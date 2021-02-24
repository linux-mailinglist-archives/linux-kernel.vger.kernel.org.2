Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838923243D1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 19:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbhBXSeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 13:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbhBXSd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 13:33:56 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9258C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 10:33:16 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id t9so1868712pjl.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 10:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H9DYo1ZP4LUGoO0BWXB3WWeK4c2QAxTNhACjC/1JXJE=;
        b=KMr1JPRwqewRXlVfcGKRwDuqMrjjXAZayhw4Iabn4JPOwjw10QtXTAbLn1go6S+kfu
         iTDCLT0xPB3nC+M/02GJZqgtwvvf7Gg6ypHorW0vP0Z4mmObMRp0+x8YS8iiivRxHvyq
         DdLtB6baEKBIJKmtUiQACHIY6UGVahllAgM+zNi3vbKLtKYkuoaZ6fCaDnh0zTAu1fKr
         oOSauJ+7wUZkbmaraRdO5Y5gZxkEFl7EG27IziSQpcQA3tx1yh36BEB3u77J2f5YhSdI
         7RUR0tg1KVHr+x2NZiVf3hI/Iw3LD1BwQjttASDYDqVvAznoGxKmotQ9BqD0drZfmVn1
         61sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H9DYo1ZP4LUGoO0BWXB3WWeK4c2QAxTNhACjC/1JXJE=;
        b=APY3Faau4nQKD5vBgqKX4pl/DxJxc5k/PZFHhghVPhQUi+5RdPGGEZhR0c7yZ8xH28
         U7Csr5hFvMlP0OpoNZw8gOA5Yk5KUKcBQ/2e7RTeDB5odRb7w6ZpwpY1q6nc8Bx6jsUW
         ZLVqUISUhXcfeuOaxsTd0Gdv89yfUY8xSP3MSvlqYdqEVMxlYfmui35uzYEgbh//shO9
         DHoPhrdpyS4k/PrdzKB7+IJoHOwz3WNgoTuOFbMM8O6EEuUrI3uuhn0SDp1uXbBg31i6
         1W7hFzVf+XaGpttrVTBRipVVP3W0RBno0R16eYDgWrIwbyjMI709/m2tVKk/W8/8s30p
         lRNg==
X-Gm-Message-State: AOAM531e9JKIHa/a4G+4oIyYMUQq+gIgL+EsNEZbyJghMUDhuTipSuuX
        +/xG45dabComVcWY6sQvwgCK9w==
X-Google-Smtp-Source: ABdhPJzSE9qWgMRdH2j2OH9Mkf8PnpftDkxuMcPAMqhDiT3iJ3G+UNg1qnrmra5H5XyP3DTqCkOZvg==
X-Received: by 2002:a17:90a:5303:: with SMTP id x3mr5913024pjh.54.1614191596065;
        Wed, 24 Feb 2021 10:33:16 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id z137sm3758481pfc.172.2021.02.24.10.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 10:33:15 -0800 (PST)
Date:   Wed, 24 Feb 2021 11:33:13 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-doc@vger.kernel.org, suzuki.poulose@arm.com,
        gregkh@linuxfoundation.org, alexander.shishkin@linux.intel.com,
        yabinc@google.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
        tingwei@codeaurora.org, leo.yan@linaro.org
Subject: Re: [PATCH v4 04/10] coresight: etm-perf: update to handle
 configuration selection
Message-ID: <20210224183313.GC3237327@xps15>
References: <20210128170936.9222-1-mike.leach@linaro.org>
 <20210128170936.9222-5-mike.leach@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128170936.9222-5-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 05:09:30PM +0000, Mike Leach wrote:
> Loaded coresight configurations are registered in the cs_etm\cs_config sub
> directory. This extends the etm-perf code to handle these registrations,
> and the cs_syscfg driver to perform the registration on load.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---
>  .../hwtracing/coresight/coresight-config.h    |   5 +-
>  .../hwtracing/coresight/coresight-etm-perf.c  | 164 +++++++++++++++---
>  .../hwtracing/coresight/coresight-etm-perf.h  |   8 +
>  .../hwtracing/coresight/coresight-syscfg.c    |  13 +-
>  4 files changed, 166 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwtracing/coresight/coresight-config.h
> index 9d66e0071f38..98380b496046 100644
> --- a/drivers/hwtracing/coresight/coresight-config.h
> +++ b/drivers/hwtracing/coresight/coresight-config.h
> @@ -154,7 +154,8 @@ struct cscfg_config_feat_ref {
>   * @nr_presets:	Number of sets of presets supplied by this configuration.
>   * @nr_total_params: Sum of all parameters declared by used features
>   * @presets:	Array of preset values.
> - *
> + * @id_ea:	Extended attribute for perf configid value
> + * @event_ea:	Extended attribute for perf event value
>   */
>  struct cscfg_config_desc {
>  	const char *name;
> @@ -165,6 +166,8 @@ struct cscfg_config_desc {
>  	int nr_presets;
>  	int nr_total_params;
>  	const u64 *presets; /* nr_presets * nr_total_params */
> +	struct dev_ext_attribute *id_ea;
> +	struct dev_ext_attribute *event_ea;
>  };
>  
>  /**
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index a608081bd446..e270bb1e0f7d 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -18,8 +18,10 @@
>  #include <linux/types.h>
>  #include <linux/workqueue.h>
>  
> +#include "coresight-config.h"
>  #include "coresight-etm-perf.h"
>  #include "coresight-priv.h"
> +#include "coresight-syscfg.h"
>  
>  static struct pmu etm_pmu;
>  static bool etm_perf_up;
> @@ -32,8 +34,13 @@ PMU_FORMAT_ATTR(cycacc,		"config:" __stringify(ETM_OPT_CYCACC));
>  PMU_FORMAT_ATTR(contextid,	"config:" __stringify(ETM_OPT_CTXTID));
>  PMU_FORMAT_ATTR(timestamp,	"config:" __stringify(ETM_OPT_TS));
>  PMU_FORMAT_ATTR(retstack,	"config:" __stringify(ETM_OPT_RETSTK));
> +/* preset - if sink ID is used as a configuration selector */
> +PMU_FORMAT_ATTR(preset,		"config:0-3");
>  /* Sink ID - same for all ETMs */
>  PMU_FORMAT_ATTR(sinkid,		"config2:0-31");
> +/* config ID - set if a system configuration is selected */
> +PMU_FORMAT_ATTR(configid,	"config2:32-63");
> +
>  
>  static struct attribute *etm_config_formats_attr[] = {
>  	&format_attr_cycacc.attr,
> @@ -41,6 +48,8 @@ static struct attribute *etm_config_formats_attr[] = {
>  	&format_attr_timestamp.attr,
>  	&format_attr_retstack.attr,
>  	&format_attr_sinkid.attr,
> +	&format_attr_preset.attr,
> +	&format_attr_configid.attr,
>  	NULL,
>  };
>  
> @@ -58,9 +67,29 @@ static const struct attribute_group etm_pmu_sinks_group = {
>  	.attrs  = etm_config_sinks_attr,
>  };
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
>  static const struct attribute_group *etm_pmu_attr_groups[] = {
>  	&etm_pmu_format_group,
>  	&etm_pmu_sinks_group,
> +	&etm_pmu_cscfg_group,
> +	&etm_pmu_events_group,
>  	NULL,
>  };
>  
> @@ -219,7 +248,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
>  	INIT_WORK(&event_data->work, free_event_data);
>  
>  	/* First get the selected sink from user space. */
> -	if (event->attr.config2) {
> +	if (event->attr.config2 & GENMASK_ULL(31, 0)) {
>  		id = (u32)event->attr.config2;
>  		sink = coresight_get_sink_by_id(id);
>  	}
> @@ -537,21 +566,17 @@ static ssize_t etm_perf_sink_name_show(struct device *dev,

I would rename this to etm_perf_name_show() so that it doesn't look bizarre when
finding it in etm_perf_add_symlink_group().

>  	return scnprintf(buf, PAGE_SIZE, "0x%lx\n", (unsigned long)(ea->var));
>  }
>  
> -int etm_perf_add_symlink_sink(struct coresight_device *csdev)
> +int etm_perf_add_symlink_group(struct device *dev,
> +			       struct dev_ext_attribute **ext_attr,
> +			       const char *name,
> +			       const char *group_name)
>  {
> -	int ret;
> +	struct dev_ext_attribute *ea;
>  	unsigned long hash;
> -	const char *name;
> +	int ret;
>  	struct device *pmu_dev = etm_pmu.dev;
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
>  	if (!etm_perf_up)
>  		return -EPROBE_DEFER;
> @@ -560,7 +585,6 @@ int etm_perf_add_symlink_sink(struct coresight_device *csdev)
>  	if (!ea)
>  		return -ENOMEM;
>  
> -	name = dev_name(dev);
>  	/* See function coresight_get_sink_by_id() to know where this is used */

I would also update this comment.  If @name is a sink then the hash will be
used in coresight_get_sink_by_id(), and if it is a configuration it will be used
in etm_perf_add_cscfg_event() and cscfg_activate_config().

>  	hash = hashlen_hash(hashlen_string(NULL, name));
>  
> @@ -574,31 +598,127 @@ int etm_perf_add_symlink_sink(struct coresight_device *csdev)
>  	ea->var = (unsigned long *)hash;
>  
>  	ret = sysfs_add_file_to_group(&pmu_dev->kobj,
> -				      &ea->attr.attr, "sinks");
> -
> +				      &ea->attr.attr, group_name);
>  	if (!ret)
> -		csdev->ea = ea;
> -
> +		*ext_attr = ea;
>  	return ret;
>  }
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
>  {
>  	struct device *pmu_dev = etm_pmu.dev;
> -	struct dev_ext_attribute *ea = csdev->ea;
>  
> +	sysfs_remove_file_from_group(&pmu_dev->kobj,
> +				     &ea->attr.attr, group_name);
> +}
> +
> +void etm_perf_del_symlink_sink(struct coresight_device *csdev)
> +{
>  	if (csdev->type != CORESIGHT_DEV_TYPE_SINK &&
>  	    csdev->type != CORESIGHT_DEV_TYPE_LINKSINK)
>  		return;
>  
> -	if (!ea)
> +	if (!csdev->ea)
>  		return;
>  
> -	sysfs_remove_file_from_group(&pmu_dev->kobj,
> -				     &ea->attr.attr, "sinks");
> +	etm_perf_del_symlink_group(csdev->ea, "sinks");
>  	csdev->ea = NULL;
>  }
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
> +{
> +	int err;
> +
> +	if (cs_cfg->id_ea != NULL)
> +		return 0;
> +
> +	err = etm_perf_add_symlink_group(dev, &cs_cfg->id_ea,
> +					 cs_cfg->name, "configurations");

Do we need configurations to be advertised under
/sys/bus/event_source/devices/cs_etm given that they are already found in
/sys/kernel/config/coresight-syscfg?  And the events already carry the hash if
someone is really keen using the "configid=" syntax.

In my opinion we can get by with what is in configfs and do away with the
"configurations" directory here.

> +
> +	if (!err)
> +		err = etm_perf_add_cscfg_event(dev, cs_cfg);
> +

That we definitely need.

Thanks,
Mathieu

> +	return err;
> +}
> +
> +void etm_perf_del_symlink_cscfg(struct cscfg_config_desc *cs_cfg)
> +{
> +	if (!cs_cfg->id_ea)
> +		return;
> +
> +	etm_perf_del_symlink_group(cs_cfg->id_ea, "configurations");
> +	etm_perf_del_symlink_group(cs_cfg->event_ea, "events");
> +	cs_cfg->id_ea = NULL;
> +	cs_cfg->event_ea = NULL;
> +}
> +
>  int __init etm_perf_init(void)
>  {
>  	int ret;
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
> index 29d90dfeba31..3646a3837a0b 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.h
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
> @@ -11,6 +11,7 @@
>  #include "coresight-priv.h"
>  
>  struct coresight_device;
> +struct cscfg_config_desc;
>  
>  /*
>   * In both ETMv3 and v4 the maximum number of address comparator implentable
> @@ -69,6 +70,9 @@ static inline void *etm_perf_sink_config(struct perf_output_handle *handle)
>  		return data->snk_config;
>  	return NULL;
>  }
> +int etm_perf_add_symlink_cscfg(struct device *dev,
> +			       struct cscfg_config_desc *cscfg_desc);
> +void etm_perf_del_symlink_cscfg(struct cscfg_config_desc *cscfg_desc);
>  #else
>  static inline int etm_perf_symlink(struct coresight_device *csdev, bool link)
>  { return -EINVAL; }
> @@ -79,6 +83,10 @@ static inline void *etm_perf_sink_config(struct perf_output_handle *handle)
>  {
>  	return NULL;
>  }
> +int etm_perf_add_symlink_cscfg(struct device *dev,
> +			       struct cscfg_config_desc *cscfg_desc)
> +{ return -EINVAL; }
> +void etm_perf_del_symlink_cscfg(struct cscfg_config_desc *cscfg_desc) {}
>  
>  #endif /* CONFIG_CORESIGHT */
>  
> diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
> index 4b8e4e35e3e7..a070f135eca3 100644
> --- a/drivers/hwtracing/coresight/coresight-syscfg.c
> +++ b/drivers/hwtracing/coresight/coresight-syscfg.c
> @@ -7,6 +7,7 @@
>  #include <linux/platform_device.h>
>  
>  #include "coresight-config.h"
> +#include "coresight-etm-perf.h"
>  #include "coresight-syscfg.h"
>  
>  /*
> @@ -100,6 +101,7 @@ static int cscfg_add_csdev_cfg(struct coresight_device *csdev,
>  			dev_cfg->feats[dev_cfg->nr_feat++] = feat;
>  		}
>  	}
> +
>  	/* if matched features, add config to device.*/
>  	if (dev_cfg) {
>  		mutex_lock(&cscfg_csdev_mutex);
> @@ -290,8 +292,12 @@ static int cscfg_load_config(struct cscfg_config_desc *cfg_desc)
>  	if (err)
>  		return err;
>  
> -	list_add(&cfg_desc->item, &cscfg_mgr->data.config_desc_list);
> +	/* add config to perf fs to allow selection */
> +	err = etm_perf_add_symlink_cscfg(to_device_cscfg(), cfg_desc);
> +	if (err)
> +		return err;
>  
> +	list_add(&cfg_desc->item, &cscfg_mgr->data.config_desc_list);
>  	return 0;
>  }
>  
> @@ -517,7 +523,12 @@ int cscfg_create_device(void)
>  
>  void cscfg_clear_device(void)
>  {
> +	struct cscfg_config_desc *cfg_desc;
> +
>  	mutex_lock(&cscfg_mutex);
> +	list_for_each_entry(cfg_desc, &cscfg_mgr->data.config_desc_list, item) {
> +		etm_perf_del_symlink_cscfg(cfg_desc);
> +	}
>  	device_unregister(to_device_cscfg());
>  	mutex_unlock(&cscfg_mutex);
>  }
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
