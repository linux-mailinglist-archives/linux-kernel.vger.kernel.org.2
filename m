Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072DB351922
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 19:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237393AbhDARvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 13:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234830AbhDARkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:40:36 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00525C031146
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 09:43:16 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id a22-20020a17090aa516b02900c1215e9b33so3369572pjq.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 09:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9kXrOvZONIFORzF1gr1KYSrBPGnVSir3zJQM6INvU0c=;
        b=UYTI2Z+XERu2McjjUV04jXIH/tJEVfD74dnF479gOXCxIwNj89UzCQfJANLtUcSMCo
         ZfVtPNhQGVPNLtH1nHjnkfyVjL3Vr6yUtivC7fqVxbmgas5Xqr5uZyUX1SR099gSnUBL
         186fg3T8c1jJwHEcwtzwkFjYTZRfcu4WZ+fg+yZqTqxMTX+Zp9KFJ5yWxeA2JB3Xa/8s
         Z+Bj3/sfrmlT7mKQN7b0qD7Ec+hBdi0GuKr5+z4IiqQLk9J+V6tKeEHxzElp0hjBBg/i
         4WjOOi+LW9oLjIt7Ck5/pEcg0Mg9/nLjULJUrvqWwN/Lu8lZVFJ34pDJefqfiRj0Plr/
         f9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9kXrOvZONIFORzF1gr1KYSrBPGnVSir3zJQM6INvU0c=;
        b=Qim/kRpiNxMgpAc8+WysfZbRZsvjDOH/bosAS2iiE0B9RAxUh0kGirW+qNKRwH8bkf
         EkLMB6v7y9vwmx3T+MxOqc/Ltc1yJ7eH3l7dnxti86cdBZgSUUMH4z3dwkL7TVFUv/Gj
         prYaVParklvwbItWbBDpENmDrGO6MxnimDMa4oLmNGf59wP++Z6UQVsOwC4cMKZPHYnS
         e32KLW100HNAwLagp/scVz6hlMwxAb6eYbPnijaoCAiIDxR0zV6qN3FgaBYKUq1Odn/2
         CRIG/y37XaADnSS9cyOvdHbCEViUtbEmh1mFV0PBsfbR6fsFdofVGchhUl10kVX9s/VE
         pw9A==
X-Gm-Message-State: AOAM531DrCVLVifBqlmS4ntp15u/38hfM8pyCK1SBpYWEV7ORrXdekME
        la6DX2SX6b2YkDdAJD10DBH1Mw==
X-Google-Smtp-Source: ABdhPJzlWF9LMWoYEoTpbDoszDeb2D+rJZVO0dKqePivBWRYnod6rpVFi8kvTiB4De7ZF6XMuAsrEw==
X-Received: by 2002:a17:90a:f403:: with SMTP id ch3mr9741454pjb.126.1617295396385;
        Thu, 01 Apr 2021 09:43:16 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id 205sm6204905pfc.201.2021.04.01.09.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 09:43:15 -0700 (PDT)
Date:   Thu, 1 Apr 2021 10:43:13 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-doc@vger.kernel.org, suzuki.poulose@arm.com,
        yabinc@google.com, corbet@lwn.net, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, tingwei@codeaurora.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 05/10] coresight: syscfg: Add API to activate and
 enable configurations
Message-ID: <20210401164313.GA145043@xps15>
References: <20210316180400.7184-1-mike.leach@linaro.org>
 <20210316180400.7184-6-mike.leach@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316180400.7184-6-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 06:03:55PM +0000, Mike Leach wrote:
> Configurations are first activated, then when any coresight device is
> enabled, the active configurations are checked and any matching
> one is enabled.
> 
> This patch provides the activation / enable API.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---
>  .../hwtracing/coresight/coresight-config.h    |   2 +
>  .../hwtracing/coresight/coresight-syscfg.c    | 122 ++++++++++++++++++
>  .../hwtracing/coresight/coresight-syscfg.h    |   8 ++
>  include/linux/coresight.h                     |   2 +
>  4 files changed, 134 insertions(+)
>

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
 
> diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwtracing/coresight/coresight-config.h
> index 38fd1c71eb05..f1a5957a25c9 100644
> --- a/drivers/hwtracing/coresight/coresight-config.h
> +++ b/drivers/hwtracing/coresight/coresight-config.h
> @@ -127,6 +127,7 @@ struct cscfg_feature_desc {
>   * @nr_total_params:	Sum of all parameters declared by used features
>   * @presets:		Array of preset values.
>   * @event_ea:		Extended attribute for perf event value
> + * @active_cnt:		ref count for activate on this configuration.
>   *
>   */
>  struct cscfg_config_desc {
> @@ -139,6 +140,7 @@ struct cscfg_config_desc {
>  	int nr_total_params;
>  	const u64 *presets; /* nr_presets * nr_total_params */
>  	struct dev_ext_attribute *event_ea;
> +	atomic_t active_cnt;
>  };
>  
>  /**
> diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
> index 03014a2142c1..c44746d6cd6d 100644
> --- a/drivers/hwtracing/coresight/coresight-syscfg.c
> +++ b/drivers/hwtracing/coresight/coresight-syscfg.c
> @@ -284,6 +284,7 @@ static int cscfg_load_config(struct cscfg_config_desc *config_desc)
>  		return err;
>  
>  	list_add(&config_desc->item, &cscfg_mgr->config_desc_list);
> +	atomic_set(&config_desc->active_cnt, 0);
>  	return 0;
>  }
>  
> @@ -451,6 +452,126 @@ void cscfg_unregister_csdev(struct coresight_device *csdev)
>  }
>  EXPORT_SYMBOL_GPL(cscfg_unregister_csdev);
>  
> +void cscfg_csdev_reset_feats(struct coresight_device *csdev)
> +{
> +	struct cscfg_feature_csdev *feat_csdev;
> +
> +	mutex_lock(&cscfg_csdev_mutex);
> +	if (list_empty(&csdev->feature_csdev_list))
> +		goto unlock_exit;
> +
> +	list_for_each_entry(feat_csdev, &csdev->feature_csdev_list, node)
> +		cscfg_reset_feat(feat_csdev);
> +
> +unlock_exit:
> +	mutex_unlock(&cscfg_csdev_mutex);
> +}
> +EXPORT_SYMBOL_GPL(cscfg_csdev_reset_feats);
> +
> +/**
> + * Mark a config descriptor as active.
> + * This will be seen when csdev devices are activated in the system.
> + *
> + * Selection by hash value - generated from the configuration name when it
> + * was loaded and added to the cs_etm/configurations file system for selection
> + * by perf.
> + *
> + * @cfg_hash: Hash value of the selected configuration name.
> + */
> +int cscfg_activate_config(unsigned long cfg_hash)
> +{
> +	struct cscfg_config_desc *config_desc;
> +	int err = -EINVAL;
> +
> +	mutex_lock(&cscfg_mutex);
> +
> +	list_for_each_entry(config_desc, &cscfg_mgr->config_desc_list, item) {
> +		if ((unsigned long)config_desc->event_ea->var == cfg_hash) {
> +			/*
> +			 * increment the global active count - control changes to
> +			 * active configurations
> +			 */
> +			atomic_inc(&cscfg_mgr->sys_active_cnt);
> +
> +			/*
> +			 * mark the descriptor as active so enable config on a
> +			 * device instance will use it
> +			 */
> +			atomic_inc(&config_desc->active_cnt);
> +
> +			err = 0;
> +			dev_dbg(cscfg_device(), "Activate config %s.\n", config_desc->name);
> +			break;
> +		}
> +	}
> +	mutex_unlock(&cscfg_mutex);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(cscfg_activate_config);
> +
> +void cscfg_deactivate_config(unsigned long cfg_hash)
> +{
> +	struct cscfg_config_desc *config_desc;
> +
> +	mutex_lock(&cscfg_mutex);
> +
> +	list_for_each_entry(config_desc, &cscfg_mgr->config_desc_list, item) {
> +		if ((unsigned long)config_desc->event_ea->var == cfg_hash) {
> +			atomic_dec(&config_desc->active_cnt);
> +			atomic_dec(&cscfg_mgr->sys_active_cnt);
> +			dev_dbg(cscfg_device(), "Deactivate config %s.\n", config_desc->name);
> +			break;
> +		}
> +	}
> +	mutex_unlock(&cscfg_mutex);
> +}
> +EXPORT_SYMBOL_GPL(cscfg_deactivate_config);
> +
> +/* Find and program any active config for the supplied device.*/
> +int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
> +				     unsigned long cfg_hash, int preset)
> +{
> +	struct cscfg_config_csdev *config_csdev_active = NULL, *config_csdev_item;
> +	const struct cscfg_config_desc *config_desc;
> +	int err = 0;
> +
> +	/* quickly check global count */
> +	if (!atomic_read(&cscfg_mgr->sys_active_cnt))
> +		return 0;
> +
> +	mutex_lock(&cscfg_csdev_mutex);
> +	list_for_each_entry(config_csdev_item, &csdev->config_csdev_list, node) {
> +		config_desc = config_csdev_item->config_desc;
> +		if ((atomic_read(&config_desc->active_cnt)) &&
> +		    ((unsigned long)config_desc->event_ea->var == cfg_hash)) {
> +			config_csdev_active = config_csdev_item;
> +			break;
> +		}
> +	}
> +	if (config_csdev_active) {
> +		err = cscfg_csdev_enable_config(config_csdev_active, preset);
> +		if (!err)
> +			csdev->active_cscfg_ctxt = (void *)config_csdev_active;
> +	}
> +	mutex_unlock(&cscfg_csdev_mutex);
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(cscfg_csdev_enable_active_config);
> +
> +/* save and disable the active config for the device */
> +void cscfg_csdev_disable_active_config(struct coresight_device *csdev)
> +{
> +	struct cscfg_config_csdev *config_csdev;
> +
> +	mutex_lock(&cscfg_csdev_mutex);
> +	config_csdev = (struct cscfg_config_csdev *)csdev->active_cscfg_ctxt;
> +	if (config_csdev)
> +		cscfg_csdev_disable_config(config_csdev);
> +	mutex_unlock(&cscfg_csdev_mutex);
> +}
> +EXPORT_SYMBOL_GPL(cscfg_csdev_disable_active_config);
> +
>  /* Initialise system configuration management device. */
>  
>  struct device *cscfg_device(void)
> @@ -519,6 +640,7 @@ int __init cscfg_init(void)
>  	INIT_LIST_HEAD(&cscfg_mgr->csdev_desc_list);
>  	INIT_LIST_HEAD(&cscfg_mgr->feat_desc_list);
>  	INIT_LIST_HEAD(&cscfg_mgr->config_desc_list);
> +	atomic_set(&cscfg_mgr->sys_active_cnt, 0);
>  
>  	dev_info(cscfg_device(), "CoreSight Configuration manager initialised");
>  	return 0;
> diff --git a/drivers/hwtracing/coresight/coresight-syscfg.h b/drivers/hwtracing/coresight/coresight-syscfg.h
> index 5bcae3b374c6..a52775890670 100644
> --- a/drivers/hwtracing/coresight/coresight-syscfg.h
> +++ b/drivers/hwtracing/coresight/coresight-syscfg.h
> @@ -24,12 +24,14 @@
>   * @csdev_desc_list:	List of coresight devices registered with the configuration manager.
>   * @feat_desc_list:	List of feature descriptors to load into registered devices.
>   * @config_desc_list:	List of system configuration descriptors to load into registered devices.
> + * @sys_active_cnt:	Total number of active config descriptor references.
>   */
>  struct cscfg_manager {
>  	struct device dev;
>  	struct list_head csdev_desc_list;
>  	struct list_head feat_desc_list;
>  	struct list_head config_desc_list;
> +	atomic_t sys_active_cnt;
>  };
>  
>  /* get reference to dev in cscfg_manager */
> @@ -61,5 +63,11 @@ int cscfg_load_config_sets(struct cscfg_config_desc **cfg_descs,
>  int cscfg_register_csdev(struct coresight_device *csdev, u32 match_flags,
>  			 struct cscfg_csdev_feat_ops *ops);
>  void cscfg_unregister_csdev(struct coresight_device *csdev);
> +int cscfg_activate_config(unsigned long cfg_hash);
> +void cscfg_deactivate_config(unsigned long cfg_hash);
> +void cscfg_csdev_reset_feats(struct coresight_device *csdev);
> +int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
> +				     unsigned long cfg_hash, int preset);
> +void cscfg_csdev_disable_active_config(struct coresight_device *csdev);
>  
>  #endif /* CORESIGHT_SYSCFG_H */
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index d0126ed326a6..a3b39ce2d6ef 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -221,6 +221,7 @@ struct coresight_sysfs_link {
>   * @has_conns_grp: Have added a "connections" group for sysfs links.
>   * @feature_csdev_list: List of complex feature programming added to the device.
>   * @config_csdev_list:  List of system configurations added to the device.
> + * @active_cscfg_ctxt:  Context information for current active system configuration.
>   */
>  struct coresight_device {
>  	struct coresight_platform_data *pdata;
> @@ -245,6 +246,7 @@ struct coresight_device {
>  	/* system configuration and feature lists */
>  	struct list_head feature_csdev_list;
>  	struct list_head config_csdev_list;
> +	void *active_cscfg_ctxt;
>  };
>  
>  /*
> -- 
> 2.17.1
> 
