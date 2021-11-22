Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6F3458F6F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 14:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235744AbhKVNfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 08:35:33 -0500
Received: from mail-eopbgr20082.outbound.protection.outlook.com ([40.107.2.82]:11662
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231935AbhKVNfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 08:35:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhR5cgKCnZ7fyYCBfFBTHHzjWqvWQE8hCnodNyb58TZOf3hGZ4ZWAIE4RExTxbhj/d5+sH+fFhof35ti7culPZUlG+AbnmrDdOcOnbMFOE1EOxbS+dRKMizRDh/cVwMWOK2LCnjeN5bDgONwn/lVCn6OyggXhmluYIzAOFUKdq41UHcBfPrLpTnnhmyQo05MYPGlYqbBnN61Of+2MqEtnagFn7wbf4ID0/I3qF45a/MQWbh8r2e/viK80aVRLcgGkvAIpYAkcO1uzl1zw/mfIduOo0KzC700CELMSiBRoc0ex3NqXu/ZI6Qdgk/2njIzkj2SW9WrCcWlCFJCM6EpqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZoznXg41Lf51W/ENkuxnbY+ek2IB3MmltUvdV50iNo=;
 b=IRrAnNqG34bAKIi3yyY1vVa/kd1pNM3TElHpjMP6jx1nEwUY3hogIBtdG270+qK33kxNRivR8VGqaS/3REwPGXbzsY4ldJwfUkOXyWw/O5MkuUt7XNpm9F7TGXOCXt7j+cMQbpwPS10eI2PxYlNion36cQ6lgn9GFY5opL7dWG528RSyn6STzwJ/vu2EZKYaX+v5c6VEGnq/8RZN7G1Psfk9kHha29c5+xVQIu/9T82O/REffCql7eWUfUl5IK/4zN6x3P+29fmcFIWjbTI6pI5peWZkPj24srfSrEu+AMwlkj0mGqlaXbBx0rmyI+sRgaHW8UlBG7TFMDlI71sf8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZoznXg41Lf51W/ENkuxnbY+ek2IB3MmltUvdV50iNo=;
 b=ANl92tLF8r52GDaqpPI2xG963ZSWmNXl3v0AveFRwmU4QbH1v/c643eDqdPGhMWziixTS+mVonYjOI82kr0U9vjyo+6OORL0ZSWiKVAWLHEXA3ST0mgIjf52BIu8kQj7gz88fjQh1d3gRcKeI9k+RQip5h1i7j4e1tQFiJKYsbc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR0402MB3839.eurprd04.prod.outlook.com (2603:10a6:803:21::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Mon, 22 Nov
 2021 13:32:22 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::d0eb:49aa:2a9:9fc4]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::d0eb:49aa:2a9:9fc4%4]) with mapi id 15.20.4713.025; Mon, 22 Nov 2021
 13:32:22 +0000
Date:   Mon, 22 Nov 2021 15:32:19 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-clk@vger.kernel.org, aford@beaconembedded.com,
        cstevens@beaconembedded.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: imx8mn: Fix imx8mn_clko1_sels
Message-ID: <YZub48xyCuchyHBH@ryzen>
References: <20211117133202.775633-1-aford173@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117133202.775633-1-aford173@gmail.com>
X-ClientProxiedBy: VI1PR0102CA0024.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::37) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
Received: from ryzen (5.12.226.136) by VI1PR0102CA0024.eurprd01.prod.exchangelabs.com (2603:10a6:802::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Mon, 22 Nov 2021 13:32:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94520b27-ee12-4bc0-29b4-08d9adbc83b9
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3839:
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3839737C6CF9A30101E5AB79F69F9@VI1PR0402MB3839.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7PGxseGljbxyR0SGB7dlvplkZzIjb7sLHq0ktXMvPIJRLiWGrKoMLaKlbwrmYlWwYJB/I+CMefkeGErFgEjsfdxyprBmyZ5vT8egeWb7mDqQIO0f5JMrG3a1OqurmA40VQM05vQ548I86Nz02c9Phz1NZd/YXRmqXxZ1Kb0BbmieAaTkI6UJ45b43/ajjNxCtskqYn4Q7RrV+rXXtCVFvchEZQoGtBd5pohAKPcgOCR1C8bOJiehrPwn0PwrFVNyqngB7GJLlL8OAEPXz6i2yO+cRKNrnHg4yBdZx0wVTVnbebJn6597+iIJa6xkd8k/OoxY1RL/YDOmfU0QrNkzju7j38q+b87upEsmrfta0IYuufL9NFOZGOV/gXcsw5Cbzy/+S1DRVlNKGi4ctYqTFa+n7Esw4gS77A8jM+7ATtz3dFgPZeevVcqBMYCaay0hR4azcQc9i5GH9S2GfUyrqjSrDBEkDV5DG+7u66n+p3pZe+sBBIBfJR/ZAJLFicAXw3+q3Icaxg/4KF6MFuC5so09V/L+PAHJ781LCzyjlgSo6y6rMKq5dFmLM7wxs4OMN6isww+Qj4dtND4NotpqeKswMg9WoVDLHgTbacQzugks2fNWBu/P7o79EqgO2I/gKBtfjP3GfqTV1jiETX79SqaXad0BF28DW6RH1Xjgm+I3mOC5thH0JDJ4QuyTKve0ptnH6cEXJEWbHu51smTG2+8HTfh6lBTxEXt7WRO29Sc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(33716001)(44832011)(956004)(7416002)(5660300002)(9576002)(316002)(83380400001)(66946007)(38100700002)(38350700002)(6916009)(6666004)(66556008)(66476007)(186003)(26005)(52116002)(6496006)(86362001)(8676002)(8936002)(4326008)(2906002)(54906003)(53546011)(9686003)(55016002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RPXGqwXeaziAOfyJsvYGmI9Rl9t00vLsVvBIHGz6uQcVo+0hq16SPMbDRM4c?=
 =?us-ascii?Q?NqaJClbAMVBik3m0XF3pUra8AQjMTISnx2cLFxnIJEP/cuxxBajLTJCXoxlI?=
 =?us-ascii?Q?CK7uKVr/GipCspFPvbcxmXy4aJZtrQ/ObRLg1Ipz4Izjv10PViFgsKlEI2Va?=
 =?us-ascii?Q?37VLLlkkTa1YxVqndf4PsnY1TdybtGETpVW81aN0BXUiu8UkoReg9/K2ii5N?=
 =?us-ascii?Q?j6HbUd672sDNkCevfKa3qb/pElHPdqfqCVdXV0uaexYnZNUnGUmWcBR3prP3?=
 =?us-ascii?Q?iY1x9Ba0miwLgeMAhKPt5osudBbVjzLHQjDtACA39V6F7QxivuV/RnIY6vxy?=
 =?us-ascii?Q?JSEjOtoUMNaI6i/OIHyckqOczooMZUY7IpDmq4l541j8Nw4On9s3fArMMt0O?=
 =?us-ascii?Q?E27BDI6giAql+78T7kHNGhFfdut6wOfe0nozyif9mtkoipHjEFi+JlPj9RFV?=
 =?us-ascii?Q?Ts5VpTNXCdfSZmmBqIyDgVWYgpTX072mmjPSUIelkuk9udVQa9iUP0f6GAs5?=
 =?us-ascii?Q?501pU8JHKD4yV0g3YTZS+byAL7ryftR5S7YZINI86VAxN3mTOBDJAo8m2CpR?=
 =?us-ascii?Q?gaFGG48j37ZA8VgyCUlF0adxVpV9VMusnTQ+swz2qT7slk0TUXu/1jxh84Tm?=
 =?us-ascii?Q?bbLAGlZ571NwobwelKCvGVChE5tw9yLbdXVs32HHkPWbV4lnQTCetqBxfOmN?=
 =?us-ascii?Q?5HT35wRh8xauIFALopPoTxJxoqQuN0iRn/e0I/c+daSLg4mB2xaGrxtGnVXg?=
 =?us-ascii?Q?8LAS+RJNqSfgEme3RYH8UQBo4yFaTzjNy4yv74/N5zHmjaosD0GUQSl64kiP?=
 =?us-ascii?Q?Vy9rO4+h7puLLIgU9Ktv67lj5e/FtNWl/7gPo730ac4PMVGf8R87c7dMZQuH?=
 =?us-ascii?Q?rtRlUnfqlB710VL1MD3bCVZJJpd2Gpi+LaEnGcLHs9TEJyWirBHmQt7n0FHS?=
 =?us-ascii?Q?qPKH3SMcp0LyFHpiYjfuPQ19TodZFarxHWUtk2uD+Tgn3aySd+xQdPvuTev7?=
 =?us-ascii?Q?4M0kHgyjP24kTMF2acir1HWjka/hhB9PH05BqD6oTpeI7lcDW8vpmGrQptSf?=
 =?us-ascii?Q?/OG6l4BJCzjgoJckAJv2f05dQk2tVS/7H78sOYCYSRg9UCAu+BTxO197Xnbp?=
 =?us-ascii?Q?K4HAlnQSUTbp7TCDesI5ZpJz2NOtrzFn8TeTzFpDyp/gKU1PD5CBDSLkYFPe?=
 =?us-ascii?Q?bx4WVpguOMrjtBjJ86pXbKNAXsoCo4bB2hzfhbhW19ovk6bYZtbL7VfIg5Sg?=
 =?us-ascii?Q?foRCyADgua4looRLjydqwurkr0lzvEUktz6WGneIfXhmSsjmgZ4Dq+WVcpiA?=
 =?us-ascii?Q?Z/3MNU23i0vQ02JuRei4hqtO9n6Uns7/mAYz/a+KKjhI3nPopqzTGl9n1/Xk?=
 =?us-ascii?Q?GQ6eCaI/nGfqwLMEfOVRf5M0Yj4/JDgSOABU5FWalBBXwstgKSrBL2OXxmUI?=
 =?us-ascii?Q?ycPBA7qyfNL4e3gQNCFS3cEHhW4/6wT8Cv++avk4/fXy74QtGBOzjAtEM1lT?=
 =?us-ascii?Q?Bahtb7hcp7kcA25aZuu1CPuPQOvtVEoKyGiWXckZ2dbnJc6lQb9Hq5Gq3LVa?=
 =?us-ascii?Q?6B3Ryno5aq1KKA/RhypCRDbpskF06qJEPlvCywq17MLKJk2pNtTBkCXd6AO9?=
 =?us-ascii?Q?6wBA35N7rV/+LsGEhxA373k=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94520b27-ee12-4bc0-29b4-08d9adbc83b9
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 13:32:22.7261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o2lG0ZhLfi7f2vCjEElBXPtozfuTRyKzkJX9PFQUixmv+rkVj5G2JAoaKbzyQ3U2P+bdHrCcA0QAXusIRHh57Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3839
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-11-17 07:32:02, Adam Ford wrote:
> When attempting to use sys_pll1_80m as the parent for clko1, the
> system hangs.  This is due to the fact that the source select
> for sys_pll1_80m was incorrectly pointing to m7_alt_pll_clk, which
> doesn't yet exist.
> 
> According to Rev 3 of the TRM, The imx8mn_clko1_sels also incorrectly
> references an osc_27m which does not exist, nor does an entry for
> source select bits 010b.  Fix both by inserting a dummy clock into
> the missing space in the table and renaming the incorrectly name clock
> with dummy.
> 
> Fixes: 96d6392b54db ("clk: imx: Add support for i.MX8MN clock driver")
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 

Applied, thanks.

> diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
> index c55577604e16..021355a24708 100644
> --- a/drivers/clk/imx/clk-imx8mn.c
> +++ b/drivers/clk/imx/clk-imx8mn.c
> @@ -277,9 +277,9 @@ static const char * const imx8mn_pdm_sels[] = {"osc_24m", "sys_pll2_100m", "audi
>  
>  static const char * const imx8mn_dram_core_sels[] = {"dram_pll_out", "dram_alt_root", };
>  
> -static const char * const imx8mn_clko1_sels[] = {"osc_24m", "sys_pll1_800m", "osc_27m",
> -						 "sys_pll1_200m", "audio_pll2_out", "vpu_pll",
> -						 "sys_pll1_80m", };
> +static const char * const imx8mn_clko1_sels[] = {"osc_24m", "sys_pll1_800m", "dummy",
> +						 "sys_pll1_200m", "audio_pll2_out", "sys_pll2_500m",
> +						 "dummy", "sys_pll1_80m", };
>  static const char * const imx8mn_clko2_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll1_400m",
>  						 "sys_pll2_166m", "sys_pll3_out", "audio_pll1_out",
>  						 "video_pll1_out", "osc_32k", };
> -- 
> 2.32.0
>
