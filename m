Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C019A327570
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 01:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhCAADO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 19:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhCAADM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 19:03:12 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E70C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 16:02:31 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id g20so8807408plo.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 16:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wfXBkAEoISyU2kjYrX43/zpDDw4c+sBwAvBvTJ2YKxA=;
        b=NwDPgRqxGE/1GI+SiShn5RfEJi4a/IB8sCX9j06UpPfexmmGcfSdWP5bRgkgLH5HtB
         9qe75idVRlIV4UXBAudKobo985QoQXQ9oE96iJOEiny/5J1qWTW94CDhPuz3wK27xpLk
         LtKwR7cJSCFqoXncEaZCycqc9rFyj/gH0VrkeNigmRKN/4UiRH7OoUZMr/NJeIHFzCih
         1EiAmS6n608GTP1a6LFcBU8oUjcuF1f9dZ/ylfMu9S7R8zHGT7qVvXoQ1J4QszW2OJzp
         7XigaMFO3iOWDreTcjIeWpQi0cG6qgcmlti/dk7KD/DYPXmTiDs6TXSA7YgU9pZpmGEi
         FggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wfXBkAEoISyU2kjYrX43/zpDDw4c+sBwAvBvTJ2YKxA=;
        b=AUldigKCWv1fMazX9Uy4co9RCMUB4lC/Bt4T88Jo55GVE2Dvs0u2qFsLvKVLYOKQSD
         GVKj+ia1czBK5B3m1A/bMY6q4ra515zfVVhAxAdHBdKqOOgrt6/D2wiNgLBQtr6s+LFz
         i5Kk8vuN1/WEyYG8gWVmb+uB/e6dz1v1epnGi6Uk9Q6KTM6BamgGXpQt2ldv7B7XediY
         tTAzVoGmlkAgd2eX12sPguBTppAADCEmGWKuvBnrUj2pjF1GsFxTGE2zN4DG1UwPBia6
         EldXrWZuVfKEVqylZwAKxtSF3HUeIFFBn70ApCYAHufNYfNJd4giPdxjQwZ+yXyQJFzr
         FtFA==
X-Gm-Message-State: AOAM530ZL1RRCs86VMp3jMeoLAYkdICnnuyqoQWYE4PlOQxdV0+5WHSh
        2FAXNFe3yJIYDnPABvlGEajVBg==
X-Google-Smtp-Source: ABdhPJwWULMoyFZ7dS2qQZX+YfVYj8DJcmQHyZbYBWGDcSBrAE7jYz3b2ohfWZNIbKDbEmiYe7Co7Q==
X-Received: by 2002:a17:90a:a414:: with SMTP id y20mr13182183pjp.77.1614556951222;
        Sun, 28 Feb 2021 16:02:31 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id p19sm15259777pjo.7.2021.02.28.16.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 16:02:30 -0800 (PST)
Date:   Sun, 28 Feb 2021 17:02:28 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-doc@vger.kernel.org, suzuki.poulose@arm.com,
        yabinc@google.com, corbet@lwn.net, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, tingwei@codeaurora.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/10] coresight: syscfg: Add initial configfs support
Message-ID: <20210301000228.GD3631443@xps15>
References: <20210128170936.9222-1-mike.leach@linaro.org>
 <20210128170936.9222-10-mike.leach@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128170936.9222-10-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 05:09:35PM +0000, Mike Leach wrote:
> Adds configfs subsystem and attributes to the configuration manager
> to enable the listing of loaded configurations and features.
> 
> The default values of feature parameters can be accessed and altered
> from these attributes to affect all installed devices using the feature.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---
>  drivers/hwtracing/coresight/Makefile          |   3 +-
>  .../hwtracing/coresight/coresight-config.c    |   1 +
>  .../coresight/coresight-syscfg-configfs.c     | 399 ++++++++++++++++++
>  .../coresight/coresight-syscfg-configfs.h     |  45 ++
>  .../hwtracing/coresight/coresight-syscfg.c    |  77 ++++
>  .../hwtracing/coresight/coresight-syscfg.h    |   7 +
>  6 files changed, 531 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/hwtracing/coresight/coresight-syscfg-configfs.c
>  create mode 100644 drivers/hwtracing/coresight/coresight-syscfg-configfs.h
> 
> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> index 2707bfef1b76..391c93a08902 100644
> --- a/drivers/hwtracing/coresight/Makefile
> +++ b/drivers/hwtracing/coresight/Makefile
> @@ -5,7 +5,8 @@
>  obj-$(CONFIG_CORESIGHT) += coresight.o
>  coresight-y := coresight-core.o  coresight-etm-perf.o coresight-platform.o \
>  		coresight-sysfs.o coresight-syscfg.o coresight-config.o \
> -		coresight-cfg-preload.o coresight-cfg-afdo.o
> +		coresight-cfg-preload.o coresight-cfg-afdo.o \
> +		coresight-syscfg-configfs.o
>  obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o
>  coresight-tmc-y := coresight-tmc-core.o coresight-tmc-etf.o \
>  		      coresight-tmc-etr.o
> diff --git a/drivers/hwtracing/coresight/coresight-config.c b/drivers/hwtracing/coresight/coresight-config.c
> index 6cc4b213d9b6..225ceca1428c 100644
> --- a/drivers/hwtracing/coresight/coresight-config.c
> +++ b/drivers/hwtracing/coresight/coresight-config.c
> @@ -243,3 +243,4 @@ void cscfg_csdev_disable_config(struct cscfg_config_csdev *cfg)
>  		cfg->enabled = false;
>  	}
>  }
> +

Spurious change

> diff --git a/drivers/hwtracing/coresight/coresight-syscfg-configfs.c b/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
> new file mode 100644
> index 000000000000..79a11ebd6782
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
> @@ -0,0 +1,399 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2020 Linaro Limited, All rights reserved.
> + * Author: Mike Leach <mike.leach@linaro.org>
> + */
> +
> +#include <linux/configfs.h>
> +
> +#include "coresight-syscfg-configfs.h"
> +
> +/* create a default ci_type. */
> +static inline struct config_item_type *cscfg_create_ci_type(void)
> +{
> +	struct config_item_type *ci_type;
> +
> +	ci_type = devm_kzalloc(to_device_cscfg(), sizeof(*ci_type), GFP_KERNEL);
> +	if (ci_type)
> +		ci_type->ct_owner = THIS_MODULE;
> +
> +	return ci_type;
> +}
> +
> +/* configurations sub-group */
> +
> +/* attributes for the config view group */
> +static ssize_t cscfg_cfg_description_show(struct config_item *item, char *page)
> +{
> +	struct cscfg_fs_config *fs_config = container_of(to_config_group(item),
> +							 struct cscfg_fs_config, group);
> +
> +	return scnprintf(page, PAGE_SIZE, "%s\n", fs_config->desc->brief);
> +}
> +CONFIGFS_ATTR_RO(cscfg_cfg_, description);
> +
> +static ssize_t cscfg_cfg_feature_refs_show(struct config_item *item, char *page)
> +{
> +	struct cscfg_fs_config *fs_config = container_of(to_config_group(item),
> +							 struct cscfg_fs_config, group);
> +	const struct cscfg_config_desc *desc = fs_config->desc;
> +	ssize_t ch_used = 0;
> +	int i;
> +
> +	if (desc->nr_refs) {
> +		for (i = 0; i < desc->nr_refs; i++) {
> +			ch_used += scnprintf(page + ch_used, PAGE_SIZE - ch_used,
> +					     "%s\n", desc->refs[i].name);
> +		}
> +	}
> +	return ch_used;
> +}
> +CONFIGFS_ATTR_RO(cscfg_cfg_, feature_refs);
> +
> +/* list preset values in order of features and params */
> +static ssize_t cscfg_cfg_values_show(struct config_item *item, char *page)
> +{
> +	const struct cscfg_feature_desc *feat;
> +	const struct cscfg_config_desc *cfg;
> +	struct cscfg_fs_preset *fs_preset;
> +	int i, j, val_idx, preset_idx;
> +	ssize_t used = 0;
> +
> +	fs_preset = container_of(to_config_group(item), struct cscfg_fs_preset, group);
> +	cfg = fs_preset->desc;
> +
> +	if (!cfg->nr_presets)
> +		return 0;
> +
> +	preset_idx = fs_preset->preset_num - 1;
> +
> +	/* start index on the correct array line */
> +	val_idx = cfg->nr_total_params * preset_idx;
> +
> +	/*
> +	 * A set of presets is the sum of all params in used features,
> +	 * in order of declaration of features and params in the features
> +	 */
> +	for (i = 0; i < cfg->nr_refs; i++) {
> +		feat = cscfg_get_named_feat_desc(cfg->refs[i].name);
> +		for (j = 0; j < feat->nr_params; j++) {
> +			used += scnprintf(page + used, PAGE_SIZE - used,
> +					  "%s.%s = 0x%llx ",
> +					  feat->name, feat->params[j].name,
> +					  cfg->presets[val_idx++]);
> +		}
> +	}
> +	used += scnprintf(page + used, PAGE_SIZE - used, "\n");
> +
> +	return used;
> +}
> +CONFIGFS_ATTR_RO(cscfg_cfg_, values);
> +
> +static struct configfs_attribute *cscfg_config_view_attrs[] = {
> +	&cscfg_cfg_attr_description,
> +	&cscfg_cfg_attr_feature_refs,
> +	NULL,
> +};
> +
> +static struct config_item_type cscfg_config_view_type = {
> +	.ct_owner = THIS_MODULE,
> +	.ct_attrs = cscfg_config_view_attrs,
> +};
> +
> +static struct configfs_attribute *cscfg_config_preset_attrs[] = {
> +	&cscfg_cfg_attr_values,
> +	NULL,
> +};
> +
> +static struct config_item_type cscfg_config_preset_type = {
> +	.ct_owner = THIS_MODULE,
> +	.ct_attrs = cscfg_config_preset_attrs,
> +};
> +
> +

Extra line

> +static int cscfg_add_preset_groups(struct cscfg_fs_config *cfg_view)
> +{
> +	int preset_num;
> +	struct cscfg_fs_preset *cfg_preset;
> +	struct cscfg_config_desc *cfg_desc = cfg_view->desc;
> +	char name[CONFIGFS_ITEM_NAME_LEN];
> +
> +	if (!cfg_desc->nr_presets)
> +		return 0;
> +
> +	for (preset_num = 1; preset_num <= cfg_desc->nr_presets; preset_num++) {
> +		cfg_preset = devm_kzalloc(to_device_cscfg(),
> +					  sizeof(struct cscfg_fs_config), GFP_KERNEL);
> +
> +		if (!cfg_preset)
> +			return -ENOMEM;
> +
> +		snprintf(name, CONFIGFS_ITEM_NAME_LEN, "preset%d", preset_num);
> +		cfg_preset->preset_num = preset_num;
> +		cfg_preset->desc = cfg_view->desc;
> +		config_group_init_type_name(&cfg_preset->group, name,
> +					    &cscfg_config_preset_type);
> +		configfs_add_default_group(&cfg_preset->group, &cfg_view->group);
> +	}
> +	return 0;
> +}
> +
> +static struct config_group *cscfg_create_config_group(struct cscfg_config_desc *cfg_desc)
> +{
> +	struct cscfg_fs_config *cfg_view;
> +	struct device *dev = to_device_cscfg();
> +	int err;
> +
> +	if (!dev)
> +		return ERR_PTR(-EINVAL);
> +
> +	cfg_view = devm_kzalloc(dev, sizeof(struct cscfg_fs_config), GFP_KERNEL);
> +	if (!cfg_view)
> +		return ERR_PTR(-ENOMEM);
> +
> +	cfg_view->desc = cfg_desc;
> +	config_group_init_type_name(&cfg_view->group, cfg_desc->name, &cscfg_config_view_type);
> +
> +	/* add in a preset<n> dir for each preset */
> +	err = cscfg_add_preset_groups(cfg_view);
> +	if (err)
> +		return ERR_PTR(err);
> +
> +	return &cfg_view->group;
> +}
> +
> +/* attributes for features view */
> +
> +static ssize_t cscfg_feat_description_show(struct config_item *item, char *page)
> +{
> +	struct cscfg_fs_feature *fs_feat = container_of(to_config_group(item),
> +							struct cscfg_fs_feature, group);
> +
> +	return scnprintf(page, PAGE_SIZE, "%s\n", fs_feat->desc->brief);
> +}
> +CONFIGFS_ATTR_RO(cscfg_feat_, description);
> +
> +static ssize_t cscfg_feat_matches_show(struct config_item *item, char *page)
> +{
> +	struct cscfg_fs_feature *fs_feat = container_of(to_config_group(item),
> +							struct cscfg_fs_feature, group);
> +	u32 match_flags = fs_feat->desc->match_flags;
> +	int used = 0;
> +
> +	if (match_flags & CS_CFG_MATCH_CLASS_SRC_ALL)
> +		used = scnprintf(page, PAGE_SIZE, "SRC_ALL ");
> +
> +	if (match_flags & CS_CFG_MATCH_CLASS_SRC_ETM4)
> +		used += scnprintf(page + used, PAGE_SIZE - used, "SRC_ETMV4 ");
> +
> +	used += scnprintf(page + used, PAGE_SIZE - used, "\n");
> +	return used;
> +}
> +CONFIGFS_ATTR_RO(cscfg_feat_, matches);
> +
> +static ssize_t cscfg_feat_nr_params_show(struct config_item *item, char *page)
> +{
> +	struct cscfg_fs_feature *fs_feat = container_of(to_config_group(item),
> +							struct cscfg_fs_feature, group);
> +
> +	return scnprintf(page, PAGE_SIZE, "%d\n", fs_feat->desc->nr_params);
> +}
> +CONFIGFS_ATTR_RO(cscfg_feat_, nr_params);
> +
> +/* base feature desc attrib structures */
> +static struct configfs_attribute *cscfg_feature_view_attrs[] = {
> +	&cscfg_feat_attr_description,
> +	&cscfg_feat_attr_matches,
> +	&cscfg_feat_attr_nr_params,
> +	NULL,
> +};
> +
> +static struct config_item_type cscfg_feature_view_type = {
> +	.ct_owner = THIS_MODULE,
> +	.ct_attrs = cscfg_feature_view_attrs,
> +};
> +
> +static ssize_t cscfg_param_value_show(struct config_item *item, char *page)
> +{
> +	struct cscfg_fs_param *param_item = container_of(to_config_group(item),
> +							 struct cscfg_fs_param, group);
> +	int param_idx = param_item->param_idx;
> +	struct cscfg_feature_desc *desc = param_item->desc;
> +
> +	return scnprintf(page, PAGE_SIZE, "0x%llx\n", desc->params[param_idx].value);
> +}
> +
> +static ssize_t cscfg_param_value_store(struct config_item *item,
> +				       const char *page, size_t size)
> +{
> +	struct cscfg_fs_param *param_item = container_of(to_config_group(item),
> +							 struct cscfg_fs_param, group);
> +	struct cscfg_feature_desc *desc = param_item->desc;
> +	int param_idx = param_item->param_idx;
> +	u64 val;
> +	int err;
> +
> +	err = kstrtoull(page, 0, &val);
> +	if (!err)
> +		err = cscfg_update_feat_param_val(desc, param_idx, val);
> +
> +	return err ? err : size;
> +}
> +CONFIGFS_ATTR(cscfg_param_, value);
> +
> +static struct configfs_attribute *cscfg_param_view_attrs[] = {
> +	&cscfg_param_attr_value,
> +	NULL,
> +};
> +
> +static struct config_item_type cscfg_param_view_type = {
> +	.ct_owner = THIS_MODULE,
> +	.ct_attrs = cscfg_param_view_attrs,
> +};
> +
> +/*
> + * configfs has far less functionality provided to add attributes dynamically than sysfs,
> + * and the show and store fns pass the enclosing config_item so the actual attribute cannot
> + * be determined. Therefore we add each item as a group directory, with a value attribute.
> + */
> +static int cscfg_create_params_group_items(struct cscfg_feature_desc *feat_desc,
> +					   struct config_group *params_group)
> +{
> +	struct device *dev = to_device_cscfg();
> +	struct cscfg_fs_param *param_item;
> +	int i;
> +
> +	/* parameter items - as groups with default_value attribute */
> +	for (i = 0; i < feat_desc->nr_params; i++) {
> +		param_item = devm_kzalloc(dev, sizeof(struct cscfg_fs_param), GFP_KERNEL);
> +		if (!param_item)
> +			return -ENOMEM;
> +		param_item->desc = feat_desc;
> +		param_item->param_idx = i;
> +		config_group_init_type_name(&param_item->group, feat_desc->params[i].name,
> +					    &cscfg_param_view_type);
> +		configfs_add_default_group(&param_item->group, params_group);
> +	}
> +	return 0;
> +}
> +
> +static struct config_group *cscfg_create_feature_group(struct cscfg_feature_desc *feat_desc)
> +{
> +	struct cscfg_fs_feature *feat_view;
> +	struct config_item_type *params_group_type;
> +	struct config_group *params_group = NULL;
> +	struct device *dev = to_device_cscfg();
> +	int item_err;
> +
> +	if (!dev)
> +		return ERR_PTR(-EINVAL);
> +
> +	feat_view = devm_kzalloc(dev, sizeof(struct cscfg_fs_feature), GFP_KERNEL);
> +	if (!feat_view)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (feat_desc->nr_params) {
> +		params_group = devm_kzalloc(dev, sizeof(struct config_group), GFP_KERNEL);
> +		if (!params_group)
> +			return ERR_PTR(-ENOMEM);
> +
> +		params_group_type = cscfg_create_ci_type();
> +		if (!params_group_type)
> +			return ERR_PTR(-ENOMEM);
> +	}
> +
> +	feat_view->desc = feat_desc;
> +	config_group_init_type_name(&feat_view->group,
> +				    feat_desc->name,
> +				    &cscfg_feature_view_type);
> +	if (params_group) {
> +		config_group_init_type_name(params_group, "params", params_group_type);
> +		configfs_add_default_group(params_group, &feat_view->group);
> +		item_err = cscfg_create_params_group_items(feat_desc, params_group);
> +		if (item_err)
> +			return ERR_PTR(item_err);
> +	}
> +	return &feat_view->group;
> +}
> +
> +static struct config_item_type cscfg_configs_type = {
> +	.ct_owner = THIS_MODULE,
> +};
> +
> +static struct config_group cscfg_configs_grp = {
> +	.cg_item = {
> +		.ci_namebuf = "configurations",
> +		.ci_type = &cscfg_configs_type,
> +	},
> +};
> +
> +/* add configuration to configurations group */
> +int cscfg_configfs_add_config(struct cscfg_config_desc *cfg_desc)
> +{
> +	struct config_group *new_group;
> +	int err;
> +
> +	new_group = cscfg_create_config_group(cfg_desc);
> +	if (IS_ERR(new_group))
> +		return PTR_ERR(new_group);
> +	err =  configfs_register_group(&cscfg_configs_grp, new_group);
> +	return err;
> +}
> +
> +static struct config_item_type cscfg_features_type = {
> +	.ct_owner = THIS_MODULE,
> +};
> +
> +static struct config_group cscfg_features_grp = {
> +	.cg_item = {
> +		.ci_namebuf = "features",
> +		.ci_type = &cscfg_features_type,
> +	},
> +};
> +
> +/* add feature to features group */
> +int cscfg_configfs_add_feature(struct cscfg_feature_desc *feat_desc)
> +{
> +	struct config_group *new_group;
> +	int err;
> +
> +	new_group = cscfg_create_feature_group(feat_desc);
> +	if (IS_ERR(new_group))
> +		return PTR_ERR(new_group);
> +	err =  configfs_register_group(&cscfg_features_grp, new_group);
> +	return err;
> +}
> +
> +int cscfg_configfs_init(struct cscfg_manager *cscfg_mgr)
> +{
> +	struct configfs_subsystem *subsys;
> +	struct config_item_type *ci_type;
> +
> +	if (!cscfg_mgr)
> +		return -EINVAL;
> +
> +	ci_type = cscfg_create_ci_type();
> +	if (!ci_type)
> +		return -ENOMEM;
> +
> +	subsys = &cscfg_mgr->cfgfs_subsys;
> +	config_item_set_name(&subsys->su_group.cg_item, CSCFG_FS_SUBSYS_NAME);
> +	subsys->su_group.cg_item.ci_type = ci_type;
> +
> +	config_group_init(&subsys->su_group);
> +	mutex_init(&subsys->su_mutex);
> +
> +	/* Add default groups to subsystem */
> +	config_group_init(&cscfg_configs_grp);
> +	configfs_add_default_group(&cscfg_configs_grp, &subsys->su_group);
> +
> +	config_group_init(&cscfg_features_grp);
> +	configfs_add_default_group(&cscfg_features_grp, &subsys->su_group);
> +
> +	return configfs_register_subsystem(subsys);
> +}
> +
> +void cscfg_configfs_release(struct cscfg_manager *cscfg_mgr)
> +{
> +	configfs_unregister_subsystem(&cscfg_mgr->cfgfs_subsys);
> +}
> diff --git a/drivers/hwtracing/coresight/coresight-syscfg-configfs.h b/drivers/hwtracing/coresight/coresight-syscfg-configfs.h
> new file mode 100644
> index 000000000000..5e49819b80fc
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-syscfg-configfs.h
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Coresight system configuration driver - support for configfs.
> + */
> +
> +#ifndef CORESIGHT_SYSCFG_CONFIGFS_H
> +#define CORESIGHT_SYSCFG_CONFIGFS_H
> +
> +#include <linux/configfs.h>
> +#include "coresight-syscfg.h"
> +
> +#define CSCFG_FS_SUBSYS_NAME "coresight-syscfg"

We have cs_etm under /sys/bus/events/device/.  Would it make sense to call this
cs-syscfg?

> +
> +/* container for configuration view */
> +struct cscfg_fs_config {
> +	struct cscfg_config_desc *desc;
> +	struct config_group group;
> +};
> +
> +/* container for feature view */
> +struct cscfg_fs_feature {
> +	struct cscfg_feature_desc *desc;
> +	struct config_group group;
> +};
> +
> +/* container for parameter view */
> +struct cscfg_fs_param {
> +	int param_idx;
> +	struct cscfg_feature_desc *desc;
> +	struct config_group group;
> +};
> +
> +/* container for preset view */
> +struct cscfg_fs_preset {
> +	int preset_num;
> +	struct cscfg_config_desc *desc;
> +	struct config_group group;
> +};
> +
> +int cscfg_configfs_init(struct cscfg_manager *cscfg_mgr);
> +void cscfg_configfs_release(struct cscfg_manager *cscfg_mgr);
> +int cscfg_configfs_add_config(struct cscfg_config_desc *cfg_desc);
> +int cscfg_configfs_add_feature(struct cscfg_feature_desc *feat_desc);
> +
> +#endif /* CORESIGHT_SYSCFG_CONFIGFS_H */
> diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
> index d79cf5b36758..c0707c31fc31 100644
> --- a/drivers/hwtracing/coresight/coresight-syscfg.c
> +++ b/drivers/hwtracing/coresight/coresight-syscfg.c
> @@ -9,6 +9,7 @@
>  #include "coresight-config.h"
>  #include "coresight-etm-perf.h"
>  #include "coresight-syscfg.h"
> +#include "coresight-syscfg-configfs.h"
>  
>  /*
>   * cscfg_ API manages configurations and features for the entire coresight
> @@ -302,6 +303,70 @@ static int cscfg_load_config(struct cscfg_config_desc *cfg_desc)
>  	return 0;
>  }
>  
> +/* get a feature descriptor by name */
> +const struct cscfg_feature_desc *cscfg_get_named_feat_desc(const char *name)
> +{
> +	const struct cscfg_feature_desc *feat = NULL, *feat_item;
> +
> +	mutex_lock(&cscfg_mutex);
> +
> +	list_for_each_entry(feat_item, &cscfg_mgr->data.feat_desc_list, item) {
> +		if (strcmp(feat_item->name, name) == 0) {
> +			feat = feat_item;
> +			break;
> +		}
> +	}
> +
> +	mutex_unlock(&cscfg_mutex);
> +	return feat;
> +}
> +
> +static struct cscfg_feature_csdev *
> +cscfg_csdev_get_feat_from_desc(struct coresight_device *csdev,
> +			       struct cscfg_feature_desc *feat_desc)
> +{
> +	struct cscfg_feature_csdev *feat_csdev = NULL, *item;
> +
> +	list_for_each_entry(item, &csdev->feature_csdev_list, node) {
> +		if (item->desc == feat_desc) {
> +			feat_csdev = item;
> +			break;
> +		}
> +	}
> +	return feat_csdev;
> +}
> +
> +int cscfg_update_feat_param_val(struct cscfg_feature_desc *feat_desc,
> +				int param_idx, u64 value)
> +{
> +	int err = 0;
> +	struct cscfg_feature_csdev *feat_csdev;
> +	struct cscfg_csdev_register *item;
> +
> +	mutex_lock(&cscfg_mutex);
> +
> +	/* check if any config active & return busy */
> +	if (atomic_read(&cscfg_mgr->data.sys_active_cnt)) {
> +		err = -EBUSY;
> +		goto unlock_exit;
> +	}
> +
> +	/* set the value */
> +	feat_desc->params[param_idx].value = value;
> +
> +	/* update loaded instances.*/
> +	list_for_each_entry(item, &cscfg_mgr->data.csdev_desc_list, item) {
> +		feat_csdev = cscfg_csdev_get_feat_from_desc(item->csdev, feat_desc);
> +		if (feat_csdev)
> +			feat_csdev->params[param_idx].current_value = value;
> +	}
> +
> +unlock_exit:
> +	mutex_unlock(&cscfg_mutex);
> +	return err;
> +}
> +
> +

Extra line

>  /*
>   * External API function to load feature and config sets.
>   * Take a 0 terminated array of feature descriptors and/or configuration
> @@ -324,6 +389,7 @@ int cscfg_load_config_sets(struct cscfg_config_desc **cfg_descs,
>  				       feat_descs[i]->name);
>  				goto do_unlock;
>  			}
> +			cscfg_configfs_add_feature(feat_descs[i]);
>  			i++;
>  		}
>  	}
> @@ -338,6 +404,7 @@ int cscfg_load_config_sets(struct cscfg_config_desc **cfg_descs,
>  				       cfg_descs[i]->name);
>  				goto do_unlock;
>  			}
> +			cscfg_configfs_add_config(cfg_descs[i]);
>  			i++;
>  		}
>  	}
> @@ -613,6 +680,7 @@ struct device *to_device_cscfg(void)
>  /* Must have a release function or the kernel will complain on module unload */
>  void cscfg_dev_release(struct device *dev)
>  {
> +	cscfg_configfs_release(cscfg_mgr);
>  	kfree(cscfg_mgr);
>  	cscfg_mgr = NULL;
>  }
> @@ -639,6 +707,7 @@ int cscfg_create_device(void)
>  	dev->init_name = "system_cfg";
>  
>  	err = device_register(dev);
> +

Extra line

I have run out of time for this patchset.  Please spin off another revision and
we'll go from there.  

The core of the feature works and I think we should move forward with it.

Thanks,
Mathieu

>  	if (err)
>  		cscfg_dev_release(dev);
>  
> @@ -668,6 +737,10 @@ int __init cscfg_init(void)
>  	if (err)
>  		return err;
>  
> +	err = cscfg_configfs_init(cscfg_mgr);
> +	if (err)
> +		goto exit_dev_clear;
> +
>  	INIT_LIST_HEAD(&cscfg_mgr->data.csdev_desc_list);
>  	INIT_LIST_HEAD(&cscfg_mgr->data.feat_desc_list);
>  	INIT_LIST_HEAD(&cscfg_mgr->data.config_desc_list);
> @@ -676,6 +749,10 @@ int __init cscfg_init(void)
>  
>  	dev_info(to_device_cscfg(), "CoreSight Configuration manager initialised");
>  	return 0;
> +
> +exit_dev_clear:
> +	cscfg_clear_device();
> +	return err;
>  }
>  
>  void __exit cscfg_exit(void)
> diff --git a/drivers/hwtracing/coresight/coresight-syscfg.h b/drivers/hwtracing/coresight/coresight-syscfg.h
> index a8a6b21315d8..62700e4e9e05 100644
> --- a/drivers/hwtracing/coresight/coresight-syscfg.h
> +++ b/drivers/hwtracing/coresight/coresight-syscfg.h
> @@ -6,6 +6,7 @@
>  #ifndef CORESIGHT_SYSCFG_H
>  #define CORESIGHT_SYSCFG_H
>  
> +#include <linux/configfs.h>
>  #include <linux/coresight.h>
>  #include <linux/device.h>
>  
> @@ -48,6 +49,10 @@ struct cscfg_csdev_register {
>  int __init cscfg_init(void);
>  void __exit cscfg_exit(void);
>  int cscfg_preload(void);
> +const struct cscfg_feature_desc *cscfg_get_named_feat_desc(const char *name);
> +int cscfg_update_feat_param_val(struct cscfg_feature_desc *feat_desc,
> +				int param_idx, u64 value);
> +
>  
>  /* syscfg manager external API */
>  int cscfg_load_config_sets(struct cscfg_config_desc **cfg_descs,
> @@ -71,10 +76,12 @@ void cscfg_csdev_disable_active_config(struct coresight_device *csdev);
>   *
>   * @dev:	The device.
>   * @data:	The API data.
> + * @cfgfs_subsys: configfs subsystem used to manage configurations.
>   */
>  struct cscfg_manager {
>  	struct device dev;
>  	struct cscfg_api_data data;
> +	struct configfs_subsystem cfgfs_subsys;
>  };
>  
>  /* get reference to dev in cscfg_manager */
> -- 
> 2.17.1
> 
