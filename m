Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE84E441229
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 03:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbhKAC3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 22:29:25 -0400
Received: from mail-eopbgr50041.outbound.protection.outlook.com ([40.107.5.41]:44037
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230222AbhKAC3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 22:29:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGBNKD+hpJlD+CIl9tq7INtjUMi7VX4n02rOw/+oUaSl/NSejAhnlVv29Us96muzFwTSpXwR8dbK+FeGpL2gFhjT80uzTYbXZdxZx/dug9qz/IUMi6Erc6onr+eigZta6IlTtf6wDLRJCdHTZV5INwfRXaV4GTgPVN4Uj8guqSuABokuzqeeepU22tN+0lnUfqet994l0HMB3ZwcP+kfhCQ987E7Hb+rAZ7PTH8UxviH7Fe4mkj4k4tn0qlHcfDPbFIxfxQxOqOSXOnH9oEwbU3x+w6Bm114zv9HR8KDI30xHvVvg/hHrfEiIt8hw8bIuhSW+5HGHveJXXMNLmwXMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fx8VuqxYb9/EhLX8KAtHy757K2vslCNC4UAOInXV7AM=;
 b=hvDZ+BNiFXn4E/8t27lLdqmoCoIpXkgdAVWonlAyo00QEN0AaMR/n+D3wBkb/0bi7EDdq0G6jjZAL1szgPajiNfggqSTzPlYSJVfN5jIB9DG0rnR+AWTXcStHByTcB+pLsQEJpdRapPEMAbIBRdOD0AAud+H/BAujHmrfj/yy5OKGqohqoZDln4cpolnRrJjdUO239RT9PoeGT9RO6Yyfo67fUoif/+MS6LVNvN5GtROpj+EyNZgRzW8RiO+ChhverGTIzudIjOGfVvwRa/W34T4Jv6hScxvlZBsFWgDsD4TGryCM6F6nuuRiC9cLjw7HygKxGBMO2gRSI5GY4BnNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fx8VuqxYb9/EhLX8KAtHy757K2vslCNC4UAOInXV7AM=;
 b=fiq6qP3njK9q6loPbdN/iN4DJKPv2mE3l7PMHhLDIr0/uT+LXHzO1LuIcFspIxjA44+9W8oYoPrp7eaa4umP/V3AS47GKw7RIsBwrzJ2GR+3ihDjgPx6pxrliBwFDx5iDUPug+Nt0gMGfcsdCwXs5xWG3vIqZsm4mWSFGC6E3eM=
Received: from DU2PR04MB9020.eurprd04.prod.outlook.com (2603:10a6:10:2e3::9)
 by DU2PR04MB9050.eurprd04.prod.outlook.com (2603:10a6:10:2e5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Mon, 1 Nov
 2021 02:26:49 +0000
Received: from DU2PR04MB9020.eurprd04.prod.outlook.com
 ([fe80::f194:b056:4b35:7f8c]) by DU2PR04MB9020.eurprd04.prod.outlook.com
 ([fe80::f194:b056:4b35:7f8c%5]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 02:26:49 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH V2] clk: imx: gate off peripheral clock slice
Thread-Topic: [PATCH V2] clk: imx: gate off peripheral clock slice
Thread-Index: AQHXyZbJTu0qvS4PsEKRIZ0lnqI4Q6vjntiAgAaXQoCAA8YHYA==
Date:   Mon, 1 Nov 2021 02:26:49 +0000
Message-ID: <DU2PR04MB9020F68A9F9E53063F838179888A9@DU2PR04MB9020.eurprd04.prod.outlook.com>
References: <20211025122902.1151-1-peng.fan@oss.nxp.com>
 <YXaeOa9CsT3cd/u+@ryzen>
 <d3fd4bdf-6e3d-7752-dcc2-293fc5e6f469@pengutronix.de>
In-Reply-To: <d3fd4bdf-6e3d-7752-dcc2-293fc5e6f469@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 247c6ad0-651e-4565-d064-08d99cdf0f31
x-ms-traffictypediagnostic: DU2PR04MB9050:
x-microsoft-antispam-prvs: <DU2PR04MB9050CC8FD1D85536C7DDC425888A9@DU2PR04MB9050.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4ctRdhuCLFdyp743Mj8GR4aY/irapzGu4iDckLq5Q5FOmo2HoN6mstsW5+2HyOZ0cSDnsqrJkS6j82UW/T29dhPrjJ0gLBM3be1uG7RIg8BVeP/uU+Chz+6o6OJ39l2AOm/pYFIq+LAryizUWNtAUs62DE7eFzqW2OVOWrI1xO4wE581ibLcNRpHMT0sTTulex0JUKDCptZGhxW8J+GZePk6YACOoRTGd+LVikGANIuFjqvBH++U7LwFyoyiLFfXvCs90aYYWz7UksaBaFBiZhf7SkOsDgiZ454BJR02R65RGlcviK/BnxI3xlfYY/19NMFO7fhbftif/qvTSRW4e2sCy2TO/0ypU46cXdM6UiRoAyaxb1DRwkkbF7g6ezONjFJAekktyCNz/J2UB1ASkJcrG/uVZgNW04t22ZVOlI4fWSmKqRWw0yZcOkrAnhna2O4XfoRZ1ZG0cg6IwVXtVM7k3USQgNj5dWc/GeexyyBh/YtS/jdrTKSIjsDn9S/pYHKKg+o1OHthxY6IC1Ydz3mJ3G5w5f40yC5LGz5RyWPZO3smhC1G1QBLZ4tkdtu3iZaeIXPDRFBypEERdVxMNu25IFo9za9XyyLc+BdbxcgyqUy7RT1iKw4KJYBbIUkmZhQQfmZuE49PuZJrT7nhKjcL7xoEguAevuooP2yfjYGWynuhhNhWm7MbkAw6zAP5yrdECUN83pbFI+l5ovv7kyep4PP4GpLn28NNpGGjsRAkiDRs0z0eOQ26jBBpeF9iqI52NUXnjDRWq/GJYBHZarm67anKLLRCbT0CKmDMRPk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9020.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(66946007)(53546011)(26005)(38070700005)(44832011)(86362001)(71200400001)(76116006)(8936002)(64756008)(186003)(5660300002)(316002)(8676002)(66446008)(122000001)(7696005)(66476007)(4326008)(83380400001)(2906002)(45080400002)(52536014)(54906003)(966005)(66556008)(33656002)(55016002)(110136005)(508600001)(9686003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZsgrW7C/NsnolQq6GxSdhNeHuCXxraQUdlyOrmLtJnmqKHpfSZZ2CZG4r8pP?=
 =?us-ascii?Q?/Ox7CQungEL1my6420w7NjT14dyrETb+gz64cuJ/MstoGnm3vbk675zWa/h+?=
 =?us-ascii?Q?5ajTW8ouf4qRHdDPSOO2Vqa6xIoJFoQ83ic/mfb09oJA322kz0CDcC+ynoGZ?=
 =?us-ascii?Q?DE6tMSDwElqrzBJyIs7/i2U8curs80xfnL62qRMgMnBuPtwDUiO2ow7/513H?=
 =?us-ascii?Q?Sq1t1w97GVDIJ81/iTyDqfKpN5WvVVy7w5CWpCRsSQFynCAlnufRrbthki3D?=
 =?us-ascii?Q?s4TAL5nI2T6mQElxVTly9eG3A/BLad+AO815hIzgrVydKNT4T0q9H9wBEED7?=
 =?us-ascii?Q?htDEfBxggWh8ahwmVzDLM6hrkP28DiFCqvUEVG0LLtkGJ/pt/PmSBtnTqg5N?=
 =?us-ascii?Q?wRBeVTtKSyTNUS4VQTQodmbICVA7FYuoQm/XipaI4VyQDi7OpSNCLbFKAmPJ?=
 =?us-ascii?Q?A7uarNX6Biv+lYI8l3qF3eUlIfa1PTP0oneYycDImA2mVt2R4T8shPQIj5Vf?=
 =?us-ascii?Q?UX2pa+tlpb0Or0aEvVPzQhchVE3WjjFNAyUXt6ZE/FKN6cpbBICZ0PtzPx19?=
 =?us-ascii?Q?US0zSD+sEhoZ1PbaHCGY25Sj4VGVwOBEvu1SPTXtA9b1WE20xsFPG7QvvzU2?=
 =?us-ascii?Q?7Se6jC8inO/vHC11kCqH6y9ELrh2Bgy/Zuomb/wfqKfQ3QDIhsJXT8tAtJwT?=
 =?us-ascii?Q?rMdd3HO/EtqwfK9Sg2gRRCjDiFmjdToVmBCP8hiuOxuYVmLAkYTVSPbKQgeU?=
 =?us-ascii?Q?gM1TdjO1FgF7AKYqFmpPSc2xSh6wdq09M1+jxTbZ1EviNhnm15GSL4H2avWX?=
 =?us-ascii?Q?fZ5umZwoTyJzIzSt5AMWdBstR1DXKO6I43cMKRxzVWBUB0fnBJTtqNUqP1B0?=
 =?us-ascii?Q?KRbckawiMYSZSmFa/Y3spIOB2jHvaTvhgLhNH5aJ1MUdz1AZeycw1LXPs5hz?=
 =?us-ascii?Q?O/xG0+FH64UIxPWKkzF0E10eQkw29tS88TrB+TjX71BClQUBEoe47x0iQjAR?=
 =?us-ascii?Q?tA6c/nP0dgHIfUdSscB/BfzyYJfqcHWN39WAHdMxmimG5U5F9ya58Tkd5EYg?=
 =?us-ascii?Q?yw4RhPoAYD560kZjq5T2ZopyaWGFOQ/KJwoVxdN5PjII9ImHN3aQz//xpkln?=
 =?us-ascii?Q?Cvz8U20a90Ld8y5ad8jeI/+jc7xRLnMAAzxsnly2PsBg2K9DGMKVacFo+FaT?=
 =?us-ascii?Q?eXrelFCr9HFhC8grFNM7cGZTwR5mVBkedfW/BUnSM/LszqAzS0akknexcWwP?=
 =?us-ascii?Q?Io/X7Tv3+Ayu7+T3/MoW77ps3AJqfgE6Y/d6b9bZ1K0noOpNlPLL2Mh4T1DF?=
 =?us-ascii?Q?JA3JqIc2qht1E0cmY79cWUx0wTOJ647eL2ywEijnIX6e5BCD9EfEdJ4bJLSl?=
 =?us-ascii?Q?H71R5l3I+8F47vyaNgfL+C65nFHcbfatl7yGk+pyejD45NPJLKBmeMeceNSA?=
 =?us-ascii?Q?God/Veyb9OuOt88G32oaPr+mkxdsh+YUFVpjGWLTLmfcrzpMJEL3FJmdXQX3?=
 =?us-ascii?Q?/Wn9kQmbIXE5DVWlSStmdJ4hyYrylfyVJba1dbKZPbKU5wiLu+V3aijHl4iz?=
 =?us-ascii?Q?AFuemSDXHP4n1vhkbohVmK5Wz1nhGgvYJNhK+OfDLAIxnj/ytpZ4Yijau//B?=
 =?us-ascii?Q?bA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9020.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 247c6ad0-651e-4565-d064-08d99cdf0f31
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2021 02:26:49.4784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B0VGfNLLVG7K3Pjz9tBpqDQCDBlVoY2eUO1cktaLfq93R+dmylBMqTxzG3i9QKUi9SIfcR3wjLfPJQCn+klq4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9050
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V2] clk: imx: gate off peripheral clock slice
>=20
> Hello Peng, Abel,
>=20
> On 25.10.21 14:08, Abel Vesa wrote:
> > On 21-10-25 20:29:02, Peng Fan (OSS) wrote:
> >> From: Peng Fan <peng.fan@nxp.com>
> >>
> >> The Peripheral clocks are default enabled when SoC power on, and
> >> bootloader not gate off the clocks when booting Linux Kernel.
> >>
> >> So Linux Kernel is not aware the peripheral clocks are enabled and
> >> still take them as disabled because of enable count is zero.
> >>
> >> Then Peripheral clock's source without clock gated off could be
> >> changed when have assigned-parents in device tree
> >>
> >> However, per i.MX8M* reference mannual, "Peripheral clock slices must
> >> be stopped to change the clock source", so need to gate off the the
> >> peripheral clock when registering the clocks to avoid glitch.
> >>
> >> Tested boot on i.MX8MM/P-EVK board
>=20
> I just noticed this breaks earlycon on an i.MX8MN, I assume because the
> earlycon driver will access unclocked registers.

Not able to reproduce your issue.

root@imx8mnevk:~# uname -a
Linux imx8mnevk 5.15.0-rc7-next-20211029-00001-gbd989abbb94c-dirty #152 SMP=
 Mon Nov 1 10:48:06 CST 2021 aarch64 aarch64 aarch64 GNU/Linux
root@imx8mnevk:~# cat /proc/cmdline
earlycon console=3Dttymxc1,115200 root=3D/dev/mmcblk2p2 rootwait rw

>=20
> On the i.MX8MN, I also noticed that disabling usb_phy_ref hangs the syste=
m,
> whether via sysfs or via this patch. Still trying to figure that one out.

root@imx8mnevk:~# cat /sys/kernel/debug/clk/clk_summary  | grep usb_phy_ref
          usb_phy_ref                 0        0        0   100000000      =
    0     0  50000         N

I am using i.MX8MN-EVK board.

Regards,
Peng.

>=20
> Cheers,
> Ahmad
>=20
> >> Fixes: d3ff9728134e ("clk: imx: Add imx composite clock")
> >> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> >> ---
> >>
> >> V2:
> >>  Add Fixes tag
> >>
> >>  drivers/clk/imx/clk-composite-8m.c | 9 ++++++++-
> >>  1 file changed, 8 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/clk/imx/clk-composite-8m.c
> >> b/drivers/clk/imx/clk-composite-8m.c
> >> index 2dfd6149e528..ee41fbf90589 100644
> >> --- a/drivers/clk/imx/clk-composite-8m.c
> >> +++ b/drivers/clk/imx/clk-composite-8m.c
> >> @@ -184,6 +184,7 @@ struct clk_hw *__imx8m_clk_hw_composite(const
> char *name,
> >>  	struct clk_mux *mux =3D NULL;
> >>  	const struct clk_ops *divider_ops;
> >>  	const struct clk_ops *mux_ops;
> >> +	u32 val;
> >>
> >>  	mux =3D kzalloc(sizeof(*mux), GFP_KERNEL);
> >>  	if (!mux)
> >> @@ -216,8 +217,14 @@ struct clk_hw
> *__imx8m_clk_hw_composite(const char *name,
> >>  		div->width =3D PCG_PREDIV_WIDTH;
> >>  		divider_ops =3D &imx8m_clk_composite_divider_ops;
> >>  		mux_ops =3D &clk_mux_ops;
> >> -		if (!(composite_flags & IMX_COMPOSITE_FW_MANAGED))
> >> +		if (!(composite_flags & IMX_COMPOSITE_FW_MANAGED)) {
> >>  			flags |=3D CLK_SET_PARENT_GATE;
> >> +			if (!(flags & CLK_IS_CRITICAL)) {
> >> +				val =3D readl(reg);
> >> +				val &=3D ~BIT(PCG_CGC_SHIFT);
> >> +				writel(val, reg);
> >> +			}
> >> +		}
> >
> > Though I'm usually against special cases like this one. I think the
> > clock core needs some generic flag that would read the state from HW
> > on probe and/or another generic flag for disabling on probe.
> >
> > But for now, I'm OK with this:
> >
> > Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
> >
> >>  	}
> >>
> >>  	div->lock =3D &imx_ccm_lock;
> >> --
> >> 2.30.0
> >>
> >
> >
>=20
>=20
> --
> Pengutronix e.K.                           |
> |
> Steuerwalder Str. 21                       |
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.p
> engutronix.de%2F&amp;data=3D04%7C01%7Cpeng.fan%40nxp.com%7C626714
> cd2773448a4c0608d99afbc80d%7C686ea1d3bc2b4c6fa92cd99c5c301635%7
> C0%7C0%7C637711228448591454%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C10
> 00&amp;sdata=3D235%2BBGnDLUAIorqGKVVt%2BUKlSAf5jT68wq2s5FMDolY%
> 3D&amp;reserved=3D0  |
> 31137 Hildesheim, Germany                  | Phone:
> +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:
> +49-5121-206917-5555 |
