Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067D23F082A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 17:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239826AbhHRPkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 11:40:06 -0400
Received: from mail-vi1eur05on2088.outbound.protection.outlook.com ([40.107.21.88]:21505
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230360AbhHRPkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 11:40:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKnsu241o+15+/LvBRiZvvkr2uQc5+t6zeJUIhGaVQrfZkMFOEQ1hCAjCRF3A0Z5Cp8p4bwNQyGwdaGr75LSfZBNncul4T0WXNDoEb1W5KrHynwSsOehgWIJ8X4YTt6mkmtIEJD2eDGq+O2SMxtuFrjdxg1cBAvFU9FurkicfKOX0oNnB4tPrGXICXTsPAMaKR86ikYj5iWeqzDwsg5Jmm2GyCE2Q42jX77n+zTYqV+WTCLDazYgRhiXltvQy9OtdzKvhNiwfGI+KuOFxozoiKBuVionLDTwq69P9q+yiBN9E4fpTlK3/Gae6+ns8X+aVqtETToAK74nKrFXQ85KVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dv1UolhMXv6N75eiJCEU1d8ktNAaAvKddQlQ5PUVMRY=;
 b=f9o5FZhKOi63H7k3akeUpiM5si1a2kWU7GnNiJpGum8KSydaW2bEbIReS1yhQAbjJ/LfbD+mLqA0EZWRlmRZWgtis7OoOJaBVlkCXn7F9dqI4gz52IpoJsozV+6mvZjgD1JtRDCW45UadRl35qmi2HpHCkelVyGVypWeds/4VlmJc4HFWcZnMYiJzrAA+7MlFGZjxe6EK1g9rWOWc5zyzRRtNFaSJY65xHdLSPb3vEyuP4iDKXwkDcAqIubmzHamUhACOTUCM7H17yxdhbXKz2J69ViWw0lTIwJ3TCKml00mij9bAea/QF2oiBt2fgFoFOdRx7QGWduL5eSbqGwi8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dv1UolhMXv6N75eiJCEU1d8ktNAaAvKddQlQ5PUVMRY=;
 b=K6uE3V+XWFWH9niYpmOEHHDmTazpeA81Yg6NoswS+cH4qPhvy2ZUmjpdUdHWyAUbB0n6twEVKM5sno3OdVoX64omsedpbUBGK8dbISG7OfkH6fpdNnYnS2RA5knsYuF5trxpPfHv0+G+soufHvhiM0o2V1HKmRUBRA6bIn+Y+8U=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0401MB2559.eurprd04.prod.outlook.com (2603:10a6:800:57::8)
 by VI1PR04MB4990.eurprd04.prod.outlook.com (2603:10a6:803:59::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Wed, 18 Aug
 2021 15:39:25 +0000
Received: from VI1PR0401MB2559.eurprd04.prod.outlook.com
 ([fe80::1dc0:b737:bf34:46b]) by VI1PR0401MB2559.eurprd04.prod.outlook.com
 ([fe80::1dc0:b737:bf34:46b%3]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 15:39:25 +0000
Date:   Wed, 18 Aug 2021 18:39:23 +0300
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
Message-ID: <YR0pqxqrlW+2KpmZ@ryzen>
References: <20210810151432.9228-1-a.fatoum@pengutronix.de>
 <YR0j21KspR618YLK@ryzen>
 <93de171b-a4d3-e1da-a5e0-4c50e7a97c5d@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93de171b-a4d3-e1da-a5e0-4c50e7a97c5d@pengutronix.de>
X-ClientProxiedBy: VI1PR08CA0125.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::27) To VI1PR0401MB2559.eurprd04.prod.outlook.com
 (2603:10a6:800:57::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ryzen (188.27.180.28) by VI1PR08CA0125.eurprd08.prod.outlook.com (2603:10a6:800:d4::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Wed, 18 Aug 2021 15:39:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb622781-141e-44af-cd86-08d9625e5b64
X-MS-TrafficTypeDiagnostic: VI1PR04MB4990:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB499078922FAED7F1BE55E919F6FF9@VI1PR04MB4990.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mkE+S0vsOgj/n8xFIuT/hQQ7juh7unQ9lHhlg3l2TNiozr7HcFEADK6LHHIf25jmhi/kqLxyVET+uxQivHle2u8OVto9lDOxzQiWrYPLiVDNE+4uSAg9h2XYVf5Osh5i9JqfHkQoCgvzx8MnrQEcGTTGEXEWoY/mB5QpDv3ER05v8xQM5VoWWW2cyBFrm9XxWkDdyQ2mXun9rIDlDpz/MI7Z8vJwAdhzFaCLPZZmz7C1vxOMef/q2AuaZe8yHr4SXUwqQIfdR1ohFyamSp6HGU6eegsf0ek29QFMng7XazBfqGKYiQDaxqiuD3QMMiRqiYkC1PHXv2ZCKWD1Dih4WT3YldGrOSC8/WU3YuECwOuYURWDC+wwJK4AR8TftQLP/65EGH/7TiCu77mvxAQr61JdAT/eLY9oxFGZ6jh4OqeGiPtAzIhTsx7Eb3qNFsnEJX6YOgpWwTBWGGKpv/M06IqRJ6lLZ2469t1M9DLs+iLL7txNgY1dE5+KiU1iTSFBnSFp2agMGiNliGu7adB2RbmhxdDI9N7w50OtRNzq5k4xsR+SeJ86MmapHuwghMpqi/T7V2Wav5pvNScAdU8Rg7DC4g0K0DYrvU2fg+ShAsR1tjV66UoCJ7wLav2C1/JChojzEgGzX5IfhABzWDn2CpytTFARYYQGvjhfzvrHJL6zQx6aQnuZqzdd/9HKUd8Y3VsrKMW48My5q9IPCa5p6+V4jwvD9EoUIe2/p+KWQoAcP7Pnm9U1YNY0dDg/2/ddmsuE9pgN2gqygFJj/E0RplEDa9MOy1v2ANzY6qBa9j8CDlzce8SBUFF5cjOG7J66wvyu7/Ykp2X28nU8wYVlSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2559.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(39850400004)(366004)(396003)(66476007)(66556008)(956004)(6916009)(54906003)(316002)(66946007)(86362001)(5660300002)(83380400001)(6496006)(52116002)(26005)(186003)(53546011)(966005)(55016002)(9686003)(38100700002)(2906002)(33716001)(4326008)(8676002)(8936002)(38350700002)(7416002)(45080400002)(9576002)(478600001)(44832011)(32563001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?saFiHJxOGvMn4QtgOL3B9rLOOBJLtCX38jJaymNSdwBZzTFjRztMaMIgzJKk?=
 =?us-ascii?Q?ozkJj1GZ6eXVtzeLbnT/SbH5BJxJ91zvvkxofcHR2sBzP4dc1XOy3cjNuS/F?=
 =?us-ascii?Q?SoslyPhlTh+18r7+cjYrkqIf2+gupZHgSwj3MSRTUA/u0lg1pxdu2VcPWk3Z?=
 =?us-ascii?Q?ITmOlA2N1HLxwXapIf4BEMbxEgWSwqpAkVU56jd9dFV8ueH0cXGaguA+vfOq?=
 =?us-ascii?Q?TpSw3J/B9FTvHljUPTtbOBr143uYrG0B/QAMjDEhZqNRY3HTXYBxHapKKoKy?=
 =?us-ascii?Q?O5x0QUY6FW/4FdfVVJBsau4nTIxFgTwhdgDZnN/TkHmTQr/Ee3tTW91zz/hy?=
 =?us-ascii?Q?C88KqMAti3G71h+Jq85iztj0+LE8B9+65MPY0BHaFAUYqUotYZajZqg+RRCq?=
 =?us-ascii?Q?BT4uTuZx4UBopb6mnkIooB4oe/+NlK4gOSt5l9hNAOpVP25B+ZlAoHqAMsqV?=
 =?us-ascii?Q?J0qGVBWzOswr2art9wLO1am4ikPZDo9bYzlqwbxdj3GZ9QsjG4o6gMLCwyqO?=
 =?us-ascii?Q?zZEwrI5eRSnUyhc2sKwxA0zi/K8+AzVNaCEKBlhc8e25Bub4cR2P7QAdT38L?=
 =?us-ascii?Q?wiGKhk4oqqOQ+h6GC69Bi7oWfDKpOB0AP2hPR755QTZc1gATyN8IcgM/Gm01?=
 =?us-ascii?Q?4LSzepFEzyuyiqk1DEWCrP9hLzCQ4cah3X+YN9shOgcsykfYocJJbvHfITV7?=
 =?us-ascii?Q?mhC833S2350kH1TJh/RF85izJy1gSNu5VJXbp8xaLG9Pqa7goBAqx+bBHSwX?=
 =?us-ascii?Q?Mk+h8MaXTaMao40RZa/jX+//nbmZcYoyJh6Y/PU61/lmOy/Mw769YiTu7cJu?=
 =?us-ascii?Q?Smh4rX6nf/UM5HvAtSzUfoemgLGrOPe31lXpLq8gPu62FQn+WGesfPAshX3L?=
 =?us-ascii?Q?YKv8p4UsW26x0a4wlQlL4k1SD0Y1KooV8rPvqtgVT2gzF9BYixK7St/Htned?=
 =?us-ascii?Q?q2NX4rW9jqWgqxVcCYYjqKUwQwnWSi63zg3AxsaUklH15EC2jGoPFLq1aOSi?=
 =?us-ascii?Q?fDF1564Rc5LT0kLiloAlwtNDrTyfPsPSSWF2s7UzoMLT9XEDPGGTUHtYMB+t?=
 =?us-ascii?Q?IFtmcoEyYSq7M8e79gNxB8q5J+TYuQls4gsuozn1XACMrZTiYnYezuUUDEgi?=
 =?us-ascii?Q?Ste9pzDURAfcwsJnMo/yU+xrtOvSUz2u3VnK2zZuLztlHT6EzBumV2Ilo/OJ?=
 =?us-ascii?Q?VB0H35ndo/pg+Y4OnxCk6r3P6JgoZJ+6Bc6819CQJ8mbKF09xzAmROWcg6KH?=
 =?us-ascii?Q?mltLJ3zf5bqAFYOGupe+tj1Q63dRZlGR3/G/H9uHM2jAGgoclk8XMx5TvN4x?=
 =?us-ascii?Q?L1aY08PNtnf5raHNJUHksdTW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb622781-141e-44af-cd86-08d9625e5b64
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2559.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2021 15:39:25.1225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S//sCDZJ7qUE+/BFURSsHMBn/uqW/yyXz+QXknxTx7VR2zH1oeu+wsVwj1qnvmDptczxMK4lx1KKGJmfW477aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4990
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-08-18 17:28:42, Ahmad Fatoum wrote:
> Hello Abel,
> 
> On 18.08.21 17:14, Abel Vesa wrote:
> > On 21-08-10 17:14:33, Ahmad Fatoum wrote:
> >> On the i.MX8M*, the TF-A exposes a SiP (Silicon Provider) service
> >> for DDR frequency scaling. The imx8m-ddrc-devfreq driver calls the
> >> SiP and then does clk_set_parent on the DDR muxes to synchronize
> >> the clock tree.
> >>
> >> Since 936c383673b9 ("clk: imx: fix composite peripheral flags"),
> >> these TF-A managed muxes have SET_PARENT_GATE set, which results
> >> in imx8m-ddrc-devfreq's clk_set_parent after SiP failing with -EBUSY:
> >>
> >> 	echo 25000000 > userspace/set_freq
> >> 	imx8m-ddrc-devfreq 3d400000.memory-controller: failed to set
> >> 		dram_apb parent: -16
> >>
> >> Fix this by adding a new i.MX composite flag for firmware managed
> >> clocks, which clears SET_PARENT_GATE.
> >>
> >> This is safe to do, because updating the Linux clock tree to reflect
> >> reality will always be glitch-free.
> >>
> >> Fixes: 936c383673b9 ("clk: imx: fix composite peripheral flags")
> >> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> > 
> > I'm OK with this.
> > 
> > Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
> 
> Thanks for the review.
> 
> > BTW, let me know if you are interested in the interconnect+devfreq
> > (the replacement for NXP's internal busfreq). I have a new version of
> > that patchset which I intend to send soon for review.
> 
> Ye, add me to CC and I'll give it at least a test. It sounds like you
> recently worked with devfreq? I am wondering why you didn't run into this issue.

I actually had a different fix for this issue actually. Have a look here:

https://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git/commit/?h=imx8mq/icc_devfreq&id=bd39ccabdfdbf128670dea56094b0da7764be05a

And my fix will still be needed when the icc+devfreq gets in, since the
parent will be changed in TF-A but the kernel clock tree can't because
the clock is marked as CLK_IS_CRITICAL.

> 
> Cheers,
> Ahmad
> 
> > 
> >> ---
> >> To: Abel Vesa <abel.vesa@nxp.com>
> >> To: Michael Turquette <mturquette@baylibre.com>
> >> To: Stephen Boyd <sboyd@kernel.org>
> >> To: Shawn Guo <shawnguo@kernel.org>
> >> To: Sascha Hauer <s.hauer@pengutronix.de>
> >> To: Pengutronix Kernel Team <kernel@pengutronix.de>
> >> To: Fabio Estevam <festevam@gmail.com>
> >> To: NXP Linux Team <linux-imx@nxp.com>
> >> To: Peng Fan <peng.fan@nxp.com>
> >> To: Leonard Crestez <leonard.crestez@nxp.com>
> >> Cc: linux-arm-kernel@lists.infradead.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Cc: linux-clk@vger.kernel.org
> >> ---
> >>  drivers/clk/imx/clk-composite-8m.c |  3 ++-
> >>  drivers/clk/imx/clk-imx8mm.c       |  7 ++++---
> >>  drivers/clk/imx/clk-imx8mn.c       |  7 ++++---
> >>  drivers/clk/imx/clk-imx8mq.c       |  7 ++++---
> >>  drivers/clk/imx/clk.h              | 16 ++++++++++++++--
> >>  5 files changed, 28 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
> >> index 2c309e3dc8e3..04e728538cef 100644
> >> --- a/drivers/clk/imx/clk-composite-8m.c
> >> +++ b/drivers/clk/imx/clk-composite-8m.c
> >> @@ -216,7 +216,8 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,
> >>  		div->width = PCG_PREDIV_WIDTH;
> >>  		divider_ops = &imx8m_clk_composite_divider_ops;
> >>  		mux_ops = &clk_mux_ops;
> >> -		flags |= CLK_SET_PARENT_GATE;
> >> +		if (!(composite_flags & IMX_COMPOSITE_FW_MANAGED))
> >> +			flags |= CLK_SET_PARENT_GATE;
> >>  	}
> >>  
> >>  	div->lock = &imx_ccm_lock;
> >> diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
> >> index f1919fafb124..73cc9805ec59 100644
> >> --- a/drivers/clk/imx/clk-imx8mm.c
> >> +++ b/drivers/clk/imx/clk-imx8mm.c
> >> @@ -470,10 +470,11 @@ static int imx8mm_clocks_probe(struct platform_device *pdev)
> >>  
> >>  	/*
> >>  	 * DRAM clocks are manipulated from TF-A outside clock framework.
> >> -	 * Mark with GET_RATE_NOCACHE to always read div value from hardware
> >> +	 * The fw_managed helper sets GET_RATE_NOCACHE and clears SET_PARENT_GATE
> >> +	 * as div value should always be read from hardware
> >>  	 */
> >> -	hws[IMX8MM_CLK_DRAM_ALT] = __imx8m_clk_hw_composite("dram_alt", imx8mm_dram_alt_sels, base + 0xa000, CLK_GET_RATE_NOCACHE);
> >> -	hws[IMX8MM_CLK_DRAM_APB] = __imx8m_clk_hw_composite("dram_apb", imx8mm_dram_apb_sels, base + 0xa080, CLK_IS_CRITICAL | CLK_GET_RATE_NOCACHE);
> >> +	hws[IMX8MM_CLK_DRAM_ALT] = imx8m_clk_hw_fw_managed_composite("dram_alt", imx8mm_dram_alt_sels, base + 0xa000);
> >> +	hws[IMX8MM_CLK_DRAM_APB] = imx8m_clk_hw_fw_managed_composite_critical("dram_apb", imx8mm_dram_apb_sels, base + 0xa080);
> >>  
> >>  	/* IP */
> >>  	hws[IMX8MM_CLK_VPU_G1] = imx8m_clk_hw_composite("vpu_g1", imx8mm_vpu_g1_sels, base + 0xa100);
> >> diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
> >> index 88f6630cd472..0a76f969b28b 100644
> >> --- a/drivers/clk/imx/clk-imx8mn.c
> >> +++ b/drivers/clk/imx/clk-imx8mn.c
> >> @@ -453,10 +453,11 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
> >>  
> >>  	/*
> >>  	 * DRAM clocks are manipulated from TF-A outside clock framework.
> >> -	 * Mark with GET_RATE_NOCACHE to always read div value from hardware
> >> +	 * The fw_managed helper sets GET_RATE_NOCACHE and clears SET_PARENT_GATE
> >> +	 * as div value should always be read from hardware
> >>  	 */
> >> -	hws[IMX8MN_CLK_DRAM_ALT] = __imx8m_clk_hw_composite("dram_alt", imx8mn_dram_alt_sels, base + 0xa000, CLK_GET_RATE_NOCACHE);
> >> -	hws[IMX8MN_CLK_DRAM_APB] = __imx8m_clk_hw_composite("dram_apb", imx8mn_dram_apb_sels, base + 0xa080, CLK_IS_CRITICAL | CLK_GET_RATE_NOCACHE);
> >> +	hws[IMX8MN_CLK_DRAM_ALT] = imx8m_clk_hw_fw_managed_composite("dram_alt", imx8mn_dram_alt_sels, base + 0xa000);
> >> +	hws[IMX8MN_CLK_DRAM_APB] = imx8m_clk_hw_fw_managed_composite_critical("dram_apb", imx8mn_dram_apb_sels, base + 0xa080);
> >>  
> >>  	hws[IMX8MN_CLK_DISP_PIXEL] = imx8m_clk_hw_composite("disp_pixel", imx8mn_disp_pixel_sels, base + 0xa500);
> >>  	hws[IMX8MN_CLK_SAI2] = imx8m_clk_hw_composite("sai2", imx8mn_sai2_sels, base + 0xa600);
> >> diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
> >> index c491bc9c61ce..83cc2b1c3294 100644
> >> --- a/drivers/clk/imx/clk-imx8mq.c
> >> +++ b/drivers/clk/imx/clk-imx8mq.c
> >> @@ -449,11 +449,12 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
> >>  
> >>  	/*
> >>  	 * DRAM clocks are manipulated from TF-A outside clock framework.
> >> -	 * Mark with GET_RATE_NOCACHE to always read div value from hardware
> >> +	 * The fw_managed helper sets GET_RATE_NOCACHE and clears SET_PARENT_GATE
> >> +	 * as div value should always be read from hardware
> >>  	 */
> >>  	hws[IMX8MQ_CLK_DRAM_CORE] = imx_clk_hw_mux2_flags("dram_core_clk", base + 0x9800, 24, 1, imx8mq_dram_core_sels, ARRAY_SIZE(imx8mq_dram_core_sels), CLK_IS_CRITICAL);
> >> -	hws[IMX8MQ_CLK_DRAM_ALT] = __imx8m_clk_hw_composite("dram_alt", imx8mq_dram_alt_sels, base + 0xa000, CLK_GET_RATE_NOCACHE);
> >> -	hws[IMX8MQ_CLK_DRAM_APB] = __imx8m_clk_hw_composite("dram_apb", imx8mq_dram_apb_sels, base + 0xa080, CLK_IS_CRITICAL | CLK_GET_RATE_NOCACHE);
> >> +	hws[IMX8MQ_CLK_DRAM_ALT] = imx8m_clk_hw_fw_managed_composite("dram_alt", imx8mq_dram_alt_sels, base + 0xa000);
> >> +	hws[IMX8MQ_CLK_DRAM_APB] = imx8m_clk_hw_fw_managed_composite_critical("dram_apb", imx8mq_dram_apb_sels, base + 0xa080);
> >>  
> >>  	/* IP */
> >>  	hws[IMX8MQ_CLK_VPU_G1] = imx8m_clk_hw_composite("vpu_g1", imx8mq_vpu_g1_sels, base + 0xa100);
> >> diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
> >> index 7571603bee23..e144f983fd8c 100644
> >> --- a/drivers/clk/imx/clk.h
> >> +++ b/drivers/clk/imx/clk.h
> >> @@ -530,8 +530,9 @@ struct clk_hw *imx_clk_hw_cpu(const char *name, const char *parent_name,
> >>  		struct clk *div, struct clk *mux, struct clk *pll,
> >>  		struct clk *step);
> >>  
> >> -#define IMX_COMPOSITE_CORE	BIT(0)
> >> -#define IMX_COMPOSITE_BUS	BIT(1)
> >> +#define IMX_COMPOSITE_CORE		BIT(0)
> >> +#define IMX_COMPOSITE_BUS		BIT(1)
> >> +#define IMX_COMPOSITE_FW_MANAGED	BIT(2)
> >>  
> >>  struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,
> >>  					    const char * const *parent_names,
> >> @@ -567,6 +568,17 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,
> >>  		ARRAY_SIZE(parent_names), reg, 0, \
> >>  		flags | CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)
> >>  
> >> +#define __imx8m_clk_hw_fw_managed_composite(name, parent_names, reg, flags) \
> >> +	imx8m_clk_hw_composite_flags(name, parent_names, \
> >> +		ARRAY_SIZE(parent_names), reg, IMX_COMPOSITE_FW_MANAGED, \
> >> +		flags | CLK_GET_RATE_NOCACHE | CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)
> >> +
> >> +#define imx8m_clk_hw_fw_managed_composite(name, parent_names, reg) \
> >> +	__imx8m_clk_hw_fw_managed_composite(name, parent_names, reg, 0)
> >> +
> >> +#define imx8m_clk_hw_fw_managed_composite_critical(name, parent_names, reg) \
> >> +	__imx8m_clk_hw_fw_managed_composite(name, parent_names, reg, CLK_IS_CRITICAL)
> >> +
> >>  #define __imx8m_clk_composite(name, parent_names, reg, flags) \
> >>  	to_clk(__imx8m_clk_hw_composite(name, parent_names, reg, flags))
> >>  
> >> -- 
> >> 2.30.2
> >>
> > 
> 
> 
> -- 
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.pengutronix.de%2F&amp;data=04%7C01%7Cabel.vesa%40nxp.com%7Cb8c21d0576b0482b181608d9625cdf49%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637648973293620984%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=D0efPtr5bHllXtgau1QWgMrzY8p2Zckeo43pvUztDPE%3D&amp;reserved=0  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
