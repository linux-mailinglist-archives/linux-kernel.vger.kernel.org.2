Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362DA3BF9DF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 14:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhGHMMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 08:12:46 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:26786 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231404AbhGHMMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 08:12:45 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 168C1Xqu013245;
        Thu, 8 Jul 2021 05:09:51 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by mx0b-0016f401.pphosted.com with ESMTP id 39ny0g8e9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jul 2021 05:09:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmaJ2l7fbHZhHRytlFEAyAz5eWYSnXuHVEMrSmjK/d8zTAe3fcvuJK+GkpKz3/9ka6SJAB257epWmzJ8NcA9TsyQUjK/TFMzZdRppykP+eNRRJbn8q5Q1xSK3QsaSe7ocgIqlPBVFGGILDbgLPE+MqkEQltPwlSnE7LwmFVJkasiA7D1c/EetMhPU1vcHL+21thBAz36TGAzFihfZS4aXmQ83AnjEy/NpHl6PBrIjcNpURAftR95LCfIVsh1Tp4eBfa7aQJovKu5oV1wp7xVnDnSk5JlCBYqCMARarlYs4GcnOrsSOuYO/pcPBIZ4uyN+rJIHOKicX6DeMShTfUZYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfST7J1GI0NorRF6IspRlK/og63Q35QnUYkJ2pG1f5g=;
 b=B0mxWkfe9PtjD1Y4jkP7qEHo66ppALYLaM54BgkKyObqYuDGowfcyXhSe8018abbbLLkSimZkJoGtagY4mc2vdOM2kumWx/wJy/uTYqPmlvscrkK+FxMShbtnIqcaJLne8+CwAC0Q6Nm3tCidubehz/Kbjhb5tFvVKprehCHgrpdueXmUNvhL4WZO/l7Jq0tMatK+qYyG8gCIASNdSMWz7HK0eIkHcoTwDYjrtQrGZ5nXNtLjZD0Aognx+GXZVlSjd+RSL8qr4j+92RTFVgv6AT+Lk+Cx+Pw7h+DtEvlmHBbsvfROYP+C87SfY2VLpfI/XrY2DL/cTDUej+ROybgEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfST7J1GI0NorRF6IspRlK/og63Q35QnUYkJ2pG1f5g=;
 b=b51wcX85GKvFmRoAhI0qImYs/3+frn0T7bq2qX6PMPOgLokA1kLfYHcYNkriqqoc72YryEalF5PbLKfpeR2deHqcJu2al89Wf0b11pYGkZ7F2/o3UccGwGfDHqUdUybbJxZKWPNSsNCn2mBvi4gQ2ChjSwz4qflhvffv+qgBgmU=
Received: from CO6PR18MB4417.namprd18.prod.outlook.com (2603:10b6:5:354::9) by
 CO1PR18MB4569.namprd18.prod.outlook.com (2603:10b6:303:fc::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.20; Thu, 8 Jul 2021 12:09:49 +0000
Received: from CO6PR18MB4417.namprd18.prod.outlook.com
 ([fe80::8c65:a737:b0e1:cf83]) by CO6PR18MB4417.namprd18.prod.outlook.com
 ([fe80::8c65:a737:b0e1:cf83%3]) with mapi id 15.20.4308.023; Thu, 8 Jul 2021
 12:09:48 +0000
From:   Kostya Porotchkin <kostap@marvell.com>
To:     Stefan Chulski <stefanc@marvell.com>,
        Russell King <linux@armlinux.org.uk>
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
Thread-Index: AQHXc+wOvt658EbTrESFwidi+ivyN6s48QKAgAAF9ACAAASnUA==
Date:   Thu, 8 Jul 2021 12:09:48 +0000
Message-ID: <CO6PR18MB44170F8D0403F98C664AF95ECA199@CO6PR18MB4417.namprd18.prod.outlook.com>
References: <20210708112528.3254-1-kostap@marvell.com>
 <20210708112528.3254-5-kostap@marvell.com>
 <20210708112850.GU22278@shell.armlinux.org.uk>
 <CO6PR18MB387366F5FE350810B45FBFECB0199@CO6PR18MB3873.namprd18.prod.outlook.com>
In-Reply-To: <CO6PR18MB387366F5FE350810B45FBFECB0199@CO6PR18MB3873.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: baf51409-3c27-4f21-2b3b-08d9420948a4
x-ms-traffictypediagnostic: CO1PR18MB4569:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR18MB45698BC4073DE84779FE963DCA199@CO1PR18MB4569.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OD9+JYQYHUAipfVa7razmpdEYBcmoxIL1U/OKH7v1fbquVjzmN2xu/G73zuzkC5IdEHJI6e6DF8Pa6/iG56InxJlqKsHTK3vnU33DDaLESPL3aH25K81Hsl35GfyiqrEBNVf75wzScsNuq+6O6poIser2KOTAQ0reqs/FcNqY3LNnAe5wb3n3YvfFT0ilyzAOQdysvIcIvHGiHzKSk0gYMjkyp7GeN4JxQ2qHgmHKORUDmxgnMyDNe0MiV45+4HdUKUZGYUHj6oSNynnBKmmPIMWgl598w9pM6S3radN7JPBJDru580cXDZvjLPGjaGKAxOky52OaXNBFv5hWiPG3NvzD/4DHd8bT1LFCpEuzBuuUDJV+m/QZ/8N7yBE1gD8Zb2l7mZ9MmbDSI4GTiCI16ve94cdTlC0QWBobD1+xLNlqJrDsvNM/vw+3t3OYjMI2e2WIDvs+1uUtwNUbwZOtf5f6+S7Ki+V8URxI7A4MHIxOOF4euj9ZsHRv6G3+7ja5Zls+tzBayrouXEPdKzWlGLI6zSWbVKXc4OWHJNHkwnb6oAI7BBVgERPMBpeZEepffiM9GULa9vHuJAdo7BJPu1/RsfyEifMgpXF21wjIkxUr6L1JdYJSNT27TDF+hGKt0VbJFtGcaAQndmiB5dVHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4417.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(186003)(110136005)(66446008)(52536014)(54906003)(8676002)(4326008)(6506007)(53546011)(7696005)(8936002)(26005)(5660300002)(107886003)(76116006)(66556008)(64756008)(9686003)(66476007)(66946007)(55016002)(478600001)(33656002)(38100700002)(122000001)(2906002)(83380400001)(316002)(71200400001)(86362001)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?z3RsUn7KZftDcRzHB/RUGKQXTvgsUpfSsaDMchdwVxx9z7jEe+vGB+vKEUWR?=
 =?us-ascii?Q?5ds7uuUr4Y6pGkSNT+BWBNGD8acIiB8LYZwGxQJUuPTOcwOPJq3fUMrmdjLj?=
 =?us-ascii?Q?m74atqqKxSNaJX8Z7o0pFOxkK1/Qp+pzzO/rN8W2DogZaf4H6exNmotleecq?=
 =?us-ascii?Q?tD6aqKURNKwNLgoAGm07QcYeaChADe1IdY361soqvQMvWhGCT7PJB+p9+OUm?=
 =?us-ascii?Q?9f5WpoCiKnilxbcSZL7VQMtC7Qxl3WP5easFF+ouyObKLbljU933WkPmv5E6?=
 =?us-ascii?Q?pSMIPP9d9XhvZDwdqtRdjDAT5B7aKEGC63v3be1cSObeaJdwlqf9SrDTxO4b?=
 =?us-ascii?Q?wwM9p4/2GZbFVPlHNcY2QyVo+7wIsVizoQTkON+8czAv9nCVYzsDfCuugkCu?=
 =?us-ascii?Q?S9igznmxn8QzijRITHOWvoNyE8o+O5sN6yGceLlAVaMzINtn64+RtHZLs1hx?=
 =?us-ascii?Q?dOT8liTCUmZD+uvPclDpPJQJaRX5jQe8BbaedBmt2oKRXVoH/Upfx+pDuN1O?=
 =?us-ascii?Q?0KUDb09lsepsKFH04FcQm1+lPnzvGvWlQlCYHZrsmbymVpUdgQqZ4eWXo2ze?=
 =?us-ascii?Q?LVEdzQALnoynKQbmisIBlzy/XZtCT/TpyhnpHxE0ZE390GOPQJKuLzgfYsdM?=
 =?us-ascii?Q?fxbzk6mI2VYPKekQcxmIlHd7X/z5BNrA6S2o5ET2N4c9Lf7pk1mWz7Xlg6wz?=
 =?us-ascii?Q?8deFm+VYokYqLozRuzYfMPboAg9xwgQB+S9lc7c5WE7JTtOXL7JUsQIq60Pr?=
 =?us-ascii?Q?7MlrlCwUOhVf0HQ8oh1SB0Mx4Ozux3NtwEfUAmEgPSSXwQRoQnVkP5yzQeRI?=
 =?us-ascii?Q?EnS/iSYVvt6jB54YC8YIA3lZU6Ybv4diCNJv3BcHk4TMX7hUYkKLg6255sV/?=
 =?us-ascii?Q?3JFK6YDuIwYwNpAmu1/u9YKOSAxFKO7t2hghtohsCDJXcRprPkxTr1JzXz4f?=
 =?us-ascii?Q?z8Yz4WgRI+tYuD/yA6vvQ1XZ/4H7Xre9mcTfKBZHlAEChwQL8JQXlSddLTPN?=
 =?us-ascii?Q?P/z1gEs8HhriKmc95Shtsf+NOnu1lTSJuoBV5rWKdvwrp9HY8sAV1SRf02Mn?=
 =?us-ascii?Q?3HKbkvxTVs71jqdr8O/oXPMp49SbxmRPjCsg9Z9m/44kpqm9htFkF0Y8KR2C?=
 =?us-ascii?Q?+L9sf1bABJo8n1rB+WEGdWhgWpNL5NEHpjRon50vNvLvd/km46XvcwoAt3sz?=
 =?us-ascii?Q?P/F4SmW1ZKDTeRhZkkJqr1O7LNEfYlWESYpeJz5oUM5KktUL68DqeQu6E7+i?=
 =?us-ascii?Q?9/e3j2k7zaKWafukucTJg7CxvYOQ7WMiLtta4SHer6DGhRoQwKoIC2UqZe8p?=
 =?us-ascii?Q?4Ow=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4417.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baf51409-3c27-4f21-2b3b-08d9420948a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2021 12:09:48.8203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UUduFBZV6wwJ+zUH3zrdxTVI87X+rkK2+Ta7pnoZVotKZZWDrpsY1G7MywMkKrYq8kEizY1WRd3wBBiSxuioqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR18MB4569
X-Proofpoint-ORIG-GUID: uX2TfwBMxNqgv38oQIVmwShV9fD-l2pI
X-Proofpoint-GUID: uX2TfwBMxNqgv38oQIVmwShV9fD-l2pI
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-08_06:2021-07-08,2021-07-08 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Stefan Chulski <stefanc@marvell.com>
> Sent: Thursday, July 8, 2021 14:50
> To: Russell King <linux@armlinux.org.uk>; Kostya Porotchkin
> <kostap@marvell.com>
> Cc: miquel.raynal@bootlin.com; kishon@ti.com; vkoul@kernel.org;
> robh+dt@kernel.org; andrew@lunn.ch; gregory.clement@bootlin.com;
> sebastian.hesselbarth@gmail.com; vladimir.vid@sartura.hr;
> luka.kovacic@sartura.hr; linux-phy@lists.infradead.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; mw@semihalf.com; jaz@semihalf.com; Nadav
> Haklai <nadavh@marvell.com>; Ben Peled <bpeled@marvell.com>
> Subject: RE: [EXT] Re: [PATCH v6 4/5] dts: marvell: Enable 10G interfaces=
 on
> 9130-DB and 9131-DB boards
>=20
> > External Email
> >
> > ----------------------------------------------------------------------
> > On Thu, Jul 08, 2021 at 02:25:27PM +0300, kostap@marvell.com wrote:
> > > From: Stefan Chulski <stefanc@marvell.com>
> > >
> > > This patch enables eth0 10G interface on CN9130-DB paltforms and
> > > eth0 10G and eth3 10G interfaces on CN9131-DB.
> > >
> > > Signed-off-by: Stefan Chulski <stefanc@marvell.com>
> > > Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
> > > ---
> > >  arch/arm64/boot/dts/marvell/cn9130-db.dtsi | 2 +-
> > > arch/arm64/boot/dts/marvell/cn9131-db.dtsi | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/marvell/cn9130-db.dtsi
> > > b/arch/arm64/boot/dts/marvell/cn9130-db.dtsi
> > > index 34274e061958..39fc90716454 100644
> > > --- a/arch/arm64/boot/dts/marvell/cn9130-db.dtsi
> > > +++ b/arch/arm64/boot/dts/marvell/cn9130-db.dtsi
> > > @@ -125,7 +125,7 @@
> > >
> > >  /* SLM-1521-V2, CON9 */
> > >  &cp0_eth0 {
> > > -	status =3D "disabled";
> > > +	status =3D "okay";
> > >  	phy-mode =3D "10gbase-kr";
> >
> > Are these really 10gbase-kr? Or should this be 10gbase-r ?
>=20
> Should be 10gbase-r. By default we do not support full KR protocol.

[KP] So I will add a separate patch to this series changing "10gbase-kr" to=
 "10gbase-r" in all CN91xx and A8K DTS.
Will it be OK?
Kosta
>=20
> Regards.
