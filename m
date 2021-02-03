Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD0C30DD1C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbhBCOmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:42:53 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:3636 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232817AbhBCOmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:42:37 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 113EeicJ021166;
        Wed, 3 Feb 2021 06:41:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0220;
 bh=AjiAwLYFEgKGJMYcOVvrfUoO41EuCAaFPLLz2vzFEqs=;
 b=f47Bfnv0qc/HlLW1wdiuhY9qoTNQs3S3v/ggXg5ZfRGQG8O61cUA/UDXmtKlvqoiWdlj
 Z8O4ATR57HKW4t7lefjoB0y+8ha+EjciEYRthThFYaafaVfSrI1+2bHyhEi1T0EzKtSk
 Ixa985F7jwRmuH5Ezr7lSks8ve2ZNo9CMQZzbx7QmjLDzqbEHcS+ntkzIUzclDe1lMg+
 CLdNPoBrEpjeRJbwqgL9YjHtZToXeUPtf82BSh6HDxoucGyJoBa+FJBHn+IJs38BcSGd
 zxiGF5icsjIJkM7LpPlbr6gYI2pQBWiqOjv0Zla6tGz2F6VOkAatjGH2s/Qt7E9eYmUA Ow== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 36d5pt3g5q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 Feb 2021 06:41:46 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 3 Feb
 2021 06:41:44 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 3 Feb
 2021 06:41:43 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by DC5-EXCH02.marvell.com (10.69.176.39) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 3 Feb 2021 06:41:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxHZC2+4N1G4Ax61FJtkvZpowS3gk7WjEOiph1czwmLg8DwbkHeZ0rZew1daD09V61XWkQsRkr+ZNWG2XdKM4IFziOo6+gdFHphGNBuOV06prq3VrONp3BcPe2giTzrKduUubaVjbkvAPylJ9gOUMUIq2zUxRA8Fc+DBodHR5ZJS0s7gAFwXPMHaFDnZQeeLVXBj1pDDtoMNSqPvwvOq5PgaYOVakU33J5024WHVjsZTYGsp29x5z87mA72JKxJgSA9a/m8/hR3y+99OqCjhU9bVdmgrbNEnNv97QYUFWyovvml8HPHKOSfendOGeKQPBF4cm4u8A0wcMJ4Mwks+Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjiAwLYFEgKGJMYcOVvrfUoO41EuCAaFPLLz2vzFEqs=;
 b=L9i0drFej5i09jF0J1smyZhkgqvcEGGLDEPY0nyoy6rn5ew9wDFvA6VJWwXuHCpd/i7EFrX0N1Wyp9uP1cEYCQOOZ0cX3c5vtaeU5nj6PAaO3IoucxvSE97Gdpv7IrJRtNr+eAPkCZtqnI9aai5qTCwOV42Vn2q3fWfYe0P6skcTHbh2bW8yNyGkCFosty3WT9YOCcVHYR+xvYE74aLDq2CL8QjFAORHcQOMPXXRl3BiDIeTBK0F0kzpJ0z/rHMNdGBDLANw1W4Qnfw00lA7ywbTnOTsgu89OhYE2KmIKnxwobw9r7uZ3DgZKx+yYTGtxWaVcypibjR7GwgyIdc49w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjiAwLYFEgKGJMYcOVvrfUoO41EuCAaFPLLz2vzFEqs=;
 b=tVpc+7FXdupHOytH6QSgiFpnTaAUAK3QhDkKSCSEAJtj7RjokVlmJlP5bhxwnulOGoLARhIwoNKaUejWCZsLOES3PfyKTHLg9SzT9gWHiVXdykOe/LYOMuBPxaxoQYmRn592ARzyUJl/9sqoSo8VVnaQ7w3QQ1ucKsJt/FwxzLo=
Received: from DM5PR18MB1452.namprd18.prod.outlook.com (2603:10b6:3:be::12) by
 DM5PR18MB2263.namprd18.prod.outlook.com (2603:10b6:4:b1::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.19; Wed, 3 Feb 2021 14:41:41 +0000
Received: from DM5PR18MB1452.namprd18.prod.outlook.com
 ([fe80::e8a9:1188:a4f8:8a57]) by DM5PR18MB1452.namprd18.prod.outlook.com
 ([fe80::e8a9:1188:a4f8:8a57%4]) with mapi id 15.20.3805.027; Wed, 3 Feb 2021
 14:41:41 +0000
From:   Kostya Porotchkin <kostap@marvell.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "mw@semihalf.com" <mw@semihalf.com>,
        "jaz@semihalf.com" <jaz@semihalf.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Stefan Chulski <stefanc@marvell.com>,
        "Ben Peled" <bpeled@marvell.com>
Subject: RE: [EXT] Re: [PATCH 03/11] dts: mvebu: Add pin control definitions
 for SDIO interafce
Thread-Topic: [EXT] Re: [PATCH 03/11] dts: mvebu: Add pin control definitions
 for SDIO interafce
Thread-Index: AQHW+jEKQCswtMtvs0m9H80l6I30SKpGfTAAgAADanA=
Date:   Wed, 3 Feb 2021 14:41:41 +0000
Message-ID: <DM5PR18MB145298C7C6CB673A6B4B5038CAB49@DM5PR18MB1452.namprd18.prod.outlook.com>
References: <20210203133138.10754-1-kostap@marvell.com>
 <20210203133138.10754-4-kostap@marvell.com>
 <20210203142806.GQ1463@shell.armlinux.org.uk>
In-Reply-To: <20210203142806.GQ1463@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: armlinux.org.uk; dkim=none (message not signed)
 header.d=none;armlinux.org.uk; dmarc=none action=none
 header.from=marvell.com;
x-originating-ip: [77.137.153.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da2beb03-11d6-4fcf-252f-08d8c851d252
x-ms-traffictypediagnostic: DM5PR18MB2263:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR18MB22636634117E8B0BB819F146CAB49@DM5PR18MB2263.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lch8Lpwvp/n9st//m0DEXxf2Glp3j4lJX1ej1w5XgmWmPCYcigdV+s50IDXMPlAXKSG1tWZhDwcWED4J6ZkLC0G+4Z/uH+D3PzF3tEUMStM33LuolPxZIeMsinQVlrCziDN+hdxqpI5RdpLDaOTzwagOx/MRR0Qr8ZCKQzAWExpCBuWw5BYz2cpi8Zc+knrgL1ChqAC3PzuXWVPy9118g5/dL3Wy50yt193hrw3GkHT5Kim1sPWx/lmcQngV1T686YSMeH7L8zVWpl5fL83Dx2iRxLUXN8GpAp0TJSZxoYqQJymySaUmE6V0silQa1oGJDUNL4D4QPsOZKf/56IIoe2+hud29SOuedABB2bOtymGGBlVmDpKUNHzxN71UG0gDVYT5HzFnQKghDV+Ej/xyVw1SftwXJw1Erx+lJ4DfzfxIUjn54fqzfR+4SipDk5W3h7uQf/cw6T5yTGt7P5rbjZFXZv9aFCIfisSm/Jgqrv6RQ70r3xiFtso3M1o2trm02ayY3FVud2LnVze3mzB7AD4a6g6n1dADIgDN0lCNrFDCcyXjxLd4WANkMmZPO7GeYw3jQBPnzJ51LzHDNV+2hUpEpDeBDozsmHCCnrG2NQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR18MB1452.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(186003)(6916009)(53546011)(8936002)(26005)(107886003)(64756008)(33656002)(966005)(76116006)(19627235002)(66476007)(54906003)(66446008)(8676002)(7416002)(66556008)(478600001)(4326008)(66946007)(9686003)(52536014)(83380400001)(316002)(86362001)(2906002)(55016002)(5660300002)(6506007)(7696005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?1PSDwICLhLwH7u5W+IbEukAhJvYbgpkifnxO16pYEsC8c8Ygi+64j3y7cwOa?=
 =?us-ascii?Q?gMOFi/bOxN9xBYjFl58+onJ3KtJCvqFDkOv9Yh/BfgfOZcR+UJ8vRvtgty1u?=
 =?us-ascii?Q?Bh6TFJftXRrsqoVA8RfRU5fhnmgPZZ9plYjEnV5bC0XMz2HpIeQKBhsvjz0N?=
 =?us-ascii?Q?zdMiCMGPQQWryxunRWV8C/f9JpLHTM2K06+E6ZSH8TIT7Y1GpfOBFstZqjyR?=
 =?us-ascii?Q?nTztnygwzaRq7EplA/rbIzDXEq7yUXLGLye//6LRIA0ZKOhuwNyE/KM/jH65?=
 =?us-ascii?Q?H4laHe/lOgtUngN+kwvAyTfnoMf3392II9JrcJIlSlz4cwSUPi10OBVwddNa?=
 =?us-ascii?Q?PGr+Ao7iLOKcICRC2w6yh55jDcwZkNBej4CE+CZGgDWmupNY7hFiKXFO9y5Y?=
 =?us-ascii?Q?xoB4/psfQvcgyyv3ET++PSEfRe9sAd88XyHj8ZXQImtLbBaub7pAUXodpZ2l?=
 =?us-ascii?Q?BnILyLWKx/DOKS2sVDztmcoJrmvYpK5JAYzX6vdwjc1Eee5c+1TZGyQna+en?=
 =?us-ascii?Q?IkV7wVuJGc+iIGtRSDKOISO7gTqrCqDeBR5rTXDcyg8Q0ILqRQHIujIhV7c4?=
 =?us-ascii?Q?eoq7gZ8jRXtf9hYWSUGizHHuF4v4b2PKanYc5q6E7Sm6o3ttRn53itfIlPau?=
 =?us-ascii?Q?MugTWvXhMGjMcefDG50khKsT2Twa5s7wldTWTYvzZRhlRMti1uedwQ0Uvw4M?=
 =?us-ascii?Q?BjtsuZp3Wbf08xg0wX0W4j3BT+sEXpkkOuTIW7aSlcfNyPIlkYtg97HMNRFA?=
 =?us-ascii?Q?Y1yqla/bTpT3JpGye/ANgMxCNa7SwFFQ4Z1gUZjL947+t2OcaFKe0F56MTuu?=
 =?us-ascii?Q?An/ioU3rAM/jHHgAGT9P3z4n0eF6D/s2zniCPKOFcfVF/Dx6td6kbD0Mt7xK?=
 =?us-ascii?Q?phEEXP5AbVKEC5EbLe04k6Rk9KeM6dKVXTPXSlMPDfnTggzZl9u3DQnPo6xE?=
 =?us-ascii?Q?Y51EkFlszdJ6M3sq/ck4y0RUjfCvKJsv/3Wgk0dLYgl0PTaMHhFbVcAn5dEC?=
 =?us-ascii?Q?H6asGVvTdxnq7vbEMGHgjrZXHu8VhBLnysIlodTMUC3LORJ//T6qmKWFB5jG?=
 =?us-ascii?Q?MO3ougaB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR18MB1452.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da2beb03-11d6-4fcf-252f-08d8c851d252
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2021 14:41:41.7810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eC2UThP/qAufnxBbsHiZ2PDMhKu/d6kbaQsm3E0Y6I/WDZfWOmShLiGVp43WIa1sVfsyw6GKntcjNTV6eiAarg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR18MB2263
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-03_06:2021-02-03,2021-02-03 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hu, Russel,

> -----Original Message-----
> From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
> Sent: Wednesday, February 3, 2021 16:28
> To: Kostya Porotchkin <kostap@marvell.com>
> Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; robh+dt@kernel.org;
> sebastian.hesselbarth@gmail.com; gregory.clement@bootlin.com;
> andrew@lunn.ch; mw@semihalf.com; jaz@semihalf.com; Nadav Haklai
> <nadavh@marvell.com>; Stefan Chulski <stefanc@marvell.com>; Ben Peled
> <bpeled@marvell.com>
> Subject: [EXT] Re: [PATCH 03/11] dts: mvebu: Add pin control definitions =
for
> SDIO interafce
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On Wed, Feb 03, 2021 at 03:31:30PM +0200, kostap@marvell.com wrote:
> > From: Konstantin Porotchkin <kostap@marvell.com>
> >
> > Add SDIO mode pin control configration for CP0 on A8K DB.
> >
> > Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
> > ---
> >  arch/arm64/boot/dts/marvell/armada-70x0.dtsi | 6 ++++++
> > arch/arm64/boot/dts/marvell/armada-80x0.dtsi | 6 ++++++
> >  2 files changed, 12 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/marvell/armada-70x0.dtsi
> > b/arch/arm64/boot/dts/marvell/armada-70x0.dtsi
> > index 293403a1a333..179218774ba9 100644
> > --- a/arch/arm64/boot/dts/marvell/armada-70x0.dtsi
> > +++ b/arch/arm64/boot/dts/marvell/armada-70x0.dtsi
> > @@ -47,6 +47,12 @@
> >  	cp0_pinctrl: pinctrl {
> >  		compatible =3D "marvell,armada-7k-pinctrl";
> >
> > +		sdhci_pins: sdhi-pins {
>=20
> sdhi-pins ?
>=20
[KP] You mean to replace the underline with dash?
Will do it in the next version, no problem.

> > +			marvell,pins =3D "mpp56", "mpp57", "mpp58",
> > +				       "mpp59", "mpp60", "mpp61", "mpp62";
> > +			marvell,function =3D "sdio";
> > +		};
> > +
> >  		nand_pins: nand-pins {
> >  			marvell,pins =3D
> >  			"mpp15", "mpp16", "mpp17", "mpp18", diff --git
> > a/arch/arm64/boot/dts/marvell/armada-80x0.dtsi
> > b/arch/arm64/boot/dts/marvell/armada-80x0.dtsi
> > index ee67c70bf02e..64100ae204da 100644
> > --- a/arch/arm64/boot/dts/marvell/armada-80x0.dtsi
> > +++ b/arch/arm64/boot/dts/marvell/armada-80x0.dtsi
> > @@ -70,6 +70,12 @@
> >  &cp0_syscon0 {
> >  	cp0_pinctrl: pinctrl {
> >  		compatible =3D "marvell,armada-8k-cpm-pinctrl";
> > +
> > +		sdhci_pins: sdhi-pins {
>=20
> sdhi-pins ?
>=20
> > +			marvell,pins =3D "mpp56", "mpp57", "mpp58",
> > +				       "mpp59", "mpp60", "mpp61", "mpp62";
> > +			marvell,function =3D "sdio";
> > +		};
> >  	};
> >  };
> >
> > --
> > 2.17.1
> >
> >
>=20
> --
> RMK's Patch system: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__www.armlinux.org.uk_developer_patches_&d=3DDwIBAg&c=3DnKjWec2b6R0
> mOyPaz7xtfQ&r=3D-
> N9sN4p5NSr0JGQoQ_2UCOgAqajG99W1EbSOww0WU8o&m=3DwUA0mnqioCngi
> HLZcn2iOBuiWLQtawWb1yfozx_80C4&s=3D_yolpLSRiJi4CnA-
> iEzpbF5r77VBdLcM6pouXxTdupk&e=3D
> FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
