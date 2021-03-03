Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27D732BCD8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359734AbhCCOuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 09:50:39 -0500
Received: from foss.arm.com ([217.140.110.172]:44968 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1843037AbhCCKYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:24:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E25311FB;
        Wed,  3 Mar 2021 02:24:00 -0800 (PST)
Received: from [10.57.63.81] (unknown [10.57.63.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 19D0F3F73B;
        Wed,  3 Mar 2021 02:23:57 -0800 (PST)
Subject: Re: [PATCH v4 01/10] coresight: syscfg: Initial coresight system
 configuration
To:     Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, linux-doc@vger.kernel.org
Cc:     yabinc@google.com, corbet@lwn.net, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, tingwei@codeaurora.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
References: <20210128170936.9222-1-mike.leach@linaro.org>
 <20210128170936.9222-2-mike.leach@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <e75f3cd2-6f87-24b1-bb3c-378725892e82@arm.com>
Date:   Wed, 3 Mar 2021 10:23:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210128170936.9222-2-mike.leach@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/21 5:09 PM, Mike Leach wrote:
> Creates an system management API to allow complex configurations and
> features to be programmed into a CoreSight infrastructure.
> 
> A feature is defined as a programming set for a device or class of
> devices.
> 
> A configuration is a set of features across the system that are enabled
> for a trace session.
> 
> The API will manage system wide configuration, and allow complex
> programmed features to be added to individual device instances, and
> provide for system wide configuration selection on trace capture
> operations.
> 
> This patch creates the initial data object and the initial API for
> loading configurations and features.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---
>   drivers/hwtracing/coresight/Makefile          |   2 +-
>   .../hwtracing/coresight/coresight-config.h    | 167 +++++++++++++++
>   drivers/hwtracing/coresight/coresight-core.c  |  12 +-
>   .../hwtracing/coresight/coresight-etm-perf.c  |   2 +-
>   .../hwtracing/coresight/coresight-etm-perf.h  |   2 +-
>   .../hwtracing/coresight/coresight-syscfg.c    | 197 ++++++++++++++++++
>   .../hwtracing/coresight/coresight-syscfg.h    |  54 +++++
>   7 files changed, 432 insertions(+), 4 deletions(-)
>   create mode 100644 drivers/hwtracing/coresight/coresight-config.h
>   create mode 100644 drivers/hwtracing/coresight/coresight-syscfg.c
>   create mode 100644 drivers/hwtracing/coresight/coresight-syscfg.h
> 
> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> index f20e357758d1..4ce854c434b1 100644
> --- a/drivers/hwtracing/coresight/Makefile
> +++ b/drivers/hwtracing/coresight/Makefile
> @@ -4,7 +4,7 @@
>   #
>   obj-$(CONFIG_CORESIGHT) += coresight.o
>   coresight-y := coresight-core.o  coresight-etm-perf.o coresight-platform.o \
> -		coresight-sysfs.o
> +		coresight-sysfs.o coresight-syscfg.o
>   obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o
>   coresight-tmc-y := coresight-tmc-core.o coresight-tmc-etf.o \
>   		      coresight-tmc-etr.o
> diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwtracing/coresight/coresight-config.h
> new file mode 100644
> index 000000000000..3fedf8ab3cee
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-config.h
> @@ -0,0 +1,167 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2020 Linaro Limited, All rights reserved.
> + * Author: Mike Leach <mike.leach@linaro.org>
> + */
> +
> +#ifndef _CORESIGHT_CORESIGHT_CONFIG_H
> +#define _CORESIGHT_CORESIGHT_CONFIG_H
> +
> +#include <linux/coresight.h>
> +#include <linux/types.h>
> +
> +/* CoreSight Configuration Management - component and system wide configuration */
> +
> +/*
> + * Register type flags for register value descriptor:
> + * describe how the value is interpreted, and handled.
> + */
> +#define CS_CFG_REG_TYPE_STD		0x80	/* reg is standard reg */
> +#define CS_CFG_REG_TYPE_RESOURCE	0x40	/* reg is a resource */
> +#define CS_CFG_REG_TYPE_VAL_PARAM	0x08	/* reg value uses param */
> +#define CS_CFG_REG_TYPE_VAL_MASK	0x04	/* reg value bit masked */
> +#define CS_CFG_REG_TYPE_VAL_64BIT	0x02	/* reg value 64 bit */
> +#define CS_CFG_REG_TYPE_VAL_SAVE	0x01	/* reg value save on disable */
> +
> +/*
> + * flags defining what device class a feature will match to when processing a
> + * system configuration - used by config data and devices.
> + */
> +#define	CS_CFG_MATCH_CLASS_SRC_ALL	0x0001	/* match any source */
> +#define CS_CFG_MATCH_CLASS_SRC_ETM4	0x0002	/* match any ETMv4 device */
> +
> +/* flags defining device instance matching - used in config match desc data. */
> +#define CS_CFG_MATCH_INST_ANY		0x80000000 /* any instance of a class */
> +
> +/*
> + * Limit number of presets in a configuration
> + * This is related to the number of bits (4) we use to select the preset on
> + * the perf command line. Preset 0 is always none selected.
> + * See PMU_FORMAT_ATTR(preset, "config:0-3") in coresight-etm-perf.c
> + */
> +#define CS_CFG_CONFIG_PRESET_MAX 15
> +
> +/**
> + * Parameter descriptor for a device feature.
> + *
> + * @name:  Name of parameter.
> + * @value: Initial or default value.
> + */
> +struct cscfg_parameter_desc {
> +	const char *name;
> +	u64 value;
> +};
> +
> +/**
> + * Representation of register value.
> + *
> + * Supports full 64 bit register value, or 32 bit value with optional mask
> + * value.
> + *
> + * @type:	define register usage and interpretation.
> + * @offset:	the address offset for register in the hardware device (per device specification).
> + * @hw_info:	optional hardware device type specific information. (ETM / CTI specific etc)
> + * @val64:	64 bit value.
> + * @val32:	32 bit value.
> + * @mask32:	32 bit mask when using 32 bit value to access device register.
> + */
> +struct cscfg_regval_desc {
> +	struct {
> +		u32 type:8;
> +		u32 offset:12;
> +		u32 hw_info:12;
> +	};
> +	union {
> +		u64 val64;
> +		struct {
> +			u32 val32;
> +			u32 mask32;
> +		};
> +	};
> +};

Is it possible to indicate whether the register value is 64bit or 32bit within the
structure, rather than having this outside ? That way cscfg_regval_desc is a complete
entity. (Realized this while looking at patch 2)

Suzuki


