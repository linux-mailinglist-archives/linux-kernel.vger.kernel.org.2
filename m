Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2950E32EC62
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 14:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbhCENja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 08:39:30 -0500
Received: from foss.arm.com ([217.140.110.172]:54326 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230472AbhCENjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 08:39:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB28931B;
        Fri,  5 Mar 2021 05:39:22 -0800 (PST)
Received: from [10.57.51.235] (unknown [10.57.51.235])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 520F93F73B;
        Fri,  5 Mar 2021 05:39:20 -0800 (PST)
Subject: Re: [PATCH v4 08/10] coresight: config: Add preloaded configurations
To:     Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, linux-doc@vger.kernel.org
Cc:     yabinc@google.com, corbet@lwn.net, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, tingwei@codeaurora.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
References: <20210128170936.9222-1-mike.leach@linaro.org>
 <20210128170936.9222-9-mike.leach@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <e8609532-547f-b728-453c-c6e930c049f7@arm.com>
Date:   Fri, 5 Mar 2021 13:39:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210128170936.9222-9-mike.leach@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/21 5:09 PM, Mike Leach wrote:
> Preload set of configurations.
> 
> This patch creates a small set of preloaded configurations and features
> that are available immediately after coresight has been initialised.
> 
> The current set provides a strobing feature for ETMv4, that creates a
> periodic sampling of trace by switching trace generation on and off
> using counters in the ETM.
> 
> A configuration called "autofdo" is also provided that uses the 'strobing'
> feature and provides a couple of preset values, selectable on the perf
> command line.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---
>   drivers/hwtracing/coresight/Makefile          |   3 +-
>   .../hwtracing/coresight/coresight-cfg-afdo.c  | 154 ++++++++++++++++++
>   .../coresight/coresight-cfg-preload.c         |  25 +++
>   .../coresight/coresight-cfg-preload.h         |  11 ++
>   drivers/hwtracing/coresight/coresight-core.c  |   6 +
>   .../hwtracing/coresight/coresight-syscfg.h    |   1 +
>   6 files changed, 199 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/hwtracing/coresight/coresight-cfg-afdo.c
>   create mode 100644 drivers/hwtracing/coresight/coresight-cfg-preload.c
>   create mode 100644 drivers/hwtracing/coresight/coresight-cfg-preload.h
> 
> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> index ea544206204d..2707bfef1b76 100644
> --- a/drivers/hwtracing/coresight/Makefile
> +++ b/drivers/hwtracing/coresight/Makefile
> @@ -4,7 +4,8 @@
>   #
>   obj-$(CONFIG_CORESIGHT) += coresight.o
>   coresight-y := coresight-core.o  coresight-etm-perf.o coresight-platform.o \
> -		coresight-sysfs.o coresight-syscfg.o coresight-config.o
> +		coresight-sysfs.o coresight-syscfg.o coresight-config.o \
> +		coresight-cfg-preload.o coresight-cfg-afdo.o
>   obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o
>   coresight-tmc-y := coresight-tmc-core.o coresight-tmc-etf.o \
>   		      coresight-tmc-etr.o
> diff --git a/drivers/hwtracing/coresight/coresight-cfg-afdo.c b/drivers/hwtracing/coresight/coresight-cfg-afdo.c
> new file mode 100644
> index 000000000000..ff69fb3f4434
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-cfg-afdo.c
> @@ -0,0 +1,154 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright(C) 2020 Linaro Limited. All rights reserved.
> + * Author: Mike Leach <mike.leach@linaro.org>
> + */
> +
> +#include "coresight-config.h"
> +#include "coresight-etm4x-cfg.h"
> +
> +/* preload configurations and features */
> +
> +/* preload in features for ETMv4 */
> +
> +/* strobe feature */
> +static struct cscfg_parameter_desc strobe_params[] = {
> +	{
> +		.name = "window",
> +		.value = 5000,
> +	},
> +	{
> +		.name = "period",
> +		.value = 10000,
> +	},
> +};
> +
> +static struct cscfg_regval_desc strobe_regs[] = {
> +	/* resource selectors */
> +	{
> +		.type = CS_CFG_REG_TYPE_RESOURCE,
> +		.offset = TRCRSCTLRn(2),
> +		.hw_info = ETM4_CFG_RES_SEL,
> +		.val32 = 0x20001,
> +	},
> +	{
> +		.type = CS_CFG_REG_TYPE_RESOURCE,
> +		.offset = TRCRSCTLRn(3),
> +		.hw_info = ETM4_CFG_RES_SEQ,
> +		.val32 = 0x20002,
> +	},
> +	/* strobe window counter 0 - reload from param 0 */
> +	{
> +		.type = CS_CFG_REG_TYPE_RESOURCE | CS_CFG_REG_TYPE_VAL_SAVE,
> +		.offset = TRCCNTVRn(0),
> +		.hw_info = ETM4_CFG_RES_CTR,
> +	},
> +	{
> +		.type = CS_CFG_REG_TYPE_RESOURCE | CS_CFG_REG_TYPE_VAL_PARAM,
> +		.offset = TRCCNTRLDVRn(0),
> +		.hw_info = ETM4_CFG_RES_CTR,
> +		.val32 = 0,
> +	},
> +	{
> +		.type = CS_CFG_REG_TYPE_RESOURCE,
> +		.offset = TRCCNTCTLRn(0),
> +		.hw_info = ETM4_CFG_RES_CTR,
> +		.val32 = 0x10001,
> +	},
> +	/* strobe period counter 1 - reload from param 1 */
> +	{
> +		.type = CS_CFG_REG_TYPE_RESOURCE | CS_CFG_REG_TYPE_VAL_SAVE,
> +		.offset = TRCCNTVRn(1),
> +		.hw_info = ETM4_CFG_RES_CTR,
> +	},
> +	{
> +		.type = CS_CFG_REG_TYPE_RESOURCE | CS_CFG_REG_TYPE_VAL_PARAM,
> +		.offset = TRCCNTRLDVRn(1),
> +		.hw_info = ETM4_CFG_RES_CTR,
> +		.val32 = 1,
> +	},
> +	{
> +		.type = CS_CFG_REG_TYPE_RESOURCE,
> +		.offset = TRCCNTCTLRn(1),
> +		.hw_info = ETM4_CFG_RES_CTR,
> +		.val32 = 0x8102,
> +	},
> +	/* sequencer */
> +	{
> +		.type = CS_CFG_REG_TYPE_RESOURCE,
> +		.offset = TRCSEQEVRn(0),
> +		.hw_info = ETM4_CFG_RES_SEQ,
> +		.val32 = 0x0081,
> +	},
> +	{
> +		.type = CS_CFG_REG_TYPE_RESOURCE,
> +		.offset = TRCSEQEVRn(1),
> +		.hw_info = ETM4_CFG_RES_SEQ,
> +		.val32 = 0x0000,
> +	},
> +	/* view-inst */
> +	{
> +		.type = CS_CFG_REG_TYPE_STD | CS_CFG_REG_TYPE_VAL_MASK,
> +		.offset = TRCVICTLR,
> +		.val32 = 0x0003,
> +		.mask32 = 0x0003,
> +	},
> +	/* end of regs */
> +};
> +
> +struct cscfg_feature_desc strobe = {
> +	.name = "strobing",
> +	.brief = "Generate periodic trace capture windows.\n"
> +	"parameter \'window\': a number of CPU cycles (W)\n"
> +	"parameter \'period\': trace enabled for W cycles every period x W cycles\n",

nit: Could we align the string as below:

	.brief = "Generate periodic trace capture windows.\n"
		 "parameter \'window\': a number of CPU cycles (W)\n"
		 "parameter \'period\': trace enabled for W cycles every period x W cycles\n",

> +	.match_flags = CS_CFG_MATCH_CLASS_SRC_ETM4,
> +	.nr_params = ARRAY_SIZE(strobe_params),
> +	.params = strobe_params,
> +	.nr_regs = ARRAY_SIZE(strobe_regs),
> +	.regs = strobe_regs,
> +};
> +
> +/* create an autofdo configuration */
> +
> +/* we will provide 9 sets of preset parameter values */
> +#define AFDO_NR_PRESETS		9
> +/* the total number of parameters in used features */
> +#define AFDO_NR_PARAM_SUM	ARRAY_SIZE(strobe_params)

nit: alignment consistency. i.e 1 TAB vs 2 TABs (with AFDO_NR_PRESETS)

minor nit : s/AFDO_NR_PARAM_SUM/AFDO_NR_TOTAL_PARAMS ? or even AFDO_NR_PARAMS

> +
> +#define AFDO_MATCH_STROBING (CS_CFG_MATCH_INST_ANY | CS_CFG_MATCH_CLASS_SRC_ETM4)
> +
> +static struct cscfg_config_feat_ref afdo_refs[] = {
> +	{
> +		.name = "strobing",
> +		.match = {
> +			.match_flags = AFDO_MATCH_STROBING,
> +		},
> +	},
> +};
> +
> +/*
> + * set of presets leaves strobing window constant while varying period to allow
> + * experimentation with mark / space ratios for various workloads
> + */
> +static u64 afdo_presets[AFDO_NR_PRESETS][AFDO_NR_PARAM_SUM] = {
> +	{ 5000, 2 },
> +	{ 5000, 4 },
> +	{ 5000, 8 },
> +	{ 5000, 16 },
> +	{ 5000, 64 },
> +	{ 5000, 128 },
> +	{ 5000, 512 },
> +	{ 5000, 1024 },
> +	{ 5000, 4096 },
> +};
> +
> +struct cscfg_config_desc afdo = {
> +	.name = "autofdo",
> +	.brief = "Setup ETMs with strobing for autofdo\n"
> +	"Supplied presets allow experimentation with mark-space ratio for various loads\n",

Same alignment comments as above

> +	.nr_refs = ARRAY_SIZE(afdo_refs),
> +	.refs = afdo_refs,
> +	.nr_presets = AFDO_NR_PRESETS,
> +	.nr_total_params = AFDO_NR_PARAM_SUM,
> +	.presets = &afdo_presets[0][0],
> +};
> diff --git a/drivers/hwtracing/coresight/coresight-cfg-preload.c b/drivers/hwtracing/coresight/coresight-cfg-preload.c
> new file mode 100644
> index 000000000000..c7ec5cbdd990
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-cfg-preload.c
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright(C) 2020 Linaro Limited. All rights reserved.
> + * Author: Mike Leach <mike.leach@linaro.org>

One line on the brief of the files purpose is helpful.

> + */
> +
> +#include "coresight-cfg-preload.h"
> +#include "coresight-config.h"
> +#include "coresight-syscfg.h"
> +
> +static struct cscfg_feature_desc *preload_feats[] = {
> +	&strobe,
> +	0
> +};
> +
> +static struct cscfg_config_desc *preload_cfgs[] = {
> +	&afdo,
> +	0
> +};
> +
> +/* preload called with mutex locked */
> +int cscfg_preload(void)
> +{
> +	return cscfg_load_config_sets(preload_cfgs, preload_feats);
> +}
> diff --git a/drivers/hwtracing/coresight/coresight-cfg-preload.h b/drivers/hwtracing/coresight/coresight-cfg-preload.h
> new file mode 100644
> index 000000000000..fc4ac7faa93d
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-cfg-preload.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright(C) 2020 Linaro Limited. All rights reserved.
> + * Author: Mike Leach <mike.leach@linaro.org>
> + */
> +
> +/* declare preloaded configurations and features */
> +
> +/* from coresight-cfg-afdo.c */
> +extern struct cscfg_feature_desc strobe;
> +extern struct cscfg_config_desc afdo;
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 6bd41de46648..633ddcffc6c7 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -1744,9 +1744,15 @@ static int __init coresight_init(void)
>   
>   	/* initialise the coresight syscfg API */
>   	ret = cscfg_init();
> +	if (ret)
> +		goto exit_perf_close;
> +
> +	/* preload builtin configurations */
> +	ret = cscfg_preload();
>   	if (!ret)
>   		return 0;

Could this be folded into cscfg_init() ?

Otherwise looks fine to me

Suzuki
