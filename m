Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B672E43BF22
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 03:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237756AbhJ0Blp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 21:41:45 -0400
Received: from mail-db8eur05on2072.outbound.protection.outlook.com ([40.107.20.72]:47840
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232003AbhJ0Blk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 21:41:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhjcxXDSCw7TB+OpMeKwrvcE9/xg9AHLF/fKZGJLMe8OSFE3LSzCU32cf/8hW0kcKBL0ltNrW7gNEBn/kJcP7XGNgJE6qij0K+thO2VpCVg3OwKe7PrlORQQwdz9bqJG7tcuth3gmF+ajQcrn4vHkrl/y3yIQ+XZ4RDXDjBQ0pSsFXoDq46kAZoj5l0f1uaBHXd/fTsFjYfJ3ztN5H97Kd+H5EH3tIHjroW0004PduA4tFMKyQr3JO4/E5e5T7zsD1QHsjRNRTn2D+YHNrSO47Wb0vKkKg/f8SrUEYXEoAS5M10tKYYK5usQtnmh1Oj3lXaxkR/OeyaA3NnPw+LU4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+fK+aS7qdVrOWHzvrlZweX9pRLTh6mnOF0RTF3EH0Q=;
 b=D86yL/X+5GpHATI+LPt8BFowWqa7r2qATcm/nnCGhHMoxuMe6WUSqcCUqllAYZH+l3mTd1fcjBTgTL+/qo6QZX5Mi+4FhF84umh0GvsaktWnztgZTiNQAdKeszKyy/kfPIRqzvUPR7XdykeUdSKqupkTQWV13cMU/MIBiLuLr3hIiMWmDVmGpzEVImMlQvMxVN2yF6L1VEBrXiiRq78m4qNbNi/lyXoVZahP0Pf0YRjUxqN+ZJ5lKwO6Kcw4bWNO4HcONZRsWW6NnRlQSyF2122v1+EtQPAaQucxo+dIdJp/QY6Y8unrJUroWeba2rohh9j6UYEMXsX/L6KxiXKxiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+fK+aS7qdVrOWHzvrlZweX9pRLTh6mnOF0RTF3EH0Q=;
 b=f1nnH+BCo9JtZXooLfoNbtnfZoqesEjz8ZTwXDJPMaPmTHFD673MJ+D0MpfTNyERJ8lE5K8M4IqbYgTsSq5oUhVsZu4IZf2Oqqtli1TQFzwmUAIxdXMNDKc8sneQjaE0mQLuhn5JvxYxr/ia3f+Q+Gs0PfTVa0WKRXbZjM7M1VA=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8484.eurprd04.prod.outlook.com (2603:10a6:20b:34c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13; Wed, 27 Oct
 2021 01:39:13 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc%5]) with mapi id 15.20.4649.014; Wed, 27 Oct 2021
 01:39:13 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "galak@kernel.crashing.org" <galak@kernel.crashing.org>
CC:     "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v3 0/9] add the imx8m pcie phy driver and imx8mm pcie
 support
Thread-Topic: [PATCH v3 0/9] add the imx8m pcie phy driver and imx8mm pcie
 support
Thread-Index: AQHXyoIP9WRZIWT4CUunBVSnJ63L4qvmD1nA
Date:   Wed, 27 Oct 2021 01:39:13 +0000
Message-ID: <AS8PR04MB8676F26022A5EA033FA5515B8C859@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1634028078-2387-1-git-send-email-hongxing.zhu@nxp.com>
 <6af982786f0136d5f984beaf544e2ba7b7b68d31.camel@toradex.com>
In-Reply-To: <6af982786f0136d5f984beaf544e2ba7b7b68d31.camel@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15c385b9-7fff-4b60-8c88-08d998ea949a
x-ms-traffictypediagnostic: AS8PR04MB8484:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AS8PR04MB84842C83EBD2D8A09E9F194E8C859@AS8PR04MB8484.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9NBIhxbZiPbUqhp+aB/gnD4+mt4j4A2C3NklzeTvOCmijmcQZW3eEPL9ThihWo6463biP9BhVNfKdPGa8vwhCgrH4l54VSzn2RuamqePpUc34zR+Dkj+3o0+4tGhW/OAKAjdAZ3a7Vpjoqdxf+N7H651VHB81jdrgGaj0PJ5PtP1TBi4g5cwME/u6k3PeOZd+WxAnHi6bNKEu2zVnfeWlzA/KddKE5o/15rClkVW6oYu9tVe5zZ5j+8QeIKjOV3bt/NFz5RWYFKVlSe3szSvE3zFpqxEglCXWkmMkLoFSBVGjvXQFc89tHAP5ECyoKVz7ULp7NEOonaD978YocLLdG5a0UtStL5Q+mXIm8Ji6n7O0taELKawiVX+M0N91UUbiBLlot5ANhXcaLAwSD2bluEhkrHAHEIShECCY5qHxffytWRJ8abmffQEALHNFCQ1ghrqA9IaEWECgHphX/hq46e4tqOFnd6abz87MPS5dK1kp9/OsH27OAMRL3ZaEoIcI1PCAF16OrTYLmnTABks/B3j4cVPqsm04zyCspPVAWkPwRcMWwsc2kLyaDrXvZBq9ItuBmPp+MTfG0n6L5dHceUhgUcPJOy0Jh6ZXpTuK1UyT4vALa2TSPQ8jQT9rImVL7W7+xlPgGjNjurG0Vkh57ZOw6tL49z6lnZ8cOlZDNQJUotwzZEbEWb693J88bkaIJvlWqe4GQWhNuUrDtUVoYpGrLMIPs6wFexXK8ycRHrwXcJGNZGM3FfUagRCsBSyRzzRi7XWSSIKrLbOvT2iPp/4aefsEC3/xeJY1qfzZ40t5UgLI51yfupTddvraRLm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(76116006)(53546011)(8936002)(66446008)(86362001)(186003)(38070700005)(966005)(26005)(7696005)(66476007)(64756008)(7416002)(122000001)(38100700002)(45080400002)(66946007)(4326008)(71200400001)(508600001)(9686003)(6506007)(110136005)(2906002)(54906003)(52536014)(66556008)(8676002)(4001150100001)(33656002)(55016002)(83380400001)(316002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mZXYbOgX8g6+vt1fzvDjj8UoV+I+YACpmITkiS/TUpWeXPcxgnbsCVipEh?=
 =?iso-8859-1?Q?99LQjVzYECvEe9qoj8VvTpdnCrrjqJfJumol+B3uTjtVA4phceCt2zXpmb?=
 =?iso-8859-1?Q?ZXE7aECyrL77N2J71cyUlqejKQ6qb1diChkcuuUYiN0x8kfhA8oF7WX3NE?=
 =?iso-8859-1?Q?8KZojlJyVZvsqdkl+bVtnf7YzilIZLafIpf1OWrmFFoeLJR023WuOerplR?=
 =?iso-8859-1?Q?aJEwz55vzlt/CwC6YmtcxQnra6OiPhSiTu6tPqzEUbNGydIi9xKkhxADcO?=
 =?iso-8859-1?Q?g+7CQkCSwinxXH9vTDIAhUrYYT1R1p+pSzyGs5IRbJ/Rmv1Elhe0+JzW2V?=
 =?iso-8859-1?Q?1V7lvRdrYT0Od0hBQ6Y4t/K1ByENNul24/V4s0LvewgFy9ATJKWKPN8IV4?=
 =?iso-8859-1?Q?8VmZMF7RTvH/wKq10sqZWkF/BN5ZqBZ0AlQl8eIGYyXBPlMOc5HP6CuG2U?=
 =?iso-8859-1?Q?gDq8a/18wstFljvHhdvIPyzlw+SwHR/QRzCrc0Hw48uV/d1CN/BVBnOyjC?=
 =?iso-8859-1?Q?1JtZG9FeF0eGBBEOUQ/amqzhdNTPyW2vmFT0K1kfZ3dGD1YpdaZbm4N3nK?=
 =?iso-8859-1?Q?Z/CcCv5sxwsoXL/LdxUE4PZz0+7rv7J0d+53ptdkoGsCqNWpnXTjNr95A9?=
 =?iso-8859-1?Q?shdU3lw7tiTaLkslYeovZFj1YGsigsAQ2dK6n506XUm/uVcn6hdfkZCk5f?=
 =?iso-8859-1?Q?nepaWlapMSmnAO1kTCsfFTcGJ4owdpugR2VuskwaahyuIHq5QQ8Bcl7kz8?=
 =?iso-8859-1?Q?ynjL29+XvWgrc75GY5rs79NPv0vag5RtaF7m6VuWpCU1ZxxOctX7ijLUs9?=
 =?iso-8859-1?Q?mbEHiIxa4MIjTUZzepLn55VEK3ikTdwEWsAnu5uksOuWO6kt8N2CczYqK2?=
 =?iso-8859-1?Q?hPNI1BksZM+Sf4/cDvB2350Q0pXzx7U0D0+Jn2oJtHcu1WnMyT3YoZguJZ?=
 =?iso-8859-1?Q?IQct/qZlKCs3GylHWzx/FHddKKNwMyTeHbvUN3K1lr+00MLvek4Sgsdojg?=
 =?iso-8859-1?Q?TrkLgOj8OtIBHlm2dVHVY/9KIT5OQOckjOaGw6T8XvzGx5u26Sm6HQNCjV?=
 =?iso-8859-1?Q?SQ10rCRBpsHxTiL8liMgLbplReoBtB6h0v5/8qylFCrgvasBSpylF0nb1/?=
 =?iso-8859-1?Q?60JPwc430dEw894v8ykq99xH3Qniokvja7pwLlf0RKvSDVTRTcphTAUpMd?=
 =?iso-8859-1?Q?Rbocso/hGGhliy/hnDyXASvcxHCIiy09NPESA49KQF7iQnIGlECShxxkEA?=
 =?iso-8859-1?Q?f+9TKICA0JWC1s1nLR0EoeDWFKEgp+VH+FRlWxQXm35gqJ4VvkBjOmjgiH?=
 =?iso-8859-1?Q?lvBtEkNsTq1kkzlQk6jHQ3o5utrTH5m3X10tF8mprNf77rne8qScKZX5T3?=
 =?iso-8859-1?Q?0Ni+oYhlToncxaR8dpuSx9wNrlhRSVfFVsJ8X3/7+x/TrP6ThKJUvUFpnA?=
 =?iso-8859-1?Q?jvu+aZaqrK+i8tXR0Ook1cJi1jhQ73gJY9XFHLAPWq68rEPelAaKsuRAaL?=
 =?iso-8859-1?Q?BooxH1sUF/fF5v+1sj/vfUdtxrJV5jVb/xXyoc8ywFrUFJOE5y81EwFEWC?=
 =?iso-8859-1?Q?Sd8BYaqmVdEy8wGaMosWmfEbOaQanvp+A5CK6mAIzfyOarzlS0ibmAZHR1?=
 =?iso-8859-1?Q?mnExExA5OZHWn4sxflRqumwu/VCLJGrjUEIJV5anmqWV3IlMmHHJznyA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c385b9-7fff-4b60-8c88-08d998ea949a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2021 01:39:13.1426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R9oCygYlqNrGytRFlSugceXAdQEjrQ6jQI8OQDc9fYGDiYEp9ucWT6aF2ZDMTay9FayvRt64wEtCSORSoqyakw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8484
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Sent: Tuesday, October 26, 2021 11:57 PM
> To: kishon@ti.com; vkoul@kernel.org; robh@kernel.org;
> l.stach@pengutronix.de; shawnguo@kernel.org; tharvey@gateworks.com;
> galak@kernel.crashing.org; Richard Zhu <hongxing.zhu@nxp.com>
> Cc: linux-phy@lists.infradead.org; linux-arm-kernel@lists.infradead.org;
> kernel@pengutronix.de; devicetree@vger.kernel.org;
> linux-kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> Subject: Re: [PATCH v3 0/9] add the imx8m pcie phy driver and imx8mm pcie
> support
>=20
> On Tue, 2021-10-12 at 16:41 +0800, Richard Zhu wrote:
> > refer to the discussion [1] when try to enable i.MX8MM PCIe support,
> > one standalone PCIe PHY driver should be seperated from i.MX PCIe
> > driver when enable i.MX8MM PCIe support.
> >
> > This patch-set adds the standalone PCIe PHY driver suport[1-5], and
> > i.MX8MM PCIe support[6-9] to have whole view to review this patch-set.
> >
> > The PCIe works on i.MX8MM EVK board based the the blkctrl power driver
> > [2] and this PHY driver patch-set.
>=20
> Whole series:
>=20
> Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>=20
> BTW: I tested it on Verdin iMX8M Mini V1.1B without an external PCIe
> oscillator aka setting fsl,refclk-pad-mode to
> IMX8_PCIE_REFCLK_PAD_OUTPUT which worked like a charm. Thanks!
>=20
[Richard Zhu] Thanks for your tests.

Best Regards
Richard Zhu

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
> om%7Cbacb5db20f2d4aa7a4ad08d998993356%7C686ea1d3bc2b4c6fa92cd9
> 9c5c3016
> >
> 35%7C0%7C0%7C637708606037565160%7CUnknown%7CTWFpbGZsb3d8ey
> JWIjoiMC4wLj
> >
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp
> ;sdata=3D
> >
> Mmea0v4pP5VzSM%2F8sIStLkwvA0pY0h2lG4Vzvr8Gk%2F4%3D&amp;reserv
> ed=3D0
> > [2]
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpat=
c
> >
> hwork.kernel.org%2Fproject%2Flinux-arm-kernel%2Fcover%2F202109102026
> 40
> > .980366-1-l.stach%40pengutronix.de%2F&amp;data=3D04%7C01%7Chongxin
> g.zhu%
> >
> 40nxp.com%7Cbacb5db20f2d4aa7a4ad08d998993356%7C686ea1d3bc2b4c6
> fa92cd99
> >
> c5c301635%7C0%7C0%7C637708606037565160%7CUnknown%7CTWFpbGZ
> sb3d8eyJWIjo
> >
> iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C10
> 00&amp
> > ;sdata=3D5U%2BP0zL0OskhyB0RtH%2FsBwRn0B1Lb27ZSpjjhFD0wUo%3D&a
> mp;reserved
> > =3D0
> >
> > Main changes v2 --> v3:
> > - Regarding Lucas' comments.
> > =A0- to have a whole view to review the patches, send out the i.MX8MM
> PCIe support too.
> > =A0- move the PHY related bits manipulations of the GPR/SRC to standalo=
ne
> PHY driver.
> > =A0- split the dts changes to SOC and board DT, and use the enum instea=
d of
> raw value.
> > =A0- update the license of the dt-binding header file.
> >
> > Changes v1 --> v2:
> > - Update the license of the dt-binding header file to make the license
> > =A0 compatible with dts files.
> > - Fix the dt_binding_check errors.
> >
> > Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml=A0=A0=A0 |=A0=
=A0 6
> +++
> > Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml |=A0 79
> > +++++++++++++++++++++++++++++
> >
> arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 |
> 53
> > ++++++++++++++++++++
> arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > |=A0 46 ++++++++++++++++-
> drivers/pci/controller/dwc/pci-imx6.c
> > |=A0 63 ++++++++++++++++++++++-
> drivers/phy/freescale/Kconfig
> > |=A0=A0 9 ++++
> drivers/phy/freescale/Makefile
> > |=A0=A0 1 +
> drivers/phy/freescale/phy-fsl-imx8m-pcie.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 |
> > 218
> >
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> ++++++++++++++++++
> >
> include/dt-bindings/phy/phy-imx8-pcie.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |
>  14
> > ++++++
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
