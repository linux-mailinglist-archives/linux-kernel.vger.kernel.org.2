Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCDDC330306
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 17:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbhCGQiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 11:38:03 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:28866 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231314AbhCGQhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 11:37:53 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 127GXi3f007835;
        Sun, 7 Mar 2021 08:37:35 -0800
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2048.outbound.protection.outlook.com [104.47.73.48])
        by mx0b-0016f401.pphosted.com with ESMTP id 374drqsr6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 07 Mar 2021 08:37:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OARZ0Lby/8vulUdWZLRK7RsAXfQ/7Uy5XhT84Y+BmNdS576KcSGAcg6jioshImQZeInKTuhY+BOS37c0h9KbXCBAEYo5vsAGcKNtAVkzi20alnjqybxCXIkesg9x0jVrOUUftp2Vva+ub1R60mLjQ4D1dVG8L8cdHcf+c3RNRGS4oviDrFXDA36mvMeGifvY0jlLVeAeuDgAJ6GpxzU7DzcExork6PBeuibGVSmMDf3+QZnYvHvcu9yXfU9VlraCqgAx7MuavFLj0tc2VZVhG+Pby12BlouHcED27ox68oNEhxmjAZqXUbLxcpTSrzisGj0D1eRJs0VSp5fFx8tFHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bo4eLyVR/yl8d+2b5V5HnakGRkGC56k3OaD3k3jg7Rw=;
 b=PTKF3c5IF6a3YOrhNC8hcBW+jKCO/K1SJIwDxP6hBieDmu1tS6oqxeKt0EtAxyL1oLZ5Om5YmQwAoueS18Iz380vyQGgSMk3XwbBqc/m8vVXdvIGsNwS71//iniyjFg/bBwe0cep8sUL+47lnt//ZgLy+C648G+VJht4A2WktmY4NN5NTMdUXIxNhcbPRssLTCKPk0CVPNqdHw8mGQhYDD/9qxjlDwG1I0+5RSvEFm28aZq/y0TbocFPXIASiKmS3eCbU7TeNT0wDC4MAEnNzemUYbpUY+mSrNGtV6iNCUJAZR8mSZG6PWlvx6yTKAI73t9vucGDGT+gb5cNEzJlLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bo4eLyVR/yl8d+2b5V5HnakGRkGC56k3OaD3k3jg7Rw=;
 b=YCtnUOuFCR8pckulroKQZZo86IJe/JN8M2ekJ041uwlyHy2Y7w9UKNj/FgEWGkrTQP+tO2w4T7fWs+N18n9zvZxG7NkZFE1APC4VPPVbdsgSs+VmIJaNGkOQfeacGFn/xE7l9Xam417hBeTHIorVMlcOD1zxQrI7cdsZCIbVnCI=
Received: from DM5PR18MB1452.namprd18.prod.outlook.com (2603:10b6:3:be::12) by
 DM6PR18MB3633.namprd18.prod.outlook.com (2603:10b6:5:2ae::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17; Sun, 7 Mar 2021 16:37:33 +0000
Received: from DM5PR18MB1452.namprd18.prod.outlook.com
 ([fe80::e8a9:1188:a4f8:8a57]) by DM5PR18MB1452.namprd18.prod.outlook.com
 ([fe80::e8a9:1188:a4f8:8a57%4]) with mapi id 15.20.3890.037; Sun, 7 Mar 2021
 16:37:33 +0000
From:   Kostya Porotchkin <kostap@marvell.com>
To:     Kostya Porotchkin <kostap@marvell.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "lkundrak@v3.sk" <lkundrak@v3.sk>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "mw@semihalf.com" <mw@semihalf.com>,
        "jaz@semihalf.com" <jaz@semihalf.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Stefan Chulski <stefanc@marvell.com>,
        Ben Peled <bpeled@marvell.com>
Subject: RE: [PATCH v3 4/5] arch/arm64: dts: add support for Marvell CP110
 UTMI driver
Thread-Topic: [PATCH v3 4/5] arch/arm64: dts: add support for Marvell CP110
 UTMI driver
Thread-Index: AQHXE2+86UnJSQ1EJkq5hcY/LyZyCqp4uTyg
Date:   Sun, 7 Mar 2021 16:37:32 +0000
Message-ID: <DM5PR18MB14528454C7C64943B1C1573FCA949@DM5PR18MB1452.namprd18.prod.outlook.com>
References: <20210307163343.25684-1-kostap@marvell.com>
 <20210307163343.25684-6-kostap@marvell.com>
In-Reply-To: <20210307163343.25684-6-kostap@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [5.29.55.143]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f955afeb-f4f1-4113-39d2-08d8e1874ebd
x-ms-traffictypediagnostic: DM6PR18MB3633:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR18MB3633F4A32DE77FD3A3FDF7BDCA949@DM6PR18MB3633.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YhZY4M4LKdwTkDnrQhEsEeMNXZvhtvTSRizHJkM6Uksaoe9zyV5h08OCDeBymLIRzP2UpqbHa2xmnCIa4u3TeU71yQKuKUcATVEBi2KZuNr6Gd6YsAz4IezezFwOmXtyMPuxmR3D8QsXfgv6fbJbRia3VAmO8f4gC+n1XW/2b+thyzcPK+vgKM2c+WYXR4S5GaTwTMVtWWKobPaKKUzNwSmMr/4DHvrVcej4wFXJkseKvw7KTuTT2hTr5qEFkVpVuiSiWRSWA5/ZNOHtd3gI086pey7RY41Qmw/FKPUiPKv/xZrLJ4vzMiN/y+jL/TMxcXER9q8F2eytVVMhaniMb3ESiovifrEpUs5xQbB+1D1T15wXaYDIZGlIkWYKmPkvlBd0aqYZaVTEzQtzz8//ws0RWGKF8Dy+NECW1+DpEK11mc7fxTNCyjsFcXQouQ0j28VRIL88uJNXoBFIpSGGfFVTjwKfKmbAsbvC7SlkOD6nEHxnBa0ZQnoIMcdSstlKY+6vM9clxKCR0XIVLYd0Eg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR18MB1452.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(39850400004)(136003)(376002)(26005)(66476007)(66946007)(54906003)(76116006)(2906002)(71200400001)(66556008)(107886003)(8936002)(53546011)(64756008)(66446008)(6506007)(186003)(4326008)(55016002)(83380400001)(478600001)(8676002)(86362001)(5660300002)(9686003)(7696005)(110136005)(316002)(33656002)(52536014)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?1SDzqD7Wjj1hd3wZxiXRF1b0T+0xq3BCdjX0OrDcX/QRF5YQfscsno71GY23?=
 =?us-ascii?Q?ZEPcnDxwnP17xzuHAh2jGgLqixfhZIM3/OnMlIn3kSQ4sDWwpdvO0LojISE9?=
 =?us-ascii?Q?7S4SDaVCpGH4AU4VHJMV0zx/0yCtVgAgEuGWdvXPpBdx553jbun3LyGfkDA9?=
 =?us-ascii?Q?y9OqadnlYRUPgcety7utVMK4E1RUQvBI00nI+yAgCZBy1YUxHHZSKK4mzHTt?=
 =?us-ascii?Q?JGSTfevN5Hb7bzl9bsbMyU21RPN1CJcKVIvt/ii4Lp3IyR1B42CV2yNnnAL+?=
 =?us-ascii?Q?MxrntpHUx/hF/2gglob6Px77sf+6Y09a9cmzEZZHbqSEt0wd2hhsR4uBOA9V?=
 =?us-ascii?Q?vJP9zJBNnluFnYlwyoPoJlRseDonpLciP4eJ2x4YpJvbcL3Eb7PmPgzHz9/1?=
 =?us-ascii?Q?Z9O9sQlE93KokN2TxVngAQWIXyV9wx8EUvACm4grS00cRl0qm8PUSeT7DYP+?=
 =?us-ascii?Q?KUncOIHjVMPktouabWGahp13FYLNlA0hRKHsGxwWheVc980joxLQEb+6GPaN?=
 =?us-ascii?Q?oLVMuDQe/53NFwah2YqD52JH1+F5U9Dd+PQ/ch/t1WykToUuLOIel6QaYVn7?=
 =?us-ascii?Q?+MaMv6xlfny19EvCzL1u+gH9byoKCdPjyVebwqPL+WpQrkiXqwyL9t5kgvU8?=
 =?us-ascii?Q?Jh1Jd1lyVpCVoh1gpnyI61q452EOBA+3r448A6YH47bVNGMOrMtJuijTh9Nb?=
 =?us-ascii?Q?4kdt8LQxQgClq72blEEaqcPX2RYHK4r+oSwaO8idP/EWrWQZwM8LF7/Rlf9N?=
 =?us-ascii?Q?Fo/Bh1l/9LL5gLfWuVj0ALE06ID3aHmPtkE/+lGxS2eqkT6HbLT3z1Igr5U5?=
 =?us-ascii?Q?s7Z40Ing/6PxdmCZAJ+e0ZUQ+CxRe6RU0jtD280OvLUOuXO4CwadDjQFmU1t?=
 =?us-ascii?Q?X7uYlWIGf6FwS9+E6N86piDiP84jPuqasRK4YJJK3l++KdiUYelV0eJcB/c4?=
 =?us-ascii?Q?P90aBmksdQbe8OptQwyJ5I8fIXI83rzNQ+a9NOR8wIQoOaEuKd26V7eqZyBK?=
 =?us-ascii?Q?hiQ56tY/6hMEmVUyhykAdfYXpvjacPqIbPUcR95j7M2na2Vb8nlqVmE4Y04g?=
 =?us-ascii?Q?MDu5lElkaLgUoMi4cylin8lCR8jFpIn6YhuLfCJnJWS4PLZuuIC/V0xrYXa2?=
 =?us-ascii?Q?g3EjcnXBnItijj67ogOOLA7+G3oo+gVhAb1zs1Lwof3N0CFlewL13+LJre/J?=
 =?us-ascii?Q?ErWwNnw6aAlPMZuUZbc9ks/cKRl2+Yg5+MuNroRG967G4v+BRSf0uCW09Cu2?=
 =?us-ascii?Q?ai9g8k3qYvTUFcuuPkYcjLO8USzEj6jloMnLxwqE2b4KZfXdmYnquOo6eLCV?=
 =?us-ascii?Q?yTI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR18MB1452.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f955afeb-f4f1-4113-39d2-08d8e1874ebd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2021 16:37:32.9174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: icmXkzys+l4uOJ3UTdujLdBHBRCwAxM/r2xMfLykkHXYmqmy0aVQqn4kM2XzS5gL+RiODbANFCESmoMwNF8V0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3633
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-07_10:2021-03-03,2021-03-07 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This one sent by mistake, please ignore it.
There is another v3 4/5 that has a correct name.
Sorry for the mess.

Kosta

> -----Original Message-----
> From: kostap@marvell.com <kostap@marvell.com>
> Sent: Sunday, March 7, 2021 18:34
> To: linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org; lin=
ux-
> kernel@vger.kernel.org
> Cc: lkundrak@v3.sk; linux@armlinux.org.uk;
> sebastian.hesselbarth@gmail.com; gregory.clement@bootlin.com;
> andrew@lunn.ch; robh+dt@kernel.org; vkoul@kernel.org; kishon@ti.com;
> miquel.raynal@bootlin.com; mw@semihalf.com; jaz@semihalf.com; Nadav
> Haklai <nadavh@marvell.com>; Stefan Chulski <stefanc@marvell.com>; Ben
> Peled <bpeled@marvell.com>; Kostya Porotchkin <kostap@marvell.com>
> Subject: [PATCH v3 4/5] arch/arm64: dts: add support for Marvell CP110 UT=
MI
> driver
>=20
> From: Konstantin Porotchkin <kostap@marvell.com>
>=20
> Add support for Marvell CP110 UTMI PHY  in a common DTSI
>=20
> Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
> ---
>  arch/arm64/boot/dts/marvell/armada-cp11x.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> index 64179a372ecf..49f9d2cd8619 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> @@ -285,6 +285,25 @@
>  			};
>  		};
>=20
> +		CP11X_LABEL(utmi): utmi@580000 {
> +			compatible =3D "marvell,cp110-utmi-phy";
> +			reg =3D <0x580000 0x2000>;
> +			marvell,system-controller =3D
> <&CP11X_LABEL(syscon0)>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			status =3D "disabled";
> +
> +			CP11X_LABEL(utmi0): usb-phy@0 {
> +				reg =3D <0>;
> +				#phy-cells =3D <0>;
> +			};
> +
> +			CP11X_LABEL(utmi1): usb-phy@1 {
> +				reg =3D <1>;
> +				#phy-cells =3D <0>;
> +			};
> +		};
> +
>  		CP11X_LABEL(usb3_0): usb@500000 {
>  			compatible =3D "marvell,armada-8k-xhci",
>  			"generic-xhci";
> --
> 2.17.1

