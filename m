Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEF83CF5EE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 10:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbhGTHgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 03:36:50 -0400
Received: from mail-db8eur05on2059.outbound.protection.outlook.com ([40.107.20.59]:27233
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233450AbhGTHfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 03:35:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UmFbCd7p9WGWfJDpXNv1iB3mRuGt/KzHJSxvvqztCxj/JMLjansebIpkKacOXEKADexeFKmTbFDvEQqky0Ojgi/kI92ZPN/5l3xD1/Uz4+ZGfbhhmPNzaFZwj7E1KP1pueDLjHjp9UrYJ0HR5iFjz6iizsHp+nm8tSDIj5qffKFPNmOP1uzD6yyDT1493uyoQfCIQfvc/RlSo3JJlSrkdBJfwJr4R0+2q/zUP3ZqJ2kUBOAvpKEPcSSv/9RxUFy6NZgdRKJbIcMxsT9TYbJDVel3yteVVfljN5YajcExgd7p7IV01Yn0v73utiokP2htKnsUWl5DCyyNKhoYsjWI/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqEs3XX8y44blTai5ApBPUg/lNc0WdOSjAf9ZyjCkiE=;
 b=fDgTa1NDbdWbt1WD3vZ3XjNLHq/PmgmtodJvT0wSq/9Pf1EgDqL+jQYgXIC8Q4trS4uQHise/J0Hm9t7/NdAeQFGOt+A8zRkFkJf/J1ZPgKHGD7z56mEcHw0qxxfVjDA9UheXLeFhzx+wQwjxgv3EO+WeM9KM8cnjhPd2po4GMIUXHLMn4gbpnwvwcEF6nQAFvL3l08xdX+hkUq8wdCBq5JtdAbND4aef8Ue7J4eLen69xlmaK0888i71A4kSTkwXCz06eqIbZzvjBn3LJwkwVcyM6fLJDCmhOhtguQRMXC6YzyTbej/yebuJQdhuBc7izRmUxzkM5oAv7cVHpqzxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqEs3XX8y44blTai5ApBPUg/lNc0WdOSjAf9ZyjCkiE=;
 b=F6zZ8l6NNQsFepev4SeG7j8enXRN290NOQ+un1ML4tzIbFE9Hu4ruTlzZIBRunfL1NjNjc8bx784dVAc3HtNEs0XjQhFAUbJY1ErC3fOWOQ5URqQ1OFiBW5NDR7tFcjkCtXK3Op36922h/ek80Bim0tm2TLdanWRZRkzxPHUn/w=
Authentication-Results: 163.com; dkim=none (message not signed)
 header.d=none;163.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0401MB2559.eurprd04.prod.outlook.com (2603:10a6:800:57::8)
 by VE1PR04MB7293.eurprd04.prod.outlook.com (2603:10a6:800:1a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 20 Jul
 2021 08:15:41 +0000
Received: from VI1PR0401MB2559.eurprd04.prod.outlook.com
 ([fe80::1dc0:b737:bf34:46b]) by VI1PR0401MB2559.eurprd04.prod.outlook.com
 ([fe80::1dc0:b737:bf34:46b%3]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 08:15:40 +0000
Date:   Tue, 20 Jul 2021 11:15:38 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rudy Lo <luhuadong@163.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: imx8: Unified initcall function
Message-ID: <YPaGKokUH9nqQ6to@ryzen>
References: <20210708081543.186820-1-luhuadong@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708081543.186820-1-luhuadong@163.com>
X-ClientProxiedBy: VI1P195CA0007.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:d0::17) To VI1PR0401MB2559.eurprd04.prod.outlook.com
 (2603:10a6:800:57::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ryzen (188.26.184.129) by VI1P195CA0007.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:d0::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 08:15:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0f6fbb6-3176-44dd-c0c7-08d94b56900e
X-MS-TrafficTypeDiagnostic: VE1PR04MB7293:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB7293236256237672571D24F0F6E29@VE1PR04MB7293.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i70ex784nQtPn5YK/59PLlNSdbL5yjRwjC7MimyoIWXhjq7kiFU6Yud0djQ2peyLgoqvlbuHxaF28EM0XmSoKgWWwIzATeFUHjWRgbV0IdRGeJs1TYIEJRkbODEdOMgkyJMHs4LlrkaiSyV+662FQgnmAJ5mECpj/OXqVuqjbZBjdjn38j614jpX6oQIbQSx21MGHMRegK984q7gwhR84a1Sul56AnTv1VYkFqWs7alEVNrneWcb72mVCU+B+B7RTyLsbrhCajBBhFXxVY9dQ/YI7mcdMrgjMc8SlF2DHH0qRYBiaQGJpCFg5aIRFrO6cSTj+LiOyXjUyuBa1YTzqCQ+j6f2gv5WL2WR4LXwWe030jh72bHCcN109pxeGZWNgA8qvD9zGzehpvto6xPzWhUbvy5ghRfsr7w3kkMx9oxol0m0Atx23dDkF4n2y2lZXKVD4ha51ncUXdDTX44y53ERNekrZfafyxDVUyaiDX1UjtOC7vxD0p4hDm1WqB48g/3ZDJqdtsWQz8VSfk7eRxLGqbDagevL+NzTTzeGJJ1jn0l8DN/m0EtG9jEPbUk/78jeGZjOJ0+n6Qjd0e6Sw0YCoaXToVI9Hl8BXjBnpma2H3m+rsrY8uqlRRKG9LCvJbnaYGyzpJwzXiyXefBgOyAf0WpOLtqbnXPMyCUCGOvTrQGvfYnhP35ePk1GMbLAn33meW9S1wEilT6JRtQsPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2559.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(6916009)(54906003)(6496006)(26005)(53546011)(186003)(5660300002)(44832011)(956004)(33716001)(38100700002)(8676002)(7416002)(8936002)(66476007)(86362001)(4326008)(52116002)(2906002)(66946007)(66556008)(38350700002)(478600001)(9576002)(83380400001)(55016002)(9686003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+QQY/Ir8FznvEd1WKhF3GN/3N7Sx0qAxJROqfgRkyYPKuzHblzg4W4mFmW/P?=
 =?us-ascii?Q?SBOg36dFtTB9qJct5y1o7n2XjW41qsjZpv3LW0FQcjoGuDniAMIdfxK/56Kt?=
 =?us-ascii?Q?zgw2UOH4YRT3k4v48IxTajJLAsmxH+mXklH+UbwscaSrAQm6S0CBt+P/oUmD?=
 =?us-ascii?Q?TVrysYcvgKTm2r4SEchoJ1NZI74fgzcxQkyh3Tl8AJ0SsG6DO3YhsGAhFYCa?=
 =?us-ascii?Q?dM6AlcTfmz0ehBPhrZ9Ia6IQvD0fep9dfvWpgiSpKzgl+vw5uXlixC4mrwNo?=
 =?us-ascii?Q?NZ7ygFlYiyJ7g01/2Mf6cUNWRfD0AfM//GnsJ5OWwHvRyt5ks/n35jneSOxq?=
 =?us-ascii?Q?BS5aglEawBoEsR7WSkwvsLKWefxoVkuhvhUY5lJD445d6VtNgmZaehUDcezF?=
 =?us-ascii?Q?SjpwnUkHxkNpiEitmTWU8o7Hm6zIUZma732KLacisS/Mc+sNQlenpJ/6+pKl?=
 =?us-ascii?Q?z04aUV00/hZnqHSBlirCRkejthZPlCkCSCN6rNc/P6T5msV9gPoLsZ1zwZ/Y?=
 =?us-ascii?Q?OM4OwL1miYCUji6KISOoN+xyiLi0fvzJrGBMqOeebU2GYkR8WjC88I/C2EZe?=
 =?us-ascii?Q?JE45ferxMv4qfPGtjuaOlPmBeY0vXTSPnQnVb+uw7hd4kUWACicbsjVZTazX?=
 =?us-ascii?Q?oTPVoKTMxUmm9uuh7kglw/AUoslVBag+x2M2yNHBcVqE+htSsbuZBKf9L1nT?=
 =?us-ascii?Q?NG7+E+Mwssoz7XcsFIztmDokS+6e4S3oSAKnKWfoZICmDp85HO2mSGsqx5Zq?=
 =?us-ascii?Q?EkAKwPK4t0rER2uWVg6a5/wneQtpf8yUYOumM77EkKpdIVSUmhX94n/rbRLh?=
 =?us-ascii?Q?yTYxbOU65Yvd+Z9IrztAcWvbCa0fl8H3qlMdnOBd81cbMCAYNO5ukEv5wv4p?=
 =?us-ascii?Q?ghe4IfG3rOL9Sh2mQrw7iJayd3Qp5tQhdmdpdYPsMtrLMU6CGu8kJMELEUTX?=
 =?us-ascii?Q?K5L4xIEOO18EMjHIpI4EAOmAVhyPZbE8pHbwA+iaqNqT2E8kdk3IFKiPjhwr?=
 =?us-ascii?Q?QeJDBZHfagM2o4ou2c/4UKAfzCE++QIm31egkP1nU8i4QtbYivAzU0Nk1O97?=
 =?us-ascii?Q?4f9DZowt/P2BR+uYO4kQU+G8zkZLiUaMpr1VZwRWWIipt1uE4tpl+BXMzpCR?=
 =?us-ascii?Q?GZ8F0M+n5y4ZEKsvEa236eeORWj+XL8pN1J3mbICBctefJLXSeQJBAXAfVMR?=
 =?us-ascii?Q?8PwrJsuhP44aO9xDvmXvzlzmLAqbDF78zMzde09ILzvxRiKgsFzwYO+oig2o?=
 =?us-ascii?Q?S4RWW4EGoA3+D1iI6D4jjaO0gQI7obceH7+01eD76ydjWOJLBk28jW+wi8Jk?=
 =?us-ascii?Q?cx0ajlgTvcqcMATx0VjnjpkC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f6fbb6-3176-44dd-c0c7-08d94b56900e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2559.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 08:15:40.8381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k8XBGXoiJ87icZ6AqmY4Bfl87B1ac/4m3iRtJJXPhRAw46DNyEcz/pqRDow8pwurIw955y8hhXl0zToRvBh11w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7293
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-07-08 16:15:42, Rudy Lo wrote:
> It is better to use builtin_platform_driver initcall for clk driver
> rather then module_platform_driver, refer to clk-imx8qxp.c file.
> 

NAK for now. I think this would break GKI.

> Signed-off-by: Rudy Lo <luhuadong@163.com>
> ---
>  drivers/clk/imx/clk-imx8mm.c | 2 +-
>  drivers/clk/imx/clk-imx8mn.c | 2 +-
>  drivers/clk/imx/clk-imx8mp.c | 2 +-
>  drivers/clk/imx/clk-imx8mq.c | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
> index f1919fafb124..fa20b08e64f1 100644
> --- a/drivers/clk/imx/clk-imx8mm.c
> +++ b/drivers/clk/imx/clk-imx8mm.c
> @@ -654,7 +654,7 @@ static struct platform_driver imx8mm_clk_driver = {
>  		.of_match_table = imx8mm_clk_of_match,
>  	},
>  };
> -module_platform_driver(imx8mm_clk_driver);
> +builtin_platform_driver(imx8mm_clk_driver);
>  
>  MODULE_AUTHOR("Bai Ping <ping.bai@nxp.com>");
>  MODULE_DESCRIPTION("NXP i.MX8MM clock driver");
> diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
> index 88f6630cd472..67b9ded112e4 100644
> --- a/drivers/clk/imx/clk-imx8mn.c
> +++ b/drivers/clk/imx/clk-imx8mn.c
> @@ -605,7 +605,7 @@ static struct platform_driver imx8mn_clk_driver = {
>  		.of_match_table = imx8mn_clk_of_match,
>  	},
>  };
> -module_platform_driver(imx8mn_clk_driver);
> +builtin_platform_driver(imx8mn_clk_driver);
>  
>  MODULE_AUTHOR("Anson Huang <Anson.Huang@nxp.com>");
>  MODULE_DESCRIPTION("NXP i.MX8MN clock driver");
> diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
> index 12837304545d..cdb40e61cef0 100644
> --- a/drivers/clk/imx/clk-imx8mp.c
> +++ b/drivers/clk/imx/clk-imx8mp.c
> @@ -735,7 +735,7 @@ static struct platform_driver imx8mp_clk_driver = {
>  		.of_match_table = imx8mp_clk_of_match,
>  	},
>  };
> -module_platform_driver(imx8mp_clk_driver);
> +builtin_platform_driver(imx8mp_clk_driver);
>  
>  MODULE_AUTHOR("Anson Huang <Anson.Huang@nxp.com>");
>  MODULE_DESCRIPTION("NXP i.MX8MP clock driver");
> diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
> index c491bc9c61ce..54f17de30935 100644
> --- a/drivers/clk/imx/clk-imx8mq.c
> +++ b/drivers/clk/imx/clk-imx8mq.c
> @@ -630,7 +630,7 @@ static struct platform_driver imx8mq_clk_driver = {
>  		.of_match_table = imx8mq_clk_of_match,
>  	},
>  };
> -module_platform_driver(imx8mq_clk_driver);
> +builtin_platform_driver(imx8mq_clk_driver);
>  
>  MODULE_AUTHOR("Abel Vesa <abel.vesa@nxp.com>");
>  MODULE_DESCRIPTION("NXP i.MX8MQ clock driver");
> -- 
> 2.25.1
> 
> 
