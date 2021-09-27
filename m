Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770304190F0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 10:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbhI0IgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 04:36:16 -0400
Received: from mail-vi1eur05on2072.outbound.protection.outlook.com ([40.107.21.72]:11297
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233418AbhI0IgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 04:36:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQs3KD9dDbwWNTluldrz+GwV48QnpEGNPc7hBXv5uTsNtZQczFd+71EV0B78u+ql1DU+SnCS7F0/AJZs6e5Ykc5QBF5vx+UPJ/Z9UjD2rXGfGl7K8cfwEsLxQ+4d4vilD42fJPGT9QztnAwZgu2dB2n1eLpjloUPS/+n5gpgQqO6Vbm45QtYt3Vg4HziYT5z6d1nj4pwuuBkc6UE4shGErbFqggMrN0soE6UE2mdxIkvYGBkMOrEglLzWI+AWJPE0r3YVvsDiTSc9SOOXvVrpzMyBFxK9GK5GzKlCJ9nIDNp2xi0QKkrLFaqr/ETR7RT09S2O8akmAEJ6P7pRe12tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=FTugsmArcZOdGJUtQj+2REjNkRpLqPJrHqXQmRkrXzE=;
 b=YzYhgGXOJl4grn5L6eJ3xw1rqJhlQrupygQqE8NZDuYIAj5w9DqBg7VX9JnweNJmliJZFGWPCNEQ95EC6sPVrqS1ecVas21teMQB8+YEw3oUJRNVjc8Up+QL+SM4YT2sweCvrPxr5gGeTseTeTLlFYBnbs8MzRPhjotD79K0ocNA9l7dc2on7oABCfDlsYoLMw/m/qoODgL9fbHpDV5EUibCmmwTXTv0ny1KMTTulgdJv07ekrKof+vP5vGyoYwG7/M+cKBX6bJSqJ/6sfPinxj2MN59rw5UspMhKZZQDPlE50aEb+XoarzhYqstu+86Slzyh9UntlwfUtYE8l+5ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTugsmArcZOdGJUtQj+2REjNkRpLqPJrHqXQmRkrXzE=;
 b=mA16RxVA3QKU/cfBmcIOC8CC2mZEMJVh5egzAG+ZOO5kkt9lz+yCQhNeLFwTu2s1+g1QB0AvVzZwxYs5tTDzujdOUNihUiwESIKOKwHY3s8vGXcgB27T6KCSzravL1vk70AUWAvfgAaBAlWhljCJ1VDDPiLPttSm10h5gG2c20k=
Authentication-Results: phytec.de; dkim=none (message not signed)
 header.d=none;phytec.de; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0401MB2559.eurprd04.prod.outlook.com (2603:10a6:800:57::8)
 by VI1PR0402MB3901.eurprd04.prod.outlook.com (2603:10a6:803:18::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Mon, 27 Sep
 2021 08:34:34 +0000
Received: from VI1PR0401MB2559.eurprd04.prod.outlook.com
 ([fe80::485a:4462:94c2:5edb]) by VI1PR0401MB2559.eurprd04.prod.outlook.com
 ([fe80::485a:4462:94c2:5edb%10]) with mapi id 15.20.4544.021; Mon, 27 Sep
 2021 08:34:34 +0000
Date:   Mon, 27 Sep 2021 11:34:31 +0300
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
Message-ID: <YVGCFwN3G4drKxcX@ryzen>
References: <20210927072857.3940880-1-s.riedmueller@phytec.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927072857.3940880-1-s.riedmueller@phytec.de>
X-ClientProxiedBy: VI1PR0302CA0015.eurprd03.prod.outlook.com
 (2603:10a6:800:e9::25) To VI1PR0401MB2559.eurprd04.prod.outlook.com
 (2603:10a6:800:57::8)
MIME-Version: 1.0
Received: from ryzen (86.121.85.242) by VI1PR0302CA0015.eurprd03.prod.outlook.com (2603:10a6:800:e9::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Mon, 27 Sep 2021 08:34:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39b67c10-6cff-4a7a-4b7b-08d98191a1f5
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3901:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB390178DDA09C343F258873B5F6A79@VI1PR0402MB3901.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ruKly5ef61oTmwaO85BT5iR2t2K2J2JfT15DubQfvcfWpEAP3IKWaeL2cXlKyWeTQD8YRQptjrTzT2xJP0pVYtzT0JIKvPOXfojPnEjlaGFh+1JHq5jjrmu5TZ8NKoViFUnUK9lsMpMbq6V1pWOHf42Q4IlRw6Rwssv72ChfI75tBM9tKVXE83MPv4llhggyLV2k5hMg/e3Blbb5xcpEXydAT4lZzAPR/grtj8dCgnqajPtbf+Uhfc3j8y0kQRu6N4gqDRz6/MbF7HyzxKliAAJPsCg9uzHZprYcHN1cVz41a9lOmp6CKZH6LLLrUrkw3xLAQppT/bNcoQAf2xhyXLoDAdEioWR9rY4tS6G/Sv2Pzaa64wedsdqFH6Ua3u+VQsiv1wwNYQfBFVVGO3j7oMy5RoAZP2weORNUN/5XGZyy0NMxM8IgZc9qwuemFcfR+zxFObRj1Lymd9UplEDerYs0EJZ3RtUEorAZ21r9aiGLDW+B/y+yp+T3n75nYCVda14LUC8Ek3ccr3njDx3kkx0LHe3Hey5oQtTqivNPupWc8ccabDQNn4TVTZ5KQFwBdOOhu7WoGDvDfhHO1AaPHkdHgvmRUDjE62VsO9/20vbIeWED3b9yYeQmxRyVI1B8s1/NDVmAPqKscKIYQwu2LXNjOE78B+j86X+hmkDZC+aYYlUBtGLztpVN7XFN6ChE27sGdH8M/hYfKN7bEXBIazzmIocZPQ5vBlYFJFtcOUc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2559.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(33716001)(66476007)(7416002)(316002)(86362001)(38100700002)(38350700002)(6496006)(508600001)(66946007)(54906003)(2906002)(26005)(66556008)(186003)(53546011)(55016002)(8936002)(44832011)(5660300002)(8676002)(9686003)(83380400001)(956004)(52116002)(9576002)(4326008)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YXWG8i8fSYD+GlRHcggKN3i8NvL1+GQ8BF2wmfyKiv+smovIQrFdyQv68at4?=
 =?us-ascii?Q?NIBhUkt6y8bwbiL6inLWR5uF5QNu1R4DeIfkksnlnkYPauYD58JslG9g1UiO?=
 =?us-ascii?Q?Uz4vDgK11cnOH8uLn3v+ehQHWPuE/aJY0igMxFZJ4FjaQg1yv4ZQrUq4OvdY?=
 =?us-ascii?Q?xpGtG981OQw6apycK75dKZORjapIcVLIPTW+yb6vW0XKFATCoRzlMsRXhgjl?=
 =?us-ascii?Q?KajPUk7AtCIQ2dnSCmI86NNnNVL56qJwwEL4M7TKmfKMA/WUQgGsmqAIeBYu?=
 =?us-ascii?Q?X61jLCnXKrYqN1AUjsGpkFzd/v9n2ZJXGCNkDzygtzmUpP1+aT+s7TF2xvhO?=
 =?us-ascii?Q?y/kzypCBFpnksOnZS6siRapFRdpK4sCh8womht0yq0rWnKEvLhhtG4qOgjw8?=
 =?us-ascii?Q?J0t82avP7C9sSr/sLGmJN8+SBPeylKnXcCtlEMfhguk5o8Wv+Qljp9Jd2Vxy?=
 =?us-ascii?Q?2fCR+1TXsHbSSzUGS3MO5cECzxxGBDDcDzDNy5TpuMUYJOoYdXNJ6f9blVn7?=
 =?us-ascii?Q?RXTcvFTMMv3a/qSXaYKIDWZN+h6wKXZYCWBdIQ5/iTdaVcJKuOngfvgK1s3T?=
 =?us-ascii?Q?jfRdMaeJ0ZTGbqgubiq9VIY7YePw6dcAoqh73CXabe3PVws6MG7KHRiG8lMq?=
 =?us-ascii?Q?lRZfetcfOjFxZ6P1vdJCooaOCxy91mXyQSWZ/X8t8LZx6wrt2d8OrKzVupqE?=
 =?us-ascii?Q?HKsxtVcgZWLpo7BQbjJE4Y8W62f/mFplrQSiZYNAVb04OmdYD3c0FbYPxnyF?=
 =?us-ascii?Q?UGeWq0VYmYqj4KjKY7sHHZ5SOr9PdQIVi/XXW1Xc+BxrbJ8EALs3uSYN0EqQ?=
 =?us-ascii?Q?G/ywgoNyQoIvf72TQANVJ68GZEb1Ji63yJhYvy7U+mPsPAonN+UOrGePznfx?=
 =?us-ascii?Q?kKFYT64s/esUDUIGiSKgewgK7K0d94+fwEt8mMZO85cyA0d/NA06n3xfFxqJ?=
 =?us-ascii?Q?K1hK0GU94Baq0IlelAYLjYrr02qNBzSs8xQQy0vW7YiBx6tk0VI2TZ+p/9V9?=
 =?us-ascii?Q?rr6MuIPfUtV8cu3mFIljjmD9CDA3jiZR+JDvOhCM4XZ7PrycBKn2OZBQXeib?=
 =?us-ascii?Q?bZLT5XLvei4yaarzgcLtH12jZtrgFMWVTgcnDKvY6bVNTXIhrYsCY11Kv4Kq?=
 =?us-ascii?Q?6cxRzDszTb7Gh6C7DbS6NgszT2mvTa+WQ35eiO2pj8PZ4HqZ2ysDzptjvFnF?=
 =?us-ascii?Q?m+EMxAJ7U9DGN/5IrdgDtxqvdHWfIlPaYDyaA2MjlK7vuUU7n8Ojef15B6O3?=
 =?us-ascii?Q?jkCJv6toAQ/8MT+LcCr3wud3jRgZoCyU5328m4U3XsrBszmPqsn7QKkgQUbi?=
 =?us-ascii?Q?6qjTQOv20J0zR6ifslB5wfx4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b67c10-6cff-4a7a-4b7b-08d98191a1f5
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2559.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2021 08:34:33.9463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jlag7NE28jAEPSlqVOisgKFI9jgAzYo0qHlWVhZFELRm3OmmYHp+zDDF5Axq2DVwqteGYSGa+IbspCOEjbF8eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3901
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

For both patches:

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

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
