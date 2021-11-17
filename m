Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF494453F0E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 04:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbhKQDlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 22:41:47 -0500
Received: from mail-eopbgr80085.outbound.protection.outlook.com ([40.107.8.85]:35600
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229908AbhKQDlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 22:41:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLYoeECVi4KzwUoRrplM9leoD9cpCxAEuNFyQqx/rv8FAXvrbWZUqTtIHS4gpAQvpD9s7zSgjePAtJr9lSeiDrGGFWn5cor9xXG5m6DjisBrt1VyEaVmVcKQOSorOS1wg0MhlfT8rxro62uP+gXvgRq8RTtqaO3Gkbv3bRJXGsPOAf93OrU198e0HrHfpwholsplaozbVHkq1WVLfKwPavebwIgG99U9u6NfzvOkjjCjTojJ1hQK5mYCkZt6rj3BePp0rCY6NUTPUnLNGABPDXSpiAJGktj0Etxt2wGFQSy/VqQvrquZh8v5LJoRvRDVKwatvCHKW9zfAJ2IDcd7gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C70Pj/FcGlJDkdSboShAWcr1w5/UGDxgkTbHkr9aGKU=;
 b=Aur72OBdmM9mfXD3/GE+OnVV9nKd+t6g5xReTP5ACS3hcfGbkGzG2nP+iH+U4jVG1XJR8pNUicT6eBOBCUELZpm4RsoTOHWjFJxZAVV7ey4EPrtEW2XZZkFgUphZH8A6jEAs4kUW/ofBYVWtoOwDJzLdWuXeJTWTRgK8ebfHUocNZEx7eYrCFS34iBmDd+jkECqAXIbui/OhndMlaFvQqeVQnbzx2tvTrB89neWIoJtwwQQW6gaKP3UjjtT7y33i6X/xVPcElAlY+dmYvfN+Lpzq+8yz7L6r4Yc/0c2yalwxpkL3IrpRclk+dy4366oZRTSMojF0X4UC01vzTZ61rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C70Pj/FcGlJDkdSboShAWcr1w5/UGDxgkTbHkr9aGKU=;
 b=Puc3TY+P8IibBXb/9C5kA9cuavi+quYlrL8FkVs9z0uPVliMplC0BaM43uRToanI4cAcXds0jzsQfF9ZNLmNPK/bteUXHGBLVNjIXMS5bCMatXtr0vhZzPmgUYqb0NvGOQCu2+dbl4TctTlkPM3q4JSihqoTCr1KczYCEK0UqGU=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8993.eurprd04.prod.outlook.com (2603:10a6:20b:42c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Wed, 17 Nov
 2021 03:38:46 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc%4]) with mapi id 15.20.4713.019; Wed, 17 Nov 2021
 03:38:46 +0000
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
Thread-Index: AQHX2nQKnAA55lO24Eigwg7jrckmc6wFXtVggAGcAoA=
Date:   Wed, 17 Nov 2021 03:38:46 +0000
Message-ID: <AS8PR04MB867632F01C9B0524BE994A5F8C9A9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1635820355-27009-1-git-send-email-hongxing.zhu@nxp.com>
 <CAJ+vNU3r0aC8GrTQ2z5BqsCFCAXP+BWt2ntqsNy8DBd--nxdvQ@mail.gmail.com>
 <AS8PR04MB86760660BD24E4C2BD98F6318C999@AS8PR04MB8676.eurprd04.prod.outlook.com>
In-Reply-To: <AS8PR04MB86760660BD24E4C2BD98F6318C999@AS8PR04MB8676.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc041854-1247-4e46-7940-08d9a97bc2b9
x-ms-traffictypediagnostic: AS8PR04MB8993:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AS8PR04MB8993FD9E11ED75E9AF571E258C9A9@AS8PR04MB8993.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i8PM9U6f0kACkuKyg51l0GJPIvvE4aYtXJburWaPNChxylTBFVHR2I+Ts948UpckWF+E1eSfyJz3HHMnAWZFu2ZCV6j7P48EFgLjjD3q0sv/f5PaxmibbjeHX8tyM6hBmF0f3eR7dutxqFYV4uz1Rnx3HefOa1PoVoO5zzUEkHOkds+s3WOT5BU8e8h/xN1zK/RTWIxhHLUnzYXrN19FT1SiMFBZtBHkHZSU8Pe7HZltvdzPlD5O6nGdggfVmTLmO7mrVyJQyBQ28U/wIa3+AUdDrhKcIKFQSTH1Wvhi5B7SH6csMQ37KOxJXMO0H22Pr5ugxA0giiXjVOOKPLt7bglHLH3EUvRN9GqRfWI59SdQ7BR2TJtjsCNuMMuX4cH2u6rwwwX5G4emonziGheoQm8GzU+Yy8525WrxNRuw2RWxvwWhk+I0kVk1bzaGAgFy5JSIq6DsUJFTHphT3xN5GJjKdM/jA2S564Eld8h894DyRiEpOd6WzEBgFq1aZ6tKw1TMcpc59aLZw+8VwoSrN1Ah4YUd0XtfYw5kUTSz/SWYeYh+ZTFc11mPLd69ncFbCCi3ukhVwnf7o97SfNUZLzLwthKL/6546JhXjGy/DkDw3PG2xW0EbPLgaa1HUaKkUdWJr6wxVphMQNENDWpElo86XPQ+q4FvQKahHHdES2xJpUeZJoGUBTce+HjfSMWEn7ho2LM7fI1MiLvVoxcLUGWEQerWrt1r97BdHcHMjYW9W5gZjpJhNMfmgGgB9QV2iMLGImkgWmKwgBI/bB4gUeymaTA9PtDwIjc/cJW7uwyYVrpHTbj2Ys4YNCui0eF4h/mWbQPEZp4Fnp3ER4yhXONIE3MVm8lKmBxU/iw0eMs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52536014)(26005)(4326008)(186003)(45080400002)(8936002)(7696005)(8676002)(71200400001)(5660300002)(44832011)(966005)(53546011)(38100700002)(55016002)(2906002)(122000001)(9686003)(508600001)(33656002)(64756008)(316002)(76116006)(6506007)(66446008)(6916009)(66946007)(83380400001)(7416002)(54906003)(86362001)(66476007)(66556008)(38070700005)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UULDKyWvVsWcXLCEDmH1F2gPGA/9KA7NElyuujJSr07/2EGEucKBOBA7IF5A?=
 =?us-ascii?Q?74B8Oxwx66lhw0oKfBOl933SFexBD3kCvAya82TNsr5MjEBk1SxUNnL9PmN3?=
 =?us-ascii?Q?Qdq1GD3n3Dloa3eqCCTvFdvj9qQMrdUsIyG3kEMZlG52n3ADxt0CVUMha9Tu?=
 =?us-ascii?Q?/A2pXvylj3W2+fiHaMrkMWre7MZwbUB3mycbziL+Daq18PCgZHFyelxcPW8+?=
 =?us-ascii?Q?nJPV/ptJDPReD6m+UjCl1JXsYeS6hEouDg5LRHu4PuFbExx50Tx3C8/o478y?=
 =?us-ascii?Q?oCJBbVq72je0sb2S8Iy0Sib9Fq5hJ4aZnSR5YPs4NSMF7BQVhvof9NwRhNQU?=
 =?us-ascii?Q?D22wzgcCo/T7QaaSiGjJ2inZl2H6qRQhBurdJpNIzoZRhHfC1oyaoXvVirL0?=
 =?us-ascii?Q?bSH9mfX2ShoFw3dUQdrv4h3fEDVi3cDQ6ZW1TSP4ebJfW+43Xy2u9jIWZUHo?=
 =?us-ascii?Q?yQ/NaejHjwsj+3MqH4vfO0E/naBpIqPCm3xNpiv5bbJ8yaUatEQZAt/q94dL?=
 =?us-ascii?Q?6aeO6uCu9jCYe7Aw/65Y5PWSEjpJ8OSHyyH2OEUzB/FAkGHlIgcOvLLLtg2j?=
 =?us-ascii?Q?ZeNbUXWwlLr78EHZxXDTlAcRcEM7xpfymiI2FryP46h6X+0BnqWqKBFp6y08?=
 =?us-ascii?Q?ePxoDjolpu7ZlCcNnx0Z5AdHR9DYgoPvkTdW5mxaF1LzRspyjELtzdrNqQuw?=
 =?us-ascii?Q?e99MJgEpCAyl/Ia6vIR0W8xEGC+gXNgQRFsDIaFozdEOuVdSVhiWB/yg9ahm?=
 =?us-ascii?Q?waDllJgMuxdIhaK/x8f6fo4gIUocb1hxb6Wf4ewemPT+uDK7/jLzBSNPrEDf?=
 =?us-ascii?Q?c3ONWV9TwDRbzFbfzlYqPdheB+3xRQOHRx440pR/rZEYSgMZx2UIZRLLGjFg?=
 =?us-ascii?Q?aocQFhlN3K2ve0pWBnVLaya4SiSwk9AkALM8uZx15vGY3l3ymzA5w9NpHp6h?=
 =?us-ascii?Q?Sm18gXwRSgevP1d7GxN/lFE/4VHCh3q4fZRhv3W0f06S7RfzV73yp7Vuv9yh?=
 =?us-ascii?Q?Vw8oLx3HWhVi3DO4E5dNG+nM1/I4S5GKeyaYOdn4Pr26KIFaVoeLgQYL2NQZ?=
 =?us-ascii?Q?el18X3uINXMOlIf+7+ukhkz0gTH0OuPnZZcW6AZl4wr6iMC5Zu+dSIK/ARyA?=
 =?us-ascii?Q?dEpOJLrXOoxPRFJnsgzQTyFkil/X7+fxnttQJh2e3dIUk/cedmMWq0uB5TYT?=
 =?us-ascii?Q?OYgZ4uF5kNB0Lt8SgJ/cM2A2oFlhhOWbKoZDAun+CwhdUWfAg+l+9Qhg0GXz?=
 =?us-ascii?Q?Q8z293zvkNe/bZSzy6GpgkAYMcUDP6pvaa9Btp0h/xjvQEysJ2nt9z+KWJoy?=
 =?us-ascii?Q?j7ox/rLAhUSuagCTsGfLfd63HiKjGjByLNVzI+UrGdNQYZ6/rcw47lOG60yk?=
 =?us-ascii?Q?ACtFXY3W4tXMXH8ZaslAaYEFfu+fG7PFbfkvsnTABxffjaC8bdbg4QgVb7V0?=
 =?us-ascii?Q?vgw0gcJsvAph/hMd/TFJWOdzjHGYHbJhv5epFleZeEys53EUeVCyPB+OYzgs?=
 =?us-ascii?Q?bfMmPDsCiLfi+LKwklrANI21CmH7rTeo7udOtSz9t7sDYPhw1I0fUsaidGYw?=
 =?us-ascii?Q?KhHH/XTCGM9FxAcOb0hbiSB0UlNb9QHvmxi/GwJ/UU1VNZVc/4/cUi370NOM?=
 =?us-ascii?Q?QA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc041854-1247-4e46-7940-08d9a97bc2b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2021 03:38:46.1497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A8YCVfipklGv6pFozIbrjJX+vBIHj97mCu36cqn1NA2eoVg5F8mTXLveOAxe/zrGVRypV7qcqj6TAtibBmtbNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8993
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<snipped...>
> > Subject: Re: [PATCH v5 0/8] Add the imx8m pcie phy driver and imx8mm
> > pcie support
> >
> > On Mon, Nov 1, 2021 at 7:58 PM Richard Zhu <hongxing.zhu@nxp.com>
> > wrote:
> > >
> > > Refer to the discussion [1] when try to enable i.MX8MM PCIe support,
> > > one standalone PCIe PHY driver should be seperated from i.MX PCIe
> > > driver when enable i.MX8MM PCIe support.
> > >
> > > This patch-set adds the standalone PCIe PHY driver suport[1-5], and
> > > i.MX8MM PCIe support[6-8] to have whole view to review this
> > patch-set.
> > >
> > > The PCIe works on i.MX8MM EVK board based the the blkctrl power
> > driver
> > > [2] and this patch-set. And tested by Tim and Marcel on the
> > > different reference clock modes boards.
> > >
> > > [1]
> > >
> >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpa
> > tc
> > >
> >
> hwork.ozlabs.org%2Fproject%2Flinux-pci%2Fpatch%2F20210510141509.
> > 929120
> > >
> >
> -3-l.stach%40pengutronix.de%2F&amp;data=3D04%7C01%7Chongxing.zhu
> > %40nxp.c
> > >
> >
> om%7C489971db9c0f4308600208d9a88b2b05%7C686ea1d3bc2b4c6fa9
> > 2cd99c5c3016
> > >
> >
> 35%7C0%7C0%7C637726137953234928%7CUnknown%7CTWFpbGZsb3d
> > 8eyJWIjoiMC4wLj
> > >
> >
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&
> > amp;sdata=3D
> > >
> >
> ltuNZqIAsEH6%2B1KE4cqNOiUul3Ex%2BWmYcyqD%2BFJuUrs%3D&amp;
> > reserved=3D0
> > > [2]
> > >
> >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpa
> > tc
> > >
> >
> hwork.kernel.org%2Fproject%2Flinux-arm-kernel%2Fcover%2F20210910
> > 202640
> > > .980366-1-l.stach%40pengutronix.de%2F&amp;data=3D04%7C01%7Ch
> on
> > gxing.zhu%
> > >
> >
> 40nxp.com%7C489971db9c0f4308600208d9a88b2b05%7C686ea1d3bc2
> > b4c6fa92cd99
> > >
> >
> c5c301635%7C0%7C0%7C637726137953234928%7CUnknown%7CTWFp
> > bGZsb3d8eyJWIjo
> > >
> >
> iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> > 7C3000&amp
> > > ;sdata=3DMrT3Re3YttE9AoqmGHksTqt4jF4vitRPz5lkgpZqSZ4%3D&amp;r
> es
> > erved=3D0
> > >
> > > Main changes v4 --> v5:
> > > - Set the AUX_EN always 1b'1, thus it can fix the regression
> > > introduced
> > in v4
> > >   series on Marcel's board.
> > > - Use the lower-case letter in the devicetreee refer to Marcel's
> > comments.
> > > - Since the default value of the deemphasis parameters are zero,
> > > only
> > set
> > >   the deemphasis registers when the input paramters are none zero.
> > >
> > > Main changes v3 --> v4:
> > > - Update the yaml to fix syntax error, add maxitems and drop
> > > description of phy
> > > - Correct the clock name in PHY DT node.
> > > - Squash the EVK board relalted dts changes into one patch, and drop
> > the
> > >   useless dummy clock and gpio suffix in DT nodes.
> > > - Add board specific de-emphasis parameters as DT properties. Thus
> > each board
> > >   can specify its actual de-emphasis values.
> > > - Update the commit log of PHY driver.
> > > - Remove the useless codes from PCIe driver, since they are moved to
> > > PHY driver
> > > - After the discussion and verification of the CLKREQ#
> > > configurations
> > with Tim,
> > >   agree to add an optional boolean property
> > > "fsl,clkreq-unsupported",
> > indicates
> > >   the CLKREQ# signal is hooked or not in HW designs.
> > > - Add "Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>"
> > > tag,
> > since
> > >   Marcel help to test the v3 patch-set.
> > >
> > > Main changes v2 --> v3:
> > > - Regarding Lucas' comments.
> > >  - to have a whole view to review the patches, send out the
> i.MX8MM
> > PCIe support too.
> > >  - move the PHY related bits manipulations of the GPR/SRC to
> > standalone PHY driver.
> > >  - split the dts changes to SOC and board DT, and use the enum
> > > instead
> > of raw value.
> > >  - update the license of the dt-binding header file.
> > >
> > > Changes v1 --> v2:
> > > - Update the license of the dt-binding header file to make the licens=
e
> > >   compatible with dts files.
> > > - Fix the dt_binding_check errors.
> > >
> > > Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |
> 6
> > +++
> > > Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml |
> 95
> > ++++++++++++++++++++++++++++++++
> > > arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> |
> > 55 +++++++++++++++++++
> > > arch/arm64/boot/dts/freescale/imx8mm.dtsi
> |
> > 46 +++++++++++++++-
> > > drivers/pci/controller/dwc/pci-imx6.c                        |
> > 73 ++++++++++++++++++++++---
> > > drivers/phy/freescale/Kconfig
> |
> > 9 ++++
> > > drivers/phy/freescale/Makefile
> |
> > 1 +
> > > drivers/phy/freescale/phy-fsl-imx8m-pcie.c                   |
> > 237
> >
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > +++++++++++++++++++++
> > > include/dt-bindings/phy/phy-imx8-pcie.h                      |
> > 14 +++++
> > > 9 files changed, 528 insertions(+), 8 deletions(-)
> > >
> > > [PATCH v5 1/8] dt-bindings: phy: phy-imx8-pcie: Add binding for the
> > > [PATCH v5 2/8] dt-bindings: phy: Add imx8 pcie phy driver support
> > > [PATCH v5 3/8] dt-bindings: imx6q-pcie: Add PHY phandles and name
> > > [PATCH v5 4/8] arm64: dts: imx8mm: Add the pcie phy support
> [PATCH
> > v5
> > > 5/8] phy: freescale: pcie: Initialize the imx8 pcie [PATCH v5 6/8]
> > > arm64: dts: imx8mm: Add the pcie support [PATCH v5 7/8] arm64:
> dts:
> > > imx8mm-evk: Add the pcie support on imx8mm [PATCH v5 8/8] PCI:
> > imx:
> > > Add the imx8mm pcie support
> >
> > Richard,
> >
> > Are you posting a v6 of this series or have we already missed the
> > window for 5.16?
> [Richard Zhu] Hi Tim:
> Thanks for your kindly reminder.
> In my original plan, I prefer to merge the codes refine firstly, then iss=
ue
> the v6 patch-set after the rebase.
> https://patchwork.kernel.org/project/linux-arm-kernel/cover/163574747
> 8-25562-1-git-send-email-hongxing.zhu@nxp.com/
> Unfortunately, I don't get ack from Lucas for other four patches.
> Anyway, I would post the v6 patch-set immediately after merge Rob's
> comments.
>=20
> Best Regards
> Richard Zhu
> >
> > Best regards,
> >
[Richard Zhu] Hi Tim:
The V6 patch-set listed below had been issued.
" https://patchwork.kernel.org/project/linux-phy/cover/1637028976-9201-1-gi=
t-send-email-hongxing.zhu@nxp.com/"
GENERIC PHY FRAMEWORK maintainer Kishon and Vinod had been contained in the
 mail-loop.
Do you know who I can ping to pick up the PHY part of this patch-set?

Best Regards
Richard Zhu
> > Tim
