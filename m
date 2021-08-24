Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F09E3F5DBD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 14:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237151AbhHXMP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 08:15:58 -0400
Received: from mail-vi1eur05on2058.outbound.protection.outlook.com ([40.107.21.58]:3393
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237030AbhHXMPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 08:15:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=geVFE0o5zkzRarcR+jmdLjEDsQiRet1kIC17j/kvl30/9icY8pnBK5Io3zLmsisQ/oj5wEk7sGvZCSDnu38Q9G7DFS47xj/lRv9oQZNZWFHiDHbul8zY8mPwQKWRYD+sxK+s8KYIAuHsGVjBe2UNmEHcV7l0jG/2MB+S6ibkvbzh5ExZlzDaZQ4C3U1r9vvRmKtPL8B2kqWWhEkjKG3gmoy+ndGduxo8S05laMfvN5WxbKXLWtlzgVvN+gf1sK1ivj0DcckMn9j2VojF2we/Su4rAGer+Cf+gxw7Yw+aRc/404kU/jyqVKa49PsVaHST+ysccg9ncf8bZhY0syEtdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ceePMjsIPmqlD5J/NBYLifdf9nCo6bmS/Vc2etUJNA=;
 b=LyZyou62ZkxNGNR8/TPhxkueFaKQA6ju34jErpADlSwHVec+UBnqJRPOR1kuDPn05OzcesljBMSc06ITg7RWmZZvcmztqwwKr87RaOyBzl9Gbih9u8pAad8zR1oxddwowLQpnbxDY0YswsAQwBvUJke8M6le5N6D+XyKzRE/mVKGv4mmOuXBpcsQNINsIsJevi4nNbjxC64Ei4055EzFyBij9Awt7/zdMnPR3/pmpUvpkNtjSNYhP13qe1Pan/eUoE4LiGAayncwaPhu+zHC3GhOqmJIh0ZU7hvHSoo+qBQDnFVkagZwUelYgG2+ZkfPf0RvINRT0a8UX1XgI1VOHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ceePMjsIPmqlD5J/NBYLifdf9nCo6bmS/Vc2etUJNA=;
 b=mSRd6kg37+J4MVAjn+dtraZ69gk6jXeK9KOSh3tFPAp7CWfxC7j2l7IL7/YSSdj1Me9vsvmu2DJfLHhnBd5OayY+1mfFtZn0Rh3cnAdINaPU3pQjZRrjj+DTIcSZBG7Cv90uHd8EWDWzKEf5vj9kN3NFAbR7NB0Knj10z+bVVQk=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0401MB2559.eurprd04.prod.outlook.com (2603:10a6:800:57::8)
 by VI1PR04MB5791.eurprd04.prod.outlook.com (2603:10a6:803:e4::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.23; Tue, 24 Aug
 2021 12:15:07 +0000
Received: from VI1PR0401MB2559.eurprd04.prod.outlook.com
 ([fe80::485a:4462:94c2:5edb]) by VI1PR0401MB2559.eurprd04.prod.outlook.com
 ([fe80::485a:4462:94c2:5edb%10]) with mapi id 15.20.4436.025; Tue, 24 Aug
 2021 12:15:07 +0000
Date:   Tue, 24 Aug 2021 15:15:05 +0300
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
Message-ID: <YSTiyR/uvpYa0jUb@ryzen>
References: <20210810151432.9228-1-a.fatoum@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810151432.9228-1-a.fatoum@pengutronix.de>
X-ClientProxiedBy: VI1PR08CA0227.eurprd08.prod.outlook.com
 (2603:10a6:802:15::36) To VI1PR0401MB2559.eurprd04.prod.outlook.com
 (2603:10a6:800:57::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ryzen (188.27.180.28) by VI1PR08CA0227.eurprd08.prod.outlook.com (2603:10a6:802:15::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 12:15:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11e6033e-1e1c-4f61-6c6f-08d966f8cfa3
X-MS-TrafficTypeDiagnostic: VI1PR04MB5791:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB579103CAC59CBC50C348EE48F6C59@VI1PR04MB5791.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dVmhPaWU5n1lqUGfkTap/pQS7IfyaWVo5Rw64N/DTjZFgkRLMo7ODRsNUuI5/qAWOWgArmRNSSlyUaB9EJvNW3sRicB7IIA8lorPjxShACUcznCvm6+TcLTcclpsyxsLjqx0sV0wVIDdCQyjsGOMw1+zJqawABYvavJ86dnjXQRG5oRlUQOBA7xEubFtOGh+6SiqK2H+47/MugRCRiYPplarRX5TBNGF+rvnNlABHOPURDj6ULUzq2E/y/MzhCHnls7J4yt42irTsq+NnfdY8dw8BY3osuzRkVxxS7WIcoZ8dV3GcQthGd/14sZfc391GZiMs0B5tA0a4YMtlegCC9IU2TJcAyHIBw/kgWgOEUnp87DBkhUNnjYZ3xRjrrQZWtKpxSkSZk9+trVOLozr56P7+mNUqgnsbkAg4BLiumAtbNTeeOd/V28KAYB/YmRE7nKt6z3BVF3HbwGYdUplo0aESWxiF7kjm8m0m0v1RoLsfIf0WPKpD3vme16PodhJTQCA20uwjsmTlFJ5tVTvJtkp85+gbhcCUCPyM82HK3oVmoJ+Gsq0ghpnIZNnnyQWrFO1qSiEDsSRsLKhT63pfumVrKQNGWIC+eXrX7wHnjGlgAaagc1PlBwfWkrNJcQB2XToB9c46qfkvzJBUv9GMxEJoKTKK2CSk5ctM2PUQPiXVFCxhttkQN7CvMMDuEAO2kxuweMpUglhSTS5ZqEcB0+Jsp/6Ck3iw6Xf642TlcM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2559.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(5660300002)(6496006)(54906003)(186003)(316002)(33716001)(4326008)(86362001)(9576002)(8676002)(2906002)(9686003)(53546011)(52116002)(55016002)(956004)(6916009)(478600001)(26005)(38350700002)(66946007)(38100700002)(44832011)(8936002)(7416002)(83380400001)(66556008)(66476007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mUm0tV/qOSn4g+XT3qMSasHAdUpZt5xc7MGz56UDdYJ9uwZ6I3PWLNqxFYaa?=
 =?us-ascii?Q?e3MzEhOvqwuK9U6idd3JHy8vzo4SX0oedCWb5t0vMGUMVWbLTSr1934LRMYL?=
 =?us-ascii?Q?Oz/Iet73E4jOoDQ2ehMX+2M7uG7Po7f1ky8+UwnYEZorQsOC6vQWrWv1C0nz?=
 =?us-ascii?Q?d+dgKFbayi5Zme0zY9jwxreKpVdv/C5xndlaPxLGWG9D4Ejm5MQAQSUM5ZKQ?=
 =?us-ascii?Q?TlINAJuCVx95wWLDe3nPzNk8DMk9qvqXq8F37AV9PpyeXa+Hinr9XMoZC9tN?=
 =?us-ascii?Q?aU8W/VMt+I0goAHzGSt8MRbbb405u5kYN7AVEkmXZztFvTOGq0KeW7gfvDoc?=
 =?us-ascii?Q?Yu9gIX0SuaeeAPj3+rbQrPWaHg1lsdnZVwy9TqOGPkJpxNZwSi+XGDySmSfd?=
 =?us-ascii?Q?OG1IfC1PcM9aB4WUlYebifOtxo5Q9o7Xl8MOnCrdRYraRY6VcoxU3R46BIkL?=
 =?us-ascii?Q?59nubp6g9f1f3Uw1gFG2BTgIcFjkaU4ysCVvGoubu/uaJOPUFCbBlZ1gQYlA?=
 =?us-ascii?Q?Uqa+ffjIWN4heaT6fo6rPq0t6KsE+T+dp8hWjlNYFNo52qjVPIaKC45ZRlT9?=
 =?us-ascii?Q?q4xHQJ+CjBMcD1IRmNbPNtymd4X0IbKGIVMzsdJ7FfKLg9sYl+sqlIcaKm+h?=
 =?us-ascii?Q?Ahp7wyMBHhtJbJ15Vie4ZOueqdE9gzGMkBnkTC7VlG7r+bDntIggMymbuPOk?=
 =?us-ascii?Q?BVVA+XDKY9DJbSO8wZM42rNtNEgIMjcUJBcV99K6J6o2RfVo4ZfivyYo0OMq?=
 =?us-ascii?Q?tP2IVPybCJfSECSZzuap5x0pSjLitEreTpQxHSk2PW0rzs03Wx4M0lCJmeDN?=
 =?us-ascii?Q?1vXu0Xuehg2uM7DY7EMRIumqY9Xa3r4Tm/Pt7zitHpk+tXT3cG0nbAFtDwSB?=
 =?us-ascii?Q?SW9nnZo7PFzCIb92oTkuVNm4P/9FyPuPyT+cau4gdWvf9sNgFMcg4mUe2bbE?=
 =?us-ascii?Q?fI+CIuWs3EgRD8AdT3ApXDD+C2lf2du0twfl0UBxGobtq+ifR0OtcqjJTUrh?=
 =?us-ascii?Q?HBHTaZhyxiJ/F1VCFIteSJFdKtbgz2jFYlYZ8NKKbqdp8Np12JQhPHVY0AKZ?=
 =?us-ascii?Q?BH8IKsPvYHOjWMMgeaQeIzzGn+PzL/paiu7aS1Mh+c+dv9k3c1aRH+ErmV1q?=
 =?us-ascii?Q?O0vYvnoSPtPKJpW896rmf4V3lF01y9aqwQqg7YwQx60YdVVUjWVf8CEn9JEN?=
 =?us-ascii?Q?WtpMYbbpRh2mreUpUL1Ijhk6Sdbb/K6HKBtQaSCivCk7OcSIGgOlTG97Lnsv?=
 =?us-ascii?Q?INAb+IkXaezTx6e1lrcSaZ4DrANfVCy8/RyNlaIyZ9X3pE4IW7DXBQEfTrhw?=
 =?us-ascii?Q?tCZJXIAktb5istxT89VSvRvI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e6033e-1e1c-4f61-6c6f-08d966f8cfa3
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2559.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 12:15:07.3191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eqNNqsh894/zE7AtctdBzYo5lhRgLc0UA+ph0JZIcESI9RN6GOLGXRuzuZqGF2t0RBaFtPSh0pXa+En4H87bJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5791
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


Applied, thanks.

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
