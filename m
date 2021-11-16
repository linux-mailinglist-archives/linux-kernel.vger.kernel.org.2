Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA5B452590
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 02:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382969AbhKPByi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 20:54:38 -0500
Received: from mail-vi1eur05on2071.outbound.protection.outlook.com ([40.107.21.71]:43713
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1356481AbhKPBnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 20:43:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhmdI6Jdj4zSmb5nmV5/3OqP0GxYgyHJUCXFwcGj0nE2f/QywKjM+A2GmOpyo2XS1nmRsD84UPzUkMNyqB/gaEJrM06yvE+ySBGggMgFtUaZ+74Ib0SWQyeORk7zEnCo499HpHcelxx71msugS+va0HldT/hqaw8WMoF4I/PtTD+67J8xX6yOZwBYTOcWCATRBlqcNtkMAqE6JuwAVA/cerr2lHiPsPSTrFnpUwQjHofcQLLODUa93ZfqbZIXtSZXvMxl3aG62gyaL+MjiaPBfUQdTDFH+229p6GzBBdtMzMGhmOw8E5If9kI2cIwVmNecq28xr0MltOpa9V6dac1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xtIRj5GrfQ/xJqsgFF7FMl8GprPb/LLYM0TbhlXQoY=;
 b=Zb7RT3KM/kWrq2G2nXtipcjQVJSxN+V479Gt64JrnidgvJcnInC11CScnYdEoxPDrFe/VHMUBi7HDE/5YcA7Z8YBn4dO5AzytyqTTSy3u4g4EomOOSf4WMNTXp5E588jmR53QNKBMMDsTFpB2Mtlzi9xc9C5OIP93QmVQMkoqGPauxr+R6/C0L+ozie5YvOOFjhBEMqT1bB3IUFILc33MdHijHfwxmmriaWamEZ1Qo37vmvHuRsWNNFUdsuIdr8JfaenJg05fiERnGJGcxi/rETZwWB16syrJ0gQaekWJnjFDtQToPUIf7dkcTPxfAnA0evO9EWGY2gRmxXgFLGpFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xtIRj5GrfQ/xJqsgFF7FMl8GprPb/LLYM0TbhlXQoY=;
 b=iSUxZDK0Vdw76b+vc9/15OJGncc+Am7hlTd8BWYg3HJbEZrmL9NGSubrjMc898lj6Oe8mXXG58kBl1DwTO4pdNOysXRnh8Ulwhc6Ohf4h36RmO7bR/IVyBWDpnJUyrtwFU0xEK8QsOB+l27IORyfuVoWn0l6/I2k1jQg4/WNDyk=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS1PR04MB9432.eurprd04.prod.outlook.com (2603:10a6:20b:4d8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Tue, 16 Nov
 2021 01:40:26 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc%5]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 01:40:26 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     "tharvey@gateworks.com" <tharvey@gateworks.com>
CC:     Lucas Stach <l.stach@pengutronix.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "galak@kernel.crashing.org" <galak@kernel.crashing.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v5 0/8] Add the imx8m pcie phy driver and imx8mm pcie
 support
Thread-Topic: [PATCH v5 0/8] Add the imx8m pcie phy driver and imx8mm pcie
 support
Thread-Index: AQHX2nQKnAA55lO24Eigwg7jrckmc6wFXtVg
Date:   Tue, 16 Nov 2021 01:40:25 +0000
Message-ID: <AS8PR04MB86760660BD24E4C2BD98F6318C999@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1635820355-27009-1-git-send-email-hongxing.zhu@nxp.com>
 <CAJ+vNU3r0aC8GrTQ2z5BqsCFCAXP+BWt2ntqsNy8DBd--nxdvQ@mail.gmail.com>
In-Reply-To: <CAJ+vNU3r0aC8GrTQ2z5BqsCFCAXP+BWt2ntqsNy8DBd--nxdvQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b335d7f6-cd1b-41a9-f5de-08d9a8a21064
x-ms-traffictypediagnostic: AS1PR04MB9432:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AS1PR04MB9432F581CA2774F992FAEC5B8C999@AS1PR04MB9432.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jqdiSSfd53/qWSaghtCBoT4NaDbkLb399Mpn4MeDIbrv4Om2nbW3A7C5KxDRAf6qAqGpheh1kR7acFOmGD8JKjuqIRhza7L2PuN5kMwK94yRqdkrkGtsTH0tP/s/+tecJep3NlLqadnrzyQ2fjxXzl6hmSGHZaGhQM2MrCs/0Fce3xPpUmzLss1IqmnzGaTojxG6Zq0kBdNCXo4vpltJAcE2pdWmTGZvLfn+efvOSLs/srQ8BsML3fycCnc9YHkYhIFe8L8qe4fv/wGLiTWeEbftpp7DQJYflRr/PR/dSoNHGDDTpNNkT8LTCCVr7+mXgAjHRa9Fsb0KyUQwH30kNxkArKOzVKN+u3fxwOuNrLZyzvDJwfA4bEsANOVuOEKdA7MEHB2uT4t8MrmIH8R9cLq/k5CFyYxjTeVxRkJ16P0Thz0Gz/dk+OcLIKBfQEKxfA7fHot677Ln4Xncs1CIQd1hEkQmg2QtLdH+14/lFGxKMEs0n+F68GuI/pfG0EtO/l/Kg7rjvR0etfpk/lOp4Nbk1U5Fd+lAQCpLyRTfsv4FxQAPMCHHIPaw2HVkWtia8npmkkLLuNSh/j/gmdSqtleWcfiu69Lzx55RkYz0FbHnwk9XTia70c/T58lUyU0ap/vLdwjzUhl/F65dJjJvd4PND8V1Y3oKI7PHnUtFiFiDrLGVWxzKbpD0cGBtwrDTJLKFkiK0Pd46q7x5aOmYCXNPsjoi2c5GJobI3naJx6cBS36QdlFe6jneTG6dot8TVGKnWgRaHR8z2gNYsgHN5IPzV+MFwnjc1z769Phzm4ATcbqePaSJvCiSVSb1h43Snlt/yrEDbMdBSfIXLQSBMxaRtLY+XI6tRzzgF2aFdQM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(52536014)(6916009)(26005)(966005)(7696005)(54906003)(8676002)(38100700002)(316002)(5660300002)(83380400001)(45080400002)(508600001)(2906002)(122000001)(8936002)(7416002)(86362001)(71200400001)(4326008)(76116006)(38070700005)(66556008)(64756008)(66446008)(66946007)(53546011)(55016002)(66476007)(44832011)(6506007)(33656002)(9686003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FgoaI9i4yT4TJs9md7ayg/i06mFKMGh42upAw+uFiRDYK15a2oE1YbXwv7Pr?=
 =?us-ascii?Q?lm3aNCDWyQD+w2UZbDGqo/rhJvGATbJR4p8wxV9PF2oAmoVCJpvjsEHYiyUk?=
 =?us-ascii?Q?r+guZV4/r4/ItKyHhv86MYG2kPRiWrikA4YRFQsac5uC+6KLt67R/nfAKuCm?=
 =?us-ascii?Q?/oKnAuy/i4NYY/ahvyHHys/hv9GzNHVWKoEUEbclxNWJnJ9CnFcl/ZAU1BY/?=
 =?us-ascii?Q?6HD8vvIhqGL62oc1zh39JdNKcr/HRrgnEB+LBaTX2Eare8Dw543pj69UEYph?=
 =?us-ascii?Q?lHpNHQ5qyC/ztS1UzhYqfmxwMXiXrJ2dyMnKYXbnJw/P29/gUtHmz88ztKot?=
 =?us-ascii?Q?8aTiAT9YnX5zfe8KCtk3nWWDnxKPisDQ9+pTUAM7Pc2YS9Db6QjtzYMG+AF0?=
 =?us-ascii?Q?dNIMtpswxNkN4TXVXOAkugQGdbnh0jvvOTm0lohzc+GOlk5ZGaIAuSFV0Srx?=
 =?us-ascii?Q?9XHN3f/yc42yBSmM0RevGt8CnX6gZ4S5SXm3aiPzrB7Alloi0eaQv3Jvbv02?=
 =?us-ascii?Q?xOHLNnLKpPYUj1TJ6YfUzOPMW5boZ7XRh5OZOtR6teJzXGYk0CA8tPSicB2F?=
 =?us-ascii?Q?frvIcVpOBcTO81ZLfy/ydksu43xuzkJG3K8W7BlsLCxSkCkg5tRSv/FPdETH?=
 =?us-ascii?Q?/GEYPlOuoDCiRodHLWH29tuA8TgFaTMKh0LbBXBJMdEqk5Fb60TVK+IRvvQY?=
 =?us-ascii?Q?5qi/YyYy1k+zrMcuNacdfZt2Q6XUj1JahMJLcK/nRaSUXIyZiABLM+H6B2ae?=
 =?us-ascii?Q?C5eQWwv9XHT9T1pfp6Efh6PXAKarthHQkoEq9BHBCvfCu9shDP2GkWpFKP2T?=
 =?us-ascii?Q?nOKH3GTCvbPkf/wsyJGVzIUz6L8/4Dq9JT46zIn6wrr1/MSPjwIl4gtRmVYC?=
 =?us-ascii?Q?dsTb+MkaAjFX6IlIxaV86xsKMR7Rq1GNr2tLICMPXE0iXMwsSqk5OpkDuQmz?=
 =?us-ascii?Q?w3ZrkVnZ42W3puV1f810FGfyJ5hd/XNvKia3UHHJ67STFBXHMejrhjKq1wTV?=
 =?us-ascii?Q?h+3hjweQlrJaz3zOIzHguNgMVMdnIDb0joWdYcR4SBbvdrUM2goGigITqUPL?=
 =?us-ascii?Q?ZxO4JOaEKLbr4ETNBdVFzu5QF7V7r/js8ae8iF/Toq9maPp8fK5c6dIdy1ZQ?=
 =?us-ascii?Q?zwDEEJRYk+pS+EC7h7FET7GfjgXm51rZp49zpy2NCBxO1t5i2BVJ1hrveTia?=
 =?us-ascii?Q?gcZWne/dZ6FQLq3G/8/72irpyEsnLW8iHnzj7gLHSOnUvnJQAYbjzX/6ISqM?=
 =?us-ascii?Q?E0O0iFgBM/Cxt0tkF3PnC/j0BsuSwyO3GDYJ0VWzuRzmL5dWkXxOK92Md1SK?=
 =?us-ascii?Q?A7pSlPV75FHOSiEakL+PAB0710Lk+Wp7Dk5y4GGBpJmQ/FEolAfMl3XpS/Mh?=
 =?us-ascii?Q?qXrLv7Z18FTpwCsBKDoJMIOdD20ElF0KLJXvFXl8x5Z4jmQncvirv6/lk4ty?=
 =?us-ascii?Q?/ax3PMUH73GKfG6q5MBnE9+UsgPZP/ctVh5Z8nmvLLoGfsMH233uu34S9G3S?=
 =?us-ascii?Q?BVUCyGCBM0qHKArd6upCuv89gTPuooTLuJLeOda1pyxU+Wdmk9oO9PHOC8JW?=
 =?us-ascii?Q?U52ve6FZaDM3BUJYjGz+OXn44ulbYFvqJG1hSaBIfPFc9VBSNx8zELFBMDGO?=
 =?us-ascii?Q?yQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b335d7f6-cd1b-41a9-f5de-08d9a8a21064
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2021 01:40:26.0924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o4CAvLsOdcYLzVOzOuEtiAtv9Q8a+ANSm+b/JLcKjMkFFE3F857P2TsvaWM5SiCZCoXHOn8j69achlh3mzOgTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9432
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Tim Harvey <tharvey@gateworks.com>
> Sent: Tuesday, November 16, 2021 6:56 AM
> To: Hongxing Zhu <hongxing.zhu@nxp.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>; Marcel Ziswiler
> <marcel.ziswiler@toradex.com>; Kishon Vijay Abraham I
> <kishon@ti.com>; vkoul@kernel.org; Rob Herring <robh@kernel.org>;
> galak@kernel.crashing.org; Shawn Guo <shawnguo@kernel.org>;
> linux-phy@lists.infradead.org; Device Tree Mailing List
> <devicetree@vger.kernel.org>; Linux ARM Mailing List
> <linux-arm-kernel@lists.infradead.org>; open list
> <linux-kernel@vger.kernel.org>; Sascha Hauer <kernel@pengutronix.de>;
> dl-linux-imx <linux-imx@nxp.com>
> Subject: Re: [PATCH v5 0/8] Add the imx8m pcie phy driver and imx8mm
> pcie support
>=20
> On Mon, Nov 1, 2021 at 7:58 PM Richard Zhu <hongxing.zhu@nxp.com>
> wrote:
> >
> > Refer to the discussion [1] when try to enable i.MX8MM PCIe support,
> > one standalone PCIe PHY driver should be seperated from i.MX PCIe
> > driver when enable i.MX8MM PCIe support.
> >
> > This patch-set adds the standalone PCIe PHY driver suport[1-5], and
> > i.MX8MM PCIe support[6-8] to have whole view to review this
> patch-set.
> >
> > The PCIe works on i.MX8MM EVK board based the the blkctrl power
> driver
> > [2] and this patch-set. And tested by Tim and Marcel on the different
> > reference clock modes boards.
> >
> > [1]
> >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpa
> tc
> >
> hwork.ozlabs.org%2Fproject%2Flinux-pci%2Fpatch%2F20210510141509.
> 929120
> >
> -3-l.stach%40pengutronix.de%2F&amp;data=3D04%7C01%7Chongxing.zhu
> %40nxp.c
> >
> om%7C489971db9c0f4308600208d9a88b2b05%7C686ea1d3bc2b4c6fa9
> 2cd99c5c3016
> >
> 35%7C0%7C0%7C637726137953234928%7CUnknown%7CTWFpbGZsb3d
> 8eyJWIjoiMC4wLj
> >
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&
> amp;sdata=3D
> >
> ltuNZqIAsEH6%2B1KE4cqNOiUul3Ex%2BWmYcyqD%2BFJuUrs%3D&amp;
> reserved=3D0
> > [2]
> >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpa
> tc
> >
> hwork.kernel.org%2Fproject%2Flinux-arm-kernel%2Fcover%2F20210910
> 202640
> > .980366-1-l.stach%40pengutronix.de%2F&amp;data=3D04%7C01%7Chon
> gxing.zhu%
> >
> 40nxp.com%7C489971db9c0f4308600208d9a88b2b05%7C686ea1d3bc2
> b4c6fa92cd99
> >
> c5c301635%7C0%7C0%7C637726137953234928%7CUnknown%7CTWFp
> bGZsb3d8eyJWIjo
> >
> iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> 7C3000&amp
> > ;sdata=3DMrT3Re3YttE9AoqmGHksTqt4jF4vitRPz5lkgpZqSZ4%3D&amp;res
> erved=3D0
> >
> > Main changes v4 --> v5:
> > - Set the AUX_EN always 1b'1, thus it can fix the regression introduced
> in v4
> >   series on Marcel's board.
> > - Use the lower-case letter in the devicetreee refer to Marcel's
> comments.
> > - Since the default value of the deemphasis parameters are zero, only
> set
> >   the deemphasis registers when the input paramters are none zero.
> >
> > Main changes v3 --> v4:
> > - Update the yaml to fix syntax error, add maxitems and drop
> > description of phy
> > - Correct the clock name in PHY DT node.
> > - Squash the EVK board relalted dts changes into one patch, and drop
> the
> >   useless dummy clock and gpio suffix in DT nodes.
> > - Add board specific de-emphasis parameters as DT properties. Thus
> each board
> >   can specify its actual de-emphasis values.
> > - Update the commit log of PHY driver.
> > - Remove the useless codes from PCIe driver, since they are moved to
> > PHY driver
> > - After the discussion and verification of the CLKREQ# configurations
> with Tim,
> >   agree to add an optional boolean property "fsl,clkreq-unsupported",
> indicates
> >   the CLKREQ# signal is hooked or not in HW designs.
> > - Add "Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>" tag,
> since
> >   Marcel help to test the v3 patch-set.
> >
> > Main changes v2 --> v3:
> > - Regarding Lucas' comments.
> >  - to have a whole view to review the patches, send out the i.MX8MM
> PCIe support too.
> >  - move the PHY related bits manipulations of the GPR/SRC to
> standalone PHY driver.
> >  - split the dts changes to SOC and board DT, and use the enum instead
> of raw value.
> >  - update the license of the dt-binding header file.
> >
> > Changes v1 --> v2:
> > - Update the license of the dt-binding header file to make the license
> >   compatible with dts files.
> > - Fix the dt_binding_check errors.
> >
> > Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |   6
> +++
> > Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml |  95
> ++++++++++++++++++++++++++++++++
> > arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi                |
> 55 +++++++++++++++++++
> > arch/arm64/boot/dts/freescale/imx8mm.dtsi                    |
> 46 +++++++++++++++-
> > drivers/pci/controller/dwc/pci-imx6.c                        |
> 73 ++++++++++++++++++++++---
> > drivers/phy/freescale/Kconfig                                |
> 9 ++++
> > drivers/phy/freescale/Makefile                               |
> 1 +
> > drivers/phy/freescale/phy-fsl-imx8m-pcie.c                   |
> 237
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> +++++++++++++++++++++
> > include/dt-bindings/phy/phy-imx8-pcie.h                      |
> 14 +++++
> > 9 files changed, 528 insertions(+), 8 deletions(-)
> >
> > [PATCH v5 1/8] dt-bindings: phy: phy-imx8-pcie: Add binding for the
> > [PATCH v5 2/8] dt-bindings: phy: Add imx8 pcie phy driver support
> > [PATCH v5 3/8] dt-bindings: imx6q-pcie: Add PHY phandles and name
> > [PATCH v5 4/8] arm64: dts: imx8mm: Add the pcie phy support [PATCH
> v5
> > 5/8] phy: freescale: pcie: Initialize the imx8 pcie [PATCH v5 6/8]
> > arm64: dts: imx8mm: Add the pcie support [PATCH v5 7/8] arm64: dts:
> > imx8mm-evk: Add the pcie support on imx8mm [PATCH v5 8/8] PCI:
> imx:
> > Add the imx8mm pcie support
>=20
> Richard,
>=20
> Are you posting a v6 of this series or have we already missed the window
> for 5.16?
[Richard Zhu] Hi Tim:
Thanks for your kindly reminder.
In my original plan, I prefer to merge the codes refine firstly, then issue
the v6 patch-set after the rebase.
https://patchwork.kernel.org/project/linux-arm-kernel/cover/1635747478-2556=
2-1-git-send-email-hongxing.zhu@nxp.com/
Unfortunately, I don't get ack from Lucas for other four patches.
Anyway, I would post the v6 patch-set immediately after merge Rob's comment=
s.

Best Regards
Richard Zhu
>=20
> Best regards,
>=20
> Tim
