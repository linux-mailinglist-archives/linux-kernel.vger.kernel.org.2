Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5A2632D1BD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 12:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239628AbhCDL0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 06:26:31 -0500
Received: from foss.arm.com ([217.140.110.172]:37008 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235242AbhCDL03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 06:26:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82CC031B;
        Thu,  4 Mar 2021 03:25:43 -0800 (PST)
Received: from [10.57.63.81] (unknown [10.57.63.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D398D3F7D7;
        Thu,  4 Mar 2021 03:25:40 -0800 (PST)
Subject: Re: [PATCH v4 03/10] coresight: config: Add configuration and feature
 generic functions
To:     Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, linux-doc@vger.kernel.org
Cc:     yabinc@google.com, corbet@lwn.net, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, tingwei@codeaurora.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
References: <20210128170936.9222-1-mike.leach@linaro.org>
 <20210128170936.9222-4-mike.leach@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <820d8330-abd3-d973-faa8-a4914864626a@arm.com>
Date:   Thu, 4 Mar 2021 11:25:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210128170936.9222-4-mike.leach@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/21 5:09 PM, Mike Leach wrote:
> Adds a set of generic support functions that allow devices to set and save
> features values on the device, and enable and disable configurations.
> 
> Additional functions for other common operations including feature
> reset.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---
>   drivers/hwtracing/coresight/Makefile          |   2 +-
>   .../hwtracing/coresight/coresight-config.c    | 245 ++++++++++++++++++
>   .../hwtracing/coresight/coresight-config.h    |  14 +-
>   .../hwtracing/coresight/coresight-syscfg.c    |   5 +-
>   4 files changed, 262 insertions(+), 4 deletions(-)
>   create mode 100644 drivers/hwtracing/coresight/coresight-config.c
> 
> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> index 4ce854c434b1..daad9f103a78 100644
> --- a/drivers/hwtracing/coresight/Makefile
> +++ b/drivers/hwtracing/coresight/Makefile
> @@ -4,7 +4,7 @@
>   #
>   obj-$(CONFIG_CORESIGHT) += coresight.o
>   coresight-y := coresight-core.o  coresight-etm-perf.o coresight-platform.o \
> -		coresight-sysfs.o coresight-syscfg.o
> +		coresight-sysfs.o coresight-syscfg.o coresight-config.o
>   obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o
>   coresight-tmc-y := coresight-tmc-core.o coresight-tmc-etf.o \
>   		      coresight-tmc-etr.o
> diff --git a/drivers/hwtracing/coresight/coresight-config.c b/drivers/hwtracing/coresight/coresight-config.c
> new file mode 100644
> index 000000000000..6cc4b213d9b6
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-config.c
> @@ -0,0 +1,245 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright(C) 2020 Linaro Limited. All rights reserved.
> + * Author: Mike Leach <mike.leach@linaro.org>

It may be good to add a one-or-two line summary of what this file is
all about in general.

> + */
> +
> +#include <linux/sysfs.h>
> +#include "coresight-config.h"
> +#include "coresight-priv.h"
> +
> +/*
> + * Write the value held in the register structure into the driver internal memory
> + * location.
> + */
> +static void cscfg_set_reg(struct cscfg_reg_csdev *reg)
> +{
> +	u32 *p_val32 = (u32 *)reg->drv_store;

Could we rename drv_store to something slightly more intuitive ?
reg->cache ? or reg->current_val ?

> +	u32 tmp32 = reg->value.val32;
> +
> +	if (reg->value.type & CS_CFG_REG_TYPE_VAL_64BIT) {
> +		*((u64 *)reg->drv_store) = reg->value.val64;
> +		return;
> +	}
> +
> +	if (reg->value.type & CS_CFG_REG_TYPE_VAL_MASK) {
> +		tmp32 = *p_val32;
> +		tmp32 &= ~reg->value.mask32;
> +		tmp32 |= reg->value.val32 & reg->value.mask32;
> +	}
> +	*p_val32 = tmp32;
> +}
> +
> +/*
> + * Read the driver value into the reg if this is marked as one we want to save.
> + */
> +static void cscfg_save_reg(struct cscfg_reg_csdev *reg)
> +{
> +	if (!(reg->value.type & CS_CFG_REG_TYPE_VAL_SAVE))
> +		return;
> +	if (reg->value.type & CS_CFG_REG_TYPE_VAL_64BIT)
> +		reg->value.val64 = *(u64 *)(reg->drv_store);
> +	else
> +		reg->value.val32 = *(u32 *)(reg->drv_store);
> +}
> +
> +static void cscfg_init_reg_param(struct cscfg_parameter_csdev *param_csdev,
> +				 struct cscfg_reg_csdev *reg_csdev)
> +{
> +	param_csdev->reg = reg_csdev;
> +	param_csdev->val64 = reg_csdev->value.type & CS_CFG_REG_TYPE_VAL_64BIT;
> +
> +	if (param_csdev->val64)
> +		param_csdev->reg->value.val64 = param_csdev->current_value;
> +	else
> +		param_csdev->reg->value.val32 = (u32)param_csdev->current_value;
> +}
> +
> +/* set values into the driver locations referenced in cscfg_reg_csdev */
> +static int cscfg_set_on_enable(struct cscfg_feature_csdev *feat)
> +{
> +	int i;
> +
> +	spin_lock(feat->csdev_spinlock);
> +	for (i = 0; i < feat->nr_regs; i++)
> +		cscfg_set_reg(&feat->regs[i]);
> +	spin_unlock(feat->csdev_spinlock);
> +	dev_dbg(&feat->csdev->dev, "Feature %s: %s", feat->desc->name, "set on enable");
> +	return 0;
> +}
> +
> +/* copy back values from the driver locations referenced in cscfg_reg_csdev */
> +static void cscfg_save_on_disable(struct cscfg_feature_csdev *feat)
> +{
> +	int i;
> +
> +	spin_lock(feat->csdev_spinlock);
> +	for (i = 0; i < feat->nr_regs; i++)
> +		cscfg_save_reg(&feat->regs[i]);
> +	spin_unlock(feat->csdev_spinlock);
> +	dev_dbg(&feat->csdev->dev, "Feature %s: %s", feat->desc->name, "save on disable");
> +}
> +
> +/* default reset - restore default values */
> +void cscfg_reset_feat(struct cscfg_feature_csdev *feat)
> +{
> +	struct cscfg_parameter_csdev *param_csdev;
> +	struct cscfg_regval_desc *reg_desc;
> +	struct cscfg_reg_csdev *reg_csdev;
> +	int i;
> +
> +	/*
> +	 * set the default values for all parameters and regs from the
> +	 * relevant static descriptors.
> +	 */
> +	for (i = 0; i < feat->nr_params; i++)
> +		feat->params[i].current_value = feat->desc->params[i].value;
> +
> +	for (i = 0; i < feat->nr_regs; i++) {
> +		reg_desc = &feat->desc->regs[i];
> +		reg_csdev = &feat->regs[i];
> +		reg_csdev->value.type = reg_desc->type;
> +
> +		/* check if reg set from a parameter otherwise desc default */
> +		if (reg_desc->type & CS_CFG_REG_TYPE_VAL_PARAM) {
> +			/* for param, reg_desc->val32 is an index */

> +			param_csdev = &feat->params[reg_desc->val32];

Please add val32 to a union, as suggested in response to Patch 1. Also, please make
sure the idx is within the nr_params range. I suggest move this into cscfg_init_reg_param
and have this contained there.

> +			cscfg_init_reg_param(param_csdev, reg_csdev);
> +		} else
> +			reg_csdev->value.val64 = reg_desc->val64;
> +	}
> +}
> +
> +static int cscfg_update_presets(struct cscfg_config_csdev *cfg, int preset)
> +{
> +	int i, j, line_offset = 0, val_idx = 0, max_idx;
> +	struct cscfg_parameter_csdev *param;
> +	struct cscfg_feature_csdev *feat;
> +	const char *name;
> +	u64 val;
> +
> +	if (preset > cfg->desc->nr_presets)
> +		return -EINVAL;
> +	/*
> +	 * Go through the array of features, assigning preset values to
> +	 * feature parameters in the order they appear.
> +	 * There should be precisely the same number of preset values as the
> +	 * sum of number of parameters over all the features - but we will
> +	 * ensure there is no overrun.
> +	 */
> +	line_offset = (preset-1) * cfg->desc->nr_total_params;

Could we instead do :

	u64 *preset_base = &cfg->desc->presets[ (preset - 1) * cfg->desc->nr_total_params];


> +	max_idx = cfg->desc->nr_total_params;

s/max_idx/n_params/
s/val_idx/param_idx/

> +	for (i = 0; i < cfg->nr_feat; i++) {
> +		feat = cfg->feats[i];
> +		if (!feat->nr_params)
> +			continue;
> +
> +		for (j = 0; j < feat->nr_params; j++) {
> +			param = &feat->params[j];
> +			name = feat->desc->params[j].name;
> +			val = cfg->desc->presets[line_offset + val_idx++];

			val = preset_base[val_idx++];

> +			if (param->val64) {
> +				dev_dbg(&cfg->csdev->dev,
> +					"set param %s (%lld)", name, val);
> +				param->reg->value.val64 = val;
> +			} else {
> +				param->reg->value.val32 = (u32)val;
> +				dev_dbg(&cfg->csdev->dev,
> +					"set param %s (%d)", name, (u32)val);
> +			}
> +			if (val_idx >= max_idx)
> +				break;
> +		}
> +
> +		/* don't overrun the preset array line */
> +		if (val_idx >= max_idx)
> +			break;

Isn't that an error if we overrun the nr_parameters ? And should we WARN about it ?

> +	}
> +	return 0;
> +}
> +
> +/*
> + * if we are not using a preset, then need to update the feature params
> + * with current values.
> + */
> +static int cscfg_update_curr_params(struct cscfg_config_csdev *cfg)

minor nit: cscfg_sync_params() ?
> +{
> +	int i, j;
> +	struct cscfg_feature_csdev *feat;
> +	struct cscfg_parameter_csdev *param;
> +	const char *name;
> +	u64 val;
> +
> +	for (i = 0; i < cfg->nr_feat; i++) {
> +		feat = cfg->feats[i];
> +		if (!feat->nr_params)
> +			continue;
> +		for (j = 0; j < feat->nr_params; j++) {
> +			param = &feat->params[j];
> +			name = feat->desc->params[j].name;
> +			val = param->current_value;
> +			if (param->val64) {
> +				dev_dbg(&cfg->csdev->dev,
> +					"set param %s (%lld)", name, val);
> +				param->reg->value.val64 = val;
> +			} else {
> +				param->reg->value.val32 = (u32)val;
> +				dev_dbg(&cfg->csdev->dev,
> +					"set param %s (%d)", name, (u32)val);
> +			}
> +		}
> +	}
> +	return 0;
> +}
> +
> +static int cscfg_prog_config(struct cscfg_config_csdev *cfg, bool enable)

minor nit: cscfg_update_config() ?

> +{
> +	int i, err = 0;
> +	struct cscfg_feature_csdev *feat;
> +	struct coresight_device *csdev;
> +
> +	for (i = 0; i < cfg->nr_feat; i++) {
> +		feat = cfg->feats[i];
> +		csdev = feat->csdev;
> +		dev_dbg(&csdev->dev, "cfg %s;  %s feature:%s", cfg->desc->name,
> +			enable ? "enable" : "disable", feat->desc->name);
> +
> +		if (enable)
> +			err = cscfg_set_on_enable(feat);
> +		else
> +			cscfg_save_on_disable(feat);
> +
> +		if (err)
> +			break;
> +	}
> +	return err;
> +}
> +
> +/**
> + * Enable configuration for the device.
> + *
> + * @cfg:	config_csdev to set.
> + * @preset:	preset values to use - 0 for default.
> + */
> +int cscfg_csdev_enable_config(struct cscfg_config_csdev *cfg, int preset)
> +{
> +	int err = 0;
> +
> +	if (preset)
> +		err = cscfg_update_presets(cfg, preset);
> +	else
> +		err = cscfg_update_curr_params(cfg);
> +	if (!err)
> +		err = cscfg_prog_config(cfg, true);
> +	if (!err)
> +		cfg->enabled = true;
> +	return err;
> +}
> +
> +void cscfg_csdev_disable_config(struct cscfg_config_csdev *cfg)
> +{
> +	if (cfg->enabled) {
> +		cscfg_prog_config(cfg, false);
> +		cfg->enabled = false;
> +	}
> +}
> diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwtracing/coresight/coresight-config.h
> index 75ecdecf7013..9d66e0071f38 100644
> --- a/drivers/hwtracing/coresight/coresight-config.h
> +++ b/drivers/hwtracing/coresight/coresight-config.h
> @@ -53,7 +53,10 @@ struct cscfg_parameter_desc {
>   };
>   
>   /**
> - * Representation of register value.
> + * Representation of register value and a descriptor of register usage.
> + *
> + * Used as a descriptor in the feature descriptors.
> + * Used as a value in when in a feature loading into a csdev.
>    *
>    * Supports full 64 bit register value, or 32 bit value with optional mask
>    * value.
> @@ -262,4 +265,13 @@ struct cscfg_csdev_feat_ops {
>   			 struct cscfg_feature_csdev *feat);
>   };
>   
> +/* coresight config helper functions*/
> +
> +/* enable / disable config on a device - called with appropriate locks set.*/
> +int cscfg_csdev_enable_config(struct cscfg_config_csdev *cfg, int preset);
> +void cscfg_csdev_disable_config(struct cscfg_config_csdev *cfg);
> +
> +/* reset a feature to default values */
> +void cscfg_reset_feat(struct cscfg_feature_csdev *feat);
> +
>   #endif /* _CORESIGHT_CORESIGHT_CONFIG_H */
> diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
> index c04cea0c1db2..4b8e4e35e3e7 100644
> --- a/drivers/hwtracing/coresight/coresight-syscfg.c
> +++ b/drivers/hwtracing/coresight/coresight-syscfg.c
> @@ -198,14 +198,15 @@ static int cscfg_load_feat_csdev(struct coresight_device *csdev,
>   	if (!feat_csdev)
>   		return -ENOMEM;
>   
> -	/* load the feature into the device - may modify default ops*/

Spurious change ?

> +	/* load the feature into the device */
>   	err = ops->load_feat(csdev, feat_csdev);
>   	if (err)
>   		return err;
>   
> -	/* add to internal csdev feature list */
> +	/* add to internal csdev feature list & initialise using reset call */
>   	mutex_lock(&cscfg_csdev_mutex);
>   	list_add(&feat_csdev->node, &csdev->feature_csdev_list);
> +	cscfg_reset_feat(feat_csdev);
>   	mutex_unlock(&cscfg_csdev_mutex);
>   
>   	return 0;
> 

Suzuki

