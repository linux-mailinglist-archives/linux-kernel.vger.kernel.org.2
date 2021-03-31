Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5603350880
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 22:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbhCaUta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 16:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhCaUtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 16:49:06 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2721BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 13:49:06 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso1828492pji.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 13:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pkMtHP/FP6HVnlsSflpSTcfcnPygeWH1oDrLgLsDFpo=;
        b=Dts3mkICYPf7LBKZROiT+D61GZbBCrLhFMaQPiyBBG5vdsx2aRLNCYqMwdDQqWFLG3
         HTGijh4JWyhKdMB7XvnZECdofQdsG+8lYmxDnuTXXwK87uzKkrHULTNXPxy/NQMlTa2/
         JZA2EfajUESlU6oDx1+EqtHOlc9eTr7MMU4DUhMy2diDRzDAnvE/gSe1WXyrxt/zWv5H
         5Ygvs1XgecnNoW+bkb84QnDLD05TSqv/hcFMPIPV7Xvv5cK/xL8JYBFdorVVrnbxO7Pe
         qX/VwBdBMabSpVPUY/FfgAtMVSvhu0dRKg/V9JHYUXZBHF7mYAfoOU9wIPZbqFEwxbZn
         ezBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pkMtHP/FP6HVnlsSflpSTcfcnPygeWH1oDrLgLsDFpo=;
        b=VRymicmD8YZ4R8LDjEaFmCFIv7jBjGQZPECvZCsmIweJTUfUYFVH+Mxm5QUTglgRxh
         OmKkfx2rqhUwp+up4bF++urE7Go4oy2+tkzRuqFc9Nr4RBcaKsLCFV06SBnCDfhT1mTU
         ZeP16+lLNLq1M6xWjr2u5XA4aqpAzO43ulcGprWlkomTg0fxX1g3XMIbwp4muRe15+c8
         t3v1y5VTOg/P7vkOm0OoKh/pxoyUIL07hLvIaAbzu6r6XZdCiZeyNe54kFkO1x5jB3dN
         eAcGTuOdRTw2Xwhd1KNUtAj1NbRPjPOmEoOtaBWhiXjBu1F4KNzSFWCK1EQ/RxR54RTP
         ox3Q==
X-Gm-Message-State: AOAM532y9L8C1WKLi14ABbaNa+wQuak2WoyMf7+rWJ2FeyBlrjAjn+rR
        Fig4MmlVYgwYkiBRaUjZ6h8NLg==
X-Google-Smtp-Source: ABdhPJz0G/JLW27sEDRxw/GaBjWLJPT58MbGHSWlArXPikku+blmltOrqTkMtyV76Ssl+B1fmvYYqA==
X-Received: by 2002:a17:90b:2304:: with SMTP id mt4mr5447321pjb.179.1617223745531;
        Wed, 31 Mar 2021 13:49:05 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id d14sm3069347pji.22.2021.03.31.13.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 13:49:01 -0700 (PDT)
Date:   Wed, 31 Mar 2021 14:48:59 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-doc@vger.kernel.org, suzuki.poulose@arm.com,
        yabinc@google.com, corbet@lwn.net, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, tingwei@codeaurora.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 04/10] coresight: etm-perf: update to handle
 configuration selection
Message-ID: <20210331204859.GA51243@xps15>
References: <20210316180400.7184-1-mike.leach@linaro.org>
 <20210316180400.7184-5-mike.leach@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316180400.7184-5-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 06:03:54PM +0000, Mike Leach wrote:
> Loaded coresight configurations are registered in the cs_etm\cs_config sub

This changelog is obsolete - cs_config is no longer under cs_etm.

> directory. This extends the etm-perf code to handle these registrations,
> and the cs_syscfg driver to perform the registration on load.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---
>  .../hwtracing/coresight/coresight-config.h    |   2 +
>  .../hwtracing/coresight/coresight-etm-perf.c  | 139 ++++++++++++++----
>  .../hwtracing/coresight/coresight-etm-perf.h  |   8 +
>  .../hwtracing/coresight/coresight-syscfg.c    |  12 ++
>  4 files changed, 130 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwtracing/coresight/coresight-config.h
> index f70561c1504b..38fd1c71eb05 100644
> --- a/drivers/hwtracing/coresight/coresight-config.h
> +++ b/drivers/hwtracing/coresight/coresight-config.h
> @@ -126,6 +126,7 @@ struct cscfg_feature_desc {
>   * @nr_presets:		Number of sets of presets supplied by this configuration.
>   * @nr_total_params:	Sum of all parameters declared by used features
>   * @presets:		Array of preset values.
> + * @event_ea:		Extended attribute for perf event value
>   *
>   */
>  struct cscfg_config_desc {
> @@ -137,6 +138,7 @@ struct cscfg_config_desc {
>  	int nr_presets;
>  	int nr_total_params;
>  	const u64 *presets; /* nr_presets * nr_total_params */
> +	struct dev_ext_attribute *event_ea;
>  };
>  
>  /**
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index 0e392513b2d6..66bda452a2f4 100644
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
> @@ -38,8 +40,13 @@ PMU_FORMAT_ATTR(contextid1,	"config:" __stringify(ETM_OPT_CTXTID));
>  PMU_FORMAT_ATTR(contextid2,	"config:" __stringify(ETM_OPT_CTXTID2));
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
>  /*
>   * contextid always traces the "PID".  The PID is in CONTEXTIDR_EL1
> @@ -69,6 +76,8 @@ static struct attribute *etm_config_formats_attr[] = {
>  	&format_attr_timestamp.attr,
>  	&format_attr_retstack.attr,
>  	&format_attr_sinkid.attr,
> +	&format_attr_preset.attr,
> +	&format_attr_configid.attr,
>  	NULL,
>  };
>  
> @@ -86,9 +95,19 @@ static const struct attribute_group etm_pmu_sinks_group = {
>  	.attrs  = etm_config_sinks_attr,
>  };
>  
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
> +	&etm_pmu_events_group,
>  	NULL,
>  };
>  
> @@ -247,7 +266,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
>  	INIT_WORK(&event_data->work, free_event_data);
>  
>  	/* First get the selected sink from user space. */
> -	if (event->attr.config2) {
> +	if (event->attr.config2 & GENMASK_ULL(31, 0)) {
>  		id = (u32)event->attr.config2;
>  		sink = coresight_get_sink_by_id(id);
>  	}
> @@ -555,9 +574,9 @@ int etm_perf_symlink(struct coresight_device *csdev, bool link)
>  }
>  EXPORT_SYMBOL_GPL(etm_perf_symlink);
>  
> -static ssize_t etm_perf_sink_name_show(struct device *dev,
> -				       struct device_attribute *dattr,
> -				       char *buf)

Because we now have etm_perf_cscfg_event_show(), this could have remained
unchanged. 

> +static ssize_t etm_perf_name_show(struct device *dev,
> +				  struct device_attribute *dattr,
> +				  char *buf)
>  {
>  	struct dev_ext_attribute *ea;
>  
> @@ -565,68 +584,126 @@ static ssize_t etm_perf_sink_name_show(struct device *dev,
>  	return scnprintf(buf, PAGE_SIZE, "0x%lx\n", (unsigned long)(ea->var));
>  }
>  
> -int etm_perf_add_symlink_sink(struct coresight_device *csdev)
> +static struct dev_ext_attribute *
> +etm_perf_add_symlink_group(struct device *dev, const char *name, const char *group_name)
>  {
> -	int ret;
> +	struct dev_ext_attribute *ea;
>  	unsigned long hash;
> -	const char *name;
> +	int ret;
>  	struct device *pmu_dev = etm_pmu.dev;
> -	struct device *dev = &csdev->dev;
> -	struct dev_ext_attribute *ea;
> -
> -	if (csdev->type != CORESIGHT_DEV_TYPE_SINK &&
> -	    csdev->type != CORESIGHT_DEV_TYPE_LINKSINK)
> -		return -EINVAL;
> -
> -	if (csdev->ea != NULL)
> -		return -EINVAL;
>  
>  	if (!etm_perf_up)
> -		return -EPROBE_DEFER;
> +		return ERR_PTR(-EPROBE_DEFER);
>  
>  	ea = devm_kzalloc(dev, sizeof(*ea), GFP_KERNEL);
>  	if (!ea)
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
>  
> -	name = dev_name(dev);
> -	/* See function coresight_get_sink_by_id() to know where this is used */
> +	/*
> +	 * If this function is called adding a sink then the hash is used for
> +	 * sink selection - see function coresight_get_sink_by_id().
> +	 * If adding a configuration then the hash is used for selection in
> +	 * cscfg_activate_config()
> +	 */
>  	hash = hashlen_hash(hashlen_string(NULL, name));
>  
>  	sysfs_attr_init(&ea->attr.attr);
>  	ea->attr.attr.name = devm_kstrdup(dev, name, GFP_KERNEL);
>  	if (!ea->attr.attr.name)
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
>  
>  	ea->attr.attr.mode = 0444;
> -	ea->attr.show = etm_perf_sink_name_show;
> +	ea->attr.show = etm_perf_name_show;

I would have removed the assignment entirely from this function and moved it to
etm_perf_add_symlink_cscfg() (like you already did) and
etm_perf_add_symlink_link(). 

>  	ea->var = (unsigned long *)hash;
>  
>  	ret = sysfs_add_file_to_group(&pmu_dev->kobj,
> -				      &ea->attr.attr, "sinks");
> +				      &ea->attr.attr, group_name);
>  
> -	if (!ret)
> -		csdev->ea = ea;
> +	return ret ? ERR_PTR(ret) : ea;
> +}
>  
> -	return ret;
> +int etm_perf_add_symlink_sink(struct coresight_device *csdev)
> +{
> +	const char *name;
> +	struct device *dev = &csdev->dev;
> +	int err = 0;
> +
> +	if (csdev->type != CORESIGHT_DEV_TYPE_SINK &&
> +	    csdev->type != CORESIGHT_DEV_TYPE_LINKSINK)
> +		return -EINVAL;
> +
> +	if (csdev->ea != NULL)
> +		return -EINVAL;
> +
> +	name = dev_name(dev);
> +	csdev->ea = etm_perf_add_symlink_group(dev, name, "sinks");
> +	if (IS_ERR(csdev->ea)) {
> +		err = PTR_ERR(csdev->ea);
> +		csdev->ea = NULL;
> +	}
> +	return err;
>  }
>  
> -void etm_perf_del_symlink_sink(struct coresight_device *csdev)
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
> +static ssize_t etm_perf_cscfg_event_show(struct device *dev,
> +					 struct device_attribute *dattr,
> +					 char *buf)
> +{
> +	struct dev_ext_attribute *ea;
> +
> +	ea = container_of(dattr, struct dev_ext_attribute, attr);
> +	return scnprintf(buf, PAGE_SIZE, "configid=0x%lx\n", (unsigned long)(ea->var));
> +}
> +
> +int etm_perf_add_symlink_cscfg(struct device *dev, struct cscfg_config_desc *config_desc)
> +{
> +	int err = 0;
> +
> +	if (config_desc->event_ea != NULL)
> +		return 0;
> +
> +	config_desc->event_ea = etm_perf_add_symlink_group(dev, config_desc->name, "events");
> +
> +	/* override the show function to the custom cscfg event */
> +	if (!IS_ERR(config_desc->event_ea))
> +		config_desc->event_ea->attr.show = etm_perf_cscfg_event_show;
> +	else {
> +		err = PTR_ERR(config_desc->event_ea);
> +		config_desc->event_ea = NULL;
> +	}
> +
> +	return err;
> +}
> +
> +void etm_perf_del_symlink_cscfg(struct cscfg_config_desc *config_desc)
> +{
> +	if (!config_desc->event_ea)
> +		return;
> +
> +	etm_perf_del_symlink_group(config_desc->event_ea, "events");
> +	config_desc->event_ea = NULL;
> +}
> +
>  int __init etm_perf_init(void)
>  {
>  	int ret;
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
> index 29d90dfeba31..ba617fe2217e 100644
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
> +			       struct cscfg_config_desc *config_desc);
> +void etm_perf_del_symlink_cscfg(struct cscfg_config_desc *config_desc);
>  #else
>  static inline int etm_perf_symlink(struct coresight_device *csdev, bool link)
>  { return -EINVAL; }
> @@ -79,6 +83,10 @@ static inline void *etm_perf_sink_config(struct perf_output_handle *handle)
>  {
>  	return NULL;
>  }
> +int etm_perf_add_symlink_cscfg(struct device *dev,
> +			       struct cscfg_config_desc *config_desc)
> +{ return -EINVAL; }
> +void etm_perf_del_symlink_cscfg(struct cscfg_config_desc *config_desc) {}
>  
>  #endif /* CONFIG_CORESIGHT */
>  
> diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
> index 11d1422f0ed3..03014a2142c1 100644
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
> @@ -86,6 +87,7 @@ static int cscfg_add_csdev_cfg(struct coresight_device *csdev,
>  			config_csdev->feats_csdev[config_csdev->nr_feat++] = feat_csdev;
>  		}
>  	}
> +

Spurious newline.

If you end up respinning:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Otherwise I have fixed it on my side.

Thanks,
Mathieu

>  	/* if matched features, add config to device.*/
>  	if (config_csdev) {
>  		mutex_lock(&cscfg_csdev_mutex);
> @@ -276,6 +278,11 @@ static int cscfg_load_config(struct cscfg_config_desc *config_desc)
>  	if (err)
>  		return err;
>  
> +	/* add config to perf fs to allow selection */
> +	err = etm_perf_add_symlink_cscfg(cscfg_device(), config_desc);
> +	if (err)
> +		return err;
> +
>  	list_add(&config_desc->item, &cscfg_mgr->config_desc_list);
>  	return 0;
>  }
> @@ -490,7 +497,12 @@ int cscfg_create_device(void)
>  
>  void cscfg_clear_device(void)
>  {
> +	struct cscfg_config_desc *cfg_desc;
> +
>  	mutex_lock(&cscfg_mutex);
> +	list_for_each_entry(cfg_desc, &cscfg_mgr->config_desc_list, item) {
> +		etm_perf_del_symlink_cscfg(cfg_desc);
> +	}
>  	device_unregister(cscfg_device());
>  	mutex_unlock(&cscfg_mutex);
>  }
> -- 
> 2.17.1
> 
