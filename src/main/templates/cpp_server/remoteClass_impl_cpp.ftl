${remoteClass.name}Impl.cpp
#include <gst/gst.h>
<#list remoteClassDependencies(remoteClass) as dependency>
<#if model.remoteClasses?seq_contains(dependency)>
#include "${dependency.name}Impl.hpp"
<#else>
#include "${dependency.name}.hpp"
</#if>
</#list>
#include "${remoteClass.name}Impl.hpp"
#include <jsonrpc/JsonSerializer.hpp>
#include <KurentoException.hpp>

namespace kurento
{

<#if remoteClass.constructor??>
${remoteClass.name}Impl::${remoteClass.name}Impl (<#rt>
     <#lt><#list remoteClass.constructor.params as param><#rt>
        <#lt>${getCppObjectType(param.type, true)}${param.name}<#rt>
        <#lt><#if param_has_next>, </#if><#rt>
     <#lt></#list>)
<#else>
${remoteClass.name}Impl::${remoteClass.name}Impl ()
</#if>
{
  // FIXME: Implement this
}
<#macro methodStub method>

${getCppObjectType(method.return,false)} ${remoteClass.name}Impl::${method.name} (<#rt>
    <#lt><#list method.params as param>${getCppObjectType(param.type)}${param.name}<#if param_has_next>, </#if></#list>)
{
  // FIXME: Implement this
  throw KurentoException (NOT_IMPLEMENTED, "${remoteClass.name}Impl::${method.name}: Not implemented");
}
</#macro>
<#list remoteClass.methods as method><#rt>
  <#list method.expandIfOpsParams() as expandedMethod ><#rt>
    <#lt><@methodStub expandedMethod />
  </#list>
  <#lt><@methodStub method />
</#list>

<#if remoteClass.constructor??><#rt>
MediaObjectImpl *
${remoteClass.name}Impl::Factory::createObject (<#rt>
     <#lt><#list remoteClass.constructor.params as param><#rt>
        <#lt>${getCppObjectType(param.type, true)}${param.name}<#rt>
        <#lt><#if param_has_next>, </#if><#rt>
     <#lt></#list>) const
{
  return new ${remoteClass.name}Impl (<#rt>
     <#lt><#list remoteClass.constructor.params as param><#rt>
        <#lt>${param.name}<#rt>
        <#lt><#if param_has_next>, </#if><#rt>
     <#lt></#list>);
}

</#if>
} /* kurento */
