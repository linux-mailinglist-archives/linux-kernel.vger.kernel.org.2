Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E87B309D5C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 16:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbhAaPQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 10:16:48 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:39060 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231899AbhAaPGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 10:06:25 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10VF0u8T005061;
        Sun, 31 Jan 2021 07:05:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0220;
 bh=5yZAb7RCJl7plHKR7rU7K/8uIsIMSJOPZhNnNh8qGHA=;
 b=A5qZ2cQWBV5AqddvaXJi8+F/olIPBDPEusdhPx24Z+hWDkifHCi9ayNOoIYzYpwy7A7z
 YTLR6TIhjen4CANiWVErNwKm8uuGeW7yv03ic2/a5EGKPtoqzJaO6rwCETzsE0RbPtIT
 KAgykOvD3T8JMft8ht8Wh7eV2dOFS/lFycos2UkIJ/0iO8kTwWMkvL3dKP7/MRcj8bvM
 Q/fU3RyWWl3anA14ZL5AurNNgYzgXFlE+p7CS/TR0wSRgjs7HC4mnIofxx4FWmTL4ujo
 GAxKJ/s9aOWuAliDtWGf/tEjB6VzZaKJoZSJHle4ztrxF0pImkt9zBxaR/Tu95upvtlB 9g== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 36d7uq1r77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 31 Jan 2021 07:05:16 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 31 Jan
 2021 07:05:14 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by DC5-EXCH01.marvell.com (10.69.176.38) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Sun, 31 Jan 2021 07:05:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MC/qUjypHPqRK8gaSFstc3KPL7WaFb0DoODUmr3cvRWhQZgELP5LbClZqrw2Kz989v3TnOKk6SQ9PpZ/SsA9+2qC+bcjlOY6bnepCCh8Wskdut1osrqOajw+QZOkyxPoRdoMrLtLI2e/2k5RJRrIPFSsn/ZO9dyp/LZWwnsUxy3G6IyOdohqtRrSq23H/Ej4zl3tMAFi1kBq1iju4+P797Ojwy3iA2CNXJY8owrSTPmTJ5uBheD0Qy5REVdS/UW+ACB7S+NMlmNloiuo0ptdqKbmvGXqugHP+KT1kDBjIzx53V9gw2awlleL1xgY2TIu7E1arnQca7sb2LMyM8VI4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yZAb7RCJl7plHKR7rU7K/8uIsIMSJOPZhNnNh8qGHA=;
 b=QLM7beDykf0LYjykloVJXR7V0lZG1ASPLiaWVv+CQqGn/fkSueYyoSId+9Pkh3Z38AdPtsH0jTzUBTWlSsZ62vkKbF59ECBmwQAc13nFOrL6UvgFnsoy5gJozdk90VI9BZLWfumAmeM5jCr42SQMWTcHXrFiSJ9EpMkwwaxTUzN7AOerWqLnh7DwBQSwP3OmwWwis8L81SKjG/sOv1GdIULRou3RnMlXg3T4a5m8iL8Xi2BWch4cQZJoN5AR6oU6dZX9JJIjDO1v9eJtdkkbFSscN82yfyhM/gfCooQTUK5DpMQTjWnVTQaq1jkYLoZ5LAXSL8z6JfwkkVTf0WZb9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yZAb7RCJl7plHKR7rU7K/8uIsIMSJOPZhNnNh8qGHA=;
 b=ZAJdeDOYXqKdwgC1q8GWBifVon5lsy28iBgI9gKV2NUo6yibQv9GUnrU1C8rg+yT45tff122xbbTJClVvnvqwPMMgQE1G/V95R3Yj7D6fvM+dQKq1dWoXejsnLv8swy5HT7ENUHJNR/CqHBhAw9vj15Qgkak6prUBtFT4WU/aJg=
Received: from DM5PR18MB1452.namprd18.prod.outlook.com (2603:10b6:3:be::12) by
 DM6PR18MB2795.namprd18.prod.outlook.com (2603:10b6:5:172::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.17; Sun, 31 Jan 2021 15:05:11 +0000
Received: from DM5PR18MB1452.namprd18.prod.outlook.com
 ([fe80::e8a9:1188:a4f8:8a57]) by DM5PR18MB1452.namprd18.prod.outlook.com
 ([fe80::e8a9:1188:a4f8:8a57%4]) with mapi id 15.20.3805.024; Sun, 31 Jan 2021
 15:05:11 +0000
From:   Kostya Porotchkin <kostap@marvell.com>
To:     Lubomir Rintel <lkundrak@v3.sk>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mw@semihalf.com" <mw@semihalf.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "jaz@semihalf.com" <jaz@semihalf.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        Nadav Haklai <nadavh@marvell.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        Stefan Chulski <stefanc@marvell.com>,
        "kishon@ti.com" <kishon@ti.com>, Ben Peled <bpeled@marvell.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>
Subject: RE: [PATCH 2/4] devicetree/bindings: add support for CP110 UTMI
 driver
Thread-Topic: [PATCH 2/4] devicetree/bindings: add support for CP110 UTMI
 driver
Thread-Index: AQHW9J94dELhKX4X40KfyQNL0K0+vao+W7mAgAN7KCA=
Date:   Sun, 31 Jan 2021 15:05:11 +0000
Message-ID: <DM5PR18MB1452A089E28D20BC68495639CAB79@DM5PR18MB1452.namprd18.prod.outlook.com>
References: <20210127112719.30632-1-kostap@marvell.com>
 <20210127112719.30632-3-kostap@marvell.com>
 <20210129093823.GB68955@demiurge.local>
In-Reply-To: <20210129093823.GB68955@demiurge.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: v3.sk; dkim=none (message not signed)
 header.d=none;v3.sk; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [77.137.153.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f261bc4-2e99-4878-019b-08d8c5f99b6c
x-ms-traffictypediagnostic: DM6PR18MB2795:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR18MB2795A0015F21C4E7ED770D0ACAB79@DM6PR18MB2795.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0VfkeL8oF7N1bjpZ1pv//K3k6OCqlVqvEuvHsDFDUsXcHLAY9jo3A1aU5maGyvLo5UfYbORgLEYjdSeUiBga07fcRn8tOyU2Rw9R+iMF0BufNrgWHPokC+5lGykGBGBe7h6BGIsrv7D5djFk2h5pezoOD0/qODFn836xJV4HKEsHMx7AJVyuOv9tDEDwIVVYLMa+G5f7cXMzcxZjWJx4i6sxdrAp/3lp1QkNCMAqZaz9cC0EFrtiCk9+yq7ihTIMaTsa1Zq4Uz2X4tccfkSF8O66JK+PG3rVhHNWJQCf63zJrJsQGC6BNBeuH0W1UKlfdPSI+BxzIuWWsN5pPfR2n5c8zASgUKuhc8b3EugaMzmy3Axk7rFX2u4xtZ4Qgz85/Bk6ZE9I5l5Qs7uvxve3tMOU2iheblfsHIbs8TUBLwrx1UlBUZ/rIa8ljvwVjMhYSAVbKRppPLFnwl6FhTId6Nf2c8c+0ZjN1AaBuJbZrMcwKdi1oEk3MgXuQFtnKIQ2tKVg81fr/mtHgBNk7DdXkhSPRAp/UW3/Hx2KFIVkljufGxZ5RGGbqf419nXRsYZ3hkwtIBHSTCS0mJt2WUpPOR39iIyyAf/jwL1/PgvAru0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR18MB1452.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(376002)(366004)(39850400004)(71200400001)(9686003)(316002)(7416002)(86362001)(8936002)(26005)(54906003)(8676002)(5660300002)(2906002)(7696005)(33656002)(6506007)(83380400001)(55016002)(66446008)(19627235002)(76116006)(66556008)(66476007)(478600001)(966005)(4326008)(64756008)(186003)(52536014)(6916009)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?hFy2sXZkl2IJsxoG0VaVSkHvNIAp1gn9SxjkGnV24XRlvaRvA2RwRy71jDVP?=
 =?us-ascii?Q?jNY9Ip/vJw2oMP5AALX+YUd2z/VFYY8N2OKPcmhikBY3PVKWDvfwOmDbRLwc?=
 =?us-ascii?Q?pqrHRQDpEx77U7HxvBKdVYGWpkP0c6uIf6VridiaLANz74JZCyHJLUYPMf2g?=
 =?us-ascii?Q?J+tvIOlvDhyOqOpxXzN6KTvDKAWLI5/3rP1qdr3uutyJD8kcJy3kL45XVfok?=
 =?us-ascii?Q?EluI+n+yYf9gx3Ge8ylsOVU6A3XXI0RjttsurvRo937kQjr8hGDprCwB1wx9?=
 =?us-ascii?Q?B82ajRa8qz1joYIKhRuY2Kg1sp2c29kmz/GojF+sPeHpoIzJKdRCRkMfVkWZ?=
 =?us-ascii?Q?R4Gfto00bBuUTzXki9FAXsU8t3wIPb/H0dOROtU/7LacYKsJoMg80JquBlDM?=
 =?us-ascii?Q?BOnwzTBQPu0F6V+NshioHTUSIcaKOMU+nmiMpmWtgMu7t0j+D7PB9cboYFo3?=
 =?us-ascii?Q?OycqqVjAYIVW0UBBBsHcFFsJs9U164T6fyV4DrfNm+Io9uE7JrifWTv1jbM4?=
 =?us-ascii?Q?XceEVNc9MZMrvuGSguRfE/ltAr17SAlwmZmJIksBYMl+Ef62ZvmP3WfBQlFt?=
 =?us-ascii?Q?Hm0RjuWeetLCdU9857j/JH/GlAlb8vZ60TIEcW8YERoa7pVMLJ1BAOcq9V3b?=
 =?us-ascii?Q?2tPlOBpha8zA+m/gmRiwQl8frn9l6QBv49sxewgLrlOGLOQBlZpWsUyuCXRY?=
 =?us-ascii?Q?+N7W16gyOg3Pae6Nx0KmnuDvTeBoqN2Q3lOQ2bNx5evmU4asxJPgE3uUQv/v?=
 =?us-ascii?Q?udC1mfu5ApY/dNhQP9ogC9W6G8FfcWylSklUUly22xXrIqPqRtZ53AqDTxlC?=
 =?us-ascii?Q?6yY2KZEunQBkVxIsJI3MmpiKwsvfLmnDJf4zVOvrQWJTh3mZG6/foV85nPWS?=
 =?us-ascii?Q?is9Y9ZKZqZ4KMO0xV1qV6wSI3iYSmUZFgQKNeTw2W0y+1ja40G8FhGAs16jz?=
 =?us-ascii?Q?EfjqV981YKLx+opfNYEJDHM8ZrHfJVqsK+L7VmrmwGk3XgmiczL+uBjdwhLR?=
 =?us-ascii?Q?hrJHMjDF0e7WqQSmXF6+5ezPJONLUV171lKSJlybABRfLd4VjlbjJV/tL9FW?=
 =?us-ascii?Q?D0LEMQIA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR18MB1452.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f261bc4-2e99-4878-019b-08d8c5f99b6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2021 15:05:11.6721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PxVfScZvxPxeqRNNPWaqBF2N4GRa+ueno4GWlVai97rXJiTdUHGgFGwM0v851l0E85ferohZ8F1fvHqPOcKrmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB2795
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-01-31_04:2021-01-29,2021-01-31 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Lubomir,

Thank you for your review!

> On Wed, Jan 27, 2021 at 01:27:17PM +0200, kostap@marvell.com wrote:
> > From: Konstantin Porotchkin <kostap@marvell.com>
> >
> > Add DTS binding for Marvell CP110 UTMI driver
> >
> > Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
>=20
> Any chance you could convert the document to YAML so that it could be use=
d
> for automatic validation?
>=20
[KP] I believe it is possible, but probably should be done by a separate pa=
tch.
Here I am extending the existing documentation.

> > ---
> >  Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt | 69
> > ++++++++++++++++++--
> >  1 file changed, 63 insertions(+), 6 deletions(-)

...
> >  Required Properties:
> >
> >  - compatible: Should be one of:
> >  	      * "marvell,a3700-utmi-host-phy" for the PHY connected to
> > -	        the USB2 host-only controller.
> > +	        the USB2 host-only controller (for Armada3700 only).
> >  	      * "marvell,a3700-utmi-otg-phy" for the PHY connected to
> > -	        the USB3 and USB2 OTG capable controller.
> > +	        the USB3 and USB2 OTG capable controller (for Armada3700 only=
.
> > +	      * "marvell,cp110-utmi-phy" (for Armada 7k/8k or CN913x only).
> >  - reg: PHY IP register range.
> >  - marvell,usb-misc-reg: handle on the "USB miscellaneous registers" sh=
ared
> >  			region covering registers related to both the host
> > -			controller and the PHY.
> > -- #phy-cells: Standard property (Documentation: phy-bindings.txt) Shou=
ld be
> 0.
> > +			controller and the PHY (for Armada3700 only).
> > +- marvell,system-controller: should contain a phandle to the system
> > +			     controller node (for Armada 7k/8k or CN913x only)
>=20
> I guess this is okay, but referring to a syscon is done in a multitude wa=
ys across
> various other bindings; with the most popular being just:
>=20
>   syscon =3D <&syscon>;
>=20
> Perhaps consider doing that?
[KP] I was not sure that I can use a generic name inside the PHY entry=20
if it is not defined as part of the generic PHY properties.=20
I just did not see a good example of such in PHY bindings documentation.
If it is legal, I can change this entry name to just "syscon".
>=20
> > +- #phy-cells: Standard property (Documentation: phy-bindings.txt.
> > +		Should be 0 (for Armada3700 only).
> > +
> > +
> > +Required properties (child nodes, for Armada 7k/8k/CN913x only):
> > +
> > +- reg: UTMI PHY port ID (0 or 1).
> > +- #phy-cells : Should be 0.
> > +
> > +
> > +Optional Properties (child nodes, for Armada 7k/8k/CN913x only)::
> >
> > +- marvell,cp110-utmi-device-mode: request the driver to connect the UT=
MI
> PHY
> > +				  port to USB device controller.
>=20
> Do you need a separate property for this? Could the driver look at "dr_mo=
de"
> property of the USB controller node to see if it's supposed to be in
> device/peripheral mode?
[KP] Yes, it seems I missed this option. I will try to change the code to s=
upport it in version 2.

>=20
> >  Example:
> >
> > +Armada3700
> >  	usb2_utmi_host_phy: phy@5f000 {
> >  		compatible =3D "marvell,armada-3700-utmi-host-phy";
> >  		reg =3D <0x5f000 0x800>;
> > @@ -36,3 +67,29 @@ Example:
> > --
> > 2.17.1
> >
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> https://urldefense.proofpoint.com/v2/url?u=3Dhttp-
> 3A__lists.infradead.org_mailman_listinfo_linux-2Darm-
> 2Dkernel&d=3DDwICAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3D-
> N9sN4p5NSr0JGQoQ_2UCOgAqajG99W1EbSOww0WU8o&m=3D_ZOAKZShBT3Qj
> uT3RZIld2HoLnlvv6gkbHW9gSvEfI4&s=3DggCBpvhDLJ8M6-
> Q41qbt8GRxryUo_mHxLMkUl8Ao5mA&e=3D
