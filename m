Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5EF3BF957
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 13:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbhGHLxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 07:53:09 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:43242 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231628AbhGHLxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 07:53:07 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 168Bj4lr018077;
        Thu, 8 Jul 2021 04:50:14 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by mx0b-0016f401.pphosted.com with ESMTP id 39ny0g8c3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jul 2021 04:50:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzV2G3iYoQ0prjo6Srava5K3WsOUqvRTpHUtyCwE9xNWpPtLFqgs+/RQ7m46mY3q1FrqNB8o73lFTB4Lrtex4Iv1SDF2WehhDMsYbhORignObJkyxrJ+lvIuP2kv3qRTrvZ+olp3yN3oqijWltMU2ZC1Jf2b1/DNoPOz51ql2TO1OyFrkznJhN8cDgwwC3UN5EK0FTkQ4kOPSIdx16fcDxkP8JnQz/pXFBSvYjzhlTh7cz2Pb+Cne56hVhberySCQx8mIWaq1ehiKp3WlOfo04q2ITPZWvEUvoDplUPzIWUQUKQeZT0pCc2wu69rRPJMUsXijqE+txGICs3IqqH16Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEgVwzI6ViCA34T/9DFgTe1KOZLw9Pwqg9eT7gIfi7c=;
 b=XEIy1c6hPH9zC1ZRwrAPg/e3CtmQzglPK9vWB+W7qW30HfK4iXEgMu59qm32M65KMHbRX3AN4gm7cGfMn0I8A39EfeTt/niHlvjcoSRYnDH3d4dO4gzepaGD3on9J3HEUuzZCdcVCcaXeOD2doG9mp8BfZ+8bN7m96QMvibkFiSMjfFL3A6Pr5ua9f439Dykj4roBWth3xF0lFiOtTa7L0lAAqIVaBAobFcEzPrEgoxGhuJx/oaAOxDDzen0G2fBdcPoFIo+reOOerj81HfqV2c/jG8kRzRE9mijCVqCpX0dBXWc4EIap4lnAK1VLhQmW+zzpvKS6OTsqDWa3lHSXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEgVwzI6ViCA34T/9DFgTe1KOZLw9Pwqg9eT7gIfi7c=;
 b=KMxGaTTdPbHlh7e0eW2amM+iYrtk9hxX8m/ua2WGLmkokngGpatc+DZFNfVXbLxffbK3cW4w08tWbBEh7d+iozMH7qDZ/H7cqyYbTx5jvj/g77gDGcPWRiZXIS+usvSK7h7UketfZZAYAZYINuMQEL+NVEZbAj9Nxog9Bn4KfLo=
Received: from CO6PR18MB3873.namprd18.prod.outlook.com (2603:10b6:5:350::23)
 by CO6PR18MB3907.namprd18.prod.outlook.com (2603:10b6:5:345::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Thu, 8 Jul
 2021 11:50:11 +0000
Received: from CO6PR18MB3873.namprd18.prod.outlook.com
 ([fe80::40f5:53f8:390e:f9bc]) by CO6PR18MB3873.namprd18.prod.outlook.com
 ([fe80::40f5:53f8:390e:f9bc%4]) with mapi id 15.20.4308.023; Thu, 8 Jul 2021
 11:50:11 +0000
From:   Stefan Chulski <stefanc@marvell.com>
To:     Russell King <linux@armlinux.org.uk>,
        Kostya Porotchkin <kostap@marvell.com>
CC:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "vladimir.vid@sartura.hr" <vladimir.vid@sartura.hr>,
        "luka.kovacic@sartura.hr" <luka.kovacic@sartura.hr>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mw@semihalf.com" <mw@semihalf.com>,
        "jaz@semihalf.com" <jaz@semihalf.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Ben Peled <bpeled@marvell.com>
Subject: RE: [EXT] Re: [PATCH v6 4/5] dts: marvell: Enable 10G interfaces on
 9130-DB and 9131-DB boards
Thread-Topic: [EXT] Re: [PATCH v6 4/5] dts: marvell: Enable 10G interfaces on
 9130-DB and 9131-DB boards
Thread-Index: AQHXc+wOxw0qL3Yb8UK2TP1cLxx6J6s48QKAgAAE4mA=
Date:   Thu, 8 Jul 2021 11:50:10 +0000
Message-ID: <CO6PR18MB387366F5FE350810B45FBFECB0199@CO6PR18MB3873.namprd18.prod.outlook.com>
References: <20210708112528.3254-1-kostap@marvell.com>
 <20210708112528.3254-5-kostap@marvell.com>
 <20210708112850.GU22278@shell.armlinux.org.uk>
In-Reply-To: <20210708112850.GU22278@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: armlinux.org.uk; dkim=none (message not signed)
 header.d=none;armlinux.org.uk; dmarc=none action=none
 header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3771726a-f52b-434b-d890-08d942068a8f
x-ms-traffictypediagnostic: CO6PR18MB3907:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO6PR18MB390757CEA9390DADB6DD096FB0199@CO6PR18MB3907.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1148;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: krnKTMJRK02yc0WbeRW6E/IjygoSX3YobN4dAAY417stBuotq2zZE8fqBJVFPqKgq1d3xBHkqMgM7q+TbEz3oQ7ZZvl4d971wU7j7d+r4u3T/8Fn5kUg3CRV+POikgQhzi3Oy6d/HThXFzGwFrDou7ej6aPVTBQi+OHcwOZZfVZkcPTqjdDW8BKCIQq6359WnTtCoLf3IN1CH1VcqB6BeAUBbiDlrjYwpVqKGjm6aI+OKJGvgNMNtWAIsNqHIVoMnV5zF3M48oT1hAQ9B6yb0ibnZg5OFHKqb4aELL2RZIIaNzxkF+hDSfrKoQWNUhaXpA4U/ofQAlcj6hQaX6ljRHuCXlMaXO8zkCa+nI9i0adIDPeuGipcMR4qeneDVESs06ySXpqHKewSYJxC7E7oErZGMqq1HazzzVyWCAqkqwXGOLmBnEXQRchtUNB0j+vctZTZos6lR/MP5cWbjtO1l03WzYlxKzHuIEBy43y/BcfKwkmiJvQdc99/dNoRXwd/7WfBkD9TXuUWYQPhQlH5mNQDnbTAmsJwQ8xDAbBU3aGCeFeVXAE8mYrY2d6k7+zR89PHabGMhLZUm3YBWO/3rwOzBF4ABDzCmhyqyRssv06Aphncsbv8fKdrUc8p7/fJ9mEiiCACWlSyaJSDcNG67g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB3873.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(66476007)(55016002)(86362001)(64756008)(6506007)(6636002)(66446008)(122000001)(52536014)(316002)(66946007)(9686003)(66556008)(26005)(76116006)(2906002)(83380400001)(8936002)(107886003)(186003)(54906003)(8676002)(110136005)(7416002)(7696005)(33656002)(71200400001)(5660300002)(4326008)(38100700002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nq/UoceQ8NdC9+dym680/s3FrVhNrNQM2nNRuJJ/PZkPDTkvTHinSNC/9RZn?=
 =?us-ascii?Q?pLlF1n4mD/ElqL0TZqEfa/tc4NhNmtjnyaDmCcDraaXqGGmZF5b2QLd9fWnx?=
 =?us-ascii?Q?Fmu9IwF3YDAOJk+XxZi+B2Xe2aaeIGI31HxXU59BSNaZ8AOYGsXzTUKdU8WW?=
 =?us-ascii?Q?tqDVAuVY/U9ARU929n024T2l2Q4sLOXqVk3JE7a4QXxjemFRIGXHTMUF/XL2?=
 =?us-ascii?Q?kYbUB6VGuhS8G71p+pWxQLKoyQD1QjgibS2VkcBIhn4XHpPwaxElOeOyGjox?=
 =?us-ascii?Q?ehm7c7giEVnHNkPADWC0G6VImcibm0w15IpJBN/JyqeF6ndwjKV3lDLApHvO?=
 =?us-ascii?Q?SqgwNT3i8UYcQgTcAYAVzqhjfjlgSlE2023GrPgPDlB+tmTTKJAGqEUAas0V?=
 =?us-ascii?Q?0lN0OJprcD+Dvuup735MLBuRcr5rM8SP2xOWPtaezW6CvcUuhx8I77fZru1V?=
 =?us-ascii?Q?/OIwIQHHDRz0X8UjJQXPca4rcZ+24oVJgRkxfHSHjzhxKKmzfVjnL4C6I5DR?=
 =?us-ascii?Q?B1vRJIDlf7RVoohfQLbMD8J5SmFA4mkbwcSWEBo5HIwt4QTXo/gT/PK+Avqa?=
 =?us-ascii?Q?oTo3Xc7eGDD/3uHpbiRQAWHNAVDOgCe2TePosLfgldhUUjD91a63COVYWRnY?=
 =?us-ascii?Q?1CI2r0KJp7BAg5uR0tdUth5+iPpygU7W7HDjrVbHm6JSC9KjH825nJixX/Ti?=
 =?us-ascii?Q?8TueudK8oIpYEUt2T9W6MlkwR1Ncj63RnZXxL8MYBcWZHQ6A3ZmearoW0qBi?=
 =?us-ascii?Q?MaXBjBp6jaDc0wPyaR5rpFZrfQl25uoD3bpaUnCXlrMFUHNQRQhe0P7B7rD2?=
 =?us-ascii?Q?oCwsJzLf0MhJv/7YYgTAhL1FFx9AKXS46d6DB+lIqPyaWswnwhMG5F91KJKC?=
 =?us-ascii?Q?VuGQD+SLbEAREktk5TXSDhH1aqShN9Z2cWdrdtOJLuIFp3pAdkTRdR+cTdJN?=
 =?us-ascii?Q?j74ke5r+0p57tm6OLNmN8MC9daYm4HgtuO6rvmS8gTid+1IXxuBFHAQQ15Iv?=
 =?us-ascii?Q?Px1rgLNhIqhrx7QTqri+GP1jfy+eAstYGRwTySYdGn48hCyPNJLjdScUJk6w?=
 =?us-ascii?Q?r3xfSZdLST9lAS5HxmMRsNZzLtWoWLl7n9mLaVK6otash/HI3FtE04Xuw+eG?=
 =?us-ascii?Q?RNUr6lGpXycPgLDrpVbEDubHzXCHmGj1f0PHTwSuuvhhj34camD+QmcEPbyX?=
 =?us-ascii?Q?JhvqfxRARqrGm35keYx31o/wyb2SorGO1dvl+TZ8AAT7ugRu2cStmqCHMw/T?=
 =?us-ascii?Q?4Q6u5zPbXw1FyHPJqLtHsupr1zhzcempQSoDltLk5maULqgdYgLQog4Xh/I4?=
 =?us-ascii?Q?OEc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB3873.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3771726a-f52b-434b-d890-08d942068a8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2021 11:50:10.9903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zNP2XrrAIBJ2z8+AYA+J49zAznCS9mYoFAWxr4tLsq32XpUFhFNyq+TyNAp3RAkydlNliVJyGO3QQLnGNaUcVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB3907
X-Proofpoint-ORIG-GUID: 3x8o5JeqmFq-e3TnmcYrcKBwenb2DPLU
X-Proofpoint-GUID: 3x8o5JeqmFq-e3TnmcYrcKBwenb2DPLU
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-08_06:2021-07-08,2021-07-08 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> External Email
>=20
> ----------------------------------------------------------------------
> On Thu, Jul 08, 2021 at 02:25:27PM +0300, kostap@marvell.com wrote:
> > From: Stefan Chulski <stefanc@marvell.com>
> >
> > This patch enables eth0 10G interface on CN9130-DB paltforms and
> > eth0 10G and eth3 10G interfaces on CN9131-DB.
> >
> > Signed-off-by: Stefan Chulski <stefanc@marvell.com>
> > Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
> > ---
> >  arch/arm64/boot/dts/marvell/cn9130-db.dtsi | 2 +-
> > arch/arm64/boot/dts/marvell/cn9131-db.dtsi | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/marvell/cn9130-db.dtsi
> > b/arch/arm64/boot/dts/marvell/cn9130-db.dtsi
> > index 34274e061958..39fc90716454 100644
> > --- a/arch/arm64/boot/dts/marvell/cn9130-db.dtsi
> > +++ b/arch/arm64/boot/dts/marvell/cn9130-db.dtsi
> > @@ -125,7 +125,7 @@
> >
> >  /* SLM-1521-V2, CON9 */
> >  &cp0_eth0 {
> > -	status =3D "disabled";
> > +	status =3D "okay";
> >  	phy-mode =3D "10gbase-kr";
>=20
> Are these really 10gbase-kr? Or should this be 10gbase-r ?

Should be 10gbase-r. By default we do not support full KR protocol.

Regards.
