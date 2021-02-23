Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFE532243E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 03:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhBWCj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 21:39:26 -0500
Received: from mail-eopbgr80053.outbound.protection.outlook.com ([40.107.8.53]:59442
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229886AbhBWCjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 21:39:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UrUXQV8YKReYxFE4/LDml8diFZwDwP2DeP8lPeTg1Wa/DOZUQQCfR66avu+U51aBgyvCKlCOInt7wZwg9sBO+kFt/NW2bBy1RTVN7XVsoPoWiV67S2zx5Irvtz5esLxnrGFY38QAFc21AfNq9SnhHKYk0Li0wgR+L6vJ1mD79nOg/SQ3D679XPipWEft8Edd/rzHaujo6hVZCNxOUb6M+RwioGg9zhmSjIi2fLYo1XEVsSk357jF86FY2WmZ/6J8pqFB5cpbquedZOiIvhsIED7NTxN05lynQcRm+IJOmzPcTUeq+2hIzK/I7l5WLOmBz9pH7WkPgxircPHHINfzBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebIx785bkTnzTVgVnKWmd3eFkUXkF3rkzO3OnDlhweg=;
 b=MNvPen2cmybgcEt333Z5mNSxybEKD/m3m9GzAgEkMYVWbQrcGnaeuKKkw8Wye7YEZPPqKrJlBM5W58GclBnr+VVZ7Lpz9t40j6NuX1dWLKbaD9Rh1trVOboHGXJfwmitQ90e9DqJySOcE/hXN7fmqSiE9829wQjAIUfdla/XNRu55snTS6ZYC1piJGvkG4bqQozuGwJXwl8RM1kBqrYLoRAzy/SLoV41E8eYK5FELDZS8ClBlfXrn4JyWFFcS9RvQtQsespzm9lHJ64Uk5bMK2HPp3FAqIKNI07vgDL4+kpl4zJGPB3OhnQFNF6+w/YF9v11+sr31ms+TWpkFoNo4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebIx785bkTnzTVgVnKWmd3eFkUXkF3rkzO3OnDlhweg=;
 b=cBYQMUCkX3STm5//uneJEvhSc8uFEdgXS0sX3GTvhM8e0w9vqMblzc8vjRkHEBxcXp3CjMFBPNDuhbENWY6x3O9wDTqJq8IjF85yBCoL/pIPh9m2ktDLtftwd5+8zaIejKiyV0+EmB147Of/+8TbPuQ6f9jq2wCscmiUWHzkTA0=
Authentication-Results: sigxcpu.org; dkim=none (message not signed)
 header.d=none;sigxcpu.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com (2603:10a6:803:4c::16)
 by VI1PR04MB3982.eurprd04.prod.outlook.com (2603:10a6:803:49::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33; Tue, 23 Feb
 2021 02:38:34 +0000
Received: from VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::2564:cacc:2da5:52d0]) by VI1PR04MB3983.eurprd04.prod.outlook.com
 ([fe80::2564:cacc:2da5:52d0%5]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 02:38:34 +0000
Message-ID: <daef1299e43f0372a95c149b979441f8083f4b15.camel@nxp.com>
Subject: Re: [PATCH v4 1/1] phy: fsl-imx8-mipi-dphy: Hook into runtime pm
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
Date:   Tue, 23 Feb 2021 10:36:58 +0800
In-Reply-To: <fa1ce8cdb448ed81e0dc6e49e3c7f8fd6b19ecae.1614019053.git.agx@sigxcpu.org>
References: <cover.1614019053.git.agx@sigxcpu.org>
         <fa1ce8cdb448ed81e0dc6e49e3c7f8fd6b19ecae.1614019053.git.agx@sigxcpu.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
Content-Transfer-Encoding: 8bit
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR03CA0143.apcprd03.prod.outlook.com
 (2603:1096:4:c8::16) To VI1PR04MB3983.eurprd04.prod.outlook.com
 (2603:10a6:803:4c::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from blueberry.ap.freescale.net (119.31.174.66) by SG2PR03CA0143.apcprd03.prod.outlook.com (2603:1096:4:c8::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.10 via Frontend Transport; Tue, 23 Feb 2021 02:38:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fe0f2cca-b3b9-426e-b49d-08d8d7a41da1
X-MS-TrafficTypeDiagnostic: VI1PR04MB3982:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB39820957BDA5A45A2537DD0598809@VI1PR04MB3982.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mX11J2e7gfuqPJuO2nFqu4MLP2XI8AhJiv2N2Q3u7gzDULW1n2dLm3NI5qwZkyu/OCXe9ls9Jo+Xv2BE6SPxo316T+kIYj+Ns9Gt2u727CMmYX7xxrayQA2yPYgHbDoiLrxTMn/UzZ+1XlEKmDltpBbLWulVDK4axuheAgxhqtG6Odbkxgs3Teqycz+KR6+L7AZFijHzhKYJxBCJSlME9BETgxajv+DsjmDg7rjQGJQL6D17bQ/u6ZrtuDIo67xe0oa6nG4MwsMhYVaLB61lrkeNpI/LfmYX3W8Bej7P80UwoxCNopsGAS6elLkvTVthbNXoXI1OY2kU6uKKD27NXnx/fN+BJLtyBEaY8epLHRpgtNMuB9QENG8hcWzx2a7w/1b0rqm4YFSFENyrXQ0aIqto8V2ZnHiPFzqo4x5rVOoCpoE3flQoCzTC3rztpJYkfJEYXbns5saLdmqYfYSQU0/cNf+SvnX+Y1aOr1mbXCWOmDfMQH5xa2cVLtXk002ThpKb0dsIn35NMIgWGQ2gsXjonhn+ENTgu6ZVg6bQB+LrE9nwwxVOM1XRAtlvY9yu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB3983.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(956004)(66556008)(2616005)(6506007)(36756003)(6486002)(2906002)(66476007)(66946007)(6666004)(83380400001)(86362001)(110136005)(66574015)(6512007)(52116002)(316002)(8676002)(16526019)(26005)(478600001)(5660300002)(186003)(8936002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bnpESkFIbXUwdWU0bnlrSU1tMnN0Qk1EUVhRaWtyQXhkMnZjM1J1REJoaHVl?=
 =?utf-8?B?eTBSRU1PUm4wZ2ZuVjl3cHhDQTBuTGd0SURkWXhleGdHUkVMMUFOZmc5UGlF?=
 =?utf-8?B?ejZ1eU1EMEwyNnZWcjhvcWdDZnduNEV5WWVoUEhlaUZVMUVlcURrNktaZFRz?=
 =?utf-8?B?YWI3dzA1eGFVV0I5OSt1b1J6ck9Bb2Z5eGM5N1NyM21tV3Bqd1c0Vk0zbmk3?=
 =?utf-8?B?S1FON1RpUzN0Zlg5THFxV21RVHRpMkRTMm5hVVJGWkpaYld5RWdUNFJCeG12?=
 =?utf-8?B?Sm1RRVJLNGg2bEttK29saklCTENhZ3FvR3pEMHdxWDVmSExlbmRCSlQyam9w?=
 =?utf-8?B?VmpnOExZZmppZjFKM0t0UTJKRFpzak5MWGE1SkE4bXQrWnFPbnpJeEhrUUdt?=
 =?utf-8?B?c0UrcGR1UUFGRUJiaTRoMjJQM3g0WUxXcUhFdlVPUnRwMGRFdytXUXJiVnNF?=
 =?utf-8?B?OFQvbXVwemhxLzZPOEZyMWhyUG9qR2dFQStpSWxzUFVoUEt0STFxc0JGNGhN?=
 =?utf-8?B?UW5TbzFuWHAyb25TOVZyZUtFMUU4OHBqRXFpWlpGaTNBakE0UEFzUjFFTThP?=
 =?utf-8?B?ZS9MUVF6TUU3bWlYempGWW5YbUlDbGJqNTdsVUU2RHpsSVFTM3VNOVRqbWNP?=
 =?utf-8?B?clNlUmVqSmJuU29oQjZzbmpaZlpjK2dEUEtTR2lHOXpzNk1CQW43aHM5OE8v?=
 =?utf-8?B?WmZHZVZQTTcyM3FKaytRemdDQWdFRlMraWRldTVVOUVwRFZqNWpEajhzRU5V?=
 =?utf-8?B?RDV1WmJobXoxMmVvWlFtemx2RzlCK1JGRkY1UWJscVU5bnduNFhXT2kvYThB?=
 =?utf-8?B?cW13c2ZJdVRBU3ZBV01WSGgyOTdHQUtHaEJvS3NVdE5kaUJOQUNKM3dmck05?=
 =?utf-8?B?OXpBNGFYenRBd3RUbDF0WTFmKzBENGFVRTBBUGs0UXJ0N3VWL1dab1FQMHVD?=
 =?utf-8?B?cy9EZ1hKaEJsTlllY3lkdHlYVmRSeU9xcVd1aVRHU2hoMjdTYXk4YjJJdDI2?=
 =?utf-8?B?VHN1Q0hCTjNBRlE2cXY4VW1VLzFXb0tWM0lnTXlPaGF5OVkwdGgzdHNQQXRT?=
 =?utf-8?B?eFkybS9lRXNCT2cyWFVOY1hPYmQzVkdxRkpzcmFKaTRhNlVJeDVHRklEYjQy?=
 =?utf-8?B?N1kveDJMR0JsYXlwL3ZrTnRDLzFUTGdLc2ZQZGUxZXhuSkU4M0hvMDQzcEZs?=
 =?utf-8?B?SE9NdTZxU1dndU82dTg1NnU4a1JNU1FEZit3UWRDeGFmUWVrUEJoTlVvWDlK?=
 =?utf-8?B?aEo1NUhaZmtNa0hZdW9IZGtyY3pJRWZ5c2lwSDhUdTV0QUpicDF5d2k0dTlC?=
 =?utf-8?B?a0hNVE1CMUNlMmRPakNTNmxweUNCNkdBQmppREc1RGFJb25jU3hQL0JIdGVU?=
 =?utf-8?B?a3ZONngxTVVmUDZ0c0FMOWhzSmlmdlRYZklHRkYzYW9SYlVYVFV1SFhXVXNC?=
 =?utf-8?B?MnRRbk5UT3NlZVpUK2xtNU84WHlUdERlZHRldTZyUThxSkxyUWlSUG5NN0dO?=
 =?utf-8?B?bGFpMVdwVjNUQm1md3VrKzA3MGNhbFVCai9PVC9yN2dmMmJWT2ZRcCtwNXRy?=
 =?utf-8?B?bFg4b2VhWWUwVDlOb2xvSDFKN1NwRGNoMTAxYnl2VXdPelRqZEZvZU5nd0JR?=
 =?utf-8?B?T055bGdrd010RnlFTis2YktFdk9MNGFSUDBWWFVHd1UwYmVLUW5ndzZ6dlVj?=
 =?utf-8?B?RkhvUFhvalNLUTB1VWNydXZBMUpJOHJORjFwTklQbmhJa2RwQ21LUjU1TXFk?=
 =?utf-8?Q?043l0BQhfjP2iE3YrR/aPZtp2JbtqfdE4RfETJ+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0f2cca-b3b9-426e-b49d-08d8d7a41da1
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB3983.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 02:38:34.6649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fbOTeJ/6M/kBISapZVSQqYHmnxP0oOcz+D1a42szSI79pS/YqVqO0UH5purDv0qVElxXLjJBkZbG/60VADxPaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3982
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guido,

On Mon, 2021-02-22 at 19:38 +0100, Guido Günther wrote:
> This allows us to shut down the mipi power domain on the imx8. The
> alternative would be to drop the dphy from the mipi power domain in the
> SOCs device tree and only have the DSI host controller visible there but
> since the PD is mostly about the PHY that would defeat it's purpose.
> 
> This allows to shut off the power domain hen blanking the LCD panel:

s/hen/when/

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
>  drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c b/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
> index a95572b397ca..5de175695834 100644
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
> @@ -469,6 +470,8 @@ static int mixel_dphy_probe(struct platform_device *pdev)
>  
>  	dev_set_drvdata(dev, priv);
>  
> +	pm_runtime_enable(dev);
> +

The runtime PM should be disabled if devm_phy_create()
or devm_of_phy_provider_register() fail.

Also, I'm just realizing that mixel_dphy_configure() accesses some PHY
registers, which likely needs the power domain on. However, the
phy-core doesn't manage the runtime PM for phy_configure(). It looks
that the NWL DSI bridge driver, which uses the PHY, enables the same
power domain prior to the PHY configuration. That's probably why
mixel_dphy_configure() gets power for accessing registers(if really
needed). So, perhaps, either make phy_configure() manage runtime PM or 
get/put runtime PM in mixel_dphy_configure().

Regards,
Liu Ying

>  	phy = devm_phy_create(dev, np, &mixel_dphy_phy_ops);
>  	if (IS_ERR(phy)) {
>  		dev_err(dev, "Failed to create phy %ld\n", PTR_ERR(phy));
> @@ -481,8 +484,15 @@ static int mixel_dphy_probe(struct platform_device *pdev)
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

