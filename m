Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD92A34D9A9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 23:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbhC2Vfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 17:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbhC2VfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 17:35:16 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6EFC061762
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 14:35:16 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id h3so10700586pfr.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 14:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lK/RWY/iLF2JT7Qhk2hVXCj/P8cDEnwnhh1wj+2kBQg=;
        b=otKHU4neS88V9y2ag7cknSxalZl7oPepO2aRaS0LPc42dABs0PDHiEZqQtvmmN2x0F
         ebKfOsYrkLBjVPsKm8Qx7BqoAu26RxzLFf5c+rbMwxo8zkgMvJGQXvMaI97Kjn7+JyJ7
         wxTtXa8CEvUQeJ/Go9n+PkmUrUvFuFU6ByvaTLXIj4+PxWinGqWu1JuEiB69Oetauibq
         qNslOncFCQs3fWXZ/zBpIU8+L7WNvGzkgda6+E8cO9BQRVLef09+GGelrTLir9P77Sm7
         ntjMOKunuQvg0mHt3Ydd3Y+mxNahUoCyJE+DxJzeEpp8RrR8oYTTJOcIbpRVtKJudXRH
         eicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lK/RWY/iLF2JT7Qhk2hVXCj/P8cDEnwnhh1wj+2kBQg=;
        b=V4SRS2442pPuS/qxNw51Ob51e6yJMh6BkLz2dPmAYjh0U/th0jjT5/EEXY7905VtFf
         MFZEVxYWD6yO1awoXWRAHDF0rd0AlC77Yei2QsHWLfR0uVL9a3GTj+z2VZlWYzEQFPoQ
         Ox7rj5W8NO2PX30ThacY+vZAxqOmOHeATcng+/4WC4nN9MJI7hE9utgIzfa5C/atrVGP
         vKRMMdy0kB+oQ5i/OskcZxY0/md7EbaHiINuU4McWOH1gFxD19o6ui274jBJSNmY4fDQ
         ikUvNSSfovSl8+TArYLvHba9llqwbB97HziuRu3k5pgZpJy8AMqa2OlR9sNIVUbTeA0W
         iMfQ==
X-Gm-Message-State: AOAM531FWS4BOvdAHjBcsHlXs4ZYL9XlTXn1as9rGpDOnQ8a7BaGi5DH
        xe4IAwMS4+HGq2Rj7qtnBO2JOPix8upzwA==
X-Google-Smtp-Source: ABdhPJzCViSc9zapBx6404Gr9VXqh1FVIrGpn/R8lltFDvfjk8Mxe3Qjgleq0QwtEItQKTq74vpJ1A==
X-Received: by 2002:a65:4006:: with SMTP id f6mr4529279pgp.108.1617053715476;
        Mon, 29 Mar 2021 14:35:15 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id q205sm18486417pfc.126.2021.03.29.14.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 14:35:14 -0700 (PDT)
Date:   Mon, 29 Mar 2021 15:35:12 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-doc@vger.kernel.org, suzuki.poulose@arm.com,
        yabinc@google.com, corbet@lwn.net, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, tingwei@codeaurora.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 02/10] coresight: syscfg: Add registration and feature
 loading for cs devices
Message-ID: <20210329213512.GE2236953@xps15>
References: <20210316180400.7184-1-mike.leach@linaro.org>
 <20210316180400.7184-3-mike.leach@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316180400.7184-3-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 06:03:52PM +0000, Mike Leach wrote:
> API for individual devices to register with the syscfg management
> system is added.
> 
> Devices register with matching information, and any features or
> configurations that match will be loaded into the device.
> 
> The feature and configuration loading is extended so that on load these
> are loaded into any currently registered devices. This allows
> configuration loading after devices have been registered.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---
>  .../hwtracing/coresight/coresight-config.h    |  98 ++++++
>  .../hwtracing/coresight/coresight-syscfg.c    | 324 +++++++++++++++++-
>  .../hwtracing/coresight/coresight-syscfg.h    |  19 +
>  include/linux/coresight.h                     |   5 +
>  4 files changed, 445 insertions(+), 1 deletion(-)

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> 
> diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwtracing/coresight/coresight-config.h
> index 21aa7464dcdc..685fb46ce893 100644
> --- a/drivers/hwtracing/coresight/coresight-config.h
> +++ b/drivers/hwtracing/coresight/coresight-config.h
> @@ -139,4 +139,102 @@ struct cscfg_config_desc {
>  	const u64 *presets; /* nr_presets * nr_total_params */
>  };
>  
> +/**
> + * config register instance - part of a loaded feature.
> + *                            maps register values to csdev driver structures
> + *
> + * @reg_desc:		value to use when setting feature on device / store for
> + *			readback of volatile values.
> + * @driver_regval:	pointer to internal driver element used to set the value
> + *			in hardware.
> + */
> +struct cscfg_regval_csdev {
> +	struct cscfg_regval_desc reg_desc;
> +	void *driver_regval;
> +};
> +
> +/**
> + * config parameter instance - part of a loaded feature.
> + *
> + * @feat_csdev:		parent feature
> + * @reg_csdev:		register value updated by this parameter.
> + * @current_value:	current value of parameter - may be set by user via
> + *			sysfs, or modified during device operation.
> + * @val64:		true if 64 bit value
> + */
> +struct cscfg_parameter_csdev {
> +	struct cscfg_feature_csdev *feat_csdev;
> +	struct cscfg_regval_csdev *reg_csdev;
> +	u64 current_value;
> +	bool val64;
> +};
> +
> +/**
> + * Feature instance loaded into a CoreSight device.
> + *
> + * When a feature is loaded into a specific device, then this structure holds
> + * the connections between the register / parameter values used and the
> + * internal data structures that are written when the feature is enabled.
> + *
> + * Since applying a feature modifies internal data structures in the device,
> + * then we have a reference to the device spinlock to protect access to these
> + * structures (@drv_spinlock).
> + *
> + * @feat_desc:		pointer to the static descriptor for this feature.
> + * @csdev:		parent CoreSight device instance.
> + * @node:		list entry into feature list for this device.
> + * @drv_spinlock:	device spinlock for access to driver register data.
> + * @nr_params:		number of parameters.
> + * @params_csdev:	current parameter values on this device
> + * @nr_regs:		number of registers to be programmed.
> + * @regs_csdev:		Programming details for the registers
> + */
> +struct cscfg_feature_csdev {
> +	const struct cscfg_feature_desc *feat_desc;
> +	struct coresight_device *csdev;
> +	struct list_head node;
> +	spinlock_t *drv_spinlock;
> +	int nr_params;
> +	struct cscfg_parameter_csdev *params_csdev;
> +	int nr_regs;
> +	struct cscfg_regval_csdev *regs_csdev;
> +};
> +
> +/**
> + * Configuration instance when loaded into a CoreSight device.
> + *
> + * The instance contains references to loaded features on this device that are
> + * used by the configuration.
> + *
> + * @config_desc:reference to the descriptor for this configuration
> + * @csdev:	parent coresight device for this configuration instance.
> + * @enabled:	true if configuration is enabled on this device.
> + * @node:	list entry within the coresight device
> + * @nr_feat:	Number of features on this device that are used in the
> + *		configuration.
> + * @feats_csdev:references to the device features to enable.
> + */
> +struct cscfg_config_csdev {
> +	const struct cscfg_config_desc *config_desc;
> +	struct coresight_device *csdev;
> +	bool enabled;
> +	struct list_head node;
> +	int nr_feat;
> +	struct cscfg_feature_csdev *feats_csdev[0];
> +};
> +
> +/**
> + * Coresight device operations.
> + *
> + * Registered coresight devices provide these operations to manage feature
> + * instances compatible with the device hardware and drivers
> + *
> + * @load_feat:	Pass a feature descriptor into the device and create the
> + *		loaded feature instance (struct cscfg_feature_csdev).
> + */
> +struct cscfg_csdev_feat_ops {
> +	int (*load_feat)(struct coresight_device *csdev,
> +			 struct cscfg_feature_csdev *feat_csdev);
> +};
> +
>  #endif /* _CORESIGHT_CORESIGHT_CONFIG_H */
> diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
> index 3e0ab4ac93fd..d6471eab8a5f 100644
> --- a/drivers/hwtracing/coresight/coresight-syscfg.c
> +++ b/drivers/hwtracing/coresight/coresight-syscfg.c
> @@ -25,6 +25,199 @@ static struct cscfg_manager *cscfg_mgr;
>  
>  /* load features and configuations into the lists */
>  
> +/* protect the cfg lists in the csdev instances */
> +static DEFINE_MUTEX(cscfg_csdev_mutex);
> +
> +/* get name feature instance from a coresight device list of features */
> +static struct cscfg_feature_csdev *
> +cscfg_get_feat_csdev(struct coresight_device *csdev, const char *name)
> +{
> +	struct cscfg_feature_csdev *feat_csdev = NULL;
> +
> +	list_for_each_entry(feat_csdev, &csdev->feature_csdev_list, node) {
> +		if (strcmp(feat_csdev->feat_desc->name, name) == 0)
> +			return feat_csdev;
> +	}
> +	return NULL;
> +}
> +
> +/* allocate the device config instance - with max number of used features */
> +static struct cscfg_config_csdev *
> +cscfg_alloc_csdev_cfg(struct coresight_device *csdev, int nr_feats)
> +{
> +	struct cscfg_config_csdev *config_csdev = NULL;
> +	struct device *dev = csdev->dev.parent;
> +
> +	/* this is being allocated using the devm for the coresight device */
> +	config_csdev = devm_kzalloc(dev,
> +				    offsetof(struct cscfg_config_csdev, feats_csdev[nr_feats]),
> +				    GFP_KERNEL);
> +	if (!config_csdev)
> +		return NULL;
> +
> +	config_csdev->csdev = csdev;
> +	return config_csdev;
> +}
> +
> +/* Load a config into a device if there are any feature matches between config and device */
> +static int cscfg_add_csdev_cfg(struct coresight_device *csdev,
> +			       struct cscfg_config_desc *config_desc)
> +{
> +	struct cscfg_config_csdev *config_csdev = NULL;
> +	struct cscfg_feature_csdev *feat_csdev;
> +	int i;
> +
> +	/* look at each required feature and see if it matches any feature on the device */
> +	for (i = 0; i < config_desc->nr_feat_refs; i++) {
> +		/* look for a matching name */
> +		feat_csdev = cscfg_get_feat_csdev(csdev, config_desc->feat_ref_names[i]);
> +		if (feat_csdev) {
> +			/*
> +			 * At least one feature on this device matches the config
> +			 * add a config instance to the device and a reference to the feature.
> +			 */
> +			if (!config_csdev) {
> +				config_csdev = cscfg_alloc_csdev_cfg(csdev,
> +								     config_desc->nr_feat_refs);
> +				if (!config_csdev)
> +					return -ENOMEM;
> +				config_csdev->config_desc = config_desc;
> +			}
> +			config_csdev->feats_csdev[config_csdev->nr_feat++] = feat_csdev;
> +		}
> +	}
> +	/* if matched features, add config to device.*/
> +	if (config_csdev) {
> +		mutex_lock(&cscfg_csdev_mutex);
> +		list_add(&config_csdev->node, &csdev->config_csdev_list);
> +		mutex_unlock(&cscfg_csdev_mutex);
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Add the config to the set of registered devices - call with mutex locked.
> + * Iterates through devices - any device that matches one or more of the
> + * configuration features will load it, the others will ignore it.
> + */
> +static int cscfg_add_cfg_to_csdevs(struct cscfg_config_desc *config_desc)
> +{
> +	struct cscfg_registered_csdev *csdev_item;
> +	int err;
> +
> +	list_for_each_entry(csdev_item, &cscfg_mgr->csdev_desc_list, item) {
> +		err = cscfg_add_csdev_cfg(csdev_item->csdev, config_desc);
> +		if (err)
> +			return err;
> +	}
> +	return 0;
> +}
> +
> +/*
> + * Allocate a feature object for load into a csdev.
> + * memory allocated using the csdev->dev object using devm managed allocator.
> + */
> +static struct cscfg_feature_csdev *
> +cscfg_alloc_csdev_feat(struct coresight_device *csdev, struct cscfg_feature_desc *feat_desc)
> +{
> +	struct cscfg_feature_csdev *feat_csdev = NULL;
> +	struct device *dev = csdev->dev.parent;
> +	int i;
> +
> +	feat_csdev = devm_kzalloc(dev, sizeof(struct cscfg_feature_csdev), GFP_KERNEL);
> +	if (!feat_csdev)
> +		return NULL;
> +
> +	/* parameters are optional - could be 0 */
> +	feat_csdev->nr_params = feat_desc->nr_params;
> +
> +	/*
> +	 * if we need parameters, zero alloc the space here, the load routine in
> +	 * the csdev device driver will fill out some information according to
> +	 * feature descriptor.
> +	 */
> +	if (feat_csdev->nr_params) {
> +		feat_csdev->params_csdev = devm_kcalloc(dev, feat_csdev->nr_params,
> +							sizeof(struct cscfg_parameter_csdev),
> +							GFP_KERNEL);
> +		if (!feat_csdev->params_csdev)
> +			return NULL;
> +
> +		/*
> +		 * fill in the feature reference in the param - other fields
> +		 * handled by loader in csdev.
> +		 */
> +		for (i = 0; i < feat_csdev->nr_params; i++)
> +			feat_csdev->params_csdev[i].feat_csdev = feat_csdev;
> +	}
> +
> +	/*
> +	 * Always have registers to program - again the load routine in csdev device
> +	 * will fill out according to feature descriptor and device requirements.
> +	 */
> +	feat_csdev->nr_regs = feat_desc->nr_regs;
> +	feat_csdev->regs_csdev = devm_kcalloc(dev, feat_csdev->nr_regs,
> +					      sizeof(struct cscfg_regval_csdev),
> +					      GFP_KERNEL);
> +	if (!feat_csdev->regs_csdev)
> +		return NULL;
> +
> +	/* load the feature default values */
> +	feat_csdev->feat_desc = feat_desc;
> +	feat_csdev->csdev = csdev;
> +
> +	return feat_csdev;
> +}
> +
> +/* load one feature into one coresight device */
> +static int cscfg_load_feat_csdev(struct coresight_device *csdev,
> +				 struct cscfg_feature_desc *feat_desc,
> +				 struct cscfg_csdev_feat_ops *ops)
> +{
> +	struct cscfg_feature_csdev *feat_csdev;
> +	int err;
> +
> +	if (!ops->load_feat)
> +		return -EINVAL;
> +
> +	feat_csdev = cscfg_alloc_csdev_feat(csdev, feat_desc);
> +	if (!feat_csdev)
> +		return -ENOMEM;
> +
> +	/* load the feature into the device */
> +	err = ops->load_feat(csdev, feat_csdev);
> +	if (err)
> +		return err;
> +
> +	/* add to internal csdev feature list */
> +	mutex_lock(&cscfg_csdev_mutex);
> +	list_add(&feat_csdev->node, &csdev->feature_csdev_list);
> +	mutex_unlock(&cscfg_csdev_mutex);
> +
> +	return 0;
> +}
> +
> +/*
> + * Add feature to any matching devices - call with mutex locked.
> + * Iterates through devices - any device that matches the feature will be
> + * called to load it.
> + */
> +static int cscfg_add_feat_to_csdevs(struct cscfg_feature_desc *feat_desc)
> +{
> +	struct cscfg_registered_csdev *csdev_item;
> +	int err;
> +
> +	list_for_each_entry(csdev_item, &cscfg_mgr->csdev_desc_list, item) {
> +		if (csdev_item->match_flags & feat_desc->match_flags) {
> +			err = cscfg_load_feat_csdev(csdev_item->csdev, feat_desc, &csdev_item->ops);
> +			if (err)
> +				return err;
> +		}
> +	}
> +	return 0;
> +}
> +
>  /* check feature list for a named feature - call with mutex locked. */
>  static bool cscfg_match_list_feat(const char *name)
>  {
> @@ -53,8 +246,14 @@ static int cscfg_check_feat_for_cfg(struct cscfg_config_desc *config_desc)
>   */
>  static int cscfg_load_feat(struct cscfg_feature_desc *feat_desc)
>  {
> -	list_add(&feat_desc->item, &cscfg_mgr->feat_desc_list);
> +	int err;
> +
> +	/* add feature to any matching registered devices */
> +	err = cscfg_add_feat_to_csdevs(feat_desc);
> +	if (err)
> +		return err;
>  
> +	list_add(&feat_desc->item, &cscfg_mgr->feat_desc_list);
>  	return 0;
>  }
>  
> @@ -71,6 +270,11 @@ static int cscfg_load_config(struct cscfg_config_desc *config_desc)
>  	if (err)
>  		return err;
>  
> +	/* add config to any matching registered device */
> +	err = cscfg_add_cfg_to_csdevs(config_desc);
> +	if (err)
> +		return err;
> +
>  	list_add(&config_desc->item, &cscfg_mgr->config_desc_list);
>  	return 0;
>  }
> @@ -121,6 +325,124 @@ int cscfg_load_config_sets(struct cscfg_config_desc **config_descs,
>  }
>  EXPORT_SYMBOL_GPL(cscfg_load_config_sets);
>  
> +/* Handle coresight device registration and add configs and features to devices */
> +
> +/* iterate through config lists and load matching configs to device */
> +static int cscfg_add_cfgs_csdev(struct coresight_device *csdev)
> +{
> +	struct cscfg_config_desc *config_desc;
> +	int err = 0;
> +
> +	list_for_each_entry(config_desc, &cscfg_mgr->config_desc_list, item) {
> +		err = cscfg_add_csdev_cfg(csdev, config_desc);
> +		if (err)
> +			break;
> +	}
> +	return err;
> +}
> +
> +/* iterate through feature lists and load matching features to device */
> +static int cscfg_add_feats_csdev(struct coresight_device *csdev,
> +				 u32 match_flags,
> +				 struct cscfg_csdev_feat_ops *ops)
> +{
> +	struct cscfg_feature_desc *feat_desc;
> +	int err = 0;
> +
> +	if (!ops->load_feat)
> +		return -EINVAL;
> +
> +	list_for_each_entry(feat_desc, &cscfg_mgr->feat_desc_list, item) {
> +		if (feat_desc->match_flags & match_flags) {
> +			err = cscfg_load_feat_csdev(csdev, feat_desc, ops);
> +			if (err)
> +				break;
> +		}
> +	}
> +	return err;
> +}
> +
> +/* Add coresight device to list and copy its matching info */
> +static int cscfg_list_add_csdev(struct coresight_device *csdev,
> +				u32 match_flags,
> +				struct cscfg_csdev_feat_ops *ops)
> +{
> +	struct cscfg_registered_csdev *csdev_item;
> +
> +	/* allocate the list entry structure */
> +	csdev_item = kzalloc(sizeof(struct cscfg_registered_csdev), GFP_KERNEL);
> +	if (!csdev_item)
> +		return -ENOMEM;
> +
> +	csdev_item->csdev = csdev;
> +	csdev_item->match_flags = match_flags;
> +	csdev_item->ops.load_feat = ops->load_feat;
> +	list_add(&csdev_item->item, &cscfg_mgr->csdev_desc_list);
> +
> +	INIT_LIST_HEAD(&csdev->feature_csdev_list);
> +	INIT_LIST_HEAD(&csdev->config_csdev_list);
> +
> +	return 0;
> +}
> +
> +/* remove a coresight device from the list and free data */
> +static void cscfg_list_remove_csdev(struct coresight_device *csdev)
> +{
> +	struct cscfg_registered_csdev *csdev_item, *tmp;
> +
> +	list_for_each_entry_safe(csdev_item, tmp, &cscfg_mgr->csdev_desc_list, item) {
> +		if (csdev_item->csdev == csdev) {
> +			list_del(&csdev_item->item);
> +			kfree(csdev_item);
> +			break;
> +		}
> +	}
> +}
> +
> +/* register a coresight device with the syscfg api */
> +int cscfg_register_csdev(struct coresight_device *csdev,
> +			 u32 match_flags,
> +			 struct cscfg_csdev_feat_ops *ops)
> +{
> +	int ret = 0;
> +
> +	mutex_lock(&cscfg_mutex);
> +
> +	/* add device to list of registered devices  */
> +	ret = cscfg_list_add_csdev(csdev, match_flags, ops);
> +	if (ret)
> +		goto reg_csdev_unlock;
> +
> +	/* now load any registered features and configs matching the device. */
> +	ret = cscfg_add_feats_csdev(csdev, match_flags, ops);
> +	if (ret) {
> +		cscfg_list_remove_csdev(csdev);
> +		goto reg_csdev_unlock;
> +	}
> +
> +	ret = cscfg_add_cfgs_csdev(csdev);
> +	if (ret) {
> +		cscfg_list_remove_csdev(csdev);
> +		goto reg_csdev_unlock;
> +	}
> +
> +	pr_info("CSCFG registered %s", dev_name(&csdev->dev));
> +
> +reg_csdev_unlock:
> +	mutex_unlock(&cscfg_mutex);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(cscfg_register_csdev);
> +
> +/* remove coresight device from registered list */
> +void cscfg_unregister_csdev(struct coresight_device *csdev)
> +{
> +	mutex_lock(&cscfg_mutex);
> +	cscfg_list_remove_csdev(csdev);
> +	mutex_unlock(&cscfg_mutex);
> +}
> +EXPORT_SYMBOL_GPL(cscfg_unregister_csdev);
> +
>  /* Initialise system configuration management device. */
>  
>  struct device *cscfg_device(void)
> diff --git a/drivers/hwtracing/coresight/coresight-syscfg.h b/drivers/hwtracing/coresight/coresight-syscfg.h
> index 18be9b58cd0b..5bcae3b374c6 100644
> --- a/drivers/hwtracing/coresight/coresight-syscfg.h
> +++ b/drivers/hwtracing/coresight/coresight-syscfg.h
> @@ -35,6 +35,22 @@ struct cscfg_manager {
>  /* get reference to dev in cscfg_manager */
>  struct device *cscfg_device(void);
>  
> +/**
> + * List entry for Coresight devices that are registered as supporting complex
> + * config operations.
> + *
> + * @csdev:	 The registered device.
> + * @match_flags: The matching type information for adding features.
> + * @ops:	 Operations supported by the registered device.
> + * @item:	 list entry.
> + */
> +struct cscfg_registered_csdev {
> +	struct coresight_device *csdev;
> +	u32 match_flags;
> +	struct cscfg_csdev_feat_ops ops;
> +	struct list_head item;
> +};
> +
>  /* internal core operations for cscfg */
>  int __init cscfg_init(void);
>  void cscfg_exit(void);
> @@ -42,5 +58,8 @@ void cscfg_exit(void);
>  /* syscfg manager external API */
>  int cscfg_load_config_sets(struct cscfg_config_desc **cfg_descs,
>  			   struct cscfg_feature_desc **feat_descs);
> +int cscfg_register_csdev(struct coresight_device *csdev, u32 match_flags,
> +			 struct cscfg_csdev_feat_ops *ops);
> +void cscfg_unregister_csdev(struct coresight_device *csdev);
>  
>  #endif /* CORESIGHT_SYSCFG_H */
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 976ec2697610..d0126ed326a6 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -219,6 +219,8 @@ struct coresight_sysfs_link {
>   * @nr_links:   number of sysfs links created to other components from this
>   *		device. These will appear in the "connections" group.
>   * @has_conns_grp: Have added a "connections" group for sysfs links.
> + * @feature_csdev_list: List of complex feature programming added to the device.
> + * @config_csdev_list:  List of system configurations added to the device.
>   */
>  struct coresight_device {
>  	struct coresight_platform_data *pdata;
> @@ -240,6 +242,9 @@ struct coresight_device {
>  	int nr_links;
>  	bool has_conns_grp;
>  	bool ect_enabled; /* true only if associated ect device is enabled */
> +	/* system configuration and feature lists */
> +	struct list_head feature_csdev_list;
> +	struct list_head config_csdev_list;
>  };
>  
>  /*
> -- 
> 2.17.1
> 
