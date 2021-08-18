Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683053F07A9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 17:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239854AbhHRPPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 11:15:18 -0400
Received: from mail-eopbgr130081.outbound.protection.outlook.com ([40.107.13.81]:16132
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239770AbhHRPPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 11:15:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gosNuIANmw/vUYoEa6NCsm21P3Ze5d5iZT6Gj+qpXE2RZO5Bagj1R428ZufUrUdZC59p4mQ3yNrYyKonnkAKjvAbb+nIluAuw9cmqj43V1UDFdQy+1zGPUVqtRjFmFhXJpqpw5Z+41FjX8rmAQuDZyXXq+XTHGsNxUx+YmsP4HI+CaPrL2nbyaNq49IX6jzs52kFaSLDIo5jdZDEDsSz7Jos9lx5+5+susuXrJjHHGGPjFJ7VpR26Hjld9eUn8btjkIRPPcXkMCZfnaM+1BGOfi/iNbz5j2kyjHNJYnngV3Ej3CmGUj1bDlNuih//ZK0OxD4+GpfrmS1aFa23bPwJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPySLwr76+b3mWU1HC1oYCvxyK69mIcView8sL7WGu8=;
 b=a3IAto/RtXtfiR749wy7TVHY+ixUXPzFnBRSs2kaS+Q0g3JNZ72FTBEBSHVpha3XipuqWT5ONF7UEhHDN4i3HAq8HKvkFQsSG4tlV44RsLIHNImXoFgN+/04d96+8ZupHNYLygfNuW8Ted9KLVz+15MP2avD9mR6NiOBB1b7S1pYsQW3E8XlY57VYRC9uUANFoP3tOmlXvQY9HtTV9O0hd30NilCqak3aQtTJrmKsjWKlO5s/9Dg6LYjqk6qP67u5EbDBtkW7niRvsVfxaZFCOXinA0+wKShJut9ESwDIIneErysfl7VO8TCyvE7ukR0aUCmtSCPfEAdSTYQJhS14g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPySLwr76+b3mWU1HC1oYCvxyK69mIcView8sL7WGu8=;
 b=pQDfUGenomTcYszTwB0r9CR9Fv9kXuGYXPQbajYkTVqbLRUhh3Kj0RjYPEqFwG0CEqz7lyveKoAmKZQ7cItDbrCIhlMah/266iiHihOpaMk9sJnsaRBSULBs2MgO6hob79ppSSnA/uQ4zZnnr9m60b6ujb7hHHESlb2gLvj8j24=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0401MB2559.eurprd04.prod.outlook.com (2603:10a6:800:57::8)
 by VE1PR04MB6749.eurprd04.prod.outlook.com (2603:10a6:803:129::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Wed, 18 Aug
 2021 15:14:39 +0000
Received: from VI1PR0401MB2559.eurprd04.prod.outlook.com
 ([fe80::1dc0:b737:bf34:46b]) by VI1PR0401MB2559.eurprd04.prod.outlook.com
 ([fe80::1dc0:b737:bf34:46b%3]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 15:14:39 +0000
Date:   Wed, 18 Aug 2021 18:14:35 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH] clk: imx8m: fix clock tree update of TF-A managed clocks
Message-ID: <YR0j21KspR618YLK@ryzen>
References: <20210810151432.9228-1-a.fatoum@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810151432.9228-1-a.fatoum@pengutronix.de>
X-ClientProxiedBy: VI1PR0102CA0031.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::44) To VI1PR0401MB2559.eurprd04.prod.outlook.com
 (2603:10a6:800:57::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ryzen (188.27.180.28) by VI1PR0102CA0031.eurprd01.prod.exchangelabs.com (2603:10a6:802::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Wed, 18 Aug 2021 15:14:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1c9e0bb-f2e8-473f-48bf-08d9625ae536
X-MS-TrafficTypeDiagnostic: VE1PR04MB6749:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB674928A6C95A713E530BF25AF6FF9@VE1PR04MB6749.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LjOEB5aJRYj9m08SCnmFyqe9uZEhF0aL164LAzp+e4zQKs2LrALRVqxv6GMrQaIq5R49rH/bQ05xDq7c5vTgHWQLUIjeLhF8b88KYVBQljNmh0LqusiHqCBvKhjA1zND+5AKngdCK6SRI9KJhf1E9h7JPoSwgEHQqNMRkj18BeP2HqVnKjUwFm4hS6sPnrXQFI0D3Oze1cWfB8CVj7U8hsBuvIQvtFpinHWFTLcejV4M/qGTfX5ao2hkkD19nEtlLr3/Yw8q4E+Su/ag7MWVEg7hgvKYd/oCPaMgSBuDO2mQzsd+NthgG9mmWpb4Pg3Uv+AzkKXp5+0QIulU9otEWRkwiCdsiA5kUGwN/R6Wv3md9RlBldwzXH6+94n9sFI4MAlNH+tPCDla7vOGTxVZQvYAfmziw33BTjN4tndFIR2BuWzWmfWHPG8/x7xYRIUedAHcBFTYqlxt+/mSsEaP9bA5NYl8C1A6clXQrgyO0dh8FV9ip7JN+yJ/ql5mH9rHi0g23QliDg+WoDaG3zBOpZ/7Ak6K5/wV1G1Ebdt4qQV3+JGtldkElaf+Vz1omDIhrM6mLyoFHMKJVgK729vDi5FEgk9b5SrnzdhlvsUEnzseBwwjXwV20V3mx2on907cZeDh6z5cVXemtTNKRvU/MfK4t3Qt83wRI9e5Xl/Kd5dMaKJCeuNGpD+LpiJjTLE0pdDhmBp3eIpriXAnGbZTzRj8cAvxXUBSeYL6ZCjFMrw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2559.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(8676002)(38350700002)(86362001)(2906002)(38100700002)(54906003)(8936002)(7416002)(9576002)(83380400001)(9686003)(186003)(66476007)(55016002)(4326008)(6916009)(5660300002)(6496006)(44832011)(66556008)(478600001)(33716001)(53546011)(956004)(316002)(66946007)(26005)(52116002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uO/qu6ZlrXUdMcZcLFj3vzSDM6C2upRejDM0TWmdBblzzsPIHODPV9iK+wL5?=
 =?us-ascii?Q?Uk6tG7nGvNIr66/57DGbD2LZy51dvO14c7AzUnc9Tx1mepI/EsgK5q6fXcV8?=
 =?us-ascii?Q?kREASOTqsrthPKMzMvH5Kb/GQGXG4uD1W9KO8UIxK+o6s2cwbE3T0wr/AyNP?=
 =?us-ascii?Q?zAsVTJf2snSma7PJZMqo9DxQcnQPsMzOa9rK2ZxNKlnGW4gcA1LewxBsRWLL?=
 =?us-ascii?Q?Y4tj1SVHWBV0XHXYmOyQ/m7fz69ANN3gaOG82tEoI31grijJW5yLNSiAERLe?=
 =?us-ascii?Q?csPjDFfEEcYpDYQNlp+59mTMzNKU1kXlXQwmPdKQNGLZ7+ryOeT1RIWpyyKz?=
 =?us-ascii?Q?5+FWgxoV52loQs3E2Irp3Di/L4Hx8FRCy0YHcu299gYKaSo3bNgkMumSZuo6?=
 =?us-ascii?Q?vtuSNfPwLrpwHVSZz1w43OHFLozh037ATTOpGK5sR4q+eEFNEI1fEieAIgZj?=
 =?us-ascii?Q?izsxcmnWx++98oRlxYeLqcHhVukAgNAI13x1ZHmBYdqaxGT/12lnQZodRbY4?=
 =?us-ascii?Q?3L7jNu3f1Woou50JLM+UW2lNv+i28BvBfnSLwvAVbkuEKLoRuymct56THh+Y?=
 =?us-ascii?Q?s0IKG6d9lQBwarlU7YmJFoMOfKypBWDeZV8+OX+TsDwTcW2lYQ0nWCxSk4Wk?=
 =?us-ascii?Q?L7rE00SWjrJZOEN1DdD5i+AuJ8RggDIN0+KjTMHie6xKzIa4Tv2LmpPG58i0?=
 =?us-ascii?Q?fqMOi6384Lta51bXb9YTRiNloTa50nHmcD8oJhHSeu3QHDA7TWxD4JKQaKuE?=
 =?us-ascii?Q?SD/H3AcQIYr1efhhBRzsH7cVEIEc+lWJVvj8wf2iRLIiURDuHePhUTsrdLRV?=
 =?us-ascii?Q?kSAzPJtZnOLvsQVkFA51WOvdThtVC2K0qsN4js9ohpeY7tjCaoNgmz+2Jewi?=
 =?us-ascii?Q?nCVqEvBV0uy/kjTg+ETtUneL2drlhKOvoR7Kvvgt1+GhsGaTAkwmtRZ+Fbvl?=
 =?us-ascii?Q?A6Rxu47Br4GDDcAA01tv8TRQ6Q62/JApzYS5OMWPxOwIU88W2oN5D6ckNFs7?=
 =?us-ascii?Q?8TYQofslsYqu+VZ0thzfwFJhh58nTxUBTizeHAuQkV3zl1DNdJ+ZXXVdGFad?=
 =?us-ascii?Q?lVSN35yDSGnM1e5+hc2wJtAkyFD0OgWt9ctx6u9mXhVyeb+ra75QX22O7UNg?=
 =?us-ascii?Q?FvD+tsdXfjzloGLoG6PtT8hvscVJYvlPLUz0ERH53YC3+jcPWm/ruV2TG+nm?=
 =?us-ascii?Q?5rQjezdBXvttVfjZ0XUzYUY8b2BKSwmMQ8yLV40nPfjXtzx0ibbkhH9z0W2X?=
 =?us-ascii?Q?Z0Sen1sNdZ6M+ny8pbRGVqIKQHOa188pISQiIiiTu4ropbDvlKTpCeHJhLht?=
 =?us-ascii?Q?uD9zcSftjju72ldlbQz6xxVP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c9e0bb-f2e8-473f-48bf-08d9625ae536
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2559.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2021 15:14:38.7552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jhb2lFhZ5NKlpRXFhs86271Zm+fGVozP9ROZ5zoE4CDHGutUPUhKXn+YOMncrK7mcgE3kfB7SFkhzno6H25AYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6749
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-08-10 17:14:33, Ahmad Fatoum wrote:
> On the i.MX8M*, the TF-A exposes a SiP (Silicon Provider) service
> for DDR frequency scaling. The imx8m-ddrc-devfreq driver calls the
> SiP and then does clk_set_parent on the DDR muxes to synchronize
> the clock tree.
> 
> Since 936c383673b9 ("clk: imx: fix composite peripheral flags"),
> these TF-A managed muxes have SET_PARENT_GATE set, which results
> in imx8m-ddrc-devfreq's clk_set_parent after SiP failing with -EBUSY:
> 
> 	echo 25000000 > userspace/set_freq
> 	imx8m-ddrc-devfreq 3d400000.memory-controller: failed to set
> 		dram_apb parent: -16
> 
> Fix this by adding a new i.MX composite flag for firmware managed
> clocks, which clears SET_PARENT_GATE.
> 
> This is safe to do, because updating the Linux clock tree to reflect
> reality will always be glitch-free.
> 
> Fixes: 936c383673b9 ("clk: imx: fix composite peripheral flags")
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

I'm OK with this.

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

BTW, let me know if you are interested in the interconnect+devfreq
(the replacement for NXP's internal busfreq). I have a new version of
that patchset which I intend to send soon for review.

> ---
> To: Abel Vesa <abel.vesa@nxp.com>
> To: Michael Turquette <mturquette@baylibre.com>
> To: Stephen Boyd <sboyd@kernel.org>
> To: Shawn Guo <shawnguo@kernel.org>
> To: Sascha Hauer <s.hauer@pengutronix.de>
> To: Pengutronix Kernel Team <kernel@pengutronix.de>
> To: Fabio Estevam <festevam@gmail.com>
> To: NXP Linux Team <linux-imx@nxp.com>
> To: Peng Fan <peng.fan@nxp.com>
> To: Leonard Crestez <leonard.crestez@nxp.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-clk@vger.kernel.org
> ---
>  drivers/clk/imx/clk-composite-8m.c |  3 ++-
>  drivers/clk/imx/clk-imx8mm.c       |  7 ++++---
>  drivers/clk/imx/clk-imx8mn.c       |  7 ++++---
>  drivers/clk/imx/clk-imx8mq.c       |  7 ++++---
>  drivers/clk/imx/clk.h              | 16 ++++++++++++++--
>  5 files changed, 28 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
> index 2c309e3dc8e3..04e728538cef 100644
> --- a/drivers/clk/imx/clk-composite-8m.c
> +++ b/drivers/clk/imx/clk-composite-8m.c
> @@ -216,7 +216,8 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,
>  		div->width = PCG_PREDIV_WIDTH;
>  		divider_ops = &imx8m_clk_composite_divider_ops;
>  		mux_ops = &clk_mux_ops;
> -		flags |= CLK_SET_PARENT_GATE;
> +		if (!(composite_flags & IMX_COMPOSITE_FW_MANAGED))
> +			flags |= CLK_SET_PARENT_GATE;
>  	}
>  
>  	div->lock = &imx_ccm_lock;
> diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
> index f1919fafb124..73cc9805ec59 100644
> --- a/drivers/clk/imx/clk-imx8mm.c
> +++ b/drivers/clk/imx/clk-imx8mm.c
> @@ -470,10 +470,11 @@ static int imx8mm_clocks_probe(struct platform_device *pdev)
>  
>  	/*
>  	 * DRAM clocks are manipulated from TF-A outside clock framework.
> -	 * Mark with GET_RATE_NOCACHE to always read div value from hardware
> +	 * The fw_managed helper sets GET_RATE_NOCACHE and clears SET_PARENT_GATE
> +	 * as div value should always be read from hardware
>  	 */
> -	hws[IMX8MM_CLK_DRAM_ALT] = __imx8m_clk_hw_composite("dram_alt", imx8mm_dram_alt_sels, base + 0xa000, CLK_GET_RATE_NOCACHE);
> -	hws[IMX8MM_CLK_DRAM_APB] = __imx8m_clk_hw_composite("dram_apb", imx8mm_dram_apb_sels, base + 0xa080, CLK_IS_CRITICAL | CLK_GET_RATE_NOCACHE);
> +	hws[IMX8MM_CLK_DRAM_ALT] = imx8m_clk_hw_fw_managed_composite("dram_alt", imx8mm_dram_alt_sels, base + 0xa000);
> +	hws[IMX8MM_CLK_DRAM_APB] = imx8m_clk_hw_fw_managed_composite_critical("dram_apb", imx8mm_dram_apb_sels, base + 0xa080);
>  
>  	/* IP */
>  	hws[IMX8MM_CLK_VPU_G1] = imx8m_clk_hw_composite("vpu_g1", imx8mm_vpu_g1_sels, base + 0xa100);
> diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
> index 88f6630cd472..0a76f969b28b 100644
> --- a/drivers/clk/imx/clk-imx8mn.c
> +++ b/drivers/clk/imx/clk-imx8mn.c
> @@ -453,10 +453,11 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
>  
>  	/*
>  	 * DRAM clocks are manipulated from TF-A outside clock framework.
> -	 * Mark with GET_RATE_NOCACHE to always read div value from hardware
> +	 * The fw_managed helper sets GET_RATE_NOCACHE and clears SET_PARENT_GATE
> +	 * as div value should always be read from hardware
>  	 */
> -	hws[IMX8MN_CLK_DRAM_ALT] = __imx8m_clk_hw_composite("dram_alt", imx8mn_dram_alt_sels, base + 0xa000, CLK_GET_RATE_NOCACHE);
> -	hws[IMX8MN_CLK_DRAM_APB] = __imx8m_clk_hw_composite("dram_apb", imx8mn_dram_apb_sels, base + 0xa080, CLK_IS_CRITICAL | CLK_GET_RATE_NOCACHE);
> +	hws[IMX8MN_CLK_DRAM_ALT] = imx8m_clk_hw_fw_managed_composite("dram_alt", imx8mn_dram_alt_sels, base + 0xa000);
> +	hws[IMX8MN_CLK_DRAM_APB] = imx8m_clk_hw_fw_managed_composite_critical("dram_apb", imx8mn_dram_apb_sels, base + 0xa080);
>  
>  	hws[IMX8MN_CLK_DISP_PIXEL] = imx8m_clk_hw_composite("disp_pixel", imx8mn_disp_pixel_sels, base + 0xa500);
>  	hws[IMX8MN_CLK_SAI2] = imx8m_clk_hw_composite("sai2", imx8mn_sai2_sels, base + 0xa600);
> diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
> index c491bc9c61ce..83cc2b1c3294 100644
> --- a/drivers/clk/imx/clk-imx8mq.c
> +++ b/drivers/clk/imx/clk-imx8mq.c
> @@ -449,11 +449,12 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
>  
>  	/*
>  	 * DRAM clocks are manipulated from TF-A outside clock framework.
> -	 * Mark with GET_RATE_NOCACHE to always read div value from hardware
> +	 * The fw_managed helper sets GET_RATE_NOCACHE and clears SET_PARENT_GATE
> +	 * as div value should always be read from hardware
>  	 */
>  	hws[IMX8MQ_CLK_DRAM_CORE] = imx_clk_hw_mux2_flags("dram_core_clk", base + 0x9800, 24, 1, imx8mq_dram_core_sels, ARRAY_SIZE(imx8mq_dram_core_sels), CLK_IS_CRITICAL);
> -	hws[IMX8MQ_CLK_DRAM_ALT] = __imx8m_clk_hw_composite("dram_alt", imx8mq_dram_alt_sels, base + 0xa000, CLK_GET_RATE_NOCACHE);
> -	hws[IMX8MQ_CLK_DRAM_APB] = __imx8m_clk_hw_composite("dram_apb", imx8mq_dram_apb_sels, base + 0xa080, CLK_IS_CRITICAL | CLK_GET_RATE_NOCACHE);
> +	hws[IMX8MQ_CLK_DRAM_ALT] = imx8m_clk_hw_fw_managed_composite("dram_alt", imx8mq_dram_alt_sels, base + 0xa000);
> +	hws[IMX8MQ_CLK_DRAM_APB] = imx8m_clk_hw_fw_managed_composite_critical("dram_apb", imx8mq_dram_apb_sels, base + 0xa080);
>  
>  	/* IP */
>  	hws[IMX8MQ_CLK_VPU_G1] = imx8m_clk_hw_composite("vpu_g1", imx8mq_vpu_g1_sels, base + 0xa100);
> diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
> index 7571603bee23..e144f983fd8c 100644
> --- a/drivers/clk/imx/clk.h
> +++ b/drivers/clk/imx/clk.h
> @@ -530,8 +530,9 @@ struct clk_hw *imx_clk_hw_cpu(const char *name, const char *parent_name,
>  		struct clk *div, struct clk *mux, struct clk *pll,
>  		struct clk *step);
>  
> -#define IMX_COMPOSITE_CORE	BIT(0)
> -#define IMX_COMPOSITE_BUS	BIT(1)
> +#define IMX_COMPOSITE_CORE		BIT(0)
> +#define IMX_COMPOSITE_BUS		BIT(1)
> +#define IMX_COMPOSITE_FW_MANAGED	BIT(2)
>  
>  struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,
>  					    const char * const *parent_names,
> @@ -567,6 +568,17 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,
>  		ARRAY_SIZE(parent_names), reg, 0, \
>  		flags | CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)
>  
> +#define __imx8m_clk_hw_fw_managed_composite(name, parent_names, reg, flags) \
> +	imx8m_clk_hw_composite_flags(name, parent_names, \
> +		ARRAY_SIZE(parent_names), reg, IMX_COMPOSITE_FW_MANAGED, \
> +		flags | CLK_GET_RATE_NOCACHE | CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)
> +
> +#define imx8m_clk_hw_fw_managed_composite(name, parent_names, reg) \
> +	__imx8m_clk_hw_fw_managed_composite(name, parent_names, reg, 0)
> +
> +#define imx8m_clk_hw_fw_managed_composite_critical(name, parent_names, reg) \
> +	__imx8m_clk_hw_fw_managed_composite(name, parent_names, reg, CLK_IS_CRITICAL)
> +
>  #define __imx8m_clk_composite(name, parent_names, reg, flags) \
>  	to_clk(__imx8m_clk_hw_composite(name, parent_names, reg, flags))
>  
> -- 
> 2.30.2
> 
