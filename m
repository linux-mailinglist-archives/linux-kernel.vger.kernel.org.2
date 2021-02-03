Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C8430DD98
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbhBCPGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:06:11 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:31250 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233870AbhBCPEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:04:51 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 113F0twq023857;
        Wed, 3 Feb 2021 07:03:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0220;
 bh=RHMi+5A3IYjvHuNaCpgjEfc8s5RpLuUmwaB5V2cQHHw=;
 b=fZaIYKQrdHPOY5GHABKWe8THfHYaV28z1tuEhUKlab2iTScYJCHzB0BucFtrAP9J52MH
 qu3ZDG0QhIKetNw15+IBvnGpnujHiH4rdByExEyVcD+IGZzVffukD0qI6mF+35+pXuot
 70rXv2ifXZa0WQ3oyx06VahcN99eTafrxpr+Ok+Jk4kkayHKkSkLaDkJa/KPIli4+kSE
 xhwKd58irRvQyb0XXJ3hJ+k5CUnQYiIWHRotC7jXuamgBOByXKk5XP6vA3VONpFK/oRG
 HgyVsyOTaHod+cCv9DUK981ZyVu6Yekbx5+TXz08XzLtBlcC/odfUo9559b9xchO4PLP jw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 36d5pt3jhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 Feb 2021 07:03:56 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 3 Feb
 2021 07:03:55 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by DC5-EXCH01.marvell.com (10.69.176.38) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 3 Feb 2021 07:03:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k46AYIsjcv3+2J1P4VZSNhe5r4wTd+y6mkQfPlyuLAF10p4lbS4TffLlLDIzGkha89u9QewLh35KwfJRqEwTa5sEXiQTEaUDrYbB5jGME0qHdOp0MMlnad1p0sAibpUNgfKbbAm9mPN/VucVxABF0DtbvZQcfT/HFOPn1MNF1sfh0NPWPNJQ27S1Sv17MqgJuvAHixOvfN3nWMtqAeyyDqEcAGJpusaYHjZia3WbTpAdkVSUdL0s4qRx6pMXSf9IkOTp3Gc6G5swDMa4ge2T2BXTEO10ponyYKkmdfQ18IX2P0f1cWjn0ApPAXZRG/30wvy19RKwqA8HVbeFOehCWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHMi+5A3IYjvHuNaCpgjEfc8s5RpLuUmwaB5V2cQHHw=;
 b=SdGVGH7jYoADjku0GO3KxMYWDmxZPMkhjh2lcsgVOdGjdqdp/J5R0QZPjEsh6mAiT6quIBC5Zmp40jVvEZx+nCtvlGmZySkNe2UIAQb5LZWMn4FoyNVDZnWtx6Z+B9kpCfPO5BjzjYTatvXKZcKMNAbAEHOA9nUjgprO1V8ul7vly95D95vyfGVsQxJoKvh+QcajpTGVbvy4UDRFshfobO2Y+m5ARLFwkZaH0bhRBWN8+9ADoY2AXtsq1QQdb8JdlXtXkWyT4uf+8jT3yM7P/3fOjX+gWnVvxEGP3/C5G2AIaW95/kNFEiDq2kkwXTHL7PAs1Kiy3c1Bnh8oar7B1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHMi+5A3IYjvHuNaCpgjEfc8s5RpLuUmwaB5V2cQHHw=;
 b=V7xJAf2+pIpTbiN9/fkBHJ+KmWkLOkCvfFOLJGniqMuw9hR0GwN3U3/FqntyG1xk4ewKj1lYGhdx8rP6SRsyOc7P8mx7yhzH7o6AuUVsZl+QFzHv7ruE4ko8sGmxOZLNb7uuYjr/d/XFNyZVNEPMDuysNfuj2Y1TPD4ZnNyNN8s=
Received: from DM5PR18MB1452.namprd18.prod.outlook.com (2603:10b6:3:be::12) by
 DM5PR18MB1067.namprd18.prod.outlook.com (2603:10b6:3:2a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.16; Wed, 3 Feb 2021 15:03:52 +0000
Received: from DM5PR18MB1452.namprd18.prod.outlook.com
 ([fe80::e8a9:1188:a4f8:8a57]) by DM5PR18MB1452.namprd18.prod.outlook.com
 ([fe80::e8a9:1188:a4f8:8a57%4]) with mapi id 15.20.3805.027; Wed, 3 Feb 2021
 15:03:52 +0000
From:   Kostya Porotchkin <kostap@marvell.com>
To:     Kostya Porotchkin <kostap@marvell.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Baruch Siach <baruch@tkos.co.il>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "jaz@semihalf.com" <jaz@semihalf.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nadav Haklai <nadavh@marvell.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Stefan Chulski <stefanc@marvell.com>,
        "mw@semihalf.com" <mw@semihalf.com>,
        Ben Peled <bpeled@marvell.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>
Subject: RE: [EXT] Re: [PATCH 02/11] dts: mvebu: Update A8K AP806 SDHCI
 settings
Thread-Topic: [EXT] Re: [PATCH 02/11] dts: mvebu: Update A8K AP806 SDHCI
 settings
Thread-Index: AQHW+jD04fJzej2FY0aIGyOLdCg1f6pGdPSAgAAJqBCAAAGXAIAAAY2wgAAFH4A=
Date:   Wed, 3 Feb 2021 15:03:52 +0000
Message-ID: <DM5PR18MB145253440ED941AF64C68A84CAB49@DM5PR18MB1452.namprd18.prod.outlook.com>
References: <20210203133138.10754-1-kostap@marvell.com>
 <20210203133138.10754-3-kostap@marvell.com> <87h7mtckxe.fsf@tarshish>
 <DM5PR18MB14529A28A31785A574A4DEF5CAB49@DM5PR18MB1452.namprd18.prod.outlook.com>
 <20210203143851.GR1463@shell.armlinux.org.uk>
 <DM5PR18MB1452A6CF26E3A54730872A14CAB49@DM5PR18MB1452.namprd18.prod.outlook.com>
In-Reply-To: <DM5PR18MB1452A6CF26E3A54730872A14CAB49@DM5PR18MB1452.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [77.137.153.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c60da55-2355-49d7-5b36-08d8c854eb68
x-ms-traffictypediagnostic: DM5PR18MB1067:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR18MB106792B101407F7B46953858CAB49@DM5PR18MB1067.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:972;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FYGgQd0q6SxQC/PObGDb4Ymc2ApF1PRvhTrIl4xeSKElaYKImWrubrOq9EQo1nwcF6Zm707Cok5ugAnM0NseXkGosXDzju2eiE+/sh6OjNjcict8ycetmZ5PoX5MluN/Lcr57oFZGF+QY2Rb2v+n+X6r+dUn4MfTpaHi9Z1hpa/HskCdwJkH0W+oOT1FuDfW5zDK7JV0oztPdqnshAzIxRy4M49Ps1doyLkrZeACNy/lbTHn0QeK/ILOvx00tJ4h8oOQ3eugMbnWm648oYnJ5wzr5he6pa5zZcAg6yxnzQ68+mGuTV6IYEFh/Z+YJsc7IGJk0vwoUWOIaS2t6Jd74NsBSkSe2WrShWAq4JofaZeQiJvrz0WovB6JcIPWLndRWxlKqjYML8VuCHw3AdREogoPyO+6o2OQeTXAk4wF88q0mt2qai3vkpCSyoPphYaSzXEJWED71MEtyfrNZoZVZJMqlRLENNWlJksTDbNr04GHHiQJw88kSbQ82+i0r4bn0g64bVtd1AiYzBFKaMtDx0cK4lF62v7veDHZMA+rrw0DC+xFGYR4uuhm/GCG6/WJex5jjehK2OrUFCQ+FhIZHMoB34bX8n8Tspcut5neOlY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR18MB1452.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(86362001)(9686003)(15650500001)(5660300002)(52536014)(2906002)(966005)(83380400001)(316002)(64756008)(8676002)(76116006)(66946007)(19627235002)(55016002)(2940100002)(33656002)(66446008)(66556008)(66476007)(71200400001)(8936002)(478600001)(53546011)(6506007)(26005)(7416002)(186003)(54906003)(7696005)(110136005)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?5XApg3Yp6IpfN/t/3PfVlX7a1vwLiz22KpaDq0tECpH4pZ4sA1mZhz4vTJHo?=
 =?us-ascii?Q?ua8yWmxAks0YKf1z0DW6puVQafdafvL9LzPF5rorUiN4NLrcgR26Mpzs/BAO?=
 =?us-ascii?Q?9+XOQYE6A04ZWF3n/aozf7GpIYYm78ffFuRO67tTAcfKLYG8WdR9tOO9B9+z?=
 =?us-ascii?Q?IuLiBieDiGaJxc6CuqWO4/O1S/w/lMmUFYVQGrWFTvbRtHSEpChvac7bt0tb?=
 =?us-ascii?Q?reIsY85R21WQBLqt1iebi067CBoMeFaPPrxvVJ4TLF1MmpBKtwSVfjTGq0SY?=
 =?us-ascii?Q?jCjFG5XUV/FQpRj+38KQzTNmCCtsFXvRiUZUbiKwdHu4vseYF1F5RBvDf7Nu?=
 =?us-ascii?Q?hOTpOEl1JcRPGXkTSO6iJZHO+Bj7TqqsX9h22HU29tFUomO+0TOFQxlYaykn?=
 =?us-ascii?Q?2b0RVjnJDC0Aa6bbR1JTJvY6U220rgeG+b5UoqTuZT4luoOxAIDTrOLkn7z4?=
 =?us-ascii?Q?lWCIadGtJhrWTT2z5ufnrIdVSxSZh7bdqZHzoiC5m3S7maqrl8OHkhfWI2Ur?=
 =?us-ascii?Q?p4mSgysJvLRH5FJYcLQUBrsNKsruZOjub/+f2TX25rXmgpewlfonsiUNZ3nR?=
 =?us-ascii?Q?P05z32ftQbxpsPTYC+UGnj124I7Ljz/5duqtfWvofmHZUImNtpMb5RnJX0i5?=
 =?us-ascii?Q?7HQaTQfoCpTBwgTVzWOMtPUp4Suxumso25sDM9ewZkSJnRfKGa7yHLhTsTuX?=
 =?us-ascii?Q?A9SDIS5Qs+S4alrvwpmvY43/98oBrdqPU5Nf1TfHS/Vj7WQQOaWDmISw7IlW?=
 =?us-ascii?Q?MU0M7vgmm2hCnoT1tkt2Sufiessx4W1fLrP7Qo1b0xKV/5r4BmZb060PTawc?=
 =?us-ascii?Q?hfwFCnixZlPC6rCulypefXxQNjarcj6Wd6Tr3rigNErD/FTm5YRFzHp19whM?=
 =?us-ascii?Q?QFk+elrHaSm+rMuptNsrUsGkYFrsTHduC8MGfgWaHvaKnL3tWUVZRJOqX/W1?=
 =?us-ascii?Q?JrJWpIlKXsprFs6gOznevyjL7eCYwW9ggMV8wTnncEkRVBtA7lCRvsA/uFaW?=
 =?us-ascii?Q?uJctXFUbQBbcye1EQjek+8LRNuOgPv/wjaezlVqwyFYlIum6eqKoYCk68B4E?=
 =?us-ascii?Q?oNKBnAaW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR18MB1452.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c60da55-2355-49d7-5b36-08d8c854eb68
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2021 15:03:52.3378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OdTmWlRHiJsfFpsTWxadk/ZeM3xxZNvXdhxJxzpmNQQLGLLc0EisSVRdZtEdobIMCiCNbJtKG9aJhEWepNB17w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR18MB1067
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-03_06:2021-02-03,2021-02-03 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: linux-arm-kernel <linux-arm-kernel-bounces@lists.infradead.org> On
> Behalf Of Kostya Porotchkin
> Sent: Wednesday, February 3, 2021 16:51
> To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
> Cc: devicetree@vger.kernel.org; Baruch Siach <baruch@tkos.co.il>;
> andrew@lunn.ch; jaz@semihalf.com; gregory.clement@bootlin.com; linux-
> kernel@vger.kernel.org; Nadav Haklai <nadavh@marvell.com>;
> robh+dt@kernel.org; Stefan Chulski <stefanc@marvell.com>;
> mw@semihalf.com; Ben Peled <bpeled@marvell.com>; linux-arm-
> kernel@lists.infradead.org; sebastian.hesselbarth@gmail.com
> Subject: RE: [EXT] Re: [PATCH 02/11] dts: mvebu: Update A8K AP806 SDHCI
> settings

[KP]=20
> > > > Hi Konstantin,
> > > >
> > > > On Wed, Feb 03 2021, kostap@marvell.com wrote:
> > > > > From: Konstantin Porotchkin <kostap@marvell.com>
> > > > >
> > > > > Update the settings for AP806 SDHCI interface according to
> > > > > latest Xenon drivers changes.
> > > > > - no need to select the PHY slow mode anymore
> > > >
> > > > Why? Has anything changed since the introduction of
> > > > marvell,xenon-phy-slow- mode?
> > > [KP] AP806 B0, AP807 and later do not need the "slow mode" set by
> > > the
> > default.
> > > The HWE-7296210 errata is not applicable to these components and
> > > they are able to run  AP SDHCI in HS400 8-bit mode.
> >
> > So what about all those people, such as me, who have A0 silicon on
> > their Macchiatobin boards?
> >
> > You can't just go around removing DT properties like this.
> >
> [KP] So for older systems this "slow mode" parameter could be set on the
> board level.
> When it is set in ap80x,dtsi file it downgrades all systems to HS-SDR52, =
even if
> they support HS400 on AP side.
> MacchiatoBIN AP eMMC is connected to 3.3v regulator and has "no-1-8-v" fl=
ag
> set, so it should remain in low speed anyway.
[KP] I also forgot to mention this code piece in Xenon driver:
	/* Disable HS200 on Armada AP806 */
	if (priv->hw_version =3D=3D XENON_AP806)
		host->quirks2 |=3D SDHCI_QUIRK2_BROKEN_HS200;

>=20
> > --
> > RMK's Patch system: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> >
> 3A__www.armlinux.org.uk_developer_patches_&d=3DDwIBAg&c=3DnKjWec2b6R0
> > mOyPaz7xtfQ&r=3D-
> >
> N9sN4p5NSr0JGQoQ_2UCOgAqajG99W1EbSOww0WU8o&m=3DyMC9YPQXZUm
> >
> QPwlD7KCTVoVTPXCTQwTXD2yVsAo6sxA&s=3DOuBO2QArzHvV4k_vsNZdmSoDX
> > rL4Q_voTqxrlYU6KKE&e=3D
> > FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> https://urldefense.proofpoint.com/v2/url?u=3Dhttp-
> 3A__lists.infradead.org_mailman_listinfo_linux-2Darm-
> 2Dkernel&d=3DDwICAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3D-
> N9sN4p5NSr0JGQoQ_2UCOgAqajG99W1EbSOww0WU8o&m=3D8f-
> 1fnISJVHCS4gZTeFgRPXGPiwBevUsFbmYDBmkRWM&s=3DRBlEEUXG0sOmZHsQ
> Omurf018V8kSE_IMZR7bDLVJ0FA&e=3D
