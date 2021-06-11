Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A71303A3C00
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 08:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhFKG0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 02:26:24 -0400
Received: from mail-eopbgr140041.outbound.protection.outlook.com ([40.107.14.41]:64940
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229633AbhFKG0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 02:26:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RuvGOi7BSLwmAzDJ35y3fQ9jogig84JBOeG90zcIxZ0rRteM2qy2RlA4uPt9b7Usw3rcpU4mHFTs3y/LCrdldCC/QZHn8Auwz5KCzO2z48tBNfVNIhQ7lrtNvp8dh+H1AnEnT+9xI9a8ydRSqu/kl3Vt2pNXk0xX4k4x29oBHUZerIrRESUc8+sVPKqiu3MK05xAZjLguAZHKqmDK94+c4njk1siEEjl9Q5DMlBR9MQEhwFV2Hj3baCUI2bzotPw971+PzWiuFn7vIa9wACByfZJ510gkE5W6VwynyP216olrZ3q7cD1irpR/SStlwbpr3DaM/eR17bu3R6jRl8COA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXw23S8iG8CK+w6OomNHmt6A7o+4JkI4FA8jWttcl5A=;
 b=bGpkfN29WAR4Zc7BStvY4/qjTIU9Mwb0vhgSSqtYkgYnTitCpGZ/jCz/Zqlq5DpZYAHIW03yldkxJiv4rk0dsQUAY8VgiCLDTrJ7xUHrT/l+LBDvrYyAhMlt8YsObmuvtq2dy8rSzC8JogFl4ai2Rv7V+BrQOBlMYtRuNv62kjp3GQZmhI+3cTJgUvx+KyTZZZGO9rIeUb/G+KOgXIRkVBq4GiLhaQHo4rOKFQzVJW7GS3CnvwU5jhrmcYXddlV0lWl8f7y4+izeejdQMA/LaF+9zfA8vkwvSzoaNulSJiluVL12v9Jr8tUMcBRiSxqqwoI9Pa8Q9rc3pT7j6vtS/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXw23S8iG8CK+w6OomNHmt6A7o+4JkI4FA8jWttcl5A=;
 b=D6ex4ODyI2S28TC7rDiHLqKQxMcBZzqLpRy8Pj/Go5qnFw7S5bvrUTfJzq+fC9CKjScmKK+opQPsdnXIRKw81DtJvHMJSXakqr5SPiOZsUje1+Lnc29FjIyo7XoJgTteNB4ZcdnMns24si980p8zBBnZ7bZu5cgu+Yd+4YjKbG8=
Received: from VI1PR04MB5935.eurprd04.prod.outlook.com (2603:10a6:803:e9::17)
 by VI1PR04MB7072.eurprd04.prod.outlook.com (2603:10a6:800:12c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Fri, 11 Jun
 2021 06:24:22 +0000
Received: from VI1PR04MB5935.eurprd04.prod.outlook.com
 ([fe80::79b2:6f7:b5ef:ed81]) by VI1PR04MB5935.eurprd04.prod.outlook.com
 ([fe80::79b2:6f7:b5ef:ed81%5]) with mapi id 15.20.4219.023; Fri, 11 Jun 2021
 06:24:22 +0000
From:   Jun Li <jun.li@nxp.com>
To:     Breno Matheus Lima <breno.lima@nxp.com>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "brenomatheus@gmail.com" <brenomatheus@gmail.com>
Subject: RE: [PATCH] mx8mm: usb: chipidea: Fix Battery Charger 1.2 CDP
 detection
Thread-Topic: [PATCH] mx8mm: usb: chipidea: Fix Battery Charger 1.2 CDP
 detection
Thread-Index: AQHXXmPdJttyoNJAYEGwtM/iicSVYKsOV5Fw
Date:   Fri, 11 Jun 2021 06:24:22 +0000
Message-ID: <VI1PR04MB59358BDBE0A6FA8A8966C66789349@VI1PR04MB5935.eurprd04.prod.outlook.com>
References: <20210611014755.124483-1-breno.lima@nxp.com>
In-Reply-To: <20210611014755.124483-1-breno.lima@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a8a89a1-8e53-41c9-5dc2-08d92ca18dc6
x-ms-traffictypediagnostic: VI1PR04MB7072:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB70726388F71BD13B5AE2F5FE89349@VI1PR04MB7072.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FIx22HtwCkyB9927AP0lRNjt4mM8+784Ih52AaipmqnLoWzQPtxM+PRrN//sy5xGvjpMuR9OV1WfrmzDwLguNQ48lJIp+olU5IUTU88eVO69KLvXGYV0ZSD5mgUsPioGqIPS24Zc8v2n0MYQT2EMMTiDNr3/MkcP9WbCua9b93ZxAnHvfbrSFkHzvxkHfcYPdvnnrOckRWSWpaRFodF04JqX2cPIh4RQ1+OF4TzYyIHgzNzFj2AzTmfg4r2mmv8IjnF074ZsUawR8AlEQiNmqLjmKmlAJ4A2KC+Ss8M3GHrnTZC5QRQPFdPlBfE7verJkbe0ad9YS0zYQZCpaVVWgSE9qJxDEhMAiMTx3aI+eXtR6GeKruLhPPtSeOi44Y2l5ZGMNCVzErqChwaiaJICxighqds5860D6qYWQjS30d184SfDz780wUqGigdFhm/rnfF23Jsxvx88j96Oq+Ktw0sqZam591WVIbYdMhpqVbm5MnZ+gXSqrFNKLrcBPabsXBt73OYEqNf0A6gtuGg/+uzxTLyKCWpqCrobbkoPuFZsu5tONKuy3SKu0xW49wwMDBLkgmU16odALD0YiA8X0Xv+6cD0juxKDSWx/LCj9fbL0SiANTfGKPlugPZxGRfksO1nZfm0hG+XS6IUi/x6ZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5935.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(396003)(366004)(346002)(316002)(478600001)(53546011)(6506007)(54906003)(86362001)(110136005)(9686003)(2906002)(186003)(66476007)(66446008)(76116006)(26005)(71200400001)(55016002)(66946007)(33656002)(83380400001)(44832011)(66556008)(64756008)(7416002)(8676002)(38100700002)(4326008)(52536014)(8936002)(7696005)(122000001)(5660300002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W9OZsLhE00uhST6WSvg9uIInF7gTxUliEY0SNfVCXsBIoMqSfQWCaElzPxgI?=
 =?us-ascii?Q?nuVZkJyuBBdpppj+pv41FAxDJ5JcIJzPbpvaFvJn3sSggomzH6a1QAamd/kr?=
 =?us-ascii?Q?2s8FESabdwWYXW4a8w+S3np3NFM7TzHnokhbfvRLUnuGDAF/ueGgv4S4GxZv?=
 =?us-ascii?Q?5voojCY6FF6jFEbmWr96uA6yf10z4SqJz4z2cu8kHHtZ/P3uH+C6AdsgQZst?=
 =?us-ascii?Q?mCEmmqu6Fw25AGCaoAwbI8BILBrX4aouN3MJMWHBkrJoCI5KkHsQO4LEQITo?=
 =?us-ascii?Q?CNtGCYfFpi3/mM4UXI2hiYS7f3VW1/8aJ0mF7/ZV0HjxfXM7z/rRD45xpZMv?=
 =?us-ascii?Q?/VMIGpXGJfb89fKV+cJiaF2FnrF+ONBM+wXwt73Z9sdXdZwv/SU38Mtn6RRa?=
 =?us-ascii?Q?pYxHwpr2510nVeJYFqXIADU+Dn/gsXKNP0A++L/m8uBHBF9+UV5OCvffIXFy?=
 =?us-ascii?Q?7dE5uemCf44GtKDeiekqDnC7UEkNaWSRTT0AwYP0SJ6GGB0nNSamUsz81TxN?=
 =?us-ascii?Q?f4Tw9pzbJGNtNX4tzjNA7370cZzjVqTlAnAvyrAb1SUySJaCj5OwSWnNFq/K?=
 =?us-ascii?Q?D+WxrbjV7Zice5nwI4aA8osKrjCeyDmD5apaaid8MFXWp7ABWl4KUpJnOL+K?=
 =?us-ascii?Q?Pc2uKzOF28XYGl3POjrNtm5qm+7QX9bmk8SZ2aMh2gBqPMsEzCACszfsr++e?=
 =?us-ascii?Q?uoev61BFWM3bkxsbdAMSHxDlATsWtTC+pxx6rxDqjLzt2qssGAPsIfGYNiRv?=
 =?us-ascii?Q?pUUpRESEhHnbldRvJx0U+YtaElkuCcnLFY+0uyhwsKHChr8wJASs7osZQJyc?=
 =?us-ascii?Q?xk4o1rnLPjJNrVZ8cg9i8/ZBdV2GWk2rUbU5QttR7G3zCYUTDM0J6efmaLH+?=
 =?us-ascii?Q?3oTVuTzENh2mkBnS4AsRyztf+gJv9T7CYwWxFKmWfC260nYvo0K+UEBxFJ4Y?=
 =?us-ascii?Q?GrO/eHORTsZ/L4imGbzUhA9IReh42/xgsVVf7er22liSGOHvWXV7wSmscrru?=
 =?us-ascii?Q?DCatlAKUhjZ05ldwYnknOqVC/hNvgYQ1zhEXNS7uu2FYib539mamg5FY9rj4?=
 =?us-ascii?Q?0zNAnBv4rAzPg3HLSUCszQvA35/YwGqG/goZEXnyDAi3eBJnOEriiRcL4gVN?=
 =?us-ascii?Q?+F7125Cjn0tw4CI+kSrg6GoQ6c71r2GClmbZENVgaIbH785QSrUcYvYf8J6N?=
 =?us-ascii?Q?r0Kf2tZ+yhUyufeHNZJApr+Xo9NptC3S/4jhDpCzr/kbYeXRJEN/fnESne04?=
 =?us-ascii?Q?6WDgap4FoZiRSQ+wHN7SFdAp5sgo3c4xTRef6awpXSCS8iaRi8OoWCLodqbe?=
 =?us-ascii?Q?5LQQrC4iYRTryC0oaiiZsZxM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5935.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a8a89a1-8e53-41c9-5dc2-08d92ca18dc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2021 06:24:22.7811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tqhnQGl814gJ9DCGALrNxvepNCQLYUg6JKrKJ9IxffYc/ytw/TUWqgOXmYus99jN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7072
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Breno Matheus Lima <breno.lima@nxp.com>
> Sent: Friday, June 11, 2021 9:48 AM
> To: peter.chen@kernel.org
> Cc: gregkh@linuxfoundation.org; shawnguo@kernel.org;
> s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> dl-linux-imx <linux-imx@nxp.com>; linux-usb@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> brenomatheus@gmail.com; Jun Li <jun.li@nxp.com>; Breno Matheus Lima
> <breno.lima@nxp.com>
> Subject: [PATCH] mx8mm: usb: chipidea: Fix Battery Charger 1.2 CDP detect=
ion
>=20
> i.MX8MM cannot detect certain CDP USB HUBs. usbmisc_imx.c driver is not
> following CDP timing requirements defined by USB BC 1.2 specification and
> section 3.2.4 Detection Timing CDP.
>=20
> During Primary Detection the i.MX device should turn on VDP_SRC and IDM_S=
INK
> for a minimum of 40ms (TVDPSRC_ON). After a time of TVDPSRC_ON, the PD is
> allowed to check the status of the D- line. Current implementation is wai=
ting
> between 1ms and 2ms, and certain BC 1.2 complaint USB HUBs cannot be dete=
cted.
> Increase delay to 40ms allowing enough time for primary detection.
>=20
> During secondary detection the PD is required to disable VDP_SRC and IDM_=
SNK,
> and enable VDM_SRC and IDP_SINK for at least 40ms (TVDMSRC_ON).
>=20
> Current implementation is not disabling VDP_SRC and IDM_SNK, introduce
> disable sequence in imx7d_charger_secondary_detection() function.
>=20
> VDM_SRC and IDP_SINK should be enabled for at least 40ms (TVDMSRC_ON).
> Increase delay allowing enough time for detection.
>=20

Fixes: 746f316b753a ("usb: chipidea: introduce imx7d USB charger detection"=
)

> Signed-off-by: Breno Lima <breno.lima@nxp.com>
> Signed-off-by: Jun Li <jun.li@nxp.com>
> ---
>  drivers/usb/chipidea/usbmisc_imx.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/usb/chipidea/usbmisc_imx.c
> b/drivers/usb/chipidea/usbmisc_imx.c
> index 4545b23bda3f..bac0f5458cab 100644
> --- a/drivers/usb/chipidea/usbmisc_imx.c
> +++ b/drivers/usb/chipidea/usbmisc_imx.c
> @@ -686,6 +686,16 @@ static int imx7d_charger_secondary_detection(struct
> imx_usbmisc_data *data)
>  	int val;
>  	unsigned long flags;
>=20
> +	/* Clear VDATSRCENB0 to disable VDP_SRC and IDM_SNK required by BC 1.2
> spec */
> +	spin_lock_irqsave(&usbmisc->lock, flags);
> +	val =3D readl(usbmisc->base + MX7D_USB_OTG_PHY_CFG2);
> +	val &=3D ~MX7D_USB_OTG_PHY_CFG2_CHRG_VDATSRCENB0;
> +	writel(val, usbmisc->base + MX7D_USB_OTG_PHY_CFG2);
> +	spin_unlock_irqrestore(&usbmisc->lock, flags);
> +
> +	/* TVDMSRC_DIS */
> +	msleep(20);
> +
>  	/* VDM_SRC is connected to D- and IDP_SINK is connected to D+ */
>  	spin_lock_irqsave(&usbmisc->lock, flags);
>  	val =3D readl(usbmisc->base + MX7D_USB_OTG_PHY_CFG2); @@ -695,7 +705,8
> @@ static int imx7d_charger_secondary_detection(struct imx_usbmisc_data
> *data)
>  				usbmisc->base + MX7D_USB_OTG_PHY_CFG2);
>  	spin_unlock_irqrestore(&usbmisc->lock, flags);
>=20
> -	usleep_range(1000, 2000);
> +	/* TVDMSRC_ON */
> +	msleep(40);
>=20
>  	/*
>  	 * Per BC 1.2, check voltage of D+:
> @@ -798,7 +809,8 @@ static int imx7d_charger_primary_detection(struct
> imx_usbmisc_data *data)
>  				usbmisc->base + MX7D_USB_OTG_PHY_CFG2);
>  	spin_unlock_irqrestore(&usbmisc->lock, flags);
>=20
> -	usleep_range(1000, 2000);
> +	/* TVDPSRC_ON */
> +	msleep(40);
>=20
>  	/* Check if D- is less than VDAT_REF to determine an SDP per BC 1.2 */
>  	val =3D readl(usbmisc->base + MX7D_USB_OTG_PHY_STATUS);
> --
> 2.25.1

