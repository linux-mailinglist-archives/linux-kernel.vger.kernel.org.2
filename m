Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D3D45804B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 21:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbhKTUVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 15:21:32 -0500
Received: from mail-eopbgr50054.outbound.protection.outlook.com ([40.107.5.54]:29820
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229488AbhKTUVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 15:21:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijuO7Ag62TpB8x4tI9xIW/7OBg6F2fdDMhLGlpAAsG5WZ7uqZCCsSvI2pEy+RRaMeeg7Q2v690oVM5clZfmrSgIlVGfSne6pTm2gZhwLOK3YcbWMboyNQ/T7yt5B7faHpfLQLSZpnH7Y0nXk1Ap9cYjeh8ia75e81FqRym3t4zp8Hb13eFQ7DuCjUyllwB/+6X+CiAFWKl7nqBx6rQlvvi4k5yqMJ+fWirXBRsmXu1O1ZbJVCkbOiWFx+XLgyFwNO6ddGV6nkUOtuNpYkXfhge2xKmhYjHbr8A+8QZVkvcJCWPW2vSm2cpAkfUoaQgvR0s7oU+AF5qNwMMDDtHY2MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75dNMHAo82fcT8nTndTJBTHq99Sw2IlQaVLiH9aJ5tQ=;
 b=oAw91d3u1bfiHvVR3R1xB5/dIEB6lE2hLM/RjVc+Xr7PjeR8bKW0YN5Zrry26g7wrttTuna/9m60Lnj9rTNYk53l5hD9UtL9oGEp5vljh/y5aewzJPFwMIZbPly8OhmLTynBX36LPYWIIm4Vam8YnnKwop7U7RAFRCw04+GyT6X7wkddonPnKK4qKxU5sHoeDMtRXYlaugEzJaKuICQq00NreV0kxj1ZhYYSNGqNZseerHcbjb9UooLxNroa6UbMh0nK9aArUeuwrLpt9bfHR2I0S4H8nF22HxmBwYNEROGAtB0i6jcNSPxlzifUo0dIN9/NrUUZ8bCwIWVtRTRH1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75dNMHAo82fcT8nTndTJBTHq99Sw2IlQaVLiH9aJ5tQ=;
 b=pwyoTPnwkNwk7ACaFHhH75ypGsjDsSVKJTMkGM+hASfjF+ti6ET37OMFO8f6VQIVhf8SlULp4pZsX2EyFS4cBZt7gN8aQsdPeX2hmncZHXQZqE4LAoV+0qpBPlXFEM4mKdiBHeArCqkZZ9Pgnizs68KACrcmnOTBHEO9o/TQ7k4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR04MB4685.eurprd04.prod.outlook.com (2603:10a6:803:70::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Sat, 20 Nov
 2021 20:18:25 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::d0eb:49aa:2a9:9fc4]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::d0eb:49aa:2a9:9fc4%4]) with mapi id 15.20.4713.024; Sat, 20 Nov 2021
 20:18:25 +0000
Date:   Sat, 20 Nov 2021 22:18:23 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     sboyd@kernel.org, mturquette@baylibre.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2] clk: imx: imx8ulp: set suppress_bind_attrs to true
Message-ID: <YZlYD4MFFrLgZeoh@ryzen>
References: <20211022131513.17381-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022131513.17381-1-peng.fan@oss.nxp.com>
X-ClientProxiedBy: VI1PR09CA0175.eurprd09.prod.outlook.com
 (2603:10a6:800:120::29) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
Received: from ryzen (5.12.226.136) by VI1PR09CA0175.eurprd09.prod.outlook.com (2603:10a6:800:120::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend Transport; Sat, 20 Nov 2021 20:18:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bcbbd3f-87b0-44ed-1b6f-08d9ac62e83d
X-MS-TrafficTypeDiagnostic: VI1PR04MB4685:
X-Microsoft-Antispam-PRVS: <VI1PR04MB4685C58A87EEB2C6E8D962E0F69D9@VI1PR04MB4685.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4PAYVhSRya6bEOlHgKmmiRvff/Ax7JPDMm+XZYlcp9ZrsFC+ybENL+Hf3bBHchRRSj0Z7EhsoonPEqCf6CNURa6Z/Zt4HkJ3ha+IAIrxPMqDVhFnu8RuWKz38Bzg/56225W4L4qWoKe2ib2KaVwj9r5RXMukookRt1+TFoRNkXCr78FOnKlQpH+jw/uGfSkfEzXrJCO1NxAnvZqRpbTiSyPWD2qgIK+T/p85nnHV/80tKsMZHD3Z620PLZj3bTScHTyPHIaJguUgKz2tmxgeoGc4ya1KO0/MDKeNz0PtaGz97MNRmLSPUtphUHvZXyMmH1ThLO5MJN/E+8WpnSN1g9RNI9/ml/A9fa0+fz75F/8wKCUtOMsEZTRzHL86OOZXzRh9lKej8LGAZM4mfGvWX6m1R17RdaXoA3+mMqbVrPT5noDndGk0tjO5LRWa4EEvTqephchXwUpTkSnx+iJPCEGPLewpJb0PMqjjZn/qY9UNoNpy/xDEQOPTaHRvCoveI0N5+5AP/yZZf2SjYboqwXJ6a5J3WKZd0wLHSy7FkcrPeX/vN9pJ1aJ1Npo0+JdKiiRoZaA+qc4O7I3cCUPbLW1YQzBDPteQxK1ReOnH2vLFvSyl+uvzteuabcdqirOxW/iIeDZsxL1BJHnd/2SJ68VWpgESRt0QKrswbiMZmlWijIN4lkchfAe+RxXox+uB+x2rvGLUVwxV09kc8m3llpyVyTdXlKMuPmhfgiSQDHk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(8936002)(86362001)(2906002)(83380400001)(44832011)(6496006)(38350700002)(9686003)(316002)(956004)(6862004)(4326008)(33716001)(52116002)(508600001)(26005)(5660300002)(186003)(55016002)(9576002)(66476007)(66946007)(38100700002)(8676002)(66556008)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yt9If4UD5V3/Tamg4miHI7xNEV61VOFyKeT4jvG4sPTW8EkbvHekWVG+wH/T?=
 =?us-ascii?Q?rP6uXiK96933urmiNWIxYsUL1esuiM+AgKBDWtwYNvDgHqAhQi9KQNnAZ4DW?=
 =?us-ascii?Q?A6xnSAKpMOMhQAkTcvXoOPfw2gNfHTPM9CTidN2Ciu/znbl0MDmg1r0D6bv3?=
 =?us-ascii?Q?xUa0/CRZGTeGTqnmfQZWS/2owFSPq603wySPcyeINeeceS2vADfE/Zfh6KnG?=
 =?us-ascii?Q?AOa8EwM6LhYKL8eV6AKEu0IyGRqimicBwcExvJUE5JP4plvj2QMf7iZ+LDWC?=
 =?us-ascii?Q?D86yFE8/fYKrHhBhWHnRCaqwseGuaV8Lw9gkm5Em8TOiprtGmKmFlaYTFqAz?=
 =?us-ascii?Q?LOFnRLf0t5ZKqNyiy0QULyRNCLMX9uaPAi0gSZ1VI5i8+x+JfjKe1KZ7UpiZ?=
 =?us-ascii?Q?Pp5KnMqz/QCbzn4TAgAz3CIOTFqSNi7+8TixRDQjEqaU0mP9htg10SRYkwX9?=
 =?us-ascii?Q?TruWY1raTmQy9l8+VmqLXQqAcU+062KnLetuqs4UZUb5cDlbn0W4SoUBfjhH?=
 =?us-ascii?Q?fWZLAjbrqQHecIT2cZtszcpw1s4fUZPyECDIXHxni8z8/jwIg8bnNe670ZnY?=
 =?us-ascii?Q?k2n4MRk0t5s0h2UR548sGvxIcIuKy/17NumPUaF0Mu1dFbih9EVtwkDMeZLc?=
 =?us-ascii?Q?tucoTFLbzTsrgeYW8vamZnOCA6EDZTjEX/f4IEwF+f5ORkjs+h3csClER5Ys?=
 =?us-ascii?Q?j0KQHzkJvIRP1UwDFYg3P+g0Q8h77zoBII/PklqxksfViebtfjCcBVwCy15P?=
 =?us-ascii?Q?Wp5IYFmvfU+J5JM5ch1mFWpobSk8MGmmeJPJ/nxSxxOgP6gVrnxe/e6rwNtY?=
 =?us-ascii?Q?VpXMxvsYTAdB29ytw4/in73UMYB04/bSdnMnssNf7+P8bZOEMMVh7t0zNv1y?=
 =?us-ascii?Q?uQw822pPsfye+gYn0V5XCnH7Kbw32Hy5Y1RCUrYUGf6lj+6VP0O4Z+JtqHgQ?=
 =?us-ascii?Q?DW21tY7lc3rBP2xt5YIlVyqyjFAfEj/ywA4gYco6lmha/LJX1MXdVcgqr8B+?=
 =?us-ascii?Q?j3xEzcWpi9FlInCBPDNK7Ktk4+s/J9wJnFrlrqw730T+cqRmMwNM1H2AHkrz?=
 =?us-ascii?Q?fxp1W9guRuCe70WV6xpKup1JJOogxUkgKyaL3q4G/4Nn9HPkZXMx9egw2P8t?=
 =?us-ascii?Q?2490xNvQn6r+eqe3zDdceCp4BNbmk2lb2GIQzwBrxKWk7jZDXbUja0e/2VxY?=
 =?us-ascii?Q?9DYvWDvRKuQmUbqdhvotA3I8Pa6eS40t9qYIWpNt7ku869MKwVQJEvN5joBi?=
 =?us-ascii?Q?d4Ol8Iax0dO+2LKp5s4U8ZPJ+u4GGdTUsLYa/Nxd8a6GJNrdjFUkUA+7mVEZ?=
 =?us-ascii?Q?2okE+mvWT6Ooedomtooj/jbKlOMlhf4mpUzMwJM7hIywAEv9K9g7eDIuiMun?=
 =?us-ascii?Q?tArB9WBDinysjzw0FPMdSJRwbw87wfXuRJs8wi0jwtIsToJOsveekDjv+d0J?=
 =?us-ascii?Q?ZCzxHUBq1sfYCGvwmDKUKj3DkK9WsL/zXHfxebGir8j2kJKnJlCqgk0Bk/SK?=
 =?us-ascii?Q?n23s+kCOLBb2XbJ2ieAk5sC4nUFS26jmWkvZoVPNNBYYKIZBXGjBgL6TW2At?=
 =?us-ascii?Q?L669IHHIsGcrD3D+9xxvTLO8blWB3AOcH6o4K2yFrod4my4DEJYLjXi/S0BK?=
 =?us-ascii?Q?OsSXrEbJKY6NvUUrwsN9GNo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bcbbd3f-87b0-44ed-1b6f-08d9ac62e83d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2021 20:18:25.4196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Tahs09YEkx7qXG7Mbmyn3Bxvxm+Xw4FJRE1IBxdfqwD7VEnr7RF5UQFTfhLSA/l+NactkWzMHooIMdpejb+Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4685
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-10-22 21:15:13, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The clock driver is registered as platform devices and
> it is possible to reloading the driver at runtime.
> 
> But actually the clocks should never be removed to make system work,
> attempting to bind again would result in a crash, because almost all
> devices depends on clock to function well.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

I'll apply it to clk/imx on Monday.

> ---
> 
> V2:
>  Update commit log to explain more
> 
>  drivers/clk/imx/clk-imx8ulp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/imx/clk-imx8ulp.c b/drivers/clk/imx/clk-imx8ulp.c
> index 6699437e17b8..8eb1af2d6429 100644
> --- a/drivers/clk/imx/clk-imx8ulp.c
> +++ b/drivers/clk/imx/clk-imx8ulp.c
> @@ -559,6 +559,7 @@ static struct platform_driver imx8ulp_clk_driver = {
>  	.probe	= imx8ulp_clk_probe,
>  	.driver = {
>  		.name		= KBUILD_MODNAME,
> +		.suppress_bind_attrs = true,
>  		.of_match_table	= imx8ulp_clk_dt_ids,
>  	},
>  };
> -- 
> 2.30.0
>
