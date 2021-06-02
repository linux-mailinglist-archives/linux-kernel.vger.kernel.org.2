Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928A139854A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 11:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbhFBJbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 05:31:20 -0400
Received: from mail-eopbgr00071.outbound.protection.outlook.com ([40.107.0.71]:24900
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229631AbhFBJbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 05:31:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbHpyvWwmfqdrpD4FOUynVg8yN3pQ9niGFcyjjaFh0YPWeYsuCsLB7U66RU4aZ35/T+b6wpL4dfvh7k/MmebSO558fyafKOqnhtDjlAjR9vzxsSyWXfSkNJhvqr/EGofifNNwTnen6ag6MgAJyvvG2UtYSgjzn86nGs/HYAs4kcNV5o4U/sgCw/Q18pw1X8VknFfmizKdbLuDqCowXp+4fRC6wRMuDqualQd8wezrSnhQ8iowgMHTRKhMFR46qGtC/nMVjxbm/sAhmgLcfz/MWNqu8+DhuL7wVKJbEqMvQXi+y39NRPyiyD/jwWithzS3Gn0ODnwPojwFuxi7/qBKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfEDMyrQ5mbaEeHretSc4BQgoQRVbrZuEfnUYNmkhvc=;
 b=AUqZ2e37767zgtqsG/d22+tUpKMuIcOqY+l5tldtVM3UjdHcj1Agsr/wUw2dQmiroyOPkVeH4R5e8Zo7qbkzDEx8EtuBKkaI8E9P+ZBqkIXTYgcG/8wwssPPSzCJUX83erST09wTTIInN/l8eRVJPq7I4fOe9twFIukIWkTdBYY3Jmdmg9HFsbiXW1yBh4bWXHGF9wf4o7s4LEanwff0nuMKuZ7Opxr3a9kyxxgtr8kStd3KgJYayS0EVgFT5EWo+NUY5PqUnu9Koku2Yt9pzT6KgeBP46c3xvqc70vQHoedRcjwZy645vrWa90kTwA1gNgE/g2BqiqfvkpMxOZJDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfEDMyrQ5mbaEeHretSc4BQgoQRVbrZuEfnUYNmkhvc=;
 b=n+gifG0enr1kPTgf9Y4+XCqFHs5MBeW32SL6pPo6f6Lz9FDLIJ8FtOpOY6roO11Ty50KEnMGofkMTUwIKv8bGXNxcULkI50AJf0fSmqwJxNOLntvPBfhLChFWU8FbBGk8q7dlLEQYKN8QSvcUwLfW4sFVjFpT5BlAyXWhtuajnM=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0401MB2559.eurprd04.prod.outlook.com (2603:10a6:800:57::8)
 by VI1PR04MB5085.eurprd04.prod.outlook.com (2603:10a6:803:55::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 09:29:33 +0000
Received: from VI1PR0401MB2559.eurprd04.prod.outlook.com
 ([fe80::49a5:9:d201:2382]) by VI1PR0401MB2559.eurprd04.prod.outlook.com
 ([fe80::49a5:9:d201:2382%6]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 09:29:33 +0000
Date:   Wed, 2 Jun 2021 12:29:31 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Dong Aisheng <dongas86@gmail.com>
Cc:     Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/7] arm64: dts: freescale: Add the top level dtsi
 support for imx8dxl
Message-ID: <YLdPe4Km5qXDG7eE@ryzen.lan>
References: <20210517171205.1581938-1-abelvesa@kernel.org>
 <20210517171205.1581938-2-abelvesa@kernel.org>
 <CAA+hA=SVGCeroox_Ld7Etr20j8fRLwYGpc8Ee2reY6Koy3bX6g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA+hA=SVGCeroox_Ld7Etr20j8fRLwYGpc8Ee2reY6Koy3bX6g@mail.gmail.com>
X-Originating-IP: [188.27.175.31]
X-ClientProxiedBy: VI1PR08CA0092.eurprd08.prod.outlook.com
 (2603:10a6:800:d3::18) To VI1PR0401MB2559.eurprd04.prod.outlook.com
 (2603:10a6:800:57::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ryzen.lan (188.27.175.31) by VI1PR08CA0092.eurprd08.prod.outlook.com (2603:10a6:800:d3::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend Transport; Wed, 2 Jun 2021 09:29:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ddc50ee-8889-42ac-f125-08d925a8ee06
X-MS-TrafficTypeDiagnostic: VI1PR04MB5085:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB5085EB9991946BFD361F4788F63D9@VI1PR04MB5085.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eIufk00tclOrP/ALtQh92klH8ONmekb6V+wI0ov9zuFdzHjTgOoP4hNfvviZHaorjyNJSZ/sQ5NwPfa5jx/7nZ5V1ldr3t0N4bNRrhLJG/ts7+ztig8CsgF0zp1BfoaoAoWnoOfqa5YUu4+Ou3hcC4HhXm/vo0784+Jb6pBWy7ALTTqbHGQk9vatgFE4Qsh8VA/k0A/ZH5332WfKZDRgfCIe/8qaxUK++aUyuMGcJB+1Dm9TldlgbPVrYKrdIEmNhLoyaMzJ9rwHB/tV0RLpL/NV41Bp/xA0gkiRaJMErDSrimJEPBJsgZIKMx5orjLXTVjDiWYr91QmTQJP541e75NlvlVAvxhZ041gURa0VQKBq5RBLQXQYXeGGsEGdVigv+c7pLvovYMmU+QwH7P9i5GA3FTOS8qSDSPZ16FP0PJ0TzUrd8A/WGmXDWeX17I4zCHwKBI0VjpmlK1iUwWUcbPVV3ee+T4O6bJ3ciQqpZH+KUG5YVclfp1pD8AwU/d0mrozA8JoFQf6LAjaki6xeRY2R3QiQi4VqAbiDOvcrWCkVtIXUU4CRUKXlIpygJGJhI4aBxTpPbtwhsCA9LYQKwitPeOsRFO+dwKlSgrRQghShqDfBGrf02Z/evVEHZ5AsuT4ClzYZ9RlaAhcCDXuHdY0D+4uqQIj/Ci2nXwnAtvzmVMvKNjXqQ0VK6nvyAwhtJ3wtuNJgYhzkxghjX0LCVeMmrS2DcUlkVL0E4wzbfslUBzM9GhvYSqBMTaSKGo0zJJtm7NsCJ0KDtQLkju04dDyqKCUo60ZXglLi3kvjrg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2559.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(346002)(39860400002)(136003)(478600001)(2906002)(4326008)(66476007)(6916009)(8936002)(66556008)(86362001)(66946007)(5660300002)(316002)(45080400002)(186003)(55016002)(44832011)(52116002)(7696005)(956004)(83380400001)(9686003)(26005)(38350700002)(8886007)(6506007)(966005)(36756003)(8676002)(30864003)(54906003)(53546011)(16526019)(38100700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Zq3zmJrQw9ti9n97/fPbt9wyn3CAPm7sgB8qCE25WRnHnwqE289xFVH6TnCW?=
 =?us-ascii?Q?KSqh6go0uAegzlfA0L6GYZvvl/p+nVLuofbH+BeA83WMnOFHlVrlNrFnP9vY?=
 =?us-ascii?Q?7+PRxPOJewEgKBtbKi47+r6Fv9mFurDLUKX0UxjyCjLDfk/DEvjNQPo+NTHL?=
 =?us-ascii?Q?ujJGbdzsL811wsmNH1aLGbzOAWxw/UszCGCbMFUXdKjYdVqT+xXsrt4sH1Cs?=
 =?us-ascii?Q?mm0ogVGLp/glKLzOgGgr+IAp9CjNCRBhuImHvSiRoxdbssiyXD5Bimm08NZk?=
 =?us-ascii?Q?Q2GakaDV2SQjaBnF9Enyz0qz0ZNikac+33ZhNGWVb0XMVsjwPlKshynH0Vwi?=
 =?us-ascii?Q?vXoLbMAzypemJNCX5TLl/MVPR/gJ5sDncBXaZxgFF3jh1OQ1k/N4XIxjsu2x?=
 =?us-ascii?Q?Tt5qKzmcsodagRVkvB/BT6sOM6J8wWT9PyNOVlSQDfSBcARMyG4mXJnwppLv?=
 =?us-ascii?Q?M29EMHIQCa6vlJrTuBNyYN8aZaacegJuAIya+IAInmxAY3PdKsiaVcWsznnP?=
 =?us-ascii?Q?p9AsHUuI4B6gxRW+0GLubu9hZdkR+odLLbWWanLkPfg8EFk8S4gYiO7xjRXK?=
 =?us-ascii?Q?R+yPbMw6XkQrju3d1Dd+xe0BpojWrQg6/skJoiuUS3d+HvjebPAQCODjWZ4r?=
 =?us-ascii?Q?QJKtffshzgPTTZA2rjyY4PU82s2HEMDW5ArPNt4cWt3Sg9Nd21icravUJ3LD?=
 =?us-ascii?Q?oydyOn0SRm8ob0AFUGD4XiWqM4IUfDCdtt4F6THA8kykf1rgVLCptJ1nzn4D?=
 =?us-ascii?Q?kfUK5nnpOGTzGJlDnGXt7+H8Ta09S8BT3lsMXPbuW3x3DnCfJzUdZf11WXO8?=
 =?us-ascii?Q?XARHmUPL8qkN9k/kGcvmdlL1YGveMRU/7rSp2szPOgX/iKqBzXgO+Ysq5Gi9?=
 =?us-ascii?Q?ouJ1qvvzjrAF5P9xA91WB7EZNlZseR8S78TWRFjj1jqaUQxT5345vsmnZopW?=
 =?us-ascii?Q?K9OyIlMJqyj+vX0MYSl6HOtnb+AQ1PTXpYwi+YSvTKs3zEefEIZgG95wDvYW?=
 =?us-ascii?Q?pVP6Z2FVNYDBnFXAOXKVAMejUkemUIS6wvGesX7GW/L7VY/Z97LhVOmeQXgF?=
 =?us-ascii?Q?wBR4xCbexCvb6gx/Dq1tNJBfTzBzDXHNVpd1uj5OK8HQq3VkQ3yAm5mGNlm3?=
 =?us-ascii?Q?JSz8IwkpbEsOpd2ZltAT0oylnNpB+mcMxoGYeSIgkdb5u5sIiMigtbYBOCBM?=
 =?us-ascii?Q?+Mw+rxzz0Am/3+melXbKN5jrVDFTEw8GiYiTVIDxBfVJb5EMAaO1XyZNsqET?=
 =?us-ascii?Q?5pfxsTWP30/WQQuAr5kt7WhwhOHW9uqOovQ2r4cCHlV23IneHqpDoD6k3nwl?=
 =?us-ascii?Q?qbulIoqHzwm2AlKu03AgMAlq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ddc50ee-8889-42ac-f125-08d925a8ee06
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2559.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 09:29:32.9620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o9yxMYuEflBqHRizkzpaUhkTQEdge5d5IbOjEX/R5mBdAmUx3ujxcgjL8Q/xio2rtMw3DDw8aCArfu3vbnLrhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5085
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-05-18 15:35:41, Dong Aisheng wrote:
> On Tue, May 18, 2021 at 1:14 AM <abelvesa@kernel.org> wrote:
> >
> > From: Jacky Bai <ping.bai@nxp.com>
> >
> > The i.MX8DXL is a device targeting the automotive and industrial
> > market segments. The flexibility of the architecture allows for
> > use in a wide variety of general embedded applications. The chip
> > is designed to achieve both high performance and low power consumption.
> > The chip relies on the power efficient dual (2x) Cortex-A35 cluster.
> >
> > Add the reserved memory node property for dsp reserved memory,
> > the wakeup-irq property for SCU node, the imx ion, the rpmsg and the
> > cm4 rproc support.
> >
> > Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> 
> FIrst of all, did you run make dt_binding_check?
> I wonder there're dt binding missing for a few nodes
> 

Fixing those in the next version.

> > ---
> >  arch/arm64/boot/dts/freescale/imx8dxl.dtsi | 286 +++++++++++++++++++++
> >  1 file changed, 286 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx8dxl.dtsi
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8dxl.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
> > new file mode 100644
> > index 000000000000..43e0bcdc2469
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
> > @@ -0,0 +1,286 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright 2019-2021 NXP
> > + */
> > +
> > +#include <dt-bindings/clock/imx8-clock.h>
> > +#include <dt-bindings/firmware/imx/rsrc.h>
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +#include <dt-bindings/input/input.h>
> > +#include <dt-bindings/pinctrl/pads-imx8dxl.h>
> 
> this depends on pinctrl driver. Is that upstreamed already?
> 

It is upstreamed.

> > +#include <dt-bindings/thermal/thermal.h>
> > +
> > +/ {
> > +       interrupt-parent = <&gic>;
> > +       #address-cells = <2>;
> > +       #size-cells = <2>;
> > +
> > +       aliases {
> > +               ethernet0 = &fec1;
> > +               ethernet1 = &eqos;
> > +               gpio0 = &lsio_gpio0;
> > +               gpio1 = &lsio_gpio1;
> > +               gpio2 = &lsio_gpio2;
> > +               gpio3 = &lsio_gpio3;
> > +               gpio4 = &lsio_gpio4;
> > +               gpio5 = &lsio_gpio5;
> > +               gpio6 = &lsio_gpio6;
> > +               gpio7 = &lsio_gpio7;
> > +               i2c2 = &i2c2;
> > +               i2c3 = &i2c3;
> > +               mmc0 = &usdhc1;
> > +               mmc1 = &usdhc2;
> > +               mu1 = &lsio_mu1;
> > +               serial0 = &lpuart0;
> > +               serial1 = &lpuart1;
> > +               serial2 = &lpuart2;
> > +               serial3 = &lpuart3;
> > +       };
> > +
> > +       cpus: cpus {
> > +               #address-cells = <2>;
> > +               #size-cells = <0>;
> > +
> > +               /* We have 1 clusters with 2 Cortex-A35 cores */
> > +               A35_0: cpu@0 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a35";
> > +                       reg = <0x0 0x0>;
> > +                       enable-method = "psci";
> > +                       next-level-cache = <&A35_L2>;
> > +                       clocks = <&clk IMX_SC_R_A35 IMX_SC_PM_CLK_CPU>;
> > +                       #cooling-cells = <2>;
> > +                       operating-points-v2 = <&a35_opp_table>;
> > +               };
> > +
> > +               A35_1: cpu@1 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a35";
> > +                       reg = <0x0 0x1>;
> > +                       enable-method = "psci";
> > +                       next-level-cache = <&A35_L2>;
> > +                       clocks = <&clk IMX_SC_R_A35 IMX_SC_PM_CLK_CPU>;
> > +                       #cooling-cells = <2>;
> > +                       operating-points-v2 = <&a35_opp_table>;
> > +               };
> > +
> > +               A35_L2: l2-cache0 {
> > +                       compatible = "cache";
> > +               };
> > +       };
> > +
> > +       a35_opp_table: opp-table {
> > +               compatible = "operating-points-v2";
> > +               opp-shared;
> > +
> > +               opp-900000000 {
> > +                       opp-hz = /bits/ 64 <900000000>;
> > +                       opp-microvolt = <1000000>;
> > +                       clock-latency-ns = <150000>;
> > +               };
> > +
> > +               opp-1200000000 {
> > +                       opp-hz = /bits/ 64 <1200000000>;
> > +                       opp-microvolt = <1100000>;
> > +                       clock-latency-ns = <150000>;
> > +                       opp-suspend;
> > +               };
> > +       };
> > +
> > +       reserved-memory {
> > +               #address-cells = <2>;
> > +               #size-cells = <2>;
> > +               ranges;
> > +
> > +               dsp_reserved: dsp@92400000 {
> > +                       reg = <0 0x92400000 0 0x2000000>;
> > +                       no-map;
> > +               };
> > +       };
> 
> this could be added when enabling DSP in case any changes required in upstream
>

Unfortunately, the imx8-ss-adma already depends on it. So it needs to go
in now, otherwise it won't build.

> > +
> > +       rpmsg: rpmsg{
> > +               compatible = "fsl,imx8qxp-rpmsg";
> 
> I belive this is still not supported in upstream
> so drop it first
> 

Removed in the next version.

> > +               /* up to now, the following channels are used in imx rpmsg
> > +                * - tx1/rx1: messages channel.
> > +                * - general interrupt1: remote proc finish re-init rpmsg stack
> > +                *   when A core is partition reset.
> > +                */
> > +               mbox-names = "tx", "rx", "rxdb";
> > +               mboxes = <&lsio_mu5 0 1
> > +                         &lsio_mu5 1 1
> > +                         &lsio_mu5 3 1>;
> > +               mub-partition = <3>;
> > +               status = "disabled";
> > +       };
> > +
> > +       imx8dxl_cm4: imx8dxl_cm4@0 {
> > +               compatible = "fsl,imx8qxp-cm4";
> 
> i'd suggest drop it first and add in separate patch
> as it's still not supported
> 

Removed in the next version.

> > +               rsc-da = <0x90000000>;
> > +               mbox-names = "tx", "rx", "rxdb";
> > +               mboxes = <&lsio_mu5 0 1
> > +                         &lsio_mu5 1 1
> > +                         &lsio_mu5 3 1>;
> > +               mub-partition = <3>;
> > +               core-index = <0>;
> > +               core-id = <IMX_SC_R_M4_0_PID0>;
> > +               status = "disabled";
> > +               power-domains = <&pd IMX_SC_R_M4_0_PID0>,
> > +                               <&pd IMX_SC_R_M4_0_MU_1A>;
> > +       };
> > +
> > +       gic: interrupt-controller@51a00000 {
> > +               compatible = "arm,gic-v3";
> > +               reg = <0x0 0x51a00000 0 0x10000>, /* GIC Dist */
> > +                     <0x0 0x51b00000 0 0xc0000>; /* GICR (RD_base + SGI_base) */
> > +               #interrupt-cells = <3>;
> > +               interrupt-controller;
> > +               interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> > +       };
> > +
> > +       pmu {
> > +               compatible = "arm,armv8-pmuv3";
> > +               interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
> > +       };
> > +
> > +       psci {
> > +               compatible = "arm,psci-1.0";
> > +               method = "smc";
> > +       };
> > +
> > +       scu {
> > +               compatible = "fsl,imx-scu";
> > +               mbox-names = "tx0",
> > +                            "rx0",
> > +                            "gip3";
> > +               mboxes = <&lsio_mu1 0 0
> > +                         &lsio_mu1 1 0
> > +                         &lsio_mu1 3 3>;
> > +
> > +               pd: imx8dxl-pd {
> > +                       compatible = "fsl,imx8dxl-scu-pd", "fsl,scu-pd";
> > +                       #power-domain-cells = <1>;
> > +                       wakeup-irq = <160 163 235 236 237 228 229 230 231 238
> > +                                    239 240 166 169>;
> 
> drop this property first which is still not supported
> 

Removed in the next version.

> > +               };
> > +
> > +               clk: clock-controller {
> > +                       compatible = "fsl,imx8dxl-clk", "fsl,scu-clk";
> > +                       #clock-cells = <2>;
> > +                       clocks = <&xtal32k &xtal24m>;
> > +                       clock-names = "xtal_32KHz", "xtal_24Mhz";
> > +               };
> > +
> > +               iomuxc: pinctrl {
> > +                       compatible = "fsl,imx8dxl-iomuxc";
> 
> make sure pinctrl upstreamed
> 

It is upstreamed.

> > +               };
> > +
> > +               ocotp: imx8qx-ocotp {
> > +                       compatible = "fsl,imx8dxl-scu-ocotp", "fsl,imx8qxp-scu-ocotp";
> 
> need update binding doc as well
> 

Will do in the next version.

> > +                       #address-cells = <1>;
> > +                       #size-cells = <1>;
> > +
> > +                       fec_mac0: mac@2c4 {
> > +                               reg = <0x2c4 6>;
> > +                       };
> > +
> > +                       fec_mac1: mac@2c6 {
> > +                               reg = <0x2c6 6>;
> > +                       };
> > +               };
> > +
> > +               rtc: rtc {
> > +                       compatible = "fsl,imx8dxl-sc-rtc", "fsl,imx8qxp-sc-rtc";
> 
> pls update dt binding as well
> 

I'll actually remove this in the next version.

Will be sent later on as a separate patch.

> > +               };
> > +
> > +               watchdog {
> > +                       compatible = "fsl,imx-sc-wdt";
> > +                       timeout-sec = <60>;
> > +               };
> > +
> > +               tsens: thermal-sensor {
> > +                       compatible = "fsl,imx-sc-thermal";
> > +                       #thermal-sensor-cells = <1>;
> > +               };
> > +       };
> > +
> > +       timer {
> > +               compatible = "arm,armv8-timer";
> > +               interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>, /* Physical Secure */
> > +                            <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>, /* Physical Non-Secure */
> > +                            <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>, /* Virtual */
> > +                            <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>; /* Hypervisor */
> > +       };
> > +
> > +       thermal_zones: thermal-zones {
> > +               cpu-thermal0 {
> > +                       polling-delay-passive = <250>;
> > +                       polling-delay = <2000>;
> > +                       thermal-sensors = <&tsens IMX_SC_R_SYSTEM>;
> > +
> > +                       trips {
> > +                               cpu_alert0: trip0 {
> > +                                       temperature = <107000>;
> > +                                       hysteresis = <2000>;
> > +                                       type = "passive";
> > +                               };
> > +                               cpu_crit0: trip1 {
> > +                                       temperature = <127000>;
> > +                                       hysteresis = <2000>;
> > +                                       type = "critical";
> > +                               };
> > +                       };
> > +                       cooling-maps {
> > +                               map0 {
> > +                                       trip = <&cpu_alert0>;
> > +                                       cooling-device =
> > +                                       <&A35_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +                                       <&A35_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> > +                               };
> > +                       };
> > +               };
> > +       };
> > +
> > +       clk_dummy: clock-dummy {
> > +               compatible = "fixed-clock";
> > +               #clock-cells = <0>;
> > +               clock-frequency = <0>;
> > +               clock-output-names = "clk_dummy";
> > +       };
> > +
> > +       xtal32k: clock-xtal32k {
> > +               compatible = "fixed-clock";
> > +               #clock-cells = <0>;
> > +               clock-frequency = <32768>;
> > +               clock-output-names = "xtal_32KHz";
> > +       };
> > +
> > +       xtal24m: clock-xtal24m {
> > +               compatible = "fixed-clock";
> > +               #clock-cells = <0>;
> > +               clock-frequency = <24000000>;
> > +               clock-output-names = "xtal_24MHz";
> > +       };
> > +
> > +       imx_ion {
> > +               compatible = "fsl,mxc-ion";
> 
> drop this unsupported node
> 

Removed in the next version.

> Regards
> Aisheng
> 
> > +               fsl,heap-id = <0>;
> > +       };
> > +
> > +       sc_pwrkey: sc-powerkey {
> > +               compatible = "fsl,imx8-pwrkey";
> > +               linux,keycode = <KEY_POWER>;
> > +               wakeup-source;
> > +       };
> > +
> > +       /* sorted in register address */
> > +       #include "imx8-ss-adma.dtsi"
> > +       #include "imx8-ss-conn.dtsi"
> > +       #include "imx8-ss-ddr.dtsi"
> > +       #include "imx8-ss-lsio.dtsi"
> > +};
> > +
> > +#include "imx8dxl-ss-adma.dtsi"
> > +#include "imx8dxl-ss-conn.dtsi"
> > +#include "imx8dxl-ss-lsio.dtsi"
> > +#include "imx8dxl-ss-ddr.dtsi"
> > --
> > 2.31.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infradead.org%2Fmailman%2Flistinfo%2Flinux-arm-kernel&amp;data=04%7C01%7Cabel.vesa%40nxp.com%7C843de7d5f11f49ba992408d919cfafdc%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637569202065001061%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=ZmB%2FXRdAz3Y0q2FFu2C2Y6cqYbfDQkk7Q1SNqESO2zc%3D&amp;reserved=0
