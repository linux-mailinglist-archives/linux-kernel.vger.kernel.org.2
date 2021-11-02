Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17EF4428C6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 08:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhKBHsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 03:48:33 -0400
Received: from mail-eopbgr130080.outbound.protection.outlook.com ([40.107.13.80]:45222
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229526AbhKBHsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 03:48:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=csvbrGay0A2eKIa7z+LJAJ7weQ+ngweuC1ecnJYKxmJxVf1F3s/+DyPcB0J8tmRileyMsdN6GgbrXDjMIoiVHrDbC/07KD8vJiRsF9B7+Fh79/mBLfL+CYUmk6scZ6xDz05Ck2ctQa3wgSRo0TMSDhtYa/fy3wLrs1eKM18hriWPhEunrBEzFWk1U2ISrTYtB66NutKOhi/x7WoejTEVNdmrKuZ0NvDawJJzd2J/zimm19GC33YzACRC4t3NaM4G3RI+lAuN6J34Fc439rbmdEm7nsJgdN+yP9GKP1mw1PClYlB8AD6kqoYxEIElX4lBtIxGTjWs57MIDKejPZSRsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWvKIo/2h5IKztZsrGnkivfY1aGTJ1Pk4IHIOO1J+cg=;
 b=LmZxJUG9bQMY7mPpswWOVdIMtNqfYm2enIq23tV0D95oqwWdSUZdtJwee/uTcbNjWaVNxUBDyFmWckcwvKuHx6441TlaqzS4XTqSLnXpxiwat1J6t9pa98aO+TV9JgN++IUjNSMEB44yLS/aSdZ13SUzg9u9eSHOL2E/F9B55lmoLhpY8MZelSktnZEbtSnOAITOnMxxAM7S4GoI6SxXM+ughTP0JBH/95/2RiL/7Dj3Cb7FO66gQ9NXbU2Q4vEPA16lFsehD8PxNjoLhD/iTa79oD4IyPrEZE+yycCfsdmfXExlV7ejLx6NFmbz1/oIVpk7Ows3VE0VZp3/ONo31Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWvKIo/2h5IKztZsrGnkivfY1aGTJ1Pk4IHIOO1J+cg=;
 b=c2RhhMjxirL20nQ47Y8+DvwBvNsGF6wKV4987TMf7KjIhG5ai+0hJJuUGBiirsHCURz2RqxACGEOwR05bD2jhA6jt4RDgeqMIp0nPWVAgF2MJr9ZXVvkbGOA8+aXA8hFLhDCpXWHXvc02x9GCaQEgn56IuzJHdR2aWS8mIwvNcM=
Received: from DU2PR04MB9020.eurprd04.prod.outlook.com (2603:10a6:10:2e3::9)
 by DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Tue, 2 Nov
 2021 07:45:51 +0000
Received: from DU2PR04MB9020.eurprd04.prod.outlook.com
 ([fe80::f194:b056:4b35:7f8c]) by DU2PR04MB9020.eurprd04.prod.outlook.com
 ([fe80::f194:b056:4b35:7f8c%5]) with mapi id 15.20.4649.020; Tue, 2 Nov 2021
 07:45:51 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH V2] clk: imx: gate off peripheral clock slice
Thread-Topic: [PATCH V2] clk: imx: gate off peripheral clock slice
Thread-Index: AQHXyZbJTu0qvS4PsEKRIZ0lnqI4Q6vjntiAgAaXQoCABbGzkA==
Date:   Tue, 2 Nov 2021 07:45:50 +0000
Message-ID: <DU2PR04MB90209DF8A713D81E4200B171888B9@DU2PR04MB9020.eurprd04.prod.outlook.com>
References: <20211025122902.1151-1-peng.fan@oss.nxp.com>
 <YXaeOa9CsT3cd/u+@ryzen>
 <d3fd4bdf-6e3d-7752-dcc2-293fc5e6f469@pengutronix.de>
In-Reply-To: <d3fd4bdf-6e3d-7752-dcc2-293fc5e6f469@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7912f78-0692-4dec-1ab8-08d99dd4cad7
x-ms-traffictypediagnostic: DU2PR04MB8567:
x-microsoft-antispam-prvs: <DU2PR04MB8567202D916A40156A98FECC888B9@DU2PR04MB8567.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C22jRmB3/E5ds4GYEx7xXFjUPMEOIPzk7qQqey52TIXmmCXTo0fFhnUMAWpYEAbC0/w4kh7uLWua37oY8zJe48GW4rzmJhlOnJrLYZm2E6TcliUUTJ1aRcqF/aTX6uKxdFguIwYU0pmr1TVZodz79khqJs3Oe54h/YE+HEoqCBRppYoMDM/IYbrRkZFg3ID6Qoz1LyZJQo5dv0izCjiqJNT+po3IIU5R0kE3RiDgO89dCH0EVLCGmcVohA8nIsKXYlAFJmE+C4wYKwfTRjmrrX70ssSEe/4aC1hrFt/dkKEaQFHLK8/VW80FmGvQGrIqZ/6jbj8HyonCma4ZvFx8UZGru7U+gFzXxWr71lsbNVKKdJRrsLhtX6OCVgH/lo/T/Jm6hAzg7iZxqZwYRx64k+3StoEuVsTC5QFxnckdGAtPH2TTmdo0YBzJRUkd9HOt644ZAnrsQlbZ9CUJw2m+RVUb0uX25nwh8lfLDxaNDvr+DT3xTy+FpvbZTqvzVSumraBTlQijFCUhOYmZvwbnwR6AGvH7HZUAEENjhRmDvz+38XYrbQMUzfC9S41vE40/WPv0mZ5vhe30+qz9U1ynW3UPg0k2DUy43D1KDYuf8+4iPbZvzQ4UJJqq9pngcLZMfo8JM4XJqx1aywFG+U1TcJ387zaWzLe/zM61mYidnJEcpUHRc8tZTcPGwdI0wduzDfOojxIB4PFAN7y/ILn5OtZjiyqtS/58E68kswo2l3Bd9OVAgBmd0wmMaue0odOki6wITlgnnOt42Gqe6VJiuAAZMqASY6pY+5Zg7sR94AE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9020.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(52536014)(38070700005)(508600001)(71200400001)(8676002)(8936002)(4326008)(44832011)(966005)(45080400002)(26005)(186003)(55016002)(316002)(122000001)(66946007)(86362001)(76116006)(83380400001)(2906002)(7696005)(53546011)(54906003)(110136005)(64756008)(66476007)(66556008)(38100700002)(66446008)(33656002)(6506007)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8bTS5414ozk3BSHThR61YZ3AIYIadwpChEPTB8qwgnBsFdRQnnkeUIEDoX+2?=
 =?us-ascii?Q?AGuuMwRxtA9XnpV4pR0X2+3PIvNPLVgClJ/py2O/QFrOcjYCWx2eDgFfhXBx?=
 =?us-ascii?Q?6m+TFk7NFNAuqGKofFIwkQQihKMqqR5ajFiR7pG6YWC0bqtBmPdSpcetTZrX?=
 =?us-ascii?Q?9iHMSsGraNyh5pO9NZcAsO+P6GEw2zj6PL6CHtMsVIekpl0O576Qe75+oHmq?=
 =?us-ascii?Q?TP43pnjXBtvTJrhfYyWmZ7WGeaiJqpkJ7se0gSZznrPG9iUM450BLDC/OhKu?=
 =?us-ascii?Q?hK3CH2Kj7YzRk18Ld0rE9wAN0S9GRcYvWfU609XV+7B0XsQPb+b025C2KYfE?=
 =?us-ascii?Q?1JyYo5IKDTtzDCIFRV6ZTpHnOzrYlF0YW508YiVWR6Ndf4WHFZAu29rgRg2E?=
 =?us-ascii?Q?y+fFAViSXH7sLZaWpecPXmQ6zySAQ0AsT8822OpmP/pvJB8KftA3WMgC9r0u?=
 =?us-ascii?Q?ye3GC80YY6aXThbLBgaSP78LNnDxXXH4EosmG2KMEsS24EOWP2NH96UCsI6i?=
 =?us-ascii?Q?Rvh4t3KoafASFe5CyDVv3VTMfUOs7awcnbshDghi/6DyMBe/C2CE/7Y0iOLC?=
 =?us-ascii?Q?IHZ1w9wacJQwQofyL9ZAkyPX2/xl9gqiW3Ebzu5GfWFeR8/2pDJ15yKtwowE?=
 =?us-ascii?Q?1IgHuvxYvMqyuDMZZA7EmHhLPUy9CESsIvrQSzpBlN8gdmXBWQBP6JsdwWGV?=
 =?us-ascii?Q?4pphwMbmuxUVmTGOICCtFMNXScCANICzdxy3FoDlD537nkmUakwMiLHXcvlL?=
 =?us-ascii?Q?oNb6BH9pxbd6KMb3X951hGdthLSWciKi2yYHjg9b3lTBXZ7ubEaLI79iCRTb?=
 =?us-ascii?Q?SsFDaBbkuH0pXnev1GkSSQGQV3I6Q6WurqZZyOBxliEu3kGqQ/ZlVtIFJvkm?=
 =?us-ascii?Q?0WiUvkXwh9xVy2Wdf7uj004/VYtaEtlhuRtvDkDdVsSg0g6Xua0XHIs1ys1H?=
 =?us-ascii?Q?bSl2DmWgnc2mw5tNJIOD5ZtCjnV9w92zUlSlVUZ0ypW9+Otelru7LCRU0wAc?=
 =?us-ascii?Q?DKABTw5vJJXkxsKa2WAknwzAxGdAw3wxLP/nDSZ15V13VXLmbRflxGreuiDn?=
 =?us-ascii?Q?A048zY2SlTUh356RzFyBKM6+hSXkHFlpeCZ84WO+3hGHZTnCkGzr//jSfIl2?=
 =?us-ascii?Q?fPRNJYyoSJzOaxroj/tR4XIjQ0VP4AFk4OcAbGJ1jhl4THYEAL7i1KFv4Qne?=
 =?us-ascii?Q?H3EJ36m8pXD0CXZlh57SPwyzsGmv9BITStz+xt7pxCkYzVzCkX+NntDo465t?=
 =?us-ascii?Q?s6LGw5hpDDmGziXCXfWnTqg5S9RC2g6L3Bj/StM21AnFGPrRd+KRFcjI1ALI?=
 =?us-ascii?Q?GZv2nCBmDcXbA+OsDirzvmTGZwf/tb0BrC1Kh3PKbQag6AQF2Skyz1gd9JBG?=
 =?us-ascii?Q?g/3SgA/ac05CCVVmuOtKUXL120NcebbsfYcTj/xcD6xzZFde6CM2TMUnep24?=
 =?us-ascii?Q?FBNk2DNJpQ/U8iqAmBN9qCpUW9a07d6WuGQlbJilsWyV+038YZuY0l80sYop?=
 =?us-ascii?Q?njUqvZByno6kN6VNciy8phQh8rnkac2LqlQMAX/2T7/DKw3qf6rOXNpbnDeI?=
 =?us-ascii?Q?c7N2yPyYSyTlSnfvmvAD7+I6vIQfE7E8r7QGgtL9yher5J4MLqdmspJMnOKh?=
 =?us-ascii?Q?hQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9020.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7912f78-0692-4dec-1ab8-08d99dd4cad7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2021 07:45:51.0740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x/u6u7uUZsCXxygRkMr9j8WLKHSOhu5+Wnp+vWFMugHkIsQmBJgMDMftQPGwlV08gNjjStFo8py25rDe2kKekw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8567
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V2] clk: imx: gate off peripheral clock slice
>=20
> Hello Peng, Abel,
>=20
> On 25.10.21 14:08, Abel Vesa wrote:
> > On 21-10-25 20:29:02, Peng Fan (OSS) wrote:
> >> From: Peng Fan <peng.fan@nxp.com>
> >>
> >> The Peripheral clocks are default enabled when SoC power on, and
> >> bootloader not gate off the clocks when booting Linux Kernel.
> >>
> >> So Linux Kernel is not aware the peripheral clocks are enabled and
> >> still take them as disabled because of enable count is zero.
> >>
> >> Then Peripheral clock's source without clock gated off could be
> >> changed when have assigned-parents in device tree
> >>
> >> However, per i.MX8M* reference mannual, "Peripheral clock slices must
> >> be stopped to change the clock source", so need to gate off the the
> >> peripheral clock when registering the clocks to avoid glitch.
> >>
> >> Tested boot on i.MX8MM/P-EVK board
>=20
> I just noticed this breaks earlycon on an i.MX8MN, I assume because the
> earlycon driver will access unclocked registers.
>=20
> On the i.MX8MN, I also noticed that disabling usb_phy_ref hangs the syste=
m,
> whether via sysfs or via this patch. Still trying to figure that one out.


This patch indeed breaks earlycon, need to think out how to fix this.
But I am still not sure why usb_phy_ref matters here.

Thanks,
Peng.

>=20
> Cheers,
> Ahmad
>=20
> >> Fixes: d3ff9728134e ("clk: imx: Add imx composite clock")
> >> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> >> ---
> >>
> >> V2:
> >>  Add Fixes tag
> >>
> >>  drivers/clk/imx/clk-composite-8m.c | 9 ++++++++-
> >>  1 file changed, 8 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/clk/imx/clk-composite-8m.c
> >> b/drivers/clk/imx/clk-composite-8m.c
> >> index 2dfd6149e528..ee41fbf90589 100644
> >> --- a/drivers/clk/imx/clk-composite-8m.c
> >> +++ b/drivers/clk/imx/clk-composite-8m.c
> >> @@ -184,6 +184,7 @@ struct clk_hw *__imx8m_clk_hw_composite(const
> char *name,
> >>  	struct clk_mux *mux =3D NULL;
> >>  	const struct clk_ops *divider_ops;
> >>  	const struct clk_ops *mux_ops;
> >> +	u32 val;
> >>
> >>  	mux =3D kzalloc(sizeof(*mux), GFP_KERNEL);
> >>  	if (!mux)
> >> @@ -216,8 +217,14 @@ struct clk_hw
> *__imx8m_clk_hw_composite(const char *name,
> >>  		div->width =3D PCG_PREDIV_WIDTH;
> >>  		divider_ops =3D &imx8m_clk_composite_divider_ops;
> >>  		mux_ops =3D &clk_mux_ops;
> >> -		if (!(composite_flags & IMX_COMPOSITE_FW_MANAGED))
> >> +		if (!(composite_flags & IMX_COMPOSITE_FW_MANAGED)) {
> >>  			flags |=3D CLK_SET_PARENT_GATE;
> >> +			if (!(flags & CLK_IS_CRITICAL)) {
> >> +				val =3D readl(reg);
> >> +				val &=3D ~BIT(PCG_CGC_SHIFT);
> >> +				writel(val, reg);
> >> +			}
> >> +		}
> >
> > Though I'm usually against special cases like this one. I think the
> > clock core needs some generic flag that would read the state from HW
> > on probe and/or another generic flag for disabling on probe.
> >
> > But for now, I'm OK with this:
> >
> > Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
> >
> >>  	}
> >>
> >>  	div->lock =3D &imx_ccm_lock;
> >> --
> >> 2.30.0
> >>
> >
> >
>=20
>=20
> --
> Pengutronix e.K.                           |
> |
> Steuerwalder Str. 21                       |
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.p
> engutronix.de%2F&amp;data=3D04%7C01%7Cpeng.fan%40nxp.com%7C626714
> cd2773448a4c0608d99afbc80d%7C686ea1d3bc2b4c6fa92cd99c5c301635%7
> C0%7C0%7C637711228448591454%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C10
> 00&amp;sdata=3D235%2BBGnDLUAIorqGKVVt%2BUKlSAf5jT68wq2s5FMDolY%
> 3D&amp;reserved=3D0  |
> 31137 Hildesheim, Germany                  | Phone:
> +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:
> +49-5121-206917-5555 |
