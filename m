Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F5C30DD41
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbhBCOv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:51:58 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:31358 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232881AbhBCOvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:51:42 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 113EipR9027857;
        Wed, 3 Feb 2021 06:50:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0220;
 bh=meLDh7ADd6zHm9SOgdq7TTNHgUXn67JJeezumY0X6Xg=;
 b=Del9UJHjoW1eg24Q9QDgiLoVgJVtkNKyjes/uVowVi4goJNiSbG0ZENSqOMl8FUlHKAw
 tXNfu5FdYbafJekY9QhoxbdohOOHaxuFTbJaJ/JrwLj6UNzJ9LE2PhAeJqco3G+dcStF
 Xpfy5pXisy2YXEwMCOesDHMsz0N3o0eL165COjRkyWaBbLl/k5oAVWZWToCvr6qx8V6g
 c0bEqses4kSvjjeME41wUDM315aOxunEf5QNhrhrHwzfq9ALPndqR2BTxBlAtdgdVOsD
 gx/gGtz8ZkS3EBVhsDNqsZLGWAWfAYCzEUmGePBPFYQLc8oGy4BVS0HV7Crx2bj6W1KX ew== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 36d5pt3h1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 Feb 2021 06:50:49 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 3 Feb
 2021 06:50:47 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 3 Feb
 2021 06:50:47 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by DC5-EXCH02.marvell.com (10.69.176.39) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 3 Feb 2021 06:50:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZm5eO5kRe3z/BXDA+PGLTo6piKRZP1UoSox/iDCiIxIxS2RAakTUje7YMYLvlK60wMHY5NkUUD01NDgtYUlE9UM2eEYk+aGFGioKSkh/a2g2FBmobt5izt3HeAqfXHqxt+tbtPsT9nhD8eZfDt+NsoRdrA0KTltAeMMmovbFNJUdw5yrGJ/RMWZDx1pGycmoQq9goEoq9NOB8MJGugyg4eta+L9NYfF1SkoXS4aUitIlunXawfIX34+nn3WzkMOX6ANjtmBbi0o2sx0Pq5x5btnsAlpi4Y/jCiCw1w6GilIqY5GujIvh8ROWile0tme9Fhcmmy9biaetl+De5P1qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=meLDh7ADd6zHm9SOgdq7TTNHgUXn67JJeezumY0X6Xg=;
 b=AMrW4/qZ6ScRUjSvp6kDh9UAvxHMIryZ6rjJCKQavCZLvkRGBqmZWZaBlQA92iwIPoZo4V47lum73orKBVOnasolLG2oRZUdd2eJzt6j5H9ZGCyryjQOK/K43QRKMl3GLPwxHuVJZb7VlLKDV+XPCEbN3ndDv2LYlxDqrUL3sXQHyUBas51c2GasScYCqs/80Lyz/mKEJWqPNc8y4WVpRgxDy8lYRlWwzLkV2jNICsDxBJFiaM3tHiw2dSSXsKIawTykHAiGI7170X9KrlgcuZl60MVEZgEZbdqd8LMeD5bz/Gvmdl6xlIsqUBtMWG0bMwBTInMxIdmAujnurJIDuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=meLDh7ADd6zHm9SOgdq7TTNHgUXn67JJeezumY0X6Xg=;
 b=ieUyOKvEUsBn0yb4cc8FiZaPyIZHEjNZDXdKptv2OI8biQFJp8XFEAh5SOwEl9+LeAWVs4176JF+MZS5MqmLKsE5VWlx9XJXYke1TGiwkwaKJyUkrckb0HcHzYBHbl+gVKUYo1052txxGenGO0gTgobD3szn6CGMMCpNbs5Rkg8=
Received: from DM5PR18MB1452.namprd18.prod.outlook.com (2603:10b6:3:be::12) by
 DM5PR18MB2326.namprd18.prod.outlook.com (2603:10b6:4:b9::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.17; Wed, 3 Feb 2021 14:50:45 +0000
Received: from DM5PR18MB1452.namprd18.prod.outlook.com
 ([fe80::e8a9:1188:a4f8:8a57]) by DM5PR18MB1452.namprd18.prod.outlook.com
 ([fe80::e8a9:1188:a4f8:8a57%4]) with mapi id 15.20.3805.027; Wed, 3 Feb 2021
 14:50:45 +0000
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
Thread-Index: AQHW+jD04fJzej2FY0aIGyOLdCg1f6pGdPSAgAAJqBCAAAGXAIAAAY2w
Date:   Wed, 3 Feb 2021 14:50:45 +0000
Message-ID: <DM5PR18MB1452A6CF26E3A54730872A14CAB49@DM5PR18MB1452.namprd18.prod.outlook.com>
References: <20210203133138.10754-1-kostap@marvell.com>
 <20210203133138.10754-3-kostap@marvell.com> <87h7mtckxe.fsf@tarshish>
 <DM5PR18MB14529A28A31785A574A4DEF5CAB49@DM5PR18MB1452.namprd18.prod.outlook.com>
 <20210203143851.GR1463@shell.armlinux.org.uk>
In-Reply-To: <20210203143851.GR1463@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: armlinux.org.uk; dkim=none (message not signed)
 header.d=none;armlinux.org.uk; dmarc=none action=none
 header.from=marvell.com;
x-originating-ip: [77.137.153.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97aa6032-e5c4-47a4-5aa8-08d8c853166e
x-ms-traffictypediagnostic: DM5PR18MB2326:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR18MB2326AF435AEE0F36A9F082BECAB49@DM5PR18MB2326.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qIKU5Q4yDz+fdE4ucSyrNyYWe4cicUnkOHxJ7xMnAchfjamrbpDkUEbFr4g+ke/Yi1ftB1mzk3DUGESg3slQZV0H7llPhMQaFDUy5ww+E2OwcfU+zvOGxXwWhBjaias7FYWKDsQ1tz2BznZy+OZI+IaGU32Qu7Qkk0qrFiFhCJxSCTqXpiO2Lmw55cd9U/wepqdQ38wJfz+FOv0r5VPixaVSv/NEj3we8RDYwDAholsMWy6HPfFG6xDwGjBNuO4tyKQO0y2Sv/tca4d+i7EnfDDRY+slMqBt/8/0OZS+I6+e5pAcNi3Y2B8Z/iOTS1QIf9SEgFYTDPadMpyvd5PZsVbeGcoji/5b+VyxDvtYUiv3+tFX9FkolGKI7IVTly25z1K/5t+oWTCOU8cb4gyOFXTqYA/V8WrT0qzPpAUugnH4D+Xj3VQF6mhuY0btcGeTjAP0GSHqnPkZch1cEGToJmVnN0Kd2K/GjumoUNMkzEDgVBamqo7FR6+vv5y80+8zVGDr6xCJ+AmhvL7xAdB+AMjfrW1fRHXrs40G3Sj4DKM+rJT0lDyjQV2DF/u6t9wuVDapXj+ZHvlCNipztRZxVFnbyWCjxXWTb9ksqxI1/Z4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR18MB1452.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(186003)(2906002)(8676002)(86362001)(15650500001)(7416002)(33656002)(83380400001)(26005)(966005)(6506007)(53546011)(8936002)(71200400001)(478600001)(5660300002)(64756008)(66476007)(54906003)(19627235002)(66446008)(52536014)(7696005)(66556008)(66946007)(6916009)(4326008)(55016002)(9686003)(316002)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?2G7lOsdU0gGEy/g+sBfQejQgAL8NzT+pLhtb926ivWCkeFxtgYQy6EpeQ8te?=
 =?us-ascii?Q?/dI4U9iscIi0OcawXIJOJJLtsbI5dxWbkeitOt3lPxyJ/6t01WrYL8IpduIM?=
 =?us-ascii?Q?w6Jmiztj3siKJAzi5AXJMqESyQq5XK6WP4OOcAtL/NM33qzmNQi/fy1sEps+?=
 =?us-ascii?Q?CESMRvgndInjrdTzTGsKrEOZ+5W8NPiUX9OefGVov++aA6l1wfVKCEDWwdww?=
 =?us-ascii?Q?L3/bmXLzjRkHQvBH5okzgUFYtxdpe3hyr1fSuPV+AmCiFVUCifLpmriH0jdN?=
 =?us-ascii?Q?Z2lDag0tV5U4RqGx4kzOpo4jQcYJz7i4KK7wbhO+fj8HMM7LKDsdnHfNDGts?=
 =?us-ascii?Q?wSGIrQ/2VLkYOl4RvW0hfyvxN0UIE3meUCrXMlHJQ6tlMVJDuBBsLy4IHjKx?=
 =?us-ascii?Q?bDnoFCvRjGgx8LoQhKkNWDDZZKnGlAfAdIPyeMlh+L3bt+6oqAqmq/xL6+Fq?=
 =?us-ascii?Q?h4IwojYmXz6mkcJGBHfOu9DMNkKc0d4ZrYuiSgKOUe16I9qhc76s+v92Ol/l?=
 =?us-ascii?Q?ZQx3zxaeJioSynwUms5hCSVGzyv5pSQeSU8/qyu76qy9nWMzuUSHFn9+J7ow?=
 =?us-ascii?Q?1TgMyRZ+E2Pdz8AJ6MCz9NOf39Ar3B7BxhqhvvUaaEdZO1OVVSVl08wCDWAd?=
 =?us-ascii?Q?EQyaUu41jWnlsRERveaQcsVbnsQkkdloHhZPQMZCvd1wo0yPI6lPTsYdVL7j?=
 =?us-ascii?Q?v4woNoL1IyYqDSvu2y0/aCoEM/i31/9LyvxLHSKLS30EA4MJ6P+SObQQ7RAi?=
 =?us-ascii?Q?xidUBkuiIuLc3lnKhR8SC1IE5uGy0zmvEH4eulpSBZWaeitF/8thcnsKBTgF?=
 =?us-ascii?Q?XoajMtrL5u7Irvriece/bd4IJ5GpzxrJeREkF5NjWtHKlhXE4EveNSRfPRBM?=
 =?us-ascii?Q?T0xU2/tBUrjs5P5vYSe3AFT7SShdcipJ8UkjgcvPRBnfrO8a+Jyb8k/Irr1S?=
 =?us-ascii?Q?2FIeqEIVDK0+LhjC/wqmiQmTT1zj0xT1/1F3di8fC+ZmrwSAgE2+wIZjMdlv?=
 =?us-ascii?Q?dBxXzeTxV6nUybDSe3wiz+xshripnrZcOygtVNSR2znesHuUyYwnpE8eJrt4?=
 =?us-ascii?Q?1nCkUUDl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR18MB1452.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97aa6032-e5c4-47a4-5aa8-08d8c853166e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2021 14:50:45.6227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gp6iP412JFodkI1rBAd4Bm7HjjbPqC/rCzk3eEGRtWh1IMN+yROpRtnVvwKawrDgJiFiAkojW70AKCCwye0WHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR18MB2326
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-03_06:2021-02-03,2021-02-03 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
> Sent: Wednesday, February 3, 2021 16:39
> To: Kostya Porotchkin <kostap@marvell.com>
> Cc: Baruch Siach <baruch@tkos.co.il>; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; andrew@lunn.ch; jaz@semihalf.com;
> gregory.clement@bootlin.com; Nadav Haklai <nadavh@marvell.com>;
> robh+dt@kernel.org; Stefan Chulski <stefanc@marvell.com>;
> mw@semihalf.com; Ben Peled <bpeled@marvell.com>;
> sebastian.hesselbarth@gmail.com; linux-arm-kernel@lists.infradead.org
> Subject: Re: [EXT] Re: [PATCH 02/11] dts: mvebu: Update A8K AP806 SDHCI
> settings
>=20
> On Wed, Feb 03, 2021 at 02:37:22PM +0000, Kostya Porotchkin wrote:
> > Hi, Baruch,
> >
> > > -----Original Message-----
> > > From: Baruch Siach <baruch@tkos.co.il>
> > > Sent: Wednesday, February 3, 2021 15:59
> > > To: Kostya Porotchkin <kostap@marvell.com>
> > > Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
> > > andrew@lunn.ch; jaz@semihalf.com; gregory.clement@bootlin.com;
> > > linux@armlinux.org.uk; Nadav Haklai <nadavh@marvell.com>;
> > > robh+dt@kernel.org; Stefan Chulski <stefanc@marvell.com>;
> > > mw@semihalf.com; Ben Peled <bpeled@marvell.com>;
> > > sebastian.hesselbarth@gmail.com;
> > > linux-arm-kernel@lists.infradead.org
> > > Subject: [EXT] Re: [PATCH 02/11] dts: mvebu: Update A8K AP806 SDHCI
> > > settings
> > >
> > > External Email
> > >
> > > --------------------------------------------------------------------
> > > --
> > > Hi Konstantin,
> > >
> > > On Wed, Feb 03 2021, kostap@marvell.com wrote:
> > > > From: Konstantin Porotchkin <kostap@marvell.com>
> > > >
> > > > Update the settings for AP806 SDHCI interface according to latest
> > > > Xenon drivers changes.
> > > > - no need to select the PHY slow mode anymore
> > >
> > > Why? Has anything changed since the introduction of
> > > marvell,xenon-phy-slow- mode?
> > [KP] AP806 B0, AP807 and later do not need the "slow mode" set by the
> default.
> > The HWE-7296210 errata is not applicable to these components and they
> > are able to run  AP SDHCI in HS400 8-bit mode.
>=20
> So what about all those people, such as me, who have A0 silicon on their
> Macchiatobin boards?
>=20
> You can't just go around removing DT properties like this.
>=20
[KP] So for older systems this "slow mode" parameter could be set on the bo=
ard level.
When it is set in ap80x,dtsi file it downgrades all systems to HS-SDR52, ev=
en if they support HS400 on AP side.
MacchiatoBIN AP eMMC is connected to 3.3v regulator and has "no-1-8-v" flag=
 set, so it should remain in low speed anyway.

> --
> RMK's Patch system: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__www.armlinux.org.uk_developer_patches_&d=3DDwIBAg&c=3DnKjWec2b6R0
> mOyPaz7xtfQ&r=3D-
> N9sN4p5NSr0JGQoQ_2UCOgAqajG99W1EbSOww0WU8o&m=3DyMC9YPQXZUm
> QPwlD7KCTVoVTPXCTQwTXD2yVsAo6sxA&s=3DOuBO2QArzHvV4k_vsNZdmSoDX
> rL4Q_voTqxrlYU6KKE&e=3D
> FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
