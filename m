Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDB436E4D8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 08:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238853AbhD2GYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 02:24:52 -0400
Received: from mail-mw2nam10on2059.outbound.protection.outlook.com ([40.107.94.59]:3041
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231781AbhD2GYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 02:24:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPQc3HrPH7FK9tymct4yJol2CDPz43A1nI90qMMBYC7Pbtpta1y2/uI7HDRbXZtbtc4qNAEBdBfYBKANKIVjv5HI4PFWX8mNLDsYWCbyeK2zwf218WyGKJRJQXwiH5vIEnFpVsKb8GYlHjpAto7x8pKda4QpdR41miS6+eEFum96PIQGCQuTY36qpeRl8br0xfpZYPuVRG0JN4/2Fn4pZLsFltgKzbU28xolc9/tlTHX3MeJ8lmMv9e3kKcEL9zIpNzWO6RR1oXoGwbhwkdCWsKyWsEBZQfj4A8C2kaOTOmrlZ0mtV7zH9xuCp6yu8MhKTDQEKzWYgTsjDUt1N6wPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErECBXuKXOIDMq9dNy6D0EfVQV06UfhbP1rTIuM1cLs=;
 b=FA36KxdxvSYQ5l8Gl4152QnBVNwlwkYl41VQeTmoS3fRvS5kpIH+eAQ3RNImaJxUgyuMj21hVd6PWEf7g4LefQJLhbo/bxHi/0NVI/VCW6NuKLkoIyO50lcm2sXZpClAB0sdUE0/7v5Oumo+Hrxym2Re6lfQLP2CXZHTlUCVZubVm6csWK45c0Ok0Y0l72aikShfrCEcvl7TCIicjg/q4tB8BTdB3AhSbEIATzs9edHbUZqZXfDbPc0lmyxrp17aZFcb/R54qArx+eqo4kWzyz1IKadPNhCV6UUhrtSWGVdLvvkEHC0z9qJ49WY2MhK89+qSfbLQzaz1/64xA2Yyag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErECBXuKXOIDMq9dNy6D0EfVQV06UfhbP1rTIuM1cLs=;
 b=P4kq4uogC58D+4vrBLguT8S7XjlrP8/p92GMFmyuJSvf7gq6SxhJd6ix5dig0jKmQy4TPBYmoGqFaneKbwvFts5QCTwgatb9ep+TUKxKSw3RQJdphu//Txu79fUbu2w7N7ny7ToZRpacQsA3UWSWel4nUkzemuEH/EOt19lBEhg=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (2603:10b6:300:44::9)
 by MW4PR02MB7475.namprd02.prod.outlook.com (2603:10b6:303:72::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Thu, 29 Apr
 2021 06:23:59 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::97d:165e:73af:bef8]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::97d:165e:73af:bef8%11]) with mapi id 15.20.4087.026; Thu, 29 Apr 2021
 06:23:59 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        Derek Kiernan <dkiernan@xilinx.com>,
        Dragan Cvetic <draganc@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>, Rajan Vaja <RAJANV@xilinx.com>,
        Jolly Shah <JOLLYS@xilinx.com>,
        Tejas Patel <tejasp@xlnx.xilinx.com>,
        Amit Sunil Dhamne <amitsuni@xlnx.xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>,
        git <git@xilinx.com>, Moritz Fischer <mdf@kernel.org>
Subject: RE: [PATCH 2/5] misc: zynq: Add afi config driver
Thread-Topic: [PATCH 2/5] misc: zynq: Add afi config driver
Thread-Index: AQHXNb4PdbEXyUDOFECbgYvFos0TEqq9F+4AgABOgRCAACFeAIANistQ
Date:   Thu, 29 Apr 2021 06:23:59 +0000
Message-ID: <MWHPR02MB262375C50CF76F70F88BB2B6C25F9@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <20210420081153.17020-1-nava.manne@xilinx.com>
 <20210420081153.17020-3-nava.manne@xilinx.com> <YH6U/L4SEtJajusW@kroah.com>
 <MWHPR02MB2623DED0785A05A9C55C20FBC2489@MWHPR02MB2623.namprd02.prod.outlook.com>
 <YH7y1Em4bp505DaV@kroah.com>
In-Reply-To: <YH7y1Em4bp505DaV@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=xilinx.com;
x-originating-ip: [149.199.50.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a89463a3-b66b-44a0-3606-08d90ad75fe0
x-ms-traffictypediagnostic: MW4PR02MB7475:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR02MB7475343938558062618EABCEC25F9@MW4PR02MB7475.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WShjzYU2MgdHP8blLhzPOglEP64lA6aCJKUzZrGKW0czQLCruaRWQVlAR2BlhYEWEjK/wn5oE701zBPLDeRy0CnBDN2IIpv5ZpaNSVrC1Be61vHlfCj3qfJtsr4cPFxBOsMhzpkPsG1QjtzJU3fd/HdZPOXwES9KSk0WcUBfo55MxxbNNb53IXzth+/kx5l9fv4DpUsySfhmVK4zm6snCSFu5YrFkVgQQ1k9RMkioz5tlV6SIXYws6gLlS03B6UO1vLPcHaSloi53zMXof4UNmk4Pn0fO9Z0Lf2LcNxm8tGmzBcC6MnAN7DPKHYfrQxwTf0vrAJ3LT4hC1Gh1pxAq9w5hEfkV9I4nvCikoeGCQqGIMaks2k6qxcrV4u0WIjQpMAv4JBo6Q8jxc87Z9+9Ach9+sc5LEUuBZT9GuA8vA+JyOXZcP4yhBzMAETJv6EGLIFE9MZQrXzA3OSVsHFCtuY5rIa+0EFqJSXhnO5zYXEL0X0UI+j7c1PEmD4zGDIMnmsob18k+IXgsqB861SJDEYQ8Tls6FDvoZ6zWrCEsPmGsh9nbysvHZEqMkuhuUVZSv1U+VJH5kvC5P2Wufy8cnmKE+7GDU4+dz9XEFqMnun52tQ1I3Ome38DXSIAgL3B/mHKtFwHR4iM+Trrhjq/QK8e1ivOGdPNL6xCjFQGdf6MiFigW2mpvbKf0+/B585Y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR02MB2623.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(39850400004)(396003)(346002)(186003)(966005)(9686003)(54906003)(64756008)(316002)(26005)(76116006)(478600001)(53546011)(86362001)(6916009)(7696005)(55016002)(33656002)(66946007)(66476007)(66556008)(83380400001)(52536014)(66446008)(5660300002)(122000001)(8676002)(2906002)(6506007)(4326008)(71200400001)(8936002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?/U1UHbJuL4brghekFSy4upfm/05KkAjrUgByN+Ds8DCh5rAL4MjN0rLs8BuG?=
 =?us-ascii?Q?aKLKQOAEaTIxEsmUBG+9ebMZh2VNpr8K9He2/sAT8actKZpBtfd1jB2/dpRW?=
 =?us-ascii?Q?N0/gCDn7wbG4a4VZCPgGdxaXHPyYpXpHAKCf7EME5ZABcD1npyVHAwDJPRrH?=
 =?us-ascii?Q?EgqrK4TlVrEqUs9aBBeszv5YKzfPLrhOyrqM2fUg2IIYz1cTig8IwgurpMr+?=
 =?us-ascii?Q?llGo8ZyBqG4ZJr6LQAdNQBozDx3gPd1pUPuw43KdI5NFefyn0c8nViUiHWmp?=
 =?us-ascii?Q?e8CVb2SGHe7IQ2Rrwy9kmQ+J1OrErU5SAZA2gNVKl+FtMnIaKH/dJZiqWozr?=
 =?us-ascii?Q?ZncEHD6AELf7B/XiA+DtcIn0JZvQhXRhlOOnWItumgeiO/D4t04zRzTutHO6?=
 =?us-ascii?Q?c8wBj0wIu1EXjVgCKarSJjjhbA4IQ/OVMh1sYpLRUuZ3llWHy9YhixfBx0qu?=
 =?us-ascii?Q?W+4FvFdPj/l7Gakvf6mDkrqGKm1RKZjwg8eUOdzUr1cxx88WrTa0eT7Dar3u?=
 =?us-ascii?Q?FuQazWQyFBUni16BYPnY/6+hOIGKX3w6ySm30OH9zNfbDtPyippvAHvhfyFG?=
 =?us-ascii?Q?1QcBeTgHvMkKHdTzoyJZI+46NC6GDjT2X0rWL8JqAz5oXs732N8uLM8NY7rG?=
 =?us-ascii?Q?jJgttBRYGEHnu590XMb94pwNykc0ZBvTpK1kDyDMKLiAXYU7J4RLwbVuqhsc?=
 =?us-ascii?Q?cqJL2sxI1TEoG4jMl4G/76cBvzGaf3esbtZLV32bkLU+wH5mtexPetE00R89?=
 =?us-ascii?Q?m7qg8FeFixdEWhGa/rrYMB8JbCK1UaNk6N10h/uAGEbEKdNyWnVOy/QPJvC0?=
 =?us-ascii?Q?GWMZDaXPBx74CzYRUslw0gad+8n9VqXKyb2CWQVoqFRCt37L+MNwERwH9qLF?=
 =?us-ascii?Q?i4NzMXFecqZWXS6UWSEu9ojPeMsKMwZEjjo/c/Dc6K24/R/xYX/HEF+iaxb8?=
 =?us-ascii?Q?nIkkcTTTT2/7/Dkr/rYQKD6jCVypaXmdNaUrimndLRxvNy+xG04iqK8VFl2Q?=
 =?us-ascii?Q?M2PG0CouVBUEB+iMDQApBVtPWJkPFOpX6fGtF/1OQ6D3Qn62TeB+L6osqXbG?=
 =?us-ascii?Q?m5i4z9eE1mV2tmHiWs+LbkSOz2QZxL22VgdQjnxeOxooBpxpX0kJiojsmjJC?=
 =?us-ascii?Q?/RlEmM9nVj1XwKQ11SeByIawFMLAUqvRBzUtfP1aBXb9Dmb59tUW+d/NTEvf?=
 =?us-ascii?Q?q10CGWZuVscQ2cxYCRKQsC4C3uOdR8W/NfWqkMxGDyPMkES0wpy/nGq2vMwF?=
 =?us-ascii?Q?nVg6XAhQpXmErFxmHzQD5yN2nF8dQ2uEnRt1jX5rGmc5FTqW+LZyx35DhxOr?=
 =?us-ascii?Q?Qg/WMNKPXZUcrEuexRzslKoD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR02MB2623.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a89463a3-b66b-44a0-3606-08d90ad75fe0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2021 06:23:59.0412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hdjyB6Uq+BIacMGJb62vuyBc6GQuZzBuaUBzkCRG9pCTN2W5A1L4Cy/vj6jLLUBIKvx8cpJTeVuNl3JzNSOjIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7475
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

	Please find my response inline.

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Tuesday, April 20, 2021 8:57 PM
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
> On Tue, Apr 20, 2021 at 01:36:51PM +0000, Nava kishore Manne wrote:
> > Hi Greg,
> >
> > 	Please find my response inline.
> >
> > > -----Original Message-----
> > > From: Greg KH <gregkh@linuxfoundation.org>
> > > Sent: Tuesday, April 20, 2021 2:17 PM
> > > To: Nava kishore Manne <navam@xilinx.com>
> > > Cc: robh+dt@kernel.org; Michal Simek <michals@xilinx.com>; Derek
> > > Kiernan <dkiernan@xilinx.com>; Dragan Cvetic <draganc@xilinx.com>;
> > > arnd@arndb.de; Rajan Vaja <RAJANV@xilinx.com>; Jolly Shah
> > > <JOLLYS@xilinx.com>; Tejas Patel <tejasp@xlnx.xilinx.com>; Amit
> > > Sunil Dhamne <amitsuni@xilinx.com>; devicetree@vger.kernel.org;
> > > linux-arm- kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > > chinnikishore369@gmail.com; git <git@xilinx.com>
> > > Subject: Re: [PATCH 2/5] misc: zynq: Add afi config driver
> > >
> > > On Tue, Apr 20, 2021 at 01:41:50PM +0530, Nava kishore Manne wrote:
> > > > This patch adds zynq afi config driver. This is useful for the
> > > > configuration of the PS-PL interface on zynq platform.
> > >
> > > What is "PS-PL"?  Can you describe it better please?
> > >
> > PS-PL interface is nothing but the interface between processing system(=
PS)
> that contains arm cores and Programmable Logic(PL) i.e FPGA.
> > Will update the description in v2.
> >
> > > >
> > > > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > > > ---
> > > >  drivers/misc/Kconfig    | 11 ++++++
> > > >  drivers/misc/Makefile   |  1 +
> > > >  drivers/misc/zynq-afi.c | 81
> > > > +++++++++++++++++++++++++++++++++++++++++
> > > >  3 files changed, 93 insertions(+)  create mode 100644
> > > > drivers/misc/zynq-afi.c
> > > >
> > > > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig index
> > > > f532c59bb59b..877b43b3377d 100644
> > > > --- a/drivers/misc/Kconfig
> > > > +++ b/drivers/misc/Kconfig
> > > > @@ -445,6 +445,17 @@ config HISI_HIKEY_USB
> > > >  	  switching between the dual-role USB-C port and the USB-A host
> > > ports
> > > >  	  using only one USB controller.
> > > >
> > > > +config ZYNQ_AFI
> > > > +	tristate "Xilinx ZYNQ AFI support"
> > > > +	help
> > > > +	  Zynq AFI driver support for writing to the AFI registers
> > > > +	  for configuring PS_PL Bus-width. Xilinx Zynq SoC connect
> > > > +	  the PS to the programmable logic (PL) through the AXI port.
> > > > +	  This AXI port helps to establish the data path between the
> > > > +	  PS and PL.In-order to establish the proper communication path
> > > > +	  between PS and PL, the AXI port data path should be configured
> > > > +	  with the proper Bus-width values
> > > > +
> > > >  source "drivers/misc/c2port/Kconfig"
> > > >  source "drivers/misc/eeprom/Kconfig"
> > > >  source "drivers/misc/cb710/Kconfig"
> > > > diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile index
> > > > 99b6f15a3c70..e9b03843100f 100644
> > > > --- a/drivers/misc/Makefile
> > > > +++ b/drivers/misc/Makefile
> > > > @@ -56,3 +56,4 @@ obj-$(CONFIG_HABANA_AI)		+=3D
> > > habanalabs/
> > > >  obj-$(CONFIG_UACCE)		+=3D uacce/
> > > >  obj-$(CONFIG_XILINX_SDFEC)	+=3D xilinx_sdfec.o
> > > >  obj-$(CONFIG_HISI_HIKEY_USB)	+=3D hisi_hikey_usb.o
> > > > +obj-$(CONFIG_ZYNQ_AFI)		+=3D zynq-afi.o
> > > > diff --git a/drivers/misc/zynq-afi.c b/drivers/misc/zynq-afi.c new
> > > > file mode 100644 index 000000000000..04317d1bdb98
> > > > --- /dev/null
> > > > +++ b/drivers/misc/zynq-afi.c
> > > > @@ -0,0 +1,81 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Xilinx ZYNQ AFI driver.
> > > > + * Copyright (c) 2018-2021 Xilinx Inc.
> > > > + */
> > > > +
> > > > +#include <linux/err.h>
> > > > +#include <linux/io.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/of.h>
> > > > +#include <linux/platform_device.h>
> > > > +
> > > > +/* Registers and special values for doing register-based operation=
s */
> > > > +#define AFI_RDCHAN_CTRL_OFFSET	0x00
> > > > +#define AFI_WRCHAN_CTRL_OFFSET	0x14
> > > > +
> > > > +#define AFI_BUSWIDTH_MASK	0x01
> > > > +
> > > > +/**
> > > > + * struct afi_fpga - AFI register description
> > > > + * @membase:	pointer to register struct
> > > > + * @afi_width:	AFI bus width to be written
> > > > + */
> > > > +struct zynq_afi_fpga {
> > > > +	void __iomem	*membase;
> > > > +	u32		afi_width;
> > > > +};
> > > > +
> > > > +static int zynq_afi_fpga_probe(struct platform_device *pdev) {
> > > > +	struct zynq_afi_fpga *afi_fpga;
> > > > +	struct resource *res;
> > > > +	u32 reg_val;
> > > > +	u32 val;
> > > > +
> > > > +	afi_fpga =3D devm_kzalloc(&pdev->dev, sizeof(*afi_fpga),
> > > GFP_KERNEL);
> > > > +	if (!afi_fpga)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > > +	afi_fpga->membase =3D devm_ioremap_resource(&pdev->dev, res);
> > > > +	if (IS_ERR(afi_fpga->membase))
> > > > +		return PTR_ERR(afi_fpga->membase);
> > > > +
> > > > +	val =3D device_property_read_u32(&pdev->dev, "xlnx,afi-width",
> > > > +				       &afi_fpga->afi_width);
> > > > +	if (val) {
> > > > +		dev_err(&pdev->dev, "failed to get the afi bus width\n");
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > > +	reg_val =3D readl(afi_fpga->membase + AFI_RDCHAN_CTRL_OFFSET);
> > > > +	reg_val &=3D ~AFI_BUSWIDTH_MASK;
> > > > +	writel(reg_val | afi_fpga->afi_width,
> > > > +	       afi_fpga->membase + AFI_RDCHAN_CTRL_OFFSET);
> > > > +	reg_val =3D readl(afi_fpga->membase + AFI_WRCHAN_CTRL_OFFSET);
> > > > +	reg_val &=3D ~AFI_BUSWIDTH_MASK;
> > > > +	writel(reg_val | afi_fpga->afi_width,
> > > > +	       afi_fpga->membase + AFI_WRCHAN_CTRL_OFFSET);
> > > > +
> > > > +	return 0;
> > > > +}
> > >
> > > I do not understand, why is this driver needed at all?  Why can't
> > > you do the above from userspace?
> > >
> > > All this does is write some values to the hardware at probe time,
> > > who needs this?
> >
> > This driver will be used by the overlay framework for configuring the
> interface after programming the FPGA and before probing the drivers that
> are present in the PL.
>=20
> What is a "overlay framework"?  And why does the kernel have to do this?
> Why can't you write these hardware values from userspace?
>=20
> confused,
>=20

The Zynq based processing system (PS) that contains ARM cores and Xilinx pr=
ogrammable logic (PL/FPGA) in a single device. The PS and PL can be tightly=
 or loosely coupled using multiple interfaces and other signals.
This enables the designer to effectively integrate user-created hardware ac=
celerators and other functions in the PL logic that are accessible to the p=
rocessors and can also access memory resources in the PS.
https://www.xilinx.com/support/documentation/user_guides/ug585-Zynq-7000-TR=
M.pdf (Page No: 41)

To Program/Re-Program the PL at runtime in Linux we have a an FPGA Manger F=
ramework and this frame work uses DT-Overlays to programming the FPGA and p=
robing the relevant PL drivers.
For more info please refer this link: https://elixir.bootlin.com/linux/late=
st/source/Documentation/devicetree/bindings/fpga/fpga-region.txt  =20

Every Zynq/ZynqMP PL(FPGA) design has its own PS-PL configuration. So after=
 programming the FPGA and before probing the relevant PL drivers these PS-P=
L configurations should be set.

Example DT-Overlay file to program the PL(FPGA) from Linux:
/dts-v1/;
/plugin/;
/ {
        fragment@0 {  /* fragment 0 contains Bitstream info */
                target =3D <&fpga_full>;
                overlay0: __overlay__ {
                        #address-cells =3D <2>;
                        #size-cells =3D <2>;
                        firmware-name =3D "Base_Zynq_MPSoC_wrapper.bit.bin"=
;
                        resets =3D <&zynqmp_reset 116>;
                };
        };
        fragment@1 { /* fragment 1 contains PS-PL configurations */
                target =3D <&amba>;
                overlay1: __overlay__ {
                        afi0: afi@f8008000 {
                                #address-cells =3D <0x1>;
                                #size-cells =3D <0x0>;
                                compatible =3D "xlnx,zynq-afi-fpga";
                                reg =3D <0xf8008000 0x24>;
                                xlnx,afi-width =3D <0x1>;
                        };
                 };
        };
       fragment@2 { /* Fragment 2 contains the relevant drivers  for the IP=
's present in the FPGA design*/
                target =3D <&amba>;
                overlay2: __overlay__ {
                        axi_gpio_0: gpio@a0000000 {
                                #gpio-cells =3D <2>;
                                clock-names =3D "s_axi_aclk";
                                clocks =3D <&zynqmp_clk 71>;
                                compatible =3D "xlnx,xps-gpio-1.00.a";
                                gpio-controller ;
                                reg =3D <0x0 0xa0000000 0x0 0x1000>;
                        };
                };
         } ;              =20
};

In-order to support the PL(FPGA) programming and to configure the interface=
 between PS and PL using FPGA Manager. This Driver is  needed in the kernel=
 space.

@Moritz Fischer: Can you please let us know your thoughts on this.

Regards,
Navakishore.
