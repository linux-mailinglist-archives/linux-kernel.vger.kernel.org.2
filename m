Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE91327529
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 00:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhB1XTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 18:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbhB1XTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 18:19:44 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B3BC061756
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 15:19:04 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id l18so10477456pji.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 15:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=us9+mymX7jX6azGLgvg8D7ife9PX0I0CSa9deFoFZGQ=;
        b=TIJfcUaQubsnwrvHZlA9Tc/PcrVtGFmOoTDvei6RyKElHoSZ1XOeBHrdL1XVb3Ukoe
         dGPUda0jdf3eBKjabwJda/AQod5cs71qq6rRYQHa+ASflHACfwv4g4DxOpcutgzKDW62
         s/9mcXolm0ks1BRyIV5dcrNQfC9LT5Gug9VE/c9lu46T8nGbG2UrnkwePpz0xkJpQlO7
         y28aZ4gakMO3SJF9idKl0dtyit/803xgYgRK+5ug4G8E6rHXqohB2IHI5qHC/gwCb73R
         fYczWZqYnzQfKBRYiXvvPt6m2l0nb8oNt6x4OblmNpb0iiSurXGg7L9XAssaEMYNx44L
         WVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=us9+mymX7jX6azGLgvg8D7ife9PX0I0CSa9deFoFZGQ=;
        b=c1Wc3pXL8c8LZFUxd4u4gUtnMC5qIuHyezzwELt2bGtwZnryvxv4Eo3zRPetWtWbGz
         D9PjTuyM0VVbj2+2gtB+WnB4jHoB9cvVTTL/rPL2ltz9pqtT87qE4NR4WLoDItRWZYAp
         WMsV7YyK2EEoTb1u+fAdkAVGP20yPJlH0qa0Vu6n3Qmvs0NnH3dencHr+KudrNsgzHia
         zMwM9VaRSWenndMfbHb7CSOqBwvn3ril32aygvMvkCjh6iJQ4SvVWD5ttVDvKiQzJuAj
         elmPb5Z/uOoMfva8ZMhLEPIfclGkbuAOlBHqLbAkUOIYKHdNtgzwm7Wq8/SEnFGXH/Zs
         8sZw==
X-Gm-Message-State: AOAM530zhZWDkpoGnTKixtTV51Slg/igRruAYp17pGs4S0Gu5evSn+cE
        ZUW8r4Xow2ad/yZdxZKZFuEdhg==
X-Google-Smtp-Source: ABdhPJxQlN2Q+imrmG0j/9WjSZT0yiD0GHnvT+U9VuV1i33lM0w/q0exxd+yYwtPCyJWufbvYPzhgQ==
X-Received: by 2002:a17:902:e810:b029:de:45bf:1232 with SMTP id u16-20020a170902e810b02900de45bf1232mr12902884plg.59.1614554343572;
        Sun, 28 Feb 2021 15:19:03 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id ge16sm2052294pjb.43.2021.02.28.15.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 15:19:02 -0800 (PST)
Date:   Sun, 28 Feb 2021 16:19:00 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-doc@vger.kernel.org, suzuki.poulose@arm.com,
        yabinc@google.com, corbet@lwn.net, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, tingwei@codeaurora.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 07/10] coresight: etm4x: Add complex configuration
 handlers to etmv4
Message-ID: <20210228231900.GB3631443@xps15>
References: <20210128170936.9222-1-mike.leach@linaro.org>
 <20210128170936.9222-8-mike.leach@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128170936.9222-8-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 05:09:33PM +0000, Mike Leach wrote:
> Adds in handlers to allow the ETMv4 to use the complex configuration
> support. Features and configurations can be loaded and selected in the
> device.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---
>  drivers/hwtracing/coresight/Makefile          |   3 +-
>  .../hwtracing/coresight/coresight-etm4x-cfg.c | 184 ++++++++++++++++++
>  .../hwtracing/coresight/coresight-etm4x-cfg.h |  29 +++
>  .../coresight/coresight-etm4x-core.c          |  38 +++-
>  .../coresight/coresight-etm4x-sysfs.c         |   3 +
>  5 files changed, 254 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/hwtracing/coresight/coresight-etm4x-cfg.c
>  create mode 100644 drivers/hwtracing/coresight/coresight-etm4x-cfg.h
> 
> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> index daad9f103a78..ea544206204d 100644
> --- a/drivers/hwtracing/coresight/Makefile
> +++ b/drivers/hwtracing/coresight/Makefile
> @@ -16,7 +16,8 @@ obj-$(CONFIG_CORESIGHT_SOURCE_ETM3X) += coresight-etm3x.o
>  coresight-etm3x-y := coresight-etm3x-core.o coresight-etm-cp14.o \
>  		     coresight-etm3x-sysfs.o
>  obj-$(CONFIG_CORESIGHT_SOURCE_ETM4X) += coresight-etm4x.o
> -coresight-etm4x-y := coresight-etm4x-core.o coresight-etm4x-sysfs.o
> +coresight-etm4x-y := coresight-etm4x-core.o coresight-etm4x-sysfs.o \
> +			coresight-etm4x-cfg.o
>  obj-$(CONFIG_CORESIGHT_STM) += coresight-stm.o
>  obj-$(CONFIG_CORESIGHT_CPU_DEBUG) += coresight-cpu-debug.o
>  obj-$(CONFIG_CORESIGHT_CATU) += coresight-catu.o
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-cfg.c b/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
> new file mode 100644
> index 000000000000..f237a8d02360
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
> @@ -0,0 +1,184 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright(C) 2020 Linaro Limited. All rights reserved.
> + * Author: Mike Leach <mike.leach@linaro.org>
> + */
> +
> +#include "coresight-etm4x.h"
> +#include "coresight-etm4x-cfg.h"
> +#include "coresight-priv.h"
> +#include "coresight-syscfg.h"
> +
> +/**
> + * etm4_cfg_map_reg_offset - validate and map the register offset into a
> + *			     location in the driver config struct.
> + *
> + * Limits the number of registers that can be accessed and programmed in
> + * features, to those which are used to control the trace capture parameters.
> + *
> + * Omits or limits access to those which the driver must use exclusively.
> + *
> + * Invalid offsets will result in fail code return and feature load failure.
> + *
> + * @drvdata:	driver data to map into.
> + * @reg:	register to map.
> + * @offset:	device offset for the register
> + */
> +static int etm4_cfg_map_reg_offset(struct etmv4_drvdata *drvdata,
> +				   struct cscfg_reg_csdev *reg, u32 offset)
> +{
> +	int err = -EINVAL, idx;
> +	struct etmv4_config *drvcfg = &drvdata->config;
> +	u32 off_mask;
> +
> +#define CHECKREG(cval, elem) \
> +	{ \
> +		if (offset == cval) { \
> +			reg->drv_store = &drvcfg->elem; \
> +			err = 0; \
> +			break; \
> +		} \
> +	}
> +
> +#define CHECKREGIDX(cval, elem, off_idx, mask)	\
> +	{ \
> +		if (mask == cval) { \
> +			reg->drv_store = &drvcfg->elem[off_idx]; \
> +			err = 0; \
> +			break; \
> +		} \
> +	}
> +
> +	if (((offset >= TRCEVENTCTL0R) && (offset <= TRCVIPCSSCTLR)) ||
> +	    ((offset >= TRCSEQRSTEVR) && (offset <= TRCEXTINSELR)) ||
> +	    ((offset >= TRCCIDCCTLR0) && (offset <= TRCVMIDCCTLR1))) {
> +		do {
> +			CHECKREG(TRCEVENTCTL0R, eventctrl0);
> +			CHECKREG(TRCEVENTCTL1R, eventctrl1);
> +			CHECKREG(TRCSTALLCTLR, stall_ctrl);
> +			CHECKREG(TRCTSCTLR, ts_ctrl);
> +			CHECKREG(TRCSYNCPR, syncfreq);
> +			CHECKREG(TRCCCCTLR, ccctlr);
> +			CHECKREG(TRCBBCTLR, bb_ctrl);
> +			CHECKREG(TRCVICTLR, vinst_ctrl);
> +			CHECKREG(TRCVIIECTLR, viiectlr);
> +			CHECKREG(TRCVISSCTLR, vissctlr);
> +			CHECKREG(TRCVIPCSSCTLR, vipcssctlr);
> +			CHECKREG(TRCSEQRSTEVR, seq_rst);
> +			CHECKREG(TRCSEQSTR, seq_state);
> +			CHECKREG(TRCEXTINSELR, ext_inp);
> +			CHECKREG(TRCCIDCCTLR0, ctxid_mask0);
> +			CHECKREG(TRCCIDCCTLR1, ctxid_mask1);
> +			CHECKREG(TRCVMIDCCTLR0, vmid_mask0);
> +			CHECKREG(TRCVMIDCCTLR1, vmid_mask1);
> +		} while (0);
> +	} else if ((offset & GENMASK(11, 4)) == TRCSEQEVRn(0)) {
> +		/* sequencer state control registers */
> +		idx = (offset & GENMASK(3, 0)) / 4;
> +		if (idx < ETM_MAX_SEQ_STATES) {
> +			reg->drv_store = &drvcfg->seq_ctrl[idx];
> +			err = 0;
> +		}
> +	} else if ((offset >= TRCSSCCRn(0)) && (offset <= TRCSSPCICRn(7))) {
> +		/* 32 bit, 8 off indexed register sets */
> +		idx = (offset & GENMASK(4, 0)) / 4;
> +		off_mask =  (offset & GENMASK(11, 5));
> +		do {
> +			CHECKREGIDX(TRCSSCCRn(0), ss_ctrl, idx, off_mask);
> +			CHECKREGIDX(TRCSSCSRn(0), ss_status, idx, off_mask);
> +			CHECKREGIDX(TRCSSPCICRn(0), ss_pe_cmp, idx, off_mask);
> +		} while (0);
> +	} else if ((offset >= TRCCIDCVRn(0)) && (offset <= TRCVMIDCVRn(7))) {
> +		/* 64 bit, 8 off indexed register sets */
> +		idx = (offset & GENMASK(5, 0)) / 8;
> +		off_mask = (offset & GENMASK(11, 6));
> +		do {
> +			CHECKREGIDX(TRCCIDCVRn(0), ctxid_pid, idx, off_mask);
> +			CHECKREGIDX(TRCVMIDCVRn(0), vmid_val, idx, off_mask);
> +		} while (0);
> +	} else if ((offset >= TRCRSCTLRn(2)) &&
> +		   (offset <= TRCRSCTLRn((ETM_MAX_RES_SEL - 1)))) {
> +		/* 32 bit resource selection regs, 32 off, skip fixed 0,1 */
> +		idx = (offset & GENMASK(6, 0)) / 4;
> +		if (idx < ETM_MAX_RES_SEL) {
> +			reg->drv_store = &drvcfg->res_ctrl[idx];
> +			err = 0;
> +		}
> +	} else if ((offset >= TRCACVRn(0)) &&
> +		   (offset <= TRCACATRn((ETM_MAX_SINGLE_ADDR_CMP - 1)))) {
> +		/* 64 bit addr cmp regs, 16 off */
> +		idx = (offset & GENMASK(6, 0)) / 8;
> +		off_mask = offset & GENMASK(11, 7);
> +		do {
> +			CHECKREGIDX(TRCACVRn(0), addr_val, idx, off_mask);
> +			CHECKREGIDX(TRCACATRn(0), addr_acc, idx, off_mask);
> +		} while (0);
> +	} else if ((offset >= TRCCNTRLDVRn(0)) &&
> +		   (offset <= TRCCNTVRn((ETMv4_MAX_CNTR - 1)))) {
> +		/* 32 bit counter regs, 4 off (ETMv4_MAX_CNTR - 1) */
> +		idx = (offset &  GENMASK(3, 0)) / 4;
> +		off_mask = offset &  GENMASK(11, 4);
> +		do {
> +			CHECKREGIDX(TRCCNTRLDVRn(0), cntrldvr, idx, off_mask);
> +			CHECKREGIDX(TRCCNTCTLRn(0), cntr_ctrl, idx, off_mask);
> +			CHECKREGIDX(TRCCNTVRn(0), cntr_val, idx, off_mask);
> +		} while (0);
> +	}
> +	return err;
> +}
> +
> +/**
> + * etm4_cfg_load_feature - load a feature into a device instance.
> + *
> + * @csdev:	An ETMv4 CoreSight device.
> + * @feat:	The feature to be loaded.
> + *
> + * The function will load a feature instance into the device, checking that
> + * the register definitions are valid for the device.
> + *
> + * Parameter and register definitions will be converted into internal
> + * structures that are used to set the values in the driver when the
> + * feature is enabled for the device.
> + *
> + * The feature spinlock pointer is initialised to the same spinlock
> + * that the driver uses to protect the internal register values.
> + */
> +static int etm4_cfg_load_feature(struct coresight_device *csdev,
> +				 struct cscfg_feature_csdev *feat)
> +{
> +	struct device *dev = csdev->dev.parent;
> +	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev);
> +	const struct cscfg_feature_desc *feat_desc = feat->desc;
> +	u32 offset;
> +	int i = 0, err = 0;
> +
> +	/*
> +	 * essential we set the device spinlock - this is used in the generic
> +	 * programming routines when copying values into the drvdata structures
> +	 * via the pointers setup in etm4_cfg_map_reg_offset().
> +	 */
> +	feat->csdev_spinlock = &drvdata->spinlock;
> +
> +	/* process the register descriptions */
> +	for (i = 0; i < feat->nr_regs && !err; i++) {
> +		offset = feat_desc->regs[i].offset;
> +		err = etm4_cfg_map_reg_offset(drvdata, &feat->regs[i], offset);
> +	}
> +	return err;
> +}
> +
> +/* match information when loading configurations */
> +#define CS_CFG_ETM4_MATCH_FLAGS	(CS_CFG_MATCH_CLASS_SRC_ALL | \
> +					 CS_CFG_MATCH_CLASS_SRC_ETM4)

Here the indentation is correct but not when the patch is applied.  Have another
look on your side but don't worry about it if things are aligned.

> +
> +int etm4_cscfg_register(struct coresight_device *csdev, const char *dev_name)
> +{
> +	struct cscfg_match_desc cfg_info;
> +	struct cscfg_csdev_feat_ops ops;
> +
> +	cfg_info.match_flags = CS_CFG_ETM4_MATCH_FLAGS;
> +
> +	ops.load_feat = &etm4_cfg_load_feature;
> +
> +	return cscfg_register_csdev(csdev, &cfg_info, &ops);
> +}
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-cfg.h b/drivers/hwtracing/coresight/coresight-etm4x-cfg.h
> new file mode 100644
> index 000000000000..9e279c5da55d
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-cfg.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2014-2015, The Linux Foundation. All rights reserved.
> + */
> +
> +#ifndef _CORESIGHT_CORESIGHT_ETM4X_CFG_H
> +#define _CORESIGHT_CORESIGHT_ETM4X_CFG_H

Shouldn't that be "_CORESIGHT_ETM4X_CFG_H" ?  The same denomination was used for
coresight-config.h but not coresight-syscfg.h...

> +
> +#include "coresight-config.h"
> +#include "coresight-etm4x.h"
> +
> +/* ETMv4 specific config defines */
> +
> +/* resource IDs */
> +
> +#define ETM4_CFG_RES_CTR	0x001
> +#define ETM4_CFG_RES_CMP	0x002
> +#define ETM4_CFG_RES_CMP_PAIR0	0x003
> +#define ETM4_CFG_RES_CMP_PAIR1	0x004
> +#define ETM4_CFG_RES_SEL	0x005
> +#define ETM4_CFG_RES_SEL_PAIR0	0x006
> +#define ETM4_CFG_RES_SEL_PAIR1	0x007
> +#define ETM4_CFG_RES_SEQ	0x008
> +#define ETM4_CFG_RES_TS		0x009
> +#define ETM4_CFG_RES_MASK	0x00F

These are used in patch 08, please move them there.

> +
> +int etm4_cscfg_register(struct coresight_device *csdev, const char *dev_name);
> +
> +#endif /* _CORESIGHT_CORESIGHT_ETM4X_CFG_H */
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 473ab7480a36..5e501ce244dd 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -38,6 +38,8 @@
>  
>  #include "coresight-etm4x.h"
>  #include "coresight-etm-perf.h"
> +#include "coresight-etm4x-cfg.h"
> +#include "coresight-syscfg.h"
>  
>  static int boot_enable;
>  module_param(boot_enable, int, 0444);
> @@ -491,12 +493,15 @@ static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata)
>  	return ret;
>  }
>  
> -static int etm4_parse_event_config(struct etmv4_drvdata *drvdata,
> +static int etm4_parse_event_config(struct coresight_device *csdev,
>  				   struct perf_event *event)
>  {
>  	int ret = 0;
> +	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>  	struct etmv4_config *config = &drvdata->config;
>  	struct perf_event_attr *attr = &event->attr;
> +	unsigned long cfg_id;
> +	int preset;
>

Ok
  
>  	if (!attr) {
>  		ret = -EINVAL;
> @@ -554,6 +559,20 @@ static int etm4_parse_event_config(struct etmv4_drvdata *drvdata,
>  		/* bit[12], Return stack enable bit */
>  		config->cfg |= BIT(12);
>  
> +	/*
> +	 * Set any selected configuration and preset.
> +	 *
> +	 * This extracts the values of PMU_FORMAT_ATTR(configid) and PMU_FORMAT_ATTR(preset)
> +	 * in the perf attributes defined in coresight-etm-perf.c.
> +	 * configid uses bits 63:32 of attr->config2, preset uses bits 3:0 of attr->config.
> +	 * A zero configid means no configuration active, preset = 0 means no preset selected.
> +	 */
> +	if (attr->config2 & GENMASK_ULL(63, 32)) {
> +		cfg_id = (u32)(attr->config2 >> 32);
> +		preset = attr->config & 0xF;
> +		ret = cscfg_csdev_enable_active_config(csdev, cfg_id, preset);
> +	}
> +

Ok

>  out:
>  	return ret;
>  }
> @@ -570,7 +589,7 @@ static int etm4_enable_perf(struct coresight_device *csdev,
>  	}
>  
>  	/* Configure the tracer based on the session's specifics */
> -	ret = etm4_parse_event_config(drvdata, event);
> +	ret = etm4_parse_event_config(csdev, event);
>  	if (ret)
>  		goto out;
>  	/* And enable it */
> @@ -701,11 +720,18 @@ static int etm4_disable_perf(struct coresight_device *csdev,
>  	u32 control;
>  	struct etm_filters *filters = event->hw.addr_filters;
>  	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	struct perf_event_attr *attr = &event->attr;
>  
>  	if (WARN_ON_ONCE(drvdata->cpu != smp_processor_id()))
>  		return -EINVAL;
>  
>  	etm4_disable_hw(drvdata);
> +	/*
> +	 * The config_id occupies bits 63:32 of the config2 perf event attr
> +	 * field. If this is non-zero then we will have enabled a config.
> +	 */
> +	if (attr->config2 & GENMASK_ULL(63, 32))
> +		cscfg_csdev_disable_active_config(csdev);

Ok

>  
>  	/*
>  	 * Check if the start/stop logic was active when the unit was stopped.
> @@ -1815,6 +1841,13 @@ static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
>  		return ret;
>  	}
>  
> +	/* register with config infrastructure & load any current features */
> +	ret = etm4_cscfg_register(drvdata->csdev, dev_name(dev));
> +	if (ret) {
> +		coresight_unregister(drvdata->csdev);
> +		return ret;
> +	}
> +
>  	etmdrvdata[drvdata->cpu] = drvdata;
>  
>  	dev_info(&drvdata->csdev->dev, "CPU%d: ETM v%d.%d initialized\n",
> @@ -1902,6 +1935,7 @@ static int __exit etm4_remove_dev(struct etmv4_drvdata *drvdata)
>  
>  	cpus_read_unlock();
>  
> +	cscfg_unregister_csdev(drvdata->csdev);
>  	coresight_unregister(drvdata->csdev);
>  
>  	return 0;
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> index b646d53a3133..cf2a51113436 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> @@ -9,6 +9,7 @@
>  #include <linux/sysfs.h>
>  #include "coresight-etm4x.h"
>  #include "coresight-priv.h"
> +#include "coresight-syscfg.h"
>  
>  static int etm4_set_mode_exclude(struct etmv4_drvdata *drvdata, bool exclude)
>  {
> @@ -269,6 +270,8 @@ static ssize_t reset_store(struct device *dev,
>  
>  	spin_unlock(&drvdata->spinlock);
>  
> +	cscfg_csdev_reset_feats(to_coresight_device(dev));
> +

Other than the cosmetic comments above, this patch is fine.

Thanks,
Mathieu

>  	return size;
>  }
>  static DEVICE_ATTR_WO(reset);
> -- 
> 2.17.1
> 
