Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75CEE37289E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 12:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhEDKRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 06:17:51 -0400
Received: from mail-eopbgr00130.outbound.protection.outlook.com ([40.107.0.130]:51437
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230153AbhEDKRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 06:17:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OyTpIbY3AgAGe/xOPBbPpaD2lrDMdPbwglqn2WscR9rCsZhSr9Qfb6unnFh1giWeWpvGlFbsDjemb2TozAZkKGjThkIOCGE2cCTNX27KGqrJJhtFX8m/tzbnoMjrsHSu7N8bN6pOzU2DqZy/c/tO7uA6QwCWnYcNW6bGR0uK+mQRCccSMIfvITixRy9mHfilFXsEPr4ZkRz1ysDxed1fbj2dlDNJqYd0bbUnJOr54+X9OCb0S2UQdSKXzRJLnuxfRUC2bf1epVgfH++CuVju/w2jNhW6+pw4a1SQuFeIf+fRP+Mz321ynzrWMMyXaJD0/RMFqHIzcjlwmcihhfR7Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0rh3Dnqcm/cz854vgyMhWHkZs2csQza3fUEfjJwYmE=;
 b=MfgV9dDOkw7BSUB7WrrQJRYVFtLiwUzPh6lK/48GcdRy27mCVsuHLaeOrKSkTpD+kLc8nsANgO3UmSkTsvNG3mC4fezhV9Yz6GVbSAOoa8np0x+66/FRf3QFO1TtFyjINVHrS8ftsk7n4afw+VdBK3FpAAR1z1MqYRIOEOBBbqe7LF9QbtZOl9NqSkzP1QFaaqnzf+RG5ep7OvRbafVqrQv22UjAfp7jKaxWb7a+YI2uVoM9nQL/rKqfnxAwhDe3Se1HgV+9x9xIZBmQ9X8m1N/HaB+B4xFkfbPrxuoBNaVcaxq3QKM3/e8tcuV85X5jFRA0JtAe//cB8VA5Rl8lmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0rh3Dnqcm/cz854vgyMhWHkZs2csQza3fUEfjJwYmE=;
 b=n3wwqhER3HW3uL2hW1vxJ+PXgvgMFyC5jpjktxiOosD6wZnomiROidAsrfEyeO1c03kvfkSAL0Uaejp4xTIqJbdXukGrBjkCiNrK4dFBUwgZGiyKtYecvQxnFsgEODl4lhFHkYpvyazpUd1kOl1p1jN0Rzk1BCu5UQXZnmwUIPo=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM0PR10MB3105.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:129::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26; Tue, 4 May
 2021 10:16:51 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87%7]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 10:16:51 +0000
Subject: Re: [PATCH V2 3/4] soc: imx: Add generic blk-ctl driver
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com, aford173@gmail.com,
        abel.vesa@nxp.com, Peng Fan <peng.fan@nxp.com>
References: <20210430052746.10815-1-peng.fan@oss.nxp.com>
 <20210430052746.10815-4-peng.fan@oss.nxp.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <46b64f2f-4dfd-88d6-77ea-68bc844eee7e@kontron.de>
Date:   Tue, 4 May 2021 12:16:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210430052746.10815-4-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [89.244.177.213]
X-ClientProxiedBy: AM0PR03CA0003.eurprd03.prod.outlook.com
 (2603:10a6:208:14::16) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.27] (89.244.177.213) by AM0PR03CA0003.eurprd03.prod.outlook.com (2603:10a6:208:14::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend Transport; Tue, 4 May 2021 10:16:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e820e5f-2992-4af9-320f-08d90ee5bbf7
X-MS-TrafficTypeDiagnostic: AM0PR10MB3105:
X-Microsoft-Antispam-PRVS: <AM0PR10MB310545B2787F2E557C7B521BE95A9@AM0PR10MB3105.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NObz7ZsGLytVmfjv2whlk7fgFgEZnc3Mvhuz+Nw8yGR9bg54yLm1TgJqR79ORaYb6QTo+2yw+1KNrUfa+5cQSltkCJZIhdYfEBrmN2YxMPfP0NGGf8/KQONux7mNd8AeGPRFYPfYRIIijZrXuGX8y3xVWAlWcotvaJBWsF/feWu7whUZkXYgPt4hWj5QdOwyPdLieUdhy1OW/ob30c+RTRx7VJBZ3eRaNAs3Vd5sugUhDnz4i/dv7UYy18ncbBe2UoTwZKk2ylTG7X9GdgvnQnmYNTVqw5KHye+2+C/NfzT9PFnTGPnSmiGo9cOpexxD/6M9jOktuTvDM1vpn3eq7U3UhQRqRnXdXCkezb9ttEJU+i8zaFcaae5zBnF/iijjamXkNgoMA0O3NxbYJMmgkSVpyMpKs60i3FNPPJ4bypZIaIhhIsgfCUgMcIom6TDhDiKhNxhHj6ibikeKszycxbRRBMGJR4RzyVp3Cq5MEFoCvpo0Xa7nIW+ojs6ZNnjfxMUEeUEVvtRQyC3jzaVe0F8Ki6CDeWwUksQ/6y06iXDwa1DL8/lG66R6FtZsJ1uk7o3TAPXG+mLz1HM+/3NN20gtbiOf7xZwX1KikpMwCDkCTrsc2DOjpSAezrwlJKFwU7gGVGe+liSGv+EIGddv1L0bDLM7eNctxVnyoG7N3hD+8eL/ZHSdzapkCHJgD+I8sFX30IRE0ro3lCRsr8hNkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(498600001)(186003)(26005)(4326008)(2906002)(16526019)(44832011)(86362001)(31696002)(5660300002)(36756003)(8676002)(2616005)(30864003)(7416002)(956004)(16576012)(8936002)(66946007)(66476007)(66556008)(6486002)(31686004)(53546011)(38100700002)(83380400001)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?blh5MHVYQ09BMGQwbE52Vi9vaG5QeWNFMC81YUhRK2pqZ0J3NUpXYlkvckk2?=
 =?utf-8?B?V0RQOERUUFkxM3ArcU53WmRVRUVEU0NRbzNqVDExMlFHNCtnUUlETFF5MlFT?=
 =?utf-8?B?K3ozM0JodytSblhqV3pxblljREJlV0lqbjY0YThvUTFnc0w2c0k5WjVKV2Vo?=
 =?utf-8?B?VzY0UnZjUlFqbE92UzJlU2N1dHdpZndLN3NEUHhIa1MwTnJXM2FTeG96azM2?=
 =?utf-8?B?dEJJWkpPWFpTR29ab3NvTko3RXNIZThFN0ZMS05uZDdMRXZUNVBrWTN5Szcx?=
 =?utf-8?B?WCsycDR4ZTZVTmljL1pOZzNnK0l3R1VoOVd2dTEvSkc3Nmc1ZnNNWVQvbXVW?=
 =?utf-8?B?Q0Z2NDhzUFN6em5JZ3dSSnhCdGZtcHRvUjlSY1dpV1BuTnI1NU0vcW5vZEpE?=
 =?utf-8?B?WFZ6ejZ6S1pLeFIyTmdPL3d5RXlKeVJiVDZxUXV3bkFpaGFabFRId2luTFl6?=
 =?utf-8?B?RysvQ1dMekdqaEdpclRISVhLWmsrd2VWQXVYU2lvdGNLdHBmYldYK3dNSnNj?=
 =?utf-8?B?eWVIbHZheTczS2VOeFJodHp3aEZuSFJ1dmlVL29MYWNQT1l2MlpEdXh6dFZC?=
 =?utf-8?B?bEpBcExjdVpMNEt1MjE3MTBMaE5EWlUxNHJjbm45MGlUWlgxaGE3V2wrbUF6?=
 =?utf-8?B?S0MzLzVVUkFJK3FUWFB4TnhXU3hpK0IyR3U3N1crOFd1UHB1U29zZWc3TmRy?=
 =?utf-8?B?NHRXSDczWG1mdE12MHhUTFV6NDdhRnBoWXVTOUQ3LzhIQlN6ODRZeU4wRzBC?=
 =?utf-8?B?Sy9aZWpUNFFwcmdVV3pCTUpQOHNaMnVKYlplSVRQdmV1K0xRQ0VJc2ZoNC9s?=
 =?utf-8?B?U25aTFE4R3RkbWJVZWFLanJ4Sng0MXZzMkZZQ2FRK3R5K3htMVdjWVZRaUlZ?=
 =?utf-8?B?TythWEkxN2prV3lGSWpGWTBzUCs3a1NKMG5sSG9RTjI4NWduaXdsNXhFeCs5?=
 =?utf-8?B?dmhUbGlnN0tNa3h5R0Y4ZXBacDhySktjV3FxalA3QUREL0xTbisxQ1lvK0tM?=
 =?utf-8?B?bUE4OUtSc0NlYVQ0ejBtVmt0MjlBZk52TjJUeHZMbitZQmw1dkxlUFlrVjZo?=
 =?utf-8?B?YUZvK0VnZGE3MmpUQ1VnbWFFTnNkWHlqa0xjTTYzV2tseGlrVkZqa3ZkdDNN?=
 =?utf-8?B?NWxJVmJFdW9Nb1pCalJSZVFidis5Y1pGelQ3c1VKU05uRzNpUE9VbzZHMk5N?=
 =?utf-8?B?ZEdqdUU4R0FmSGIvS3dRNyszeHBPMVVGZHJxbXJWTTdtczErdHZxRmhNWXA2?=
 =?utf-8?B?bFJLVU9PZlJGaHg0MzU1YStMNC9OQlVTT0c5YkF5TjNEVU1QNGdlSkRoOFgr?=
 =?utf-8?B?NjZEUWd2bmY4c2NPT0RVOWNtUm5YT3NEZG01Z3NmTHMxRmZUN3k4eVlCUkRX?=
 =?utf-8?B?TEVvMkJ2OEYvUVRyeWh2b1d6ZEJLN2pyWnl0NjJ5ZHA5eU5uTnJEZ2RWa3hD?=
 =?utf-8?B?SFBPMzNUaDZiNko2UkdjU2lYdTFzOHkzdGlSeTFsK3dzUUpxODFEeUFKRTB0?=
 =?utf-8?B?ZHRKcEhFYlNLTGVFZTJqZHl1S1g2anJqZGZwTUloWjNFdEVaeWgreU9RV2Fh?=
 =?utf-8?B?UGRqZEpxdS9VK2JZS1ZIYW1JRHlteTRUZEtySFVqeFlnSzBVNDd4MldKcTlS?=
 =?utf-8?B?eXZmbkxBczJPSENLbEdmNjZLZkpvTWhYN0UxUzcxT1E0YkNEZnY4ZDBBVytm?=
 =?utf-8?B?aDBIUDZoNUZ3Qmk5a2JGQThVb0RaZmZ5aHJFOVV2N3lNR3hscko4d0RQZ1dU?=
 =?utf-8?Q?sL/M/n0fvpvFzuWXJYMh+sI9p6BGiFQasgEI69W?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e820e5f-2992-4af9-320f-08d90ee5bbf7
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 10:16:51.6073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xIVeJ7vMT2TRDMZFM8HgRAsQpthAtE4s2S897OC8Zo6qhpkV6dYmCTS3Q0aDH00nRmdeOnlZd4m+nMFa4ZY6HCcyMNLgjM68nqSWrjeQIgc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3105
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.04.21 07:27, Peng Fan (OSS) wrote:
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
> ---
>   drivers/soc/imx/Makefile  |   2 +-
>   drivers/soc/imx/blk-ctl.c | 303 ++++++++++++++++++++++++++++++++++++++
>   drivers/soc/imx/blk-ctl.h |  76 ++++++++++
>   3 files changed, 380 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/soc/imx/blk-ctl.c
>   create mode 100644 drivers/soc/imx/blk-ctl.h
> 
> diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
> index 078dc918f4f3..d3d2b49a386c 100644
> --- a/drivers/soc/imx/Makefile
> +++ b/drivers/soc/imx/Makefile
> @@ -4,4 +4,4 @@ obj-$(CONFIG_ARCH_MXC) += soc-imx.o
>   endif
>   obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
>   obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
> -obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o
> +obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o blk-ctl.o
> diff --git a/drivers/soc/imx/blk-ctl.c b/drivers/soc/imx/blk-ctl.c
> new file mode 100644
> index 000000000000..1f764dfd308d
> --- /dev/null
> +++ b/drivers/soc/imx/blk-ctl.c
> @@ -0,0 +1,303 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2021 NXP.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
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
> +

Only one blank line here.

> +	if (hw->flags & IMX_BLK_CTL_PD_RESET)
> +		ret = regmap_update_bits(regmap, hw->rst_offset, hw->rst_mask, hw->rst_mask);

The return value above gets discarded.

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
> +	struct imx_blk_ctl_domain *pd;
> +	struct imx_blk_ctl *blk_ctl;
> +	const struct imx_blk_ctl_hw *hw;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	pd = to_imx_blk_ctl_pd(domain);
> +	blk_ctl = pd->blk_ctl;
> +	regmap = blk_ctl->regmap;
> +	hw = &blk_ctl->dev_data->pds[pd->id];

You could include the assignments above in the declarations.

> +
> +	ret = clk_bulk_prepare_enable(blk_ctl->num_clks, blk_ctl->clks);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(regmap, hw->offset, hw->mask, 0);

You could use regmap_clear_bits() here.

> +	if (ret)
> +		goto hsk_fail;
> +
> +	if (hw->flags & IMX_BLK_CTL_PD_RESET)
> +		ret = regmap_update_bits(regmap, hw->rst_offset, hw->rst_mask, 0);

You could use regmap_clear_bits() here.
And the return value of regmap_update_bits() potentially gets discarded.

> +
> +	if (atomic_dec_and_test(&blk_ctl->power_count)) {
> +		ret = imx_blk_ctl_enable_hsk(blk_ctl->dev);
> +		if (ret) {
> +			dev_err(blk_ctl->dev, "Hankshake fail\n");

s/Hankshake fail/Handshake failed/

> +			goto hsk_fail;

This goto is redundant.

> +		}
> +	}
> +
> +hsk_fail:
> +	clk_bulk_disable_unprepare(blk_ctl->num_clks, blk_ctl->clks);
> +
> +	return ret;
> +}
> +
> +int imx_blk_ctl_power_on(struct generic_pm_domain *domain)
> +{
> +	struct imx_blk_ctl_domain *pd;
> +	struct regmap *regmap;
> +	const struct imx_blk_ctl_hw *hw;
> +	int ret;
> +	struct imx_blk_ctl *blk_ctl;
> +
> +	pd = to_imx_blk_ctl_pd(domain);
> +	blk_ctl = pd->blk_ctl;
> +	regmap = blk_ctl->regmap;
> +	hw = &blk_ctl->dev_data->pds[pd->id];

You could include the assignments above in the declarations.

> +
> +	ret = clk_bulk_prepare_enable(blk_ctl->num_clks, blk_ctl->clks);
> +	if (ret)
> +		return ret;
> +
> +	if ((atomic_read(&blk_ctl->power_count) == 0)) {
> +		ret = imx_blk_ctl_enable_hsk(blk_ctl->dev);
> +		if (ret) {
> +			dev_err(blk_ctl->dev, "Hankshake fail\n");

s/Hankshake fail/Handshake failed/

> +			goto disable_clk;
> +		}
> +	}
> +
> +	if (hw->flags & IMX_BLK_CTL_PD_RESET)
> +		ret = regmap_update_bits(regmap, hw->rst_offset, hw->rst_mask, 0);

You could use regmap_clear_bits() here.
And the return value of regmap_update_bits() gets discarded.

> +
> +	/* Wait for reset propagate */
> +	udelay(5);
> +
> +	if (hw->flags & IMX_BLK_CTL_PD_RESET)
> +		ret = regmap_update_bits(regmap, hw->rst_offset, hw->rst_mask, hw->rst_mask);

The return value above gets discarded.

> +
> +	ret = regmap_update_bits(regmap, hw->offset, hw->mask, hw->mask);
> +	if (ret)
> +		goto disable_clk;
> +
> +	atomic_inc(&blk_ctl->power_count);
> +
> +disable_clk:
> +	clk_bulk_disable_unprepare(blk_ctl->num_clks, blk_ctl->clks);
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
> +		return 0;
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

It looks like you should add pm_runtime_disable() in this error path to 
not leave the pm_runtime_enable() unmatched.

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
> +			return ret;

Looks like you should use the error path here and "goto remove_genpd" 
instead of return.

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
> +		if (ret == -EPROBE_DEFER)
> +			return ret;
> +		dev_err(dev, "Failed to attach active pd: %d\n", ret);
> +		return ret;

I think it would be better to do it the other way round:

                 if (ret != -EPROBE_DEFER)
	            dev_err(dev, "Failed to attach active pd: %d\n", ret);
                 return ret;

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
> +			pr_warn("failed to add subdomain:\n");

Remove the colon add the end of the warning message or add something 
after it.

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
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(imx_blk_ctl_register);
> +
> +static int __maybe_unused imx_blk_ctl_runtime_suspend(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static int __maybe_unused imx_blk_ctl_runtime_resume(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +const struct dev_pm_ops imx_blk_ctl_pm_ops = {
> +	SET_RUNTIME_PM_OPS(imx_blk_ctl_runtime_suspend,
> +			   imx_blk_ctl_runtime_resume, NULL)
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +			   pm_runtime_force_resume)
> +};
> +EXPORT_SYMBOL_GPL(imx_blk_ctl_pm_ops);
> diff --git a/drivers/soc/imx/blk-ctl.h b/drivers/soc/imx/blk-ctl.h
> new file mode 100644
> index 000000000000..e736369406a1
> --- /dev/null
> +++ b/drivers/soc/imx/blk-ctl.h
> @@ -0,0 +1,76 @@
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
> +	atomic_t power_count;
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
