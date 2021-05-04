Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388A7372919
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 12:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhEDKcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 06:32:06 -0400
Received: from mail-eopbgr40049.outbound.protection.outlook.com ([40.107.4.49]:36442
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230225AbhEDKcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 06:32:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUs5mbTScTttzj6VHDgryIO07HbO2Md1Fed6NEavMkPqZewDLHei4Se8OQJcqQTqtBKX139z8z7Zv5DleLG5CWTVG2UO7OfTm/plK9uBbPywpAfmf5AnBeHro/6kHGjFyrS3bOtKwJ67WFmrtKXc1Dngw8b7ZNSADNKUch3jYimHopd0bXjjEjvZnklkrV2ODOsOl4QUn0BAQGTwgS8SjKkpOXWbfPAmA/2sz9rJREOfhshqUaNr8vUhJaw0uLfxU9ZCtJFCfyMQE8X3L8dbvrmu6LfelC+GpuTSvWFlsiRYWBg0JxLjGAXzF97al6BmAmUTRxQysTjUlzwM5qicCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAlEUxyV6J6+FRwZ/VXIT90KKAwT1Gi3dSF9KRt4jdE=;
 b=JjLj8bB0gmiu6xx8Bg7ktn3ml5B1V8dStNd7MD+ZckH0Qt3TqFAyezI7XA8Q/dIeYyAAQ+6U3l0+dGrjx7WyK+gxBEJX3ekWEPeGoMb8w7ukSB4IOd/68zQDVlXJD9pb0FRe0mKIDJxyfALxPxSbVIieu5x9zSKrTdvOeMewzOMuZlVicaqT7xZYbdZ7w+Rj9y+Kr97ZzmpUGtnnGuSUWV7idacbsIeKKclSPtK1y7OXdwnUmX+70ad+mHpFTIvZepcjLwNi6bXxGpoCUCenDdE5mKQazgr/2NQcBJgU8ip8sDYLwhiV/BMU178Y+oSg4UWlPA9/L/iiwGGQp8DEdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAlEUxyV6J6+FRwZ/VXIT90KKAwT1Gi3dSF9KRt4jdE=;
 b=AtNmGROQTxrco86oRsI7s5HDmxzYfVmApsiX/GCBCNQKsaEE/r2sT9YWlyDkQXf/kLO7c2/D21OszbAeg6eHHsrAtNrH+Np1yam6Ndyn8dTBU/w8jtzYJloXe/YxCk4x24t5rdAdmWpA73Xw68cX5ydpEMJIEjTJhB3pepZcvNI=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBBPR04MB7850.eurprd04.prod.outlook.com (2603:10a6:10:1e8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.35; Tue, 4 May
 2021 10:31:05 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.039; Tue, 4 May 2021
 10:31:05 +0000
Subject: Re: [PATCH V2 3/4] soc: imx: Add generic blk-ctl driver
To:     Lucas Stach <l.stach@pengutronix.de>, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, krzk@kernel.org, agx@sigxcpu.org,
        marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
References: <20210430052746.10815-1-peng.fan@oss.nxp.com>
 <20210430052746.10815-4-peng.fan@oss.nxp.com>
 <6997abd422ffa1fa384a048552109aec1095abc3.camel@pengutronix.de>
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Message-ID: <1707a917-5f91-b3e8-2be1-6461fb4c950c@oss.nxp.com>
Date:   Tue, 4 May 2021 18:30:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <6997abd422ffa1fa384a048552109aec1095abc3.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [58.223.139.112]
X-ClientProxiedBy: HK2PR02CA0193.apcprd02.prod.outlook.com
 (2603:1096:201:21::29) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.107] (58.223.139.112) by HK2PR02CA0193.apcprd02.prod.outlook.com (2603:1096:201:21::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.43 via Frontend Transport; Tue, 4 May 2021 10:30:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34a7299e-4b2c-4210-d649-08d90ee7b85c
X-MS-TrafficTypeDiagnostic: DBBPR04MB7850:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB78509F02F27A1B0DDE1D9722C95A9@DBBPR04MB7850.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6FPUgqadFMy8l9i2ghvVtdwJFWd9PFRRsmnE/F+tTBFM5oLzaeCK1w10b0CZ7w+T69jGTzXLJp4LbPQy7ciXPjADwuQbCpEZZWy1ouZBbdaE9i+l4N+Oh2RuvvtSMRiYBlJBfNIufgXwQveg87wzsva3yFWk5CoZjLpaPtFjGLmvC94bWQdH6F5ZiD62K6XUKWUZPlyd3FS9UG5dt0TLtRGgvkkgobBEs/7jpbsQXdvVwuSMoiqf11a1dHRKViuWlYqmMFDV3RFYZq/mPdTDBBnfunqoVIFgpJqbxJf1zZMhSzEaMGnwaFnF9/CdiiwV1Rsy5ptuuUw4T4XsUd9iE2N3DkpEaxWYSp5SyON5bjfDqolAxuJ/53FyGo8zWDjUryLPjVYFwubsH3Uffrko9XpraITpu49F7nQS3xOgZ56I50j3bF+7BapydZWhxkM6gvrqavK+D9jCx3c0wprTPgUNYiDdLty4oh7bsmg6rpnL/Kr5grlGPOU0z3m+Vazch03q3FDlfvK5ho2PNCTY70hTFKDzP4vDnKuRdk7XHN5kieaZuJDHovrjwxFRkueYeoykzGnhmmR1whf35e1AjcmwQf+ta9N3Z4i6c+z8VLy9dI9xswwz0rc+CLqNlf0NFkTNVf9JELCe/keW/w7uUlus2aKBeHFbdKBFdITyMYCiCRCNtxZTfywLblgMnmt1e7gbSzIa5ndtC3mFbNVSw8Npy2oBBPyHfF1jNsAGbgu5XewcF5CI9QKl5vFp7/oX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(136003)(39850400004)(396003)(956004)(5660300002)(53546011)(16576012)(31696002)(83380400001)(316002)(86362001)(186003)(6666004)(16526019)(2906002)(6486002)(478600001)(31686004)(66946007)(7416002)(26005)(4326008)(38100700002)(8676002)(8936002)(52116002)(66556008)(66476007)(38350700002)(30864003)(2616005)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?c2wrZERySU0vQjB6VVl1NHVWWUpTbHRIa1RHTEl1b0pQUGxZZFVDdzNqRGp5?=
 =?utf-8?B?ZlJYREJBZ3FJSW9JY2FWMElQclJYbUR2WHB3emUwbE9ITE16cGRCV081NVdx?=
 =?utf-8?B?YWcvVDdNVzZZaGRTWlVjT1Nka3FiUnZaY2lEVyt2Wm1LNEpwaE13L25keW45?=
 =?utf-8?B?RkJtV0dFYmlKbVVyVU1UZG51cllldTdXVWxOMWVHTFNnTXdQc28rZVpqY3N2?=
 =?utf-8?B?d0pDQit5dFdQd2phU1haWHFpTzVsYVVMNitTZWZUcVRlYng1UW40UFBpek9I?=
 =?utf-8?B?TjMzK0lpTlZLWk4rUGwwdXhXOWIwNzBVU2dQdi9xTDZqY1dQSWRnSWhleGxr?=
 =?utf-8?B?OWs2dnU3dld6d2pXdWhyMG11MUZkNlRTMTk4TUdTZUthckI4M0crTHdZcnV4?=
 =?utf-8?B?R3cvRzVQN1ZNNW41ZkUrNmxaQUx3NG1WTzJhRXRFUUFERnFlVUhHQUROVFR1?=
 =?utf-8?B?WWFpUnlPWWpTM0N6T0RIMzZvS0ltQm5DY2tPZzZqcVJtWFVkRHhnU0VDN242?=
 =?utf-8?B?WmZkakF1UDJuRzNBODU3cWZpMWpWVlRYZnlBVzdPODgwUnk3NDdiV2UzMC9j?=
 =?utf-8?B?MWxBMFBkby81TTd4L1VGUTZQQW90c0xaUC90UGFiZEw1YTZ2QTZ5TmV6MmpY?=
 =?utf-8?B?K05FS1pORG9EQTJweEpJK1JXVVlZdDNGNXluS0x2QTN6aElMTmtGNkQrZUZl?=
 =?utf-8?B?aFhremlCOU84WlByZDU0RENWWlJkTnBJZjg4R3F1SUt4WGM5YTIwM0cwQ1Zn?=
 =?utf-8?B?YU9OREZydFcyTXlXV1psdVZnY0wzZWVUS0dLL3o5UFQ2UkkyeFNrak4yMHAy?=
 =?utf-8?B?cVZrN3hSci8wQ2Vxc0VHUUJwL1grdjRqNkJGeHdKYlVLNjJxQjBTWnE3V3Y3?=
 =?utf-8?B?bFF2blNmdHBicUVaUGZaN2RJdTJkNTVSR3d0M0xsMUxCVFJZSmFoTWZhYTNV?=
 =?utf-8?B?VmtLK3JIMldjaHNwTzRmeG41SFFibmVxeE5mRE43MTdoUXMzeUhkWURubHNx?=
 =?utf-8?B?Rm95d0hBN1NTckU5SmxzUlRQaFAwQUFTTlZSZlYxTFVHM3RyOFVPT0c3VU91?=
 =?utf-8?B?dk5yQ0VGNnloaTZrUTdmWStvVENRUWdFY3VmQkNDc1NvVm83ald0STlQSit4?=
 =?utf-8?B?YUx3N1ZLRnZCZm9IeEdLRmJKcFJBMmtHTnRpVStYWWhMTWxyVlZlMWl3RTBM?=
 =?utf-8?B?a1BvOENLclhxdDNIdDhqNGRzMklHZ1NFK2t6ekoxa1RsOGhyc3dyUklqQm81?=
 =?utf-8?B?b3hXc1Q4OE5VL21qK3RuUmVESVZJZ1hBc1ZhcFVvYVhWV21jV1FacWllV0d0?=
 =?utf-8?B?YlMwYmFLU0NNN2EwdHFyaFRWZmVnWEl5Z1RJcWEycnUxYVV6d1cyUG53a3U2?=
 =?utf-8?B?UmYrL0VHQVpYMmQvMG95OUdqaUZnb2NNdlQxanZacFR5N0tua3ZNTnVJelJK?=
 =?utf-8?B?WWE0SUhPN3U2c2VOSkxyRkJwY1pETTRNTUFXWjhKVE15eTZIazNpT3kwcTJv?=
 =?utf-8?B?ZzdWYmpucjJqSGI0bFRQWXZtVUZ2NFVhYUs1d2hUcS9wcmxhOFJjV0FNbk16?=
 =?utf-8?B?d3BRTG1pcm1ZSEZHTEZaQXo3UEZJUHpwVUtoNWhNSjgrcnFVMFZ6MkJWVDRy?=
 =?utf-8?B?N0w3Z055TmcxY1NoOEpLSmxsbTVNcE1WOVBEUi9tTTlBazBnMmRXaEVXM3lP?=
 =?utf-8?B?TWNDampmQjJQc2JMTW8zYXhaa3kvV1FnbzQ5dXlJbUlrSURjUmIwR0xPVzFP?=
 =?utf-8?Q?NxjncZViOAdZo2oN9nhq+MBWETAiecSJCtox8B8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a7299e-4b2c-4210-d649-08d90ee7b85c
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 10:31:04.9598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zHEv3F+WrUqQF4xUGk+Egjs5UxbSJw/ok9kDnsw+YE7unx1U5R+XfiA59UcVd2Mozb79scFzqXc5VHaFYkRJnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7850
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/5/4 17:47, Lucas Stach wrote:
> Am Freitag, dem 30.04.2021 um 13:27 +0800 schrieb Peng Fan (OSS):
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> The i.MX8MM introduces an IP named BLK_CTL and usually is comprised of
>> some GPRs.
>>
>> The GPRs has some clock bits and reset bits, but here we take it
>> as virtual PDs, because of the clock and power domain A/B lock issue
>> when taking it as a clock controller.
>>
>> For some bits, it might be good to also make it as a reset controller,
>> but to i.MX8MM, we not add that support for now.
>>
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>   drivers/soc/imx/Makefile  |   2 +-
>>   drivers/soc/imx/blk-ctl.c | 303 ++++++++++++++++++++++++++++++++++++++
>>   drivers/soc/imx/blk-ctl.h |  76 ++++++++++
>>   3 files changed, 380 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/soc/imx/blk-ctl.c
>>   create mode 100644 drivers/soc/imx/blk-ctl.h
>>
>> diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
>> index 078dc918f4f3..d3d2b49a386c 100644
>> --- a/drivers/soc/imx/Makefile
>> +++ b/drivers/soc/imx/Makefile
>> @@ -4,4 +4,4 @@ obj-$(CONFIG_ARCH_MXC) += soc-imx.o
>>   endif
>>   obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
>>   obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
>> -obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o
>> +obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o blk-ctl.o
>> diff --git a/drivers/soc/imx/blk-ctl.c b/drivers/soc/imx/blk-ctl.c
>> new file mode 100644
>> index 000000000000..1f764dfd308d
>> --- /dev/null
>> +++ b/drivers/soc/imx/blk-ctl.c
>> @@ -0,0 +1,303 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright 2021 NXP.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/regmap.h>
>> +#include <linux/slab.h>
>> +#include <linux/string.h>
>> +#include <linux/types.h>
>> +#include <linux/pm_domain.h>
>> +#include <linux/reset-controller.h>
>> +
>> +#include "blk-ctl.h"
>> +
>> +static inline struct imx_blk_ctl_domain *to_imx_blk_ctl_pd(struct generic_pm_domain *genpd)
>> +{
>> +	return container_of(genpd, struct imx_blk_ctl_domain, pd);
>> +}
>> +
>> +static int imx_blk_ctl_enable_hsk(struct device *dev)
>> +{
>> +	struct imx_blk_ctl *blk_ctl = dev_get_drvdata(dev);
>> +	const struct imx_blk_ctl_hw *hw = &blk_ctl->dev_data->hw_hsk;
>> +	struct regmap *regmap = blk_ctl->regmap;
>> +	int ret;
>> +
>> +
>> +	if (hw->flags & IMX_BLK_CTL_PD_RESET)
>> +		ret = regmap_update_bits(regmap, hw->rst_offset, hw->rst_mask, hw->rst_mask);
>> +
>> +	ret = regmap_update_bits(regmap, hw->offset, hw->mask, hw->mask);
>> +
>> +	/* Wait for handshake */
>> +	udelay(5);
>> +
>> +	return ret;
>> +}
>> +
>> +int imx_blk_ctl_power_off(struct generic_pm_domain *domain)
>> +{
>> +	struct imx_blk_ctl_domain *pd;
>> +	struct imx_blk_ctl *blk_ctl;
>> +	const struct imx_blk_ctl_hw *hw;
>> +	struct regmap *regmap;
>> +	int ret;
>> +
>> +	pd = to_imx_blk_ctl_pd(domain);
>> +	blk_ctl = pd->blk_ctl;
>> +	regmap = blk_ctl->regmap;
>> +	hw = &blk_ctl->dev_data->pds[pd->id];
>> +
>> +	ret = clk_bulk_prepare_enable(blk_ctl->num_clks, blk_ctl->clks);
>> +	if (ret)
>> +		return ret;
> 
> This looks a bit strange to me. Does that mean that you keep all the
> CCM clocks going into the blkctl enabled as long as one of the blkctl
> virtual power domains is up?

No. The clocks are disable unprepared when this function finish.
The clocks are only used for setting blk ctl bits and handshake.

  I would have expected each virtual PD to
> have a list of clock names that need to be enabled, to make this more
> selective.
> 
> I haven't completely thought it through if this is a problem, but I
> could see some CCM PLLs running without a reason if all CCM clocks are
> kept enabled. This surely is something we want to avoid from a pwoer
> consumption PoV.

I thought to add selective clocks for each virtual PD, but that makes
the design completed, and the clocks(gate) are only enabled for a little
while, so I think compared with the software complexity, the little
benifit of power could be ignored?

> 
>> +
>> +	ret = regmap_update_bits(regmap, hw->offset, hw->mask, 0);
>> +	if (ret)
>> +		goto hsk_fail;
>> +
>> +	if (hw->flags & IMX_BLK_CTL_PD_RESET)
>> +		ret = regmap_update_bits(regmap, hw->rst_offset, hw->rst_mask, 0);
>> +
>> +	if (atomic_dec_and_test(&blk_ctl->power_count)) {
>> +		ret = imx_blk_ctl_enable_hsk(blk_ctl->dev);
>> +		if (ret) {
>> +			dev_err(blk_ctl->dev, "Hankshake fail\n");
>> +			goto hsk_fail;
>> +		}
>> +	}
>> +
>> +hsk_fail:
>> +	clk_bulk_disable_unprepare(blk_ctl->num_clks, blk_ctl->clks);
>> +
>> +	return ret;
>> +}
>> +
>> +int imx_blk_ctl_power_on(struct generic_pm_domain *domain)
>> +{
>> +	struct imx_blk_ctl_domain *pd;
>> +	struct regmap *regmap;
>> +	const struct imx_blk_ctl_hw *hw;
>> +	int ret;
>> +	struct imx_blk_ctl *blk_ctl;
>> +
>> +	pd = to_imx_blk_ctl_pd(domain);
>> +	blk_ctl = pd->blk_ctl;
>> +	regmap = blk_ctl->regmap;
>> +	hw = &blk_ctl->dev_data->pds[pd->id];
>> +
>> +	ret = clk_bulk_prepare_enable(blk_ctl->num_clks, blk_ctl->clks);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if ((atomic_read(&blk_ctl->power_count) == 0)) {
>> +		ret = imx_blk_ctl_enable_hsk(blk_ctl->dev);
>> +		if (ret) {
>> +			dev_err(blk_ctl->dev, "Hankshake fail\n");
>> +			goto disable_clk;
>> +		}
>> +	}
> 
> This is bogus. The variable isn't used as a atomic, if at all this
> should use atomic_inc_return, but I think even that isn't correct in
> that case. imx_blk_ctl_enable_hsk() includes a wait time, so if two
> paths call this function at the same time, the second caller would be
> able to overtake the first one, which is still waiting for the
> handshake to complete, effectively skipping the handshake. This needs a
> proper lock, as this function isn't called from a performance critical
> path it makes no sense to try to optimize this with an atomic counter,
> rather than going with a mutex.

I see. Will use a mutex here.

> 
>> +
>> +	if (hw->flags & IMX_BLK_CTL_PD_RESET)
>> +		ret = regmap_update_bits(regmap, hw->rst_offset, hw->rst_mask, 0);
>> +
>> +	/* Wait for reset propagate */
>> +	udelay(5);
>> +
>> +	if (hw->flags & IMX_BLK_CTL_PD_RESET)
>> +		ret = regmap_update_bits(regmap, hw->rst_offset, hw->rst_mask, hw->rst_mask);
>> +
>> +	ret = regmap_update_bits(regmap, hw->offset, hw->mask, hw->mask);
>> +	if (ret)
>> +		goto disable_clk;
>> +
>> +	atomic_inc(&blk_ctl->power_count);
>> +
>> +disable_clk:
>> +	clk_bulk_disable_unprepare(blk_ctl->num_clks, blk_ctl->clks);
>> +
>> +	return ret;
>> +}
>> +
>> +static int imx_blk_ctl_attach_pd(struct device *dev, struct device **devs, char **pd_names,
>> +				 u32 num_pds)
>> +{
>> +	int i, ret;
>> +
>> +	if (!pd_names)
>> +		return 0;
>> +
>> +	if (dev->pm_domain) {
>> +		devs[0] = dev;
>> +		pm_runtime_enable(dev);
>> +		return 0;
>> +	}
>> +
>> +	for (i = 0; i < num_pds; i++) {
>> +		devs[i] = dev_pm_domain_attach_by_name(dev, pd_names[i]);
>> +		if (IS_ERR_OR_NULL(devs[i])) {
>> +			ret = PTR_ERR(devs[i]) ? : -ENODATA;
>> +			goto detach_pm;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +
>> +detach_pm:
>> +	for (i--; i >= 0; i--)
>> +		dev_pm_domain_detach(devs[i], false);
>> +
>> +	return ret;
>> +}
>> +
>> +static int imx_blk_ctl_register_pd(struct device *dev)
>> +{
>> +	struct imx_blk_ctl *blk_ctl = dev_get_drvdata(dev);
>> +	const struct imx_blk_ctl_dev_data *dev_data = blk_ctl->dev_data;
>> +	int num = dev_data->pds_num;
>> +	struct imx_blk_ctl_domain *domain;
>> +	int i, ret;
>> +
>> +	blk_ctl->onecell_data.num_domains = num;
>> +	blk_ctl->onecell_data.domains = devm_kcalloc(dev, num,
>> +						     sizeof(struct generic_pm_domain *),
>> +						     GFP_KERNEL);
>> +
>> +	if (!blk_ctl->onecell_data.domains)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < num; i++) {
>> +		domain = devm_kzalloc(dev, sizeof(*domain), GFP_KERNEL);
>> +		if (!domain) {
>> +			ret = -ENOMEM;
>> +			goto remove_genpd;
>> +		}
>> +		domain->pd.name = dev_data->pds[i].name;
>> +		domain->pd.power_off = imx_blk_ctl_power_off;
>> +		domain->pd.power_on = imx_blk_ctl_power_on;
>> +		domain->blk_ctl = blk_ctl;
>> +		domain->id = i;
>> +
>> +		ret = pm_genpd_init(&domain->pd, NULL, true);
>> +		if (ret)
>> +			return ret;
>> +
>> +		blk_ctl->onecell_data.domains[i] = &domain->pd;
>> +	}
>> +
>> +	return 0;
>> +
>> +remove_genpd:
>> +	for (i = i - 1; i >= 0; i--)
>> +		pm_genpd_remove(blk_ctl->onecell_data.domains[i]);
>> +
>> +	return ret;
>> +}
>> +
>> +static int imx_blk_ctl_hook_pd(struct device *dev)
>> +{
>> +	struct imx_blk_ctl *blk_ctl = dev_get_drvdata(dev);
>> +	const struct imx_blk_ctl_dev_data *dev_data = blk_ctl->dev_data;
>> +	const struct imx_blk_ctl_hw *pds = dev_data->pds;
>> +	int num_active_pd = dev_data->num_active_pd;
>> +	int num = dev_data->pds_num;
>> +	struct generic_pm_domain *genpd, *child_genpd;
>> +	int ret;
>> +	int i, j;
>> +
>> +	blk_ctl->active_pds = devm_kcalloc(dev, num_active_pd, sizeof(struct device *), GFP_KERNEL);
>> +	if (!blk_ctl->active_pds)
>> +		return -ENOMEM;
>> +
>> +	ret = imx_blk_ctl_attach_pd(dev, blk_ctl->active_pds, dev_data->active_pd_names,
>> +				    num_active_pd);
>> +	if (ret) {
>> +		if (ret == -EPROBE_DEFER)
>> +			return ret;
>> +		dev_err(dev, "Failed to attach active pd: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	for (i = 0; i < num; i++) {
>> +		for (j = 0; j < num_active_pd; j++) {
>> +			genpd = pd_to_genpd(blk_ctl->active_pds[j]->pm_domain);
>> +			if (!strcmp(genpd->name, pds[i].parent_name))
>> +				break;
>> +		}
>> +
>> +		child_genpd = blk_ctl->onecell_data.domains[i];
>> +		if (pm_genpd_add_subdomain(genpd, child_genpd))
>> +			pr_warn("failed to add subdomain:\n");
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +int imx_blk_ctl_register(struct device *dev)
>> +{
>> +	struct imx_blk_ctl *blk_ctl = dev_get_drvdata(dev);
>> +	const struct imx_blk_ctl_dev_data *dev_data = blk_ctl->dev_data;
>> +	int num = dev_data->pds_num;
>> +	int i, ret;
>> +
>> +	if (!blk_ctl)
>> +		return -ENODEV;
>> +
>> +	ret = imx_blk_ctl_register_pd(dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = imx_blk_ctl_hook_pd(dev);
>> +	if (ret)
>> +		goto unregister_pd;
>> +
>> +	ret = of_genpd_add_provider_onecell(dev->of_node, &blk_ctl->onecell_data);
>> +	if (ret)
>> +		goto detach_pd;
>> +
>> +	pm_runtime_get_noresume(dev);
>> +	pm_runtime_set_active(dev);
>> +	pm_runtime_enable(dev);
>> +
>> +	pm_runtime_put(dev);
>> +
>> +	return 0;
>> +
>> +detach_pd:
>> +	for (i = blk_ctl->dev_data->num_active_pd; i >= 0; i--)
>> +		dev_pm_domain_detach(blk_ctl->active_pds[i], false);
>> +unregister_pd:
>> +	for (i = num - 1; i >= 0; i--)
>> +		pm_genpd_remove(blk_ctl->onecell_data.domains[i]);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(imx_blk_ctl_register);
>> +
>> +static int __maybe_unused imx_blk_ctl_runtime_suspend(struct device *dev)
>> +{
>> +	return 0;
>> +}
>> +
>> +static int __maybe_unused imx_blk_ctl_runtime_resume(struct device *dev)
>> +{
>> +	return 0;
>> +}
> 
> Why those empty stubs? If you don't need to do anything for
> suspend/resume, just don't add the functions.

ok, will drop in V3.

Thanks,
Peng.

> 
>> +
>> +const struct dev_pm_ops imx_blk_ctl_pm_ops = {
>> +	SET_RUNTIME_PM_OPS(imx_blk_ctl_runtime_suspend,
>> +			   imx_blk_ctl_runtime_resume, NULL)
>> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
>> +			   pm_runtime_force_resume)
>> +};
>> +EXPORT_SYMBOL_GPL(imx_blk_ctl_pm_ops);
>> diff --git a/drivers/soc/imx/blk-ctl.h b/drivers/soc/imx/blk-ctl.h
>> new file mode 100644
>> index 000000000000..e736369406a1
>> --- /dev/null
>> +++ b/drivers/soc/imx/blk-ctl.h
>> @@ -0,0 +1,76 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef __SOC_IMX_BLK_CTL_H
>> +#define __SOC_IMX_BLK_CTL_H
>> +
>> +enum imx_blk_ctl_pd_type {
>> +	BLK_CTL_PD,
>> +};
>> +
>> +struct imx_blk_ctl_hw {
>> +	int type;
>> +	char *name;
>> +	char *parent_name;
>> +	u32 offset;
>> +	u32 mask;
>> +	u32 flags;
>> +	u32 id;
>> +	u32 rst_offset;
>> +	u32 rst_mask;
>> +};
>> +
>> +struct imx_blk_ctl_domain {
>> +	struct generic_pm_domain pd;
>> +	struct imx_blk_ctl *blk_ctl;
>> +	u32 id;
>> +};
>> +
>> +struct imx_blk_ctl_dev_data {
>> +	struct regmap_config config;
>> +	struct imx_blk_ctl_hw *pds;
>> +	struct imx_blk_ctl_hw hw_hsk;
>> +	u32 pds_num;
>> +	char **active_pd_names;
>> +	u32 num_active_pd;
>> +};
>> +
>> +struct imx_blk_ctl {
>> +	struct device *dev;
>> +	struct regmap *regmap;
>> +	struct device **active_pds;
>> +	u32 pds_num;
>> +	u32 active_pd_count;
>> +	struct genpd_onecell_data onecell_data;
>> +	const struct imx_blk_ctl_dev_data *dev_data;
>> +	struct clk_bulk_data *clks;
>> +	u32 num_clks;
>> +
>> +	atomic_t power_count;
>> +};
>> +
>> +#define IMX_BLK_CTL(_type, _name, _parent_name, _id, _offset, _mask, _rst_offset, _rst_mask,	\
>> +		    _flags)								\
>> +	{										\
>> +		.type = _type,								\
>> +		.name = _name,								\
>> +		.parent_name = _parent_name,						\
>> +		.id = _id,								\
>> +		.offset = _offset,							\
>> +		.mask = _mask,								\
>> +		.flags = _flags,							\
>> +		.rst_offset = _rst_offset,						\
>> +		.rst_mask = _rst_mask,							\
>> +	}
>> +
>> +#define IMX_BLK_CTL_PD(_name, _parent_name, _id, _offset, _mask, _rst_offset, _rst_mask, _flags) \
>> +	IMX_BLK_CTL(BLK_CTL_PD, _name, _parent_name, _id, _offset, _mask, _rst_offset,		\
>> +		    _rst_mask, _flags)
>> +
>> +int imx_blk_ctl_register(struct device *dev);
>> +
>> +#define IMX_BLK_CTL_PD_HANDSHAKE	BIT(0)
>> +#define IMX_BLK_CTL_PD_RESET		BIT(1)
>> +#define IMX_BLK_CTL_PD_BUS		BIT(2)
>> +
>> +const extern struct dev_pm_ops imx_blk_ctl_pm_ops;
>> +
>> +#endif
> 
> 
