Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C5C3E518D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 05:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236698AbhHJDiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 23:38:51 -0400
Received: from mail-eopbgr00065.outbound.protection.outlook.com ([40.107.0.65]:64969
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230039AbhHJDit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 23:38:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KU9PJhp8/+YIGtyJJvdfHk0GL1HU6VdOQcVnedr5AkXMUMM1nYyWN/hE94AiUaZMZHWQ7bPSFtbxLRisdaWlN3rvmdkYGu7KCG91qOHHKF5XTQeASGO+QiZP0kzyTLsH4xQhzVzVMUxMdsYovM8i6wa+CS26ArE0GllOWZtOldUZdKS2YbEcwSx+jaW3UFHnCDtKfoHRcJ/FLppR3zVHcuMidU9fpE3qr0lWEaQQbQXzyQo0c6JOE0Ip1N300zHim+v6xOfMVMfUu+e3lRFq9AvGVosi7LsN5HCtT9Czq+t74QR8Fny26DlT9rHg5mnbGiQnUsYRb87df9Te7W/WCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwiaGvfgI/InRAZ0ZKkwwHKsiw4geczTUDzdCpx6mX4=;
 b=WLCK/UbZuGYPEiviFClAntbePn73iAGL0L1U2a0PYquFV/gj/Bavz0aaVpu2FYJ0VF81L8CsFjskT7BaY5/Zh7PTdrIOYcAzardIjJscXvOEOKhdu/1Cng+L3T99Ve16lux5W/DCKRnsjcJeFiwyaGB44frhD2x41tNC41ft7+HrnR4Cr0UupTnSFPm0Rdrt5Oy9W6H7Ua7rsI8XI7OXjfWAVMWoJdKJBvnQhbbSWByGFnXHRMjU2qNu9MySh/dCHCC3bqzpUnk0TtoZiahlwSQFNYTSA2Y/z1LMoAcVMpJWnLmuYFmfgvyTNV6MzhZyoLA1ps6W3x+vp0pWeoPmxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwiaGvfgI/InRAZ0ZKkwwHKsiw4geczTUDzdCpx6mX4=;
 b=NCQgWrTfFIQtCKoh+C3kCHNuYeIVeAzUPuNWA0kvsHAIi/a5h6imLXNSqzxO63M4pBttA8DVkXyDD0zKt5rkfsChq4o3yMeKm5a1AanGhIfb30x2gue2d9K3S1fGIPxcfF0IVVTZNO2haMwv7TbpFCfXSPUTnbZfzRikrgI491I=
Received: from AS8PR04MB8946.eurprd04.prod.outlook.com (2603:10a6:20b:42d::18)
 by AS8PR04MB8705.eurprd04.prod.outlook.com (2603:10a6:20b:428::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Tue, 10 Aug
 2021 03:38:26 +0000
Received: from AS8PR04MB8946.eurprd04.prod.outlook.com
 ([fe80::4d62:f78d:cea9:1ba6]) by AS8PR04MB8946.eurprd04.prod.outlook.com
 ([fe80::4d62:f78d:cea9:1ba6%6]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 03:38:26 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] arm64: dts: lx2160a: Fix the compatible string of
 LX2160A UART
Thread-Topic: [PATCH v2 1/1] arm64: dts: lx2160a: Fix the compatible string of
 LX2160A UART
Thread-Index: AQHXYejVx8YR0SiBXEyplsaWZ0dlkatsHV6QgAAsv4CAACNCUA==
Date:   Tue, 10 Aug 2021 03:38:26 +0000
Message-ID: <AS8PR04MB8946913A8B97C18240ADBAEA8FF79@AS8PR04MB8946.eurprd04.prod.outlook.com>
References: <20210615131605.616-1-thunder.leizhen@huawei.com>
 <20210615131605.616-2-thunder.leizhen@huawei.com>
 <AS8PR04MB8946D0EB15D631346F4D13198FF69@AS8PR04MB8946.eurprd04.prod.outlook.com>
 <03d7c7be-2f19-9fdf-2a4e-f49a62bb82f6@huawei.com>
In-Reply-To: <03d7c7be-2f19-9fdf-2a4e-f49a62bb82f6@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f05fb863-7610-45bb-1e62-08d95bb04fe0
x-ms-traffictypediagnostic: AS8PR04MB8705:
x-microsoft-antispam-prvs: <AS8PR04MB87052DCC7D1068A7E60451908FF79@AS8PR04MB8705.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ahg//ULOoPmNmEjP4bLhWQn5RV4Vpioz5vEJopxtbDgnct2w6pgbQjytfOCyo2qhsll/M1hSlwHUX/ivwk2gu20wL9G/szBKVrZK9WqiAbdNCcIHy0g2ysS8Obrrfqpk8uS5eVl5CSwIOKAcaAdGQ6UDP+VQ+iQgg98ILXQmqMD6wvJ8tvqLgWtmLhtJTfcuNk/0oT7z8rJWt0qRg9v5SuS1j+0FUKFB9ushdgn+YoxHucoi/SPuIq8LqYnD8l6tFfRyUsADZp4/R+FDT0GMC1AuDI5rLNG5wDaKPfS67aHIAs49qybU3/UjG21APJ6N4IAI34b0wcZAqEX71cFa+IlIwLB0fVCVv3GsjoZHs/UFbF64DVS6+4bsZ5jEObwQB9qlGbP1YxPpRi56Ic1qEekmKEM+XPArS1F855o8MvS/bDzxMyTqb90GniLnYLv4BcflB45Elune+p73hx1zVnIu9bXKlMPsWrr5+DIpHaSUcr/cv7lmUKCY/l2IP1O6Rl9DNNa9Jk4AnjU6JSS+Xi2QsGYNwd6eTsB0iqkD4RTxQlc5trITML2MwNkIg0nrzICYxnzSE/NO8bfbm6bpw0MLaYS2LtTYav1ZAiTcdzgbuj+caZa2ombf9vcnz1HbNwSPE/xfEoEl8qOBgBQfIcx9bcqVaMrtNQEs1GCyuraExR9r9EgGp631VAoGWO2ur090P50H+iePaRWV/k5j+FfsVHZOhb/ucTJSAm6D6HgOLBNXJadAAgQXYopgVGOyGpBVULIvywYDszRKtlsA1OJEQiJUGRoNmkOvVBGZ2fI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8946.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(186003)(33656002)(26005)(53546011)(55016002)(38100700002)(8676002)(66446008)(478600001)(66556008)(66476007)(9686003)(316002)(83380400001)(66946007)(966005)(110136005)(7696005)(6506007)(5660300002)(71200400001)(2906002)(8936002)(45080400002)(76116006)(86362001)(52536014)(64756008)(122000001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SUlLmPFdqhoPKBC/eGQ79qtrMAtBUNmEBQ9xyxB4ZbkKxQyIH+nc7meIrb3T?=
 =?us-ascii?Q?O2QLOGROIxLk2jKGLT7JBRnIoa8Nb3NfdGixprCraAEJ7kJJILwL83/qkOPn?=
 =?us-ascii?Q?u/cGMpNvNF/69xH5r+TeLhZPPMAETa5LnV0uFrUGtq+QSXNUGhyefgKEDLlr?=
 =?us-ascii?Q?X34CpB7PREZUbyDXKzmMoh1S1Ct6B4QOcOWaO1XyM/s3dh+kxbHC57GuxCFu?=
 =?us-ascii?Q?zFIz8DTmGwkYan7Kciif+yWqf1ym23CMwRuPveJeSu7A3ix1dAQQ/1gJt6T3?=
 =?us-ascii?Q?HsaasfZqIWEwUcxEaczDNTm1qUCf3RAG6GD1A0diI+D3vKV03DUMYo1CEvgo?=
 =?us-ascii?Q?rSnKmWdMbjbULiVVTyKvY8SaXV4pZrAuHv9ENua4a+fD1IJ3aSq8HslI5E4m?=
 =?us-ascii?Q?65pX6oGzQp4EEWGr5q19JnLixJFyodH2M3dnNkogiHaeuoI9NdjKCRKRhUF1?=
 =?us-ascii?Q?Jn9LmII7eUSUigVDGO4hvLnNHW2O7N0ATBUVSvvO3++571c9HCqMl/pJ++ns?=
 =?us-ascii?Q?eRTy6NbA38I1HW7NF5vZFNyqbLbgXZZCmgEsuzmLlpVj/FjPTTUfvxMGKkuI?=
 =?us-ascii?Q?SrHsb7+hOpgNNHXvmVqnfufarLEc94+2XEohaW0k9IXAmU7himHzy/BzEqV8?=
 =?us-ascii?Q?TQxTwBD3Dar52+Do7Y94WJPzQPXGhFNY1kvTgv7lGvSM0lVHznPsRANHFeQC?=
 =?us-ascii?Q?+pdhTASBur6Ab+JSQajAFkBryNhyP4SrD3jsEYstl9fdgH6Qres/xbXXTEX9?=
 =?us-ascii?Q?kZOEWoeZVN4SqJT/l7Hnbk2NQyxfN7ZQZcG89Rl45YmrFpUiXpevQfspT2kN?=
 =?us-ascii?Q?tvvFVj6CaZHgNjEDPyP3T1EBPBaj1SRettozwxuztS2Ct7hQo3Jg3N48t541?=
 =?us-ascii?Q?syi4qHo2wAmGh4AVKImtD5pPNit5C4donTR5/FKWeskFg6PtaJBD8p6/xiTc?=
 =?us-ascii?Q?02Rx9uxoCJY3shBbvQ0Zc55MN3grN9XBqz8M6JblqXj8OBpVpH1fny0i7HPW?=
 =?us-ascii?Q?owi7sDAwdU9QIU5MUDQJzIBSjN3NY1hGxkZgE5Z4U3sSWOdi40arwy9U0Zd9?=
 =?us-ascii?Q?E8vue08Xu2/u84WWmQfrQzBRrck4u0OA9hnVk3/BV5qK4aTyjq5zJwPhgbtR?=
 =?us-ascii?Q?mGsUz/BqehebVYTYjANob+Ud8iLcapC2ym4K//rYcK6+MhKmiC26dgu970BF?=
 =?us-ascii?Q?ZBqsHqsAMO1HhGBP4iXcRmqa6GcH8vvpt89xwaVnorZUuq93EMSHE7GQF0M7?=
 =?us-ascii?Q?7VNcu5Ee4Y7CsT1OXvGAVyavxTa4M3jKzh84LmoqvLNyyIkZdSDYLu/5DwtS?=
 =?us-ascii?Q?ehTgF6T0YlPyRVvgMCJbjKc4?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8946.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f05fb863-7610-45bb-1e62-08d95bb04fe0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2021 03:38:26.1079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YtRU2XyxZUu1xpIVuh3ZBkHYuHk981Uk7CvTyDS+WTLctczoFU9LkxY85HgwToMVTlPio1Ti2F0PIQlGaucD7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8705
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Leizhen (ThunderTown) <thunder.leizhen@huawei.com>
> Sent: Monday, August 9, 2021 8:28 PM
> To: Leo Li <leoyang.li@nxp.com>; Shawn Guo <shawnguo@kernel.org>; Rob
> Herring <robh+dt@kernel.org>; Mark Kettenis <mark.kettenis@xs4all.nl>;
> devicetree <devicetree@vger.kernel.org>; linux-arm-kernel <linux-arm-
> kernel@lists.infradead.org>; linux-kernel <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH v2 1/1] arm64: dts: lx2160a: Fix the compatible strin=
g of
> LX2160A UART
>=20
>=20
>=20
> On 2021/8/10 6:52, Leo Li wrote:
> >
> >
> >> -----Original Message-----
> >> From: Zhen Lei <thunder.leizhen@huawei.com>
> >> Sent: Tuesday, June 15, 2021 8:16 AM
> >> To: Shawn Guo <shawnguo@kernel.org>; Leo Li <leoyang.li@nxp.com>;
> Rob
> >> Herring <robh+dt@kernel.org>; Mark Kettenis
> >> <mark.kettenis@xs4all.nl>; devicetree <devicetree@vger.kernel.org>;
> >> linux-arm-kernel <linux-arm- kernel@lists.infradead.org>;
> >> linux-kernel <linux-kernel@vger.kernel.org>
> >> Cc: Zhen Lei <thunder.leizhen@huawei.com>
> >> Subject: [PATCH v2 1/1] arm64: dts: lx2160a: Fix the compatible
> >> string of LX2160A UART
> >>
> >> Mark Kettenis told us that:
> >> According to the NXP documentation, the LX2160A has a real PL011 UART.
> >>
> >> Therefore, rewrite it to the compatible string of pl011. The property
> >> "current- speed" specific to "arm,sbsa-uart" is also deleted.
> >
> > Sorry that I missed the discussion on the v1.  But looks like this chan=
ge
> breaks the LX2160 boot.  The AMBA matching doesn't seem to work.  And
> the console is not registered correctly.
>=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
k
> ernel.org%2Flinux-arm-kernel%2Fcba3a29f-92b5-072a-9a27-
> 60240f072dad%40huawei.com%2F&amp;data=3D04%7C01%7Cleoyang.li%40nx
> p.com%7C9986b52f71724d7f6ae108d95b9e1d9b%7C686ea1d3bc2b4c6fa92cd
> 99c5c301635%7C0%7C0%7C637641556923909225%7CUnknown%7CTWFpbGZ
> sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M
> n0%3D%7C1000&amp;sdata=3DwReesSfMj1hV2iPTN0%2F%2B%2Fb%2BKJH8xF
> LLcDgOMfjx731I%3D&amp;reserved=3D0
>=20
> Maybe we should fall back to v1.

I didn't look into the problem in detail.  Probably it is because of lackin=
g the clock properties needed by the AMBA bus?

>=20
> >
> > [    0.639055] OF: amba_device_add() failed (-2) for /soc/serial@21c000=
0
> > [    0.645612] OF: amba_device_add() failed (-2) for /soc/serial@21d000=
0
> >
> >>
> >> Suggested-by: Shawn Guo <shawnguo@kernel.org>
> >> Suggested-by: Mark Kettenis <mark.kettenis@xs4all.nl>
> >> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >> ---
> >>  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 12 ++++--------
> >>  1 file changed, 4 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> >> b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> >> index c4b1a59ba424..d2e6f7285674 100644
> >> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> >> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> >> @@ -920,34 +920,30 @@ QORIQ_CLK_PLL_DIV(8)>,
> >>  		};
> >>
> >>  		uart0: serial@21c0000 {
> >> -			compatible =3D "arm,sbsa-uart","arm,pl011";
> >> +			compatible =3D "arm,pl011", "arm,primecell";
> >>  			reg =3D <0x0 0x21c0000 0x0 0x1000>;
> >>  			interrupts =3D <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> >> -			current-speed =3D <115200>;
> >>  			status =3D "disabled";
> >>  		};
> >>
> >>  		uart1: serial@21d0000 {
> >> -			compatible =3D "arm,sbsa-uart","arm,pl011";
> >> +			compatible =3D "arm,pl011", "arm,primecell";
> >>  			reg =3D <0x0 0x21d0000 0x0 0x1000>;
> >>  			interrupts =3D <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> >> -			current-speed =3D <115200>;
> >>  			status =3D "disabled";
> >>  		};
> >>
> >>  		uart2: serial@21e0000 {
> >> -			compatible =3D "arm,sbsa-uart","arm,pl011";
> >> +			compatible =3D "arm,pl011", "arm,primecell";
> >>  			reg =3D <0x0 0x21e0000 0x0 0x1000>;
> >>  			interrupts =3D <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
> >> -			current-speed =3D <115200>;
> >>  			status =3D "disabled";
> >>  		};
> >>
> >>  		uart3: serial@21f0000 {
> >> -			compatible =3D "arm,sbsa-uart","arm,pl011";
> >> +			compatible =3D "arm,pl011", "arm,primecell";
> >>  			reg =3D <0x0 0x21f0000 0x0 0x1000>;
> >>  			interrupts =3D <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
> >> -			current-speed =3D <115200>;
> >>  			status =3D "disabled";
> >>  		};
> >>
> >> --
> >> 2.25.1
> >>
> >
> > .
> >
