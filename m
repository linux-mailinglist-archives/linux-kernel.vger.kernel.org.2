Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8833BF677
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 09:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhGHHxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 03:53:08 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:62594 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229851AbhGHHxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 03:53:08 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1687jAXm017257;
        Thu, 8 Jul 2021 00:50:11 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by mx0a-0016f401.pphosted.com with ESMTP id 39nrnu0xwu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jul 2021 00:50:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rkp8Dvz8S0yxuOq0gZmFJt8UOJOkTO5AhxCxIDns/+Pmhy/9SOGeWM7wdcZDghkIdDs1OCX6CX/MO5Hzwg4cfuMs3CbcRYWkoUMjD1dxH7LYMRAZowdeGLR/grIgzcy8Hq5PNW2HLZKyc/dibPjtNdKvzKa82qh7sAU79t5iu7gqX8iim1/Vnuab1qPUitujniBLmlwNZ3ei5KV308dlkshMb8REYjzJoYbsIqAgHB0JNnffu9SCao7zqFij1O9UXr19cFnijLusyMX/lvhKQLzog0B1jV4w49yyIRaNKKV89eUQR5ooGdAXWzp2YKCq/2CC7RhmDllOx31ZMGXR4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BXAk5cIhWvtlbGEFPECEgzv4mBhIQ3kEOWi4aXxHzg=;
 b=Vtmsags7DVfkF8xXNWsXxxRPt/vLUDX846YI/bnYWvYjURZZ0lcoLaPkLH/kMedh3cYPF2sO3w7qrl5DyS55eSnxoWS3A6+I4fvlJFSkapoM4GeyA7J0HrViS1ABGmK/43yFhQhS7LmWdsiIzjPcT4FmgTcnBJaEYCIxlig7HkQ4NPagyL0VXPdGbbmkPEknwuuNqSEw5Jaauukfqku0WPnZuqYMJNPqjTaADMgBMibWd6nPKSxTrpoAQNhEWd41OcoNXUnHGzD/n836fxKwyfmguMG1fFvV2FjUjS3EGwuIl+D4aJhMDtitrJTV9aqPJDv7NMVmudMr9XW0k4ANKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BXAk5cIhWvtlbGEFPECEgzv4mBhIQ3kEOWi4aXxHzg=;
 b=MaW/3Em+b+Y624UvtqFYNtQCRW6HXhOBNH6U9tqCIXw7XcjKceQYUxgDSvPgjI2Hav0odVwHWXSPjKUDTrhtjHmTC6HDPgL6gLAfGaIUUG5UzEDb+jEgn2wVgxOftIS0G31AiRtxCAFlzHKvBu4QPTSiuOqwlnVe+T3yiutvbl8=
Received: from CO6PR18MB4417.namprd18.prod.outlook.com (2603:10b6:5:354::9) by
 CO6PR18MB4481.namprd18.prod.outlook.com (2603:10b6:303:13a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Thu, 8 Jul
 2021 07:50:09 +0000
Received: from CO6PR18MB4417.namprd18.prod.outlook.com
 ([fe80::8c65:a737:b0e1:cf83]) by CO6PR18MB4417.namprd18.prod.outlook.com
 ([fe80::8c65:a737:b0e1:cf83%3]) with mapi id 15.20.4308.022; Thu, 8 Jul 2021
 07:50:09 +0000
From:   Kostya Porotchkin <kostap@marvell.com>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "vladimir.vid@sartura.hr" <vladimir.vid@sartura.hr>,
        "tmn505@gmail.com" <tmn505@gmail.com>,
        "luka.kovacic@sartura.hr" <luka.kovacic@sartura.hr>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
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
Subject: RE: [EXT] Re: [PATCH v4 0/5] DTS updates for Marvell Armada CN913x
 platforms
Thread-Topic: [EXT] Re: [PATCH v4 0/5] DTS updates for Marvell Armada CN913x
 platforms
Thread-Index: AQHW/uoRcnrIpzeThkC88De4plJFyKsZIDwAgCB9KbA=
Date:   Thu, 8 Jul 2021 07:50:09 +0000
Message-ID: <CO6PR18MB4417276AD6E894F061F16D8FCA199@CO6PR18MB4417.namprd18.prod.outlook.com>
References: <20210209134610.19904-1-kostap@marvell.com>
 <87h7hw1ovj.fsf@BL-laptop>
In-Reply-To: <87h7hw1ovj.fsf@BL-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5f7f0da-df0f-4acf-bc41-08d941e50290
x-ms-traffictypediagnostic: CO6PR18MB4481:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO6PR18MB44812F4BC6A9B351A4C7EEAECA199@CO6PR18MB4481.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dECHMEAQFtP3PgRY4q2yDRTrALG1JjeFQtk51QH8nDKAS9f3oXL/FPG6Cue6MV9RSdpC871Yvj7eYx3idq/p+Sefi4AxiAx6nHpVeXwkZZS7qeSiG0oehHUpy8qCB10IYMPEqhAKcwRGxmerE1wT6EBpcpSi5EWrCZK4A094G0Y0o/GGtdPbdWp6GphmFnp4WL+Ij3+b37D1VOg2o6jvefk9mQMCj2cIIe0b/Xh3xmd6rKBFxCOjAyDg0jl0uf3NRh/FfMIYztkcMOV+ORGEFMRtKFIky+VtmUzY+pVKCvxd+HeVgPN/qpsf//+vDnH1g9YqXsNctQrMi6KYG8H4BFEFi+TgN43Cbsf/9BbIxAwMmdwLkTfXjr3/2igBhv3A2IxEzAh9KQRqiAnCyQyL8BWhIHuhLf7cDSBgSBRo0cCPODILQdnaYN9OWczOwj6VT7tbiLHNybLBCFmGxwuZdarT2IOveRqlNcMDTE/dnB9YKDrC8Q6t7lgpNd+kNOcTSO0D6ytBWAnRI2gx3nPv0CmGEj5VRAkDkuxkZYKLzNemZ8l0VHEEgAniqqoYi9SBBv56JbQ9mNnw6Vxv4gApem/QIUmZ5Gljnh/F1R5VG7H9+CbgT6uJxkHlhQGX8C6xTNOWZvQtQHZ90b9Ic+MGyEq1bgOnzCphK7hKgUt4pDhOzzdphhFYY8desFEZY22H7JA2HnnazEKDLZh97MHiu4/CT488DHwS327IV+FZA1U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4417.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(346002)(366004)(376002)(396003)(136003)(71200400001)(15650500001)(64756008)(66946007)(186003)(26005)(52536014)(76116006)(6506007)(38100700002)(122000001)(2906002)(7416002)(8676002)(7696005)(33656002)(66446008)(4326008)(66476007)(66556008)(83380400001)(8936002)(53546011)(316002)(110136005)(54906003)(86362001)(5660300002)(478600001)(55016002)(9686003)(966005)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?md15YWi9VN8ClJmKqXp2OnQIIceuLTXCe0UB2XL1yTApLCk2mN8Q+OPcGTsO?=
 =?us-ascii?Q?vsJ0al4sMuXk/NCDwrtj16W58vYF3m7FzXNITFCoaunx/lL6T317IWGpTBqC?=
 =?us-ascii?Q?coUqCIVADzzcwX1bX7+FpjrCriFGrLQJjYIHk/+uEpCx3ee24VV6Wajeus1R?=
 =?us-ascii?Q?dFnN17N+EcU7wnHwkbzVQYHbMglu+YJpU9RxQvXQDf33bXVS5qHwABHka9E3?=
 =?us-ascii?Q?VuBeTLeT7p5vByKOtNw7xGzhTZlFXygoZLSSMXf/GoxNO1WOqwYubQAIOzJ9?=
 =?us-ascii?Q?dcfJYjKEdJByDb1qX53JIVS/s1/sDXUgpCL6EnfJStHydkg00bLPhJZEpNPR?=
 =?us-ascii?Q?palNgZDDJVwGSnWUr+EcH0ueFprTWDddO45Pj20o7bJPV842xyvgVEOwUj/D?=
 =?us-ascii?Q?FW2vTzE6jPV9ZRTwOywngmz7hVwRs6jfWDy1Lp7AMiKy6p9V1nbBMFA/qtfx?=
 =?us-ascii?Q?kecZhjyu9cMkEPHke1Ujt38P/eIRC8Yjymk7ngdALv8fbu/nb7wyVgG6pZgZ?=
 =?us-ascii?Q?twvMce8lLCqS+86rXJIMUfg915d6Y3FH4yFiev2c0opUQnSKcZmzqhTgwmyT?=
 =?us-ascii?Q?4x3tLRiPKV/pwjqRKuhKdP5LKHi6vMeUWZkJZaxBsXR7Su0Ua+fj/43D+hxX?=
 =?us-ascii?Q?0YjQv8/EJrB/usZxeSuCtiJZA3a1kt4+WBAYXS5bG5mA59Fh7h2fGsA2+zVX?=
 =?us-ascii?Q?ppB3Z4Vpq7ENMKBy+JmGJbr8/BEaXd/dOS0kdxmr+L0vaTX0msOpEdXHVa+t?=
 =?us-ascii?Q?/P9KC3JnhAUXCX6rkRrZ7nyHrEZ6NKyuyXSsBGEeBK92RTXuiY8fd3cWOtBF?=
 =?us-ascii?Q?lL9eIWbqVu3VXoqXta+5rYbPWogpMzi8/V0zXEE8XWsDQ9vP+v4njqhT0YAM?=
 =?us-ascii?Q?rwZglRry/6ROUNFjn4gpGePyvokol7yULi+wQ4tO5A7l5j+2NSR0J7vt5e9g?=
 =?us-ascii?Q?3W8UOab/BS9N9uHmTVWgNUmdS3/ezcY5Q32htW1YA+G5WyTd4ZTJ76+dUVy7?=
 =?us-ascii?Q?shDv5tgMQ61BGRVPfNoDNkVqP9/KRzkDdmVVk5ZGSC6I+YTL6cmmlqaDzX2U?=
 =?us-ascii?Q?0JzyorNxgFU2d8Lb1PeThXvFWaTK3+NLQDdNLRYp4cNIh+xufXyNqweriKVI?=
 =?us-ascii?Q?mTkDTPRiOR2fI5UYuxPXdOLLoroiOzbJXTcPU9UnKZKWSW0bERIsrwx64ZoT?=
 =?us-ascii?Q?DDzSvwKy6+VDCUfPQ472F1kBaZ2iLj0WmfgsuNLlGcLNvi9GD7rRvldnZJIi?=
 =?us-ascii?Q?n/RERy8bpU/0DhWKx7v4hbtIVd+LXqwcHYfBmWLoOyvxynTCe9WVcPPDm+Rq?=
 =?us-ascii?Q?mwc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4417.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f7f0da-df0f-4acf-bc41-08d941e50290
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2021 07:50:09.4946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XrZO/LAZfJN/aDx9UYR4QPKZJ1HsfBBUatlI85ZfTKxfhGn2ANQ4mOeBq6C2FCJs/4fBRdL0MFUvw79MO0R3wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB4481
X-Proofpoint-ORIG-GUID: yCUcQc3iwNLR1LTi52G7_DblE-wQ4CFc
X-Proofpoint-GUID: yCUcQc3iwNLR1LTi52G7_DblE-wQ4CFc
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-08_03:2021-07-06,2021-07-08 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Gregory,

The last series was v5. I will rebase on top of Linus 5.13-rcx and then pos=
t new v6 set.

Regards
Kosta

> -----Original Message-----
> From: Gregory CLEMENT <gregory.clement@bootlin.com>
> Sent: Thursday, June 17, 2021 18:40
> To: Kostya Porotchkin <kostap@marvell.com>; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Cc: vladimir.vid@sartura.hr; tmn505@gmail.com; luka.kovacic@sartura.hr;
> sebastian.hesselbarth@gmail.com; andrew@lunn.ch; robh+dt@kernel.org;
> vkoul@kernel.org; kishon@ti.com; miquel.raynal@bootlin.com;
> mw@semihalf.com; jaz@semihalf.com; Nadav Haklai
> <nadavh@marvell.com>; Stefan Chulski <stefanc@marvell.com>; Ben Peled
> <bpeled@marvell.com>; Kostya Porotchkin <kostap@marvell.com>
> Subject: [EXT] Re: [PATCH v4 0/5] DTS updates for Marvell Armada CN913x
> platforms
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> Hello,
>=20
> > From: Konstantin Porotchkin <kostap@marvell.com>
> >
> > This patch series contains the following changes/fixes:
> > 1. Add support for Armada CN913x Development Board topology "B"
> > 2. Add support for Armada CN913x Reference Design boards (CRB) 3.
> > Fixes the CP11X references in PHY binding document 4. Fixes the NAND
> > paritioninig scheme in DTS eliminating gap between consecutive
> > partitions All above changes are already intergated into Marvell
> > official SDK sources
> >
> > v2:
> > - extract common nodes from DB boards to separate DTSI files
> > - disable eth2 on CRB boards until the required phy mode support is
> > added
> > - mention the switch part ID in CRB board description
> >
> > v3:
> > - do not rename setup A DTS files for DB variants
> > - fix a couple of wrong include names
> >
> > v4:
> > - Rebase on top of Linus master branch (v5.11-rc7)
> > - Remove HS400 timing from CRB AP SDHCI (not supported by connected
> > eMMC)
> > - Add cd-gpio entry to CP0 SDHCI for SD card support
> > - Add a comment to CN9130-CRB patch about the required defconfig
> >   changes for supporting the onboard i2c expander
> > - Add Stefan's patch to enable 10G port on CN9130-DB platforms
> >
> > Grzegorz Jaszczyk (1):
> >   Documentation/bindings: phy: update references to cp11x
> >
> > Konstantin Porotchkin (3):
> >   arch/arm64/boot/dts/marvell: fix NAND partitioning scheme
> >   arm64: dts: cn913x: add device trees for topology B boards
> >   arm64: dts: add support for Marvell cn9130-crb platform
> >
> > Stefan Chulski (1):
> >   dts: marvell: Enable 10G interface on 9130-DB board
> >
>=20
> I've applied patches 1 and 2, but I have issue with patch 3, there was so=
me
> changes around the phys and I am not sure of the correct way to modify th=
e
> patch.
>=20
> Could you rebase it on v5.13-c1 and fix the merge issue ?
>=20
> Thanks,
>=20
> Gregory
>=20
> >  .../bindings/phy/phy-mvebu-comphy.txt         |  12 +-
> >  arch/arm64/boot/dts/marvell/Makefile          |   5 +
> >  arch/arm64/boot/dts/marvell/cn9130-crb-A.dts  |  38 ++
> > arch/arm64/boot/dts/marvell/cn9130-crb-B.dts  |  46 ++
> >  arch/arm64/boot/dts/marvell/cn9130-crb.dtsi   | 221 ++++++++++
> >  arch/arm64/boot/dts/marvell/cn9130-db-B.dts   |  22 +
> >  arch/arm64/boot/dts/marvell/cn9130-db.dts     | 393 +----------------
> >  arch/arm64/boot/dts/marvell/cn9130-db.dtsi    | 402 ++++++++++++++++++
> >  arch/arm64/boot/dts/marvell/cn9131-db-B.dts   |  22 +
> >  arch/arm64/boot/dts/marvell/cn9131-db.dts     | 192 +--------
> >  arch/arm64/boot/dts/marvell/cn9131-db.dtsi    | 201 +++++++++
> >  arch/arm64/boot/dts/marvell/cn9132-db-B.dts   |  22 +
> >  arch/arm64/boot/dts/marvell/cn9132-db.dts     | 211 +--------
> >  arch/arm64/boot/dts/marvell/cn9132-db.dtsi    | 220 ++++++++++
> >  14 files changed, 1223 insertions(+), 784 deletions(-)  create mode
> > 100644 arch/arm64/boot/dts/marvell/cn9130-crb-A.dts
> >  create mode 100644 arch/arm64/boot/dts/marvell/cn9130-crb-B.dts
> >  create mode 100644 arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
> >  create mode 100644 arch/arm64/boot/dts/marvell/cn9130-db-B.dts
> >  create mode 100644 arch/arm64/boot/dts/marvell/cn9130-db.dtsi
> >  create mode 100644 arch/arm64/boot/dts/marvell/cn9131-db-B.dts
> >  create mode 100644 arch/arm64/boot/dts/marvell/cn9131-db.dtsi
> >  create mode 100644 arch/arm64/boot/dts/marvell/cn9132-db-B.dts
> >  create mode 100644 arch/arm64/boot/dts/marvell/cn9132-db.dtsi
> >
> > --
> > 2.17.1
> >
>=20
> --
> Gregory Clement, Bootlin
> Embedded Linux and Kernel engineering
> https://urldefense.proofpoint.com/v2/url?u=3Dhttp-
> 3A__bootlin.com&d=3DDwIBAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3D-
> N9sN4p5NSr0JGQoQ_2UCOgAqajG99W1EbSOww0WU8o&m=3Dyb2JOcVicfAZRe
> thZJoDE-
> wbwtupb3tk_D7VGKCNsqc&s=3D4oskkLywYJujfGQ4XpFfP6n4ybkC0722K_8qH3xz
> bK8&e=3D
