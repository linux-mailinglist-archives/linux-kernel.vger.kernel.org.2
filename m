Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE5A436E4AD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 08:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238520AbhD2GCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 02:02:20 -0400
Received: from mail-bn8nam08on2086.outbound.protection.outlook.com ([40.107.100.86]:11222
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229814AbhD2GCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 02:02:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STH5sHzcaHd/n/57tX13mLrNRairVymAI9VR7mRiHDyrMYpd8/G/4CLhB3xCTEnzJ4t6vqZVwyGrXtXz+CrJAwtwdsR4H2Vif54ECS5JBXn3pzUpDXTEjO3AGJ7kYwel3Asi7YKR5Dm+oR2mQ8aT/utybHazYmj4re723p4i5M4reO1F6ifkisz9PDmbx+6SIvErO2jBjZHb8tMi7vSOD73/lkakR9du6gDWMTwAFsdJbCD4C/EfIJa1ImnasiUagzc7HfrXqb5n+UC+aE/EQWKVsk3YntyQC1Yk7jKw/jaQUveKPzI9+uoj1DPNDr3ejzbXnur2JW4s3qigD9k6kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNQuwtdxwlEwOBVirO47bJy+bBFYD5O1kHTErXCMZLQ=;
 b=ikH3oyQpXM1Llp+kiy1zZCUG3kGJUFwRKGauSheKClay7W12tzOLMqccgux4c5HGMtcvMQ9HnogB7+2NNGTHLoaxRvcMrirdt5CBwawoh3hdJrARaxUp+sEIeG8Vw4BfwEsIK1u7u/oDXSrx/yYyr0sUuXsihUDnhtEkTsU4d7kK/Xz7B0nc2Yn+Rrow5tU+Brff4nsAQUryYkRUaZ9fDJN+9qxOSM2zqDsGbnm8nobk/Qryv2QTqA3M2uuw+XpMwfesr0AiauAPSE84l91ensTd9GHOtoliqMSadG8Poy51Qs87mXh1KmwVfi+vVWn+HGGAq6f4hi2uU81BY9WE2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNQuwtdxwlEwOBVirO47bJy+bBFYD5O1kHTErXCMZLQ=;
 b=c5X+waBjAGxRa9sbIRNBK18+zqLYqYgMzO0AiYolRMz66Poap03OWLqMhXGux173ni3SntEI/yAuJqbY2tGtblkS9lOYkUYdr9T/J07xLpI3dKvPQ83nPMY8Lz9YJoUOFwTLo1TjQWF4LQwvN4QKL1XofZtPF0i2JuZ9JB6phx4=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (2603:10b6:300:44::9)
 by MW4PR02MB7105.namprd02.prod.outlook.com (2603:10b6:303:70::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Thu, 29 Apr
 2021 06:01:28 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::97d:165e:73af:bef8]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::97d:165e:73af:bef8%11]) with mapi id 15.20.4087.026; Thu, 29 Apr 2021
 06:01:28 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Moritz Fischer <mdf@kernel.org>
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
        git <git@xilinx.com>
Subject: RE: [PATCH 5/5] misc: zynqmp: Add afi config driver
Thread-Topic: [PATCH 5/5] misc: zynqmp: Add afi config driver
Thread-Index: AQHXNb4YA+92oo6dgkaPdwzLOSQ8W6q9GRYAgABSSTCAABzAgIANgSTA
Date:   Thu, 29 Apr 2021 06:01:28 +0000
Message-ID: <MWHPR02MB26232DBCD6C20C8B5F4B5F2AC25F9@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <20210420081153.17020-1-nava.manne@xilinx.com>
 <20210420081153.17020-6-nava.manne@xilinx.com> <YH6V9Im3L/gJJ/CP@kroah.com>
 <MWHPR02MB26233345F140ACA18E55BC15C2489@MWHPR02MB2623.namprd02.prod.outlook.com>
 <YH7zGf3/NrXmMN8/@kroah.com>
In-Reply-To: <YH7zGf3/NrXmMN8/@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: mdf@kernel.org
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=xilinx.com;
x-originating-ip: [149.199.50.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29a20ca6-f125-4ff3-654a-08d90ad43ad0
x-ms-traffictypediagnostic: MW4PR02MB7105:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR02MB710591A6140F8127969D730AC25F9@MW4PR02MB7105.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VaXyhcAw3uAO/t5VBkmjTidGBE66/acSptl4DJz5ZNHjKA+uPT9cyL7axoW/a3BGdtzv8WW3pTfQ/Aaps+IDXxFdqgyT8c4sCyEcyH2mtQPnOZGS2f0W5hU7jtj29Z1YcKzAeSPupsa+EO28jfnEiT5ADNCI8egDQm+5dkjdVfaLVllLu6ULqw+v3IThaEOe+qItpKDKRshBvEzM3qaJfH784tReOfRGh3c1Td8ASL+hpSL7ojjzwpi/RM97pDWHC84qopGlID/k4sdoPj88hGlF2zlAYmmMOJV/5YmqCer3mPPYuiL0p2DsMl5NABiG1Xf2whA2PMC+FBV3Fl8aalWn3jSWpWS8ggYx2C5yLqx4ASLl5ojQ3ycmnmidpPiTmOpsZwBfFWK1Tm8nfTD6hUshtxQ8ztnfRz8ipmeLuu8f0I7dlzuZnq/5qI7M722w+wD9B3KnGap+l5JWsfxW6t2hJtPnQ7YJ6rZN2CWdKx9dh7NV+9XXk53jLwCSerO7rs8ZdDqvMTNdNzUMpoEg1JJbu1YOFdKbZnWi2yUpnhVqLuZEjqBNHAwTZchJtXOOF+qE23W2HnxKeldjzEvBApPGxMtzaLgWkRIQtwxsAddGLaFhnd9cL/voxrKnR7uFyR6f22Wi5AJYCIoqOAd5DZZigd4QztiYKMPq22vPKDkZ7biqtFOEAHRIN3EybfYB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR02MB2623.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(316002)(38100700002)(52536014)(5660300002)(8676002)(9686003)(186003)(478600001)(8936002)(76116006)(122000001)(33656002)(107886003)(966005)(55016002)(54906003)(4326008)(64756008)(110136005)(6506007)(7696005)(53546011)(26005)(86362001)(2906002)(83380400001)(66476007)(66946007)(66446008)(71200400001)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?q0jEYAs34xQd2fDV8k3QQE2UFlHWHPQVLiP63S7oU3kxfU7dRV3+biJ8JJyv?=
 =?us-ascii?Q?0KYhmHjU+zOidUAOSB5+jlEleA3MEGWfWVxahphXpVo8gX9OiDh1Z/YHBrmZ?=
 =?us-ascii?Q?Rn2NE/fykwcRP9K3Q+NHi/l4kPA1WvQXrHaRC02UB15iieiCmz6jVQeUWWuv?=
 =?us-ascii?Q?CVFtgp/BR5xY0Lrg0fyVIH7iWYGdo34O3xKY0Or0KUMKogqE6guDp6FvQp4H?=
 =?us-ascii?Q?wuan6kODKfSPoftq8yi/3ysQiQdfEnAVoyNK8dI4sHPEeSD/M9pO3MpNqIcS?=
 =?us-ascii?Q?NZNBDDX4O0zDriBN2+r5QFiKnPsu92IDZCwzvfzdYxFEZJ2VsXLRjZ+zSgjg?=
 =?us-ascii?Q?zedds1yrVp2HhXnU83+rpTteknu30g05oUs7BZvKwGCG9TN0QSYdWzGkpxxS?=
 =?us-ascii?Q?Hvk5wVQgvuktDI33BKQbrp5Eh28g0EFCX/Onge65yjDKvLrF/Qpe+1V9VUT7?=
 =?us-ascii?Q?zIkxhbzOU2aEEw/XF1leS68Hb7EJv5BJpzWRqjTjwzwIdCjQ7ETMm6hsYVi+?=
 =?us-ascii?Q?FyQcYLuHPXoQxEjLHsAWrxnaF/mI89L8lhZuXqHMWIGRylRu4chuD+22IvoE?=
 =?us-ascii?Q?aJ3dTlwxv8NeJ9xYz96sK2lJmQbweLu7EDexRMdhmBrRIxU4biLaJOq5hjDL?=
 =?us-ascii?Q?sD7HCSxdmexUeSui9gBoi+yX91JjJzUZttHesqzByUWKU7XHlK5+DnDJ7zwL?=
 =?us-ascii?Q?driINQcEooKG1KMK6/aGvFQFNb0uO3DAeUal9TZq/hHjNHtZCTlVx51Zdw7U?=
 =?us-ascii?Q?AhO0evuY5iuyhcqk+hkzoqQODpyPpWSTUG46Fs6idSqYE1mRA6TO3i25s4RH?=
 =?us-ascii?Q?w5HiEHM8gCZKcVcIYHxc7dpVPaIV3o7CIFlOe7gWcvD68iYu0VUHVZxrPHWN?=
 =?us-ascii?Q?jmIKrVHdRvgqyr6KJeBd79ksr2uT4P1iAfYznhMXSSn3gWesRExis4nnK6hC?=
 =?us-ascii?Q?gFjtTelQmBVXPt5QQ+q5UsHz7coOA3oNG2nBH2oNPM12tdMCHq0hzbYXEQcT?=
 =?us-ascii?Q?lT4wFbAbX0Ua1ivezGGBrzN+u8aRkVzJMfFJ031WrQ+pLQ960D7FG4uVx5Oa?=
 =?us-ascii?Q?Qx5z/q7bIed+TNGsnn5ABC6hbG5TaUKHxQAqjw4uQLmYi1cMpFxKZ00Tr6En?=
 =?us-ascii?Q?6OQLI8LX2y/POUYipHUxS9mRJc3gxlYcqC4I0BEq4KmudedcPCNFIoTk1a03?=
 =?us-ascii?Q?5Q2L3vv9lvCNEmWghQJsWmTMs3+InEakt5m3ZF8BaIsV6Xv2BNYi0whOPdGJ?=
 =?us-ascii?Q?O6bg9kloAxBBxbQuL5MFhqTaIiDO45aevadOsLAJ1q73D8EP4U3DGyhH68hm?=
 =?us-ascii?Q?/JF8lAdrpV/H9/jTBQbQ0PvJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR02MB2623.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a20ca6-f125-4ff3-654a-08d90ad43ad0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2021 06:01:28.3297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6myyhNttAnFuy0fKFTPqRFM7F8RJHWMWvte5A0usIlWUzvrt9Qqi3jxr9ShvTD8BSYx0i4UMfe8miOYAU4ck2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7105
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

	Please find my response inline.

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Tuesday, April 20, 2021 8:58 PM
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
> On Tue, Apr 20, 2021 at 01:47:17PM +0000, Nava kishore Manne wrote:
> > Hi Greg,
> >
> > 	Please find my response inline.
> >
> > > -----Original Message-----
> > > From: Greg KH <gregkh@linuxfoundation.org>
> > > Sent: Tuesday, April 20, 2021 2:21 PM
> > > To: Nava kishore Manne <navam@xilinx.com>
> > > Cc: robh+dt@kernel.org; Michal Simek <michals@xilinx.com>; Derek
> > > Kiernan <dkiernan@xilinx.com>; Dragan Cvetic <draganc@xilinx.com>;
> > > arnd@arndb.de; Rajan Vaja <RAJANV@xilinx.com>; Jolly Shah
> > > <JOLLYS@xilinx.com>; Tejas Patel <tejasp@xlnx.xilinx.com>; Amit
> > > Sunil Dhamne <amitsuni@xilinx.com>; devicetree@vger.kernel.org;
> > > linux-arm- kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > > chinnikishore369@gmail.com; git <git@xilinx.com>
> > > Subject: Re: [PATCH 5/5] misc: zynqmp: Add afi config driver
> > >
> > > On Tue, Apr 20, 2021 at 01:41:53PM +0530, Nava kishore Manne wrote:
> > > > This patch adds zynqmp afi config driver.This is useful for the
> > > > configuration of the PS-PL interface on Zynq US+ MPSoC platform.
> > > >
> > > > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > > > ---
> > > >  drivers/misc/Kconfig      | 11 ++++++
> > > >  drivers/misc/Makefile     |  1 +
> > > >  drivers/misc/zynqmp-afi.c | 83
> > > > +++++++++++++++++++++++++++++++++++++++
> > > >  3 files changed, 95 insertions(+)  create mode 100644
> > > > drivers/misc/zynqmp-afi.c
> > > >
> > > > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig index
> > > > 877b43b3377d..d1ea1eeb3ac1 100644
> > > > --- a/drivers/misc/Kconfig
> > > > +++ b/drivers/misc/Kconfig
> > > > @@ -456,6 +456,17 @@ config ZYNQ_AFI
> > > >  	  between PS and PL, the AXI port data path should be configured
> > > >  	  with the proper Bus-width values
> > > >
> > > > +config ZYNQMP_AFI
> > > > +        tristate "Xilinx ZYNQMP AFI support"
> > > > +        help
> > > > +	  ZynqMP AFI driver support for writing to the AFI registers for
> > > > +	  configuring PS_PL Bus-width. Xilinx Zynq US+ MPSoC connect the
> > > > +	  PS to the programmable logic (PL) through the AXI port. This AX=
I
> > > > +	  port helps to establish the data path between the PS and PL.
> > > > +	  In-order to establish the proper communication path between
> > > > +	  PS and PL, the AXI port data path should be configured with
> > > > +	  the proper Bus-width values
> > > > +
> > > >  source "drivers/misc/c2port/Kconfig"
> > > >  source "drivers/misc/eeprom/Kconfig"
> > > >  source "drivers/misc/cb710/Kconfig"
> > > > diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile index
> > > > e9b03843100f..54bd0edc511e 100644
> > > > --- a/drivers/misc/Makefile
> > > > +++ b/drivers/misc/Makefile
> > > > @@ -57,3 +57,4 @@ obj-$(CONFIG_UACCE)		+=3D uacce/
> > > >  obj-$(CONFIG_XILINX_SDFEC)	+=3D xilinx_sdfec.o
> > > >  obj-$(CONFIG_HISI_HIKEY_USB)	+=3D hisi_hikey_usb.o
> > > >  obj-$(CONFIG_ZYNQ_AFI)		+=3D zynq-afi.o
> > > > +obj-$(CONFIG_ZYNQMP_AFI)	+=3D zynqmp-afi.o
> > > > diff --git a/drivers/misc/zynqmp-afi.c b/drivers/misc/zynqmp-afi.c
> > > > new file mode 100644 index 000000000000..a318652576d2
> > > > --- /dev/null
> > > > +++ b/drivers/misc/zynqmp-afi.c
> > > > @@ -0,0 +1,83 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Xilinx FPGA AFI bridge.
> > > > + * Copyright (c) 2018-2021 Xilinx Inc.
> > > > + */
> > > > +
> > > > +#include <linux/err.h>
> > > > +#include <linux/firmware/xlnx-zynqmp.h> #include <linux/io.h>
> > > > +#include <linux/module.h> #include <linux/of.h> #include
> > > > +<linux/platform_device.h> #include <linux/slab.h>
> > > > +
> > > > +/**
> > > > + * struct zynqmp_afi_fpga - AFI register description
> > > > + * @value: value to be written to the register
> > > > + * @regid: Register id for the register to be written  */ struct
> > > > +zynqmp_afi_fpga {
> > > > +	u32 value;
> > > > +	u32 regid;
> > > > +};
> > > > +
> > > > +static int zynqmp_afi_fpga_probe(struct platform_device *pdev) {
> > > > +	struct zynqmp_afi_fpga *zynqmp_afi_fpga;
> > > > +	struct device_node *np =3D pdev->dev.of_node;
> > > > +	int i, entries, ret;
> > > > +	u32 reg, val;
> > > > +
> > > > +	zynqmp_afi_fpga =3D devm_kzalloc(&pdev->dev,
> > > > +				       sizeof(*zynqmp_afi_fpga), GFP_KERNEL);
> > > > +	if (!zynqmp_afi_fpga)
> > > > +		return -ENOMEM;
> > > > +	platform_set_drvdata(pdev, zynqmp_afi_fpga);
> > > > +
> > > > +	entries =3D of_property_count_u32_elems(np, "config-afi");
> > > > +	if (!entries || (entries % 2)) {
> > > > +		dev_err(&pdev->dev, "Invalid number of registers\n");
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > > +	for (i =3D 0; i < entries / 2; i++) {
> > > > +		ret =3D of_property_read_u32_index(np, "config-afi", i * 2,
> > > &reg);
> > > > +		if (ret) {
> > > > +			dev_err(&pdev->dev, "failed to read register\n");
> > > > +			return -EINVAL;
> > > > +		}
> > > > +		ret =3D of_property_read_u32_index(np, "config-afi", i * 2 + 1,
> > > > +						 &val);
> > > > +		if (ret) {
> > > > +			dev_err(&pdev->dev, "failed to read value\n");
> > > > +			return -EINVAL;
> > > > +		}
> > > > +		ret =3D zynqmp_pm_afi(reg, val);
> > > > +		if (ret < 0) {
> > > > +			dev_err(&pdev->dev, "AFI register write error
> %d\n",
> > > > +				ret);
> > > > +			return ret;
> > > > +		}
> > > > +	}
> > > > +	return 0;
> > > > +}
> > >
> > > Again, why does this have to be in the kernel?  All it does is make
> > > a single call to the hardware based on some values read from the
> > > device tree.  Can't you do this from userspace?
> > >
> > For every PL design has its own PS-PL configuration.
>=20
> What is a "PL design", and what is a "PS-PL configuration"?  :)
>=20
> > This driver will be used by the overlay framework for configuring the
> interface after programming the FPGA and before probing the drivers that
> are present in the PL.
>=20
> Again, I have no idea what this means at all.
>=20
> And again, why does this have to be done in the kernel?  All you are doin=
g is
> sending some random values read in DT down to a hardware
> device.   What requires a kernel driver for this?
>=20

The ZynqMP based processing system (PS) that contains ARM cores and Xilinx =
programmable logic (PL/FPGA) in a single device. The PS and PL can be tight=
ly or loosely coupled using multiple interfaces and other signals.
This enables the designer to effectively integrate user-created hardware ac=
celerators and other functions in the PL logic that are accessible to the p=
rocessors and can also access memory resources in the PS.
https://www.xilinx.com/support/documentation/user_guides/ug1085-zynq-ultras=
cale-trm.pdf  (Page No: 1085)

To Program/Re-Program the PL at runtime in Linux we have a an FPGA Manger F=
ramework and this frame work uses DT-Overlays to programming the FPGA and p=
robing the relevant PL drivers.
For more info please refer this link: https://elixir.bootlin.com/linux/late=
st/source/Documentation/devicetree/bindings/fpga/fpga-region.txt =20

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
                        afi0: afi0 {
                                compatible =3D "xlnx,afi-fpga";
                                config-afi =3D < 0 0>, <1 0>, <2 0>, <3 0>,=
 <4 0>, <5 0>, <6 0>, <7 0>, <8 0>, <9 0>, <10 0>, <11 0>, <12 0>, <13 0>, =
<14 0xa00>, <15 0x000>;
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

