Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9263B365A45
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 15:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbhDTNh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 09:37:29 -0400
Received: from mail-dm6nam12on2040.outbound.protection.outlook.com ([40.107.243.40]:2223
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230408AbhDTNh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 09:37:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PvTs1s79yD4DX68Nyg4LzM0/hnoMUZ0S4tDzMnHo98CJLynvrfwbK2hFI/eYGQYKKIgFfAlXn97KU40xgr0nyPdPsyMLyijMhahxWQDTtIsRcGRmXBcZtarASm+204LxvLPh62LRnqvePznyGauX984COyjB3Q8EAN00YSJqDroUANZ2ZpHEiUr2FxcU3qZGuXQ/MgJt72p7fCR0BiImn3gfCerZKjN8tw44P4Gw1xYbQej+LoOdw/vrz6K8Xog/kKytnvvZgSiSYSCAfkLYa5bXRWMXTet+glg9gcly/LbDg+3/XdXRZEnhMHTfTdaEs13CT+Jn4Ym2ik+O0+ftBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dHvZhdZ04r4LrwKBFLH8CjCUxy7IKUNLCOTTRfyi1Y=;
 b=kU8+XhTDu9KeCMgzlrKaWNeW/4v5nbFzjZayHVOoO8ZrbY+2IAGNyVsubetB/zAnTCaieLb22zOr7wJyibhkIfGfhcBDdbKVicTTrnr20MHAB0cPJ7MAs4wqEUh1lD41pSx2G2im1iWR+H9dAgFCQvOC9/mqNwutvRNWjQ0VcRJgfd+CeoZG0FLL20liEXDF7B9P1CeT9NwcyUK++TmOnur/8iKIjecO2TzVHHDR50f/kGesSPomQf/QYPvnYK2FETUKeCWXBIMy30Mxx9+p6zLckCE+uwy5WeMdO1I3RxAzO1rq+RsOPu2eKLBgYEzZmB9Edh0ULaKIaNG8O6v4lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dHvZhdZ04r4LrwKBFLH8CjCUxy7IKUNLCOTTRfyi1Y=;
 b=KRhLXiY9ntBOuY+QqzEXLAI8hFDCpdfrv7r8lgqpqmYtVPTSzW9TgTeXZ6Uk5dd6dQsw724hrPu1Vp8SZgWW2R7l/PSCxgYz/Tn858xA1j+Gr125aLuF+VNDEHjpcrpRs8tqhyAbEJnNZKUvcJDClZbgrdk/lBtyXH/ZxQ5FyDs=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (2603:10b6:300:44::9)
 by MWHPR02MB2846.namprd02.prod.outlook.com (2603:10b6:300:10d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Tue, 20 Apr
 2021 13:36:51 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::297d:1fb:ad07:1b26]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::297d:1fb:ad07:1b26%9]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 13:36:51 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        Derek Kiernan <dkiernan@xilinx.com>,
        Dragan Cvetic <draganc@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>, Rajan Vaja <RAJANV@xilinx.com>,
        Jolly Shah <JOLLYS@xilinx.com>,
        Tejas Patel <tejasp@xlnx.xilinx.com>,
        Amit Sunil Dhamne <amitsuni@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>,
        git <git@xilinx.com>
Subject: RE: [PATCH 2/5] misc: zynq: Add afi config driver
Thread-Topic: [PATCH 2/5] misc: zynq: Add afi config driver
Thread-Index: AQHXNb4PdbEXyUDOFECbgYvFos0TEqq9F+4AgABOgRA=
Date:   Tue, 20 Apr 2021 13:36:51 +0000
Message-ID: <MWHPR02MB2623DED0785A05A9C55C20FBC2489@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <20210420081153.17020-1-nava.manne@xilinx.com>
 <20210420081153.17020-3-nava.manne@xilinx.com> <YH6U/L4SEtJajusW@kroah.com>
In-Reply-To: <YH6U/L4SEtJajusW@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=xilinx.com;
x-originating-ip: [149.199.50.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 287ceb0f-5d0e-466b-041c-08d904015af1
x-ms-traffictypediagnostic: MWHPR02MB2846:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB28467F147AA4B2130EF1F05FC2489@MWHPR02MB2846.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DWhP2tJni7t1V4chaMmLjJ8WlrAyG6vsFkNAKxSZO3Zn+cea/rOXL/Hq+rvYZKGkDdC6DjoPXB46zbIwqvmoJbMIVKOirH7uTuTPrEG9HIdd5mCrZd9hECbbPojw2lHj5FpXokLCqRWF94cM8wpwyZyaOwZYG5NuBxiarS7RJXUaLe7dz0X0am1L7fjKimGGij/rZ6AteEjBAH7+HIvQNlAjnyv/0oG727LH3vkP19qiTFvjUlSBUivfLqxqCTTSVBxMgklQujMW0J2XYwHkQFAm/OZcfmo14cXSxt8813NfyiiGEBIvmLmhdtRztGojz2KYs9hT1QfFqKQI5gSyJB5wZVl47yLE4asF3v+VmxclPQtfV16TxbYTu49A/95+hhRoVnBdsgjI0kFWI3lkEols25roonCgzUleC72m2zHwucZv4yfDAEKgDKHWQ19VgqfJktB9wGypwMeGkfXsLLbUAHnEAKczBQ32/MFtH94AeBdt8uzDO8dJS7a8++1XsNq/2cvm2RmuivotYxLBHQOZU3l0aNygt0KiZzoJSjkTUbngoIc5K06TSkobpfZqxTHV0P+wRRqUBTeqCBsN8TejQPaLB2mW10CJck7D9yQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR02MB2623.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(107886003)(6916009)(186003)(2906002)(86362001)(33656002)(55016002)(38100700002)(54906003)(83380400001)(9686003)(53546011)(122000001)(6506007)(26005)(71200400001)(7696005)(52536014)(316002)(8676002)(76116006)(5660300002)(66476007)(66446008)(8936002)(66946007)(66556008)(64756008)(4326008)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Fp5E0SiUbs08fFP0sz+FZI3Zhj6NycUUARd2KUWyFquDsCw4rVbQFgpeCaF6?=
 =?us-ascii?Q?uiexK9bPb96bqp1LUzwWfeyk9lP1tHo7rDjRbX96XjptHGXPjvCNZjGo/asZ?=
 =?us-ascii?Q?EJkxG8htl6HBhLxZyobzZ8Jqh+DvHLntlsmXNGhQm+4NZcX7w2Xr4otxbU4w?=
 =?us-ascii?Q?v2+REVhvK3VrnX5KOZE7/SzpDBwsAz/a4qBzoC7In/GP6GA2M3VD2MrZ1Mox?=
 =?us-ascii?Q?ZCkyUKb+Mc/qz3p+WZCiY31abEjn9bMAdzf6WYEalwm7S60w5O0d90fjdXUS?=
 =?us-ascii?Q?IJ6hCy9td7IYtteqUWzGDATh9WQ2s/VRi+owXukUtrigNkmeLkiPIT7hNEse?=
 =?us-ascii?Q?7sgtpacqrH9AgYPw3VdsvgyaGWZRwORfIgGjx6zZYgWFE+pqmDMgEWF7vwI2?=
 =?us-ascii?Q?BsEeErbgtG7V6LUA4hA93t2/Zo0UWoFdPLxLB5/1SdvsR1/tgoLVA6x17x7Z?=
 =?us-ascii?Q?+13LAyzscPI6YRIsGnC/BgGwaCDFdD/CLqe4xJQD3GmZInheanuXtP1104RO?=
 =?us-ascii?Q?xOuTtwKKxTo95WeYJbNXo6TWOwsL6Z5JYb1S4oWkDrwzWfjQ5UJh9dzwtbsB?=
 =?us-ascii?Q?jJ8oKDKJH5XuenuVyZw96VUalauofrZYDaRM2qjAZKsukNydDdjN9+buOlWp?=
 =?us-ascii?Q?+TlTa7/auTw6RhD2/EbYWcawomfYpRI37oBT6p6nljjzoxCJ8iel2m5H189t?=
 =?us-ascii?Q?CgPmlxbbCr8r7XiIELGYGS/pJORlwsn4i4NR5Lg0gD7hQxip2xC5evPacfU9?=
 =?us-ascii?Q?G1OnO7nVJTNmle2eYsY/u8E36JuIQqW1DRr1EoAsEAKIDYilwzfiXgLKTTq4?=
 =?us-ascii?Q?zOeQKNDo65EgQRhO+CxpiI77hY+xxGm7lqXyBt6L8VMOMBX9Ep1ZXqFu1Sf4?=
 =?us-ascii?Q?V6cVe6A1o6JMa1IQCXvrHj+E9HooKN/6dd/Vwca4Qw29XOiexapF3k2t7CLf?=
 =?us-ascii?Q?gXVVt3imIimWUnqc4i+hrqG7hkFnw7lxNyiuZhg4x9vwgsc7XE99auUwkBlr?=
 =?us-ascii?Q?hKb/gy5aV1Qw+ZMDPcGPfWCXwf3aeIcEJst9Qi81/E6Tmc8+rnCt4IMOHiLi?=
 =?us-ascii?Q?kPyQG5dHOf5IhqUNjmBT0Btq5jkLEqTwLEwgU9LJqnxhXJ8ANo3fADbrZFat?=
 =?us-ascii?Q?W6pjdooINm64+YYP6VPh/+NTzMl6pxu+/UTiZpaE3LOaNTZ32xahQk2BDQQQ?=
 =?us-ascii?Q?U1i2vqotTUWkedq+DIrx8gCT6YcS2T6IJYlMptnnF+oE6nxxGngCGKEB76E3?=
 =?us-ascii?Q?vaV7W+3bKnbpht5awz9ImMnLz3Ab0B16UdiKG7N8mSpC6f3dvdgBuCu6ze1C?=
 =?us-ascii?Q?c+3dwicemekw6LbcNUEK6A/T?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR02MB2623.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 287ceb0f-5d0e-466b-041c-08d904015af1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2021 13:36:51.5489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TmhskFEeQe93O/ZB2AfJdmIIkrMm42bmphe/3nF8+ebDFTVDZUB8K39iaMDU0vhIL3gTVH/dxV8yi8xCDZv8xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2846
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

	Please find my response inline.

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Tuesday, April 20, 2021 2:17 PM
> To: Nava kishore Manne <navam@xilinx.com>
> Cc: robh+dt@kernel.org; Michal Simek <michals@xilinx.com>; Derek Kiernan
> <dkiernan@xilinx.com>; Dragan Cvetic <draganc@xilinx.com>;
> arnd@arndb.de; Rajan Vaja <RAJANV@xilinx.com>; Jolly Shah
> <JOLLYS@xilinx.com>; Tejas Patel <tejasp@xlnx.xilinx.com>; Amit Sunil
> Dhamne <amitsuni@xilinx.com>; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> chinnikishore369@gmail.com; git <git@xilinx.com>
> Subject: Re: [PATCH 2/5] misc: zynq: Add afi config driver
>=20
> On Tue, Apr 20, 2021 at 01:41:50PM +0530, Nava kishore Manne wrote:
> > This patch adds zynq afi config driver. This is useful for the
> > configuration of the PS-PL interface on zynq platform.
>=20
> What is "PS-PL"?  Can you describe it better please?
>=20
PS-PL interface is nothing but the interface between processing system(PS) =
 that contains arm cores and Programmable Logic(PL) i.e FPGA.
Will update the description in v2.

> >
> > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > ---
> >  drivers/misc/Kconfig    | 11 ++++++
> >  drivers/misc/Makefile   |  1 +
> >  drivers/misc/zynq-afi.c | 81
> > +++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 93 insertions(+)
> >  create mode 100644 drivers/misc/zynq-afi.c
> >
> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig index
> > f532c59bb59b..877b43b3377d 100644
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -445,6 +445,17 @@ config HISI_HIKEY_USB
> >  	  switching between the dual-role USB-C port and the USB-A host
> ports
> >  	  using only one USB controller.
> >
> > +config ZYNQ_AFI
> > +	tristate "Xilinx ZYNQ AFI support"
> > +	help
> > +	  Zynq AFI driver support for writing to the AFI registers
> > +	  for configuring PS_PL Bus-width. Xilinx Zynq SoC connect
> > +	  the PS to the programmable logic (PL) through the AXI port.
> > +	  This AXI port helps to establish the data path between the
> > +	  PS and PL.In-order to establish the proper communication path
> > +	  between PS and PL, the AXI port data path should be configured
> > +	  with the proper Bus-width values
> > +
> >  source "drivers/misc/c2port/Kconfig"
> >  source "drivers/misc/eeprom/Kconfig"
> >  source "drivers/misc/cb710/Kconfig"
> > diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile index
> > 99b6f15a3c70..e9b03843100f 100644
> > --- a/drivers/misc/Makefile
> > +++ b/drivers/misc/Makefile
> > @@ -56,3 +56,4 @@ obj-$(CONFIG_HABANA_AI)		+=3D
> habanalabs/
> >  obj-$(CONFIG_UACCE)		+=3D uacce/
> >  obj-$(CONFIG_XILINX_SDFEC)	+=3D xilinx_sdfec.o
> >  obj-$(CONFIG_HISI_HIKEY_USB)	+=3D hisi_hikey_usb.o
> > +obj-$(CONFIG_ZYNQ_AFI)		+=3D zynq-afi.o
> > diff --git a/drivers/misc/zynq-afi.c b/drivers/misc/zynq-afi.c new
> > file mode 100644 index 000000000000..04317d1bdb98
> > --- /dev/null
> > +++ b/drivers/misc/zynq-afi.c
> > @@ -0,0 +1,81 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Xilinx ZYNQ AFI driver.
> > + * Copyright (c) 2018-2021 Xilinx Inc.
> > + */
> > +
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +
> > +/* Registers and special values for doing register-based operations */
> > +#define AFI_RDCHAN_CTRL_OFFSET	0x00
> > +#define AFI_WRCHAN_CTRL_OFFSET	0x14
> > +
> > +#define AFI_BUSWIDTH_MASK	0x01
> > +
> > +/**
> > + * struct afi_fpga - AFI register description
> > + * @membase:	pointer to register struct
> > + * @afi_width:	AFI bus width to be written
> > + */
> > +struct zynq_afi_fpga {
> > +	void __iomem	*membase;
> > +	u32		afi_width;
> > +};
> > +
> > +static int zynq_afi_fpga_probe(struct platform_device *pdev) {
> > +	struct zynq_afi_fpga *afi_fpga;
> > +	struct resource *res;
> > +	u32 reg_val;
> > +	u32 val;
> > +
> > +	afi_fpga =3D devm_kzalloc(&pdev->dev, sizeof(*afi_fpga),
> GFP_KERNEL);
> > +	if (!afi_fpga)
> > +		return -ENOMEM;
> > +
> > +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	afi_fpga->membase =3D devm_ioremap_resource(&pdev->dev, res);
> > +	if (IS_ERR(afi_fpga->membase))
> > +		return PTR_ERR(afi_fpga->membase);
> > +
> > +	val =3D device_property_read_u32(&pdev->dev, "xlnx,afi-width",
> > +				       &afi_fpga->afi_width);
> > +	if (val) {
> > +		dev_err(&pdev->dev, "failed to get the afi bus width\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	reg_val =3D readl(afi_fpga->membase + AFI_RDCHAN_CTRL_OFFSET);
> > +	reg_val &=3D ~AFI_BUSWIDTH_MASK;
> > +	writel(reg_val | afi_fpga->afi_width,
> > +	       afi_fpga->membase + AFI_RDCHAN_CTRL_OFFSET);
> > +	reg_val =3D readl(afi_fpga->membase + AFI_WRCHAN_CTRL_OFFSET);
> > +	reg_val &=3D ~AFI_BUSWIDTH_MASK;
> > +	writel(reg_val | afi_fpga->afi_width,
> > +	       afi_fpga->membase + AFI_WRCHAN_CTRL_OFFSET);
> > +
> > +	return 0;
> > +}
>=20
> I do not understand, why is this driver needed at all?  Why can't you do =
the
> above from userspace?
>=20
> All this does is write some values to the hardware at probe time, who nee=
ds
> this?

This driver will be used by the overlay framework for configuring the inter=
face after programming the FPGA and before probing the drivers that are pre=
sent in the PL.

Regards,
Navakishore.
