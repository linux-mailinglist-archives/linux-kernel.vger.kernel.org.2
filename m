Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6A344CE02
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 00:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbhKJXvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 18:51:03 -0500
Received: from mail-eopbgr80079.outbound.protection.outlook.com ([40.107.8.79]:53155
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234005AbhKJXu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 18:50:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVQldYXyXu9BHE1pXkWtbqWb8DSh8CFXiAdDyRdG66YvDIUVtyQXfCIGXUozzn6F+wmD09DFlwurTbpzDLxmdqCE/x0jFulfZyCWZlgnSCeijCzhDuidiL7Wq/FOx6h/sz692y3I3mKUDoT67NIT6PRVfTIpmr9qZR3fhpcVJm9xZq/Q2LTt3qupOTMsNB6AM+3uKkuuxrj75JcW8F0cER9GObjgekIUx/FTGp58qfGEnEcjJhDrGrPrWALNUkCJ9gpmuxGSzOreJ0WsXaYM9YUyM0JHDBJ9cty8PftAoyeG10voqvyQaE8othVWg3omaeHD0+42+my2NCZ+u+/TCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+CS9fimIoNHlWg7qPBxQh+yG+9JoTfDeJFpd1rXd0E=;
 b=d9SGK1CkOsgpibP1W+oNMaaGAeOvppIOwqQq2wTfzHFxyV3tvXJJJyoxKuP6Wj7xKuDTazk5CsMqC+FHrezOnhfBd1Rv8RKpEwhkvWEVJ70lpj4U+6R8X6kLh9363+Fi1sHwFvN+R6Saz417NfZTuBjeAp8QqLai/AG3RA6SGxBBRdoFSEIC3yqY2rz3KwR0KklPmC16ehRfNPO3h9qRsMSl1AayAINvw4skrLxyydJ1lyVrP92RFBMBc4t3nHm+5H6FLAT/e/knM99erK4OMEe//r4/9w7ZaBosuOOVaG9bcOzCoz2iXXYjWtELOe4A0DYKHOoAEoIhigRgL3cd4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+CS9fimIoNHlWg7qPBxQh+yG+9JoTfDeJFpd1rXd0E=;
 b=YpuHPbdmBwGkSwgbdf9uDtC7tDNd867QKSz98OQgOlq8LbrPi2Of+Ai8pi6v77Son7qOpEJjc6wd1jADtY3sOr8VJqhskjIeo2H4yXx24BuytXkEPGjNwTMm0EmfTvFvwoW6gefIbiH6LooNo1L72fXgb1jpx3VUmu8ni2YJ3ww=
Received: from AS8PR04MB8946.eurprd04.prod.outlook.com (2603:10a6:20b:42d::18)
 by AS8PR04MB8945.eurprd04.prod.outlook.com (2603:10a6:20b:42c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Wed, 10 Nov
 2021 23:48:07 +0000
Received: from AS8PR04MB8946.eurprd04.prod.outlook.com
 ([fe80::60be:d568:a436:894b]) by AS8PR04MB8946.eurprd04.prod.outlook.com
 ([fe80::60be:d568:a436:894b%5]) with mapi id 15.20.4690.016; Wed, 10 Nov 2021
 23:48:07 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 06/11] arm64: dts: lx2160a-qds: enable sata nodes
Thread-Topic: [PATCH 06/11] arm64: dts: lx2160a-qds: enable sata nodes
Thread-Index: AQHX1oF39+aKh0WLAkeElMuulF75a6v9bRiw
Date:   Wed, 10 Nov 2021 23:48:07 +0000
Message-ID: <AS8PR04MB8946BE5E5FD072A148EF0A808F939@AS8PR04MB8946.eurprd04.prod.outlook.com>
References: <20211110222200.6780-1-leoyang.li@nxp.com>
 <20211110222200.6780-7-leoyang.li@nxp.com>
In-Reply-To: <20211110222200.6780-7-leoyang.li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3528dbd1-5065-43a0-508e-08d9a4a48bad
x-ms-traffictypediagnostic: AS8PR04MB8945:
x-microsoft-antispam-prvs: <AS8PR04MB894555EE9DFC93B3F4C475DC8F939@AS8PR04MB8945.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:660;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +zLraCHgVopjPeFnl9pyxBq10ALkIy5vwJBWcEKsQyRkHoPeQ0ZojWhHthx+Xx7heCYEjPO51jNSS1I172220BKpw/HVBKJgNK0SIWd+sJpxpQ+SkIwIsLSPlzhKPoGrg+ArSmOpQ64qGJaRzDJfAV7ioObbzAPiyCk54Lt9afgg8GfFBz8TZn2VunLH86Xtv0j+KLfwSvoyg8jWM4NZXNQSVtrKOtN8e5iN2rCBsPciLWYDfDUy5YafLKHjN5EHdm7HKW4LB3pNLEYlHPSOlMCGiNdSyOVHNX21Z1fpC91xUmmY//jKaoAiPRlz1z5zx648aLlcg9vR4HI/D8C/dEUx+KeMci899U0MkUmJW4M28ykDk320g6K+UeLntDvlCp7yDM120eL+xaMR4HxysTqEBSa2BCu4azGVO4afugNJHSQB65wzeLJry4lKmoGVtmDgr1O/04q9ftjK72aAGXgCwB+O71kdL0ypVgRQEqEoSnakiAz2GhHMAvs5Bi3kGKqDqrYpo7fO980MwaHD8rwkPqDK0Km2BUebTg+W2MM9wHDQVsT4hKFm3PSYEAMHDAKBwIJwo/lcDCZhJ0n3J2t36ClAC7lfeeuuVkB5PkIvjX/E2jb81TtduGPS+7oihiK4O94YDtOUsAhZTsO3GNJKBX67XRT/EipB6EuPefYCUvaXriHAs/GdcndecJSFEDv44mzgAK3tdGYfTrHVGA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8946.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(66946007)(66476007)(55016002)(9686003)(66556008)(66446008)(86362001)(76116006)(2906002)(38100700002)(4326008)(508600001)(64756008)(110136005)(186003)(38070700005)(5660300002)(52536014)(83380400001)(7696005)(26005)(6506007)(122000001)(33656002)(8936002)(8676002)(71200400001)(316002)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C3sFhv88tesXFt5XkwIByT5CfcwKW49kehlHx7sjsZaUoDa1tPyPqha8pglY?=
 =?us-ascii?Q?olO6m7RgmFlDwb2EkKhWAQTl+G1cFfWFsY4sPkjK5e1W5GzqVyIWyXK7VaUg?=
 =?us-ascii?Q?QGTAhGiLkL3KYJy72xu4aj94dtk4W6yAQZ2Ea/cQGXnFrCGwN8cuxDRnOAUW?=
 =?us-ascii?Q?Zbn0GYXUe13wXgwfeut1ssSLBPsoHqB4Fv1snSl2Uck4Q5UYlgsdoWFVElR3?=
 =?us-ascii?Q?fO7zDa+XMwb5ZQ6/ejyUb7M6A8wQ/oVK32Cx4fO8mXg0muYEnMZi40mQ5/cD?=
 =?us-ascii?Q?tecz8Kv5+u/kWKw7LZlFle04hpZGwtatpbC1hRYwMLIdlpG8vk+6+LGq499b?=
 =?us-ascii?Q?Q0TZpd8R9MHcobHNSZ6jVScvBEdietFqxYYABEn0DUM0iNjAds/rqgpDIUWQ?=
 =?us-ascii?Q?WQSbCdPs5o2A5E3p4mdVpVxJ1oRCRBzTQIo2sqRPexoW2yRrIuNoiem268fi?=
 =?us-ascii?Q?YoCoZbs4mrNdQd0+wggiVeZVk0iu2YLEGZgAi5Uruxg6kjFEm1uV9+Tokq3u?=
 =?us-ascii?Q?jQ8NWF+gDqkU9mKRytFUDgiahxGpqYDwYizzUK0545SJB12OXBt+H1MAvOay?=
 =?us-ascii?Q?+iODoyPnFHTsoRZVgdd32kTSaKLXy26MHR6O6vi1cgqk6QyMvQMIJ8bgq1rx?=
 =?us-ascii?Q?b7TKeWm+GDlNPNIrxzNhXFykv3iepWq6zJCb4leQM4nItPsgoAAdtLQeDN3G?=
 =?us-ascii?Q?yZMzZ4oVJb55jt5ffNKVDOzlJRRAiPYUPdUKkwySZo0JGRU1tjiav2UrFfAM?=
 =?us-ascii?Q?dNFp1gCOqc8ysW0+uQ/wG3brSa0SuO6xAb5UJcNubLxdYEl+U7mPQ6duBe+H?=
 =?us-ascii?Q?/ZH0gMGaW6P3//GJol+zpTSzz7r+phWu9gd8CWGAd1LkqtRKWMGZLDAm/+wD?=
 =?us-ascii?Q?wPBYHQE0GW9Tp8bPKY470OA79n7viM20ezFCYD2opTr0yK4/n7uOkkWlb4Oe?=
 =?us-ascii?Q?sBsb4MZNGI/vmRh4ZSqpTqhHfH/2nDFfM0YPjN3wX5TdttfR2FTkvy5MnChV?=
 =?us-ascii?Q?kGwA+I+HoQNO1BO6Kr9DmFWjr3ikXCRk1W6y+RBVm7fkRLvllfA4+Wk193Px?=
 =?us-ascii?Q?iH3foz/4inpsgeG4O9yzvTAyZIls0GvElYLX2OQXKlP26Kf3333QL81cTC7p?=
 =?us-ascii?Q?4AhfN4E96x1spL06UcJff+nw1atIe93DRIWIX6OXsHmpuHFr1Dbyd+X9RsBx?=
 =?us-ascii?Q?R9nwNaqNRX9WSc0KYHPJmXCzV5NXjrc5Gg/VC43BDwEylq9cHrmT1xgv3C2d?=
 =?us-ascii?Q?Zb5sc81b0ckAHIg0Eof8xdz4VbvpsFzG+NAy0TJbH5rfQtRwijcUP+A37FR8?=
 =?us-ascii?Q?Kn1xmTtOukIG7OkFQLvxw7czMLqC8GrWrTDVLRlFFkx8HPXT/opY3lGG7hCn?=
 =?us-ascii?Q?x2b0cRQ+FoPocYFipfwa5YTsrBb2qPnWMrkPGiD6gVgprHR/F6tIE2KXSH5p?=
 =?us-ascii?Q?/Oah9glYrgaWnsRdGfRPnCGLRUCnLXf1XN/dcqtcYSKkEisyL5vJ9hHW+ak/?=
 =?us-ascii?Q?Dkg4SpOtmNmLVDtNYwO0uxZ1vzR11wvsJKN8IdK31fk1gdyiX++R2LJjlf/U?=
 =?us-ascii?Q?gmJ2wHUdAuR4Hd2KMQ+Fs/80eVL9C7Q7egbGXTICtODOHFE45EM58DS5B3l9?=
 =?us-ascii?Q?2Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8946.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3528dbd1-5065-43a0-508e-08d9a4a48bad
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2021 23:48:07.3484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KJwCXP/uaz4S49FufpL5GvnGfhgxrq0uaXMYwrP9RaRTpr4UnwnBSxDdYdlrh4ebadwiDEw+IXb+KmQXlhf4gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8945
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Li Yang <leoyang.li@nxp.com>
> Sent: Wednesday, November 10, 2021 4:22 PM
> To: Shawn Guo <shawnguo@kernel.org>; Rob Herring
> <robh+dt@kernel.org>; Michael Turquette <mturquette@baylibre.com>;
> Stephen Boyd <sboyd@kernel.org>
> Cc: devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; Peng Ma <peng.ma@nxp.com>; Leo Li
> <leoyang.li@nxp.com>
> Subject: [PATCH 06/11] arm64: dts: lx2160a-qds: enable sata nodes
>=20
> From: Peng Ma <peng.ma@nxp.com>
>=20
> Enables sata support on lx2160a-qds.
>=20
> Signed-off-by: Peng Ma <peng.ma@nxp.com>
> Signed-off-by: Li Yang <leoyang.li@nxp.com>

Please skip this patch.  Looks like an updated one has been merged.

> ---
>  .../arm64/boot/dts/freescale/fsl-lx2160a-qds.dts | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> index 8354af0b31e3..480520152e1a 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> @@ -191,3 +191,19 @@ &usb0 {
>  &usb1 {
>  	status =3D "okay";
>  };
> +
> +&sata0 {
> +	status =3D "okay";
> +};
> +
> +&sata1 {
> +	status =3D "okay";
> +};
> +
> +&sata2 {
> +	status =3D "okay";
> +};
> +
> +&sata3 {
> +	status =3D "okay";
> +};
> --
> 2.25.1

