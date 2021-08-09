Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3666D3E4F88
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 00:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236887AbhHIWw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 18:52:29 -0400
Received: from mail-eopbgr140040.outbound.protection.outlook.com ([40.107.14.40]:50718
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233266AbhHIWw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 18:52:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nkiwl6inDYmm1Qi1bRArYiDIby7m0EDaorC45LXNef0qP3+5kOW9Ba3G4N0dCT4NF6tUb7Iy7pO3pTSRmRz1fOYxA86sp86IbdqqNCBORhsZ/Vaetqrc2y+lvLUsK/hfefIKOK9xbtYfWXHSnRUMegpqoue7MmbvIO9Nsl31KQqqLR0q2JAfZsTfeUlLzAaF8mtaaifx4n3WPUrmeZBG6u8ZDDAVfyuFVreio7dbI7NV0/292BVt43/t3ykFTEhuRgLrk73IbU83Oqo6UNP1P0Phv+phW7rUq3nCRnIhW70h2AogO/4ST/oSap8jYwdmHX7raJ/0wtYHR4Dzcihp/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BezF/EkhsKFiWIncWLfoNgKUUbITtVWxJLMpkT0MhXk=;
 b=QS0+Xt45aJWuuHqDCOCeVxVo7P032a7XC7KGSaBnYcPJ75iXOlT0cc1JNYxi4Dw2WPxrTP7zS6QovI81+MTSlpWfoTA8D4BmPkG6I2u7dRch3Hyf2PkiVISCf2VWRkYvCTfuPQbdcspMxw8DunJp61XEIITf7hUcXgqQCPAWh8DUqg3KXptVATdiBYXBmkJK04QwEW7ieUqxayXA1y6tQspM9NIQ1K52yp0IZFKOVINSxZyRf/KviMAmxeU7d/q6zH/5sJ+tk+ZI98Q6ggZJxQe+5VBuPCSAD7I4futXzVj+CWuiLVP+T/PVsRLcK5dP+7f8b81N7hyLSvlciT19eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BezF/EkhsKFiWIncWLfoNgKUUbITtVWxJLMpkT0MhXk=;
 b=UaPdTgvHtZb3mibkOegX+VOegBGflcT7eMVReMnT0QHKvR6ZX1DfeU7iDCvzuxth1no27dwWIEQ8mnZ3K3lH1IUEzTH+wlb75VSCQcwxysBDMlFgL6E/WwK0GkutPMq73q9L6XvlnxbLJ8qAZKTMtsHC0SrrWmp630OqjZ/YOwg=
Received: from AS8PR04MB8946.eurprd04.prod.outlook.com (2603:10a6:20b:42d::18)
 by AS8PR04MB8562.eurprd04.prod.outlook.com (2603:10a6:20b:421::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Mon, 9 Aug
 2021 22:52:04 +0000
Received: from AS8PR04MB8946.eurprd04.prod.outlook.com
 ([fe80::4d62:f78d:cea9:1ba6]) by AS8PR04MB8946.eurprd04.prod.outlook.com
 ([fe80::4d62:f78d:cea9:1ba6%6]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 22:52:04 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>,
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
Thread-Index: AQHXYejVx8YR0SiBXEyplsaWZ0dlkatsHV6Q
Date:   Mon, 9 Aug 2021 22:52:04 +0000
Message-ID: <AS8PR04MB8946D0EB15D631346F4D13198FF69@AS8PR04MB8946.eurprd04.prod.outlook.com>
References: <20210615131605.616-1-thunder.leizhen@huawei.com>
 <20210615131605.616-2-thunder.leizhen@huawei.com>
In-Reply-To: <20210615131605.616-2-thunder.leizhen@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5029487d-38ff-4ad0-cedf-08d95b884ee2
x-ms-traffictypediagnostic: AS8PR04MB8562:
x-microsoft-antispam-prvs: <AS8PR04MB8562E3AC8D74E29C2BD7223E8FF69@AS8PR04MB8562.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 39ByvojyGeRcogw1eerwB3v6HooAB7zxc+ww7H49ZNQHD5Wm/3tT23fQRqGL/qCzckHFbwhrXxyo11cMZlR+f96rBpv5vXcQVLQkRuzyBMXTQtevopCTK1fGCWryJ95UTZUKHRTMRPYb2LonQVoSjXqGE+eM5rjGIc4njvPXk3Ltg+lXHEpfREWx5MXjWLB0ydKisIHq7r8Cgd2OMGSGbLXDwlEq9vLyoYiQLIE9icXDOzUGEaYIqvuzv/CLlHqNOQUEJTwEvTVyvfiiblR1+z+h+lZhoS6oOmiTwRCnXdB/BiIBC9nbKWnWkan7ppfZQJwfT66MjjDz23G1fM8kh5gNjtoC7OBJ9TLWpWDwhEH2qobQy/fTdAhLnIvhf+kXgImrypN6j9n2yTVTvdNRZ/sm2bxyIPzxtGdh/AIdO7jH3Owyv3WqXJEpgks+osLoSI7jycT6u1ucril2NpUKMki20RdiCssaraXvUTnaeyuff5yl1v5uvHBo2PBk5r2BYcaTVZkwy+mYpaX+gj9XuZH5qbhCSzegCsv8wJTUpkXqswvUkR6EgM8iwrZ84oUtdaJt0MdOgnD9+NFUmdnkOWVzTlRwEokboUW9UJC5HkLYs3DUHvlHdpyLyf/hfX80JeCTO7nCLJZWGjS15zaXXNXaykqnD042+ag1MNYvx3RwUN4U02yxvFFJhvywNk/b89Iiv+8AA0saKYAzkeh2wQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8946.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(346002)(366004)(136003)(376002)(478600001)(64756008)(66556008)(66446008)(76116006)(66476007)(66946007)(26005)(2906002)(7696005)(110136005)(38100700002)(86362001)(316002)(33656002)(6506007)(83380400001)(53546011)(71200400001)(186003)(8676002)(38070700005)(8936002)(55016002)(5660300002)(52536014)(9686003)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j8gZWWwOpKHSJdJWtT53x+e2gipCciMD4Y/WKCERN+b8v373DqKzCWd1DOFW?=
 =?us-ascii?Q?5BANfMEPMUFEV2YTJ1EhVk+4Cs27mzWxhjlbOU7rj6Rhpv9uqo0UPJe9QBoc?=
 =?us-ascii?Q?/7zWbX6wfmnDzeVUCg//aXe99o5guibiBYwVGSyeTVW22jWQC5DEt+5w7Pwl?=
 =?us-ascii?Q?iTUsMdK78bkdTexGJZkXBHQqrrCIvkjmVYu+Dzz/Y+pipKW50oTIzBazdLQD?=
 =?us-ascii?Q?0OZqg/NMuTKeIn4O3ETigNETiMG4qpuko0I3zRVBgZI7fVPpiMz5CMW1M5JZ?=
 =?us-ascii?Q?hnfNgex4S6FjA1V+gBYua2vG24unl9MMgZ1b415iYO/BkY65yDS32kdvj5cE?=
 =?us-ascii?Q?0cVlbnHQeFlpfwSmGDSnzpPLeFjOGS4YOgacDJyX3rPlvg362C9IYg/ys5nN?=
 =?us-ascii?Q?l9+52kRG1HdObOK+0O99vAMenJY4uQVsfr8OnCieefzVmo0MjwTLxkOUcscS?=
 =?us-ascii?Q?UTxymtJpuSIUFFBE+nn6PTbV2u0ng+GplKIQriColzEFRT3BKvnP855o8pSL?=
 =?us-ascii?Q?YN/NwJk62ydcTH+mf7KBhpnR7szrN5N4MpNO/NJacJ//w+YN3vS/ObMLE+Fk?=
 =?us-ascii?Q?aNyqwcGgaZ6yiqtA1tpj3eHc3QEse7bwuCQNesEx4grRX2Le867uEnM0h2m9?=
 =?us-ascii?Q?50dOzoP5Xl8DQytzeGXyvnz+AlP03S+UZnrG9RtEWEG3yisCa/WTIgGlgr9S?=
 =?us-ascii?Q?RFHjtMwropcrgAeytcR6SC80AUuB22BVxZ2kgdqkwbTF5VLt1V8dqH698cWo?=
 =?us-ascii?Q?nxtyL1Kakw2pX3V8WTFk4XDEThWRrb5zQ902zLJlKvRhQTRfuKrW9WCLbkXs?=
 =?us-ascii?Q?W55KbrH1DT0i+COeQVQlWa14r8ctkxxSkskqULyGvHK1iZHufrifKeZ8+qEr?=
 =?us-ascii?Q?lLU/ZAKoVExnLzT1MYVPk6mSreLpqYw5wDRSPGFd6EtWPj2lYLaXMElwLREW?=
 =?us-ascii?Q?DICP4pmpXDmg7eXHJ45XRCvyITZMGaH139KgKCPWpupZwTL2txb8rEvDYqB5?=
 =?us-ascii?Q?ncd4i47OLSwz6nCc8gjd6xXjJIFSfYkwUS/VM9HyI0cnB5miVKUbm0JUl9kd?=
 =?us-ascii?Q?3/zMVFgxMzVfspUHKlgOOz/fRnaaGN8ZetPn0NKG6pEzsDJwYBgkYZESECGl?=
 =?us-ascii?Q?AV1YZLxpZIr+LyZVoS5wN5t4l/lWGDWOuFGWoO7alMR/jrULUVPzDfo1CaB/?=
 =?us-ascii?Q?tJLpLJSn+Zlpq7429WMiVI1x6+il4Dht1b803tofuNsLzEKylN4QC2HZsYYt?=
 =?us-ascii?Q?XZ3X+9ro3wYXr5VYDaDE88kBf9I6vBC2sI/Ld0mR/S7gVAxJ9yeNAL0/5asz?=
 =?us-ascii?Q?P2gj1c9lU2y06pcfZ/snc+FL?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8946.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5029487d-38ff-4ad0-cedf-08d95b884ee2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 22:52:04.6065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5nJDTls1oY+wpxcrxkc71Izwg2VZJKbgGqhcZvvQ5cuhnchh8imgCz5xCYLQT6L4JLuCUkEOxQJj8uNYmEM3pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8562
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Zhen Lei <thunder.leizhen@huawei.com>
> Sent: Tuesday, June 15, 2021 8:16 AM
> To: Shawn Guo <shawnguo@kernel.org>; Leo Li <leoyang.li@nxp.com>; Rob
> Herring <robh+dt@kernel.org>; Mark Kettenis <mark.kettenis@xs4all.nl>;
> devicetree <devicetree@vger.kernel.org>; linux-arm-kernel <linux-arm-
> kernel@lists.infradead.org>; linux-kernel <linux-kernel@vger.kernel.org>
> Cc: Zhen Lei <thunder.leizhen@huawei.com>
> Subject: [PATCH v2 1/1] arm64: dts: lx2160a: Fix the compatible string of
> LX2160A UART
>=20
> Mark Kettenis told us that:
> According to the NXP documentation, the LX2160A has a real PL011 UART.
>=20
> Therefore, rewrite it to the compatible string of pl011. The property "cu=
rrent-
> speed" specific to "arm,sbsa-uart" is also deleted.

Sorry that I missed the discussion on the v1.  But looks like this change b=
reaks the LX2160 boot.  The AMBA matching doesn't seem to work.  And the co=
nsole is not registered correctly.

[    0.639055] OF: amba_device_add() failed (-2) for /soc/serial@21c0000
[    0.645612] OF: amba_device_add() failed (-2) for /soc/serial@21d0000

>=20
> Suggested-by: Shawn Guo <shawnguo@kernel.org>
> Suggested-by: Mark Kettenis <mark.kettenis@xs4all.nl>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> index c4b1a59ba424..d2e6f7285674 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> @@ -920,34 +920,30 @@ QORIQ_CLK_PLL_DIV(8)>,
>  		};
>=20
>  		uart0: serial@21c0000 {
> -			compatible =3D "arm,sbsa-uart","arm,pl011";
> +			compatible =3D "arm,pl011", "arm,primecell";
>  			reg =3D <0x0 0x21c0000 0x0 0x1000>;
>  			interrupts =3D <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> -			current-speed =3D <115200>;
>  			status =3D "disabled";
>  		};
>=20
>  		uart1: serial@21d0000 {
> -			compatible =3D "arm,sbsa-uart","arm,pl011";
> +			compatible =3D "arm,pl011", "arm,primecell";
>  			reg =3D <0x0 0x21d0000 0x0 0x1000>;
>  			interrupts =3D <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> -			current-speed =3D <115200>;
>  			status =3D "disabled";
>  		};
>=20
>  		uart2: serial@21e0000 {
> -			compatible =3D "arm,sbsa-uart","arm,pl011";
> +			compatible =3D "arm,pl011", "arm,primecell";
>  			reg =3D <0x0 0x21e0000 0x0 0x1000>;
>  			interrupts =3D <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
> -			current-speed =3D <115200>;
>  			status =3D "disabled";
>  		};
>=20
>  		uart3: serial@21f0000 {
> -			compatible =3D "arm,sbsa-uart","arm,pl011";
> +			compatible =3D "arm,pl011", "arm,primecell";
>  			reg =3D <0x0 0x21f0000 0x0 0x1000>;
>  			interrupts =3D <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
> -			current-speed =3D <115200>;
>  			status =3D "disabled";
>  		};
>=20
> --
> 2.25.1
>=20

