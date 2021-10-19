Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44F2432BB2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 04:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhJSCMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 22:12:33 -0400
Received: from mail-eopbgr10053.outbound.protection.outlook.com ([40.107.1.53]:2721
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229945AbhJSCMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 22:12:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHsU0uXlgQMbuiKuoEOuA0PjY2xYyIqQ/V68YwlxNx5z1J5irJSgkZ2QU4qDyhcr3IQtS2s/BBXSird/WZflPSupv9nIOtOtPbLp3hNlWwIQvsuQinPqHc4a2Fsfzve2NYQ4+x6rtxpEsB1692VqiTBTkX/Ul47hzQDzNjE2f/douSJfULh2tet67IshDokY406GMEU+uViS/xHzmg82MjFByfhwGU1izr8EEjT5nlKrXT3qGMnGc9hc8SklYIW1nob5mdlwDDjTO7APQTIgkT93d81rZ01mM4WovuvUNERXGVJAKYBIFEWDCxq79S+4AuIWdN4EGRzQzmEIiPMi4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uK/erj7hHykUJy7fThZQEhi/A9yTVQNOpkqzyW4sCjI=;
 b=mr8E/VfU8yGIr+oz6ELLjvyCsAhiJjurc+dBVbEYmMK6BKt1M1bnLpwlw21h7tFDKIjEtqj40iexBUj/l0ZJ2bfeBI3gZOWzlgkeBr/S+kRQMWaNbbe1GgJy02pSFwaV8VsDVX+yeec7m8MkeMLynWC0hgJIyg8CYE6NyxWy9hGO6cEo9RDM0db97O008iKJ3EOetq6LQQ8u226+EoAJzVLtPDTPeg2VBfZdqp95GxHLih9iXT7BX+J0VcIs2/QnAAk4oc0FFT9dmqvFLQmxpde2ItEA9L3eQuax6lfFJGWpf/e6axKVOH6zEhqfIg9wpzXq4CuyRs130QWyUOQPgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uK/erj7hHykUJy7fThZQEhi/A9yTVQNOpkqzyW4sCjI=;
 b=c3OR2En60F63sZtrgsi5FUtGwyywtZkKb0BO50OIkZr/TX/55I6UW9fJ+zmbwoohNwpuViyOddNNJYsxScoOIZkpHSw4ES/KFTFKGekHNIv3h86zD8b2/AKPtfEB4ypcL3vzQu4pgvmv9j+Yfe5Q3pYb+Wj3t3Y5WtVZ78oVwKM=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8834.eurprd04.prod.outlook.com (2603:10a6:20b:42d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Tue, 19 Oct
 2021 02:10:16 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc%4]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 02:10:16 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     "tharvey@gateworks.com" <tharvey@gateworks.com>,
        Lucas Stach <l.stach@pengutronix.de>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
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
Thread-Index: AQHXwf8T9WRZIWT4CUunBVSnJ63L4qvZhp6g
Date:   Tue, 19 Oct 2021 02:10:16 +0000
Message-ID: <AS8PR04MB8676B2AC24E2769D47A1ED478CBD9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1634028078-2387-1-git-send-email-hongxing.zhu@nxp.com>
 <CAJ+vNU2b-=T_gTsRBvdF7SRUZopEFOU_Np8mEJn8bOpn5b5FaA@mail.gmail.com>
In-Reply-To: <CAJ+vNU2b-=T_gTsRBvdF7SRUZopEFOU_Np8mEJn8bOpn5b5FaA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gateworks.com; dkim=none (message not signed)
 header.d=none;gateworks.com; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9bdfe581-faaa-449c-c872-08d992a5980f
x-ms-traffictypediagnostic: AS8PR04MB8834:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AS8PR04MB8834F352D1AD5F9A784FA7728CBD9@AS8PR04MB8834.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:639;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HPPuNZnrq8OZCwWhnT2EPJvwRZQIo200c1RIAyWZ4wP7jH88aqVIkUQwk6MI4H5F/Zc9WkTrP2Yvk979UIS5eipPGuWFCoFE4w44plakk8jL/t6gkas0ipUYgA+q+x7ttbX3eBxW9taghHZwREW9e4b0t1d2iO+Ch+MmMikmUz477el64iKq1hBIMzdywg6zuHz4bylWsPQ8ffBudxIoq7Zlz44szNVr3N2PLj2JYwojNAUlGLOehvjeqi6R6RuJ9toyhNNml0Yf/Y8YSOpEpoanB62m58zSAUCUqWL8QoEZ0Vz4+EqEP1Cv4bjS7GIKEe5UAiliRg+k52O+gLrv9k04cdKy9dty6At4ccqmkPP69Wxp2E3jJAHIvc47E0fMVXHpEwZKNFhNtrxqXFUubEWvnBOrtUHJ/72kjOkE35g/6NCPpywjQ97nRucgyVj3/G/qUYRw1TYo1NAA//2ZsGawqIdl9eLa5qzRyQJmPn0EL3L5fyJxcXkiSi6qDF8+21Y1xJMm8inwLqfc04mWm9aQ7u364aRk5F88e9kxgr63J++x9V2Njbmm9+DmKMePO3aIl0mz2TXHc+PQz2mLdBN9sMSH9CfTgNSKXwGhRalcQsifooO5ZYBeQLQgxOGKeZHFJja3SVIKmyX3lm+5HXZaZeyqViU5ceaY43OgcTgad+ZkKWrD8Z1dsf/Fy9kPYRYov7l8C9ZEEpX8Sz+Uk47IckpIigyBxNVM6PP2W7jlzdiJSmrsWf9jHMQEcai2raL+0Zpt2aIz4lRO+sLw1yZ70S8C7ARkuys8muNQanFRhjyEMo72zwyDd0SGAFAv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(84040400005)(316002)(7416002)(86362001)(7696005)(38100700002)(52536014)(38070700005)(966005)(45080400002)(6506007)(110136005)(8936002)(66446008)(9686003)(8676002)(33656002)(54906003)(5660300002)(55016002)(83380400001)(508600001)(4326008)(66946007)(71200400001)(2906002)(186003)(64756008)(66556008)(66476007)(26005)(53546011)(76116006)(122000001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hZd85vcH4dop3YMBe5xzYv2LTz0FmTezmezEnxPqvT0J4g1TuiUEua36cv/7?=
 =?us-ascii?Q?CU+Qlukm7FT/UR86YcgnjqnpeAqY5XUP1qiz7/DKtC/ESpdrF+gfkkXvB+Sz?=
 =?us-ascii?Q?SQQ0oSWZ4UBUE4H9XDQYpPLpOpviWETuceNWbXbH8aeBQCPCO5EmasuYxqtw?=
 =?us-ascii?Q?3zDyVvrPHO6pb7sDRAWRQ6yPcZ6HsXapIBdxHoPoBkuqfliBkUSYgGmzIk/1?=
 =?us-ascii?Q?dw+PE82WGPl6EtsRwB0H3EYL0B7t5muMp3TN+33hQ1jTHZf7YK4sNcF0MinX?=
 =?us-ascii?Q?NDq0F0B4ZLGeJq5d/S8Dd41A/f+B43n4wWN+mqA4bLlp8RFAjZctejJ7IAAD?=
 =?us-ascii?Q?gNd9VmQ5WtcED3//20eZbshr5wXhFS6wNeubg2M5DLiYJg6O5km9oWaXeowP?=
 =?us-ascii?Q?SYoiCP/qng5JguAZwS0l7wL32Jw3F99rTTZJrIsumD24/TH4CcispN79LOs4?=
 =?us-ascii?Q?UoMyO7f5+BOTB8ygOHS+dSttje7BBITTvVVsni0srjTPyxGNqypcKWdDFtRx?=
 =?us-ascii?Q?cgObgukDoiwCtmCXiprI6c/gKc8BZTSr5iU9vrH04GTGE9rOiLgOjsdsXE5i?=
 =?us-ascii?Q?gPfZ0C2Q6FoqMoo/GNXCcgtGQ427w+T04h3coJ8X31XTL4aRi+CFnvvQMuqW?=
 =?us-ascii?Q?2fXprdmatwCc5B+xQLsdRRqtTDpGh49JsyweWWqK/hlCqCBdFp8sKYzloLxv?=
 =?us-ascii?Q?QhH/4ZgtTmxQ5m3uFDeAOYGQcaPvQDU7vCj99izI5o8WskXc34bTYQhMmpoB?=
 =?us-ascii?Q?089Qj6+kQxMq1c9VrM3a2AgbUkOGMcLps0JB3uqq69XKhmWtbrEtd6nwdmiI?=
 =?us-ascii?Q?UkdhA3HZBe8bt+6VAncWv03gUcXQ4t4LMQKLJSM/vu8ObxVr2v9VUAySaim2?=
 =?us-ascii?Q?wovtqDYDeTWrsUSU856ixeZr6SXMmsGh8wsFovW2h4XyqzIMrWMig2vBTbcj?=
 =?us-ascii?Q?beVTkGOQLhdk3tAIUWhxfzIy9oT26LHIUP0INFIeZDMF177sO5YYp6da0DD2?=
 =?us-ascii?Q?tUzi5Di8Vg/0QHE1MA9WGsv8NGkhts0SnZjr0F0RKGpO1xv3lyI0pjFVHJHX?=
 =?us-ascii?Q?E4HnqSJIP0y4bFj31SVm5O1OJ2UJtOiaLNHNf54YC51js/9K1N0NNk9t4Mm6?=
 =?us-ascii?Q?5U1uIniJQPfuSc+VpbKrKIBNq+SjsTzuAzPQePZduKsSprXQrXZtqCsrRH4i?=
 =?us-ascii?Q?GR8ZuiAXqEEPQRMRq9ShBUBL4qxQvBExac/J15NrON5WvBOErHLOjnehZnbq?=
 =?us-ascii?Q?6cfiJMy2LUx8u6ERgka4/asYNj62hmy4p4MHbuIt6z30E5oUzrnishjoSe46?=
 =?us-ascii?Q?SsWB2ebCRngv2YcqBNYqSgq/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bdfe581-faaa-449c-c872-08d992a5980f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2021 02:10:16.6821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PA0mA5ivX60vdKuVEhZTYoG5RJIzy11wvNP10c01y47OjQLtuHCeSiEscNU9ZpFj9mPSuG9hduT6bY/XtvXTUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8834
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Tim Harvey <tharvey@gateworks.com>
> Sent: Saturday, October 16, 2021 3:59 AM
> To: Richard Zhu <hongxing.zhu@nxp.com>; Lucas Stach
> <l.stach@pengutronix.de>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>; vkoul@kernel.org; Rob Herring
> <robh@kernel.org>; galak@kernel.crashing.org; Shawn Guo
> <shawnguo@kernel.org>; linux-phy@lists.infradead.org; Device Tree Mailing
> List <devicetree@vger.kernel.org>; Linux ARM Mailing List
> <linux-arm-kernel@lists.infradead.org>; open list
> <linux-kernel@vger.kernel.org>; Sascha Hauer <kernel@pengutronix.de>;
> dl-linux-imx <linux-imx@nxp.com>
> Subject: Re: [PATCH v3 0/9] add the imx8m pcie phy driver and imx8mm pcie
> support
>=20
> On Tue, Oct 12, 2021 at 2:06 AM Richard Zhu <hongxing.zhu@nxp.com>
> wrote:
> >
> > refer to the discussion [1] when try to enable i.MX8MM PCIe support,
> > one standalone PCIe PHY driver should be seperated from i.MX PCIe
> > driver when enable i.MX8MM PCIe support.
> >
> > This patch-set adds the standalone PCIe PHY driver suport[1-5], and
> > i.MX8MM PCIe support[6-9] to have whole view to review this patch-set.
> >
> > The PCIe works on i.MX8MM EVK board based the the blkctrl power driver
> > [2] and this PHY driver patch-set.
> >
> > [1]
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpat=
c
> >
> hwork.ozlabs.org%2Fproject%2Flinux-pci%2Fpatch%2F20210510141509.929
> 120
> >
> -3-l.stach%40pengutronix.de%2F&amp;data=3D04%7C01%7Chongxing.zhu%40
> nxp.c
> >
> om%7C4e3d8ee008d94327f99108d9901634be%7C686ea1d3bc2b4c6fa92cd
> 99c5c3016
> >
> 35%7C0%7C0%7C637699247319711209%7CUnknown%7CTWFpbGZsb3d8ey
> JWIjoiMC4wLj
> >
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp
> ;sdata=3D
> >
> Z2TZCpdDUSoqrNB1X%2BXdoYNBe3dBDKUgkA4r%2F0TcdOg%3D&amp;reser
> ved=3D0
> > [2]
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpat=
c
> >
> hwork.kernel.org%2Fproject%2Flinux-arm-kernel%2Fcover%2F202109102026
> 40
> > .980366-1-l.stach%40pengutronix.de%2F&amp;data=3D04%7C01%7Chongxin
> g.zhu%
> >
> 40nxp.com%7C4e3d8ee008d94327f99108d9901634be%7C686ea1d3bc2b4c6
> fa92cd99
> >
> c5c301635%7C0%7C0%7C637699247319711209%7CUnknown%7CTWFpbGZ
> sb3d8eyJWIjo
> >
> iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C10
> 00&amp
> > ;sdata=3D5h%2By%2FcBW%2BjFkyplUuN1nB5%2BAFHuwCUJBqvRh1RiPYMo
> %3D&amp;rese
> > rved=3D0
> >
> > Main changes v2 --> v3:
> > - Regarding Lucas' comments.
> >  - to have a whole view to review the patches, send out the i.MX8MM PCI=
e
> support too.
> >  - move the PHY related bits manipulations of the GPR/SRC to standalone
> PHY driver.
> >  - split the dts changes to SOC and board DT, and use the enum instead =
of
> raw value.
> >  - update the license of the dt-binding header file.
> >
> > Changes v1 --> v2:
> > - Update the license of the dt-binding header file to make the license
> >   compatible with dts files.
> > - Fix the dt_binding_check errors.
> >
> > Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |   6 +++
> > Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml |  79
> +++++++++++++++++++++++++++++
> > arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi                |  53
> ++++++++++++++++++++
> > arch/arm64/boot/dts/freescale/imx8mm.dtsi                    |
> 46 ++++++++++++++++-
> > drivers/pci/controller/dwc/pci-imx6.c                        |  63
> ++++++++++++++++++++++-
> > drivers/phy/freescale/Kconfig                                |   9
> ++++
> > drivers/phy/freescale/Makefile                               |   1
> +
> > drivers/phy/freescale/phy-fsl-imx8m-pcie.c                   | 218
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> ++++++++++++++++++
> > include/dt-bindings/phy/phy-imx8-pcie.h                      |  14
> ++++++
> > 9 files changed, 486 insertions(+), 3 deletions(-)
> >
> > [PATCH v3 1/9] dt-bindings: phy: phy-imx8-pcie: Add binding for the
> > [PATCH v3 2/9] dt-bindings: phy: add imx8 pcie phy driver support
> > [PATCH v3 3/9] arm64: dts: imx8mm: add the pcie phy support [PATCH v3
> > 4/9] arm64: dts: imx8mm-evk: add the pcie phy support [PATCH v3 5/9]
> > phy: freescale: pcie: initialize the imx8 pcie [PATCH v3 6/9]
> > dt-bindings: imx6q-pcie: Add PHY phandles and name [PATCH v3 7/9]
> > arm64: dts: imx8mm: add the pcie support [PATCH v3 8/9] arm64: dts:
> > imx8mm-evk: add the pcie support on imx8mm [PATCH v3 9/9] PCI: imx:
> > add the imx8mm pcie support
>=20
> Richard and Lucas,
>=20
> Thanks for your collective work on this series!
>=20
> I have imx8mm-venice boards to test this on both with and without PCIe
> bridges. I've tested this on top of Shawn's imx/for-next (as blk-ctl has =
been
> merged there) and end up hanging waiting for PHY ready timeout.
[Richard Zhu] Sorry to reply late. I run the tests based on pci/for-next ap=
plied the blk-ctl issue by Lucas [2] in commit.
Can you help to make a re-tests?
As I know that the blk-ctl is not merged yet.
Hi Lucas:
Am I right?

BR
Richard

>=20
> [    1.454308] imx6q-pcie 33800000.pcie:       IO
> 0x001ff80000..0x001ff8ffff -> 0x0
> [    1.466538] imx6q-pcie 33800000.pcie:      MEM
> 0x0018000000..0x001fefffff -> 0x0
> [    1.476344] libphy: fec_enet_mii_bus: probed
> [    1.602631] phy phy-32f00000.pcie-phy.0: phy init failed --> -110
> [    1.608775] imx6q-pcie 33800000.pcie: Waiting for PHY ready timeout!
>=20
> I can verify that imx8_pcie_phy_probe returns successfully and the the ph=
y
> node (imx6_pcie->phy) was found.
>=20
> Here is the dt change I made for the imx8mm-venice-gw71xx-0x board that
> has no bridge:
[Richard Zhu] Refer to the changes, the external OSC is used as PCIe REF cl=
ock(same to EVK board design), right?

> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi
> index 91544576f145..e89e9cf7318e 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi
> @@ -5,6 +5,7 @@
>=20
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/leds/common.h>
> +#include <dt-bindings/phy/phy-imx8-pcie.h>
>=20
>  / {
>         aliases {
> @@ -33,6 +34,12 @@
>                 };
>         };
>=20
> +       pcie0_refclk: pcie0-refclk {
> +               compatible =3D "fixed-clock";
> +               #clock-cells =3D <0>;
> +               clock-frequency =3D <100000000>;
> +       };
> +
>         pps {
>                 compatible =3D "pps-gpio";
>                 pinctrl-names =3D "default"; @@ -101,6 +108,27 @@
>         status =3D "okay";
>  };
>=20
> +&pcie0 {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_pcie0>;
> +       reset-gpio =3D <&gpio4 6 GPIO_ACTIVE_LOW>;
> +       clocks =3D <&clk IMX8MM_CLK_PCIE1_ROOT>, <&clk
> IMX8MM_CLK_PCIE1_AUX>,
> +                <&clk IMX8MM_CLK_DUMMY>, <&pcie0_refclk>;
> +       clock-names =3D "pcie", "pcie_aux", "pcie_phy", "pcie_bus";
> +       assigned-clocks =3D <&clk IMX8MM_CLK_PCIE1_AUX>,
> +                         <&clk IMX8MM_CLK_PCIE1_CTRL>;
> +       assigned-clock-rates =3D <10000000>, <250000000>;
> +       assigned-clock-parents =3D <&clk IMX8MM_SYS_PLL2_50M>,
> +                                <&clk IMX8MM_SYS_PLL2_250M>;
> +       status =3D "okay";
> +};
> +
> +&pcie_phy {
> +       fsl,refclk-pad-mode =3D <IMX8_PCIE_REFCLK_PAD_INPUT>;
> +       clocks =3D <&clk IMX8MM_CLK_DUMMY>;
> +       status =3D "okay";
> +};
> +
>  /* GPS */
>  &uart1 {
>         pinctrl-names =3D "default";
> @@ -162,6 +190,12 @@
>                 >;
>         };
>=20
> +       pinctrl_pcie0: pciegrp {
> +               fsl,pins =3D <
> +                       MX8MM_IOMUXC_SAI1_RXD4_GPIO4_IO6
> 0x41
> +               >;
> +       };
> +
>         pinctrl_pps: ppsgrp {
>                 fsl,pins =3D <
>                         MX8MM_IOMUXC_GPIO1_IO15_GPIO1_IO15
> 0x41
>=20
> and here are the changes to the imx8mm-venice-gw72xx-0x dt - this board
> has a PCIe bridge:
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi
> index b12ead847302..260ea93ebfc2 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi
> @@ -5,9 +5,11 @@
>=20
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/leds/common.h>
> +#include <dt-bindings/phy/phy-imx8-pcie.h>
>=20
>  / {
>         aliases {
> +               ethernet1 =3D &eth1;
>                 usb0 =3D &usbotg1;
>                 usb1 =3D &usbotg2;
>         };
> @@ -33,6 +35,12 @@
>                 };
>         };
>=20
> +       pcie0_refclk: pcie0-refclk {
> +               compatible =3D "fixed-clock";
> +               #clock-cells =3D <0>;
> +               clock-frequency =3D <100000000>;
> +       };
> +
>         pps {
>                 compatible =3D "pps-gpio";
>                 pinctrl-names =3D "default"; @@ -122,6 +130,53 @@
>         status =3D "okay";
>  };
>=20
> +&pcie0 {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_pcie0>;
> +       reset-gpio =3D <&gpio4 6 GPIO_ACTIVE_LOW>;
> +       clocks =3D <&clk IMX8MM_CLK_PCIE1_ROOT>, <&clk
> IMX8MM_CLK_PCIE1_AUX>,
> +                <&clk IMX8MM_CLK_DUMMY>, <&pcie0_refclk>;
> +       clock-names =3D "pcie", "pcie_aux", "pcie_phy", "pcie_bus";
> +       assigned-clocks =3D <&clk IMX8MM_CLK_PCIE1_AUX>,
> +                         <&clk IMX8MM_CLK_PCIE1_CTRL>;
> +       assigned-clock-rates =3D <10000000>, <250000000>;
> +       assigned-clock-parents =3D <&clk IMX8MM_SYS_PLL2_50M>,
> +                                <&clk IMX8MM_SYS_PLL2_250M>;
> +       status =3D "okay";
> +
> +       pcie@0,0 {
> +               reg =3D <0x0000 0 0 0 0>;
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +
> +               pcie@1,0 {
> +                       reg =3D <0x0000 0 0 0 0>;
> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <0>;
> +
> +                       pcie@2,3 {
> +                               reg =3D <0x1800 0 0 0 0>;
> +                               #address-cells =3D <1>;
> +                               #size-cells =3D <0>;
> +
> +                               eth1: pcie@5,0 {
> +                                       reg =3D <0x0000 0 0 0 0>;
> +                                       #address-cells =3D <1>;
> +                                       #size-cells =3D <0>;
> +
> +                                       local-mac-address =3D [00 00
> 00 00 00 00];
> +                               };
> +                       };
> +               };
> +       };
> +};
> +
> +&pcie_phy {
> +       fsl,refclk-pad-mode =3D <IMX8_PCIE_REFCLK_PAD_INPUT>;
> +       clocks =3D <&clk IMX8MM_CLK_DUMMY>;
> +       status =3D "okay";
> +};
> +
>  /* off-board header */
>  &sai3 {
>         pinctrl-names =3D "default";
> @@ -214,6 +269,12 @@
>                 >;
>         };
>=20
> +       pinctrl_pcie0: pciegrp {
> +               fsl,pins =3D <
> +                       MX8MM_IOMUXC_SAI1_RXD4_GPIO4_IO6
> 0x41
> +               >;
> +       };
> +
>         pinctrl_pps: ppsgrp {
>                 fsl,pins =3D <
>                         MX8MM_IOMUXC_GPIO1_IO15_GPIO1_IO15
> 0x41
>=20
>=20
> Any ideas?
>=20
> Perhaps
