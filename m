Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E2641AB8E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 11:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239903AbhI1JNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 05:13:23 -0400
Received: from mail-am6eur05on2064.outbound.protection.outlook.com ([40.107.22.64]:59073
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239927AbhI1JNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 05:13:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hW9lK5uh/4G3SSo7y4VHA3L4tV6EQ0/ltVb91N+zcePWMico1mrOYckI+eYvHtRNM86OZfNUlkPPUgJB3FFsjVobMJOMfgqa8M+Nj1VV/UHTYbXqFhDsNea1Hb3gJ9fWOGX2Twbv9GGqCAFQ4UV0t+3ojjGcxhL6/l8aeeF1Gh8aMnwIJqOy0ykIxjxrBT3JuIuA7dknw9wYANvDYZSe1RVvqdiMyVVi7Sp4dMk72+5lSlVL5LD4coZkegBr5HJDBFvW3tbUzmyQ7TcSMCnLR5+OSqOhc/i071/jOwL29XdRdImmGZrBOp7YICKwnAenJKNruhVg1k/kG/NOyti7EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=XydbSv7Hu01/FT6HbxdUAjHJWyc9ZH5C2EbNY0dojhQ=;
 b=HLhWqNErfb/FEmmT+hVIxiduXgAozp4d/bLe3HDOZ/CYdRCU2wgSctEcK0krSpj+SpqC3QhYA+SCcbk0yDaqtrjIPV1q01qB6c8XVasIH0ajWAy8RBOfTRlzYYx77Pq+7ypSqgki7QlouA3fM45AIVJI0InqWTLee0FiiBeVGLP6xqRYnrVGdFjEbu1CqEvfahnCVP6A/xEz1R32PU9C4Xh5WcEcElq8IsmTlHRrl2n783XFdjg59w4PshKYf7AKNfbBY1lfIUxp+r+IMem+J397nKFLykb0dGQj9Z8hQ9oTi39oT5ofzJjzjUL/yjDsz6EgJSx1+G4LKACL6cL/gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XydbSv7Hu01/FT6HbxdUAjHJWyc9ZH5C2EbNY0dojhQ=;
 b=d73uUfSDjA7Rh1Y/XpRRU8Vklq2kJlLvWqUxRBIhaK//TAbN91nPvcdRsIqYtlgQk63JFpn6+DcA51PDJpkV08zFUOTN162dYg24l6upDKoIXOAse21aBX2RQOVXG9Cqb5ICyODW7RNiSbvo3/QjBYVGt2RrxtI2CzInjHeCfRE=
Authentication-Results: phytec.de; dkim=none (message not signed)
 header.d=none;phytec.de; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0401MB2559.eurprd04.prod.outlook.com (2603:10a6:800:57::8)
 by VI1PR04MB6239.eurprd04.prod.outlook.com (2603:10a6:803:fd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Tue, 28 Sep
 2021 09:11:36 +0000
Received: from VI1PR0401MB2559.eurprd04.prod.outlook.com
 ([fe80::485a:4462:94c2:5edb]) by VI1PR0401MB2559.eurprd04.prod.outlook.com
 ([fe80::485a:4462:94c2:5edb%10]) with mapi id 15.20.4544.022; Tue, 28 Sep
 2021 09:11:36 +0000
Date:   Tue, 28 Sep 2021 12:11:34 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stefan Riedmueller <s.riedmueller@phytec.de>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] clk: imx: imx6ul: Move csi_sel mux to correct
 base register
Message-ID: <YVLcRqJTpTsZ3hAJ@ryzen>
References: <20210927072857.3940880-1-s.riedmueller@phytec.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927072857.3940880-1-s.riedmueller@phytec.de>
X-ClientProxiedBy: VI1PR08CA0203.eurprd08.prod.outlook.com
 (2603:10a6:800:d2::33) To VI1PR0401MB2559.eurprd04.prod.outlook.com
 (2603:10a6:800:57::8)
MIME-Version: 1.0
Received: from ryzen (86.121.85.242) by VI1PR08CA0203.eurprd08.prod.outlook.com (2603:10a6:800:d2::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13 via Frontend Transport; Tue, 28 Sep 2021 09:11:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3952a28f-3e07-47e4-001e-08d9825ff913
X-MS-TrafficTypeDiagnostic: VI1PR04MB6239:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB6239E0908CAE4336BCA67869F6A89@VI1PR04MB6239.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V6S8tO9jkRohwd88mowRc94eJf5o56905s2rIjWO4aZpKLXG/ZfD2cB/Zs8VQVYeTEzCksq8L9M2Gvj0uCDzhaMbOy3HUe3UDXjQ/Yp6hUk9j6I+qcRP2ZRao6+hOAUr18SAmD7ISm9RKsPNuqqPb37YV60QjgXe8pGUUm39BJ/liD7ibd/h1smgnpUKdY3mqa0oZxHJvq7bwrxJvQrbfbXhO+c/WW6MVVj8cFkqhRNkvMZGfdW/KG8d0dz0682zsJeCY3GDclS9FjTx3DymaiHgooe+Zltc2AG0jbYYX71w95TVXBXwbShDYY6iqk0xuLT+dOiCYIQM+LJ8+ShbliW3Le8MPjzcHebt2w8b+Fu16Q6bhiljFNVxtf4yEYDN3B8n0vF5f9r4sboKJAhIpoRU3VRyidnVf4OtRg3lSUPzrvbRxJdJ7ZW2ny2br66XCDhPH370u2uuU4S2qhAGHr3UpggA1HN3C7f7ThI+MU7dXEQAUF2dUXjHpT5BCL+MK/X/TIuScxmZaAERQ3I4Jp08T3df80AnnCQNT0CTVGXIyJVVwA9c0Xp7M36kk3EwL8d8pRYxMkqJHgcOu1DBqX1Z1VJrZC3i5jFALsrFdYT98WVrcdvhwVfHDAZ7mbKhKQCsGmR7SuTY7EngQdB6WHPGOYAkgR1cC03GCyRB8gWlfLGXHR+NuiQ6w6eiXg3OS/N5o/YTFCwOXtSibF3U4i6ugDVoKdpSqKfRTM4Ykxg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2559.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(33716001)(4326008)(53546011)(26005)(9686003)(52116002)(44832011)(316002)(5660300002)(8676002)(38100700002)(38350700002)(66476007)(55016002)(8936002)(86362001)(6916009)(9576002)(66946007)(6496006)(66556008)(956004)(2906002)(54906003)(83380400001)(508600001)(7416002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UQSxagk7TDfL/eAkXucdLwYw2WMIGLABAS4Cz2Lpo+BkEjD3OlkYM2x0mxH4?=
 =?us-ascii?Q?apuBiDevhumTfubR143G/6+FqUvsOsX9FE2IPzShsjuXEepquGIG3oWRFtrt?=
 =?us-ascii?Q?lInzNSH1oRl+7VHaQy9IyOfHu7kng6x33prMj9e6e/P4sDGZ2Xe6QOugLXR1?=
 =?us-ascii?Q?wyMjHUnb+PSS2FjeylknyCmtCGuZNLxvWZikYES61nRB3Pyuh4jJrqv5On7n?=
 =?us-ascii?Q?KVkXdnWnVyywOY4PIVqtd44rOvvZbH+rOgDS1J6lwHpRoUP9OEV+p/xSy+nr?=
 =?us-ascii?Q?EIt42KLzWu1j3FiUMIaaZS5NpVgyrCgjZC+y9xHcDeqGqgi/obOGDqkf3JnQ?=
 =?us-ascii?Q?7IFfCDeffrUmjvDohhSgQ66Z7VZYqAG5usa/NrlbXqVmIajQuIHxW7f9oLpx?=
 =?us-ascii?Q?fxyVJL0PB0rJ0mgWQKOvGU71AfqzLmOLDs5XFHGHUriO4RsEVLI19aGNfOzn?=
 =?us-ascii?Q?JotPG4cvUf2eSXa+yB9cXww/DewiZK4Nv8roX2+SZyl2+NYLVz1jBiM9/tbL?=
 =?us-ascii?Q?IX47DEA9EyRvNtlLH2MImkAX0A6ikcc+KhbF4SNFQhDYY5ntxRQgr9HCOQ7J?=
 =?us-ascii?Q?obp2cYbRfnXCDfhrZBBQ0GBkkUyoVpBHiNhsb4irv+kkmKQTafYMpGRl4Mu2?=
 =?us-ascii?Q?ls16vbw4WL6gNvNgK/uzn4oT/iWKJnroBD0n9jeAEOdw10E7vMk9IiOnzG5d?=
 =?us-ascii?Q?fQnKqjyixYvMztEdYy2ThmavwPjIxd3n3AkzD+b4q3mkuAPL3zEs11sEYsPu?=
 =?us-ascii?Q?fabbLB9kvZML8JTP1VGMDPYiuxudN/ksYWHkuLIH5YQyZsUNfGeyFPFPDry9?=
 =?us-ascii?Q?oJ2JPdl/0eQOFbpHVCh3Yr85epXJFS+Eq0dZ/ZNpqQ0Iac0rmMFbwu1sWYjf?=
 =?us-ascii?Q?5PWDsWiQxg0UEWpJ0A9t6lm0juzL9gjcLDScOzMw3P39fQrBuFcpZpyKi3Fy?=
 =?us-ascii?Q?rGo7E73rFvjZvzUgG/t4Kv8UC8GHSVElFzjDz+RoHh2GFWHOai+3qfeNbgBR?=
 =?us-ascii?Q?RwXbGn7z4JxLL+UWaCABNd5FmxDaUNpUZY/aHBCR8NkFzOm5pn14Ld8UJew8?=
 =?us-ascii?Q?InRpF8hShYz+YoxCkrfSqgtDep/I1gBvmnBKszGYDNIJQ1q4bO5o6NzfmK6N?=
 =?us-ascii?Q?K1bQDIEvwN4SaJVm+kxKrNT0k9/C5TrxRlu5S2fSbZpkQd6h+taHWPWAy7/9?=
 =?us-ascii?Q?zb+SZoifmU56DwbLYTFF1X5M0hI092xt/hgEP/kZQmkvgH6zrnv8QHvmBmn/?=
 =?us-ascii?Q?KeslOpKBDxuEmDEzijlzZDT4Cku2Z75YvpT/v4au4wpoNRFrbbT/VKNUyc3u?=
 =?us-ascii?Q?FKqS0HndIhq4v1E/Ccu+EjQi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3952a28f-3e07-47e4-001e-08d9825ff913
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2559.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 09:11:36.5650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OKf2vR4Xe7MbTarHFCkXZnBi6myh7k9c9sWWk3HdFD6/n0BF9XnT68PL0SB1DMJpOke7zbfn3pTpOmKuyCRA+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6239
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-09-27 09:28:56, Stefan Riedmueller wrote:
> The csi_sel mux register is located in the CCM register base and not the
> CCM_ANALOG register base. So move it to the correct position in code.
> 
> Otherwise changing the parent of the csi clock can lead to a complete
> system failure due to the CCM_ANALOG_PLL_SYS_TOG register being falsely
> modified.
> 
> Also remove the SET_RATE_PARENT flag since one possible supply for the
> csi_sel mux is the system PLL which we don't want to modify.
> 
> Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>

Applied both. Thanks.

> ---
> No changes in v2.
> ---
>  drivers/clk/imx/clk-imx6ul.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
> index 5dbb6a937732..206e4c43f68f 100644
> --- a/drivers/clk/imx/clk-imx6ul.c
> +++ b/drivers/clk/imx/clk-imx6ul.c
> @@ -161,7 +161,6 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
>  	hws[IMX6UL_PLL5_BYPASS] = imx_clk_hw_mux_flags("pll5_bypass", base + 0xa0, 16, 1, pll5_bypass_sels, ARRAY_SIZE(pll5_bypass_sels), CLK_SET_RATE_PARENT);
>  	hws[IMX6UL_PLL6_BYPASS] = imx_clk_hw_mux_flags("pll6_bypass", base + 0xe0, 16, 1, pll6_bypass_sels, ARRAY_SIZE(pll6_bypass_sels), CLK_SET_RATE_PARENT);
>  	hws[IMX6UL_PLL7_BYPASS] = imx_clk_hw_mux_flags("pll7_bypass", base + 0x20, 16, 1, pll7_bypass_sels, ARRAY_SIZE(pll7_bypass_sels), CLK_SET_RATE_PARENT);
> -	hws[IMX6UL_CLK_CSI_SEL] = imx_clk_hw_mux_flags("csi_sel", base + 0x3c, 9, 2, csi_sels, ARRAY_SIZE(csi_sels), CLK_SET_RATE_PARENT);
>  
>  	/* Do not bypass PLLs initially */
>  	clk_set_parent(hws[IMX6UL_PLL1_BYPASS]->clk, hws[IMX6UL_CLK_PLL1]->clk);
> @@ -270,6 +269,7 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
>  	hws[IMX6UL_CLK_ECSPI_SEL]	  = imx_clk_hw_mux("ecspi_sel",	base + 0x38, 18, 1, ecspi_sels, ARRAY_SIZE(ecspi_sels));
>  	hws[IMX6UL_CLK_LCDIF_PRE_SEL]	  = imx_clk_hw_mux_flags("lcdif_pre_sel", base + 0x38, 15, 3, lcdif_pre_sels, ARRAY_SIZE(lcdif_pre_sels), CLK_SET_RATE_PARENT);
>  	hws[IMX6UL_CLK_LCDIF_SEL]	  = imx_clk_hw_mux("lcdif_sel",	base + 0x38, 9, 3, lcdif_sels, ARRAY_SIZE(lcdif_sels));
> +	hws[IMX6UL_CLK_CSI_SEL]		  = imx_clk_hw_mux("csi_sel", base + 0x3c, 9, 2, csi_sels, ARRAY_SIZE(csi_sels));
>  
>  	hws[IMX6UL_CLK_LDB_DI0_DIV_SEL]  = imx_clk_hw_mux("ldb_di0", base + 0x20, 10, 1, ldb_di0_div_sels, ARRAY_SIZE(ldb_di0_div_sels));
>  	hws[IMX6UL_CLK_LDB_DI1_DIV_SEL]  = imx_clk_hw_mux("ldb_di1", base + 0x20, 11, 1, ldb_di1_div_sels, ARRAY_SIZE(ldb_di1_div_sels));
> -- 
> 2.25.1
> 
