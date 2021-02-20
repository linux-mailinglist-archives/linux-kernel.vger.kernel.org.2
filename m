Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1669832040C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 06:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhBTFj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 00:39:56 -0500
Received: from mail-eopbgr60077.outbound.protection.outlook.com ([40.107.6.77]:7745
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229462AbhBTFjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 00:39:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6FdEIIp2gnnNpakcewH6Z/bShm6zyBOpDQVPId30RU4V2Yj1c8UBJK1RIEL5h3NHE6FZ5LEOzZdXy9KuSaSLaima4c5cnaVFiDuLISrQ9n9x3Fzq3USlXP8q6snBpj2ms6IBRbytaUeCChuu25hhc0X6wlCjwWKLTilIcz+dW/U0B76GlGNYdb5BUbG1kF3rB2h3flWcuf4gCFFSOP7C+j1eZp6M0+DCP9WAl5WeWrSPNDIKV2+zeW4NqMVizmaXeLuCKU15Day6rzFD2YDUGs5HoR6RbePZ7j2f8olBmOxj+/UcQjbsbMfgpetrEg1W80V1j6R073SqwTTTKi1KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VesTOvsfOJf0tpAhGDUI7W81GxarpG/xdJs3s1mDPZQ=;
 b=m0StgIqA39CApwg1vZQby72jRLByw4BK2Q0O7iGRvyhAYXv5YpSfi17vGxLzT601rmEurll6mp23Nm7XhKG74emSKQDJsqGJ76nPXpcY2qAER+9mgAZVQONNdPeYWplI8LB/0z96oINABfSEgIqAEVQmfToKGD4wCJQgdcX0VYhdy7hS9PET6eGjDAItm9DjwIYaGhRq7HK1HNI8z0lKQpKA2trrHw6nUiOlwyNlDVScdkUIHTifnjF3HD8DhYSGnbh/2BZ/RwwQ5nprx0ckfX3u92WVd/wGg/5GSEWYPVhcMMRm7FTn20ZkonasT+aHtYFm/lhmQnfW+F5CL+y3Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VesTOvsfOJf0tpAhGDUI7W81GxarpG/xdJs3s1mDPZQ=;
 b=Eh8GjJA/zN9o3xfuRlQ+GZOUFp0RJPHslPDq/3JYEJ0SvzLLWen41IWL1+rLYoxyBfsdBiswbAjHEveNQ4VTwZoHJCVzo+Gs5cLqM+Yk3NkWpUd5QXaB355xQsAkyR6uNkAoLVao1q+RvNT4FnSl92TWvsEuXjjsXYLBg+fK8z4=
Authentication-Results: sigxcpu.org; dkim=none (message not signed)
 header.d=none;sigxcpu.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com (2603:10a6:803:4c::16)
 by VI1PR04MB3309.eurprd04.prod.outlook.com (2603:10a6:802:3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Sat, 20 Feb
 2021 05:39:03 +0000
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::2564:cacc:2da5:52d0]) by VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::2564:cacc:2da5:52d0%5]) with mapi id 15.20.3868.027; Sat, 20 Feb 2021
 05:39:03 +0000
Message-ID: <424af315b677934fe6a91cee5a0a7aee058245a9.camel@nxp.com>
Subject: Re: [PATCH v2 1/1] phy: fsl-imx8-mipi-dphy: Hook into runtime pm
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
Date:   Sat, 20 Feb 2021 13:37:29 +0800
In-Reply-To: <eae82b09fd5ed39dbcd88cc10ce60338474183aa.1608118008.git.agx@sigxcpu.org>
References: <cover.1608118008.git.agx@sigxcpu.org>
         <eae82b09fd5ed39dbcd88cc10ce60338474183aa.1608118008.git.agx@sigxcpu.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
Content-Transfer-Encoding: 8bit
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR06CA0139.apcprd06.prod.outlook.com
 (2603:1096:1:1f::17) To VI1PR04MB3983.eurprd04.prod.outlook.com
 (2603:10a6:803:4c::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from blueberry.ap.freescale.net (119.31.174.66) by SG2PR06CA0139.apcprd06.prod.outlook.com (2603:1096:1:1f::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Sat, 20 Feb 2021 05:39:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0deff3e1-fb7f-4a2d-e99a-08d8d561d4ba
X-MS-TrafficTypeDiagnostic: VI1PR04MB3309:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB33095AF17D081307396F83A498839@VI1PR04MB3309.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mBy2UwPW7ZxvfJES/Mk7ZK0lZkdISfwDnj1V2jHu9cOEX00UBjRe0KYv8ccF1liHl54nc1WksoIwgE0FsACvqMIYUe/uA8lyC7SujwqE/BfByXlSFyFqdrj0LzmXOJJn+ssYmrhIkrYk9xRWmQ2IdJ5iNlFmOtZHmiQGWOjLqlI97x3OJOtARFTbQWZAVfs2rFQOSNmhkJ602KNSLoKwkiJePxYuPLV72JnCPJEjPJ6If6z18gUNfk/mxO8t99QMKl80Z/B7dh+wzRqM239l/I2hSP8/4CaA4b4KjysJPsayFbjpefukFWscCnTj1XtmFZ/bOWl8kRnQYUwOZXAcnprrwB4+neIUYlLwR41HKhSnBDC9DtuezN4CBdtOYQZWDoJ2Yk5wNgIo8PGx77yu+ZWHAA2xQ0bM2R2y8dF7k8Gtatgdr5SUWzaiseVE0QchUe0NO3YXMuuJW1kvEuLHYlusX1vIB+h4zkQkk644oGg6IUKr4JPDTZUYB8/LV0BDB+p0M0zp7+F2JBxmnB/9s4Rc/HAUATqH8zKct833kZ7+5ru3AcStbK6tHvxcl2HF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB3983.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(66556008)(2906002)(36756003)(478600001)(921005)(86362001)(8676002)(52116002)(83380400001)(6506007)(66946007)(66476007)(8936002)(4001150100001)(5660300002)(2616005)(110136005)(26005)(956004)(186003)(16526019)(66574015)(6486002)(6666004)(316002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Q25zUXNNOW5UeGtWeXRYcFV1N2dBWFpHM3hNQXQrVy9FQU0ya1FOSDFDRDA1?=
 =?utf-8?B?bjRzN2JKT1M1ajRsYWluT0VpZUdDRTQxSThIWEIvbFBRd0htc00xL2pDRDRF?=
 =?utf-8?B?YmVLbDZPSlhaRGtPRVFWL2diQVpkeGVOaTlxNk1keFJ1d3ZnSFRsVWZnNFF5?=
 =?utf-8?B?cVBYVzNjbWNtSXdYM2VUdGZnbnFYZGs3Y0VJUUJrdnNzMnJORGFqR2x3YStJ?=
 =?utf-8?B?K09aV2pOVFdNZndXanJ4NFp0U1JWSjRVcXB3cnFONXl2Zi84VXIvb1R5NUdY?=
 =?utf-8?B?WlJpVEFLcDMxMzJtblUyQkNFQU1ETko3VFVXdmRLUlFNV1JqNmhra1hxMlBv?=
 =?utf-8?B?YmtzeGdPandvenZFYjlrMWtneFZ1SThJRnJwUFR2OEUrc3l4SlFQQ0dBYXNC?=
 =?utf-8?B?cXhHcjBWYURkMStrcEZDV1k5cFNqS1d2bk5zV1UwNkVwTXl6bkNGR3ZnM0VO?=
 =?utf-8?B?TjkwYXJHVEtnanRubW8xWS9oSFJlQkIzTTlNOU1kbXRBVGxJRUxTSUVMTFEv?=
 =?utf-8?B?cTBmWFh2MWxvQTE2RHFoQ2k2dHlRN0p2TC94NEUwbTh4Q3ExL2lOZWgxRlIr?=
 =?utf-8?B?OUhXZzF1NnlheVE2VC9iUkgyOWwxZUVrNlp6V2VBUTZJZDVEazh0ZXFEOGY3?=
 =?utf-8?B?RkQ1NlpBVEFvV0w2ZGdCS01TSlJVRFFJT0RHN0hyODN1TTJhV0hxWnVJdUh5?=
 =?utf-8?B?ZkJub1JvOXRJU3I0Y080a015R1FLTDhlNDlyUDdpMDQ4WmhSZVcrak1KKzI1?=
 =?utf-8?B?V2J4blJHUlk0THVhRlVRN3MzcGJ1TTRuaG9RdHRsRENoQmpPaDdXdDkxU0wr?=
 =?utf-8?B?MEE5QkxmNXdpMU4yM0c2U1JCV2hUckNMNFhiTUZoTlZqamJFaFNyeUJyenlI?=
 =?utf-8?B?S2Z3YWRvdGp3WFFPVC83V01rQys0U3ZhOWdYL0ttaWN6UlgvVHhlZmxDWll0?=
 =?utf-8?B?WTQwcUpPK1hsdkZXRDBFYU1XMUtqSjRiTzNKWHhvbXhtdDNNQTgwbUJiUm9B?=
 =?utf-8?B?blNOS0UreDBRejREc29ZQ2lQdkVaeS9nUk81VVFpR3V4cU1qdzRWQStLYy9C?=
 =?utf-8?B?M0Zhc3ZkOHR5YjF2bkYySHFhbXd1Sm5NSzF5SUtYQXMwYUF2a0oxQ2hDQ1hs?=
 =?utf-8?B?ZFdRY0ZNSjNKZmFoM05GRFRZUUZQN0x2d3hjL0huYnVOK28xT3ByRDB1MUZt?=
 =?utf-8?B?MHlaVlRLeUI1SFA2ZHBhbUNvNmJQK3l0NUh1NVUvWnM0Nlp3NnhLNndKZitQ?=
 =?utf-8?B?Qk1XL1B6WHJmdStKSFB2Y2xqUGozTTlIdy9rbVRzRHhZUnRkU1ZlMGpyaFdw?=
 =?utf-8?B?NTc4TGdPWGpyYVZ1aXR1eXVxUXJoTUYvWTl2SEVIcHpRLzJXMHR0KytEbUJQ?=
 =?utf-8?B?R3BjcSs5L0c5bTRlRk1uYTRURldjSVlCVmNDUzNZcWRuRXZnZ3R0cTJOOVY2?=
 =?utf-8?B?Q3JDZGJkL1c0aHhKd2JuMTF4U2hLWDZnaVlDQVd3TnZTcXBtWEhaWVNnYXNV?=
 =?utf-8?B?bURjQWhUbGZETURpaHpSdHlkc2lHWllpeXRCclRVWTh0TkxqczhDNnBodUFz?=
 =?utf-8?B?U2xpTmJXVnRUMlFXMTE0NTJjM2YydFVuTjQxQlRZblBJenZ6RUhpWE1SaCtq?=
 =?utf-8?B?K3N4UlRvWGRFUnh1TDNpRzRzSHRydEtXT0t5YitNYkpXajhPbEdOMGNxb3Aw?=
 =?utf-8?B?aXB5L1B1ajN4aWVHQ2d1YXpLTXMxV0JSZDRYYzQxamVxazFwaGozTEJyUllz?=
 =?utf-8?Q?GlRdXxzl3rzFblpZrEcnkpqcRVP4mHa9T894Sn+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0deff3e1-fb7f-4a2d-e99a-08d8d561d4ba
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB3983.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2021 05:39:03.2057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RoZspWxfsjl6uLZzKUlpUXObwcRlfPhzjgZTU0Aovmke0DHbmOmMojbm8UIOK8oskd+e0KZL/925Vhu4/AkGUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3309
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guido,

On Wed, 2020-12-16 at 12:27 +0100, Guido Günther wrote:
> This allows us to shut down the mipi power domain on the imx8. The
> alternative would be to drop the dphy from the mipi power domain in the
> SOCs device tree and only have the DSI host controller visible there but
> since the PD is mostly about the PHY that would defeat it's purpose.
> 
> This allows to shut off the power domain hen blanking the LCD panel:
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
>  .../phy/freescale/phy-fsl-imx8-mipi-dphy.c    | 22 ++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c b/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
> index a95572b397ca..34e2d801e520 100644
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
> @@ -93,6 +94,7 @@ struct mixel_dphy_cfg {
>  };
>  
>  struct mixel_dphy_priv {
> +	struct device *dev;
>  	struct mixel_dphy_cfg cfg;
>  	struct regmap *regmap;
>  	struct clk *phy_ref_clk;
> @@ -382,6 +384,7 @@ static int mixel_dphy_power_on(struct phy *phy)
>  	ret = clk_prepare_enable(priv->phy_ref_clk);
>  	if (ret < 0)
>  		return ret;
> +	pm_runtime_get_sync(priv->dev);
>  
>  	phy_write(phy, PWR_ON, DPHY_PD_PLL);
>  	ret = regmap_read_poll_timeout(priv->regmap, DPHY_LOCK, locked,
> @@ -395,6 +398,7 @@ static int mixel_dphy_power_on(struct phy *phy)
>  
>  	return 0;
>  clock_disable:
> +	pm_runtime_put(priv->dev);
>  	clk_disable_unprepare(priv->phy_ref_clk);
>  	return ret;
>  }
> @@ -406,6 +410,7 @@ static int mixel_dphy_power_off(struct phy *phy)
>  	phy_write(phy, PWR_OFF, DPHY_PD_PLL);
>  	phy_write(phy, PWR_OFF, DPHY_PD_DPHY);
>  
> +	pm_runtime_put(priv->dev);
>  	clk_disable_unprepare(priv->phy_ref_clk);
>  
>  	return 0;
> @@ -467,6 +472,7 @@ static int mixel_dphy_probe(struct platform_device *pdev)
>  	dev_dbg(dev, "phy_ref clock rate: %lu\n",
>  		clk_get_rate(priv->phy_ref_clk));
>  
> +	priv->dev = dev;
>  	dev_set_drvdata(dev, priv);
>  
>  	phy = devm_phy_create(dev, np, &mixel_dphy_phy_ops);
> @@ -477,12 +483,26 @@ static int mixel_dphy_probe(struct platform_device *pdev)
>  	phy_set_drvdata(phy, priv);
>  
>  	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +	if (IS_ERR(phy_provider))
> +		return PTR_ERR(phy_provider);
>  
> -	return PTR_ERR_OR_ZERO(phy_provider);
> +	pm_runtime_enable(dev);

If this enablement is done prior to devm_phy_create(), then the
phy-core will manage runtime PM for this device.  This way, this driver
doesn't have to manage it by itself.

Regards,
Liu Ying

> +
> +	return 0;
> +}
> +
> +static int mixel_dphy_remove(struct platform_device *pdev)
> +{
> +	struct mixel_dphy_priv *priv = platform_get_drvdata(pdev);
> +
> +	pm_runtime_disable(priv->dev);
> +
> +	return 0;
>  }
>  
>  static struct platform_driver mixel_dphy_driver = {
>  	.probe	= mixel_dphy_probe,
> +	.remove = mixel_dphy_remove,
>  	.driver = {
>  		.name = "mixel-mipi-dphy",
>  		.of_match_table	= mixel_dphy_of_match,

