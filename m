Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9299D321FA7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 20:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbhBVTHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 14:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbhBVTGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 14:06:13 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F2AC06178B
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 11:05:31 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id t5so319828pjd.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 11:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Je502acR01r6/SPBqpB8Uo6h0rfg9ClMtmh8OUgji2s=;
        b=BQ7OPSVWVpwMPZQUWB1EWVWmWO+h+m+EiSx8QGOP6WkBlCuRJ4xQ4KnfaAH7MhlBGW
         N/hLak64oaRqcEaEnvNeI6yI7mjC+eLVZ3L7SuM3dHC+/1gSGSu92YJhkT/cWwqfGLrT
         0Rje5LLdoxsHSxoaiHDTxTZcMupgxpfLoqMRoLJOgjPaROaK6yEria93pAWqJsD5yKNN
         dEQDndDGN89elHyL5fpZvNiHV9SbIUoZnkGNGJ+lYk1vbUKGq25qtZwYbWM3dmUWqKmD
         WpcIbl3J25jK39uAUcvzuPgdUoFTlelyKGew3IGkAZOG3p6pvO0NvIaFFJ4U3aqN6Urc
         IiTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Je502acR01r6/SPBqpB8Uo6h0rfg9ClMtmh8OUgji2s=;
        b=C8soGR6R2Ozwkm/m0ZgEpTuKzvgA4mYMGduW1YIX5HJNKK+1pRqBDlz4aZw+wDLutY
         mTzcf7eW6BYEiNQh8dp+eIagMEu5ozqFgkI2ii0wdbu95GC7m4xtaog9rnCx4D0IwUZg
         fglhoxTgvHc6zhvmryZ+4gKtqxzg33G1xsvXHUgMp3VaE7wcDtIlfXN+bWA9i3U2beC9
         3uFXqBfKBlPHtQR/Re2MWb8xR31DgUOIWQCxk30e+IKzGWk6z2R48+Rk0H6fKhOlEsKR
         xWWlk/plWJwf/9PL3uS+rMdwXhHlfMO+8pP+baVtnh6bly3hreCOzreiiDLmuIYxObNU
         npZw==
X-Gm-Message-State: AOAM533SWGG50GUn4eOR8gQTArXwexDr9tdl5hvvrEOZ4FoeDoW6mB7n
        LaGFoKtnw8ci6ogXQkXPdLQNJQ==
X-Google-Smtp-Source: ABdhPJzAxD+2QnNQuLrBNFpx5fI4LPenXH82ujN3opydFwzc7b2/ZMTshMFFwU33cH5BeIMSUuvGew==
X-Received: by 2002:a17:90a:72c4:: with SMTP id l4mr20827164pjk.52.1614020730983;
        Mon, 22 Feb 2021 11:05:30 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id u66sm6180095pfc.72.2021.02.22.11.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 11:05:30 -0800 (PST)
Date:   Mon, 22 Feb 2021 12:05:28 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-doc@vger.kernel.org, suzuki.poulose@arm.com,
        yabinc@google.com, corbet@lwn.net, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, tingwei@codeaurora.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/10] coresight: syscfg: Add registration and feature
 loading for cs devices
Message-ID: <20210222190528.GB3239381@xps15>
References: <20210128170936.9222-1-mike.leach@linaro.org>
 <20210128170936.9222-3-mike.leach@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128170936.9222-3-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 05:09:28PM +0000, Mike Leach wrote:
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
>  .../hwtracing/coresight/coresight-config.h    |  98 +++++
>  .../hwtracing/coresight/coresight-syscfg.c    | 348 ++++++++++++++++++
>  .../hwtracing/coresight/coresight-syscfg.h    |  20 +
>  include/linux/coresight.h                     |   5 +
>  4 files changed, 471 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwtracing/coresight/coresight-config.h
> index 3fedf8ab3cee..75ecdecf7013 100644
> --- a/drivers/hwtracing/coresight/coresight-config.h
> +++ b/drivers/hwtracing/coresight/coresight-config.h
> @@ -164,4 +164,102 @@ struct cscfg_config_desc {
>  	const u64 *presets; /* nr_presets * nr_total_params */
>  };
>  
> +/**
> + * config register instance - part of a loaded feature.
> + *                            maps register values to csdev driver structures
> + *
> + * @value:	value to use when setting feature on device / store for
> + *		readback of volatile values.
> + * @drv_store:	pointer to internal driver element used to set the value
> + *		in hardware.
> + */
> +struct cscfg_reg_csdev {
> +	struct cscfg_regval_desc value;

        struct cscfg_regval_desc reg_desc;

> +	void *drv_store;
> +};
> +
> +/**
> + * config parameter instance - part of a loaded feature.
> + *
> + * @feat:		parent feature
> + * @reg:		register value updated by this parameter.
> + * @current_value:	current value of parameter - may be set by user via
> + *			sysfs, or modified during device operation.
> + * @val64:		true if 64 bit value
> + */
> +struct cscfg_parameter_csdev {
> +	struct cscfg_feature_csdev *feat;

        struct cscfg_feature_csdev *feat_csdev;

> +	struct cscfg_reg_csdev *reg;
        
        struct cscfg_reg_csdev *reg_csdev;

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
> + * structures (@csdev_spinlock).
> + *
> + * @desc:		pointer to the static descriptor for this feature.
> + * @csdev:		parent CoreSight device instance.
> + * @node:		list entry into feature list for this device.
> + * @csdev_spinlock:	device spinlock from csdev instance..
> + * @nr_params:		number of parameters.
> + * @params:		current parameter values on this device
> + * @nr_regs:		number of registers to be programmed.
> + * @regs:		Programming details for the registers
> + */
> +struct cscfg_feature_csdev {
> +	const struct cscfg_feature_desc *desc;

        const struct cscfg_feature_desc *feat_desc;

> +	struct coresight_device *csdev;
> +	struct list_head node;
> +	spinlock_t *csdev_spinlock;
> +	int nr_params;
> +	struct cscfg_parameter_csdev *params;

        struct cscfg_parameter_csdev *params_csdev;

> +	int nr_regs;
> +	struct cscfg_reg_csdev *regs;
        
        struct cscfg_reg_csdev *regs_csdev;
> +};
> +
> +/**
> + * Configuration instance when loaded into a CoreSight device.
> + *
> + * The instance contains references to loaded features on this device that are
> + * used by the configuration.
> + *
> + * @desc:	reference to the descriptor for this configuration
> + * @csdev:	parent coresight device for this configuration instance.
> + * @node:	list entry within the coresight device
> + * @nr_feat:	Number of features on this device that are used in the
> + *		 configuration.
> + * @feats:	reference to the device features to enable.
> + * @enabled:	true if configuration is enabled on this device.
> + */
> +struct cscfg_config_csdev {
> +	const struct cscfg_config_desc *desc;

        const struct cscfg_config_desc *cfg_desc;

> +	struct coresight_device *csdev;
> +	struct list_head node;
> +	int nr_feat;
> +	struct cscfg_feature_csdev **feats;

        struct cscfg_feature_csdev **feat_csdev;

> +	bool enabled;
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
> +			 struct cscfg_feature_csdev *feat);

                        struct cscfg_feature_csdev *feat_csdev);

Please pick the same convention for naming structure throughout the entire
patchset for declaration and function parameters.  I know it is a lot of
modifications but it is the only way I can concentrate on the feature being
added without having to constantly go back to the header files.

Thanks,
Mathieu

> +};
> +
>  #endif /* _CORESIGHT_CORESIGHT_CONFIG_H */
> diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
> index f7e396a5f9cb..c04cea0c1db2 100644
> --- a/drivers/hwtracing/coresight/coresight-syscfg.c
> +++ b/drivers/hwtracing/coresight/coresight-syscfg.c
> @@ -25,6 +25,212 @@ static struct cscfg_manager *cscfg_mgr;
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
> +	struct cscfg_feature_csdev *feat = NULL;
> +
> +	list_for_each_entry(feat, &csdev->feature_csdev_list, node) {
> +		if (strcmp(feat->desc->name, name) == 0)
> +			return feat;
> +	}
> +	return NULL;
> +}
> +
> +/* allocate the device config instance - with max number of used features */
> +static struct cscfg_config_csdev *
> +cscfg_alloc_csdev_cfg(struct coresight_device *csdev, int nr_feats)
> +{
> +	struct cscfg_config_csdev *dev_cfg = NULL;
> +	struct device *dev = csdev->dev.parent;
> +
> +	/* this is being allocated using the devm for the coresight device */
> +	dev_cfg = devm_kzalloc(dev, sizeof(struct cscfg_config_csdev), GFP_KERNEL);
> +	if (!dev_cfg)
> +		return NULL;
> +
> +	dev_cfg->csdev = csdev;
> +	dev_cfg->feats = devm_kcalloc(dev, nr_feats,
> +				      sizeof(struct cscfg_feature_csdev *),
> +				      GFP_KERNEL);
> +	if (!dev_cfg->feats)
> +		dev_cfg = NULL;
> +	return dev_cfg;
> +}
> +
> +/* check match info between used feature from the config and a regisered device */
> +static bool cscfg_match_feat_info(struct cscfg_match_desc *used_cmp,
> +				  struct cscfg_match_desc *reg_dev)
> +{
> +	/* if flags don't match then fail early */
> +	if (!(used_cmp->match_flags & reg_dev->match_flags))
> +		return false;
> +
> +	return true;
> +}
> +
> +/* Load a config into a device if there are feature matches between config and device  */
> +static int cscfg_add_csdev_cfg(struct coresight_device *csdev,
> +			       struct cscfg_match_desc *match_info,
> +			       struct cscfg_config_desc *cfg_desc)
> +{
> +	struct cscfg_config_csdev *dev_cfg = NULL;
> +	struct cscfg_config_feat_ref *feat_ref;
> +	struct cscfg_feature_csdev *feat;
> +	int checked;
> +
> +	/* look at each required feature and see if it matches any feature on the device */
> +	for (checked = 0; checked < cfg_desc->nr_refs; checked++) {
> +		feat_ref = &cfg_desc->refs[checked];
> +		if (cscfg_match_feat_info(&feat_ref->match, match_info)) {
> +			/* device matched - get the feature */
> +			feat = cscfg_get_feat_csdev(csdev, feat_ref->name);
> +			if (!feat)
> +				return -EINVAL;
> +			if (!dev_cfg) {
> +				dev_cfg = cscfg_alloc_csdev_cfg(csdev, cfg_desc->nr_refs);
> +				if (!dev_cfg)
> +					return -ENOMEM;
> +				dev_cfg->desc = cfg_desc;
> +			}
> +			dev_cfg->feats[dev_cfg->nr_feat++] = feat;
> +		}
> +	}
> +	/* if matched features, add config to device.*/
> +	if (dev_cfg) {
> +		mutex_lock(&cscfg_csdev_mutex);
> +		list_add(&dev_cfg->node, &csdev->config_csdev_list);
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
> +static int cscfg_add_cfg_to_csdevs(struct cscfg_config_desc *cfg_desc)
> +{
> +	struct cscfg_csdev_register *curr_item;
> +	int err;
> +
> +	list_for_each_entry(curr_item, &cscfg_mgr->data.csdev_desc_list, item) {
> +		err = cscfg_add_csdev_cfg(curr_item->csdev, &curr_item->match_info, cfg_desc);
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
> +	struct cscfg_feature_csdev *feat = NULL;
> +	struct device *dev = csdev->dev.parent;
> +	int i;
> +
> +	feat = devm_kzalloc(dev, sizeof(struct cscfg_feature_csdev), GFP_KERNEL);
> +	if (!feat)
> +		return NULL;
> +
> +	/* parameters are optional - could be 0 */
> +	feat->nr_params = feat_desc->nr_params;
> +
> +	/*
> +	 * if we need parameters, zero alloc the space here, the load routine in
> +	 * the csdev device driver will fill out some information according to
> +	 * feature descriptor.
> +	 */
> +	if (feat->nr_params) {
> +		feat->params = devm_kcalloc(dev, feat->nr_params,
> +					    sizeof(struct cscfg_parameter_csdev),
> +					    GFP_KERNEL);
> +		if (!feat->params)
> +			return NULL;
> +
> +		/*
> +		 * fill in the feature reference in the param - other fields
> +		 * handled by loader in csdev.
> +		 */
> +		for (i = 0; i < feat->nr_params; i++)
> +			feat->params[i].feat = feat;
> +	}
> +
> +	/*
> +	 * Always have registers to program - again the load routine in csdev device
> +	 * will fill out according to feature descriptor and device requirements.
> +	 */
> +	feat->nr_regs = feat_desc->nr_regs;
> +	feat->regs = devm_kcalloc(dev, feat->nr_regs,
> +				  sizeof(struct cscfg_reg_csdev), GFP_KERNEL);
> +	if (!feat->regs)
> +		return NULL;
> +
> +	/* load the feature default values */
> +	feat->desc = feat_desc;
> +	feat->csdev = csdev;
> +
> +	return feat;
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
> +	/* load the feature into the device - may modify default ops*/
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
> +	struct cscfg_csdev_register *curr_item;
> +	int err;
> +
> +	list_for_each_entry(curr_item, &cscfg_mgr->data.csdev_desc_list, item) {
> +		if (curr_item->match_info.match_flags & feat_desc->match_flags) {
> +			err = cscfg_load_feat_csdev(curr_item->csdev, feat_desc, &curr_item->ops);
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
> @@ -53,6 +259,13 @@ static int cscfg_check_feat_for_cfg(struct cscfg_config_desc *cfg_desc)
>   */
>  static int cscfg_load_feat(struct cscfg_feature_desc *feat_desc)
>  {
> +	int err;
> +
> +	/* add feature to any matching registered devices */
> +	err = cscfg_add_feat_to_csdevs(feat_desc);
> +	if (err)
> +		return err;
> +
>  	list_add(&feat_desc->item, &cscfg_mgr->data.feat_desc_list);
>  
>  	return 0;
> @@ -71,6 +284,11 @@ static int cscfg_load_config(struct cscfg_config_desc *cfg_desc)
>  	if (err)
>  		return err;
>  
> +	/* add config to any matching registered device */
> +	err = cscfg_add_cfg_to_csdevs(cfg_desc);
> +	if (err)
> +		return err;
> +
>  	list_add(&cfg_desc->item, &cscfg_mgr->data.config_desc_list);
>  
>  	return 0;
> @@ -122,6 +340,136 @@ int cscfg_load_config_sets(struct cscfg_config_desc **cfg_descs,
>  }
>  EXPORT_SYMBOL_GPL(cscfg_load_config_sets);
>  
> +/* Handle coresight device registration and add configs and features to devices */
> +
> +/* iterate through config lists and load matching configs to device */
> +static int cscfg_add_cfgs_csdev(struct coresight_device *csdev,
> +				struct cscfg_match_desc *info)
> +{
> +	struct cscfg_config_desc *curr_item;
> +	int err = 0;
> +
> +	list_for_each_entry(curr_item, &cscfg_mgr->data.config_desc_list, item) {
> +		err = cscfg_add_csdev_cfg(csdev, info, curr_item);
> +		if (err)
> +			break;
> +	}
> +	return err;
> +}
> +
> +/* iterate through feature lists and load matching features to device */
> +static int cscfg_add_feats_csdev(struct coresight_device *csdev,
> +				 struct cscfg_match_desc *info,
> +				 struct cscfg_csdev_feat_ops *ops)
> +{
> +	struct cscfg_feature_desc *curr_item;
> +	int err = 0;
> +
> +	if (!ops->load_feat)
> +		return -EINVAL;
> +
> +	list_for_each_entry(curr_item, &cscfg_mgr->data.feat_desc_list, item) {
> +		if (curr_item->match_flags & info->match_flags) {
> +			err = cscfg_load_feat_csdev(csdev, curr_item, ops);
> +			if (err)
> +				break;
> +		}
> +	}
> +	return err;
> +}
> +
> +/* Add coresight device to list and copy its matching info */
> +static int cscfg_list_add_csdev(struct coresight_device *csdev,
> +				struct cscfg_match_desc *info,
> +				struct cscfg_csdev_feat_ops *ops)
> +{
> +	struct cscfg_csdev_register *list_entry;
> +
> +	/* allocate the list entry structure */
> +	list_entry = kzalloc(sizeof(struct cscfg_csdev_register), GFP_KERNEL);
> +	if (!list_entry)
> +		return -ENOMEM;
> +
> +	list_entry->csdev = csdev;
> +	list_entry->match_info.match_flags = info->match_flags;
> +	list_entry->ops.load_feat = ops->load_feat;
> +	list_add(&list_entry->item, &cscfg_mgr->data.csdev_desc_list);
> +
> +	INIT_LIST_HEAD(&csdev->feature_csdev_list);
> +	INIT_LIST_HEAD(&csdev->config_csdev_list);
> +	cscfg_mgr->data.nr_csdev++;
> +
> +	return 0;
> +}
> +
> +/* remove a coresight device from the list and free data */
> +static void cscfg_list_remove_csdev(struct coresight_device *csdev)
> +{
> +	struct cscfg_csdev_register *curr_item, *tmp;
> +
> +	list_for_each_entry_safe(curr_item, tmp, &cscfg_mgr->data.csdev_desc_list, item) {
> +		if (curr_item->csdev == csdev) {
> +			list_del(&curr_item->item);
> +			kfree(curr_item);
> +			cscfg_mgr->data.nr_csdev--;
> +			break;
> +		}
> +	}
> +}
> +
> +/* register a coresight device with the syscfg api */
> +int cscfg_register_csdev(struct coresight_device *csdev,
> +			 struct cscfg_match_desc *info,
> +			 struct cscfg_csdev_feat_ops *ops)
> +{
> +	int ret = 0;
> +
> +	mutex_lock(&cscfg_mutex);
> +
> +	/* add device to list of registered devices  */
> +	ret = cscfg_list_add_csdev(csdev, info, ops);
> +	if (ret)
> +		goto reg_csdev_unlock;
> +
> +	/* now load any registered features and configs matching the device. */
> +	ret = cscfg_add_feats_csdev(csdev, info, ops);
> +	if (ret) {
> +		cscfg_list_remove_csdev(csdev);
> +		goto reg_csdev_unlock;
> +	}
> +
> +	ret = cscfg_add_cfgs_csdev(csdev, info);
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
> +/* remove coresight device and update counts - syscfg device at 0 */
> +void cscfg_unregister_csdev(struct coresight_device *csdev)
> +{
> +	struct cscfg_csdev_register *curr_item, *tmp;
> +
> +	mutex_lock(&cscfg_mutex);
> +	list_for_each_entry_safe(curr_item, tmp, &cscfg_mgr->data.csdev_desc_list, item) {
> +		if (curr_item->csdev == csdev) {
> +			list_del(&curr_item->item);
> +			kfree(curr_item);
> +			cscfg_mgr->data.nr_csdev--;
> +			break;
> +		}
> +	}
> +	mutex_unlock(&cscfg_mutex);
> +}
> +EXPORT_SYMBOL_GPL(cscfg_unregister_csdev);
> +
>  /* Initialise system configuration management device. */
>  
>  struct device *to_device_cscfg(void)
> diff --git a/drivers/hwtracing/coresight/coresight-syscfg.h b/drivers/hwtracing/coresight/coresight-syscfg.h
> index 907ba8d3efea..ebf5e1491d86 100644
> --- a/drivers/hwtracing/coresight/coresight-syscfg.h
> +++ b/drivers/hwtracing/coresight/coresight-syscfg.h
> @@ -26,6 +26,22 @@ struct cscfg_api_data {
>  	int nr_csdev;
>  };
>  
> +/**
> + * List entry for Coresight devices that are registered as supporting complex
> + * config operations.
> + *
> + * @csdev:	The registered device.
> + * @match_info: The matching type information.
> + * @ops:	Operations supported by the registered device.
> + * @item:	list entry.
> + */
> +struct cscfg_csdev_register {
> +	struct coresight_device *csdev;
> +	struct cscfg_match_desc match_info;
> +	struct cscfg_csdev_feat_ops ops;
> +	struct list_head item;
> +};
> +
>  /* internal core operations for cscfg */
>  int __init cscfg_init(void);
>  void __exit cscfg_exit(void);
> @@ -33,6 +49,10 @@ void __exit cscfg_exit(void);
>  /* syscfg manager external API */
>  int cscfg_load_config_sets(struct cscfg_config_desc **cfg_descs,
>  			   struct cscfg_feature_desc **feat_descs);
> +int cscfg_register_csdev(struct coresight_device *csdev,
> +			 struct cscfg_match_desc *info,
> +			 struct cscfg_csdev_feat_ops *ops);
> +void cscfg_unregister_csdev(struct coresight_device *csdev);
>  
>  /**
>   * System configuration manager device.
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
