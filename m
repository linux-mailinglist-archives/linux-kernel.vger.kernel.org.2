Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B42D320415
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 07:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhBTFxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 00:53:21 -0500
Received: from mail-eopbgr20077.outbound.protection.outlook.com ([40.107.2.77]:49076
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229462AbhBTFxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 00:53:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwFrALwwa7AGLiJ3WzfTtxtDKC5GeQTRv5fPtFoBLyRP5R/qpwDmOkJYdkB2PmtvWmBvzOUpIemwD56PlXFDVI5vDUyKUUMIj7E0jq8XfixjkA7W51ca1y8Yd53WwCptXOGdjL4cigVEgq2GaTsE62rHfhWhKC3+eowvwu/zhaiz+NCHmlAAYmqW0Swwa90f0Oh6rBQ/POZ0z3Lg7t3m3e0SHQAyv6kIMV71UrYCOraT3FyARnu6MUAvsG1T+WHWnri+U18VxDYQJzi0OHyzDXICemRn4iUepdQyOtwWcS8NeVeyJPg8K0JhHI0P+DCVsMOpEn42p20dGggKSAacQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sklt5O+FOd7cXd9j6MhtD/xgTZJbc0qEhWb4p1I3umw=;
 b=Rgfr7Aq2tCoLYFwMs7OAjJxZAMj4A5K72l8PNUvs2bk6zLnt+ffH9fIxjHVS5ZXnzLXXxxTVZ8jOYVLfVqCmwAs7G0IcgKMipVtL1RfOXzKXaeaMzxLy7bix+I9ewqH/9NOtPEPDSwXTwNloOVFztrJyaicg0mcwC+c8kIePag/YEkjt6a5a27k4A9JdLB2mNutn5XznZ4AJjAeX08J+bofNzdWpyx1JAdBup2APC57XgJ47PtYtuuv9cELKYmLuTF5j0/LRKJoeqVXcC5zeWfyR59ePOlB/uIZf5SATiOmOwuGFw+1jbjP0f9+hV56rn235A3pegJT01pPTS1uRhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sklt5O+FOd7cXd9j6MhtD/xgTZJbc0qEhWb4p1I3umw=;
 b=W/k+7kjgciCrLQpbbC1LtD2aN4CaqjtEDp6KV1ZgmeNo07kOUum/K9WkQ+IfCOvuHRwsVdzLVWLz1FaUVNjKqq2qIosLjCBGDxccbCEx8890o+E5DOn4get6VeCwYRrAYwsKeZVe2JnCcCSQbDEpypNICZ+8XkdbavJgmQaV0CM=
Authentication-Results: sigxcpu.org; dkim=none (message not signed)
 header.d=none;sigxcpu.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com (2603:10a6:803:4c::16)
 by VI1PR04MB7118.eurprd04.prod.outlook.com (2603:10a6:800:127::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Sat, 20 Feb
 2021 05:52:26 +0000
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::2564:cacc:2da5:52d0]) by VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::2564:cacc:2da5:52d0%5]) with mapi id 15.20.3868.027; Sat, 20 Feb 2021
 05:52:26 +0000
Message-ID: <a98f7531b9d0293d3c89174446f742d4199cb27c.camel@nxp.com>
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
Date:   Sat, 20 Feb 2021 13:50:51 +0800
In-Reply-To: <424af315b677934fe6a91cee5a0a7aee058245a9.camel@nxp.com>
References: <cover.1608118008.git.agx@sigxcpu.org>
         <eae82b09fd5ed39dbcd88cc10ce60338474183aa.1608118008.git.agx@sigxcpu.org>
         <424af315b677934fe6a91cee5a0a7aee058245a9.camel@nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
Content-Transfer-Encoding: 8bit
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:3:18::19) To VI1PR04MB3983.eurprd04.prod.outlook.com
 (2603:10a6:803:4c::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from blueberry.ap.freescale.net (119.31.174.66) by SG2PR02CA0031.apcprd02.prod.outlook.com (2603:1096:3:18::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Sat, 20 Feb 2021 05:52:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 950c9747-99ea-4d0c-0ab9-08d8d563b379
X-MS-TrafficTypeDiagnostic: VI1PR04MB7118:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB7118DCA10FC6657E7567B39498839@VI1PR04MB7118.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QIMezmklMq5bpZlc6wRaiwMbInI9MW7aGRq15TIO6knA3SSs0ytYJkHusgf97T2/s/umC8zm3iSd5fRvbYG1lJPrQBiPRzhlm74/FkUnvpqjdFtQCSI9++0e7piaWBS/eEfQE7ZtHB8HIEnOZ5q9gx8OcS8Y7Hua19fB+dEGdKXj55kCebdBDFwgXKQwViqqhqcJeDutHmYesW8qyFVarazdbgTWn/ZeCc2HAcwr1N6JRV5CisN8FF1A7GLOuMktXeBh1pwaguCxXaL1x8V7X8ipUIcZ9N3znhbyfM0LRhTb5ksWqlHEL8ZWCF61rrnPlF4Iyx2fzpUQQlRHWeZkw0ZyVKm0CW84LP1Qlrg2y63Hyc2FNUHEvlkJAvKy87C6OsqU6OgbjHKAgE4T+gFKb0lKs3eFtPIf90UPkmcYjC1/1awWgnItEKCqV93ZkCFwR73pC4E4RbzNQmUsg3q5iIE4dwGir07Hf5py5FLNodoqSDAIapZqXioBFZBGoJexI9q8fq7hsnPAo9Xd2GUVfmTpfYcTKF+PxGUgimvU1w1Gid3WAv/M+3zHH4GHk6Zd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB3983.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(86362001)(921005)(110136005)(52116002)(66946007)(66476007)(66556008)(316002)(6666004)(6506007)(5660300002)(2906002)(6486002)(36756003)(26005)(6512007)(186003)(478600001)(8676002)(8936002)(83380400001)(66574015)(4001150100001)(2616005)(956004)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bGEzeDRNU1J4dGM0ZDlSTWhXTlJOSnkvVWRqMnRCZVZOSW9nOGd6VVVHcXF0?=
 =?utf-8?B?bU1ZQzdaMWVLako2WHdaclkwRFlKRWk1cldyZUxRWW5CZE9YOXA4Nm45WEto?=
 =?utf-8?B?TjYzZDhQLytKRGFGMlhUaGZMVnRWRlp5YnMyVUZ1R0hhdFVYK2tIZ2ZrV1Ry?=
 =?utf-8?B?M3BaTE1CN00xSzUzcCtEdmNoYU9qa3lTTDhJMDY5UVlhUmFkVDdzUXN6bXhS?=
 =?utf-8?B?MVlHSk15THpoVXZlL1IvbDdOSE1qQWt4YXV2NlBXOHdubmo4ZyswS1Ruck9N?=
 =?utf-8?B?ajJZZ1hHeG0zeGg4NmVnZDk4OGUrOVJVdUlrNjJKVGs1WXlicnNsTGxOVWg2?=
 =?utf-8?B?Wi9laGE1VDFoL25iaG9MZGVnQXl6cm1DbUwzMXFxRGNFQi82cExDN21UVWtG?=
 =?utf-8?B?dmFNYjhZVUxjL3BuRzJmZ0VCK2s3Y3E4Y1NTaGYxVWhMYU9rcmdmTG52dmFi?=
 =?utf-8?B?NVhFNTFsczRnRTVXKzVnUnY2MUU0UUU3dUFVRjBZL3NQL1ZaWlQ1bEhib0d1?=
 =?utf-8?B?ZEJiaWNPRTlhUWRYdFY2VmFsYVJ0ZXN4emlvcCtLQlE1TzZVRitYVWtsNVBs?=
 =?utf-8?B?Sk43NkJXcXIxOVdlNnB4dS93ZVdwVERZMzVqOTBxc2x3SFFnbDdyYnZoMjlG?=
 =?utf-8?B?cTlDYnlVWlJXMUdmT2hVRTZxbDFGWmlsNnVYc3RZRHdGSGR5b0NueGtXV3Vy?=
 =?utf-8?B?WW9jaC8zb0dXYzRnQzAyOEhSM3YwSnBiR29Xdk81S3lXeWQyRFVKalQwQ0NE?=
 =?utf-8?B?R2RSSjUxZFlzOFJzQXpwa0lDcmFhOGFiMHV4SGdXUUNndkRLeWMwWXRqeW1V?=
 =?utf-8?B?dUt5a2NzbWF3Rlg0TENpSWYxWjlhaDhTQi9INHR1b2JyWUNZcEFjTytPOTU1?=
 =?utf-8?B?elNoOUg3dlZGNGJxd1BnMTJBa0dSaFZqc3hUR2V2UFVESyt5WEZSRW9YVk4z?=
 =?utf-8?B?a0JleU1OWXJ3QWd1aUc0ejRGcEhGRU9GZ1NTSFppTHEyRnBsUUJIOGZkNGF6?=
 =?utf-8?B?aUVJTkQzRUZCa2E3ZGFCOHZWa0FuWG5RUjhLUFduMmhTVTV2TVUvSkV4d0dE?=
 =?utf-8?B?eW5DR0ljZm54TS9OQVNXSlhaaDVBVjVwOWpNZG11UVo2R0d4QTNQN3krTE5G?=
 =?utf-8?B?aFdwOWFHYUJZdlpxTjh1RkU4czFTWmsxU2Z0L25OM1VKL1FHQ2ZjY251c2wz?=
 =?utf-8?B?VSt3SWg2bHkyeWZnL0h6M0FTUk1lZlNQL3BnN3lxOU16V0xPbUZBeXplUm1Z?=
 =?utf-8?B?NFVSNThHdDJmSE1EdHZFZGo3dlJkRUdMelN4RXF1YVUrQklrM3F2aURubzVk?=
 =?utf-8?B?VDUyRGNsS0NjSjY4MHUva05Zckxlb20rSlpXZVZXK1F6NUhJRGNXVEFLSEMx?=
 =?utf-8?B?d3J0dmMzRWZ3SG4vL0FSdThBRVRaUUJlSmRDWnI3WWI5aC80Q0Vpc2JTbjhP?=
 =?utf-8?B?aVZxRC9hTDdxWkNIbUN6aC9SWStVNW1PNDhxTW13dUZlTWVGaXVhNklKY0J1?=
 =?utf-8?B?a3UxNFBMVlFSdTBLQWdXY0xUTUdBYnZTVHROeTk5SGxqYzNSVERzdE9DN1Qw?=
 =?utf-8?B?aW1uREFUNWdMdXVhMXpwRnhIQmVHNlFiV01VTzRXVmRGbkIvNHNzVTdVdmVY?=
 =?utf-8?B?c3VwV0dEZFRsaDhsTUIwVDc2K3pBTG92Mk1wajlVRDFVK2JxRVNoYXRnbXB3?=
 =?utf-8?B?THZRaWg3OWk1MjRMTUVyOUtxRDlWcEcyQWZSOWtGc1ZFV3A4cWx2RTdEZlJB?=
 =?utf-8?Q?3+jIdQNKfLpZqSPwwZUWjfktC1ZtwybNN9o4kdm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 950c9747-99ea-4d0c-0ab9-08d8d563b379
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB3983.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2021 05:52:26.5196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gxtHtWPcxm90lqHYsJtY9WRkFI1k/pHfIBdqvY4WAS6ukZmbB6BEefNX4cLiqXMXDomX8RPBqjO9C/47bEjEZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7118
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-02-20 at 13:37 +0800, Liu Ying wrote:
> Hi Guido,
> 
> On Wed, 2020-12-16 at 12:27 +0100, Guido Günther wrote:
> > This allows us to shut down the mipi power domain on the imx8. The
> > alternative would be to drop the dphy from the mipi power domain in the
> > SOCs device tree and only have the DSI host controller visible there but
> > since the PD is mostly about the PHY that would defeat it's purpose.
> > 
> > This allows to shut off the power domain hen blanking the LCD panel:
> > 
> > pm_genpd_summary before:
> > 
> > domain                          status          slaves
> >     /device                                             runtime status
> > ----------------------------------------------------------------------
> > mipi                            on
> >     /devices/platform/soc@0/soc@0:bus@30800000/30a00300.dphy  unsupported
> >     /devices/platform/soc@0/soc@0:bus@30800000/30a00000.mipi_dsi  suspended
> > 
> > after:
> > 
> > mipi                            off-0
> >     /devices/platform/soc@0/soc@0:bus@30800000/30a00300.dphy  suspended
> >     /devices/platform/soc@0/soc@0:bus@30800000/30a00000.mipi_dsi  suspended
> > 
> > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> > ---
> >  .../phy/freescale/phy-fsl-imx8-mipi-dphy.c    | 22 ++++++++++++++++++-
> >  1 file changed, 21 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c b/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
> > index a95572b397ca..34e2d801e520 100644
> > --- a/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
> > +++ b/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/of_platform.h>
> >  #include <linux/phy/phy.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> >  #include <linux/regmap.h>
> >  
> >  /* DPHY registers */
> > @@ -93,6 +94,7 @@ struct mixel_dphy_cfg {
> >  };
> >  
> >  struct mixel_dphy_priv {
> > +	struct device *dev;
> >  	struct mixel_dphy_cfg cfg;
> >  	struct regmap *regmap;
> >  	struct clk *phy_ref_clk;
> > @@ -382,6 +384,7 @@ static int mixel_dphy_power_on(struct phy *phy)
> >  	ret = clk_prepare_enable(priv->phy_ref_clk);
> >  	if (ret < 0)
> >  		return ret;
> > +	pm_runtime_get_sync(priv->dev);
> >  
> >  	phy_write(phy, PWR_ON, DPHY_PD_PLL);
> >  	ret = regmap_read_poll_timeout(priv->regmap, DPHY_LOCK, locked,
> > @@ -395,6 +398,7 @@ static int mixel_dphy_power_on(struct phy *phy)
> >  
> >  	return 0;
> >  clock_disable:
> > +	pm_runtime_put(priv->dev);
> >  	clk_disable_unprepare(priv->phy_ref_clk);
> >  	return ret;
> >  }
> > @@ -406,6 +410,7 @@ static int mixel_dphy_power_off(struct phy *phy)
> >  	phy_write(phy, PWR_OFF, DPHY_PD_PLL);
> >  	phy_write(phy, PWR_OFF, DPHY_PD_DPHY);
> >  
> > +	pm_runtime_put(priv->dev);
> >  	clk_disable_unprepare(priv->phy_ref_clk);
> >  
> >  	return 0;
> > @@ -467,6 +472,7 @@ static int mixel_dphy_probe(struct platform_device *pdev)
> >  	dev_dbg(dev, "phy_ref clock rate: %lu\n",
> >  		clk_get_rate(priv->phy_ref_clk));
> >  
> > +	priv->dev = dev;
> >  	dev_set_drvdata(dev, priv);
> >  
> >  	phy = devm_phy_create(dev, np, &mixel_dphy_phy_ops);
> > @@ -477,12 +483,26 @@ static int mixel_dphy_probe(struct platform_device *pdev)
> >  	phy_set_drvdata(phy, priv);
> >  
> >  	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> > +	if (IS_ERR(phy_provider))
> > +		return PTR_ERR(phy_provider);
> >  
> > -	return PTR_ERR_OR_ZERO(phy_provider);
> > +	pm_runtime_enable(dev);
> 
> If this enablement is done prior to devm_phy_create(), then the
> phy-core will manage runtime PM for this device.  This way, this driver
> doesn't have to manage it by itself.
> 
> Regards,
> Liu Ying
> 
> > +
> > +	return 0;
> > +}
> > +
> > +static int mixel_dphy_remove(struct platform_device *pdev)
> > +{
> > +	struct mixel_dphy_priv *priv = platform_get_drvdata(pdev);
> > +
> > +	pm_runtime_disable(priv->dev);

One more comment - 'pm_runtime_disable(&pdev->dev);' is fine.

Regards,
Liu Ying

> > +
> > +	return 0;
> >  }
> >  
> >  static struct platform_driver mixel_dphy_driver = {
> >  	.probe	= mixel_dphy_probe,
> > +	.remove = mixel_dphy_remove,
> >  	.driver = {
> >  		.name = "mixel-mipi-dphy",
> >  		.of_match_table	= mixel_dphy_of_match,

