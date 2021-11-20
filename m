Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6705458057
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 21:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbhKTUkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 15:40:33 -0500
Received: from mail-eopbgr70050.outbound.protection.outlook.com ([40.107.7.50]:35044
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231818AbhKTUkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 15:40:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jU5S4qGkrcnVlp73AX5h4EXyX7m+zciFieOWOa1pkjwFPPIqQm/DQpFmT0MjrxUxfUC9OTi/2Em71Btzt/hlf2s31TGJbEes/N+jAqP0MdRVaCWtuaC+tI1IQmEOx217+PXRSMrX9TXx6cIW4RT+JGl/mYm3zb/0nEJFxYefNxBKyE201cWQzxbiviAbOcbhuwjgorf/aO84gQrSysnYGYuUYZkPr+x5odYo43GxHpmQGvDVBx6WM+pQL5LcDSxa98dzB3MAg5y6plCY8ectHaq56mvQt9aQi4TVjDbUjfV1/gHupcZJaOad2SGemovz/ps9dWS3WeU7kwVS//+CCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6o77xnjLx+cuN15w/SbjqCiBor6gVJDUOmaHt0xQRQA=;
 b=hL1mmE8uuf5Fh2eMqmsJGJFAyBwXrWcMl/MeOYQD4I3tNNj/2il1VaNCWawccfajfyqcl8WLO6OOrJ9YASuJLwROWnWevMk9lVlMa9dj+fEfDXoXyeW6R3xubtMx3HWuyYfL9PoKRsWfsNwZofzgHpo0J+xfsJeQmfyEKaKn88m9dTJPMV/ry0bxbfANhkrGVaz9bYLerM5UTM54FQ1o1Tck1CkqOkAz/6Ph7Mrl5EGsWMEtl3SPNU6kOqU//y1tYzbsp29nPwhYMmzWxJlRcEuSzJgGlX7nWPyp65wqGvsABzrjGxHWkvKzdhOTqw2vKzhgY7pqNJNtGF37dP8umA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6o77xnjLx+cuN15w/SbjqCiBor6gVJDUOmaHt0xQRQA=;
 b=U9TDvVxOxiXBNeadAA6N2BZk5nMYpTBRHnttsTx7LAAibewlcLO2bHpgj3V1VKon07HjoSt7SZtrmyJ7e6IXZFKncFno2TYDR5vYD1A1OjefljrvYUt0/DYq2+VrWAwTVPSaf/35hgthrP/ra816t/TC9Tt6y4zeoAvbA7Oao8s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VE1PR04MB6703.eurprd04.prod.outlook.com (2603:10a6:803:129::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Sat, 20 Nov
 2021 20:37:26 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::d0eb:49aa:2a9:9fc4]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::d0eb:49aa:2a9:9fc4%4]) with mapi id 15.20.4713.024; Sat, 20 Nov 2021
 20:37:26 +0000
Date:   Sat, 20 Nov 2021 22:37:24 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     miles.chen@mediatek.com
Cc:     sboyd@kernel.org, festevam@gmail.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, mturquette@baylibre.com,
        s.hauer@pengutronix.de, shawnguo@kernel.org,
        wsd_upstream@mediatek.com
Subject: Re: [PATCH v3] clk: imx: use module_platform_driver
Message-ID: <YZlchKnEqWN8nKQk@ryzen>
References: <163087455086.405991.14496690646389782129@swboyd.mtv.corp.google.com>
 <20211105055932.3432-1-miles.chen@mediatek.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105055932.3432-1-miles.chen@mediatek.com>
X-ClientProxiedBy: VI1PR0701CA0039.eurprd07.prod.outlook.com
 (2603:10a6:800:90::25) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
Received: from ryzen (5.12.226.136) by VI1PR0701CA0039.eurprd07.prod.outlook.com (2603:10a6:800:90::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.13 via Frontend Transport; Sat, 20 Nov 2021 20:37:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4468373-0b03-4f36-c6e2-08d9ac65903b
X-MS-TrafficTypeDiagnostic: VE1PR04MB6703:
X-Microsoft-Antispam-PRVS: <VE1PR04MB6703E3FCC8CE5D87578C43BEF69D9@VE1PR04MB6703.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YD5L2JU+piX7c18K0NmYcEQ6IZA6DcD69/7+INz8o3Woetvh2K4Ihom2/SFNc/mj67QpD0xqE4aLi64a6qRU+XjTJiZLrLVXyp0IH4Cn/7M6YY8sWKKkAB5koMo1C/AIgWm9+XrKpu3KYNYL7o3lOxMqfAmyNXtmdl8SCujGpOjiAVgcFzE8uXEKU+/7YNHOaJN1uPqZKwwn3XWLPk5LucdOyEs9p3Jl+lA2/kylGH4e31OvfY0jcCyvK4sVrb854Yw+3TolfyNUD9wWZrvd6ScYmz9rHXrB657j2l7TfHvgn3+k6t9MQ2GK2GiLJ0EZ6NmES+I7XooaX68AfJ/0I/0vmkEB7J2LQ/KC+y2bLFw2b0Q1LXESojkgEI1KnhhjjdCJsaJhbd4gqQvM238iFMT0BBTfLC0x5I2uoiWXZ8mj+/swyrHwKQPnonjn0u3vIKc9ehLplNj3HIz9jVVpBS1mTZ9pxJVfBgrRF85kTpvI1MgjhPFu5KQ9+0kZQTLqiff7oAw0XD6q3uR8wsV0A39YEPEvH+O0gXjQYyFSrtLPux16N8LXwGYGfw8HE+pmwfM+2ISIL0eMqt+DpiV9bvujwUgxLAkkcOTanyF9SPStPvg4BOuux+snLXkJZGgiqTPIaIOu0Vvs4ffI56YZzRpHPvm+MLvdA5RipszphJQA5Oc0NKx26KOMIeUFyeTFwGZXOw4wP+FUwePATpnSzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(9576002)(52116002)(316002)(6496006)(66476007)(6916009)(2906002)(4326008)(26005)(38350700002)(33716001)(4744005)(186003)(53546011)(7416002)(508600001)(38100700002)(66556008)(83380400001)(8676002)(44832011)(86362001)(66946007)(5660300002)(8936002)(55016002)(9686003)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NzygtBfPDcKZi5wMtkHxGHPEb0eGS1eNJZ1OJSqPpM51wujbz319GBqrRiSF?=
 =?us-ascii?Q?gJP3aXB8S5JyiEE15LVVl/TXxLGTRxe7BRqCUhuBwiuMxwtrX3BAyiXdtJ+x?=
 =?us-ascii?Q?hc9wScluHl8KyF9AL4x7KV3Sm4Ta/meItb6KIGCXiz51wvhqM6jE/ncEby0i?=
 =?us-ascii?Q?qJycPdugsrngLbipdzB9Yx9JS9bL8sY6VXpC9ObbFERyXRrebiGGeO+wMKdG?=
 =?us-ascii?Q?DiMkSdEFPyNqny5I9Kwzy9dQ9+Yn1PjMVw3V9XHepwo/f1LsqFQird+j3Ck3?=
 =?us-ascii?Q?uYxVELXzQX6TKg/3v3ZUeSCncYt0HLvgg9czGMZK/I7JKdK1W4unN972MB1u?=
 =?us-ascii?Q?6iR5Mk03TkSdom8oke5Ft/2X6xJC+QTbAC04LUfMiwnUlrXE1SCS9m427tDz?=
 =?us-ascii?Q?PU19GGKzkhukHNNXPED7ECGYgsJFVeQmRUBgvhmX48U7mBFTzwKHMZUNOpWg?=
 =?us-ascii?Q?ELd3tH2RWqsgwe962gsh2Pc08UfdFkHsq5gLP1hPbTsnLwt5R8gblVbScaTx?=
 =?us-ascii?Q?XR8itAJmp1Sv+IMADRIbVvMTTFZdrml6avUFHKBNrcQ2OGdwA7hx8RtMI1wa?=
 =?us-ascii?Q?owRZOP2T+r8AVd000dnRPDcI1dagMY8KDy0b1vF4Opi4DiRvloHo5rrSS0nj?=
 =?us-ascii?Q?CcNd0O9iY6ewq2T3++Wwfe/pzL2jjztRdkvN9WIT6gojKDmUCFgnHOIdW1G6?=
 =?us-ascii?Q?/lvOVPIn/lWSw8cSv8dbhPvxRFOl1NJxLHmKGFNtOAWivVHTQjhYsm/a+n/A?=
 =?us-ascii?Q?dhRKaz8XJyxbcURwmK8CCu6ZerbaOAnrnnSz2BIxGK4BFMbbA56gEoupfpxx?=
 =?us-ascii?Q?i0c4oG2AfQbnCQroXtw81foZnObNTD1SYQGPpis202KtLDnXZsmynvRytq3z?=
 =?us-ascii?Q?4zCbvwMkJ/brsvzXjLVT4YlUFNsrbfvOYwcjQuxCYMlLSSAUzipGSwvlehrO?=
 =?us-ascii?Q?QxkT5qLnK373GVjFuYfWQGX4MDCEat1Rk+zxfIhbLE2tR2MpiE0QqKu0C1h7?=
 =?us-ascii?Q?lwVXU/Sh3mEmv+yDSDD0Vit61Gk6CHLJrAb+qJc8giPHZ5m/lVxy0LoyU4YT?=
 =?us-ascii?Q?oja2plPbZnInpyU4Xill32MkP+bFuE7x20SyiP/yrHIRrn0JpUOPJM/i/6Bn?=
 =?us-ascii?Q?fq76Lxqqmm4I5ldEcUqr/INk2xavFackr7pKJZ7AsrFWNOxpJg9SusNAzwMC?=
 =?us-ascii?Q?joihIZBFts/rz3dTujLFkoFCUiGTySTKq0Cc7GUAvsYIFLelsb3v8v66dKlb?=
 =?us-ascii?Q?oQGNImqJFG0Ysrdlwf+Vt5PekAyo84OHZUd0TxfG1Pq1b1BGJCiRvQ++BTHh?=
 =?us-ascii?Q?0KGgR2jlp5kQpwjBeH441NAILFPkmU0+6AHK887htqyY9kiGFA9wB24sOtFI?=
 =?us-ascii?Q?73RpZRY8v/F9/4jT3uzPSE3ykmfEmBzXk3dEG0JFMRz/DLQLPHgCgtwI5F/m?=
 =?us-ascii?Q?pxgkmfrVInwDGj1eYRwjO1BXxj6nzZ6kVFfg07NJOMsKszZ7K0DHO7ZIBsW4?=
 =?us-ascii?Q?TQ+YZZf5aQhU0crETdxlpDf2osvpyBNW93JFpzgfL5KZqbNK8P3TaR+pAkGR?=
 =?us-ascii?Q?fUqBRzqNWGI8+Qks9QUlCjTL2V4HTMzCTK8ARJge5D1sItgawVloMxUqGXkE?=
 =?us-ascii?Q?cbphD4EJNV7vRALYysjJGkY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4468373-0b03-4f36-c6e2-08d9ac65903b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2021 20:37:26.2715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXJ5zXrJFeVgk/1E+9rknWBfUIcdBZb/1f4dV6O1No5iQ5dWpmhHJnrNNOJb4rxdOPH/cQIoJtJluXSn22iIzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6703
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-11-05 13:59:32, miles.chen@mediatek.com wrote:
> From: Miles Chen <miles.chen@mediatek.com>
> 
> Hi Stephen,
> 
> >> Fixes: e0d0d4d86c766 ("clk: imx8qxp: Support building i.MX8QXP clock driver as module")
> >> Cc: Fabio Estevam <festevam@gmail.com>
> >> Cc: Stephen Boyd <sboyd@kernel.org>
> >> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> 
> > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> 
> Thanks for doing the review, I cannot find this patch in clk-imx tree,
> Would you pick this patch, please?

Sorry for the delay. 

Fixes are usually picked up directly by Stephen, 
therefore they're not going through clk-imx tree.

Stephen, can you pick this one up please?

> 
> Miles
