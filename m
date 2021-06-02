Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6A9398862
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 13:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbhFBLac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 07:30:32 -0400
Received: from mail-am6eur05on2067.outbound.protection.outlook.com ([40.107.22.67]:24064
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229541AbhFBLaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 07:30:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btdehVwwvir3U4rWcQtBelOb3vZNPaPYkLELVy53ZIeDiZdIEZ57uLzpbJ5jMSC0vRs9UDToGGIxOKU8AUysIZeUiRl3Bq3Q5QK9/IWCSx6NEbz9AY/eReLWZJfUJ08y2hrb86rvB8Mc7zkrBBomTuIeiXHGr6RegWOQe6PxznG8/hn8dvYxkJQDij0lyP5onVjuOkOPPX5FJ9/wnbM5ZWsVtYpQNRLaTmEvuGgWXiVbxGcdCDGVlzC8Yl3dMDA1M25MT1qK1+tH4FFALcQcVH9y20MkHgWluh0nI28z6jz+nistL8Jj7M+PKNJGMUmaum/TLCMGSNVmCWYQbZBfcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBwcOd95Xfjflb0NglY8P9Hki+KFos7dXNwkIjLtQJg=;
 b=cML2sMqyDLx23S/HRWR6aqr8+sb60XwNzK1oziPPsT02lJi8JkKw9cmo268US0zIGlUr06bWgJXrLHvtLXr88XnHNb+YJylAm6bPQX6SU09WG24VHpzwbWJTEXguVZBVsF3I7dufM/Qku5rzHwCt8zqwY/JM8mfWII6HV3NQZDnsQHq55SM9aBUr1AwxgW0LVg3IKDFBeIpXocPPepLAWuDXnYEyt0aXE9twc2Yxw8cNYiLLNx8kCxgyoi9OH9MKqXP9TbEJovzQCAlOC32qh328+WIgYNzH9L3wMy0YPsEpBTNfTh1kYEq4Mw8jP221eT80ORYidWt/I5Ka0BVz8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBwcOd95Xfjflb0NglY8P9Hki+KFos7dXNwkIjLtQJg=;
 b=jYPcgBdPujDfRm8NDYC2BMeLiwcsd9ESWu3KKHAtx3iile7ea+d7RU7dobbpDq4ZQWmBwuv6jB13iYc30E5yLofzO7IObJ0e2uLRxya1lDgOd3fzaPMTtp41C35MNFB0fAHlnbt+ixz4fbjF7QZPtftX9P87FHnFUN8i0oXF6kI=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0401MB2559.eurprd04.prod.outlook.com (2603:10a6:800:57::8)
 by VI1PR04MB6239.eurprd04.prod.outlook.com (2603:10a6:803:fd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 2 Jun
 2021 11:28:45 +0000
Received: from VI1PR0401MB2559.eurprd04.prod.outlook.com
 ([fe80::49a5:9:d201:2382]) by VI1PR0401MB2559.eurprd04.prod.outlook.com
 ([fe80::49a5:9:d201:2382%6]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 11:28:45 +0000
Date:   Wed, 2 Jun 2021 14:28:43 +0300
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
        <linux-arm-kernel@lists.infradead.org>,
        Clark Wang <xiaoning.wang@nxp.com>
Subject: Re: [PATCH 3/7] arm64: dts: freescale: Add adma subsystem dtsi for
 imx8dxl
Message-ID: <YLdra2JOW+/peGch@ryzen.lan>
References: <20210517171205.1581938-1-abelvesa@kernel.org>
 <20210517171205.1581938-4-abelvesa@kernel.org>
 <CAA+hA=R1-JJ+uwa0qio-twUnFW7CYDPaj26CmwuoFcP0oXcNtQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA+hA=R1-JJ+uwa0qio-twUnFW7CYDPaj26CmwuoFcP0oXcNtQ@mail.gmail.com>
X-Originating-IP: [188.27.175.31]
X-ClientProxiedBy: VI1PR0502CA0021.eurprd05.prod.outlook.com
 (2603:10a6:803:1::34) To VI1PR0401MB2559.eurprd04.prod.outlook.com
 (2603:10a6:800:57::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ryzen.lan (188.27.175.31) by VI1PR0502CA0021.eurprd05.prod.outlook.com (2603:10a6:803:1::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Wed, 2 Jun 2021 11:28:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8d557e6-46db-4fee-68a4-08d925b994fc
X-MS-TrafficTypeDiagnostic: VI1PR04MB6239:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB6239F053B6DFF843207CA092F63D9@VI1PR04MB6239.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KQshlJ0Y+WqrD1hAeywbBw5a1kdtEd5DwWv3mxW6vCJUpMAfQmjwrVyMoXx1u7aqmCX1da4sVpAhQPJ1A6u8JWEF14YjobgAIWAY7+kEaS6wTdM/MAE+LYsfHd3M6kW3D238djVAddyF6RI7DvXHPQJiDXP9kOhn1fTs6ZggbZQNkBbG3Tre93sWewX4JQgHaFhzBU8mKoBzC63iQWh28aBOEPPaAWCjya2nP/A1p56by7d0cxj4b7JX0KiF6tynKD+RVCk0c+1Jt0V1Ph3vSYroSAZBBVU+NuC/VCDM+hUD4wE3e9q6g4mzttmkuHA0o0lTla7uOwqrXjHI0dOj282dqE3oZ4I7SSOYKKKf2HV3kCyF6XQdbtZgXi1TQBIyIVi9m4e22NFBifvkPSD97/jqOMBy0im0uNy7VGZkBPCTPnmJCZhxYbZwjuZmdPevxbLJjRP/SAQG9QHg++cCzsMY61Unet9B1Ncqtmk3Q87YswWCxMLM5W9A3xuppgn9YgoDXwJUsttgoPtZdI0Zo52IksdAT/a+DUQbDZrX01bJyK/91IqTL5hppJrzZKI0uw3SHaj9cY4pxOtV66Vfc65aDePOltaGW8XQbqoEBwUTX7r/XKilZ6engCw/SpGnT7RYHn5FKL7JtJDkFTTFspQ+u6LH0aNn7pPOXSkHyn0g6F9jQABv4wG6PzSeCYGvgNk1funZr8IVZokxeu+6hglLFC+MOkD9GsaroU0LwUhQQJerTDPjJV4j50OJeZ3bb92ws115IDpUSZm//ZZHdAMQAxMQGzBS0LSPsYM25kQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2559.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39850400004)(376002)(136003)(396003)(66556008)(44832011)(6916009)(38100700002)(5660300002)(956004)(36756003)(66476007)(8676002)(7696005)(478600001)(38350700002)(16526019)(186003)(966005)(52116002)(8936002)(9686003)(6506007)(26005)(8886007)(54906003)(316002)(83380400001)(4326008)(66946007)(2906002)(45080400002)(53546011)(86362001)(55016002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?7mBKXQ38DjxPX8zfbaXwnXGvQNOkNofRiYc4/fpPkozAClXe62vBZDdclHw2?=
 =?us-ascii?Q?+DzVmlm7xs2LXngszQv2CZFGZtBa7rpZcTufRScV1a87qWo5AQFyDB7sT5MK?=
 =?us-ascii?Q?W4I2Y+yVEeLCtUcKGkw4WjlpBUVW/M4KdM/zTnVvDYJgspOGIjC4blPzMLQe?=
 =?us-ascii?Q?ax770A0bZjuft5NZTsovhOm6eHX/zFga1w7n2r5EMpIa9hHhEu5MAplYj4hz?=
 =?us-ascii?Q?1oQ/AlEW7SHK28VmUFhrzAQ5f28CEwAeqUxChC8HM0F16BG0B3QITGv+1y4d?=
 =?us-ascii?Q?NSqPrL+IpYUHtLdvAstFwmbe5Guv8wjTRlOvDgwC5s/jVQQ8KtIh/JfJfa4I?=
 =?us-ascii?Q?JAHBYNt25q8uyT4Dj2iRMrnNjrcNxqkbOu8oEHLEYIzMSq3yQ4GmY8qfFNL1?=
 =?us-ascii?Q?2YW+R4qOaUM1scEM7uRc030SEN/ChzTXW3TtFB9AsheUYHEPB2EiXYZ+C5IN?=
 =?us-ascii?Q?wT1+h1GHXwy2BWcRD/c/RrfoT7VSy7jquhxxhR5cPGyD3XXtm5MJGwSmfKmb?=
 =?us-ascii?Q?0OAZ2ttduKzBDHUhiTVLyKwQRwtQ8T23T6iWxebobi6usiC/o+Yh8lyIzlj8?=
 =?us-ascii?Q?RT012zOGQviu76WU193Rc9X0dT55DGtuMAjtYxkWDhAkir8W2P+Tq0YHdDtw?=
 =?us-ascii?Q?dEd7tOqVnXnaHvUkDiWRygizC1w1x4XS4jPsCblYOr3663j2EjUEkzr+i3ij?=
 =?us-ascii?Q?TDO3m5InuB8pT0T8urAWAavahlMVceVXe+Yk4Y6e+j0tVGxjr+pXaCxZsfgO?=
 =?us-ascii?Q?MdVIJ2oT8xCSyO1Hqd7rOQaIDnwYcCsdpRXXgXGnIeOhsB/4njerl4lihcPo?=
 =?us-ascii?Q?LdRhVS5rNMTeTfHAgvtygtyubsB7J48IRTtd1jyoHZ+s0okxNUA+gJO6AsP+?=
 =?us-ascii?Q?ls0iFYDQ3+RFuAxQQVPxWQ+PHucsISW6wnfjvYKrNYp4nMwTvEe5SUcRIJ4P?=
 =?us-ascii?Q?D/wxrJzi5DvFBGXLNAGE8voJTEVQQkcXdeR4rlOh3rsD9GBGYctQsRbsVkoh?=
 =?us-ascii?Q?j+viAvzFTgy2CwFCoHKW0d/yvwr0PmI5DP3g8WwhIM0XMIyMOZOsYIQBKBmL?=
 =?us-ascii?Q?GYT8n03Ukf6WA53jIXTtrcCWTnFW6pFGvt9rnur+2j8OZjzwezGXU6Lx59Pa?=
 =?us-ascii?Q?XxPbwF9FI462So6Mr3aFuNtzDRpbSqYDcf/r1zJkY9RLCY/d8GXSipt6eBop?=
 =?us-ascii?Q?69d7eVLjzoMYflbGZgDZWgBSgaOto3fIZoEBdvgvsHHtjrmlWuEDrfIjCjKq?=
 =?us-ascii?Q?9JsrAvyZcS9VkAAvuUkJ8THqN9mfjvPsI4lV+FErbysQVcYXwQkrsve6joH/?=
 =?us-ascii?Q?c23mU0voEvqCAOJW3vGw0Jhb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d557e6-46db-4fee-68a4-08d925b994fc
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2559.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 11:28:45.1051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rlvcz/byacd1nWWK1PHFRl44hP3aFo3L8y+BB70eIOPfKpZspVZjpvYyWXNpgediqL9/f3k0Ma70YOds8o94oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6239
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-05-18 15:52:00, Dong Aisheng wrote:
> On Tue, May 18, 2021 at 1:15 AM <abelvesa@kernel.org> wrote:
> >
> > From: Abel Vesa <abel.vesa@nxp.com>
> >
> > Override the I2Cs, LPUARTs, audio_ipg_clk and dma_ipg_clk with
> > the i.MX8DXL specific properties.
> >
> > Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> > Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> 
> Please add dt-binding update as well.
> Better along with this patch series
> 

Will do in the next version.

> > ---
> >  .../boot/dts/freescale/imx8dxl-ss-adma.dtsi   | 53 +++++++++++++++++++
> >  1 file changed, 53 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
> > new file mode 100644
> > index 000000000000..12ccbc6587ca
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
> > @@ -0,0 +1,53 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright 2019-2021 NXP
> > + */
> > +
> > +&audio_ipg_clk {
> > +       clock-frequency = <160000000>;
> > +};
> > +
> > +&dma_ipg_clk {
> > +       clock-frequency = <160000000>;
> > +};
> > +
> > +&i2c0 {
> > +       compatible = "fsl,imx8dxl-lpi2c", "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
> > +       interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
> > +};
> > +
> > +&i2c1 {
> > +       compatible = "fsl,imx8dxl-lpi2c", "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
> > +       interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
> > +};
> > +
> > +&i2c2 {
> > +       compatible = "fsl,imx8dxl-lpi2c", "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
> > +       interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
> > +};
> > +
> > +&i2c3 {
> > +       compatible = "fsl,imx8dxl-lpi2c", "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
> > +       interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
> > +};
> > +
> > +&lpuart0 {
> > +       compatible = "fsl,imx8dxl-lpuart", "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
> > +       interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>;
> > +};
> > +
> > +&lpuart1 {
> > +       compatible = "fsl,imx8dxl-lpuart", "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
> > +       interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
> > +};
> > +
> > +&lpuart2 {
> > +       compatible = "fsl,imx8dxl-lpuart", "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
> > +       interrupts = <GIC_SPI 230 IRQ_TYPE_LEVEL_HIGH>;
> > +};
> > +
> > +&lpuart3 {
> > +       compatible = "fsl,imx8dxl-lpuart", "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
> > +       interrupts = <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>;
> > +};
> > +
> > --
> > 2.31.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infradead.org%2Fmailman%2Flistinfo%2Flinux-arm-kernel&amp;data=04%7C01%7Cabel.vesa%40nxp.com%7Cc94d080848a648df0ad708d919d1f75f%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637569211861760914%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=J6uUG1sc6bXk2MNXKtBzH1AjIb%2FsmeXCw4Ww%2BqvrixQ%3D&amp;reserved=0
