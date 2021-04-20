Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFCBC365A7D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 15:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbhDTNr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 09:47:57 -0400
Received: from mail-co1nam11on2087.outbound.protection.outlook.com ([40.107.220.87]:41233
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232450AbhDTNrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 09:47:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtJB8dCtEOFCAqZpdZe04gFRHe5h4nFn+TgiWahPzpfZzh/dqRjGmwMcBgQm+oeQYa9GQTBrg3DPPPjIDsb0lVNtFDyq2VybbO5lqquj3GpRHYwVQ/NuqKn/U9y5cpGFjE86VYmWEJ/QPic9oo6Vd3+872vByMoGouRKHhAIsdnIXherTpx8n5c3ezXhsWMZrhEXYTnBlksMQA8h8Os3Tal+2IGhbOcMHEDjMYG+DdEWvUYS5dlCZcq4vtpa/Ee8m0y+UGu5m9FFodMCsmp0Iwz/vG4tITfVCaHbM2A+/6bUp0mSFFwskCdIpjgY/j74DGzWTamE1d5Pc3724Cv2Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IjP1QE/RgUptSbSmCpkxY5zAo4SbHc1J8zcSyWS0XY=;
 b=QRULkY1R1huyNwMpWW2N0k555ReMlTS40eErTqmrEXeXKW/EbA2a3t2WjQTLwOoLtwTkvnRGBD4iADEzAeLnNm0UHLRZMu3Qrs+nE556XVegfqXXSnvTvuV26m4Ya/gvvb8MDs8bCInTVmv9TpAsFc9yJNXG0ejpHgYPdztj7zXacMHye8vCsspXm0+J6/bolLe2xjbf/Fgi1iubDPNf+7AWaoEe+SzBdt5aH/H62tBQr5GrylAfgWFjPSUtDW3HrtM6Tr/Y9K96R3vJ9jILxmAkZuCB9a/ExhEvSI39b1mnJMHq4PHWfhJSeXC1+SZOf0usoiapiuqOKCgIxu8Prw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IjP1QE/RgUptSbSmCpkxY5zAo4SbHc1J8zcSyWS0XY=;
 b=og+NgirBFYeFfG36+VsgwKuNNr5cngIf+Gk+VtIKa2nslGq1a+69AvOyKWXUzTp59Ctd3qOu3HmZRsV6NR9EyIEXKQR/kPDhyvtEQir2yGbR9HUNikLXaIBdn1a1MW5/r13I4VHzLB0/wbF2/A5Lshk9he924d/qPrSjh7GUR0E=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (2603:10b6:300:44::9)
 by MW4PR02MB7297.namprd02.prod.outlook.com (2603:10b6:303:77::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Tue, 20 Apr
 2021 13:47:18 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::297d:1fb:ad07:1b26]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::297d:1fb:ad07:1b26%9]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 13:47:18 +0000
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
Subject: RE: [PATCH 5/5] misc: zynqmp: Add afi config driver
Thread-Topic: [PATCH 5/5] misc: zynqmp: Add afi config driver
Thread-Index: AQHXNb4YA+92oo6dgkaPdwzLOSQ8W6q9GRYAgABSSTA=
Date:   Tue, 20 Apr 2021 13:47:17 +0000
Message-ID: <MWHPR02MB26233345F140ACA18E55BC15C2489@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <20210420081153.17020-1-nava.manne@xilinx.com>
 <20210420081153.17020-6-nava.manne@xilinx.com> <YH6V9Im3L/gJJ/CP@kroah.com>
In-Reply-To: <YH6V9Im3L/gJJ/CP@kroah.com>
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
x-ms-office365-filtering-correlation-id: d5f0e8ac-bcbc-44b2-5ee8-08d90402d046
x-ms-traffictypediagnostic: MW4PR02MB7297:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR02MB7297158E8D9CE66896F7D749C2489@MW4PR02MB7297.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 46kZFBbryQyldZOWmnZsk6JfRJKw/PHEK/kEN7l2bA6m5n8TeuuZ3t+kQEe0WVzYsZ7evkhkLX45XB/vnhOb+de3R/8mjWGRynE760nxOQ3t5PeBSbHA5d533l3BrlqH6PVGwkwKuK5vwOj/RO1ZkkECcW6yhi8+mlCkog6ZwWqxQLueSMO2yM6ryRBgu9QxorHhnA9ehrd1f+D7kN0jfOtJWvbR62irnrAen/fyd35gMcUNB/yXhf5Gf35kBcUeapkydD228GDT+//t78RU2LdLULuFeScHK9h9PXbCOAOJKBp0XzZHJVQqrEzT9pCYZ49mymVRxR45k2FtMSLRKnJriKD8sAvobSwZSZhw8alMDoHYPPZI4e/0XPOumt5D7EcPq/TWfAeqDh6KrF80zCc8iFI2k5pwlEkanUn51ubyk+QQMvmB2eZA5pnj+PqmRZryyQVNoxKOAC1Wk80WaNwvQ4YmmUYtHD7nRfXwSyu1uk2D00l988GCkqb7HD2JVCHbplS7O8IxI6tKfyso5tVvrogPZyxHGtnFP7pkPqsbunZUXqM3qRt8ywEhsIYb1tnJVuFcwOrrCq8cY7Tp2AxB0Esy2XiKHuAsBembx48=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR02MB2623.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(4326008)(83380400001)(8936002)(7696005)(9686003)(316002)(71200400001)(5660300002)(6506007)(53546011)(66556008)(55016002)(33656002)(64756008)(2906002)(76116006)(66446008)(66476007)(66946007)(107886003)(54906003)(52536014)(6916009)(86362001)(38100700002)(122000001)(8676002)(186003)(478600001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?vZuKhe3B6zwj6aQk1sGOzLORZ45b3yW2Db8jPM8d3Iv9D1aw3WZ5Dwo5Xilw?=
 =?us-ascii?Q?E2nolpovJ23j9vnchuTyYDnjZCOoS1EdbL6ziEcOUSVF+44KfCyyu9NkJqgk?=
 =?us-ascii?Q?hs3sj9sH9Vf1HKyeHMnxusMSERthY0zQ8+j/ikCcw65UauIYytZcO6vDjMQY?=
 =?us-ascii?Q?Cx2sh3qPX+TNWjGF6pBniUAX/kNksQ3Gqr5RpKNMnMrJu96U3oBqext63eWr?=
 =?us-ascii?Q?DGldHH4tu5xazm0AuFpDD3s9gbBbSa8qsqWKqI1dA1v5ncYpJFY74cdX33Dt?=
 =?us-ascii?Q?LISiB3csieYCea2AFyBEcVC37Rm9NTROmrTI5K6+OnZ/ah1+tX+uIV7t3hC/?=
 =?us-ascii?Q?8Af+3G9v/RZL6bqO18s7FFbQGS8KHJmwRY2hcDvUw5tJz1K9dslAxz6EIvgM?=
 =?us-ascii?Q?6msi4dRZd9oYupWvJUL5CGAepvRqrusi6NlGhIt4NBqMrIhNZqPwrlDzluBZ?=
 =?us-ascii?Q?cREv1QxxhGwSZUcxaVoz8Zy6GoNasK33WVJ+Cr5AYdcPu8QKefbA4yEPtISE?=
 =?us-ascii?Q?c8RGzrtkHzE8IiWM+2zxR+5E/OWMG3iUdjyEapj8VEesGKF1b0YG7xfhh3XP?=
 =?us-ascii?Q?yUhaVXyGjhckVFVYjwMdSynYmJnfnKAQnDIIUmLzAnxPR2NwunFNu6J3l+tz?=
 =?us-ascii?Q?T7Sd5QPSqOuV0O06VoZPsE9A0JJVaP2Duefxk3NdDDB0FLGQa3Mo072UPGi8?=
 =?us-ascii?Q?r01FGaYni1yJHkGumVGwBEKOQygdHR789Q/1gddBbEKdodAJJKspMTF8QKaW?=
 =?us-ascii?Q?1HhPQT4MzMxjDqVLdEn5aFiX9ZnO+HDoSwNHaYrPTyZhn2agHIANX4quNxua?=
 =?us-ascii?Q?kGxIWCBog59iuXmo6ge4fQg7miM8i+yW/F8X5P474bcB7fPPGtiRaexWMeSW?=
 =?us-ascii?Q?URKZg1aZFWtQvMkoJFNrTVoJWWOHDbf95xsq5rL9eomT3EmsaVSxczSuN2he?=
 =?us-ascii?Q?TP04gbzexlBSkhpoGDdUhIubQ8cS6nwFPY6IhQSIFJ/s8TMgYwVJnbhsTB+S?=
 =?us-ascii?Q?ePV/iN4U8aGVf/Ymyzp8baXGwd4ZeSH178GexW/gEoLi2T037YF4Wror3SNN?=
 =?us-ascii?Q?US9NaWDxwvpHE5jmxz8T1iFAdk9E1m2KSGAnj72rIy39+Xe8IbUy1P9A6IdQ?=
 =?us-ascii?Q?KuNBkmPQ4llg4uZw1bLptFIieMR6KWeXOoDwFhk5P7X9/ACPMByW0Tgk2xev?=
 =?us-ascii?Q?aRYYssn3ixzcFBt7koKqyRmJE14oVUINfWeBIcphW+wHbyI3QZaANAatdVL7?=
 =?us-ascii?Q?JX2DDRLN45x9ATYVSKILwbu1Dd9kyGq3dxOjjCT2HIoyvSidyF/9jqlKGWpE?=
 =?us-ascii?Q?rmwG+pgnEc3IV/mwxiKLBjWE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR02MB2623.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f0e8ac-bcbc-44b2-5ee8-08d90402d046
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2021 13:47:17.1438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o0lmHuPH8LGjDCuTUm7BCghsEZUPXe8pEmfn5WlKwvq07yZrIV7/6Jk3PXEH/Tuk2msnbGP+iIegttox3H5WvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7297
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

	Please find my response inline.

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Tuesday, April 20, 2021 2:21 PM
> To: Nava kishore Manne <navam@xilinx.com>
> Cc: robh+dt@kernel.org; Michal Simek <michals@xilinx.com>; Derek Kiernan
> <dkiernan@xilinx.com>; Dragan Cvetic <draganc@xilinx.com>;
> arnd@arndb.de; Rajan Vaja <RAJANV@xilinx.com>; Jolly Shah
> <JOLLYS@xilinx.com>; Tejas Patel <tejasp@xlnx.xilinx.com>; Amit Sunil
> Dhamne <amitsuni@xilinx.com>; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> chinnikishore369@gmail.com; git <git@xilinx.com>
> Subject: Re: [PATCH 5/5] misc: zynqmp: Add afi config driver
>=20
> On Tue, Apr 20, 2021 at 01:41:53PM +0530, Nava kishore Manne wrote:
> > This patch adds zynqmp afi config driver.This is useful for the
> > configuration of the PS-PL interface on Zynq US+ MPSoC platform.
> >
> > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > ---
> >  drivers/misc/Kconfig      | 11 ++++++
> >  drivers/misc/Makefile     |  1 +
> >  drivers/misc/zynqmp-afi.c | 83
> > +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 95 insertions(+)
> >  create mode 100644 drivers/misc/zynqmp-afi.c
> >
> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig index
> > 877b43b3377d..d1ea1eeb3ac1 100644
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -456,6 +456,17 @@ config ZYNQ_AFI
> >  	  between PS and PL, the AXI port data path should be configured
> >  	  with the proper Bus-width values
> >
> > +config ZYNQMP_AFI
> > +        tristate "Xilinx ZYNQMP AFI support"
> > +        help
> > +	  ZynqMP AFI driver support for writing to the AFI registers for
> > +	  configuring PS_PL Bus-width. Xilinx Zynq US+ MPSoC connect the
> > +	  PS to the programmable logic (PL) through the AXI port. This AXI
> > +	  port helps to establish the data path between the PS and PL.
> > +	  In-order to establish the proper communication path between
> > +	  PS and PL, the AXI port data path should be configured with
> > +	  the proper Bus-width values
> > +
> >  source "drivers/misc/c2port/Kconfig"
> >  source "drivers/misc/eeprom/Kconfig"
> >  source "drivers/misc/cb710/Kconfig"
> > diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile index
> > e9b03843100f..54bd0edc511e 100644
> > --- a/drivers/misc/Makefile
> > +++ b/drivers/misc/Makefile
> > @@ -57,3 +57,4 @@ obj-$(CONFIG_UACCE)		+=3D uacce/
> >  obj-$(CONFIG_XILINX_SDFEC)	+=3D xilinx_sdfec.o
> >  obj-$(CONFIG_HISI_HIKEY_USB)	+=3D hisi_hikey_usb.o
> >  obj-$(CONFIG_ZYNQ_AFI)		+=3D zynq-afi.o
> > +obj-$(CONFIG_ZYNQMP_AFI)	+=3D zynqmp-afi.o
> > diff --git a/drivers/misc/zynqmp-afi.c b/drivers/misc/zynqmp-afi.c new
> > file mode 100644 index 000000000000..a318652576d2
> > --- /dev/null
> > +++ b/drivers/misc/zynqmp-afi.c
> > @@ -0,0 +1,83 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Xilinx FPGA AFI bridge.
> > + * Copyright (c) 2018-2021 Xilinx Inc.
> > + */
> > +
> > +#include <linux/err.h>
> > +#include <linux/firmware/xlnx-zynqmp.h> #include <linux/io.h>
> > +#include <linux/module.h> #include <linux/of.h> #include
> > +<linux/platform_device.h> #include <linux/slab.h>
> > +
> > +/**
> > + * struct zynqmp_afi_fpga - AFI register description
> > + * @value: value to be written to the register
> > + * @regid: Register id for the register to be written
> > + */
> > +struct zynqmp_afi_fpga {
> > +	u32 value;
> > +	u32 regid;
> > +};
> > +
> > +static int zynqmp_afi_fpga_probe(struct platform_device *pdev)
> > +{
> > +	struct zynqmp_afi_fpga *zynqmp_afi_fpga;
> > +	struct device_node *np =3D pdev->dev.of_node;
> > +	int i, entries, ret;
> > +	u32 reg, val;
> > +
> > +	zynqmp_afi_fpga =3D devm_kzalloc(&pdev->dev,
> > +				       sizeof(*zynqmp_afi_fpga), GFP_KERNEL);
> > +	if (!zynqmp_afi_fpga)
> > +		return -ENOMEM;
> > +	platform_set_drvdata(pdev, zynqmp_afi_fpga);
> > +
> > +	entries =3D of_property_count_u32_elems(np, "config-afi");
> > +	if (!entries || (entries % 2)) {
> > +		dev_err(&pdev->dev, "Invalid number of registers\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	for (i =3D 0; i < entries / 2; i++) {
> > +		ret =3D of_property_read_u32_index(np, "config-afi", i * 2,
> &reg);
> > +		if (ret) {
> > +			dev_err(&pdev->dev, "failed to read register\n");
> > +			return -EINVAL;
> > +		}
> > +		ret =3D of_property_read_u32_index(np, "config-afi", i * 2 + 1,
> > +						 &val);
> > +		if (ret) {
> > +			dev_err(&pdev->dev, "failed to read value\n");
> > +			return -EINVAL;
> > +		}
> > +		ret =3D zynqmp_pm_afi(reg, val);
> > +		if (ret < 0) {
> > +			dev_err(&pdev->dev, "AFI register write error %d\n",
> > +				ret);
> > +			return ret;
> > +		}
> > +	}
> > +	return 0;
> > +}
>=20
> Again, why does this have to be in the kernel?  All it does is make a
> single call to the hardware based on some values read from the device
> tree.  Can't you do this from userspace?
>=20
For every PL design has its own PS-PL configuration.
This driver will be used by the overlay framework for configuring the inter=
face after programming the FPGA and before probing the drivers that are pre=
sent in the PL.

Regards,
Navakishore.
