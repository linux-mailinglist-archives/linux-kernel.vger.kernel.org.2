Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED51E379BE8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 03:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhEKBPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 21:15:22 -0400
Received: from mail-eopbgr50083.outbound.protection.outlook.com ([40.107.5.83]:19844
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229934AbhEKBPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 21:15:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAsUdnFFXxxhHHDQKKgWDYdMnEO9HKQr1WAWzoTZHWpl6dnZPRSq4gfHmDMFsIOFRpwyDrDBpZJzEjNdG9/ugm9+3D18accig+izZkfRK8VT5l6vU2+8z1Q4MVhd6JC4j7cpb/t8gYUwnvW5R08RwdQonXLL36Bh4dydt20qbt5j8qZFV393ep5Dg/5B8N8aANr8CvdDEd01eW6Eae32z5dir4UYWwROXeyFcLIpgz9bWTihX4iT4JqzAAZcOUKIKdrbyGF2rOBO0tlKAJoTAsNUCPWHAxhXvYFEPMoucKVprHHtOCR92UB5omKUpO4u4VOjZdJ/162ECF2XsLVdlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TupZkvCgcny//xDAXgEVB3qEIQ2JT1ydf3JKsPuhtvU=;
 b=Sb4i3FBASz9TIlskciVmkS6f2/Dm+SUuJvcJpUbWGPMLuwJN8d75X2P6B3H9V0JRECP6OWl3VcihEvOI8SO8o81XlLmU5mUzDI2ev+2aquxPBuC2ivJd23jMeNP6s93H7mlo66FKV3RZ1jAJzVNLXAeFUdkvCljze7ATQ2ue/X9T7Sj4vR27wBA1VuQwNUlFpH+wUWj9UXcqopzdqFpBqUJ4KPeclw6t25OkXFtCeR8pLBQlsBXDD8qAmC+0yyU8AVgJQXvtn634VrW7+zkKMlrBkxQYGscIuK3ks+HQNW1vVO+/YiBzQkq6dXaFS3wn1FqaZR+d+2goVVPG4jdzAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TupZkvCgcny//xDAXgEVB3qEIQ2JT1ydf3JKsPuhtvU=;
 b=qTYIFvyhji68oCgiTWFV64e01Vk0ML0MKzhrp797ew7GP/7bc6MrYB57aK9eBxzvD+YU9Noke+4J1iuPy/1NGUdztOlziCY2UJU75t6cvLYE6WFvgPLlOE2LaVQlQUQfOYUPAR43rTB8jENBgjQr3OO0jDuLi//2Npx2Vp8eY5s=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4092.eurprd04.prod.outlook.com (2603:10a6:5:27::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.28; Tue, 11 May
 2021 01:14:12 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 01:14:12 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "marex@denx.de" <marex@denx.de>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
        "aford173@gmail.com" <aford173@gmail.com>
Subject: RE: [PATCH V4 4/4] soc: imx: Add blk-ctl driver for i.MX8MM
Thread-Topic: [PATCH V4 4/4] soc: imx: Add blk-ctl driver for i.MX8MM
Thread-Index: AQHXRU134jm/FqpaL06N/5HWMg6916rceJSAgAECR2A=
Date:   Tue, 11 May 2021 01:14:11 +0000
Message-ID: <DB6PR0402MB27601005EFA105AB35CAD85488539@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20210510040704.14997-1-peng.fan@oss.nxp.com>
 <20210510040704.14997-5-peng.fan@oss.nxp.com>
 <20210510094813.vye2yjdspuqkiocd@fsr-ub1664-175>
In-Reply-To: <20210510094813.vye2yjdspuqkiocd@fsr-ub1664-175>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c0b3caf-450e-4076-376d-08d9141a1609
x-ms-traffictypediagnostic: DB7PR04MB4092:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB4092AA9E62EAE4ABBDD0B56F88539@DB7PR04MB4092.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8KKYLPBRLpN0UoZ1w9nOnfKa1kbzV2ZhjOYzhcH58imoubzQp2DnLHkldNyoWzYI+lEm5nRy8zYTQ9H6iON5jgHzmWfBDAKfamvALHCbtf8jKsMC/EYscrxNiKbu0pS0UfxAtiBDqVjOXhLsNqIKBrY3LWRPgE3CnnLwiLJhm84WvJwbEy0f5IGyJ/JL4eJ6jSv3y15lIRGIBmM2oCyN5XBP5GnTcix8T/wdbcngFzm/I6l4tMwoSIvcAwWdgpOGB55NMD6c8hUiH2d320BPOR4OPFdR5YFqocMrhKSV71/Zr6/OQaqKy0IaNcu6KNqmJHvnwJ8MmfzCy0pbBLl38FScWUnbwMiPbFDHZ/ruCYP8df5CJ8FrpxrQNsAkqsjPYMwOJP9x70YQTNvUlbWBLx9CjAKuVy9/gART1VxLSZAthtOP7ktzwC6OnngnU/ppKoeRUr6YbKmumda0nu4DTo1d6LlnlRDB3mTAMi2/cJALhJoQQLSDDvtBFzezOYpLnM1lRV5MfaYygMEEvEzFDOhEzsdQn8GxT1Aam89YEYXzk/pbSaL/qofIWsDWGKQKm/B0bVNIdXqdl121i8FFv419asIYTm4C0sjY/iO6Pyg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(5660300002)(53546011)(66946007)(86362001)(478600001)(64756008)(66556008)(186003)(66476007)(52536014)(6506007)(33656002)(2906002)(55016002)(7696005)(66446008)(71200400001)(8936002)(38100700002)(316002)(54906003)(26005)(122000001)(83380400001)(44832011)(110136005)(9686003)(8676002)(7416002)(4326008)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?n0IEmEeD0qMfs5C28ZPFqB+gjJNlWuyETwU3hXKJTvsQW3HJNMpPHFNUVKDI?=
 =?us-ascii?Q?g8zZOREkO2xaglqM2hXfs8QRiH8hfFV64Hem+ZO6JVxYoki+Gabzu6q29KUZ?=
 =?us-ascii?Q?AvUdOJO5FLiuTs3W6ze7SOTolWdK9Tth6zmj0e8wCnAk6iJIziRJhu+GxBZ4?=
 =?us-ascii?Q?s9fbSeAdHSJ5Tkt7xJtvZIz7T1OpPBbwTBVAuhG1cwD6XVjBfv39WW8ys30Q?=
 =?us-ascii?Q?y3qWW8ULxEgVDbTqiFH38l4tq4RwkbRM2gQPGdBxuijYBlRomwx4CvBLAFrn?=
 =?us-ascii?Q?wzqX+zoNWTv6g1HvcOuwkds84WWthncRh2sfSk2VzGBXQwWYtuojPGQj0gTS?=
 =?us-ascii?Q?ByrLRX6RF+eekldj8i5axNuCTyl5na1wRmtDvUhuXR6gK5XxNzuQvA8Q48V6?=
 =?us-ascii?Q?5ygJEQmNyYJcg6H8MqVT/j4HTj45xK+25fdWH8EFygck/NHEdmBNFlqfytXE?=
 =?us-ascii?Q?/wr8g+2SBnR8H1Y9lKqcqS5ViGZ/DQliE+rOunDRrUoQ0aLKePuSGX26O9h1?=
 =?us-ascii?Q?cDA7v6TwB6oVR6hgYRaj9CeSluVRHe5+bPIonEmrcIkHDKDsyAv1iJpEHSUI?=
 =?us-ascii?Q?0qZ7jZ28Y22mjP9LW/YFn0LzIXe5158wdfkFxMfxCQXZet/w9R1nar9xTKia?=
 =?us-ascii?Q?fdoKbGZxx8Izyugoq6uZFplEyFOqT/5JpzQI61YRQ1itRdWA8wQOBoFJR39z?=
 =?us-ascii?Q?Irl4gqbw9uYiWv96CVJB3gScZKUnZFOTuBXqYH0L1J9C6jUkQtBn7g0zFzia?=
 =?us-ascii?Q?1GJS5zgNQn6x8LmIlR69Ee0eZJqW4/HYU6ir9PgObDMfShsOyw+UD9qbxEV9?=
 =?us-ascii?Q?QJjYZTWphEVza7ta+9HzaQlyVYOECNUSZZrGGGafcMPv4bZH4SFJAYiEZU4w?=
 =?us-ascii?Q?IabMAtiJQrSrynBVP/afDxXWMANX/fuX9WhUuqNpzd/1zDjTylErzSfObRwH?=
 =?us-ascii?Q?Ymc1j5rnJBCO39GBt8lePWqIgigiB2QBPIdSL+4F7eIsBj5F991rw5og1d5U?=
 =?us-ascii?Q?/89Qutpz/qS6zJgWfURns4Ptm9eLigLIZixaxodvE3ZDejgoJUJ9p67TVRfD?=
 =?us-ascii?Q?4e4jKNKFL+Ha7pO6Jtyyi10SIuHnJjdEPkK6Qx1ThdpUZ9hIr1j1nnN7n5s0?=
 =?us-ascii?Q?ae7b3pdghHQWO5z7dp8YD5O3bz+9SiYqOwsRx0o29wR1ghhz7kqmb9dSPyZW?=
 =?us-ascii?Q?jiGrvqpVMWraEQAIdTdQOOLnYmmN/H/Uts5dIkvfG8d4YxBMeeY80s1eq33i?=
 =?us-ascii?Q?8UzE/BHW8uwRBlqubNp0qxJaBrTv3wjEW7WKuUnFiq25YxwzhSBJLw7+QgIx?=
 =?us-ascii?Q?3Vw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0b3caf-450e-4076-376d-08d9141a1609
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 01:14:11.6315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UtxHIHX19JX+A73RRXhNXjfXJOt0yqkr7owwsl0c992dsSX9z/h83RF+TWLOdPMxLVf/cdSgGucNs6GRMH8yYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V4 4/4] soc: imx: Add blk-ctl driver for i.MX8MM
>=20
> On 21-05-10 12:07:04, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > The i.MX8MM SoC has dispmix BLK-CTL and vpumix BLK-CTL, so we add
> that
> > support in this driver.
> >
> > Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/soc/imx/Makefile         |   2 +-
> >  drivers/soc/imx/blk-ctl-imx8mm.c | 138
> > +++++++++++++++++++++++++++++++
> >  2 files changed, 139 insertions(+), 1 deletion(-)  create mode 100644
> > drivers/soc/imx/blk-ctl-imx8mm.c
> >
> > diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile index
> > d3d2b49a386c..c260b962f495 100644
> > --- a/drivers/soc/imx/Makefile
> > +++ b/drivers/soc/imx/Makefile
> > @@ -4,4 +4,4 @@ obj-$(CONFIG_ARCH_MXC) +=3D soc-imx.o  endif
> >  obj-$(CONFIG_HAVE_IMX_GPC) +=3D gpc.o
> >  obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) +=3D gpcv2.o
> > -obj-$(CONFIG_SOC_IMX8M) +=3D soc-imx8m.o blk-ctl.o
> > +obj-$(CONFIG_SOC_IMX8M) +=3D soc-imx8m.o blk-ctl.o blk-ctl-imx8mm.o
> > diff --git a/drivers/soc/imx/blk-ctl-imx8mm.c
> > b/drivers/soc/imx/blk-ctl-imx8mm.c
> > new file mode 100644
> > index 000000000000..5ca8d6c52917
> > --- /dev/null
> > +++ b/drivers/soc/imx/blk-ctl-imx8mm.c
> > @@ -0,0 +1,138 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2021 NXP
> > + */
> > +
> > +#include <dt-bindings/clock/imx8mm-clock.h>
> > +#include <dt-bindings/power/imx8mm-power.h>
> > +#include <linux/clk.h>
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +#include <linux/types.h>
> > +#include <linux/pm_domain.h>
> > +#include <linux/regmap.h>
> > +
> > +#include "blk-ctl.h"
> > +
> > +#define MEDIA_BLK_BUS_RSTN_BLK_SYNC_SFT_EN			BIT(6)
> > +#define MEDIA_BLK_MIPI_DSI_I_PRESETN_SFT_EN			BIT(5)
> > +#define MEDIA_BLK_MIPI_CSI_I_PRESETN_SFT_EN			BIT(4)
> > +#define MEDIA_BLK_CAMERA_PIXEL_RESET_N_SFT_EN
> 	BIT(3)
> > +#define MEDIA_BLK_CSI_BRIDGE_SFT_EN				GENMASK(2,
> 0)
> > +
> > +#define MEDIA_BLK_BUS_PD_MASK					BIT(12)
> > +#define MEDIA_BLK_MIPI_CSI_PD_MASK				GENMASK(11,
> 10)
> > +#define MEDIA_BLK_MIPI_DSI_PD_MASK				GENMASK(9,
> 8)
> > +#define MEDIA_BLK_LCDIF_PD_MASK					GENMASK(7,
> 6)
> > +#define MEDIA_BLK_CSI_BRIDGE_PD_MASK				GENMASK(5,
> 0)
> > +
> > +static struct imx_blk_ctl_hw imx8mm_dispmix_blk_ctl_pds[] =3D {
> > +	IMX_BLK_CTL_PD("CSI_BRIDGE", "dispmix",
> IMX8MM_BLK_CTL_PD_DISPMIX_CSI_BRIDGE, 0x4,
> > +		       MEDIA_BLK_CSI_BRIDGE_PD_MASK, 0,
> MEDIA_BLK_CSI_BRIDGE_SFT_EN,
> > +		       IMX_BLK_CTL_PD_RESET),
> > +	IMX_BLK_CTL_PD("LCDIF", "dispmix",
> IMX8MM_BLK_CTL_PD_DISPMIX_LCDIF, 0x4,
> > +		       MEDIA_BLK_LCDIF_PD_MASK, -1, -1, 0),
> > +	IMX_BLK_CTL_PD("MIPI_DSI", "mipi",
> IMX8MM_BLK_CTL_PD_DISPMIX_MIPI_DSI, 0x4,
> > +		       MEDIA_BLK_MIPI_DSI_PD_MASK, 0,
> MEDIA_BLK_MIPI_DSI_I_PRESETN_SFT_EN,
> > +		       IMX_BLK_CTL_PD_RESET),
> > +	IMX_BLK_CTL_PD("MIPI_CSI", "mipi",
> IMX8MM_BLK_CTL_PD_DISPMIX_MIPI_CSI, 0x4,
> > +		       MEDIA_BLK_MIPI_CSI_PD_MASK, 0,
> > +		       MEDIA_BLK_MIPI_CSI_I_PRESETN_SFT_EN |
> MEDIA_BLK_CAMERA_PIXEL_RESET_N_SFT_EN,
> > +		       IMX_BLK_CTL_PD_RESET)
> > +};
> > +
> > +static struct imx_blk_ctl_hw imx8mm_vpumix_blk_ctl_pds[] =3D {
> > +	IMX_BLK_CTL_PD("VPU_BLK_CTL_G2", "vpu-g2",
> IMX8MM_BLK_CTL_PD_VPU_G2, 0x4,
> > +		       BIT(0), 0, BIT(0), IMX_BLK_CTL_PD_RESET),
> > +	IMX_BLK_CTL_PD("VPU_BLK_CTL_G1", "vpu-g1",
> IMX8MM_BLK_CTL_PD_VPU_G1, 0x4,
> > +		       BIT(1), 0, BIT(1), IMX_BLK_CTL_PD_RESET),
> > +	IMX_BLK_CTL_PD("VPU_BLK_CTL_H1", "vpu-h1",
> IMX8MM_BLK_CTL_PD_VPU_H1, 0x4,
> > +		       BIT(2), 0, BIT(2), IMX_BLK_CTL_PD_HANDSHAKE |
> > +IMX_BLK_CTL_PD_RESET), };
> > +
> > +static const struct regmap_config imx8mm_blk_ctl_regmap_config =3D {
> > +	.reg_bits		=3D 32,
> > +	.reg_stride		=3D 4,
> > +	.val_bits		=3D 32,
> > +	.max_register		=3D 0x30,
> > +	.fast_io		=3D true,
> > +};
> > +
> > +static const struct imx_blk_ctl_dev_data
> imx8mm_vpumix_blk_ctl_dev_data =3D {
> > +	.pds =3D imx8mm_vpumix_blk_ctl_pds,
> > +	.pds_num =3D ARRAY_SIZE(imx8mm_vpumix_blk_ctl_pds),
> > +	.hw_hsk =3D IMX_BLK_CTL_PD(NULL, NULL,
> IMX8MM_BLK_CTL_PD_VPU_H1, 0x4, BIT(2), 0, BIT(2),
> > +				 IMX_BLK_CTL_PD_HANDSHAKE),
> > +	.config =3D imx8mm_blk_ctl_regmap_config,
> > +	.active_pd_names =3D (char*[]){"vpumix", "g1", "g2", "h1"},
> > +	.num_active_pd =3D 4,
> > +};
> > +
> > +static const struct imx_blk_ctl_dev_data
> imx8mm_dispmix_blk_ctl_dev_data =3D {
> > +	.pds =3D imx8mm_dispmix_blk_ctl_pds,
> > +	.pds_num =3D ARRAY_SIZE(imx8mm_dispmix_blk_ctl_pds),
> > +	.hw_hsk =3D IMX_BLK_CTL_PD(NULL, NULL, -1, 0x4,
> MEDIA_BLK_BUS_PD_MASK, 0,
> > +				 MEDIA_BLK_BUS_RSTN_BLK_SYNC_SFT_EN,
> > +				 IMX_BLK_CTL_PD_HANDSHAKE |
> IMX_BLK_CTL_PD_RESET),
> > +	.config =3D imx8mm_blk_ctl_regmap_config,
> > +	.active_pd_names =3D (char*[]){"dispmix", "mipi"},
> > +	.num_active_pd =3D 2,
> > +};
> > +
> > +static int imx8mm_blk_ctl_probe(struct platform_device *pdev) {
> > +	struct device *dev =3D &pdev->dev;
> > +	const struct imx_blk_ctl_dev_data *dev_data =3D
> of_device_get_match_data(dev);
> > +	struct regmap *regmap;
> > +	struct imx_blk_ctl *ctl;
> > +	void __iomem *base;
> > +
> > +	ctl =3D devm_kzalloc(dev, sizeof(*ctl), GFP_KERNEL);
> > +	if (!ctl)
> > +		return -ENOMEM;
> > +
> > +	base =3D devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(base))
> > +		return PTR_ERR(base);
> > +
> > +	regmap =3D devm_regmap_init_mmio(dev, base, &dev_data->config);
> > +	if (IS_ERR(regmap))
> > +		return PTR_ERR(regmap);
> > +
> > +	ctl->regmap =3D regmap;
> > +	ctl->dev =3D dev;
> > +	ctl->power_count =3D 0;
> > +	mutex_init(&ctl->lock);
> > +
> > +	ctl->num_clks =3D devm_clk_bulk_get_all(dev, &ctl->clks);
> > +	if (ctl->num_clks < 0)
> > +		return ctl->num_clks;
> > +
> > +	dev_set_drvdata(dev, ctl);
> > +	ctl->dev_data =3D dev_data;
> > +
> > +	return imx_blk_ctl_register(dev);
> > +}
>=20
> Nitpick:
>=20
> Pretty sure all the other platforms will have a similar probe function.
> So maybe we can move this into the generic and call it imx8_blk_ctl_regis=
ter
> and pass on the PDs, dev data and regmap_config.
>=20
> We could also do this later on when i.MX8MP variant will be done.

Let me do this later, I have started i.MX8MP part, and will use a generic
probe function.

Thanks,
Peng.

>=20
> > +
> > +static const struct of_device_id imx_blk_ctl_of_match[] =3D {
> > +	{ .compatible =3D "fsl,imx8mm-vpumix-blk-ctl", .data =3D
> &imx8mm_vpumix_blk_ctl_dev_data },
> > +	{ .compatible =3D "fsl,imx8mm-dispmix-blk-ctl", .data =3D
> &imx8mm_dispmix_blk_ctl_dev_data },
> > +	{ /* Sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, imx_blk_ctl_of_match);
> > +
> > +static struct platform_driver imx_blk_ctl_driver =3D {
> > +	.probe =3D imx8mm_blk_ctl_probe,
> > +	.driver =3D {
> > +		.name =3D "imx8mm-blk-ctl",
> > +		.of_match_table =3D of_match_ptr(imx_blk_ctl_of_match),
> > +		.pm =3D &imx_blk_ctl_pm_ops,
> > +	},
> > +};
> > +module_platform_driver(imx_blk_ctl_driver);
> > --
> > 2.30.0
> >
