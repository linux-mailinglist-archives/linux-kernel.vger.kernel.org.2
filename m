Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5D393A4ECC
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 14:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbhFLMhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 08:37:24 -0400
Received: from mail-eopbgr30046.outbound.protection.outlook.com ([40.107.3.46]:13878
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231400AbhFLMhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 08:37:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=muGSUSMK78gtSBEXs9G8yQ4o/NzKFQK9WhO93vAvA9jctq0JVev+7VxB9tSv0U3e9R2A/NiGNeN8dxxJjG9O44dh/tYvVniGj8WuSG7y9b5+Sf+3Br9aYritHTLtcIuzuaiIQsjWIOrx2NVZeffQY2V8per78qMELPy/tR+f1EhXlIi0pfQMG7KE/WcSsTL/rXF4yB7O5oXpHFhczPWlEAEwRGHJO/zqVnAuttAIhPjLPJYWmPt3zbYFrnxZ16uVXoKyvdc5vaCL00aRc3QXNEvMYsy4eLiVw/JQaVGYuA/Y3Y5/770gsGlaESZQVUJQZPcqNTDuM0P01QxaEmPMTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1pKeEtqK3wgbdDsdyFTmzvpWgHJ8pIFkIaVYHHK3R8=;
 b=eNuqRkGiljgA79xNET4wyAYlxSCYc48BF3nWUVDrPjIyccd3z2BaVD/PeL4VKZE+T3vdlK1/NmOSbjIn2O2mvNo7zIlwjmwu400qH6FDXK8zJ+vLTErkXQhYlx4hqWT3tRRzoauQvrGrlI/Z5jiz4JI6z8bWvGcsq9ZGXNawyLlPxChw4ln/8F6GhlmTmJdU+cUpCpA0s/1eJWQfJY+zoFreTn3QsbddDxcKGmMMghoVJtyNij+wI3j12GyAKAN1uijYXHFwyUGl53Hlg/RcyTh9HPvI7BaifGxd0qCfcugxOKsIS0zp6Q1iyaiJgNhXYSgY0ZO/05u8Mat6wF1B2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1pKeEtqK3wgbdDsdyFTmzvpWgHJ8pIFkIaVYHHK3R8=;
 b=CEC9AHcogxc5M/RXGLE5bE8o57AYO4MNha4eyMksSAcJ0HKpOzSWzrNcWQwFLvAypHurpA2V2xefhsVH6wJV41ehXaBkAAZUECmM1U64NeHqBr0nEmvqMoD0Q17M9pQtT//15e7nbtFEkn2qr4YlodkUlbVb4JDFvWzwPJrtkvc=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4939.eurprd04.prod.outlook.com (2603:10a6:10:20::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.29; Sat, 12 Jun
 2021 12:35:20 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4219.022; Sat, 12 Jun 2021
 12:35:20 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
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
        "aford173@gmail.com" <aford173@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: RE: [PATCH V6 3/4] soc: imx: Add generic blk-ctl driver
Thread-Topic: [PATCH V6 3/4] soc: imx: Add generic blk-ctl driver
Thread-Index: AQHXTwvXz3ml5KS/WU2bIQjwsz4ceKsPshmAgAC6ZxA=
Date:   Sat, 12 Jun 2021 12:35:19 +0000
Message-ID: <DB6PR0402MB276077D04FAC90D4EBE760B188339@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20210522134249.15322-1-peng.fan@oss.nxp.com>
 <20210522134249.15322-4-peng.fan@oss.nxp.com> <20210612011304.GD29138@dragon>
In-Reply-To: <20210612011304.GD29138@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72ec9fc7-c5bd-4d18-54b9-08d92d9e8a75
x-ms-traffictypediagnostic: DB7PR04MB4939:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB49394BA36F7EE5ABD90CC950C9339@DB7PR04MB4939.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i3myQHDRQ/2WA13EQbjafqppCWSCVlEKaru16Zk65AAjKO1d/ot3WT+0kVzDTEacLJ+f0lsAxarBjT4wN4dqydGB6YcdcuqLvhwRRQeS7GUnZDaAfTL/SLdPU2dtHoCJQiWXACeJwCTvzABUiIh2HJoUi2qV5VwXY/jRJyrKQGpTJUouOfSwg2KiWCQ+cJG2n2bDaURvcL3o6ThYW8PT0cfakKQfDn1jbZ//iv2keaW0SaacyX2g/UFnPrPzOnCVLjza3UgOr8nBS7kChvdkaB5lVfbA3TKzifnhsOSp9s+sim5NnJPB2OJ7erzUhCF3CKJW3+v2Tj0ktOKXXz6IhnCQtn2FJ9gHgppOq+F51Y1slDL4DWdaBZvPcld9g6ecP2wZEFUtAS9F360yQy5dg1zF4Q6kDisimdUBD4aH5Tg0EWtFLMXmFEsdu/o5sWeiO0CCeAZymET33lfOFmb4rTfsNIvSXdxqSjxKyq/aMAX7cWw2t9+kdxwQ37bnNqc9jBjcUdXMoZz3heNsuL4gi1m++j1WvZlI53RcJBPfMZKK/tYYDef892mNNCJRZo6cZcZ+uURz+g1VnPqJ622EHj9sha7XCGhi33pRzFvV9bfHHXtj9EkyuN/ThRYxW/3BkqNskXWiQW3yD7mSx0zssA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(39830400003)(366004)(346002)(83380400001)(186003)(55016002)(122000001)(478600001)(6506007)(9686003)(38100700002)(26005)(66556008)(66946007)(86362001)(2906002)(33656002)(7696005)(54906003)(71200400001)(52536014)(5660300002)(30864003)(4326008)(64756008)(7416002)(66446008)(110136005)(66476007)(316002)(8676002)(8936002)(76116006)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EgeSpumdYDd2wawe56dglCF7lVQDKHXMyhv7JQrjccb/3finNAcgFQK0BOt9?=
 =?us-ascii?Q?UuHb137LX/mKGiJ4iFby6CCAHtfMiAQnEDXK+4mNaoErBvVEOZKS1mz8pawC?=
 =?us-ascii?Q?JPiq59vUEhFyT3xzH4SbHnptgx+8sY84Qu7T9rJdBqPy+gPz2jKOMSjiMjzC?=
 =?us-ascii?Q?9mU4YXguwLhgzElh6I1RjCHWE220xraJ8UL/MOQ1T7z7W7nbaw/e16f7R6Fa?=
 =?us-ascii?Q?QIbcsSB2r7XI745CCn0k0dGV+px3ojVZnDcX6v3N0d+Rp36u4xz3Ges7qjQL?=
 =?us-ascii?Q?gklcGCN31N88s4Jxxb6dK+ZyKL62llj+vg6miv1k8lttUrzHjeSfxoSeTvN0?=
 =?us-ascii?Q?myYrMBjPBqsjl6fdJhEFoytmphYePK1K+twgfYf3fA3ckOVk54CDIrIKiWDq?=
 =?us-ascii?Q?PhY+inZe8dKXbwxq54X8CxnutXbyR0o09j3SmuQORVwEShf/HDq9pkkd6tKf?=
 =?us-ascii?Q?T/pmt20hN47c9ojQ8oDurcd5iwOaf9L+BzaS8kZ30Hc7rS4Q80OBgTbyLHho?=
 =?us-ascii?Q?riULAZlMw4gR6PlltpCVEeqrBFEJu6khVP/+wTL9rHGaVFoDWeCVv5zXl9ZR?=
 =?us-ascii?Q?FAHkYn9lRmWTFnu3uJcDfz7287xNToHlQry9NwiZKSGeWge1LALodLWIHYi9?=
 =?us-ascii?Q?A1TfaU5ZFOj4Hgf7EpNQDCx+PaWOEFwfd2enLbv8/BGeFcLtC2raYn6Aifr0?=
 =?us-ascii?Q?hzF07KgHXlXuFgrM9nOUwR6icuMoUIJrcSc4YQK2PlVOTTUymmlphyBYy9WZ?=
 =?us-ascii?Q?eqrQTdFGTL0P0ZVpzZ9r1Jjbs/Qtw/xo/FgecSyaNM+nDR8Tx+xh/diDCspt?=
 =?us-ascii?Q?WVKPIlnh+ZgMZPsChZRcuNuZHy1BwiNCZG8vA20XcskZz4pVFuXhSRrq1US/?=
 =?us-ascii?Q?wp/mH5eacJc1zbaIrJohbGjnQFFmFEyzSzJ+vWtMl52LuHp57B4UTi/hD0SS?=
 =?us-ascii?Q?nYSkVx1/wgLrsCAFAKa4JKRqyi2HhMB7824hyNHcy6LQp0uh5+8l+kfY2lxp?=
 =?us-ascii?Q?HgrMmUp8PhjypbfMsXM61nWwBe9A2iP/btvsAAHAIxd6MDjnzHYXabnsa++d?=
 =?us-ascii?Q?39+NhlqtN5dcDyX3ZxPwl5jXCx3LHZCJX98JErkphPhWz6JuN+HNiXZlRE5f?=
 =?us-ascii?Q?UDuTU0TSQa2wkmLWkMDUqjT+n/zVcqP5ODEB2qg/C5TCAFkUs17eK2QBodLK?=
 =?us-ascii?Q?HuLeksVqP7tGQV0wEv14pbM0hrb+35q9bOObot92aohYlx9J9GnY6C8TS4wy?=
 =?us-ascii?Q?Y1eE/dqwNcJkPktRBHlMr5GzCFXt5W94Ayj4fbUmaQX/YHamjlC/Rhvpxqlq?=
 =?us-ascii?Q?Rp88ECJdhkFaQ+j1nUgGsUgG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ec9fc7-c5bd-4d18-54b9-08d92d9e8a75
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2021 12:35:19.9054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pr6dMecyPHlpIUhj9IPuh+aB0SqjdUEyi0L46Za6wiW/6ICgteSkODYhfR4w0F17TXhCIwJFAVIEM5RnO5xJUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4939
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V6 3/4] soc: imx: Add generic blk-ctl driver
>=20
> On Sat, May 22, 2021 at 09:42:48PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > The i.MX8MM introduces an IP named BLK_CTL and usually is comprised of
> > some GPRs.
> >
> > The GPRs has some clock bits and reset bits, but here we take it as
> > virtual PDs, because of the clock and power domain A/B lock issue when
> > taking it as a clock controller.
> >
> > For some bits, it might be good to also make it as a reset controller,
> > but to i.MX8MM, we not add that support for now.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
>=20
> I would like to see some Reviewed-by tags.

ok

>=20
> > ---
> >  drivers/soc/imx/Makefile  |   2 +-
> >  drivers/soc/imx/blk-ctl.c | 334
> > ++++++++++++++++++++++++++++++++++++++
> >  drivers/soc/imx/blk-ctl.h |  85 ++++++++++
> >  3 files changed, 420 insertions(+), 1 deletion(-)  create mode 100644
> > drivers/soc/imx/blk-ctl.c  create mode 100644
> > drivers/soc/imx/blk-ctl.h
> >
> > diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile index
> > 078dc918f4f3..d3d2b49a386c 100644
> > --- a/drivers/soc/imx/Makefile
> > +++ b/drivers/soc/imx/Makefile
> > @@ -4,4 +4,4 @@ obj-$(CONFIG_ARCH_MXC) +=3D soc-imx.o  endif
> >  obj-$(CONFIG_HAVE_IMX_GPC) +=3D gpc.o
> >  obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) +=3D gpcv2.o
> > -obj-$(CONFIG_SOC_IMX8M) +=3D soc-imx8m.o
> > +obj-$(CONFIG_SOC_IMX8M) +=3D soc-imx8m.o blk-ctl.o
>=20
> As it's a generic blk-ctl driver, should we have a dedicated Kconfig opti=
on for
> it?

I think no need a dedicated Kconfig option, It is almost a must have
driver for i.MX8M.

>=20
> > diff --git a/drivers/soc/imx/blk-ctl.c b/drivers/soc/imx/blk-ctl.c new
> > file mode 100644 index 000000000000..8e286b8ef1b3
> > --- /dev/null
> > +++ b/drivers/soc/imx/blk-ctl.c
> > @@ -0,0 +1,334 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2021 NXP.
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/completion.h>
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/regmap.h>
> > +#include <linux/slab.h>
> > +#include <linux/string.h>
> > +#include <linux/types.h>
> > +#include <linux/pm_domain.h>
> > +#include <linux/reset-controller.h>
>=20
> Some of the includes are out of alphabetic order.  Also please check if y=
ou
> need all of these headers.

Fix in V7.

>=20
> > +
> > +#include "blk-ctl.h"
> > +
> > +static inline struct imx_blk_ctl_domain *to_imx_blk_ctl_pd(struct
> > +generic_pm_domain *genpd)
>=20
> Did you run checkpatch on it?  Isn't this line beyond 80 column?

Yes. I ran, kernel new rule has been 100 column as I know.

>=20
> > +{
> > +	return container_of(genpd, struct imx_blk_ctl_domain, genpd); }
> > +
> > +static int imx_blk_ctl_enable_hsk(struct device *dev) {
> > +	struct imx_blk_ctl *blk_ctl =3D dev_get_drvdata(dev);
> > +	const struct imx_blk_ctl_hw *hw =3D blk_ctl->dev_data->hw_hsk;
> > +	struct regmap *regmap =3D blk_ctl->regmap;
> > +	int ret;
> > +
> > +	if (hw->flags & IMX_BLK_CTL_PD_RESET) {
> > +		ret =3D regmap_update_bits(regmap, hw->rst_offset, hw->rst_mask,
> hw->rst_mask);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	ret =3D regmap_update_bits(regmap, hw->offset, hw->mask, hw->mask);
> > +
> > +	/* Wait for handshake */
> > +	udelay(5);
> > +
> > +	return ret;
> > +}
> > +
> > +int imx_blk_ctl_power_on(struct generic_pm_domain *domain)
>=20
> static?

Fix in v7.

>=20
> > +{
> > +	struct imx_blk_ctl_domain *pd =3D to_imx_blk_ctl_pd(domain);
> > +	struct imx_blk_ctl *blk_ctl =3D pd->blk_ctl;
> > +	struct regmap *regmap =3D blk_ctl->regmap;
> > +	const struct imx_blk_ctl_hw *hw =3D &blk_ctl->dev_data->pds[pd->id];
> > +	int ret;
> > +
> > +	mutex_lock(&blk_ctl->lock);
> > +
> > +	ret =3D clk_bulk_prepare_enable(blk_ctl->num_clks, blk_ctl->clks);
> > +	if (ret) {
> > +		mutex_unlock(&blk_ctl->lock);
> > +		return ret;
> > +	}
> > +
> > +	if (hw->flags & IMX_BLK_CTL_PD_HANDSHAKE) {
> > +		ret =3D imx_blk_ctl_enable_hsk(blk_ctl->dev);
> > +		if (ret)
> > +			dev_err(blk_ctl->dev, "Hankshake failed when power on\n");
> > +
> > +		goto disable_clk;
>=20
> Goto disable_clk regardless of the ret check?

Oh, this was introduced in v6, fix in V7.

>=20
> > +	}
> > +
> > +	if (hw->flags & IMX_BLK_CTL_PD_RESET) {
> > +		ret =3D regmap_clear_bits(regmap, hw->rst_offset, hw->rst_mask);
> > +		if (ret)
> > +			goto disable_clk;
> > +	}
> > +
> > +	/* Wait for reset propagate */
> > +	udelay(5);
>=20
> The delay will be there even when IMX_BLK_CTL_PD_RESET is not set.

Fix in V7.

>=20
> > +
> > +	if (hw->flags & IMX_BLK_CTL_PD_RESET) {
> > +		ret =3D regmap_update_bits(regmap, hw->rst_offset, hw->rst_mask,
> hw->rst_mask);
> > +		if (ret)
> > +			goto disable_clk;
> > +	}
> > +
> > +	ret =3D regmap_update_bits(regmap, hw->offset, hw->mask, hw->mask);
> > +	if (ret)
> > +		goto disable_clk;
>=20
> Useless goto.

Fix in V7.

>=20
> > +
> > +disable_clk:
> > +	clk_bulk_disable_unprepare(blk_ctl->num_clks, blk_ctl->clks);
> > +
> > +	mutex_unlock(&blk_ctl->lock);
> > +
> > +	return ret;
> > +}
> > +
> > +int imx_blk_ctl_power_off(struct generic_pm_domain *domain) {
> > +	struct imx_blk_ctl_domain *pd =3D to_imx_blk_ctl_pd(domain);
> > +	struct imx_blk_ctl *blk_ctl =3D pd->blk_ctl;
> > +	struct regmap *regmap =3D blk_ctl->regmap;
> > +	const struct imx_blk_ctl_hw *hw =3D &blk_ctl->dev_data->pds[pd->id];
> > +	int ret;
> > +
> > +	mutex_lock(&blk_ctl->lock);
> > +
> > +	ret =3D clk_bulk_prepare_enable(blk_ctl->num_clks, blk_ctl->clks);
> > +	if (ret) {
> > +		mutex_unlock(&blk_ctl->lock);
> > +		return ret;
> > +	}
> > +
> > +	if (!(hw->flags & IMX_BLK_CTL_PD_HANDSHAKE)) {
> > +		ret =3D regmap_clear_bits(regmap, hw->offset, hw->mask);
> > +		if (ret)
> > +			goto hsk_fail;
> > +
> > +		if (hw->flags & IMX_BLK_CTL_PD_RESET) {
> > +			ret =3D regmap_clear_bits(regmap, hw->rst_offset,
> hw->rst_mask);
> > +			if (ret)
> > +				goto hsk_fail;
> > +		}
> > +	}
> > +
> > +	if (hw->flags & IMX_BLK_CTL_PD_HANDSHAKE) {
> > +		ret =3D imx_blk_ctl_enable_hsk(blk_ctl->dev);
> > +		if (ret)
> > +			dev_err(blk_ctl->dev, "Hankshake failed when power off\n");
> > +	}
> > +
> > +hsk_fail:
>=20
> You use disable_clk in above function for the same code.  Inconsistent
> labeling strategy.

Fix in V7.

>=20
> > +	clk_bulk_disable_unprepare(blk_ctl->num_clks, blk_ctl->clks);
> > +
> > +	mutex_unlock(&blk_ctl->lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static int imx_blk_ctl_probe(struct platform_device *pdev) {
> > +	struct imx_blk_ctl_domain *domain =3D pdev->dev.platform_data;
> > +	struct imx_blk_ctl *blk_ctl =3D domain->blk_ctl;
> > +	struct generic_pm_domain *parent_genpd;
> > +	struct device *dev =3D &pdev->dev;
> > +	struct device *active_pd;
> > +	int ret;
> > +
> > +	pdev->dev.of_node =3D blk_ctl->dev->of_node;
>=20
> Have a newline.

Fix in V7.

>=20
> > +	if (domain->hw->active_pd_name) {
> > +		active_pd =3D dev_pm_domain_attach_by_name(dev,
> domain->hw->active_pd_name);
> > +		if (IS_ERR_OR_NULL(active_pd)) {
> > +			ret =3D PTR_ERR(active_pd) ? : -ENODATA;
> > +			pdev->dev.of_node =3D NULL;
>=20
> Why is this necessary?

This is to avoid blk-ctl match with is parent's device driver, if
it use same dt node.

>=20
> > +			return ret;
> > +		}
>=20
> Have a newline.
>=20
> > +		domain->active_pd =3D active_pd;
> > +	} else {
> > +		if (!blk_ctl->bus_domain) {
> > +			pdev->dev.of_node =3D NULL;
> > +			return -EPROBE_DEFER;
> > +		}
> > +	}
> > +
> > +	if (domain->hw->active_pd_name)
> > +		parent_genpd =3D pd_to_genpd(active_pd->pm_domain);
> > +	else
> > +		parent_genpd =3D blk_ctl->bus_domain;
> > +
> > +	if (pm_genpd_add_subdomain(parent_genpd, &domain->genpd)) {
> > +		pr_warn("failed to add subdomain: %s\n", domain->genpd.name);
>=20
> dev_warn()?
>=20
> > +	} else {
> > +		mutex_lock(&blk_ctl->lock);
> > +		domain->hooked =3D true;
> > +		mutex_unlock(&blk_ctl->lock);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int imx_blk_ctl_remove(struct platform_device *pdev) {
> > +	struct imx_blk_ctl_domain *domain =3D pdev->dev.platform_data;
> > +	struct imx_blk_ctl *blk_ctl =3D domain->blk_ctl;
> > +	struct generic_pm_domain *parent_genpd;
> > +	struct device *active_pd;
> > +
> > +	pdev->dev.of_node =3D blk_ctl->dev->of_node;
>=20
> Why is this needed for .remove?
Fix in v7.
>=20
> I stop right here.  The patch really needs some level cross reviewing.

ok, we are almost done in V5, but have to introduce a new design in V6.
I'll try to invite someone to help review.

Thanks,
Peng.

>=20
> Shawn
>=20
> > +	if (domain->hw->active_pd_name)
> > +		parent_genpd =3D pd_to_genpd(active_pd->pm_domain);
> > +	else
> > +		parent_genpd =3D blk_ctl->bus_domain;
> > +
> > +	pm_genpd_remove_subdomain(parent_genpd, &domain->genpd);
> > +
> > +	mutex_lock(&blk_ctl->lock);
> > +	domain->hooked =3D false;
> > +	mutex_unlock(&blk_ctl->lock);
> > +
> > +	if (domain->hw->active_pd_name)
> > +		dev_pm_domain_detach(domain->active_pd, false);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct platform_device_id imx_blk_ctl_id[] =3D {
> > +	{ "imx-vpumix-blk-ctl", },
> > +	{ "imx-dispmix-blk-ctl", },
> > +	{ },
> > +};
> > +
> > +static struct platform_driver imx_blk_ctl_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "imx-blk-ctl",
> > +	},
> > +	.probe    =3D imx_blk_ctl_probe,
> > +	.remove   =3D imx_blk_ctl_remove,
> > +	.id_table =3D imx_blk_ctl_id,
> > +};
> > +builtin_platform_driver(imx_blk_ctl_driver)
> > +
> > +static struct generic_pm_domain *imx_blk_ctl_genpd_xlate(struct
> of_phandle_args *genpdspec,
> > +							 void *data)
> > +{
> > +	struct genpd_onecell_data *genpd_data =3D data;
> > +	unsigned int idx =3D genpdspec->args[0];
> > +	struct imx_blk_ctl_domain *domain;
> > +	struct generic_pm_domain *genpd =3D ERR_PTR(-EPROBE_DEFER);
> > +
> > +	if (genpdspec->args_count !=3D 1)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	if (idx >=3D genpd_data->num_domains) {
> > +		pr_err("%s: invalid domain index %u\n", __func__, idx);
> > +		return ERR_PTR(-EINVAL);
> > +	}
> > +
> > +	if (!genpd_data->domains[idx])
> > +		return ERR_PTR(-ENOENT);
> > +
> > +	domain =3D to_imx_blk_ctl_pd(genpd_data->domains[idx]);
> > +	mutex_lock(&domain->blk_ctl->lock);
> > +	if (domain->hooked)
> > +		genpd =3D genpd_data->domains[idx];
> > +	mutex_unlock(&domain->blk_ctl->lock);
> > +
> > +	return genpd;
> > +}
> > +
> > +int imx_blk_ctl_register(struct device *dev) {
> > +	struct imx_blk_ctl *blk_ctl =3D dev_get_drvdata(dev);
> > +	const struct imx_blk_ctl_dev_data *dev_data =3D blk_ctl->dev_data;
> > +	int num =3D dev_data->pds_num;
> > +	struct imx_blk_ctl_domain *domain;
> > +	struct generic_pm_domain *genpd;
> > +	struct platform_device *pd_pdev;
> > +	int domain_index;
> > +	int i, ret;
> > +
> > +	blk_ctl->onecell_data.num_domains =3D num;
> > +	blk_ctl->onecell_data.xlate =3D imx_blk_ctl_genpd_xlate;
> > +	blk_ctl->onecell_data.domains =3D devm_kcalloc(dev, num, sizeof(struc=
t
> generic_pm_domain *),
> > +						     GFP_KERNEL);
> > +	if (!blk_ctl->onecell_data.domains)
> > +		return -ENOMEM;
> > +
> > +	for (i =3D 0; i < num; i++) {
> > +		domain_index =3D dev_data->pds[i].id;
> > +		if (domain_index >=3D num) {
> > +			dev_warn(dev, "Domain index %d is out of bounds\n",
> domain_index);
> > +			continue;
> > +		}
> > +
> > +		domain =3D devm_kzalloc(dev, sizeof(struct imx_blk_ctl_domain),
> GFP_KERNEL);
> > +		if (!domain)
> > +			goto error;
> > +
> > +		pd_pdev =3D platform_device_alloc(dev_data->name, domain_index);
> > +		if (!pd_pdev) {
> > +			dev_err(dev, "Failed to allocate platform device\n");
> > +			goto error;
> > +		}
> > +
> > +		pd_pdev->dev.platform_data =3D domain;
> > +
> > +		domain->blk_ctl =3D blk_ctl;
> > +		domain->hw =3D &dev_data->pds[i];
> > +		domain->id =3D domain_index;
> > +		domain->genpd.name =3D dev_data->pds[i].name;
> > +		domain->genpd.power_off =3D imx_blk_ctl_power_off;
> > +		domain->genpd.power_on =3D imx_blk_ctl_power_on;
> > +		domain->dev =3D &pd_pdev->dev;
> > +		domain->hooked =3D false;
> > +
> > +		ret =3D pm_genpd_init(&domain->genpd, NULL, true);
> > +		pd_pdev->dev.parent =3D dev;
> > +
> > +		if (domain->hw->flags & IMX_BLK_CTL_PD_HANDSHAKE)
> > +			blk_ctl->bus_domain =3D &domain->genpd;
> > +
> > +		ret =3D platform_device_add(pd_pdev);
> > +		if (ret) {
> > +			platform_device_put(pd_pdev);
> > +			goto error;
> > +		}
> > +		blk_ctl->onecell_data.domains[i] =3D &domain->genpd;
> > +	}
> > +
> > +	return of_genpd_add_provider_onecell(dev->of_node,
> > +&blk_ctl->onecell_data);
> > +
> > +error:
> > +	for (; i >=3D 0; i--) {
> > +		genpd =3D blk_ctl->onecell_data.domains[i];
> > +		if (!genpd)
> > +			continue;
> > +		domain =3D to_imx_blk_ctl_pd(genpd);
> > +		if (domain->dev)
> > +			platform_device_put(to_platform_device(domain->dev));
> > +	}
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(imx_blk_ctl_register);
> > +
> > +const struct dev_pm_ops imx_blk_ctl_pm_ops =3D {
> > +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> > +			   pm_runtime_force_resume)
> > +};
> > +EXPORT_SYMBOL_GPL(imx_blk_ctl_pm_ops);
> > diff --git a/drivers/soc/imx/blk-ctl.h b/drivers/soc/imx/blk-ctl.h new
> > file mode 100644 index 000000000000..6780d00ec8c5
> > --- /dev/null
> > +++ b/drivers/soc/imx/blk-ctl.h
> > @@ -0,0 +1,85 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */ #ifndef __SOC_IMX_BLK_CTL_H
> > +#define __SOC_IMX_BLK_CTL_H
> > +
> > +enum imx_blk_ctl_pd_type {
> > +	BLK_CTL_PD,
> > +};
> > +
> > +struct imx_blk_ctl_hw {
> > +	int type;
> > +	char *name;
> > +	char *active_pd_name;
> > +	u32 offset;
> > +	u32 mask;
> > +	u32 flags;
> > +	u32 id;
> > +	u32 rst_offset;
> > +	u32 rst_mask;
> > +	u32 errata;
> > +};
> > +
> > +struct imx_blk_ctl_domain {
> > +	struct generic_pm_domain genpd;
> > +	struct device *active_pd;
> > +	struct imx_blk_ctl *blk_ctl;
> > +	struct imx_blk_ctl_hw *hw;
> > +	struct device *dev;
> > +	bool hooked;
> > +	u32 id;
> > +};
> > +
> > +struct imx_blk_ctl_dev_data {
> > +	struct regmap_config config;
> > +	struct imx_blk_ctl_hw *pds;
> > +	struct imx_blk_ctl_hw *hw_hsk;
> > +	u32 pds_num;
> > +	u32 max_num;
> > +	char *name;
> > +};
> > +
> > +struct imx_blk_ctl {
> > +	struct device *dev;
> > +	struct regmap *regmap;
> > +	struct genpd_onecell_data onecell_data;
> > +	const struct imx_blk_ctl_dev_data *dev_data;
> > +	struct clk_bulk_data *clks;
> > +	u32 num_clks;
> > +	struct generic_pm_domain *bus_domain;
> > +
> > +	struct mutex lock;
> > +};
> > +
> > +#define IMX_BLK_CTL(_type, _name, _active_pd, _id, _offset, _mask,
> _rst_offset, _rst_mask,	\
> > +		    _flags, _errata)								\
> > +	{											\
> > +		.type =3D _type,									\
> > +		.name =3D _name,									\
> > +		.active_pd_name =3D _active_pd,							\
> > +		.id =3D _id,									\
> > +		.offset =3D _offset,								\
> > +		.mask =3D _mask,									\
> > +		.flags =3D _flags,								\
> > +		.rst_offset =3D _rst_offset,							\
> > +		.rst_mask =3D _rst_mask,								\
> > +		.errata =3D _errata,								\
> > +	}
> > +
> > +#define IMX_BLK_CTL_PD(_name, _active_pd, _id, _offset, _mask,
> _rst_offset, _rst_mask, _flags)	\
> > +	IMX_BLK_CTL(BLK_CTL_PD, _name, _active_pd, _id, _offset, _mask,
> _rst_offset,		\
> > +		    _rst_mask, _flags, 0)
> > +
> > +#define IMX_BLK_CTL_PD_ERRATA(_name, _active_pd, _id, _offset, _mask,
> _rst_offset, _rst_mask,	\
> > +			      _flags, _errata)							\
> > +	IMX_BLK_CTL(BLK_CTL_PD, _name, _active_pd, _id, _offset, _mask,
> _rst_offset,		\
> > +		    _rst_mask, _flags, _errata)
> > +
> > +int imx_blk_ctl_register(struct device *dev);
> > +
> > +#define IMX_BLK_CTL_PD_HANDSHAKE	BIT(0)
> > +#define IMX_BLK_CTL_PD_RESET		BIT(1)
> > +#define IMX_BLK_CTL_PD_BUS		BIT(2)
> > +
> > +const extern struct dev_pm_ops imx_blk_ctl_pm_ops;
> > +
> > +#endif
> > --
> > 2.30.0
> >
