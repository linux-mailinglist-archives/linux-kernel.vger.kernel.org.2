Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 468AD3B8023
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 11:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbhF3JjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 05:39:24 -0400
Received: from mail-eopbgr60063.outbound.protection.outlook.com ([40.107.6.63]:30107
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234070AbhF3JjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 05:39:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LywkdkoxhIZtgdOqL7UOlTwCCPYtS6Fh5AnU+uitFnKdvrXA+AicHIAVwFO/3nMgRHxccpNQ0igRh5Kwm9kDxeZrlIcczrnp1K3/HZ4lSdlAPpPUSRd4vVeuBsAgU3z/3KXRGodyCgqGvoE7Rouc2I8/tMX6CPeTHufwS0BabPD0fXqlFHSGvuy3wRHLi7vgpoZvjR2+pPw7CU8sBW1Qv3lPJVo+nDbGBOLKOOjRlYsEiS32exkvBD8SO7HRWt8mxlSVmfyMwno11WUCr/uh6J3r4Qkxb2iCmbKdNVMOkga/SGydXYTiavzLUaoKaawlGvZGr3Zg6RM2/Z0/MCPZoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEb8NfIXtPYylJjV0NtwICh1wwUKKGSZe7RLre3WSJE=;
 b=PGTh2M1t5RaYfPlhOi/vZbHjA/cleD07uFXUVaIWtSpkrDLSZK4PBwDm6N8CwdyIOH26srenXvTjuuVlXV42y+sBGDe3a+28lwDBXw6cK0gaYM9zwTcI4iKZ1GhX4rPgxkm27QfHO9WYdKHI82URuzWWevhz41DK0R5KpvDlKICz2tRUPBSPhXYlPdnWoGbM8luYEK4ENNDv2YUzpzzqWnzBlgZzm79qZZ5etg32KLcDC+Gk3dqB8sU1sRVQLlnyagfBNznD9mKnUqeefmL/ALk3zirhoasX7FG0WsZiVZoCgewSX+ArDRnP9zJUEzGI9DA1i4Zq1ew+H1jPHg849w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEb8NfIXtPYylJjV0NtwICh1wwUKKGSZe7RLre3WSJE=;
 b=kLfT5xCXFMgt6VNxBbMsYgkQFLl6V9ilZEXsSfoaIGlEbMi/ekl/87EEu5Qmwh0xABrJtD9cTSMJwS1LtEdVMRWVdmBewLD0Tq7+1kHIk5n2GPhcQgv2jPFN/Mmby6pQbN+J/TL3DZaFJPOsmYTZ3kU9XSnhhB6nIEftwgVWRqo=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBAPR04MB7285.eurprd04.prod.outlook.com (2603:10a6:10:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Wed, 30 Jun
 2021 09:36:47 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd%9]) with mapi id 15.20.4264.026; Wed, 30 Jun 2021
 09:36:47 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Adam Ford <aford173@gmail.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?iso-8859-1?Q?Guido_G=FCnther?= <agx@sigxcpu.org>,
        Marek Vasut <marex@denx.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: RE: [PATCH] arm64: dts: imx8mm: add pgc/blk_ctl nodes
Thread-Topic: [PATCH] arm64: dts: imx8mm: add pgc/blk_ctl nodes
Thread-Index: AQHXWS2PVjyy+Br6002MNpNRwYB58KsrJSWAgAFPF9A=
Date:   Wed, 30 Jun 2021 09:36:47 +0000
Message-ID: <DB6PR0402MB2760BB01268FBD961F9FF0D288019@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20210604111005.6804-1-peng.fan@oss.nxp.com>
 <CAHCN7xKYooBQzREdoa8ybhQUBXxy6RPaFX9rp1keD7_HgnVA9Q@mail.gmail.com>
In-Reply-To: <CAHCN7xKYooBQzREdoa8ybhQUBXxy6RPaFX9rp1keD7_HgnVA9Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30a8747c-d90e-4e71-e028-08d93baa9499
x-ms-traffictypediagnostic: DBAPR04MB7285:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DBAPR04MB7285954A77CA10E8F618D3E388019@DBAPR04MB7285.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NzNIYWJlHkZUol86xVAE9q2mEg4FEdwdB8NAjr8UFplKEoP4gwtKHahlJ1H85dE5XIhppPwep7XUiOtpNRm9GNSOoV/aBQkfC1K8mn8ivm2GnUf+vuGhgo5hmhRkuG2DMRPm9uHKjF/23kNvMOdDhvPFhyRT6YiVf4RB4YuijjYvUudev9WGHP/VRhiH/sB3OBDL9d2qCViHXb1EkWCSiH3UHmrAnaunfNq35kACmMe6WUXR/hwSW61SQUCHfCGYBtRfs/qs8WakZistPiBwKuvKmej0KOOa7oxnDiKiPT43Ua+4ymj2VS+bu9CZoWCQeYBe+1q4WVWadN5eqKuOJsqAg3ds3AhRERXTQ+eOiKFE/LpQeOFgZDRCBkSnAcQLv8md95x1ussBgQyuliZJbgKOi1iQPCmlh7MWCDOUnM6o/SHL8JbWCQhaK+w5YLVP2HWGRnZmByXt+eU2Jw7yW0nqJyaozB8pHYflMrkYzNZpvWapcSg/HZI7OIqBcN/9Ly7bUOhuPwANSmJcYKQCXFjId5PoyfmwKFb5nJm0W0Cr4AZG+fyav3LoFRStXuiHZWV8yWN/CiU+bM4xt/myTuGGsUI9Sh9KVPIqjWLXyHxj5/M8AkuctNgmcs8CIgh9mjXEZRZ/Xj6xstl/Mx39ihU5PqfUUDu/lvc0oOzKSxuRtXYLAbuMM+4IEHtSFjkC3ZYRbqYUjDlSs8KXBXGkCy6bJjuS1eCQVtFqDkE3taHYboaqPfh5iadFcLr40RqmB2xa68cFFN3zpUvl8NHWpEdsTvzEEgqmzZNZ/GgvVXid6pr6ZKPEelpBExBVyYj0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(66946007)(38100700002)(66446008)(64756008)(110136005)(478600001)(33656002)(76116006)(66556008)(66476007)(122000001)(7416002)(52536014)(45080400002)(8936002)(71200400001)(316002)(186003)(5660300002)(26005)(86362001)(54906003)(6506007)(966005)(55016002)(83380400001)(8676002)(7696005)(4326008)(44832011)(9686003)(2906002)(53546011)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NmHGHD5wKmvCV2wAzT8NsxTjOFolkUH8QWCcRoxVGwmgWpLFi9KXw1Wva2?=
 =?iso-8859-1?Q?wWz1o3RfGQm/iU9MUAe9HkOwTrooKqMFAdAIPeiicJmKrQHRfkSxxzDdlF?=
 =?iso-8859-1?Q?fqcAlKfsQx86MD1b+Geoo9vELUi/WR2NcyOCC/ptFP4WhQl6pW9ivQ42Ox?=
 =?iso-8859-1?Q?iEnrLL/9ecp2bJ4MMbUK4SmTp+ly1iSDk/3f4yCx3adw69GwvkQ+WuiN1C?=
 =?iso-8859-1?Q?lxuvrsEANkt9ydnQ95H6gS83ACWXNDj5HhRmu/Idlc5sHwrKbC/SMRCp9+?=
 =?iso-8859-1?Q?VVGMCyuWvEI+UC2KnOOo8/KrMw6o2KiNpk4uipZQUgUUxY4WL/FVSkOyiz?=
 =?iso-8859-1?Q?1Dc1kKokRoWKfeO743W1QIxHqZItHMl7pW9vPT0/DZlbOx7lQTBsGvvnOd?=
 =?iso-8859-1?Q?XOPfDjqhQRR2EwoYPnV+3oNMAfhl/09ICkbtI1SnzM4h8HKZiXAxIJdmpu?=
 =?iso-8859-1?Q?2au4mso+DQ1nsT+cXav4wuNGcmBFWFCFVCFVHwj7dxch8EBYVroLAvusDX?=
 =?iso-8859-1?Q?klvssqmfWNm4bkOdy8jHcLGavXEw2BqNdjDjKdunLVl5DZZzhaFW0Xid51?=
 =?iso-8859-1?Q?UVnYihPDqSDRQVTlJMQYUpc1S0JLNsbxxB4mTddEkqWRT6xSX133zDS1VC?=
 =?iso-8859-1?Q?++Y2E8+FAOH8SN2I+sOJk1QX6IW6QsB0q8jrWY3TAR8jmuGd+IPD+T/fKh?=
 =?iso-8859-1?Q?RDyguKKIPGrl8QqNgAPHEARC+DxLZmN0RAQO9R0z5p7m/Hw2AXw+Qo8x4D?=
 =?iso-8859-1?Q?oD9hhIDjmWwHPaC3W5TVAkhMvtWU3YbvtcZjq5Z1Ngws/acIsh0eULTvov?=
 =?iso-8859-1?Q?I/bxdXhi7+mGCzgXufGbWTFa/6C9VLGrbPm5f3ELehIDk/+qK1EELl25O3?=
 =?iso-8859-1?Q?CPlyn+7BvidkXo7Mdg3Eze0AYZCGv7oIHFA9Sci0HLYGUYx6UXejwtPrXN?=
 =?iso-8859-1?Q?uUtWKAOKcQyNNWhbmXAl8Nn6sbY1OuAfY3Uk+zxgLJ6nuuYrY+jvlHEB6X?=
 =?iso-8859-1?Q?BxgPTK4iPRu1xcgi5CyO/jpc+kYORQ/XT+MjogH095beXE/hvsf+rGrwVl?=
 =?iso-8859-1?Q?R5ZsK3Rh7cm9XGlv6SMDdChAF127O/gueT5BHwaaf9whNItZelST1ndY6k?=
 =?iso-8859-1?Q?d3b36zj0v8B8zD2LExIebnV6YvaWtqTkE1km9DMZOzFAmxLhLVXcozrKDL?=
 =?iso-8859-1?Q?cf0gHYnQqTWsPzYAox1ko7Ibip2nmN97+eYximbc+Br8M8f8qPmBZgelYR?=
 =?iso-8859-1?Q?zwUqwKzjMRM9MsAQKqVk99lvnTb0ieImBUw3nOBIUUHl/dknNLggDdL8KW?=
 =?iso-8859-1?Q?GGo3/Zy9pLa7tziw+PNOPr9iffcjW6ILPJLTdLtBdFU4FRQDttrmV9GVZK?=
 =?iso-8859-1?Q?eN9a0cy4Lb?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a8747c-d90e-4e71-e028-08d93baa9499
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2021 09:36:47.2037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /HjXsxD+G2mkae294ww/Bn/0DSh6B0aVKjFp5L0wsW1x3w5WTNPVcNWbrcX2tr9haAI+tRiEoXJBWvGZqT8d9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7285
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH] arm64: dts: imx8mm: add pgc/blk_ctl nodes
>=20
> On Fri, Jun 4, 2021 at 5:37 AM Peng Fan (OSS) <peng.fan@oss.nxp.com>
> wrote:
> >
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > With PGC and BLK-CTL landed, we could add pgc and blk-ctl nodes,
> > because some pgc domain relies on blk-ctl power domain, so they need
> > to be added together.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > V1:
> >  Depends on the blk-ctl patchset,
> >
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpat=
c
> >
> hwork.kernel.org%2Fproject%2Flinux-arm-kernel%2Fcover%2F202105221342
> 49
> > .15322-1-peng.fan%40oss.nxp.com%2F&amp;data=3D04%7C01%7Cpeng.fan%
> 40nxp.c
> >
> om%7C388c4bd417ff49d393c708d93b02e9f9%7C686ea1d3bc2b4c6fa92cd99
> c5c3016
> >
> 35%7C0%7C0%7C637605705985073021%7CUnknown%7CTWFpbGZsb3d8ey
> JWIjoiMC4wLj
> >
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp
> ;sdata=3D
> >
> osAlqXkaxQ8qexwmd%2Fh33V0tUpVnT%2Fk7B5kq5vgVRVQ%3D&amp;reser
> ved=3D0
> >
> >  Shawn,
> >   Since the blk-ctl patchset is in good shape and tested, is it ok for
> >   you to pick up?
> >  Thanks
> >
> >  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 128
> > ++++++++++++++++++++++
> >  1 file changed, 128 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > index e7648c3b8390..0e01ff649956 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > @@ -7,6 +7,8 @@
> >  #include <dt-bindings/gpio/gpio.h>
> >  #include <dt-bindings/input/input.h>
> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +#include <dt-bindings/power/imx8mm-power.h>
> > +#include <dt-bindings/reset/imx8mq-reset.h>
> >  #include <dt-bindings/thermal/thermal.h>
> >
> >  #include "imx8mm-pinfunc.h"
> > @@ -609,6 +611,109 @@ src: reset-controller@30390000 {
> >                                 interrupts =3D <GIC_SPI 89
> IRQ_TYPE_LEVEL_HIGH>;
> >                                 #reset-cells =3D <1>;
> >                         };
> > +
> > +                       gpc: gpc@303a0000 {
> > +                               compatible =3D "fsl,imx8mm-gpc";
> > +                               reg =3D <0x303a0000 0x10000>;
> > +                               interrupts =3D <GIC_SPI 87
> IRQ_TYPE_LEVEL_HIGH>;
> > +                               interrupt-parent =3D <&gic>;
> > +                               interrupt-controller;
> > +                               #interrupt-cells =3D <3>;
> > +
> > +                               pgc {
> > +                                       #address-cells =3D <1>;
> > +                                       #size-cells =3D <0>;
> > +
> > +                                       pgc_hsiomix:
> power-domain@0 {
> > +
> #power-domain-cells =3D <0>;
> > +                                               reg =3D
> <IMX8MM_POWER_DOMAIN_HSIOMIX>;
> > +                                               clocks =3D <&clk
> IMX8MM_CLK_USB1_CTRL_ROOT>;
> > +                                       };
> > +
> > +                                       pgc_pcie:
> power-domain@1 {
> > +
> #power-domain-cells =3D <0>;
> > +                                               reg =3D
> <IMX8MM_POWER_DOMAIN_PCIE>;
> > +                                               power-domains
> =3D <&pgc_hsiomix>;
> > +                                               clocks =3D <&clk
> IMX8MM_CLK_PCIE1_ROOT>;
> > +                                       };
> > +
> > +                                       pgc_otg1:
> power-domain@2 {
> > +
> #power-domain-cells =3D <0>;
> > +                                               reg =3D
> <IMX8MM_POWER_DOMAIN_OTG1>;
> > +                                               power-domains
> =3D <&pgc_hsiomix>;
> > +                                       };
> > +
> > +                                       pgc_otg2:
> power-domain@3 {
> > +
> #power-domain-cells =3D <0>;
> > +                                               reg =3D
> <IMX8MM_POWER_DOMAIN_OTG2>;
> > +                                               power-domains
> =3D <&pgc_hsiomix>;
> > +                                       };
> > +
>=20
> Any change you could add the references to pgc_otg1 and pgc_otg2 to their
> respective OTG nodes?  Without them, enabling OTG1 or OTG2 can result in =
a
> hang unless it was started in U-Boot.

Will post v2 to add that, really hope the driver part could be in, then mov=
e on.

Thanks,
Peng.

>=20
> > +                                       pgc_gpumix:
> power-domain@4 {
> > +
> #power-domain-cells =3D <0>;
> > +                                               reg =3D
> <IMX8MM_POWER_DOMAIN_GPUMIX>;
> > +                                               clocks =3D <&clk
> IMX8MM_CLK_GPU_BUS_ROOT>,
> > +
> <&clk IMX8MM_CLK_GPU_AHB>;
> > +                                       };
> > +
> > +                                       pgc_gpu:
> power-domain@5 {
> > +
> #power-domain-cells =3D <0>;
> > +                                               reg =3D
> <IMX8MM_POWER_DOMAIN_GPU>;
> > +                                               clocks =3D <&clk
> IMX8MM_CLK_GPU_AHB>,
> > +
> <&clk IMX8MM_CLK_GPU_BUS_ROOT>,
> > +
> <&clk IMX8MM_CLK_GPU2D_ROOT>,
> > +
> <&clk IMX8MM_CLK_GPU3D_ROOT>;
> > +                                               resets =3D <&src
> IMX8MQ_RESET_GPU_RESET>;
> > +                                               power-domains
> =3D <&pgc_gpumix>;
> > +                                       };
> > +
> > +                                       pgc_vpumix:
> power-domain@6 {
> > +
> #power-domain-cells =3D <0>;
> > +                                               reg =3D
> <IMX8MM_POWER_DOMAIN_VPUMIX>;
> > +                                               clocks =3D <&clk
> IMX8MM_CLK_VPU_DEC_ROOT>;
> > +                                               resets =3D <&src
> IMX8MQ_RESET_VPU_RESET>;
> > +                                       };
> > +
> > +                                       pgc_vpu_g1:
> power-domain@7 {
> > +
> #power-domain-cells =3D <0>;
> > +                                               power-domains
> =3D
> > +
> <&vpumix_blk_ctl IMX8MM_BLK_CTL_PD_VPU_BUS>;
> > +                                               reg =3D
> <IMX8MM_POWER_DOMAIN_VPUG1>;
> > +                                               clocks =3D <&clk
> IMX8MM_CLK_VPU_G1_ROOT>;
> > +                                       };
> > +
> > +                                       pgc_vpu_g2:
> power-domain@8 {
> > +
> #power-domain-cells =3D <0>;
> > +                                               power-domains
> =3D
> > +
> <&vpumix_blk_ctl IMX8MM_BLK_CTL_PD_VPU_BUS>;
> > +                                               reg =3D
> <IMX8MM_POWER_DOMAIN_VPUG2>;
> > +                                               clocks =3D <&clk
> IMX8MM_CLK_VPU_G2_ROOT>;
> > +                                       };
> > +
> > +                                       pgc_vpu_h1:
> power-domain@9 {
> > +
> #power-domain-cells =3D <0>;
> > +                                               power-domains
> =3D
> > +
> <&vpumix_blk_ctl IMX8MM_BLK_CTL_PD_VPU_BUS>;
> > +                                               reg =3D
> <IMX8MM_POWER_DOMAIN_VPUH1>;
> > +                                               clocks =3D <&clk
> IMX8MM_CLK_VPU_H1_ROOT>;
> > +                                       };
> > +
> > +                                       pgc_dispmix:
> power-domain@10 {
> > +
> #power-domain-cells =3D <0>;
> > +                                               reg =3D
> <IMX8MM_POWER_DOMAIN_DISPMIX>;
> > +                                               clocks =3D <&clk
> IMX8MM_CLK_DISP_ROOT>,
> > +
> <&clk IMX8MM_CLK_DISP_AXI_ROOT>,
> > +
> <&clk IMX8MM_CLK_DISP_APB_ROOT>;
> > +                                       };
> > +
> > +                                       pgc_mipi:
> power-domain@11 {
> > +
> #power-domain-cells =3D <0>;
> > +                                               reg =3D
> <IMX8MM_POWER_DOMAIN_MIPI>;
> > +                                               power-domains
> =3D
> > +
> <&dispmix_blk_ctl IMX8MM_BLK_CTL_PD_DISPMIX_BUS>;
> > +                                       };
> > +                               };
> > +                       };
> >                 };
> >
> >                 aips2: bus@30400000 {
> > @@ -960,6 +1065,18 @@ aips4: bus@32c00000 {
> >                         #size-cells =3D <1>;
> >                         ranges =3D <0x32c00000 0x32c00000
> 0x400000>;
> >
> > +                       dispmix_blk_ctl: blk_ctl@32e28000 {
> > +                               compatible =3D
> "fsl,imx8mm-dispmix-blk-ctl", "syscon";
> > +                               reg =3D <0x32e28000 0x100>;
> > +                               #power-domain-cells =3D <1>;
> > +                               #reset-cells =3D <1>;
> > +                               power-domains =3D <&pgc_dispmix>,
> <&pgc_mipi>;
> > +                               power-domain-names =3D "dispmix",
> "mipi";
> > +                               clocks =3D <&clk
> IMX8MM_CLK_DISP_ROOT>,
> > +                                        <&clk
> IMX8MM_CLK_DISP_AXI_ROOT>,
> > +                                        <&clk
> IMX8MM_CLK_DISP_APB_ROOT>;
> > +                       };
> > +
> >                         usbotg1: usb@32e40000 {
> >                                 compatible =3D "fsl,imx8mm-usb",
> "fsl,imx7d-usb";
> >                                 reg =3D <0x32e40000 0x200>; @@
> -1029,6
> > +1146,17 @@ gpmi: nand-controller@33002000{
> >                         status =3D "disabled";
> >                 };
> >
> > +               vpumix_blk_ctl: blk-ctl@38330000 {
> > +                       compatible =3D "fsl,imx8mm-vpumix-blk-ctl",
> "syscon";
> > +                       reg =3D <0x38330000 0x100>;
> > +                       #power-domain-cells =3D <1>;
> > +                       #reset-cells =3D <1>;
> > +                       power-domains =3D <&pgc_vpumix>,
> <&pgc_vpu_g1>, <&pgc_vpu_g2>, <&pgc_vpu_h1>;
> > +                       power-domain-names =3D "vpumix", "vpu-g1",
> "vpu-g2", "vpu-h1";
> > +                       clocks =3D <&clk
> IMX8MM_CLK_VPU_DEC_ROOT>, <&clk IMX8MM_CLK_VPU_G1_ROOT>,
> > +                                <&clk
> IMX8MM_CLK_VPU_G2_ROOT>, <&clk IMX8MM_CLK_VPU_H1_ROOT>;
> > +               };
> > +
> >                 gic: interrupt-controller@38800000 {
> >                         compatible =3D "arm,gic-v3";
> >                         reg =3D <0x38800000 0x10000>, /* GIC Dist */
> > --
> > 2.30.0
> >
