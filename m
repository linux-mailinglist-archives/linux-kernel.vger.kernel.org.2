Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A05324F59
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 12:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbhBYLmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 06:42:52 -0500
Received: from mail-bn8nam11on2070.outbound.protection.outlook.com ([40.107.236.70]:20065
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233961AbhBYLmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 06:42:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNCVrC+RyMf7IAEzxk8+3wPMTXnJRq2OZfsln8mngVSBYRH2FnWSVrtMN6r6v7AG7CjoMQrFebpHnBPuiASfUvalYm2aokvqTX311A+nuAJpqH6tJOSSsMMRp97ivD/Y3aJcsmH3CywdRgOJo8VMnKND8tZI+YF03TL8Lp6//tFY4zFRHnjxcpU6cpo7qVRKnqw0ZxQkmAl28LPVEK6FSi5Fa864ux9V28zOjh0zsJBI4mMwME+ygy7fTjIHFA5jD2NnB5h4XAy5lm1rSWKekcl0akKlKL/lJH9HRlsdklLCCTStH/DrlJTqDEQb80/wfcTvB76JU38Rlb1M4QkLWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGvhhmYn52e732jEJoMHhEVXD6+Lpa4aM7SoM4JXsD0=;
 b=VMYJXER25hggpedttipwps97QxU5zqxTjcqVSvbRVP4LgIEUaIRtDwkTr/zjPLebALXPgXuk/PksaOHzK8Yb//MH8jlwpkCR1LDoNkohO8wh0M0P6KuSFD77ZJ3pTQ51dWJqqQQAkPgFhggHlBl+ASjYJvKrHdEcfSkb1jnNjq7eKba/5e3jj4/t6+MY/lcKbDBbsPo5Q24eFiUEpcwfOkUvgehxvy5U6e4xMdMT0ZsI7LpiQkEjoKRJXtOrT/UbTnuURGdBcaI+TkX0oF5GfvHowtbINfNSDJGVnCSv281w3ptimBbjMZ08yiW0u2FkqmpnNPMfZN9go3V72WMYfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGvhhmYn52e732jEJoMHhEVXD6+Lpa4aM7SoM4JXsD0=;
 b=rt6Ko7sFhsfE/rwakX1t7XKQu+YhmhFS5vYK1IkPmRwOH8Jn9VZELX4lMoUhRlbOAFpJmMyz5qT+Ax/EpwfWFjiAi/W799AIgNwGTXr2kFAC8I7+YbuWC3/pZGJtDRGOzqpDknIynU1aYsJC3Y3dFGB1IyjtEWN8YE0II5+ts5Q=
Received: from BYAPR02MB5896.namprd02.prod.outlook.com (2603:10b6:a03:122::10)
 by BYAPR02MB5655.namprd02.prod.outlook.com (2603:10b6:a03:a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33; Thu, 25 Feb
 2021 11:41:42 +0000
Received: from BYAPR02MB5896.namprd02.prod.outlook.com
 ([fe80::c4f1:e969:f8d2:20b4]) by BYAPR02MB5896.namprd02.prod.outlook.com
 ([fe80::c4f1:e969:f8d2:20b4%3]) with mapi id 15.20.3846.049; Thu, 25 Feb 2021
 11:41:42 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Michael Grzeschik <mgr@pengutronix.de>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [RESEND PATCH v3 2/2] usb: dwc3: Add driver for Xilinx platforms
Thread-Topic: [RESEND PATCH v3 2/2] usb: dwc3: Add driver for Xilinx platforms
Thread-Index: AQHW0q9EwtT3SEPXrk68pgN7S+dn2KpkuhmAgAR2jtA=
Date:   Thu, 25 Feb 2021 11:41:42 +0000
Message-ID: <BYAPR02MB5896566D19BADC73FEA9A65DC19E9@BYAPR02MB5896.namprd02.prod.outlook.com>
References: <1608015291-52007-1-git-send-email-manish.narani@xilinx.com>
 <1608015291-52007-3-git-send-email-manish.narani@xilinx.com>
 <20210222153105.GD4544@pengutronix.de>
In-Reply-To: <20210222153105.GD4544@pengutronix.de>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=xilinx.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [183.83.140.151]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fcfb7ed1-907a-4aea-219c-08d8d9825275
x-ms-traffictypediagnostic: BYAPR02MB5655:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB5655D7A18B0CE67619CB8B6AC19E9@BYAPR02MB5655.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9lCYYIMjbsJlSM5VWUWp+O/DwnLrXrjcESc49HPzRRRIUbtV/DGrUPvLk36Bh6hUNqxTok57QQ4cf0CXrt/No9+DD3eoIE5DTetNqXv8SpsxJ80MI5/3LUDBlaIJmq/8CE36IxYgh5eErpDm7HL3vv3UzcmjFT8y4plW8b2KhuaYzm52i7I2bYtqmN9MDbUhEZatq0rR2TSIa9JDBzULqX2KRzUxlTXRLe++bajDnt2BY+wSp3bmM/prCZxCybr5BHHcQAUaS+SxaTANpVlpsXctbG8qUPE5uj8dIMYPQ/zp35fGlX/dVZMvz1cKtFoX2qg7GM49JR5a+qgCR58/+zJTkwEyAgwTp8cUabIWU2isgQpSwO4i5k/DXb0z3AfV3c3OIXPhE42+DXrYWfy5Ea1bEtg1znH2iMIE2pxL8bi2QfKpvx5BnuBZnuJN4UqkdjMP5TDoOpRjo78Fy9MAUHJvD5r4nXi+BHUOFX4ocFNknbRcYPEICtSdNwxwc4lYzzK0ya9JrRoJ2j8geqt/CC+cVCvhpABFs2+Gvy5ZIM7t//gQNd0mPimlx1ZgmDkP+fE3HkRreLzEarV8MjNk4cUmMN0IPBHFitD1V4/jmdm1pdHcDv+Mbf+ohMdQ3TUFm5Ke3UGAGwwj2w5ioBcMIHyF3sAxg0C0OcdIatL32wM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5896.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(2906002)(66476007)(66946007)(66556008)(33656002)(76116006)(71200400001)(64756008)(66446008)(26005)(9686003)(83080400002)(186003)(8936002)(4326008)(55016002)(54906003)(7696005)(8676002)(966005)(7416002)(5660300002)(316002)(30864003)(83380400001)(6916009)(53546011)(44832011)(478600001)(52536014)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?3u3h1VyeejtmxpzvWOIuahKOfgg/1u0dshlfT8yOUhU8uQ8HzZtFbhSElGq9?=
 =?us-ascii?Q?0+sXpkE0YGwCKl/tO4TaOJ2mJYwmS1Rd6Oxs1HM2UGxqKJr+H/RfNj1MW90/?=
 =?us-ascii?Q?8Ict7i815r8eInTeeGdhoOwFBJVQAUjWCW+r7f6dZ4Pp3wvWQF419jUDu28N?=
 =?us-ascii?Q?UYuNG9SK0dDZsxfrcYJTcBq4z6s5Tto9yrTlVGcbJ+ZKxXj3EF2/c+XFmP5x?=
 =?us-ascii?Q?1w/HeIWSwZd9lmEExDohv56miZMFRBOxYjBPvukkgaIPd6KTjxGcZwjFZITs?=
 =?us-ascii?Q?bEaaWMtdohl4CFwYPqaN9s15/nyw7qMrodhZt5ttq8xJR3/RgqKSJQOKIU+U?=
 =?us-ascii?Q?vRJLZ8aMQ/cDg+YxmN7BPoOqqu9v6ICnoKuzzRat+dq7SD0r0JqP9J2g4U+6?=
 =?us-ascii?Q?F2fwNuFqB16Ws4bLkXNjYrFbtWEbyzRomul/hcbKBsGnnzaN1QjIyhJn1GO1?=
 =?us-ascii?Q?Lza1Utt+SUWvYs3aSvRicEvnMSEnfg2XPPRNXWBA4aZ4OYZ8s2T0gPAIE3F7?=
 =?us-ascii?Q?PslLaguzP1KlPKui1ETz1CUAVCp99G9O/cUpvVeUmgyz822hTZV59URkDPoF?=
 =?us-ascii?Q?E4A3GycHIssweuBZHaYwEVHouEw01uhPgELt42+YrZ7vYadZ97/QHY2XV2eK?=
 =?us-ascii?Q?oGugpF89eJo7iQfhtj7/nc43CS0Ym/aqr2YmgPQVDwURASjFTe2a8WvVrgN1?=
 =?us-ascii?Q?CXo9NgAXOxwUQsZPIuqnkKW5DDAgMqTddK3u5jrl/n/lZmUFjo+gRbPnqoZV?=
 =?us-ascii?Q?7EbujKVEGu8F0rV8hHK80Y319Fp5Na8j8JYF5eIcOpep//D60h1Nb39dBT+E?=
 =?us-ascii?Q?/PfqrhXrcmuyeq9jDMO5EjhcsUPTrvBwFUPB+PfW14AXnSXByeWH1rv13KRJ?=
 =?us-ascii?Q?onM/9X4/qbkEl4C8pi8TyRID5ktrt/XqEJxvjmEy83P3036ilV+9lQg5P/NM?=
 =?us-ascii?Q?5aHW05AoEtCSsXZ9z87cD4Fg/DKkxSq66ZsX3mfrTaMaUTFTbo4qBqzCoYvH?=
 =?us-ascii?Q?L0QlpfNSt5DEfiXKTGrnDiMEU/5Gm6azdz+67q8znQ4ld7tf+ORHv7zlt4B5?=
 =?us-ascii?Q?GGF0gP+WlRWqJ8CU9yRXyJcaC8QhU9e2YKu3GqFFeaK2MXCHdQELyEIUWm6T?=
 =?us-ascii?Q?65EpHJL8d5faROkRoYh55FYkf2mKMPIdI9NGNmUoDc8jRZEA8mCBWqbUgpzk?=
 =?us-ascii?Q?XYd7+FlNzkROLdVxHmQT3loz7UD50iluMTLXctVocvtp1xZckNP/6gJa2swo?=
 =?us-ascii?Q?OHz4iRayr48hq2qvKrkfBaoJrPUCjOiV42ysM2DlcKMZfymj8H9p/Qpb0gmC?=
 =?us-ascii?Q?AwsqNwgeXU3yzXxOvOvnrkvE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5896.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcfb7ed1-907a-4aea-219c-08d8d9825275
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2021 11:41:42.3650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mk7WvsudkjXdg9/Dml8TzelO3JHmnWG8bp19OiVAp0IuY/xtw5vkU6VhWctRs88qzv6B35TsUMUGO+1ZKu7JaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5655
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Michael,

> -----Original Message-----
> From: Michael Grzeschik <mgr@pengutronix.de>
> Sent: Monday, February 22, 2021 9:01 PM
> To: Manish Narani <MNARANI@xilinx.com>
> Cc: gregkh@linuxfoundation.org; robh+dt@kernel.org; Michal Simek
> <michals@xilinx.com>; balbi@kernel.org; p.zabel@pengutronix.de;
> devicetree@vger.kernel.org; linux-usb@vger.kernel.org; linux-
> kernel@vger.kernel.org; git <git@xilinx.com>; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [RESEND PATCH v3 2/2] usb: dwc3: Add driver for Xilinx
> platforms
>=20
> Hi Manish!
>=20
> On Tue, Dec 15, 2020 at 12:24:51PM +0530, Manish Narani wrote:
> >Add a new driver for supporting Xilinx platforms. This driver is used
> >for some sequence of operations required for Xilinx USB controllers.
> >This driver is also used to choose between PIPE clock coming from SerDes
> >and the Suspend Clock. Before the controller is out of reset, the clock
> >selection should be changed to PIPE clock in order to make the USB
> >controller work. There is a register added in Xilinx USB controller
> >register space for the same.
> >
> >Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> >---
> > drivers/usb/dwc3/Kconfig          |   9 +
> > drivers/usb/dwc3/Makefile         |   1 +
> > drivers/usb/dwc3/dwc3-of-simple.c |   1 -
> > drivers/usb/dwc3/dwc3-xilinx.c    | 334
> ++++++++++++++++++++++++++++++
> > 4 files changed, 344 insertions(+), 1 deletion(-)
> > create mode 100644 drivers/usb/dwc3/dwc3-xilinx.c
> >
> >diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
> >index 7a2304565a73..0e00e6dfccd8 100644
> >--- a/drivers/usb/dwc3/Kconfig
> >+++ b/drivers/usb/dwc3/Kconfig
> >@@ -139,4 +139,13 @@ config USB_DWC3_QCOM
> > 	  for peripheral mode support.
> > 	  Say 'Y' or 'M' if you have one such device.
> >
> >+config USB_DWC3_XILINX
> >+	tristate "Xilinx Platforms"
> >+	depends on (ARCH_ZYNQMP || ARCH_VERSAL) && OF
> >+	default USB_DWC3
> >+	help
> >+	  Support Xilinx SoCs with DesignWare Core USB3 IP.
> >+	  This driver handles both ZynqMP and Versal SoC operations.
> >+	  Say 'Y' or 'M' if you have one such device.
> >+
> > endif
> >diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
> >index ae86da0dc5bd..add567578b1f 100644
> >--- a/drivers/usb/dwc3/Makefile
> >+++ b/drivers/usb/dwc3/Makefile
> >@@ -51,3 +51,4 @@ obj-$(CONFIG_USB_DWC3_MESON_G12A)	+=3D
> dwc3-meson-g12a.o
> > obj-$(CONFIG_USB_DWC3_OF_SIMPLE)	+=3D dwc3-of-simple.o
> > obj-$(CONFIG_USB_DWC3_ST)		+=3D dwc3-st.o
> > obj-$(CONFIG_USB_DWC3_QCOM)		+=3D dwc3-qcom.o
> >+obj-$(CONFIG_USB_DWC3_XILINX)		+=3D dwc3-xilinx.o
> >diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-
> of-simple.c
> >index e62ecd22b3ed..71fd620c5161 100644
> >--- a/drivers/usb/dwc3/dwc3-of-simple.c
> >+++ b/drivers/usb/dwc3/dwc3-of-simple.c
> >@@ -172,7 +172,6 @@ static const struct dev_pm_ops
> dwc3_of_simple_dev_pm_ops =3D {
> >
> > static const struct of_device_id of_dwc3_simple_match[] =3D {
> > 	{ .compatible =3D "rockchip,rk3399-dwc3" },
> >-	{ .compatible =3D "xlnx,zynqmp-dwc3" },
> > 	{ .compatible =3D "cavium,octeon-7130-usb-uctl" },
> > 	{ .compatible =3D "sprd,sc9860-dwc3" },
> > 	{ .compatible =3D "allwinner,sun50i-h6-dwc3" },
> >diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-
> xilinx.c
> >new file mode 100644
> >index 000000000000..7e485951d2f7
> >--- /dev/null
> >+++ b/drivers/usb/dwc3/dwc3-xilinx.c
> >@@ -0,0 +1,334 @@
> >+// SPDX-License-Identifier: GPL-2.0
> >+/**
> >+ * dwc3-xilinx.c - Xilinx DWC3 controller specific glue driver
> >+ *
> >+ * Authors: Manish Narani <manish.narani@xilinx.com>
> >+ *          Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> >+ */
> >+
> >+#include <linux/module.h>
> >+#include <linux/kernel.h>
> >+#include <linux/slab.h>
> >+#include <linux/clk.h>
> >+#include <linux/of.h>
> >+#include <linux/platform_device.h>
> >+#include <linux/dma-mapping.h>
> >+#include <linux/of_platform.h>
> >+#include <linux/pm_runtime.h>
> >+#include <linux/reset.h>
> >+#include <linux/of_address.h>
> >+#include <linux/delay.h>
> >+#include <linux/firmware/xlnx-zynqmp.h>
> >+#include <linux/io.h>
> >+
> >+#include <linux/phy/phy.h>
> >+
> >+/* USB phy reset mask register */
> >+#define XLNX_USB_PHY_RST_EN			0x001C
> >+#define XLNX_PHY_RST_MASK			0x1
> >+
> >+/* Xilinx USB 3.0 IP Register */
> >+#define XLNX_USB_TRAFFIC_ROUTE_CONFIG		0x005C
> >+#define XLNX_USB_TRAFFIC_ROUTE_FPD		0x1
> >+
> >+/* Versal USB Reset ID */
> >+#define VERSAL_USB_RESET_ID			0xC104036
> >+
> >+#define XLNX_USB_FPD_PIPE_CLK			0x7c
> >+#define PIPE_CLK_DESELECT			1
> >+#define PIPE_CLK_SELECT				0
> >+#define XLNX_USB_FPD_POWER_PRSNT		0x80
> >+#define PIPE_POWER_ON				1
> >+#define PIPE_POWER_OFF				0
> >+
> >+struct dwc3_xlnx {
> >+	int				num_clocks;
> >+	struct clk_bulk_data		*clks;
> >+	struct device			*dev;
> >+	void __iomem			*regs;
> >+	int				(*pltfm_init)(struct dwc3_xlnx *data);
> >+};
> >+
> >+static void dwc3_xlnx_mask_phy_rst(struct dwc3_xlnx *priv_data, bool
> mask)
> >+{
> >+	u32 reg;
> >+
> >+	/*
> >+	 * Enable or disable ULPI PHY reset from USB Controller.
> >+	 * This does not actually reset the phy, but just controls
> >+	 * whether USB controller can or cannot reset ULPI PHY.
> >+	 */
> >+	reg =3D readl(priv_data->regs + XLNX_USB_PHY_RST_EN);
> >+
> >+	if (mask)
> >+		reg &=3D ~XLNX_PHY_RST_MASK;
> >+	else
> >+		reg |=3D XLNX_PHY_RST_MASK;
> >+
> >+	writel(reg, priv_data->regs + XLNX_USB_PHY_RST_EN);
> >+}
> >+
> >+static int dwc3_xlnx_init_versal(struct dwc3_xlnx *priv_data)
> >+{
> >+	struct device		*dev =3D priv_data->dev;
> >+	int			ret;
> >+
> >+	dwc3_xlnx_mask_phy_rst(priv_data, false);
> >+
> >+	/* Assert and De-assert reset */
> >+	ret =3D zynqmp_pm_reset_assert(VERSAL_USB_RESET_ID,
> >+				     PM_RESET_ACTION_ASSERT);
> >+	if (ret < 0) {
> >+		dev_err_probe(dev, ret, "failed to assert Reset\n");
> >+		return ret;
> >+	}
> >+
> >+	ret =3D zynqmp_pm_reset_assert(VERSAL_USB_RESET_ID,
> >+				     PM_RESET_ACTION_RELEASE);
> >+	if (ret < 0) {
> >+		dev_err_probe(dev, ret, "failed to De-assert Reset\n");
> >+		return ret;
> >+	}
> >+
> >+	dwc3_xlnx_mask_phy_rst(priv_data, true);
> >+
> >+	return 0;
> >+}
> >+
> >+static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
> >+{
> >+	struct device		*dev =3D priv_data->dev;
> >+	struct reset_control	*crst, *hibrst, *apbrst;
> >+	struct phy		*usb3_phy;
> >+	int			ret;
> >+	u32			reg;
> >+
> >+	crst =3D devm_reset_control_get_exclusive(dev, "usb_crst");
> >+	if (IS_ERR(crst)) {
> >+		ret =3D PTR_ERR(crst);
> >+		dev_err_probe(dev, ret,
> >+			      "failed to get core reset signal\n");
> >+		goto err;
> >+	}
> >+
> >+	hibrst =3D devm_reset_control_get_exclusive(dev, "usb_hibrst");
> >+	if (IS_ERR(hibrst)) {
> >+		ret =3D PTR_ERR(hibrst);
> >+		dev_err_probe(dev, ret,
> >+			      "failed to get hibernation reset signal\n");
> >+		goto err;
> >+	}
> >+
> >+	apbrst =3D devm_reset_control_get_exclusive(dev, "usb_apbrst");
> >+	if (IS_ERR(apbrst)) {
> >+		ret =3D PTR_ERR(apbrst);
> >+		dev_err_probe(dev, ret,
> >+			      "failed to get APB reset signal\n");
> >+		goto err;
> >+	}
> >+
> >+	ret =3D reset_control_assert(crst);
> >+	if (ret < 0) {
> >+		dev_err(dev, "Failed to assert core reset\n");
> >+		goto err;
> >+	}
> >+
> >+	ret =3D reset_control_assert(hibrst);
> >+	if (ret < 0) {
> >+		dev_err(dev, "Failed to assert hibernation reset\n");
> >+		goto err;
> >+	}
> >+
> >+	ret =3D reset_control_assert(apbrst);
> >+	if (ret < 0) {
> >+		dev_err(dev, "Failed to assert APB reset\n");
> >+		goto err;
> >+	}
> >+
> >+	usb3_phy =3D devm_phy_get(dev, "usb3-phy");
>=20
> You should move this phy get to probe code and skip the call of
> pltfm_init if no phy was found.
>=20
> As I understand this glue now, you will set an defined fixed-clock
> frequency from dts in the ps-gtr phy. If no phy and therefor also no
> clock is defined, the call of dwc3_xlnx_init_zynqmp can be skipped, as
> you will not need to switch the clocks to an external lane source.
>=20
> For example for the host case with node option dr_mode =3D "host" set and
> no external physical external clksrc connected, this glue still needs to
> be used. The current version would break this case.

OK Michael. I will take care of the same in the next version of the driver.

Thanks,
Manish

>=20
> Thanks,
> Michael
>=20
> >+	ret =3D phy_init(usb3_phy);
> >+	if (ret < 0) {
> >+		phy_exit(usb3_phy);
> >+		goto err;
> >+	}
> >+
> >+	ret =3D reset_control_deassert(apbrst);
> >+	if (ret < 0) {
> >+		dev_err(dev, "Failed to release APB reset\n");
> >+		goto err;
> >+	}
> >+
> >+	/* Set PIPE Power Present signal in FPD Power Present Register*/
> >+	writel(PIPE_POWER_ON, priv_data->regs +
> XLNX_USB_FPD_POWER_PRSNT);
> >+
> >+	/* Set the PIPE Clock Select bit in FPD PIPE Clock register */
> >+	writel(PIPE_CLK_SELECT, priv_data->regs +
> XLNX_USB_FPD_PIPE_CLK);
> >+
> >+	ret =3D reset_control_deassert(crst);
> >+	if (ret < 0) {
> >+		dev_err(dev, "Failed to release core reset\n");
> >+		goto err;
> >+	}
> >+
> >+	ret =3D reset_control_deassert(hibrst);
> >+	if (ret < 0) {
> >+		dev_err(dev, "Failed to release hibernation reset\n");
> >+		goto err;
> >+	}
> >+
> >+	ret =3D phy_power_on(usb3_phy);
> >+	if (ret < 0) {
> >+		phy_exit(usb3_phy);
> >+		goto err;
> >+	}
> >+
> >+	/*
> >+	 * This routes the USB DMA traffic to go through FPD path instead
> >+	 * of reaching DDR directly. This traffic routing is needed to
> >+	 * make SMMU and CCI work with USB DMA.
> >+	 */
> >+	if (of_dma_is_coherent(dev->of_node) ||
> device_iommu_mapped(dev)) {
> >+		reg =3D readl(priv_data->regs +
> XLNX_USB_TRAFFIC_ROUTE_CONFIG);
> >+		reg |=3D XLNX_USB_TRAFFIC_ROUTE_FPD;
> >+		writel(reg, priv_data->regs +
> XLNX_USB_TRAFFIC_ROUTE_CONFIG);
> >+	}
> >+
> >+err:
> >+	return ret;
> >+}
> >+
> >+static const struct of_device_id dwc3_xlnx_of_match[] =3D {
> >+	{
> >+		.compatible =3D "xlnx,zynqmp-dwc3",
> >+		.data =3D &dwc3_xlnx_init_zynqmp,
> >+	},
> >+	{
> >+		.compatible =3D "xlnx,versal-dwc3",
> >+		.data =3D &dwc3_xlnx_init_versal,
> >+	},
> >+	{ /* Sentinel */ }
> >+};
> >+MODULE_DEVICE_TABLE(of, dwc3_xlnx_of_match);
> >+
> >+static int dwc3_xlnx_probe(struct platform_device *pdev)
> >+{
> >+	struct dwc3_xlnx		*priv_data;
> >+	struct device			*dev =3D &pdev->dev;
> >+	struct device_node		*np =3D dev->of_node;
> >+	const struct of_device_id	*match;
> >+	void __iomem			*regs;
> >+	int				ret;
> >+
> >+	priv_data =3D devm_kzalloc(dev, sizeof(*priv_data), GFP_KERNEL);
> >+	if (!priv_data)
> >+		return -ENOMEM;
> >+
> >+	regs =3D devm_platform_ioremap_resource(pdev, 0);
> >+	if (IS_ERR(regs)) {
> >+		ret =3D PTR_ERR(regs);
> >+		dev_err_probe(dev, ret, "failed to map registers\n");
> >+		return ret;
> >+	}
> >+
> >+	match =3D of_match_node(dwc3_xlnx_of_match, pdev->dev.of_node);
> >+
> >+	priv_data->pltfm_init =3D match->data;
> >+	priv_data->regs =3D regs;
> >+	priv_data->dev =3D dev;
> >+
> >+	platform_set_drvdata(pdev, priv_data);
> >+
> >+	ret =3D devm_clk_bulk_get_all(priv_data->dev, &priv_data->clks);
> >+	if (ret < 0)
> >+		return ret;
> >+
> >+	priv_data->num_clocks =3D ret;
> >+
> >+	ret =3D clk_bulk_prepare_enable(priv_data->num_clocks, priv_data-
> >clks);
> >+	if (ret)
> >+		return ret;
> >+
> >+	ret =3D priv_data->pltfm_init(priv_data);
> >+	if (ret)
> >+		goto err_clk_put;
> >+
> >+	ret =3D of_platform_populate(np, NULL, NULL, dev);
> >+	if (ret)
> >+		goto err_clk_put;
> >+
> >+	pm_runtime_set_active(dev);
> >+	pm_runtime_enable(dev);
> >+	pm_suspend_ignore_children(dev, false);
> >+	pm_runtime_get_sync(dev);
> >+
> >+	return 0;
> >+
> >+err_clk_put:
> >+	clk_bulk_disable_unprepare(priv_data->num_clocks, priv_data-
> >clks);
> >+	clk_bulk_put_all(priv_data->num_clocks, priv_data->clks);
> >+
> >+	return ret;
> >+}
> >+
> >+static int dwc3_xlnx_remove(struct platform_device *pdev)
> >+{
> >+	struct dwc3_xlnx	*priv_data =3D platform_get_drvdata(pdev);
> >+	struct device		*dev =3D &pdev->dev;
> >+
> >+	of_platform_depopulate(dev);
> >+
> >+	clk_bulk_disable_unprepare(priv_data->num_clocks, priv_data-
> >clks);
> >+	clk_bulk_put_all(priv_data->num_clocks, priv_data->clks);
> >+	priv_data->num_clocks =3D 0;
> >+
> >+	pm_runtime_disable(dev);
> >+	pm_runtime_put_noidle(dev);
> >+	pm_runtime_set_suspended(dev);
> >+
> >+	return 0;
> >+}
> >+
> >+static int __maybe_unused dwc3_xlnx_suspend_common(struct device
> *dev)
> >+{
> >+	struct dwc3_xlnx *priv_data =3D dev_get_drvdata(dev);
> >+
> >+	clk_bulk_disable(priv_data->num_clocks, priv_data->clks);
> >+
> >+	return 0;
> >+}
> >+
> >+static int __maybe_unused dwc3_xlnx_resume_common(struct device
> *dev)
> >+{
> >+	struct dwc3_xlnx *priv_data =3D dev_get_drvdata(dev);
> >+
> >+	return clk_bulk_enable(priv_data->num_clocks, priv_data->clks);
> >+}
> >+
> >+static int __maybe_unused dwc3_xlnx_runtime_idle(struct device *dev)
> >+{
> >+	pm_runtime_mark_last_busy(dev);
> >+	pm_runtime_autosuspend(dev);
> >+
> >+	return 0;
> >+}
> >+
> >+static UNIVERSAL_DEV_PM_OPS(dwc3_xlnx_dev_pm_ops,
> dwc3_xlnx_suspend_common,
> >+			    dwc3_xlnx_resume_common,
> dwc3_xlnx_runtime_idle);
> >+
> >+static struct platform_driver dwc3_xlnx_driver =3D {
> >+	.probe		=3D dwc3_xlnx_probe,
> >+	.remove		=3D dwc3_xlnx_remove,
> >+	.driver		=3D {
> >+		.name		=3D "dwc3-xilinx",
> >+		.of_match_table	=3D dwc3_xlnx_of_match,
> >+		.pm		=3D &dwc3_xlnx_dev_pm_ops,
> >+	},
> >+};
> >+
> >+module_platform_driver(dwc3_xlnx_driver);
> >+
> >+MODULE_LICENSE("GPL v2");
> >+MODULE_DESCRIPTION("Xilinx DWC3 controller specific glue driver");
> >+MODULE_AUTHOR("Manish Narani <manish.narani@xilinx.com>");
> >+MODULE_AUTHOR("Anurag Kumar Vulisha
> <anurag.kumar.vulisha@xilinx.com>");
> >--
> >2.17.1
> >
> >
> >_______________________________________________
> >linux-arm-kernel mailing list
> >linux-arm-kernel@lists.infradead.org
> >http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
>=20
> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  =
|
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|
