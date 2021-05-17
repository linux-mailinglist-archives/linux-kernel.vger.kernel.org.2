Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEAB382548
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 09:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235255AbhEQH00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 03:26:26 -0400
Received: from mail-db8eur05on2103.outbound.protection.outlook.com ([40.107.20.103]:25427
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230339AbhEQH0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 03:26:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ub04W2tbbRKneW7sFZtbP9FYYXSW47uE58xPBgrDjxQaeSoQ6ZSUwBQQdtNhPCNcVBAs+NO3iPmD0SliIz3TATt6ABTzatHhEnJg/x2fYsUBF3a0araWZKAI81dMw+4LETR8owUMYAW9MXS1anMmgi51WZNZsw1Hvmh4A2DJaVntSSUcJP1309IUdomeXqeVsWp2ce7sB/XwdCANMtq4qnK6Zai2oxbk+sI46LqC3+epkt1rtm41Kwy2zmJ+OD17kIuZczh475ikYb4B7Li44v66Wq23oCzRdcg9l4ESIjwRAsUUGQN80FGSD2na9SU/SApA6q0V/9UdhGb1eWbpww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nz3R+CF/CZPwivwkwEW0s1YCDuAPNw2nS09pb2zTVr0=;
 b=DCfUdsHOUsRQIJYGQcRvdPRiVXqTonyHfm13NNYQeqXfGrxGOBokGDgi/lBhjmx205b+AkiLSK9UlAAV5zdGpN/3IsODy6jrU3+wtfZ8Vk80FdUsLeQkk6wG/5I5ZxBQTqTBdBArwgoQPiwE9qT13gEbaWrskZk7fzC40eyb7V9jy0YXMI8FnCWipSh/1fNaKFsH/e2FfT7D0ke0BF3MK+n2cQ1TD+OHwPWIHeQZ/dziiSxQXRlrWypS76Saywif+/8gg7Ajs00YngYuE4oe20s2PXbQp5GXkikkjCxX/XiYiMimV51tGR09cHl+lbWiB3sHCbqqtl3qRwli4QP0Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nz3R+CF/CZPwivwkwEW0s1YCDuAPNw2nS09pb2zTVr0=;
 b=QE3KTCq6ibeBo9cQmJ15ORHGZeHEqmjEN8jj7eezpbqvGVIUba8QxZteNlB4SeM8zacPhjEf/2aPx8HXQ7sW1CMeyHLYHpTIPEibjcFueAV4un6brs18oRtCzNXkOZLyB/X4eBVjnMJZMeKLJNe4D7o3D1avd/2gyAIDo8Qnuuk=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM9PR10MB4484.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:269::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 07:25:07 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87%7]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 07:25:07 +0000
Subject: Re: [PATCH V4 3/4] soc: imx: Add generic blk-ctl driver
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com, aford173@gmail.com,
        abel.vesa@nxp.com, Peng Fan <peng.fan@nxp.com>
References: <20210510040704.14997-1-peng.fan@oss.nxp.com>
 <20210510040704.14997-4-peng.fan@oss.nxp.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <31d4335e-6a1b-6ef5-f1c5-92fff42ae6b7@kontron.de>
Date:   Mon, 17 May 2021 09:25:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210510040704.14997-4-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [109.250.142.188]
X-ClientProxiedBy: AM0PR08CA0026.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::39) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.17] (109.250.142.188) by AM0PR08CA0026.eurprd08.prod.outlook.com (2603:10a6:208:d2::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 17 May 2021 07:25:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 545e9a15-a49f-4e84-e1b2-08d91904e560
X-MS-TrafficTypeDiagnostic: AM9PR10MB4484:
X-Microsoft-Antispam-PRVS: <AM9PR10MB4484CD6EDE090503C0BB1A8EE92D9@AM9PR10MB4484.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YwNKTmo8VaX0sxuhri06DcRhWXafKWun0iDGkTwZQqA+xQLp9mig5k6C0bshPI80y045Qxx2Iv3iiOybzfNsDOlA61RZxILmwcPH6Kj8qY276vFSmGfLPPXr6qCeI4peDf7LY2Doz0ObEiqcvHkG+cxXY+DZyDwOJvXTWQ7dW7jT9v7Q1fhOE/koL401w+sz55Kvct60hJ5+jRMfGjJnsRhXFyOCzNqKc2uHJ8tvzRUDF41Oh94NVlNhf614/2IqYdekeOLdItnWtspFHifcpdMucu9nUHdbcHgTlaKcX0noYEfrm2g/mu0zq7HzDdrSBJVocB1OzhjaEn/YdLYy77vUw6rF6kPG6QdC12dnTVI9dfr49gwVIPPfvT9fcgUqERXSGTxwQgzsK8KTzhK04ikFmSlH+Qqt71Bozr25xp585UHG8D8BY6UkTZsI4Jnjq/+Z9NiE2+7tH/OAmgK0MmKOi42zLEyeKJQFnBPy7Nl8UzNksQ9a5BhteDxO5Gc85Aq0qF+lPDsE+b/G6VIpnKR6GPDOOmdWTITbZQnMeyXMzv/yRLSEhtRwLrbNdEbWX/ymFeSjbdm5V06i5DzluIdkFhK/6ExUSuxXOQ8eOEoWya5ize9+9qLWsmAcv1z6LrrwbD77WaYRb3AJiuTZoycOwSCi3Cu5V0HlVYmsxW91JsUg+6ZPV8BKTF2qPCCN7j5SuCArntBcOsnNEE4Zzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(66476007)(66946007)(66556008)(38100700002)(31686004)(6486002)(5660300002)(36756003)(44832011)(16526019)(186003)(956004)(83380400001)(7416002)(8936002)(478600001)(2616005)(2906002)(16576012)(316002)(86362001)(53546011)(30864003)(26005)(8676002)(4326008)(31696002)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZXVUc0t4WjFWRStnVVRWWS9BVFRXQlRQV3dkVC9VUGxpdGd0djU3aHpiUzhM?=
 =?utf-8?B?bDVuM2krZDNxVVRmMjVlZWdEYVVhTlpzb1hpR2pzN0NNbSs1R2UrclRLRlVE?=
 =?utf-8?B?SjdWT3cvUWFPZE1ZUFNmMUhvZUlrdXcxQ1ZiMCt1bXNYM285STQ5amdQdVBH?=
 =?utf-8?B?K2tENzlQaDRIMlBLOC9lOFh4MlRCanY4MFBFZjZqQWk1OXZBQ1RhVU5WcWFH?=
 =?utf-8?B?bEhJbUV3Z0V3Q3BScnNvMURhM2FTOEhBdUxZM1RhcGtrUzF4TGFiZmozbDBK?=
 =?utf-8?B?bVlJNm5zV21IMnBjR3RqRWFRMkdJNjJMSHo2OXlKczFKWmR3N2xIKy9ZVTNn?=
 =?utf-8?B?VjZ2citueVA0YnJKcDV3SFdRRmlqczJpWTRtV0MvRlZLaGpWR2tFZDlIaHBv?=
 =?utf-8?B?aVlrZkc4ZkZyWWhaVkhIbmdQQlVXMmRUaDFJVWdOWWt2YStnTVR2dFNUWStr?=
 =?utf-8?B?RitURnhnN3VlaXo4b2NybStHQm82ampCbWtYMzlOMGYyNUdvbSsxSGdDSlNp?=
 =?utf-8?B?Q2ExOTlyc2FDakZRUlNJL0xuZEVPNklxTFN2M09KeWlJWFU0RTNTV3hPS3Bh?=
 =?utf-8?B?WWI0UGpOTU9zdmJWNUh5NkZFVFA1Q0Q0Yk9xaXEwTmdjZmx5UkhveldZMVFj?=
 =?utf-8?B?YlFITHFVM05UQ2dVLyt5aVdwa0NJSllwNW1LcHZiR3A2TFNzOWZyQ1dBUGt6?=
 =?utf-8?B?c0VYbS9SNXdZV1dSZlVYZktmVUZING44S1FQNFl2dGtNZzZrSFJoTjFLVE93?=
 =?utf-8?B?TFZOMFZ0ZmliSDdxdEhuRFo2OWNFdVVORkVncGZZVTIrVXB0Qkd6Z2crQ1Y1?=
 =?utf-8?B?ci90ZGN0azZLeWVvMGR4SWZzZjR1Rk1ldDZibGhXdi8xbzBTY2FvdUNEeFBk?=
 =?utf-8?B?MG5BMkg5MjV3c0pKTmxUSVBpU0M0ZG5CamgwZzc5dVhjaWNmYTlNOXZsRXUy?=
 =?utf-8?B?MWMwYkRhd1c4U3hrRDZwUG90VjMvcXUvaCtvV0s5RjRGckZBdTZwSTFySmJ6?=
 =?utf-8?B?NWFra3l6cEJtUW9WdWRoK3djbWpKcWhJZFV5VzFCblZ1bE1JWGJXbmY1eUt2?=
 =?utf-8?B?Nng4bGV5MlpUK2FiNVc4em5aRFIrWTVYSHVWd3pYbU1McVo0ZUlMRXhOSmpw?=
 =?utf-8?B?enVWUXJEcTJ0QkFuTHNMWm5OaGFPcWt4aXloZUN6T0ExT3hRUFNSU0FZcTJY?=
 =?utf-8?B?b0oyNVMrbDV2R2dsNXNhSEZxWVZYbFJRNm11UTFkQVU4MlVNYzVGNVAvYllV?=
 =?utf-8?B?dFhVUnk2bGhHbEFSMjFGOFZyNmNlRytLNlpGNkNJcG1rZUtKYTVpMkQzSkNF?=
 =?utf-8?B?NmhrN3dZZEEwcll0azBLRVJSSTJlR2Fsek5nakNib2lwaktLWlNaSHB1bVNV?=
 =?utf-8?B?VEdqajgwTVhzSmRBMEpHYXVDVHBZZzZKKzNvTTdZZUR0RGhJbnNjWmJWWEJK?=
 =?utf-8?B?djQxdTNsYzVzc3Ezd3A4bzRVeDdGNnA4RmQ4ZnJLZGk4YTdjNzZmWm5UcjVB?=
 =?utf-8?B?L1dQUXZIT2pYWkh1S00vY24zZklPTTNLeDJHSXpDbFNSWngwV2tqMmt2WVh3?=
 =?utf-8?B?RHBVbm01OG9UNk8wMG95WWpKbUZUWGFzdzB2M0RoSmQwcnZwaHpXM2RFNnpt?=
 =?utf-8?B?aG4yRnkvdXRhMUlvNnkyUnRZMVUwNzhuZG84V2VqQUp4VSszSmJBT1RhZzVn?=
 =?utf-8?B?ZGtEL3J1WXUzeFp0Zm1ibVB2SDR6S251N3VheHYzMm1GK3hqTm05a2h4VVVv?=
 =?utf-8?Q?PeNipUEiLTqClp7UYPhdSCqOvOlXajtLoBddaxh?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 545e9a15-a49f-4e84-e1b2-08d91904e560
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 07:25:07.1619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: enzYrld8zx4boqn3byISEU41+I7QRsCF4SjY7ewHATMuaEQ1aOo6A0jdMw602U9LNARxJh+x6K8ERY5IqZdG5em9VLZP4Ms7LoeQR5wwXpc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4484
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.05.21 06:07, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The i.MX8MM introduces an IP named BLK_CTL and usually is comprised of
> some GPRs.
> 
> The GPRs has some clock bits and reset bits, but here we take it
> as virtual PDs, because of the clock and power domain A/B lock issue
> when taking it as a clock controller.
> 
> For some bits, it might be good to also make it as a reset controller,
> but to i.MX8MM, we not add that support for now.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

As far as I can judge, this looks good:

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

> ---
>  drivers/soc/imx/Makefile  |   2 +-
>  drivers/soc/imx/blk-ctl.c | 307 ++++++++++++++++++++++++++++++++++++++
>  drivers/soc/imx/blk-ctl.h |  77 ++++++++++
>  3 files changed, 385 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/soc/imx/blk-ctl.c
>  create mode 100644 drivers/soc/imx/blk-ctl.h
> 
> diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
> index 078dc918f4f3..d3d2b49a386c 100644
> --- a/drivers/soc/imx/Makefile
> +++ b/drivers/soc/imx/Makefile
> @@ -4,4 +4,4 @@ obj-$(CONFIG_ARCH_MXC) += soc-imx.o
>  endif
>  obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
>  obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
> -obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o
> +obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o blk-ctl.o
> diff --git a/drivers/soc/imx/blk-ctl.c b/drivers/soc/imx/blk-ctl.c
> new file mode 100644
> index 000000000000..36556e8015bb
> --- /dev/null
> +++ b/drivers/soc/imx/blk-ctl.c
> @@ -0,0 +1,307 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2021 NXP.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +#include <linux/pm_domain.h>
> +#include <linux/reset-controller.h>
> +
> +#include "blk-ctl.h"
> +
> +static inline struct imx_blk_ctl_domain *to_imx_blk_ctl_pd(struct generic_pm_domain *genpd)
> +{
> +	return container_of(genpd, struct imx_blk_ctl_domain, pd);
> +}
> +
> +static int imx_blk_ctl_enable_hsk(struct device *dev)
> +{
> +	struct imx_blk_ctl *blk_ctl = dev_get_drvdata(dev);
> +	const struct imx_blk_ctl_hw *hw = &blk_ctl->dev_data->hw_hsk;
> +	struct regmap *regmap = blk_ctl->regmap;
> +	int ret;
> +
> +	if (hw->flags & IMX_BLK_CTL_PD_RESET) {
> +		ret = regmap_update_bits(regmap, hw->rst_offset, hw->rst_mask, hw->rst_mask);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = regmap_update_bits(regmap, hw->offset, hw->mask, hw->mask);
> +
> +	/* Wait for handshake */
> +	udelay(5);
> +
> +	return ret;
> +}
> +
> +int imx_blk_ctl_power_off(struct generic_pm_domain *domain)
> +{
> +	struct imx_blk_ctl_domain *pd = to_imx_blk_ctl_pd(domain);
> +	struct imx_blk_ctl *blk_ctl = pd->blk_ctl;
> +	struct regmap *regmap = blk_ctl->regmap;
> +	const struct imx_blk_ctl_hw *hw = &blk_ctl->dev_data->pds[pd->id];
> +	int ret;
> +
> +	mutex_lock(&blk_ctl->lock);
> +
> +	ret = clk_bulk_prepare_enable(blk_ctl->num_clks, blk_ctl->clks);
> +	if (ret) {
> +		mutex_unlock(&blk_ctl->lock);
> +		return ret;
> +	}
> +
> +	ret = regmap_clear_bits(regmap, hw->offset, hw->mask);
> +	if (ret)
> +		goto hsk_fail;
> +
> +	if (hw->flags & IMX_BLK_CTL_PD_RESET) {
> +		ret = regmap_clear_bits(regmap, hw->rst_offset, hw->rst_mask);
> +		if (ret)
> +			goto hsk_fail;
> +	}
> +
> +	blk_ctl->power_count--;
> +
> +	if (!blk_ctl->power_count) {
> +		ret = imx_blk_ctl_enable_hsk(blk_ctl->dev);
> +		if (ret)
> +			dev_err(blk_ctl->dev, "Handshake failed when power off\n");
> +	}
> +
> +hsk_fail:
> +	clk_bulk_disable_unprepare(blk_ctl->num_clks, blk_ctl->clks);
> +
> +	mutex_unlock(&blk_ctl->lock);
> +
> +	return ret;
> +}
> +
> +int imx_blk_ctl_power_on(struct generic_pm_domain *domain)
> +{
> +	struct imx_blk_ctl_domain *pd = to_imx_blk_ctl_pd(domain);
> +	struct imx_blk_ctl *blk_ctl = pd->blk_ctl;
> +	struct regmap *regmap = blk_ctl->regmap;
> +	const struct imx_blk_ctl_hw *hw = &blk_ctl->dev_data->pds[pd->id];
> +	int ret;
> +
> +	mutex_lock(&blk_ctl->lock);
> +
> +	ret = clk_bulk_prepare_enable(blk_ctl->num_clks, blk_ctl->clks);
> +	if (ret) {
> +		mutex_unlock(&blk_ctl->lock);
> +		return ret;
> +	}
> +
> +	if (!blk_ctl->power_count) {
> +		ret = imx_blk_ctl_enable_hsk(blk_ctl->dev);
> +		if (ret) {
> +			dev_err(blk_ctl->dev, "Handshake failed when power on\n");
> +			goto disable_clk;
> +		}
> +	}
> +
> +	if (hw->flags & IMX_BLK_CTL_PD_RESET) {
> +		ret = regmap_clear_bits(regmap, hw->rst_offset, hw->rst_mask);
> +		if (ret)
> +			goto disable_clk;
> +	}
> +
> +	/* Wait for reset propagate */
> +	udelay(5);
> +
> +	if (hw->flags & IMX_BLK_CTL_PD_RESET) {
> +		ret = regmap_update_bits(regmap, hw->rst_offset, hw->rst_mask, hw->rst_mask);
> +		if (ret)
> +			goto disable_clk;
> +	}
> +
> +	ret = regmap_update_bits(regmap, hw->offset, hw->mask, hw->mask);
> +	if (ret)
> +		goto disable_clk;
> +
> +	blk_ctl->power_count++;
> +
> +disable_clk:
> +	clk_bulk_disable_unprepare(blk_ctl->num_clks, blk_ctl->clks);
> +
> +	mutex_unlock(&blk_ctl->lock);
> +
> +	return ret;
> +}
> +
> +static int imx_blk_ctl_attach_pd(struct device *dev, struct device **devs, char **pd_names,
> +				 u32 num_pds)
> +{
> +	int i, ret;
> +
> +	if (!pd_names)
> +		return -EINVAL;
> +
> +	if (dev->pm_domain) {
> +		devs[0] = dev;
> +		pm_runtime_enable(dev);
> +		return 0;
> +	}
> +
> +	for (i = 0; i < num_pds; i++) {
> +		devs[i] = dev_pm_domain_attach_by_name(dev, pd_names[i]);
> +		if (IS_ERR_OR_NULL(devs[i])) {
> +			ret = PTR_ERR(devs[i]) ? : -ENODATA;
> +			goto detach_pm;
> +		}
> +	}
> +
> +	return 0;
> +
> +detach_pm:
> +	for (i--; i >= 0; i--)
> +		dev_pm_domain_detach(devs[i], false);
> +
> +	return ret;
> +}
> +
> +static int imx_blk_ctl_register_pd(struct device *dev)
> +{
> +	struct imx_blk_ctl *blk_ctl = dev_get_drvdata(dev);
> +	const struct imx_blk_ctl_dev_data *dev_data = blk_ctl->dev_data;
> +	int num = dev_data->pds_num;
> +	struct imx_blk_ctl_domain *domain;
> +	int i, ret;
> +
> +	blk_ctl->onecell_data.num_domains = num;
> +	blk_ctl->onecell_data.domains = devm_kcalloc(dev, num,
> +						     sizeof(struct generic_pm_domain *),
> +						     GFP_KERNEL);
> +
> +	if (!blk_ctl->onecell_data.domains)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < num; i++) {
> +		domain = devm_kzalloc(dev, sizeof(*domain), GFP_KERNEL);
> +		if (!domain) {
> +			ret = -ENOMEM;
> +			goto remove_genpd;
> +		}
> +		domain->pd.name = dev_data->pds[i].name;
> +		domain->pd.power_off = imx_blk_ctl_power_off;
> +		domain->pd.power_on = imx_blk_ctl_power_on;
> +		domain->blk_ctl = blk_ctl;
> +		domain->id = i;
> +
> +		ret = pm_genpd_init(&domain->pd, NULL, true);
> +		if (ret)
> +			goto remove_genpd;
> +
> +		blk_ctl->onecell_data.domains[i] = &domain->pd;
> +	}
> +
> +	return 0;
> +
> +remove_genpd:
> +	for (i = i - 1; i >= 0; i--)
> +		pm_genpd_remove(blk_ctl->onecell_data.domains[i]);
> +
> +	return ret;
> +}
> +
> +static int imx_blk_ctl_hook_pd(struct device *dev)
> +{
> +	struct imx_blk_ctl *blk_ctl = dev_get_drvdata(dev);
> +	const struct imx_blk_ctl_dev_data *dev_data = blk_ctl->dev_data;
> +	const struct imx_blk_ctl_hw *pds = dev_data->pds;
> +	int num_active_pd = dev_data->num_active_pd;
> +	int num = dev_data->pds_num;
> +	struct generic_pm_domain *genpd, *child_genpd;
> +	int ret;
> +	int i, j;
> +
> +	blk_ctl->active_pds = devm_kcalloc(dev, num_active_pd, sizeof(struct device *), GFP_KERNEL);
> +	if (!blk_ctl->active_pds)
> +		return -ENOMEM;
> +
> +	ret = imx_blk_ctl_attach_pd(dev, blk_ctl->active_pds, dev_data->active_pd_names,
> +				    num_active_pd);
> +	if (ret) {
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "Failed to attach active pd: %d\n", ret);
> +		return ret;
> +	}
> +
> +	for (i = 0; i < num; i++) {
> +		for (j = 0; j < num_active_pd; j++) {
> +			genpd = pd_to_genpd(blk_ctl->active_pds[j]->pm_domain);
> +			if (!strcmp(genpd->name, pds[i].parent_name))
> +				break;
> +		}
> +
> +		child_genpd = blk_ctl->onecell_data.domains[i];
> +		if (pm_genpd_add_subdomain(genpd, child_genpd))
> +			pr_warn("failed to add subdomain: %s\n", child_genpd->name);
> +	}
> +
> +	return 0;
> +}
> +
> +int imx_blk_ctl_register(struct device *dev)
> +{
> +	struct imx_blk_ctl *blk_ctl = dev_get_drvdata(dev);
> +	const struct imx_blk_ctl_dev_data *dev_data = blk_ctl->dev_data;
> +	int num = dev_data->pds_num;
> +	int i, ret;
> +
> +	if (!blk_ctl)
> +		return -ENODEV;
> +
> +	ret = imx_blk_ctl_register_pd(dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = imx_blk_ctl_hook_pd(dev);
> +	if (ret)
> +		goto unregister_pd;
> +
> +	ret = of_genpd_add_provider_onecell(dev->of_node, &blk_ctl->onecell_data);
> +	if (ret)
> +		goto detach_pd;
> +
> +	pm_runtime_get_noresume(dev);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +
> +	pm_runtime_put(dev);
> +
> +	return 0;
> +
> +detach_pd:
> +	for (i = blk_ctl->dev_data->num_active_pd; i >= 0; i--)
> +		dev_pm_domain_detach(blk_ctl->active_pds[i], false);
> +unregister_pd:
> +	for (i = num - 1; i >= 0; i--)
> +		pm_genpd_remove(blk_ctl->onecell_data.domains[i]);
> +
> +	if (dev->pm_domain)
> +		pm_runtime_disable(dev);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(imx_blk_ctl_register);
> +
> +const struct dev_pm_ops imx_blk_ctl_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +			   pm_runtime_force_resume)
> +};
> +EXPORT_SYMBOL_GPL(imx_blk_ctl_pm_ops);
> diff --git a/drivers/soc/imx/blk-ctl.h b/drivers/soc/imx/blk-ctl.h
> new file mode 100644
> index 000000000000..7a950ea9fb85
> --- /dev/null
> +++ b/drivers/soc/imx/blk-ctl.h
> @@ -0,0 +1,77 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __SOC_IMX_BLK_CTL_H
> +#define __SOC_IMX_BLK_CTL_H
> +
> +enum imx_blk_ctl_pd_type {
> +	BLK_CTL_PD,
> +};
> +
> +struct imx_blk_ctl_hw {
> +	int type;
> +	char *name;
> +	char *parent_name;
> +	u32 offset;
> +	u32 mask;
> +	u32 flags;
> +	u32 id;
> +	u32 rst_offset;
> +	u32 rst_mask;
> +};
> +
> +struct imx_blk_ctl_domain {
> +	struct generic_pm_domain pd;
> +	struct imx_blk_ctl *blk_ctl;
> +	u32 id;
> +};
> +
> +struct imx_blk_ctl_dev_data {
> +	struct regmap_config config;
> +	struct imx_blk_ctl_hw *pds;
> +	struct imx_blk_ctl_hw hw_hsk;
> +	u32 pds_num;
> +	char **active_pd_names;
> +	u32 num_active_pd;
> +};
> +
> +struct imx_blk_ctl {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct device **active_pds;
> +	u32 pds_num;
> +	u32 active_pd_count;
> +	struct genpd_onecell_data onecell_data;
> +	const struct imx_blk_ctl_dev_data *dev_data;
> +	struct clk_bulk_data *clks;
> +	u32 num_clks;
> +
> +	struct mutex lock;
> +	int power_count;
> +};
> +
> +#define IMX_BLK_CTL(_type, _name, _parent_name, _id, _offset, _mask, _rst_offset, _rst_mask,	\
> +		    _flags)								\
> +	{										\
> +		.type = _type,								\
> +		.name = _name,								\
> +		.parent_name = _parent_name,						\
> +		.id = _id,								\
> +		.offset = _offset,							\
> +		.mask = _mask,								\
> +		.flags = _flags,							\
> +		.rst_offset = _rst_offset,						\
> +		.rst_mask = _rst_mask,							\
> +	}
> +
> +#define IMX_BLK_CTL_PD(_name, _parent_name, _id, _offset, _mask, _rst_offset, _rst_mask, _flags) \
> +	IMX_BLK_CTL(BLK_CTL_PD, _name, _parent_name, _id, _offset, _mask, _rst_offset,		\
> +		    _rst_mask, _flags)
> +
> +int imx_blk_ctl_register(struct device *dev);
> +
> +#define IMX_BLK_CTL_PD_HANDSHAKE	BIT(0)
> +#define IMX_BLK_CTL_PD_RESET		BIT(1)
> +#define IMX_BLK_CTL_PD_BUS		BIT(2)
> +
> +const extern struct dev_pm_ops imx_blk_ctl_pm_ops;
> +
> +#endif
> 
