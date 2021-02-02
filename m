Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA42E30B4F2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 03:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhBBCC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 21:02:56 -0500
Received: from mail-eopbgr00083.outbound.protection.outlook.com ([40.107.0.83]:55678
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230122AbhBBCCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 21:02:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6DwDEuRbqpVtFQrWlFQggjCyaZrubiPTjAw4YdJYu3XCxjU7tUPAjCeAjqdSZxI04xA9bnugnTncgC7LVOkJCuWZPWKKZPvr07rkHANFFWcHz5zrzCwtvJ7RkulgCCI9+rm5ZErbenamziBhrPREHXVKZ+8eSDWuxP5mUhkDBoBUjay2mUJCGciqzFwtib4HJp0ZHLSXqehygsbm4OFoKS1uTWDmc9jbp+FUG8e6YzBBtIiDME/RxU8uWWf7DX/SojYgkUPIQurLyT0yO5LnoEPHhCNv3VhMShonnlh5Ef7p8HSit3l2dK6gc9jYTzTf14SQq0I+jRR04NtHyhT0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHdSPr1wQ/efzdlvQIkDyB/mcki95784iKXk7f/4wDM=;
 b=fUMopVp0zDz7VAhD9qCtXeiQs8qOUU7WPjyApGAhmGAH+K68QyvHYoiwK3GGuReIzSN0DupiybHBWC9p1gNJ9534kkfQaOYxP6ge+xW26ToIYK9OrigM4f5nV6II2qYzrlDHzT2EVDNYkTSOOh9toYS2/8wOhZ/iDzw1WzvTl9+/duFSRFlR25iIIwkCMjBFjoujPtm9dRZKc7lb96XgnPJ90gx9D5/Npau8FmeIpsxVrPsdNsrWT7Ufm4/QHbzf3NdwOJOO+p8hASXA2mLSXccujCGOb3QGSBQ6bCdkbS0WS7nSndUM9Vc5lMt2FeFyOCAj2e9rxC/smCUwULJSzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHdSPr1wQ/efzdlvQIkDyB/mcki95784iKXk7f/4wDM=;
 b=a++AzPUweiLTcWxQqXlKKJKy6DQ8X3DDfkqeLOeuCDJX5J+ONZNwYdDie2N5yWNsJaU+QAIQZXUnmcQbQPUmdlw40MTHwz9NRax5mDpRxlbGXjegoR6Owl88JtcAIYgw+iub6GX//Xpw7npWIa+zOpeWo0IHSV57PO+opS8NiIw=
Received: from VE1PR04MB6528.eurprd04.prod.outlook.com (2603:10a6:803:127::18)
 by VI1PR0401MB2398.eurprd04.prod.outlook.com (2603:10a6:800:2a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Tue, 2 Feb
 2021 02:02:00 +0000
Received: from VE1PR04MB6528.eurprd04.prod.outlook.com
 ([fe80::80f4:b88a:e331:c1b9]) by VE1PR04MB6528.eurprd04.prod.outlook.com
 ([fe80::80f4:b88a:e331:c1b9%7]) with mapi id 15.20.3805.024; Tue, 2 Feb 2021
 02:02:00 +0000
From:   Jun Li <jun.li@nxp.com>
To:     Adrien Grassein <adrien.grassein@gmail.com>
CC:     "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "rikard.falkeborn@gmail.com" <rikard.falkeborn@gmail.com>,
        Peter Chen <peter.chen@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 2/2] phy: fsl-imx8mq-usb: handle resettable hubs
Thread-Topic: [PATCH 2/2] phy: fsl-imx8mq-usb: handle resettable hubs
Thread-Index: AQHW9cK/Xd4v6w/EQUeck/DTUwmxaKpEIBQQ
Date:   Tue, 2 Feb 2021 02:01:59 +0000
Message-ID: <VE1PR04MB6528BC88615D9A2DD2080E4389B59@VE1PR04MB6528.eurprd04.prod.outlook.com>
References: <20210128221255.2673992-1-adrien.grassein@gmail.com>
 <20210128221255.2673992-2-adrien.grassein@gmail.com>
In-Reply-To: <20210128221255.2673992-2-adrien.grassein@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bb854fae-c16e-4d2d-7d04-08d8c71e8714
x-ms-traffictypediagnostic: VI1PR0401MB2398:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0401MB2398C50319736C1B96663F8B89B59@VI1PR0401MB2398.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4tk/fWaWCjiyi2GypCe4UKncO1aXAtbU7LV+rk+deHzL90AwCWr//nO91B5Fz2kpdDtZLC4bctVXVsG6d8W2YP15bAUGHs9NXH/hFRZLgNpClDRLSh6U/inQaeSc11Y2rDzPcanzPeTAfQmfmwTNRf/ukBpyNakn8dHRCoMB63pFwb3mopeXlYMfzpfXm/qyGHD2S87LtDDc+U7I/WWao1NKgrUIleRLSa/TTx6fsDD8uaSIqC+TEDYkOPQJbAbCddcJWIbDTl27OIkxwTyLWFVMdDGObtRCxGTD6P8s49u2RMjP22wU71e59PXbkpJ8U/wTycwSrM5jw0yiUKH1BAIv2qAoaKozrjL+zANQOw/pJFlJz2GvKZzcC1jSKCZINShLvStthpywT3CZbx3b551QqQBrB0Qw7GMCb2YLtosCR2lIa7+luRaDFftPJgXukY4QVc5pYTIKOa2gUMEp2vF6sFPFfvBPWbdtcwYifpVdDoEm/KJbgQ0tLAAPBDh5Kr4jil3BkGNzWK+SxdeuzQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6528.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(346002)(39850400004)(376002)(66446008)(86362001)(8936002)(6916009)(4326008)(2906002)(9686003)(186003)(5660300002)(478600001)(8676002)(26005)(33656002)(66946007)(64756008)(6506007)(52536014)(66556008)(66476007)(71200400001)(316002)(7416002)(44832011)(7696005)(54906003)(76116006)(55016002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?yWqlxQZ38rHnKSBcqX6Fijgjr/tn9UOpV2UmLAi6/cCGNBiYDFX/YOyvI5o+?=
 =?us-ascii?Q?C0gEt1nJIGKXZSVHTzPS+XU/sXm7XTe9bzn2bwk3+yQh1Bi0BDZzHVPYPGdg?=
 =?us-ascii?Q?XGfjd14EiNCwzv0zOUSPWsfFgrepRyIIyC/nAbMGGYeQl58w+dMmx11U0kbe?=
 =?us-ascii?Q?sOcZWCBcl2NEOM8eaXrNUVsmLvSXwD5GRqW3l8JddZKAcn/9GoUSMQCRL9CH?=
 =?us-ascii?Q?noH527iWTVl3iGpIFSbt6vomPLCeN7+Ozs2SSeD+BW/ZMRprk2gd5GcFDMG4?=
 =?us-ascii?Q?gjejbwuR99+abTpU+KBhTHtWmVOHXKeVEJq9ghJmN+26P13QqeTOeKTcbqqw?=
 =?us-ascii?Q?PkwBbhQ9VfZmSpOnle4df5ZN+mzIMfAGql3U+i17cM/dMYVj+3BvraTwHzjI?=
 =?us-ascii?Q?40og26ufDI9kXbtyEm+LIw73UqKBPCu2gxmzqnPPT0n7rsMnvqm94JVIuT8Z?=
 =?us-ascii?Q?5o8gabYfiqzD4CIFWIcRMIBMBFGJH70v2Qo65UC1WPGIzENpyFlPAU7SuJ0y?=
 =?us-ascii?Q?yA/92w3tPGkFW6Lf9zsabJuHpoLZvKgVA3pmnAwnYkSY6LGXaAR0g2IIHDW4?=
 =?us-ascii?Q?tGe+3j7doIs/oohxt+RY6llHf/x24XP+28y+cTvlOWTGSs5qml6WxwEvMEmv?=
 =?us-ascii?Q?PQDJJyeEdXDOYVwaWsm0YHCRxHgX7p9zxQbOXZkM4FN4AmQSpQ+hfJMGmzO4?=
 =?us-ascii?Q?6zQhIWRZ7HFreC2Sgz702cW0/rfDsIJUizR3OJHZ4saTCsYRaY4mhxQYL8qt?=
 =?us-ascii?Q?AK4tm0Sxkju/nU0NkbawxaY9/tgNYyZGucR9Qev9ecum1wNpM4pq+iQBFVgc?=
 =?us-ascii?Q?RqwpjaQZkHkU14LbaDlEEe5/OWqzEb1nrr77hMoWS3xZ/dgFFAEgewR1TSUG?=
 =?us-ascii?Q?QmAwNHKJSeZEXtgplHc1IUQk4Omib0os88SuMq1mFDaiiq5KQXdRReEnqVIu?=
 =?us-ascii?Q?J6xapFauNTgw+6YpyTi8jICtTiIbVlNdAEY7HEt2CEuVd1GscBjejO6yhm1F?=
 =?us-ascii?Q?K4ElVSLBGRZ7tlzW2lmXg4OMFCcZL+a1RPBaWv/tG2iEP7KVZNCmFsee+qyg?=
 =?us-ascii?Q?b9Lv3u78?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6528.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb854fae-c16e-4d2d-7d04-08d8c71e8714
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 02:02:00.1168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Zp7UhyX+bnUWaTnd67Ax/wZEHP/0oHctKW+VqicFreLzuS9ZAxlgbfmR8YLt88L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2398
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
> -----Original Message-----
> From: Adrien Grassein <adrien.grassein@gmail.com>
> Sent: Friday, January 29, 2021 6:13 AM
> Cc: kishon@ti.com; vkoul@kernel.org; robh+dt@kernel.org; shawnguo@kernel.=
org;
> s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com; dl-lin=
ux-imx
> <linux-imx@nxp.com>; rikard.falkeborn@gmail.com; Peter Chen <peter.chen@n=
xp.com>;
> Jun Li <jun.li@nxp.com>; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Adrien
> Grassein <adrien.grassein@gmail.com>
> Subject: [PATCH 2/2] phy: fsl-imx8mq-usb: handle resettable hubs
>=20
> Add an optional GPIO in the dtb description that will be used to reset th=
e connected
> hub (if any).

Put the external usb device reset in host phy driver, this may not
the right way, there was some attempts to handle this case(on board
hub), I am not sure what's the status now.

Li Jun

>=20
> Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> ---
>  drivers/phy/freescale/phy-fsl-imx8mq-usb.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
> b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
> index a29b4a6f7c24..00abf7814fe9 100644
> --- a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
> +++ b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
> @@ -4,6 +4,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/of_platform.h>
> @@ -36,6 +37,7 @@ struct imx8mq_usb_phy {
>  	struct clk *clk;
>  	void __iomem *base;
>  	struct regulator *vbus;
> +	struct gpio_desc *reset_gpio;
>  };
>=20
>  static int imx8mq_usb_phy_init(struct phy *phy) @@ -111,6 +113,9 @@ stat=
ic int
> imx8mq_phy_power_on(struct phy *phy)
>  	if (ret)
>  		return ret;
>=20
> +	if (imx_phy->reset_gpio)
> +		gpiod_set_value_cansleep(imx_phy->reset_gpio, 0);
> +
>  	return clk_prepare_enable(imx_phy->clk);  }
>=20
> @@ -120,6 +125,8 @@ static int imx8mq_phy_power_off(struct phy *phy)
>=20
>  	clk_disable_unprepare(imx_phy->clk);
>  	regulator_disable(imx_phy->vbus);
> +	if (imx_phy->reset_gpio)
> +		gpiod_set_value_cansleep(imx_phy->reset_gpio, 1);
>=20
>  	return 0;
>  }
> @@ -153,6 +160,7 @@ static int imx8mq_usb_phy_probe(struct platform_devic=
e *pdev)
>  	struct device *dev =3D &pdev->dev;
>  	struct imx8mq_usb_phy *imx_phy;
>  	const struct phy_ops *phy_ops;
> +	int ret;
>=20
>  	imx_phy =3D devm_kzalloc(dev, sizeof(*imx_phy), GFP_KERNEL);
>  	if (!imx_phy)
> @@ -180,6 +188,15 @@ static int imx8mq_usb_phy_probe(struct platform_devi=
ce *pdev)
>  	if (IS_ERR(imx_phy->vbus))
>  		return PTR_ERR(imx_phy->vbus);
>=20
> +	imx_phy->reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT=
_HIGH);
> +	if (IS_ERR(imx_phy->reset_gpio)) {
> +		ret =3D PTR_ERR(imx_phy->reset_gpio);
> +		if (ret =3D=3D -ENXIO || ret =3D=3D -ENODEV)
> +			imx_phy->reset_gpio =3D NULL;
> +		else
> +			return PTR_ERR(imx_phy->reset_gpio);
> +	}
> +
>  	phy_set_drvdata(imx_phy->phy, imx_phy);
>=20
>  	phy_provider =3D devm_of_phy_provider_register(dev, of_phy_simple_xlate=
);
> --
> 2.25.1

