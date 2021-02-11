Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD554318D26
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 15:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhBKORY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 09:17:24 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:43430 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231208AbhBKN60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 08:58:26 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11BDuEJI025687;
        Thu, 11 Feb 2021 05:57:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0220;
 bh=0iYa5Ik9Bf/TZn6cGnLpGbhpID2UTQl7nEcw/FleoWY=;
 b=cfB59Zgri+Qlrgzbu1hPGM6IB7FZqUz0I4DvUKIAa3/7ia1VhmaM1uLAnRQeKwATpYSb
 Pz6eaAi0/CIKtHXqfeK2NjF3R36HfND3FMlOan+vk+Ncd6XfzoA/Z0gedYP1V1/cWGK5
 KNWylXPwoFdWC7SJMSdRreHkSHTxg8qbjxi/zxF9sDTz1cyao64Mz28wUkfg8IDjKOSs
 h2teZwb6cc/iuwUIJ126+bO9YF+GfUB3fBb8UpjuIrZixMIcYhozKItgOLdf1X3+y/A9
 yJ8EdabE9IkLuQ50Wd/IE4/Bo/5UvptAbnxGll/+lVAoDqUksxHf6Bm+jhfutT80QFEG Cw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 36hsbrq613-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 05:57:29 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 11 Feb
 2021 05:57:27 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 11 Feb
 2021 05:57:27 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by DC5-EXCH01.marvell.com (10.69.176.38) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 11 Feb 2021 05:57:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JexGAasEvxo/qMBeehwmtRABd2gV4BravLYNv+LAXQTGlbFFQaG65KF+v8Q3Q6RCsBz6z+2gjRj2VxLz9rx3y6ZqusqLWb8DFd4389FOkA355WRdNdD5lYfWNs2G5JVng/xfHy482Lyc/gzXjc+Ndm4HZp051JJIUjx2S7Tn68CwEMc4DTGjvzuZ460F5FaObq38GzrGwCzBDP1avwxRA/C+Bvg+I9NCchAVKYZq00zgRC5qsUYVXvKAWWlL237btYyTBbHpSpVaHBhZcUE7R3+Di6PR7adgjyoRHFbYKd1M51oCUBAi1OfAYgyjg6FRGidIRP+RI/9b5oyiwEoRdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iYa5Ik9Bf/TZn6cGnLpGbhpID2UTQl7nEcw/FleoWY=;
 b=FZ9hUOV6+BBu2/1TiJK47COQsO4a24tgGThPeQ2kou11iP61YVM7tRAyoCUBKPFhxkpB2HK+lRQbzdQ3IjeQSLf4xYpTt8IDLgXblFuwyVIQI0YRf3OIPcSMerV3uZXdblIBY7qrWOkRHZNatTdXGYriS+vdbQQG8ezC8Eg32gCdGYgAfXWCRwbyRXqUoKFIJHz3xSw06dGAgyF0Vyh5BJGsxNAkuAXr6Frr1FI97cQb2/k5UEIbT5NFKwgHYx5b1vG7rTv7suq/SSenGXzn5xOny8608n8Sm1APQzjjqAdu2aZnAqNYCq7wCxr0Uuv228//MpFWSst/Z11ydiBo8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iYa5Ik9Bf/TZn6cGnLpGbhpID2UTQl7nEcw/FleoWY=;
 b=AA8JSq1PW2fnp7LxV3HJLt9wgjGUcALGJUOwrQBElN53Xvnebm6chE+Oglm6LZKQYgY9v/jIjCvwnODFVhzdD8eZA+sBGjVoYV3k8UiROEvP5MycEOdt2/PRF89QrAeEW7/bjYYOGKaCNP3Jh/u67zoX3CvzBIix29R3pCoTZes=
Received: from DM5PR18MB1452.namprd18.prod.outlook.com (2603:10b6:3:be::12) by
 DM5PR1801MB1930.namprd18.prod.outlook.com (2603:10b6:4:62::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.19; Thu, 11 Feb 2021 13:57:26 +0000
Received: from DM5PR18MB1452.namprd18.prod.outlook.com
 ([fe80::e8a9:1188:a4f8:8a57]) by DM5PR18MB1452.namprd18.prod.outlook.com
 ([fe80::e8a9:1188:a4f8:8a57%4]) with mapi id 15.20.3825.033; Thu, 11 Feb 2021
 13:57:25 +0000
From:   Kostya Porotchkin <kostap@marvell.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Jon Nettleton <jon@solid-run.com>
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
Subject: RE: [EXT] Re: [PATCH v2 01/12] fix: arm64: dts: replace wrong
 regulator on ap emmc
Thread-Topic: [EXT] Re: [PATCH v2 01/12] fix: arm64: dts: replace wrong
 regulator on ap emmc
Thread-Index: AQHW/7Zxt24oayXyI0uXyCrLQTNSLapSyIYAgAAzcpA=
Date:   Thu, 11 Feb 2021 13:57:25 +0000
Message-ID: <DM5PR18MB1452DFBCDCE970384339545BCA8C9@DM5PR18MB1452.namprd18.prod.outlook.com>
References: <20210210140949.32515-1-kostap@marvell.com>
 <20210210140949.32515-2-kostap@marvell.com>
 <20210211105222.GY1463@shell.armlinux.org.uk>
In-Reply-To: <20210211105222.GY1463@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: armlinux.org.uk; dkim=none (message not signed)
 header.d=none;armlinux.org.uk; dmarc=none action=none
 header.from=marvell.com;
x-originating-ip: [77.137.153.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 328696c6-5d4a-4150-9b10-08d8ce94f68e
x-ms-traffictypediagnostic: DM5PR1801MB1930:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1801MB19307F1C48E2B0920E1BC249CA8C9@DM5PR1801MB1930.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1xu3OOLS/ESIgjIf/rFX1VIiaRTiKYRVKtcaIcjW2bWho53MYgKyzBV8tlG/qno+5kUYgutxtWuyLcTknSiz/ezY6N9mCcpqhfojmYsKRRmVgMhdqF0yv50ID3R62nfPPL/0ZSJJ2vFB+4/fCRmh3xmbvoU0dWYVhvZUkHcOl6VB48DuVF5MJ3/RYQYCjEJ96+3WXUVifbhG7Pz5X4YOckm5VTL3MvDBELAKSAcMRxi7wPT4cplSiAxHhhcB6oZZLKfnyNWKQi4JzrjufUWm7iUwtU39JXSPdhvVpVQEGXdOOnlDPAj+uCxDC3QcUKcOD7Xd72DAzdUYk/s43o/TMhdqIvwZfX7Of6LQoqQkEmdEZxdVo2Q7mYKh+29Rf2RVccSNiZhVFQMeUFHkanatCSAp3sbP02LXrdrKDxOLWXEhiXGdy41L0M2asD1Q68kDB3WngW3VXndByzHV04gR/d4+OOGrlgjJ7l3JEq3Mj1jpvTsh6NRCC0kJ13jJ8ymlyzrWQYnKW29uY8JfoPwh6tNTHLhY99seRlLdQhy5CZS/5//S4vAgcdTFB1IokCDlO20M/Zjju73D0tRrWg5sqS6Ha3Zs1M+9zmK27ZJ1fdU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR18MB1452.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(86362001)(478600001)(26005)(7696005)(5660300002)(76116006)(186003)(9686003)(19627235002)(8936002)(66946007)(55016002)(316002)(107886003)(4326008)(966005)(52536014)(71200400001)(8676002)(2906002)(6506007)(7416002)(64756008)(66476007)(66556008)(54906003)(33656002)(110136005)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?kOjc+XRgrPrQQtsRLyuFX9bUCiLTdKtKwJmi/inwnGMIUAwwBvRgu5drf2cO?=
 =?us-ascii?Q?j5fk+9dtVGlFLO27VXxnhVuEFMMe25f0mvy/lXNtfyph/lvMXJjCpJXfNIWC?=
 =?us-ascii?Q?0zvo3NVCrlpVVayMEcmjzXnATpRMrcpIVBAfM/25W3jRD5a0gK9+206tZE+/?=
 =?us-ascii?Q?V7+rZFIWWnWKJ7sXq5VJM+u/k3/fDGe5+5OyeZwPT578ATfCGwKSA83wnp5/?=
 =?us-ascii?Q?tB2Yy46DM5mxwrc/PnOPVbG2RIPhOX0IXEYUpTP417sk1b3eXlq6MJDzsb+E?=
 =?us-ascii?Q?4IPWCupSEBDxekSj/o7F7iMaEzovOjiHFfgMD1oPYO48wQmtsYjUJA0dpRxz?=
 =?us-ascii?Q?z8IvRIY4c5bxc5ZSLjtfsa7M3Iq8uhNiE/zB6yfJ3igJUdp8d8G9Z/ZvnR3t?=
 =?us-ascii?Q?8Ue+9REHbMH38omHQwu9V3LGN/0nf9GjZpuSkVH1ido8JmYRLcUpFpMD03pJ?=
 =?us-ascii?Q?DeJrE6CARbfD9cA0lUoktol3FpcEGHTKaJmIRDEh/GQTt5695C08wHFPppTL?=
 =?us-ascii?Q?OHZbRbyRRFKCWDLErRz/aHnveFllVvQHVBmwuvD+yYq24ci7TJQn2FDg6WS7?=
 =?us-ascii?Q?Zq+JsPB4fP7ehWmITfGk5QOYRnROcBktkzmbjwQRRXSOQTZGGVS3hvub1Q+H?=
 =?us-ascii?Q?eSSL+/lBhkAPVci7Itl3XeZPBHUGyBI1w754UqGjmeUv9QBJQ1wVIAzwTNJN?=
 =?us-ascii?Q?bBxE7XEwn3Cc8zbG7N9Ehz/+nEfSMhbz3AW9j2Go4PGV9FfWLggxaCvqsDYG?=
 =?us-ascii?Q?EFojQToKgDi+zvSgKwSTnIaJrPtu8h6l/duAbVpsHqGWQB19VST672zT64wm?=
 =?us-ascii?Q?x6Kask4LCeRoPasqwF1ggcZuCsS9zP0Cy6IDKfF2+CTeRkSZmZKBq5xbG3ma?=
 =?us-ascii?Q?esKYwP9wWnEOwQD/tEAnaWztv7Mz9HRu5AI77X4r5j0daOLCdW7gmvwC/WBV?=
 =?us-ascii?Q?R2pQp8k8TL2aRsbc1jV3tOyyB9lk7uxon33hnEIF0VezE3YnEIcxF0TYTABT?=
 =?us-ascii?Q?o86NpP5Zj0uGwdKdNpBlVgsinop527wIo62M/hwruFp9JrJdJ5QwciwTefIU?=
 =?us-ascii?Q?2eVcwPebWvoT1IOLzBuLRmpy7SFGH3j8Rd6pYX/RGyH9fUqfR/h11zq0N92B?=
 =?us-ascii?Q?H8qw/pK7JGajmjGsLReXHw15DXdbHCP4SBz+hsrBkSAwJriHOgrWYplU1nkL?=
 =?us-ascii?Q?Bv6wsLLvu3hpFpI4CtmzjgzmOicfiyRcdlU/jskLWjct6jhBtOEGmeqfxaPW?=
 =?us-ascii?Q?x1xKB3+y6HZcnkLuiXVFmOuQH11R6bmX45MT4R94d/tlY9d+vhrKNLlkr8lO?=
 =?us-ascii?Q?NbYCZQ3m6n6oOpnDnsg1/kEi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR18MB1452.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 328696c6-5d4a-4150-9b10-08d8ce94f68e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2021 13:57:25.8068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l2LoM2ZRbGMSNSfZ1oDqfaS6XUV/hAN6v1yMFPJ/VEr7qfuw2+JO/aCCxMeBXQd8MTes+6ePDbm05YYAR1qD/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1801MB1930
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-11_06:2021-02-10,2021-02-11 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> ----------------------------------------------------------------------
> On Wed, Feb 10, 2021 at 04:09:38PM +0200, kostap@marvell.com wrote:
> > From: Konstantin Porotchkin <kostap@marvell.com>
> >
> > Replace wrong regulator in AP0 eMMC definition on MacchiatoBIN board
> > with 3.3V regulator.
> > The MacchiatoBIN board has no 1.8V regulator connected to AP0 eMMC
> > (ap0_sdhci0) interface.
>=20
> There seems to be some variability between Macchiatobin versions accordin=
g
> to the schematics.
>=20
> The VDDO_H supply is connected to the eMMC VCCQ pins, and is also
> connected to the AP_VDDO_H pins. It is wired to the 1.8V regulator on rev=
 1.1
> schematics, but hard-wired to the 3.3V regulator on rev 1.3 schematics.
>=20
> This needs clarification from SolidRun before the patch can be accepted -=
 was
> VDDO_H ever wired to the 1.8V regulator on production hardware?
>=20
[KP] I will try to find a relevant contact in SolidRun for get this issue c=
larified.

Kosta
> --
> RMK's Patch system: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__www.armlinux.org.uk_developer_patches_&d=3DDwIBAg&c=3DnKjWec2b6R0
> mOyPaz7xtfQ&r=3D-
> N9sN4p5NSr0JGQoQ_2UCOgAqajG99W1EbSOww0WU8o&m=3D7JAOlRdnL-
> 42trjLrz_DOgZhvVuW8Skolb3bL-wJ6lo&s=3D9IB3Lxht5IQHTINpyLfX-
> KC8AmqqHn0cCSSuQuTvfkE&e=3D
> FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
