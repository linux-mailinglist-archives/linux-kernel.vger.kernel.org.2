Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61FB430E060
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 18:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbhBCRAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 12:00:06 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:23974 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231211AbhBCQ6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:58:16 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 113GdsUg018918;
        Wed, 3 Feb 2021 08:57:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0220;
 bh=noDUR2dOgIjUt5Q2MnjUQsKzlmga3Xe9/1dhhZHv85c=;
 b=YsUaOknhgvLsFQmdvNtiEa9TvseqaGxzr9tcVbPYQeD0kXAm8UV2y1Sn6VlsoGuzGjNZ
 Nq8dNLF56mbJxjjus7WYhMsi+peRxoU3khi/rTe8crisDBiwmpaZ9v8z2wLNGOeKIpd+
 5U3Rahb4kcrfKWJ7zzkLZZGVk70HE12ZlzR8acc91HZgZPEx7C8M7ArAE9QkH+MfsOAz
 Kie8JPQ9p2qafZORVWEUKXMPzK4h4AoIwrOqSDbDWuf5/XzGMLWfLvZ3ijymCbLiAYzc
 WqOL4q1LOcvEVMX7lhKljKdxngJuOxS/f9tfYnTB7kzBUSKiQvwxjclB6G/yX+xKTEes gQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 36fnr61ugr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 Feb 2021 08:57:14 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 3 Feb
 2021 08:57:11 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 3 Feb
 2021 08:57:11 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by DC5-EXCH02.marvell.com (10.69.176.39) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 3 Feb 2021 08:57:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFFksJpRQMpBInyU5eYV6Y/h2VFbrOom+DIsvSnu2kGoYQ1XKF+x9zV4c/XpbBkXK/uxQ/3Nia4KApHFoT6Dd29vq9IYmTfFUvCmN1w2ACMc50E/6t4bUFc5OT74cw2JIumI/pwthwRgirnXfiOWU0xnP3EzcPzwdMla4ebjGobyngF6U4BZjFvOXTThjqBZ+Kolj1h8JJd4FTMMV/gl9BV8cKcEw5qHn/lOc4jYYUoZOggslSQfAGMeJuCjYPcTHvqyD8UmBYSnSWyM8RYydHsai/36Iw9Qqm6+YW3s22CROnfqtpzDoUppq9WkB15X03GV/+38+1FfS4UDAIYUBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=noDUR2dOgIjUt5Q2MnjUQsKzlmga3Xe9/1dhhZHv85c=;
 b=ETwDZTdzxo6o1hERUF6wPGlliykxSeBjOLzYOy/J4HsLnWbTG05Am33wp0Pt5FhvhgMbwXqUX9+W3NVy5RLIedLCUG79OO0xwwWW8dCqWaT/X1F20tb8zUQkb6D+A6ZfTzoY7vagbsj9/JkLcxvnsLFtWA4CqyRhplzVWbqRLehF77NN6nwAn57Hy+Xa06hVuCSpECMuKEhckIeIEutH79IZ1mPBA3vJAjpA7mivRbmlhf6tIkNts03zHTvjk1vq0hjq9EbPhi2NUcACTYmvlgfQJO2Tk/pGFzusqhOI7sp2vaiiwIGo4cI33McZQOwrbYSe6Pgi+BS9SMvWv662Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=noDUR2dOgIjUt5Q2MnjUQsKzlmga3Xe9/1dhhZHv85c=;
 b=SMfrxzAJ3CqHVP+tEyeBWnWpu4E5f0YSncdT9hPmSQpViZ72enSrpUKtW5WUMC9eovUJ4WhA6GCV1PxRNCVB7GtbQtUYIy2XAasbilsTbF5xptsD3tDRAqQv2D6hOCebGoxIbIXh7bwbnTEyQ5fIjufLPPoCA0pW+xZq7Xxj83Q=
Received: from DM5PR18MB1452.namprd18.prod.outlook.com (2603:10b6:3:be::12) by
 DM5PR18MB0938.namprd18.prod.outlook.com (2603:10b6:3:2d::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.23; Wed, 3 Feb 2021 16:57:10 +0000
Received: from DM5PR18MB1452.namprd18.prod.outlook.com
 ([fe80::e8a9:1188:a4f8:8a57]) by DM5PR18MB1452.namprd18.prod.outlook.com
 ([fe80::e8a9:1188:a4f8:8a57%4]) with mapi id 15.20.3805.027; Wed, 3 Feb 2021
 16:57:09 +0000
From:   Kostya Porotchkin <kostap@marvell.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
CC:     Baruch Siach <baruch@tkos.co.il>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "jaz@semihalf.com" <jaz@semihalf.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Stefan Chulski <stefanc@marvell.com>,
        "mw@semihalf.com" <mw@semihalf.com>,
        Ben Peled <bpeled@marvell.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH 02/11] dts: mvebu: Update A8K AP806 SDHCI
 settings
Thread-Topic: [EXT] Re: [PATCH 02/11] dts: mvebu: Update A8K AP806 SDHCI
 settings
Thread-Index: AQHW+jD04fJzej2FY0aIGyOLdCg1f6pGdPSAgAAJqBCAAAGXAIAAAY2wgAAYXgCAAAmuIA==
Date:   Wed, 3 Feb 2021 16:57:09 +0000
Message-ID: <DM5PR18MB14525D61BC500B0026F30D07CAB49@DM5PR18MB1452.namprd18.prod.outlook.com>
References: <20210203133138.10754-1-kostap@marvell.com>
 <20210203133138.10754-3-kostap@marvell.com> <87h7mtckxe.fsf@tarshish>
 <DM5PR18MB14529A28A31785A574A4DEF5CAB49@DM5PR18MB1452.namprd18.prod.outlook.com>
 <20210203143851.GR1463@shell.armlinux.org.uk>
 <DM5PR18MB1452A6CF26E3A54730872A14CAB49@DM5PR18MB1452.namprd18.prod.outlook.com>
 <20210203161137.GS1463@shell.armlinux.org.uk>
In-Reply-To: <20210203161137.GS1463@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: armlinux.org.uk; dkim=none (message not signed)
 header.d=none;armlinux.org.uk; dmarc=none action=none
 header.from=marvell.com;
x-originating-ip: [77.137.153.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5af82a7-a377-4518-7b5b-08d8c864bef8
x-ms-traffictypediagnostic: DM5PR18MB0938:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR18MB0938C6746E352FEE06054B60CAB49@DM5PR18MB0938.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o6bBcIcSRHyDCwPXFIhl3RLmXqbHufXfV8tpIb8R6/NaUjujfskBiKaG2lbINpA/+Xh+bLsRYy3htYE2vnFXOGntaLeP0Ar7LLiUROYMXqxVzK4apfNTUBUPlPlHrw7KA6zQqrUbMLd+IvJA4GUEF4SNcW3ppctQt3IseXJnaFzN7i8JVV6o0WHkfSenr/gePYc4/faKrXkvbZ/k5je7qbSNo2qOGdXHBRLLIOfcJosOjVSonef9Dh3qYQyCUJvjbEg8suYq0KJbJacpgfWhe278SE5+WHdebHrzu5/3O/a5DwgFA3/tfTM+/BQkBJWR3dXdzKnrh/0KFowyknhLghF8nZ78yA5kE7p2+bUPrDGNaJTemRyLOcJf3v820XUih9LUp3+SYbyla0WoFfd7/6jK1QUEH8HZqGwSjLUCPtA+5g6+qctbz61E2PdWXCKmSQ2DdSVyy66WDcHAz9nCUUVXWoftwgnzqzb5hUruYfWqXamUYHXLcOmrT3KtEEP7R6Ta8pJoBoNt7vzsxaUA0wBnMJBqOI1EQdZhFT0ML4N+tuEEMW0UsZflCfa78bBSkxB445tfgA0d8T6x/S9ZtAPp6FU3kvHgj9RKg21mKI8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR18MB1452.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(316002)(478600001)(54906003)(7696005)(966005)(6916009)(55016002)(9686003)(15650500001)(2906002)(4326008)(26005)(6506007)(5660300002)(186003)(66446008)(64756008)(66556008)(66476007)(76116006)(8676002)(71200400001)(86362001)(7416002)(8936002)(66946007)(52536014)(33656002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?UGlWq4dvu6ptUcrtxHNADSjejdzxUVz0ynK//jYrUq/Bg08sX8iF+VUgHqai?=
 =?us-ascii?Q?EKFx5XJDanLJBrwIL05GYy48YPst2KtE6PtGbL/HSsz5a21mxaNmPYHkPDEl?=
 =?us-ascii?Q?WTk8sbtE5fjGwJIMgHDph++89DKm49s6XgO2r7mpyj/+8bslbM7lexspHEi4?=
 =?us-ascii?Q?/HzEKWdvgsywM8mv1R/aPWqWVXnJt4Eg1Ajpa/EvuUdkzzO3i8MnJJKEp3cQ?=
 =?us-ascii?Q?kJURQin2vJQlXuEfuu/x/5dp1owNaPArIgWx6b/QfZze9o+cIDUrCsux20G4?=
 =?us-ascii?Q?auBPVDzGLNuvAEfPSnaHDjgZ2XcJLLEfM2M+sfVwhgw4zgy8ZgzHfkA7HwRy?=
 =?us-ascii?Q?1BtMP2ewWZNaPwOxrGqtM8zJvcP5JuM3QkvrQi2aFMJotBF/5b/7unnmjkvO?=
 =?us-ascii?Q?y3UreULm3CiAfFXx3VvfENfKYXUt3zwPhblCCjxE+uWmvPxA/hNNtvkiw8LX?=
 =?us-ascii?Q?/D7Zk2Aub5YqcOti+ahNiHd6aieq04Zohb7pWshZBcbFr+9aIco323fnXcK5?=
 =?us-ascii?Q?zZFjjy0ANZ4/+dUs3qHCN9vRu00zSwGqtoIF1OjMx0K/KJr/FadR9EGV89P2?=
 =?us-ascii?Q?oOLU5HhSjgzvRWlXnLmKamHYcjK1xqmvRmDunhFq4+f7K1W/StVt1TJYhVfW?=
 =?us-ascii?Q?TKEzTdqqNKWqpEiHfD72dQGns8Dw92n8a1TU/agSqyeijLb4PY66KM66es4F?=
 =?us-ascii?Q?pSYl/kmzQRdP3eHHb2AYEqF5pKcojOekBiVgBaBZGiTScvJXrXFteMwN0tfU?=
 =?us-ascii?Q?Fqd02GbcDlIesUu3opH+/bCMnU8DLd2rnSZ5QirAuYvuz1ldKZ9E4WQkPPtj?=
 =?us-ascii?Q?22EJRjOZuGDiAkunqgvBethRhszTJ1KzStLWEyboKs2Ee91r0zOwkTlds4iY?=
 =?us-ascii?Q?2Ox38RaJEnAFB4C+A9HVO2B6e3w9N2uYcmkXzbW23vnLrzl1Pt4qWxvQZd9O?=
 =?us-ascii?Q?CI3X2X0QRa2dWUKyZ7Ayhz2SkKBlgbXQz+urkCr4Yy9V6X96h1igNphtTpIi?=
 =?us-ascii?Q?DiIIweDrHP82Z2dwnGvk69UH33tTiFuOEutrnJ0a+NoYMUzGsEz9E0MOXXTA?=
 =?us-ascii?Q?JZ+/YTrc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR18MB1452.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5af82a7-a377-4518-7b5b-08d8c864bef8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2021 16:57:09.7756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gbx0mPhZsswYbfAKXn7KoqIbbscD1J5eJQB/aZMlJpZJNYzz7KCYgdYnqqjkp85YDSAyOgp9ayDLa3pTLrWAXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR18MB0938
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-03_06:2021-02-03,2021-02-03 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Russell,
I agree that this patch needs rework.
I will definitely do it and issue a new version.

> On Wed, Feb 03, 2021 at 02:50:45PM +0000, Kostya Porotchkin wrote:
> > [KP] So for older systems this "slow mode" parameter could be set on th=
e
> board level.
> > When it is set in ap80x,dtsi file it downgrades all systems to HS-SDR52=
, even
> if they support HS400 on AP side.
> > MacchiatoBIN AP eMMC is connected to 3.3v regulator and has "no-1-8-v"
> flag set, so it should remain in low speed anyway.
>=20
> Your reasoning does not make sense.
>=20
> The ap80x.dtsi file does not specify "marvell,xenon-phy-slow-mode".
> It is not specified at this level. It is already specified at board level=
.
[KP] it does. In current armada-ap80x.dtsi File this specification is on ro=
w 260:
			ap_sdhci0: sdhci@6e0000 {
				compatible =3D "marvell,armada-ap806-sdhci";
				reg =3D <0x6e0000 0x300>;
				interrupts =3D <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
				clock-names =3D "core";
				clocks =3D <&ap_clk 4>;
				dma-coherent;
				marvell,xenon-phy-slow-mode;
				status =3D "disabled";
			};
So I would like to remove this row.
=20
> Given that Macchiatobin will still use slow mode, why remove the
> marvell,xenon-phy-slow-mode property from this file?
[KP] Agree, I will keep this property in Macchiatobin DTS file.

>=20
> Also, if you're upgrading ap80x.dtsi to use a bus-width of 8, why keep th=
e bus-
> width specifier of 8 in the board files?
[KP] The bus width is updated in A8040 DB DTS. This board utilizes 8-bit in=
terface.
The armada-ap80x.dtsi file does not specifies the bus width since it is boa=
rd-specific.

>=20
> This patch just doesn't make sense, and your responses to our points seem=
 to
> add to the confusion.
[KP] I am sorry about it. Hope my last response clarifies it.

Kosta
>=20
> --
> RMK's Patch system: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__www.armlinux.org.uk_developer_patches_&d=3DDwIBAg&c=3DnKjWec2b6R0
> mOyPaz7xtfQ&r=3D-
> N9sN4p5NSr0JGQoQ_2UCOgAqajG99W1EbSOww0WU8o&m=3DV27OOcgNqKN2
> WrlW2YFvHm_D_dXoP44wPd5zyOKvEBk&s=3Do3OrmStt1ZuXVNlYklTV_b1wY35
> NvPPrdLqwGgtxRZU&e=3D
> FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
