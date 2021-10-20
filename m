Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0578143434A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 04:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhJTCMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 22:12:50 -0400
Received: from mail-eopbgr70077.outbound.protection.outlook.com ([40.107.7.77]:37502
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229635AbhJTCMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 22:12:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UY7I9zJVhTLV3SvNxrrdScln5tMMwkz2LCsunrVBwqyr8aJME3iCPD2/5qFuOnHCRwwZ7rJMjFd554d+MWSazZo0WzWqcKJhdDQEZZ970K1+SLhHEdWJROwkQFyeiI3crNqD9p7Y+k5v8KyAN0FEuf8lRolVrBWiJ+8wswuiWpFhEeAlQbjFiB9Ue4/n4YoSsI3HwMjzjNukdtpTbk1WmJR1hgiOkGxMYRHlhxc2indI/wrz3AE1OAUtyINghwj5tWa+QXTKVlVk+ddfOf0cyKygnU36XutSkSTb8ScG/SiTL3TxLbilO5PhUVGILeK73a2yDhCzoCfeSbLzns+42A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZSx6vqIJ8iEmQf21aQ7O1G8Gcju5wy+BqONDnV3wFQ=;
 b=fBSGpcmUieD7tpIbuLi7IJ2IxydJ/dm1IEf0RzfhDMvgNrL4LhabBlHg/V1MFX0vDz8dVXvDrZ2afHCt9ch3QO+UKA0HyIN/rkscX5xSnFwbaDpS9Ts8pt9Pqj3rNpDJegHz2J3R+cgotnbrYi4SxogZVXRNSrCMJiMRFNJLy8F8Z4UtMgEtbgdv+aTZzf7c0tUEE4nU9pTRPepuwf9gq79srkmCYZG+JBVy9U1avJ6jgVER6S6SRogpSPUZGIb6X7lHUHMu8QYNHbDXmKy35cNlTRJu8qdqje2rpqvmfEW61HLhT4PM+qqepGPe7t36omLqsAjDKM3QmQ1q9gSo6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZSx6vqIJ8iEmQf21aQ7O1G8Gcju5wy+BqONDnV3wFQ=;
 b=caeiz3WXpul8N0pqAxsZ7HwgidgKxcv8I4lR+/dliDQHh5iylerpL+mm0c6+FE3bGH8MbetXhzC7/moT3F8CWj+B/urQ9vEtsjn/FgDj/q10xYWH8FK843xLysCXdXMMH/+GzU++XY2xk3K09xqakBEw3IAXJ3PvBR3HkDmiFms=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB9093.eurprd04.prod.outlook.com (2603:10a6:20b:444::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Wed, 20 Oct
 2021 02:10:32 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc%4]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 02:10:32 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     "tharvey@gateworks.com" <tharvey@gateworks.com>
CC:     Lucas Stach <l.stach@pengutronix.de>,
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
Subject: RE: [PATCH v3 0/9] add the imx8m pcie phy driver and imx8mm pcie
 support
Thread-Topic: [PATCH v3 0/9] add the imx8m pcie phy driver and imx8mm pcie
 support
Thread-Index: AQHXwf8T9WRZIWT4CUunBVSnJ63L4qvZhp6ggAD4IYCAAKk/cA==
Date:   Wed, 20 Oct 2021 02:10:32 +0000
Message-ID: <AS8PR04MB8676840D7EDD56D10F9471288CBE9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1634028078-2387-1-git-send-email-hongxing.zhu@nxp.com>
 <CAJ+vNU2b-=T_gTsRBvdF7SRUZopEFOU_Np8mEJn8bOpn5b5FaA@mail.gmail.com>
 <AS8PR04MB8676B2AC24E2769D47A1ED478CBD9@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <CAJ+vNU2AitmxCyam5FArmxAD41QUU=5CF_0JZhm+uzdkRbr7kw@mail.gmail.com>
In-Reply-To: <CAJ+vNU2AitmxCyam5FArmxAD41QUU=5CF_0JZhm+uzdkRbr7kw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fef6b006-1718-4a63-2bca-08d9936ecbba
x-ms-traffictypediagnostic: AS8PR04MB9093:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AS8PR04MB909321F3ABFD9D0BC2C7DFF08CBE9@AS8PR04MB9093.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /QrULzzEKBtvVwdQHPhsVcekg79kE92XRIVGztRxEUwYhiuufWH6hHO8+RN6NcoEyCumX/iM+w+FwCVGCqyG88TTQpEOgic5cmByb2Oh6NCjC2hGkJm/ebvSOCYWoDwxIQvzecSaVLv7EqABPw8Spmk9YWpgAnbUsDqrjf8bzXitjTw8orY/uZvlpLMKNCQ61RG60dIIvH5wSy2IgY3SALsSZWeiHlmJXnN0z0TODGxbc4Ryc7uvUQwIPV4iD+a13KRa4OPa7FdZn3i9uU/mMu3zHW0RBxtDsjE+QvBAYLVYeJ96eZqKzLPsIJzypT71usd71/z9G6E3n0nqtDYSvqqxvt0t2WByvgPjLkaCeT6lEAARI06A9HTpoywwxJiooYu3aNJmwoyZEE+k/dccIZdsPK8pKiQKwr8ws0wokDiucM3Tc+d2zRNzzs96CNXtYQjYWDd6ealZTWqLxIc9AOfM1yX7hdxm8K2qbBTM/OUv9hbWdVY27AaAo8fmPFIdChfVIyzBt6FdVb6BvuEwHHhxWg96796WLS+5QFym4L6YURKcj1+2NCBfKbshTc/4HKdP/1IpH5NPthMCgvXZpDqBJ6lx2q5hMb/en7IsAXGopHs8YbdteF4tyHVe73SjadK/DOkMQMNz2u6SllZkUuh9vko5wqa1nZ5KHECJgqLyKViDrgxHsG/WS8PXbtDZv4lEFH/3zV0vp5nWvooTfrpVcVR3HusZ+IvgBVLcZclDdu9v7TYW0ZA/GybEUng9ifdfXZWcJVcQ4RRb2Oyk38WarJGXP9/u9CfofxiQ5lZOWoHnEfI9a9+T1diNkyBV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(84040400005)(5660300002)(6916009)(26005)(8936002)(122000001)(52536014)(186003)(8676002)(71200400001)(53546011)(7696005)(54906003)(6506007)(316002)(55016002)(4326008)(9686003)(38100700002)(966005)(2906002)(33656002)(83380400001)(86362001)(45080400002)(66446008)(76116006)(7416002)(508600001)(64756008)(66946007)(38070700005)(66476007)(66556008)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f0U9Pgve9bwxmtpwH8dsrTEA/GwR3E5x2T/zX2jy7GSEbtCU3CXJ3d67vNYo?=
 =?us-ascii?Q?LLk0Y8ABJXx3uI9PLkKqHiGt56tRd52UYD7YrMYGC0AVxtYkVJVxaCJzhoax?=
 =?us-ascii?Q?PGtXjVmkgriE9C8LnR7wvv+KSuJGRpZymTDe8BosfiBZb8fERQiJd6G9QFuG?=
 =?us-ascii?Q?jBcRLZsRbtRIrwyizzeCazNnpWMdxBckMDU1kDqUbWcBrrwrT7sm7rnigbEu?=
 =?us-ascii?Q?jY+qMK7U2ShSjsMUD6rEpNpUmpOsQKgEdvlWICqKkpzhpN8nHbjDcM50/mRd?=
 =?us-ascii?Q?ZscrkHQ3fl5zOLdTNIpGQKpzxYqJIfvAHEzRh6lSiU2Pe8wDY3jxW773zOaS?=
 =?us-ascii?Q?vH+YjZ8vVM6zRHb+YG+PkufUc4pXxI9dX/aYGcJo6yrCQf3dBHfnTijbYNZ5?=
 =?us-ascii?Q?n+iby6i2uIP1J2pmjuzDQnCZtqkLcMVLgNh85lCObOKwsAZR27zJQar18n0Q?=
 =?us-ascii?Q?bCEA2xWTK4d5wCm6Tyny1xghXqsAmSfMxpsxnpUJRUbIdYJYx6zwr+qfRJfU?=
 =?us-ascii?Q?h6S0SFev8fVEM/NbgSJraK5cpcvqo+j99BX48VPzzXe0yvVffHu3jDCpK1V+?=
 =?us-ascii?Q?lSnwBK87Ot5L4mhdMAs2+mmtde7wvK5Ri51XhxRWT1EpEDSnmMwvcxvOknGt?=
 =?us-ascii?Q?t8kWjGWLsihcfJYbuFZ2fvuIEsWWXnRN0qTLA7NfrD/40IqMFR8wX7XNwTsJ?=
 =?us-ascii?Q?rFCvlhgnHnwAEh+IvCxNhaJnsW8Oe65DM2WLPVISIYCznHXhI52dMBWmXPr3?=
 =?us-ascii?Q?izUkaGN+Sw5Z71RppI/hkL3ivQgHC4Dw6lGeegRsDFXesclUVvQWNOglY/U/?=
 =?us-ascii?Q?CqmuskaV/Kb4AbThBb/b+fIShGWWGyCoGaGkLe1YGTwPp1tCLThnTw56mPtj?=
 =?us-ascii?Q?RREkzUko1qtMD3adgiGBTZ7ts0GNjWC4ybNt/RVLxGjujABc2W7LNMUfYnM3?=
 =?us-ascii?Q?nUeqjC6HJpVFTWGYGRPD6p7lWJ1Y63707+G7KAAhEzj+hqsLfK32HLjqo4EA?=
 =?us-ascii?Q?wX63BIW7ZI1iV7ULgOsD725jYNhbf09abY2bluwXOhoajMhQHkiBvPIfV0c5?=
 =?us-ascii?Q?UQ6Zwei6xVYfOCjYqhRKgbg1BuEz+xPqwuH3xSYufFZTyyx3TScAr01jckHh?=
 =?us-ascii?Q?1EOJtK8fxZy77BBXbY/171cxYbHFzP5twyrtuhr9VdMK/kzg8lEchmwnLg4D?=
 =?us-ascii?Q?SFr3QY18O1+E7T0fsLb+8v44CZqub5svIy1N2ckYuQO9knFVrUSKIag45sQk?=
 =?us-ascii?Q?SMii5zMMKPiPVgRll/BI9elMHL2iCXiq4J/bw7y5cAYynmpRMM+iWHK9wFiy?=
 =?us-ascii?Q?bTiQDbn4Jk4zQQBEN8frj1JtKjJepUyIxRRk1LSar81XEWUgGItQ7NfKj+HE?=
 =?us-ascii?Q?lvcYMUs1tPljqh99EBg/kPCNOvnYAR24zwWBcOjJmbUD5Q2SuE9RtpKGdefI?=
 =?us-ascii?Q?7TcEMhNQAa1bs/3h1VV3SOdoNqYjSzMlk78xUDyEQz9l0Nq4hMrHdqvSlpQP?=
 =?us-ascii?Q?LprK2/ZKXGJmnFDUqOPl/qN+/dJ5uXnTIkmqQEHvsuQohnFOnkBb8S8jJzyn?=
 =?us-ascii?Q?1bx1FJOEQeNkes5fukSPxfVxf9oaQJw2BDgIHpLYwD4Eu9J2gS5LaZ5rhf2f?=
 =?us-ascii?Q?jw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fef6b006-1718-4a63-2bca-08d9936ecbba
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2021 02:10:32.2032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iNFoN0fGQkxHp//1spLU/F8pU3t747uom/YLpAQ4qtj7AnNiD7LwvlSGrG5FhPrHorM+SX0A8Sne11vrSMk2nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9093
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Tim Harvey <tharvey@gateworks.com>
> Sent: Tuesday, October 19, 2021 11:53 PM
> To: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>; Kishon Vijay Abraham I
> <kishon@ti.com>; vkoul@kernel.org; Rob Herring <robh@kernel.org>;
> galak@kernel.crashing.org; Shawn Guo <shawnguo@kernel.org>;
> linux-phy@lists.infradead.org; Device Tree Mailing List
> <devicetree@vger.kernel.org>; Linux ARM Mailing List
> <linux-arm-kernel@lists.infradead.org>; open list
> <linux-kernel@vger.kernel.org>; Sascha Hauer <kernel@pengutronix.de>;
> dl-linux-imx <linux-imx@nxp.com>
> Subject: Re: [PATCH v3 0/9] add the imx8m pcie phy driver and imx8mm pcie
> support
>=20
> On Mon, Oct 18, 2021 at 7:10 PM Richard Zhu <hongxing.zhu@nxp.com>
> wrote:
> >
> >
> > > -----Original Message-----
> > > From: Tim Harvey <tharvey@gateworks.com>
> > > Sent: Saturday, October 16, 2021 3:59 AM
> > > To: Richard Zhu <hongxing.zhu@nxp.com>; Lucas Stach
> > > <l.stach@pengutronix.de>
> > > Cc: Kishon Vijay Abraham I <kishon@ti.com>; vkoul@kernel.org; Rob
> > > Herring <robh@kernel.org>; galak@kernel.crashing.org; Shawn Guo
> > > <shawnguo@kernel.org>; linux-phy@lists.infradead.org; Device Tree
> > > Mailing List <devicetree@vger.kernel.org>; Linux ARM Mailing List
> > > <linux-arm-kernel@lists.infradead.org>; open list
> > > <linux-kernel@vger.kernel.org>; Sascha Hauer
> > > <kernel@pengutronix.de>; dl-linux-imx <linux-imx@nxp.com>
> > > Subject: Re: [PATCH v3 0/9] add the imx8m pcie phy driver and imx8mm
> > > pcie support
> > >
> > > On Tue, Oct 12, 2021 at 2:06 AM Richard Zhu <hongxing.zhu@nxp.com>
> > > wrote:
> > > >
> > > > refer to the discussion [1] when try to enable i.MX8MM PCIe
> > > > support, one standalone PCIe PHY driver should be seperated from
> > > > i.MX PCIe driver when enable i.MX8MM PCIe support.
> > > >
> > > > This patch-set adds the standalone PCIe PHY driver suport[1-5],
> > > > and i.MX8MM PCIe support[6-9] to have whole view to review this
> patch-set.
> > > >
> > > > The PCIe works on i.MX8MM EVK board based the the blkctrl power
> > > > driver [2] and this PHY driver patch-set.
> > > >
> > > > [1]
> > > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
F
> > > > patc
> > > >
> > >
> hwork.ozlabs.org%2Fproject%2Flinux-pci%2Fpatch%2F20210510141509.929
> > > 120
> > > >
> > >
> -3-l.stach%40pengutronix.de%2F&amp;data=3D04%7C01%7Chongxing.zhu%40
> > > nxp.c
> > > >
> > >
> om%7C4e3d8ee008d94327f99108d9901634be%7C686ea1d3bc2b4c6fa92cd
> > > 99c5c3016
> > > >
> > >
> 35%7C0%7C0%7C637699247319711209%7CUnknown%7CTWFpbGZsb3d8ey
> > > JWIjoiMC4wLj
> > > >
> > >
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp
> > > ;sdata=3D
> > > >
> > >
> Z2TZCpdDUSoqrNB1X%2BXdoYNBe3dBDKUgkA4r%2F0TcdOg%3D&amp;reser
> > > ved=3D0
> > > > [2]
> > > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
F
> > > > patc
> > > >
> > >
> hwork.kernel.org%2Fproject%2Flinux-arm-kernel%2Fcover%2F202109102026
> > > 40
> > > > .980366-1-l.stach%40pengutronix.de%2F&amp;data=3D04%7C01%7Chon
> gxin
> > > g.zhu%
> > > >
> > >
> 40nxp.com%7C4e3d8ee008d94327f99108d9901634be%7C686ea1d3bc2b4c6
> > > fa92cd99
> > > >
> > >
> c5c301635%7C0%7C0%7C637699247319711209%7CUnknown%7CTWFpbGZ
> > > sb3d8eyJWIjo
> > > >
> > >
> iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C10
> > > 00&amp
> > > > ;sdata=3D5h%2By%2FcBW%2BjFkyplUuN1nB5%2BAFHuwCUJBqvRh1RiPY
> Mo
> > > %3D&amp;rese
> > > > rved=3D0
> > > >
> > > > Main changes v2 --> v3:
> > > > - Regarding Lucas' comments.
> > > >  - to have a whole view to review the patches, send out the
> > > > i.MX8MM PCIe
> > > support too.
> > > >  - move the PHY related bits manipulations of the GPR/SRC to
> > > > standalone
> > > PHY driver.
> > > >  - split the dts changes to SOC and board DT, and use the enum
> > > > instead of
> > > raw value.
> > > >  - update the license of the dt-binding header file.
> > > >
> > > > Changes v1 --> v2:
> > > > - Update the license of the dt-binding header file to make the lice=
nse
> > > >   compatible with dts files.
> > > > - Fix the dt_binding_check errors.
> > > >
> > > > Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |   6
> +++
> > > > Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml |  79
> > > +++++++++++++++++++++++++++++
> > > > arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi                |
> 53
> > > ++++++++++++++++++++
> > > > arch/arm64/boot/dts/freescale/imx8mm.dtsi                    |
> > > 46 ++++++++++++++++-
> > > > drivers/pci/controller/dwc/pci-imx6.c                        |
> 63
> > > ++++++++++++++++++++++-
> > > > drivers/phy/freescale/Kconfig                                |
> 9
> > > ++++
> > > > drivers/phy/freescale/Makefile                               |
> 1
> > > +
> > > > drivers/phy/freescale/phy-fsl-imx8m-pcie.c                   |
> 218
> > >
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > > ++++++++++++++++++
> > > > include/dt-bindings/phy/phy-imx8-pcie.h                      |
> 14
> > > ++++++
> > > > 9 files changed, 486 insertions(+), 3 deletions(-)
> > > >
> > > > [PATCH v3 1/9] dt-bindings: phy: phy-imx8-pcie: Add binding for
> > > > the [PATCH v3 2/9] dt-bindings: phy: add imx8 pcie phy driver
> > > > support [PATCH v3 3/9] arm64: dts: imx8mm: add the pcie phy
> > > > support [PATCH v3 4/9] arm64: dts: imx8mm-evk: add the pcie phy
> > > > support [PATCH v3 5/9]
> > > > phy: freescale: pcie: initialize the imx8 pcie [PATCH v3 6/9]
> > > > dt-bindings: imx6q-pcie: Add PHY phandles and name [PATCH v3 7/9]
> > > > arm64: dts: imx8mm: add the pcie support [PATCH v3 8/9] arm64: dts:
> > > > imx8mm-evk: add the pcie support on imx8mm [PATCH v3 9/9] PCI: imx:
> > > > add the imx8mm pcie support
> > >
> > > Richard and Lucas,
> > >
> > > Thanks for your collective work on this series!
> > >
> > > I have imx8mm-venice boards to test this on both with and without
> > > PCIe bridges. I've tested this on top of Shawn's imx/for-next (as
> > > blk-ctl has been merged there) and end up hanging waiting for PHY rea=
dy
> timeout.
> > [Richard Zhu] Sorry to reply late. I run the tests based on pci/for-nex=
t
> applied the blk-ctl issue by Lucas [2] in commit.
> > Can you help to make a re-tests?
> > As I know that the blk-ctl is not merged yet.
> > Hi Lucas:
> > Am I right?
> >
>=20
> Richard,
>=20
> v5 of blk-ctl is merged into Shawn's for-next tree.
>=20
[Richard Zhu] Got that.
Thanks.

> > >
> > > [    1.454308] imx6q-pcie 33800000.pcie:       IO
> > > 0x001ff80000..0x001ff8ffff -> 0x0
> > > [    1.466538] imx6q-pcie 33800000.pcie:      MEM
> > > 0x0018000000..0x001fefffff -> 0x0
> > > [    1.476344] libphy: fec_enet_mii_bus: probed
> > > [    1.602631] phy phy-32f00000.pcie-phy.0: phy init failed --> -110
> > > [    1.608775] imx6q-pcie 33800000.pcie: Waiting for PHY ready
> timeout!
> > >
> > > I can verify that imx8_pcie_phy_probe returns successfully and the
> > > the phy node (imx6_pcie->phy) was found.
> > >
> > > Here is the dt change I made for the imx8mm-venice-gw71xx-0x board
> > > that has no bridge:
> > [Richard Zhu] Refer to the changes, the external OSC is used as PCIe RE=
F
> clock(same to EVK board design), right?
>=20
> Correct, an ext osc is used like EVK.
>=20
> I applied v5 blk-ctl and your v3 series on top of pci/next and came up wi=
th the
> same issue. Do you have a git repo I could try to make sure I'm not missi=
ng
> anything?
>=20
> Also, as Lucas has requested some changes do you have a v4 coming soon th=
at
> I should wait for to try? I believe this has something to do with the phy=
 reset
> where some of his changes were requested.
[Richard Zhu] Unfortunately, I don't have personal git repo. But I think we=
 stand on same base-line.
I tried on Shawn's next tree with my v3 series today.
PCIe NVME device works fine on my i.MX8MM EVK board, although there is git-=
am failure in the last patch when I apply the v3 series.
Part of the logs:
"
root@imx8_all:~# lspci
00:00.0 PCI bridge: Synopsys, Inc. Device abcd (rev 01)
01:00.0 Non-Volatile memory controller: Sandisk Corp Device 5002
root@imx8_all:~# uname -a
Linux imx8_all 5.15.0-rc1-00091-g8bd7cd1cc7f0-dirty #1 SMP PREEMPT Wed Oct =
20 09:22:32 CST 2021 aarch64 aarch64 aarch64 GNU/Linux
...
[    1.164144] imx6q-pcie 33800000.pcie: host bridge /soc@0/pcie@33800000 r=
anges:
[    1.172114] imx6q-pcie 33800000.pcie:       IO 0x001ff80000..0x001ff8fff=
f -> 0x0000000000
[    1.182447] imx6q-pcie 33800000.pcie:      MEM 0x0018000000..0x001feffff=
f -> 0x0018000000
[    1.304429] imx6q-pcie 33800000.pcie: invalid resource
[    1.316305] imx6q-pcie 33800000.pcie: iATU unroll: enabled
[    1.321799] imx6q-pcie 33800000.pcie: Detected iATU regions: 4 outbound,=
 4 inbound
[    1.429803] imx6q-pcie 33800000.pcie: Link up
[    1.534497] imx6q-pcie 33800000.pcie: Link up
[    1.538870] imx6q-pcie 33800000.pcie: Link up, Gen2
[    1.550364] imx6q-pcie 33800000.pcie: Link up
[    1.550487] imx6q-pcie 33800000.pcie: PCI host bridge to bus 0000:00
[    1.565545] pci_bus 0000:00: root bus resource [bus 00-ff]
[    1.573834] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    1.580055] pci_bus 0000:00: root bus resource [mem 0x18000000-0x1feffff=
f]
[    1.586968] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
[    1.592997] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
[    1.599282] pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
[    1.606033] pci 0000:00:00.0: supports D1
[    1.610053] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
[    1.618206] pci 0000:01:00.0: [15b7:5002] type 00 class 0x010802
[    1.624293] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit=
]
[    1.631177] pci 0000:01:00.0: reg 0x20: [mem 0x00000000-0x000000ff 64bit=
]
[    1.638409] pci 0000:01:00.0: 4.000 Gb/s available PCIe bandwidth, limit=
ed by 5.0 GT/s PCIe x1 link at 0000:00:00.0 (capable of 31.504 Gb/s with 8.=
0 GT/s PCIe x4 link)
[    1.664931] pci 0000:00:00.0: BAR 0: assigned [mem 0x18000000-0x180fffff=
]
[    1.671745] pci 0000:00:00.0: BAR 14: assigned [mem 0x18100000-0x181ffff=
f]
[    1.678634] pci 0000:00:00.0: BAR 6: assigned [mem 0x18200000-0x1820ffff=
 pref]
[    1.685873] pci 0000:01:00.0: BAR 0: assigned [mem 0x18100000-0x18103fff=
 64bit]
[    1.693222] pci 0000:01:00.0: BAR 4: assigned [mem 0x18104000-0x181040ff=
 64bit]
[    1.700577] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    1.705814] pci 0000:00:00.0:   bridge window [mem 0x18100000-0x181fffff=
]
[    1.712972] pcieport 0000:00:00.0: PME: Signaling with IRQ 216
"
Regarding the log you pasted, it seems that the clock is not feed to PHY pr=
operly.

Anyway, let's waiting for the v4 series, then make a try. Thanks for your g=
reat help to make the double tests.

BR
Richard
>=20
> Best regards,
>=20
> Tim
