Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABBDA32D2B4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 13:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240490AbhCDMOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 07:14:41 -0500
Received: from foss.arm.com ([217.140.110.172]:37588 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240494AbhCDMOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 07:14:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5F1F31B;
        Thu,  4 Mar 2021 04:13:54 -0800 (PST)
Received: from [10.57.63.81] (unknown [10.57.63.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E92363F7D7;
        Thu,  4 Mar 2021 04:13:51 -0800 (PST)
Subject: Re: [PATCH v4 04/10] coresight: etm-perf: update to handle
 configuration selection
To:     Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, linux-doc@vger.kernel.org
Cc:     yabinc@google.com, corbet@lwn.net, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, tingwei@codeaurora.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
References: <20210128170936.9222-1-mike.leach@linaro.org>
 <20210128170936.9222-5-mike.leach@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <641a0d20-bf3d-24e2-8402-d99de9117584@arm.com>
Date:   Thu, 4 Mar 2021 12:13:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210128170936.9222-5-mike.leach@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/21 5:09 PM, Mike Leach wrote:
> Loaded coresight configurations are registered in the cs_etm\cs_config sub
> directory. This extends the etm-perf code to handle these registrations,
> and the cs_syscfg driver to perform the registration on load.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---
>   .../hwtracing/coresight/coresight-config.h    |   5 +-
>   .../hwtracing/coresight/coresight-etm-perf.c  | 164 +++++++++++++++---
>   .../hwtracing/coresight/coresight-etm-perf.h  |   8 +
>   .../hwtracing/coresight/coresight-syscfg.c    |  13 +-
>   4 files changed, 166 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwtracing/coresight/coresight-config.h
> index 9d66e0071f38..98380b496046 100644
> --- a/drivers/hwtracing/coresight/coresight-config.h
> +++ b/drivers/hwtracing/coresight/coresight-config.h
> @@ -154,7 +154,8 @@ struct cscfg_config_feat_ref {
>    * @nr_presets:	Number of sets of presets supplied by this configuration.
>    * @nr_total_params: Sum of all parameters declared by used features
>    * @presets:	Array of preset values.
> - *
> + * @id_ea:	Extended attribute for perf configid value
> + * @event_ea:	Extended attribute for perf event value
>    */
>   struct cscfg_config_desc {
>   	const char *name;
> @@ -165,6 +166,8 @@ struct cscfg_config_desc {
>   	int nr_presets;
>   	int nr_total_params;
>   	const u64 *presets; /* nr_presets * nr_total_params */
> +	struct dev_ext_attribute *id_ea;
> +	struct dev_ext_attribute *event_ea;
>   };
>   
>   /**
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index a608081bd446..e270bb1e0f7d 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -18,8 +18,10 @@
>   #include <linux/types.h>
>   #include <linux/workqueue.h>
>   
> +#include "coresight-config.h"
>   #include "coresight-etm-perf.h"
>   #include "coresight-priv.h"
> +#include "coresight-syscfg.h"
>   
>   static struct pmu etm_pmu;
>   static bool etm_perf_up;
> @@ -32,8 +34,13 @@ PMU_FORMAT_ATTR(cycacc,		"config:" __stringify(ETM_OPT_CYCACC));
>   PMU_FORMAT_ATTR(contextid,	"config:" __stringify(ETM_OPT_CTXTID));
>   PMU_FORMAT_ATTR(timestamp,	"config:" __stringify(ETM_OPT_TS));
>   PMU_FORMAT_ATTR(retstack,	"config:" __stringify(ETM_OPT_RETSTK));
> +/* preset - if sink ID is used as a configuration selector */
> +PMU_FORMAT_ATTR(preset,		"config:0-3");
>   /* Sink ID - same for all ETMs */
>   PMU_FORMAT_ATTR(sinkid,		"config2:0-31");
> +/* config ID - set if a system configuration is selected */
> +PMU_FORMAT_ATTR(configid,	"config2:32-63");
> +
>   
>   static struct attribute *etm_config_formats_attr[] = {
>   	&format_attr_cycacc.attr,
> @@ -41,6 +48,8 @@ static struct attribute *etm_config_formats_attr[] = {
>   	&format_attr_timestamp.attr,
>   	&format_attr_retstack.attr,
>   	&format_attr_sinkid.attr,
> +	&format_attr_preset.attr,
> +	&format_attr_configid.attr,
>   	NULL,
>   };
>   
> @@ -58,9 +67,29 @@ static const struct attribute_group etm_pmu_sinks_group = {
>   	.attrs  = etm_config_sinks_attr,
>   };
>   
> +static struct attribute *etm_config_cscfg_attr[] = {
> +	NULL,
> +};
> +
> +static const struct attribute_group etm_pmu_cscfg_group = {
> +	.name   = "configurations",
> +	.attrs  = etm_config_cscfg_attr,
> +};
> +
> +static struct attribute *etm_config_events_attr[] = {
> +	NULL,
> +};
> +
> +static const struct attribute_group etm_pmu_events_group = {
> +	.name   = "events",
> +	.attrs  = etm_config_events_attr,
> +};
> +
>   static const struct attribute_group *etm_pmu_attr_groups[] = {
>   	&etm_pmu_format_group,
>   	&etm_pmu_sinks_group,
> +	&etm_pmu_cscfg_group,
> +	&etm_pmu_events_group,
>   	NULL,
>   };
>   
> @@ -219,7 +248,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
>   	INIT_WORK(&event_data->work, free_event_data);
>   
>   	/* First get the selected sink from user space. */
> -	if (event->attr.config2) {
> +	if (event->attr.config2 & GENMASK_ULL(31, 0)) {
>   		id = (u32)event->attr.config2;
>   		sink = coresight_get_sink_by_id(id);
>   	}
> @@ -537,21 +566,17 @@ static ssize_t etm_perf_sink_name_show(struct device *dev,
>   	return scnprintf(buf, PAGE_SIZE, "0x%lx\n", (unsigned long)(ea->var));
>   }
>   
> -int etm_perf_add_symlink_sink(struct coresight_device *csdev)
> +int etm_perf_add_symlink_group(struct device *dev,
> +			       struct dev_ext_attribute **ext_attr,
> +			       const char *name,
> +			       const char *group_name)

Couple of nits:

This could be:

struct dev_ext_attribute *
etm_perf_add_to_group_hashed(struct device *dev,
			     const char *group,
			     const char *name)
{
}
						

This could return the ea on success avoiding the **ext_attr as argument.
Also the name of the function indicates what it does.


>   {
> -	int ret;
> +	struct dev_ext_attribute *ea;
>   	unsigned long hash;
> -	const char *name;
> +	int ret;
>   	struct device *pmu_dev = etm_pmu.dev;
> -	struct device *dev = &csdev->dev;
> -	struct dev_ext_attribute *ea;
>   
> -	if (csdev->type != CORESIGHT_DEV_TYPE_SINK &&
> -	    csdev->type != CORESIGHT_DEV_TYPE_LINKSINK)
> -		return -EINVAL;
> -
> -	if (csdev->ea != NULL)
> -		return -EINVAL;
> +	*ext_attr = NULL;
>   
>   	if (!etm_perf_up)
>   		return -EPROBE_DEFER;
> @@ -560,7 +585,6 @@ int etm_perf_add_symlink_sink(struct coresight_device *csdev)
>   	if (!ea)
>   		return -ENOMEM;
>   
> -	name = dev_name(dev);
>   	/* See function coresight_get_sink_by_id() to know where this is used */
>   	hash = hashlen_hash(hashlen_string(NULL, name));
>   
> @@ -574,31 +598,127 @@ int etm_perf_add_symlink_sink(struct coresight_device *csdev)
>   	ea->var = (unsigned long *)hash;
>   
>   	ret = sysfs_add_file_to_group(&pmu_dev->kobj,
> -				      &ea->attr.attr, "sinks");
> -
> +				      &ea->attr.attr, group_name);
>   	if (!ret)
> -		csdev->ea = ea;
> -
> +		*ext_attr = ea;
>   	return ret;





>   }
>   
> -void etm_perf_del_symlink_sink(struct coresight_device *csdev)
> +int etm_perf_add_symlink_sink(struct coresight_device *csdev)
> +{
> +	const char *name;
> +	struct device *dev = &csdev->dev;
> +
> +	if (csdev->type != CORESIGHT_DEV_TYPE_SINK &&
> +	    csdev->type != CORESIGHT_DEV_TYPE_LINKSINK)
> +		return -EINVAL;
> +
> +	if (csdev->ea != NULL)
> +		return -EINVAL;
> +
> +	name = dev_name(dev);
> +	return etm_perf_add_symlink_group(dev, &csdev->ea, name, "sinks");
> +}
> +
> +void etm_perf_del_symlink_group(struct dev_ext_attribute *ea, const char *group_name)

void etm_perf_del_from_group(group, ea)

>   
> +/* string to contain the attribute value */
> +#define CSCFG_EVENT_STR_SIZE	32
> +
> +static ssize_t etm_perf_cscfg_event_show(struct device *dev,
> +					 struct device_attribute *dattr,
> +					 char *buf)
> +{
> +	struct dev_ext_attribute *ea;
> +
> +	ea = container_of(dattr, struct dev_ext_attribute, attr);
> +	return scnprintf(buf, PAGE_SIZE, "%s\n", (const char *)(ea->var));
> +}

"configid=0x%lx", (unsigned long)ea->var ?

> +
> +static int etm_perf_add_cscfg_event(struct device *dev, struct cscfg_config_desc *cs_cfg)
> +{
> +	struct dev_ext_attribute *ea;
> +	unsigned long hash;
> +	int ret;
> +	struct device *pmu_dev = etm_pmu.dev;
> +
> +	ea = devm_kzalloc(dev, sizeof(*ea), GFP_KERNEL);
> +	if (!ea)
> +		return -ENOMEM;
> +
> +	hash = (unsigned long)cs_cfg->id_ea->var;
> +
> +	sysfs_attr_init(&ea->attr.attr);
> +	ea->attr.attr.name = devm_kstrdup(dev, cs_cfg->name, GFP_KERNEL);
> +	if (!ea->attr.attr.name)
> +		return -ENOMEM;
> +
> +	/*
> +	 * attribute value is "configid=<hash>".
> +	 * this will be what perf evaluates when the config name is used
> +	 * on the command line.
> +	 */
> +	ea->var = devm_kzalloc(dev, CSCFG_EVENT_STR_SIZE, GFP_KERNEL);
> +	if (!ea->var)
> +		return -ENOMEM;

Could we drop this string and use the "hash" instead ?

> +
> +	scnprintf(ea->var, CSCFG_EVENT_STR_SIZE, "configid=0x%lx", hash);
> +	ea->attr.attr.mode = 0444;
> +	ea->attr.show = etm_perf_cscfg_event_show;
> +
> +	ret = sysfs_add_file_to_group(&pmu_dev->kobj,
> +				      &ea->attr.attr, "events");
> +	if (!ret)
> +		cs_cfg->event_ea = ea;
> +	return ret;
> +}
> +
> +int etm_perf_add_symlink_cscfg(struct device *dev, struct cscfg_config_desc *cs_cfg)

etm_perf_add_cscfg() ?

> +{
> +	int err;
> +
> +	if (cs_cfg->id_ea != NULL)
> +		return 0;
> +
> +	err = etm_perf_add_symlink_group(dev, &cs_cfg->id_ea,
> +					 cs_cfg->name, "configurations");
> +
> +	if (!err)
> +		err = etm_perf_add_cscfg_event(dev, cs_cfg);
> +
> +	return err;
> +}
> +
> +void etm_perf_del_symlink_cscfg(struct cscfg_config_desc *cs_cfg)

etm_perf_del_cscfg() ?

Suzuki
