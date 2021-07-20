Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02963D006B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 19:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbhGTRAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 13:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhGTRAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 13:00:37 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE86EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 10:41:15 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id t9so23202735pgn.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 10:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EaZqysZ6Sv+JlzCRlutTkWcMMV1RXVzV+oqBMjgghMg=;
        b=mWQZctZrWqEqgjZ/8xAB/FWpA7QdTCQgUhlUFRqlQqfRAt2fB/gVqfYo6Wk8WZxJz5
         6GmWOwAEfKPSOc8qCBLng7btppLLY560rBK8ryYy0cWSsm8VPofBVz1crCBjs5XLBb4h
         Gq89+JOvbRHbiFvBgLs4qZoSULtZXxPygwMQw+JBHmjolCeFA8Lndz/CPfi2jC74qMIJ
         F3/7PTZa8eK0I4ep+R/3veTKAehlDKxmOLJIbQIuQmG2EwCl1gB5YmDiZ9hW98prB5EP
         gObveFPF+a1RsxD+Nq1KTt1ZIyi2cpA+3WzbY66+0udg4vtn4ptaKBId0sHhAdPBjzCQ
         ldSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EaZqysZ6Sv+JlzCRlutTkWcMMV1RXVzV+oqBMjgghMg=;
        b=F0Oq1GM0TwUoiKKF0Ta7U2TPdRjPDVGRcTPubRtoaOA+lwijdrOXtAvmu39Zqo1oKI
         HZLXT/LT67Rh539HIvb224Su14W3qRlFwumdCR4R0+yYgEGb7xZP3/zebowR/F/fo/WY
         Wyv/pUnNDD7hKN9A/VGhDsEWqVGDVc9b1dHhh+Y6DtiCgTkr61+PJKmNJeKVPxxOnM8W
         R6jB0DslltdJ3C1UeraP2yLj2jRbC1ndQIS/TziL07AiN/LNOM6xwBt5wzGkwDomZN/x
         v54TYHEa+xcJBDGw+XgB08V5XcOn2QmJ/iR7ARHvu3rphAgVvzuhdiSVy2mXs12QGTDJ
         gn8A==
X-Gm-Message-State: AOAM533ZCx/6VOUZrl4WO5MEhEvV1zfQigwGSiOtpRdt0rSXZ72rA+hX
        2flDwd9c3/tCQkWElhbwRkRdmg==
X-Google-Smtp-Source: ABdhPJxHt8ipu9DkivDBUtk+f75sYH+VJ8ul0qe5ERRxK4wz6TS/ECnvzo/ZJ29MZ4kp3Mcm/w3FuQ==
X-Received: by 2002:aa7:81c5:0:b029:2f7:d4e3:78e9 with SMTP id c5-20020aa781c50000b02902f7d4e378e9mr33099744pfn.31.1626802875433;
        Tue, 20 Jul 2021 10:41:15 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id w186sm25146235pfw.106.2021.07.20.10.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 10:41:08 -0700 (PDT)
Date:   Tue, 20 Jul 2021 11:41:06 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 05/10] coresight: syscfg: Add API to activate and
 enable configurations
Message-ID: <20210720174106.GA2301883@p14s>
References: <20210707133003.5414-1-mike.leach@linaro.org>
 <20210707133003.5414-6-mike.leach@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707133003.5414-6-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2021 at 02:29:58PM +0100, Mike Leach wrote:
> Configurations are first activated, then when any coresight device is
> enabled, the active configurations are checked and any matching
> one is enabled.
> 
> This patch provides the activation / enable API.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  .../hwtracing/coresight/coresight-config.h    |   2 +
>  .../hwtracing/coresight/coresight-syscfg.c    | 197 ++++++++++++++++++
>  .../hwtracing/coresight/coresight-syscfg.h    |   8 +
>  include/linux/coresight.h                     |   4 +
>  4 files changed, 211 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwtracing/coresight/coresight-config.h
> index 0667581822c1..25eb6c632692 100644
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
> index b93f2b4a777e..4e9804875a9b 100644
> --- a/drivers/hwtracing/coresight/coresight-syscfg.c
> +++ b/drivers/hwtracing/coresight/coresight-syscfg.c
> @@ -282,6 +282,7 @@ static int cscfg_load_config(struct cscfg_config_desc *config_desc)
>  		return err;
>  
>  	list_add(&config_desc->item, &cscfg_mgr->config_desc_list);
> +	atomic_set(&config_desc->active_cnt, 0);
>  	return 0;
>  }
>  
> @@ -468,6 +469,201 @@ void cscfg_unregister_csdev(struct coresight_device *csdev)
>  }
>  EXPORT_SYMBOL_GPL(cscfg_unregister_csdev);
>  
> +/**
> + * cscfg_csdev_reset_feats - reset features for a CoreSight device.
> + *
> + * Resets all parameters and register values for any features loaded
> + * into @csdev to their default values.
> + *
> + * @csdev: The CoreSight device.
> + */
> +void cscfg_csdev_reset_feats(struct coresight_device *csdev)
> +{
> +	struct cscfg_feature_csdev *feat_csdev;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
> +	if (list_empty(&csdev->feature_csdev_list))
> +		goto unlock_exit;
> +
> +	list_for_each_entry(feat_csdev, &csdev->feature_csdev_list, node)
> +		cscfg_reset_feat(feat_csdev);
> +
> +unlock_exit:
> +	spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
> +}
> +EXPORT_SYMBOL_GPL(cscfg_csdev_reset_feats);
> +
> +/**
> + * cscfg_activate_config -  Mark a configuration descriptor as active.
> + *
> + * This will be seen when csdev devices are enabled in the system.
> + * Only activated configurations can be enabled on individual devices.
> + * Activation protects the configuration from alteration or removal while
> + * active.
> + *
> + * Selection by hash value - generated from the configuration name when it
> + * was loaded and added to the cs_etm/configurations file system for selection
> + * by perf.
> + *
> + * Increments the configuration descriptor active count and the global active
> + * count.
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
> +/**
> + * cscfg_deactivate_config -  Mark a config descriptor as inactive.
> + *
> + * Decrement the configuration and global active counts.
> + *
> + * @cfg_hash: Hash value of the selected configuration name.
> + */
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
> +/**
> + * cscfg_csdev_enable_active_config - Enable matching active configuration for device.
> + *
> + * Enables the configuration selected by @cfg_hash if the configuration is supported
> + * on the device and has been activated.
> + *
> + * If active and supported the CoreSight device @csdev will be programmed with the
> + * configuration, using @preset parameters.
> + *
> + * Should be called before driver hardware enable for the requested device, prior to
> + * programming and enabling the physical hardware.
> + *
> + * @csdev:	CoreSight device to program.
> + * @cfg_hash:	Selector for the configuration.
> + * @preset:	Preset parameter values to use, 0 for current / default values.
> + */
> +int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
> +				     unsigned long cfg_hash, int preset)
> +{
> +	struct cscfg_config_csdev *config_csdev_active = NULL, *config_csdev_item;
> +	const struct cscfg_config_desc *config_desc;
> +	unsigned long flags;
> +	int err = 0;
> +
> +	/* quickly check global count */
> +	if (!atomic_read(&cscfg_mgr->sys_active_cnt))
> +		return 0;
> +
> +	/* look for matching config - set in_enable flag if found */
> +	spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
> +	list_for_each_entry(config_csdev_item, &csdev->config_csdev_list, node) {
> +		config_desc = config_csdev_item->config_desc;
> +		if ((atomic_read(&config_desc->active_cnt)) &&
> +		    ((unsigned long)config_desc->event_ea->var == cfg_hash)) {
> +			config_csdev_active = config_csdev_item;
> +			csdev->cscfg_in_enable = true;
> +			break;
> +		}
> +	}
> +	spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags)

In the previous revision the mutex wasn't dropped and
cscfg_csdev_enable_config() was called with the mutex held.  Any reason for not
doing that with the spinlock implemenation?  If anything it should be more
efficient because the spinlock is on a per csdev basis.  It would also keep
things simple and avoid adding a new ->cscfg_in_enable field to the
coresight_device structure.  That last point really concerns me - if holding the
spinlock is not possible than a new approach should be considered.  

Thanks,
Mathieu

> +
> +	/*
> +	 * If found, attempt to enable and then set as enabled if no error
> +	 * and in enable flag still set.
> +	 */
> +	if (config_csdev_active) {
> +		/*
> +		 * Call the generic routine that will program up the internal
> +		 * driver structures prior to programming up the hardware.
> +		 * This routine takes the driver spinlock saved in the configs.
> +		 */
> +		err = cscfg_csdev_enable_config(config_csdev_active, preset);
> +		if (!err) {
> +			/*
> +			 * Successful programming. re-check in_enable flag
> +			 * to avoid potential race with disable config.
> +			 */
> +			spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
> +			if (csdev->cscfg_in_enable)
> +				csdev->active_cscfg_ctxt = (void *)config_csdev_active;
> +			csdev->cscfg_in_enable = false;
> +			spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
> +		}
> +	}
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(cscfg_csdev_enable_active_config);
> +
> +/**
> + * cscfg_csdev_disable_active_config - disable an active config on the device.
> + *
> + * Disables the active configuration on the CoreSight device @csdev.
> + * Disable will save the values of any registers marked in the configurations
> + * as save on disable.
> + *
> + * Should be called after driver hardware disable for the requested device,
> + * after disabling the physical hardware and reading back registers.
> + *
> + * @csdev: The CoreSight device.
> + */
> +void cscfg_csdev_disable_active_config(struct coresight_device *csdev)
> +{
> +	struct cscfg_config_csdev *config_csdev;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
> +	csdev->cscfg_in_enable = false;
> +	config_csdev = (struct cscfg_config_csdev *)csdev->active_cscfg_ctxt;
> +	csdev->active_cscfg_ctxt = NULL;
> +	spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
> +
> +	if (config_csdev)
> +		cscfg_csdev_disable_config(config_csdev);
> +}
> +EXPORT_SYMBOL_GPL(cscfg_csdev_disable_active_config);
> +
>  /* Initialise system configuration management device. */
>  
>  struct device *cscfg_device(void)
> @@ -536,6 +732,7 @@ int __init cscfg_init(void)
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
> index 16544ae2b532..e66e1a5fd803 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -223,6 +223,8 @@ struct coresight_sysfs_link {
>   * @feature_csdev_list: List of complex feature programming added to the device.
>   * @config_csdev_list:  List of system configurations added to the device.
>   * @cscfg_csdev_lock:	Protect the lists of configurations and features.
> + * @active_cscfg_ctxt:  Context information for current active system configuration.
> + * @cscfg_in_enable:    Flag to indicate we are in the process of enabling.
>   */
>  struct coresight_device {
>  	struct coresight_platform_data *pdata;
> @@ -248,6 +250,8 @@ struct coresight_device {
>  	struct list_head feature_csdev_list;
>  	struct list_head config_csdev_list;
>  	spinlock_t cscfg_csdev_lock;
> +	void *active_cscfg_ctxt;
> +	bool cscfg_in_enable;
>  };
>  
>  /*
> -- 
> 2.17.1
> 
