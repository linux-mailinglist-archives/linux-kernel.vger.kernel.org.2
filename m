Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA69437767
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 14:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbhJVMsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 08:48:42 -0400
Received: from mail-db8eur05on2057.outbound.protection.outlook.com ([40.107.20.57]:30945
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231928AbhJVMsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 08:48:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cA8b5rhmMxMe7RNSmx5QEfSNxIHXXvY7nLuh6w7Qo2Qv2IVIya0yVDfLD64r0nV8k8F9OCFUzLU/FCiA0c6//NfpBsotYQNoSJn+TvlL8L7ehoQjpfKBoUWWQY70TkFKQRbwS/nai8qSRHCVxoxkdORnFMrSRK6s2kpJhTiVRJMMk6L32HNwoPLnDAYSTLDFaJMWPplL+6iATZqA67EAtMuS1B9jC72Q99mAy4iQ1llduMSNiEfeg5GbMvzagQ1DmPHfQA5PfSe++T6tiqd2snm0Q0ilqEA88XqLP6kbj0+KaNThJv5fFHXdgED3nqpoS+BmYeUy2LUtZnfST4YBXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04zmHqGXEK5LrSxADlWbYQPN5r74eOUsk3eZExeL93o=;
 b=gJiEnRPeq86+9Sen80Xixp8CMKjEWqdYSuTvSp56lPO/wa9ZasU1XRiDUyhnhtXgNwba/6sxXL00TwgwfYnTVWhIAsdWsHpakPw/+G/2yeYIGtxAfKB5+yy6bWT6Phg+YAzXw1Iim6ZvVsYwXYuF8c0oP12PdyXq1RTVGcA+AqaZOSaAtZMOyZotkudawwAExtXvZs80giwf8zpI8MH1uvY0gbNAulpO89eFiozoscdEN3XKXxQssfec2KevV/2PaSz7B6KhNwgJrstiMb+Mup2sCoyJMxSM9jUHrV0cZe/U99NCz4asFZt2tA+y+nCwBgk7Yac1yZt+Wd7tySM6gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04zmHqGXEK5LrSxADlWbYQPN5r74eOUsk3eZExeL93o=;
 b=ckUNOEi5uHH/SL8fn2byoV5gfkAwp6FXKYKprm8LjRkBiUQPmnigAIrjocdG4xWWoDZlxfxkLD28KDqDF7lzre+nPZlxtQwtP+IAg7fkIis6P0L1h/dEjT96dAqUtY3NjupYhYAUt7q+KCO7rpFvYREqt/vPpg0m/xwwEGtckgI=
Received: from DU2PR04MB9020.eurprd04.prod.outlook.com (2603:10a6:10:2e3::9)
 by DU2PR04MB8694.eurprd04.prod.outlook.com (2603:10a6:10:2dd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Fri, 22 Oct
 2021 12:46:21 +0000
Received: from DU2PR04MB9020.eurprd04.prod.outlook.com
 ([fe80::b928:9230:aa10:639a]) by DU2PR04MB9020.eurprd04.prod.outlook.com
 ([fe80::b928:9230:aa10:639a%9]) with mapi id 15.20.4628.018; Fri, 22 Oct 2021
 12:46:20 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] clk: imx: gate off peripheral clock slice
Thread-Topic: [PATCH] clk: imx: gate off peripheral clock slice
Thread-Index: AQHXx0D/LxWymokOzkW9VG+dIz+piave9jEAgAAANNA=
Date:   Fri, 22 Oct 2021 12:46:20 +0000
Message-ID: <DU2PR04MB90209C3309DFCB331BF95A0588809@DU2PR04MB9020.eurprd04.prod.outlook.com>
References: <20211022130946.16683-1-peng.fan@oss.nxp.com>
 <eeac9ec3-1775-acc8-61c4-1d5c12ab0a29@pengutronix.de>
In-Reply-To: <eeac9ec3-1775-acc8-61c4-1d5c12ab0a29@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09736c58-f0b5-4932-344d-08d99559f2e9
x-ms-traffictypediagnostic: DU2PR04MB8694:
x-microsoft-antispam-prvs: <DU2PR04MB869448DCA9B68297DB3E5EBF88809@DU2PR04MB8694.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CbbuseWBa6uteyv7zqg17ANknE9kEwGe3BZpk0BDLGPY8EyY56gXonk35djO3NuAiTendevF/I/EXd4QNuevKbYnEAhOOujG5ebw7/0+Rin8/+qZb0vhV5RoU5ujtn6EUUbxcwgoJWrRL0dqrsn1UZztt7hm0T3d9UAh5+mXhlik+AK1MPMlbRALULt+4d7TPy1Hkk5dIcElVtE5JFz2WrpymKXp39bhfU9rXQs/95G9ZYeJ7Mh0ug/zyRhBdoxSMzD+8i/5WQ3xzb4JoO+v/8t+RYeic7YlB/trIIXJQWTxizbUwEeccLmKtIkjBqKczMQfCr5Hm/tCLy48TdCs2k7pIU6z4uFz8282iID479iohtyERWCRx8QIfP1f+9XZ2qM9+U7SsQp+PTEUcGRQ+3lrIJsxbjaQYVdzbMiD/NbhoscFekn3ZZaSD9+6HLRIPgR3XgK4WEac9QBu2BWZYChGtkz5WALORCLyVbaUwHNiANL9navExGm7VTVfRZ1p/esWbwHapjmJBBHZvGXbf0HE8n7g1u44U6LSkTV9WYqUsWNCJJ2DwIeQaDx9AY4FGD0xKopqZb/r8oZCKM+VMAa+DxLXVA8yMhdQftLG8pZGR6Ex7YrFWcp80dfQsPORP3l9CVStPHtuiYFmmm2YyACzsv08Y4+GIsizvhGCoqEJXXLJ2K3iliVDnbaKPxV5y1NQMZ2zA1X5GiGQf0ZkELPrllYDBGzAy8w6jl6pOjt63Hq67rYuJ18woJuf4sQz3cskL6Hi75xzGMONMcWATJZU5HTD4ahSbBRQsbJPSuQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9020.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(9686003)(38070700005)(55016002)(54906003)(71200400001)(316002)(26005)(66476007)(4326008)(44832011)(508600001)(5660300002)(2906002)(45080400002)(6506007)(122000001)(53546011)(966005)(52536014)(110136005)(66946007)(83380400001)(33656002)(7696005)(66556008)(86362001)(64756008)(8936002)(186003)(76116006)(66446008)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/6jyTW3rr3oNKss1vmr6KlI/Qio0ds732I5lGBugH7v5vEfoxv7zf5VIMxGN?=
 =?us-ascii?Q?+zMOKKuQGAboFrZzdSFx874nfBsdfP5qB06na5iQknBuzQ8WXwVZtPQNFnBQ?=
 =?us-ascii?Q?mVtHe7EwB304ud3Lu1zn2pjutQ0pxbD+zZdMb4htFFnNp2L/ffDKiOjJ/Ecg?=
 =?us-ascii?Q?b+02eQ8s0/D85Hcsh2j9dV4P9ZiRaSMIBEu0WTWQWwH/yAx0yY2v42mgrdiD?=
 =?us-ascii?Q?BqHXan7De+wxjIKVbWN/a8I5w9hkWIVwh1bMGvYX4NLHV2/zxaXy0cOK46Fp?=
 =?us-ascii?Q?G2YTPOuGl+V6qLV86XAlUxXYg1FrfSyUB3e3fQ6NCyuLM4cbev9H5IlmjhgZ?=
 =?us-ascii?Q?S7eV89ZGuIfGsfwX7PZ6oJWnGcVEiiJxhQAlWEZxeNDd6EF0pvuOiCxxKdoi?=
 =?us-ascii?Q?N+9K8WI8aQ1P9TOth8TCdKOBmDDk+pub/xJyZ+dvS0ubwX75K7+Rt2Jh1qMr?=
 =?us-ascii?Q?djgKpomSbwHfmIKJN5LjpR3wFhAlIU6IPnEDpjhiZuTxSRDriDWq/235/QCv?=
 =?us-ascii?Q?qvaIzx9eLmxPVDQA483Fi9thGH27vO8cj/5TrG5ohoAbO99utLGt/QIJXz4j?=
 =?us-ascii?Q?m/LKvXZsRRb2FgzvXUlPztf2rhaHPh6JQxiqu95emG/1NhuuevAtEcfdW6qX?=
 =?us-ascii?Q?J2m6HGTj3LL1T3299HUFKiwbIOkWl4tJUwUADIGpi/QEW5NAQjCBBEP7AXQw?=
 =?us-ascii?Q?us4/+A7UVZaGxAtuyK1QjHXntEw6qXrLTns0CsBTuai6fT0vZU7UnkvCf5lT?=
 =?us-ascii?Q?cU0ysuWcx1nyaO9BdVn7ZmDCt0mlK7qHRJqn1fRupHa1SrDB8FEnmlKfGXqj?=
 =?us-ascii?Q?U4kdARNjfBgcyI2KJydYsA2ZoK5BE6QH/wWvrxUOXttYZKyfR1uO0oILnPdQ?=
 =?us-ascii?Q?Ux6XeYU4OKgIMZxqYFE0Xum5x+XS0IATaWZkbjkh8TVJnbVdiA2sS+LX3gDT?=
 =?us-ascii?Q?GMR99S17lm9S/+J6unGUT8SGZ08tbkUznhKaEkL0dIlW5NIPE3YAblq+7HiF?=
 =?us-ascii?Q?iHb8THdQMNNHeApRvxV1jtXx2OdlJldSNeVAHXAn3XzNkgbjjrfIrKpu3OsF?=
 =?us-ascii?Q?HkuS1mGjPA8bZDj/Y2LGryjqk2G140ag4xN85lLf2au3tG245thQO2lGegCj?=
 =?us-ascii?Q?EGZQg9LXwKpIjHJ+H76XsKVo6jAAwgaGC/AOvo2HW++imgX1elXXA7K+jlXL?=
 =?us-ascii?Q?igIC+18oyRro49F6JrJx1ZBQsatNofg/bDneQVZrYukL+vjpC+wFCVB5Vh07?=
 =?us-ascii?Q?3vy1tAf+jXQcZqDGYNftgXZfWPT0ZkuF1oB6snGy9fb0cD7C0Xj30Gg8xlBG?=
 =?us-ascii?Q?YHeL7I/Fd5kgM42Z0R5Xemdl02GptQEGO86blOtHOEvknJOtEPzfFlz2Aizm?=
 =?us-ascii?Q?Gu2AMLtfgcFc3VB4IxQOO5yWukftlUw3/6ltkHjEdWfIGbA7rmQkB/nMvZTl?=
 =?us-ascii?Q?XNSuB59aI8g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9020.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09736c58-f0b5-4932-344d-08d99559f2e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2021 12:46:20.7622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: peng.fan@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8694
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ahmad,

> Subject: Re: [PATCH] clk: imx: gate off peripheral clock slice
>=20
> Hello Peng,
>=20
> On 22.10.21 15:09, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > The Peripheral clocks are default enabled when SoC power on, and
> > bootloader not gate off the clocks when booting Linux Kernel.
> >
> > So Linux Kernel is not aware the peripheral clocks are enabled and
> > still take them as disabled because of enable count is zero.
> >
> > Then Peripheral clock's source without clock gated off could be
> > changed when have assigned-parents in device tree
> >
> > However, per i.MX8M* reference mannual, "Peripheral clock slices must
> > be stopped to change the clock source", so need to gate off the the
> > peripheral clock when registering the clocks to avoid glitch.
>=20
> This sounds like a fix that should be backported. If so, could you provid=
e a
> Fixes: Tag?

We not see any critical issue without this patch, just to avoid
any potential risk here. So I not add fix tag here.

Abel, do you prefer a fixes tag or leave it as is?

Thanks,
Peng.

>=20
> Thanks,
> Ahmad
>=20
> >
> > Tested boot on i.MX8MM/P-EVK board
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/clk/imx/clk-composite-8m.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/clk/imx/clk-composite-8m.c
> > b/drivers/clk/imx/clk-composite-8m.c
> > index 2dfd6149e528..ee41fbf90589 100644
> > --- a/drivers/clk/imx/clk-composite-8m.c
> > +++ b/drivers/clk/imx/clk-composite-8m.c
> > @@ -184,6 +184,7 @@ struct clk_hw *__imx8m_clk_hw_composite(const
> char *name,
> >  	struct clk_mux *mux =3D NULL;
> >  	const struct clk_ops *divider_ops;
> >  	const struct clk_ops *mux_ops;
> > +	u32 val;
> >
> >  	mux =3D kzalloc(sizeof(*mux), GFP_KERNEL);
> >  	if (!mux)
> > @@ -216,8 +217,14 @@ struct clk_hw *__imx8m_clk_hw_composite(const
> char *name,
> >  		div->width =3D PCG_PREDIV_WIDTH;
> >  		divider_ops =3D &imx8m_clk_composite_divider_ops;
> >  		mux_ops =3D &clk_mux_ops;
> > -		if (!(composite_flags & IMX_COMPOSITE_FW_MANAGED))
> > +		if (!(composite_flags & IMX_COMPOSITE_FW_MANAGED)) {
> >  			flags |=3D CLK_SET_PARENT_GATE;
> > +			if (!(flags & CLK_IS_CRITICAL)) {
> > +				val =3D readl(reg);
> > +				val &=3D ~BIT(PCG_CGC_SHIFT);
> > +				writel(val, reg);
> > +			}
> > +		}
> >  	}
> >
> >  	div->lock =3D &imx_ccm_lock;
> >
>=20
>=20
> --
> Pengutronix e.K.                           |
> |
> Steuerwalder Str. 21                       |
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.p
> engutronix.de%2F&amp;data=3D04%7C01%7Cpeng.fan%40nxp.com%7Cb5b827
> 20263e43680e9208d995597f48%7C686ea1d3bc2b4c6fa92cd99c5c301635%
> 7C0%7C0%7C637705033902868076%7CUnknown%7CTWFpbGZsb3d8eyJWIj
> oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1
> 000&amp;sdata=3DPolK7YYK66Bbyd6KJgINnvma8JZ6OdDZ8e1cp6rvIww%3D&a
> mp;reserved=3D0  |
> 31137 Hildesheim, Germany                  | Phone:
> +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:
> +49-5121-206917-5555 |
