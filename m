Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07B035C264
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244066AbhDLJng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:43:36 -0400
Received: from mail-eopbgr30044.outbound.protection.outlook.com ([40.107.3.44]:3115
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239682AbhDLJNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:13:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ii95J+SCl72zDkLDZeUDxw+A7yzTyXMxD5CpOojLPLyvCcwAueUebSBETKZ7BptWsYaCf8JDw513wLhYDMywalMPdnYCGLbZSj8xpMUnlbJinO2tbrjVcDFSxvDvwci0wNRr7E1GW61+h3e33znRlcj3wsLPeCe/WHNhBA8Lxm6Xq3DKI3n5yHD2KWyrHQaSf3Rh8sHG/isv6Kqb3hec0YCrWW4zD4ATBc5l5YGflSJfgu480llExBScJwbp0po/xKZ3eOTrJg6p4FcdUkiy3kGF9CyqNQL+SzjH+VlqARzcp8lIMTztnsLX7/ihFtx2KDdsUelBxwoHkuPsXbFSLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bixnm5g6Mey+EjEXxAO25Zx91UiXpSQM//U8zqB1Fes=;
 b=FlW7qoCkjy0jFpQ+WY3pR/b6h8v9rSMiqPbuQPVNRpZ2MAJOmHlJXRyBL9a65Eyo+s8sH7fiPY5Fe9w4lZBb3DcmFcK6kFlgK16UcIgzrYGlCPa2lJ1ANOMrMJgDtRn3mtfPem+GIbYmDnGjwqRNRxRwpvIXMpakXt1DRWL3xdSbUjVgGqfX41aVp5Q7N7asITth6NTM3wG2RXId4/XAvVDthm4QHe9a1yK129YmqeaKwQ8U5CpVEUzIAbH/uV3hVAthCWjGewnp4xLNqGHba7yQx2JJ5yuMyf03pExJcipYsuAx9RVFPp/PVdi8t1jTnrmZ7rMMHYnSKspMaNpjwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bixnm5g6Mey+EjEXxAO25Zx91UiXpSQM//U8zqB1Fes=;
 b=MU4on5Dj1TszdTtr4NTznr8seBjv9C+I3xeWOq5pZHUOWfu1V7NUFcjZWCkbrIFj8WkkteyzXb2YpsmphjPgzspBO+9gOgkIWkFCSRIPl8NPkNXYYaPaGtOBxGPoEJYb07biykMLKM/rK2UWKrpj11gkFJBtT+LCUlIXWIOrwP8=
Authentication-Results: sigxcpu.org; dkim=none (message not signed)
 header.d=none;sigxcpu.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com (2603:10a6:803:4c::16)
 by VI1PR04MB6814.eurprd04.prod.outlook.com (2603:10a6:803:138::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Mon, 12 Apr
 2021 09:12:56 +0000
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::a5f3:fde9:1d85:5f28]) by VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::a5f3:fde9:1d85:5f28%7]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 09:12:55 +0000
Message-ID: <d44e5261e8a09d4a221e9c04dd6fc831dfa3fe13.camel@nxp.com>
Subject: Re: [PATCH v5 2/2] phy: fsl-imx8-mipi-dphy: Hook into runtime pm
From:   Liu Ying <victor.liu@nxp.com>
To:     Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Mon, 12 Apr 2021 17:11:28 +0800
In-Reply-To: <c68efbfc19de3bf1a6586edc71a9b9bdd05c84eb.1617968250.git.agx@sigxcpu.org>
References: <cover.1617968250.git.agx@sigxcpu.org>
         <c68efbfc19de3bf1a6586edc71a9b9bdd05c84eb.1617968250.git.agx@sigxcpu.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
Content-Transfer-Encoding: 8bit
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR02CA0151.apcprd02.prod.outlook.com
 (2603:1096:201:1f::11) To VI1PR04MB3983.eurprd04.prod.outlook.com
 (2603:10a6:803:4c::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from blueberry (119.31.174.66) by HK2PR02CA0151.apcprd02.prod.outlook.com (2603:1096:201:1f::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Mon, 12 Apr 2021 09:12:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46261768-1322-43ce-715e-08d8fd9328a1
X-MS-TrafficTypeDiagnostic: VI1PR04MB6814:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB68144DC6491CA35287D6EB6A98709@VI1PR04MB6814.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: alCKShtNmiGOohFv3ZmNfRIR5pJzrXFrJwC0Y4Oqdv8Q8fA9AUdlzRAazTPxUWt8ZZGUc5QXxvdcjwCWP/byfxONkB+0MDwio12RD82DBab2HkcifVfbd3a0BqkTsmCeqz3Zpwqr/dBic7vL94w+kyn+s86EkZBKdiEWeo+9sauhn9k2pCt5VCOjKx/CSiE6YUvSwjCVv1LDmEHu4FtyB0OzZtPhjfWxgC7U7L0ut7QpsHDfvoAX6HES9tJBgs6p0YaFt2+3m04xpMODTU9v4LkKElgnH6kjqmlk7/JAcP2YBNiam9/7ZjzXjtB60+tRGrzJK3ltQLRmCgOhol/IpgK3bszVdjdVExx2KXZ4Tv4hUVH6kDfYINMwEhwbTfaqeGo+Y5AyUDLr/0JGft+PewgcEeIdx0dajF2Ob0QoO1VVq5c5flBiRilwBlHiBWMufkI+DHcGq5hLJ6f3qE3+yS0FlImtKECo7rUQjFJpSaAtF2wzHuOCvrHCjnr2QOher34xRNoCVXnU+b8YyEc38nSMUDl5vMdBHoMRd9lzw9mUmgY0k0q0NfkzAjLNPry00BAThxyiF98jEsMQUFxdLPed0SN84XT568q85HmatZLZxfxuF4EPu2Fumf4T62b0Va4g/OdbtllI6oTDloeLaO0izg+ZYQd4Pc2hZg+lZGHBB/QgI4DMGVhRgW2ExWxj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB3983.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(956004)(38350700002)(2616005)(38100700002)(66556008)(8936002)(6496006)(5660300002)(8676002)(66946007)(478600001)(52116002)(66476007)(921005)(110136005)(316002)(6666004)(16526019)(186003)(26005)(2906002)(66574015)(83380400001)(6486002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WmNkSW55OTM0VGJjeGNCcFBaYmZ3Ry93WEdHZk1MOGgyMitmdmZIaXdZRXEy?=
 =?utf-8?B?ZVdzRlhiSWx5cC8wVVZuMDF3S3BoMEJlQ0tJOE1SdnFjNlI0clk4OWUwSmpL?=
 =?utf-8?B?bFdEQlBMNGZjUDkrZkdyTjVsMVVKSjNrbGh6bjUzcWNCNHZ1NXFHTklNYnFX?=
 =?utf-8?B?WW1XZ2t4aE42S3EyeE4yTVlwbzQwU2d5bUZIZlJweEZIdzJ4YXdsWFpQQ0ht?=
 =?utf-8?B?UlRDS2EzVjQzZXhXUnBJVTNodXBQZkxLaml0Q093UDQrL3R1ZHM0UE43cWE0?=
 =?utf-8?B?bkczMHBrbGhKMmYzNW1MQU9Bc2J6aDVHM2g0MCthbjJXWW5XRjBnbkxvZjNL?=
 =?utf-8?B?eU9MMHgxbzl1ZVovd04vRGVuVytzek9LdDMxZXV0YVlwOVJabmgxaHM3YzVX?=
 =?utf-8?B?UzZOTFhkTHY1UVk0dEdWZUNCc2l0VFJla1ZyYkM3VDdZaXg4RitOOGo1Yisx?=
 =?utf-8?B?aXJaYmhWVW1HMnozU3NKMHdvTDhVRXFyazh0b3J3QldRSDdjR2JQcW41Q2JX?=
 =?utf-8?B?M0ZQVHBpL3k1NS9CeGdPMGhKOTE1SGZlU0l6SzF3bFc4R0l3NDhIcXZqVWtU?=
 =?utf-8?B?RXNmUlhMMXhQMEdKYUNFelA0alAwUHdTQ1E2OTRKUk4zVXQ5dUs0ZHIwdlJM?=
 =?utf-8?B?Tk13dldhaitoUmxOT3dUWkFoc1dyZUhYZll1bzM1eHBqSDdFdC82S1JoZWp1?=
 =?utf-8?B?Tmg5VFFrWHdSbkFaYkJPZXFwdEczd3VtdWtyTzlPWXhRVEYyV0JlYVdlYWRo?=
 =?utf-8?B?a3VaY2JaSUtiRGRlS0hwMzNnZEhlQnpNTXRsMngrN2FSR1pGUm40REErREdK?=
 =?utf-8?B?RWxEOTlYTGpTMXpNTzEybDZMd0dNTkE4WEJiMVpiSjd0S1l6MFpPWDJicUNh?=
 =?utf-8?B?enZvZk1kUDFhc05IZDlXZTE0MFBhcXJuSDY5V0JFYW9jSnNzdzRab21EcDdW?=
 =?utf-8?B?VkFGaFQ2NnE0Z2dKWXg2ckl0b3krVDh6Zzlsd2FLZFZsQnpVVkN2VUIzdUtt?=
 =?utf-8?B?ZmJIaFJmcGtqaU1hdk00Zld1Q3Nnb2g1aHRsYzNMSEhlVk85RVl4VkJ3MzBm?=
 =?utf-8?B?SGJqcFdYTE1QZnlMVThnQU9ORm5hSXpEeVlHOWRZK040dXN0OUMxeHJYUzFT?=
 =?utf-8?B?MzZOdXd5Rk1kcTNmeW9CK0t0RFVLcjl2VEdOVThCRU9uZ3psWlVSMDU0ZGtK?=
 =?utf-8?B?dDZ4QWxWcXNSeHlxc05CTWJGTFBKQUVnT2VSMVZvbmw1eXBVWklqZkYwcndu?=
 =?utf-8?B?L2t0QnZ6ZXZaRHNHQjlZVnNOTmJ3Y0xzR0wvK2J1Mm1oWGhoY0pTcUI3VGtu?=
 =?utf-8?B?ZkpQNG84cW4ybm9ETEs4bWczRjk0TVRYbi9MUHBCanV3VjczUHVubEhXQUph?=
 =?utf-8?B?VWtqTk1LeXdqci9hU2lmTHA4Z0wrWGtmVWhWc0MxMit0N1Y3TkFLcmwrTGsy?=
 =?utf-8?B?dENSS0VuOFhWRG9mKzFNeHR1QmZGb1IwWmxMNlNLU201eTdHVlZPSElKdU9n?=
 =?utf-8?B?WGN4VWk5YzBURlVSS1VvZGNQZHJud2k0MWhHZmQ3NDZhYTB6MGd1SnFmdm9C?=
 =?utf-8?B?Ny9JYUFabGlaMnpPbEd2Y2pDWlpXT3cyOGpJd0lzVkNtQ3JSSGh5RURZeFZV?=
 =?utf-8?B?Y0NETGV4SXR2NlJxVEdIZHlnL0VMaHllVTJrZWlXblkwVWZjcjhiMjlwdmVk?=
 =?utf-8?B?TUFqQkdwb29zNjl4c0RPZzBoOVdoSFRUR2N5TmtWNUFQVnNUcU9MSXNwWlVC?=
 =?utf-8?Q?C5AVplQNwTSq4aAlnYUdsLh5gUMV2P4Lw5Wyq7r?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46261768-1322-43ce-715e-08d8fd9328a1
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB3983.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 09:12:55.8032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eRHb73V0/kaHFwSmjmYG9R2fVD/X4Cx3xUGizN3lxtDyZpWXwKewqWi5fv648mcCLglsTFDBWBUrabiyluhNLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6814
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guido,

On Fri, 2021-04-09 at 13:40 +0200, Guido Günther wrote:
> This allows us to shut down the mipi power domain on the imx8. The
> alternative would be to drop the dphy from the mipi power domain in the
> SOCs device tree and only have the DSI host controller visible there but
> since the PD is mostly about the PHY that would defeat it's purpose.
> 
> This allows to shut off the power domain when blanking the LCD panel:
> 
> pm_genpd_summary before:
> 
> domain                          status          slaves
>     /device                                             runtime status
> ----------------------------------------------------------------------
> mipi                            on
>     /devices/platform/soc@0/soc@0:bus@30800000/30a00300.dphy  unsupported
>     /devices/platform/soc@0/soc@0:bus@30800000/30a00000.mipi_dsi  suspended
> 
> after:
> 
> mipi                            off-0
>     /devices/platform/soc@0/soc@0:bus@30800000/30a00300.dphy  suspended
>     /devices/platform/soc@0/soc@0:bus@30800000/30a00000.mipi_dsi  suspended
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>  drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c b/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
> index a95572b397ca..f89a0c458499 100644
> --- a/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
> +++ b/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
> @@ -14,6 +14,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  
>  /* DPHY registers */
> @@ -469,20 +470,32 @@ static int mixel_dphy_probe(struct platform_device *pdev)
>  
>  	dev_set_drvdata(dev, priv);
>  
> +	pm_runtime_enable(dev);
> +
>  	phy = devm_phy_create(dev, np, &mixel_dphy_phy_ops);
>  	if (IS_ERR(phy)) {
> +		pm_runtime_disable(&pdev->dev);

It's fine to just use 'dev'.

>  		dev_err(dev, "Failed to create phy %ld\n", PTR_ERR(phy));
>  		return PTR_ERR(phy);
>  	}
>  	phy_set_drvdata(phy, priv);
>  
>  	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +	if (IS_ERR(phy_provider))
> +		pm_runtime_disable(&pdev->dev);

Ditto.

With the above two addressed:

Reviewed-by: Liu Ying <victor.liu@nxp.com>

>  
>  	return PTR_ERR_OR_ZERO(phy_provider);
>  }
>  
> +static int mixel_dphy_remove(struct platform_device *pdev)
> +{
> +	pm_runtime_disable(&pdev->dev);
> +	return 0;
> +}
> +
>  static struct platform_driver mixel_dphy_driver = {
>  	.probe	= mixel_dphy_probe,
> +	.remove = mixel_dphy_remove,
>  	.driver = {
>  		.name = "mixel-mipi-dphy",
>  		.of_match_table	= mixel_dphy_of_match,

