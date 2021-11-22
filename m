Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 530EB458F34
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 14:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236206AbhKVNQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 08:16:21 -0500
Received: from mail-eopbgr130073.outbound.protection.outlook.com ([40.107.13.73]:48118
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231444AbhKVNQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 08:16:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAkc3lkSrap7CNaWT4dropUyFAYo3kmKOKl2gw7JJNpuqUZmue1XeJZyIyTP+L5/zzBJflYLjKShUlci15iQNR4I1Pv6N3SIPB58t7MztXYBcc11KTVr2zIMUdH1JDp3cHiSJlIHYH/jibXk6+HkwkwTGgZoXP/bfv8Y7nQSXmGChh8WlMlZevBJP2KAjk2dBdUM2VBkT2sZp8+r5Xc4dvy6Z0jilDd/Jh2SmTGxf4k7U27QS2+XYH2wJTINVRHpaRVt5SBtgQ3QppvApmg2zkS2aEtqA6yQ9gvMjr/2vfVrtRo5x892TsD62oHY357DmjLBWHRa2C7SfkVyAWAtIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/3ytnTCbvSC7qBm/Z4gUU6lwngNVsPz32jMYR/DkEw=;
 b=gXTkc07uLdj2TjrM/SLLtnGjZEKB2PntRb5dKrGUQpRc4bQDvsJ1/EVMB3rQ2VvxeIn0gTJPkVurWdV7O9Q6j3ggtRCroXbiv6XYXFlGTxoQvLKLghbDaON7tdyAmMn5AfHLR7CU5oy4R4SRwM6rkfBvvD6zyKwQ6cTZn5CTBG94Ew82UzMNSYThwl16eOtudZiZ28kCdazoisQ5WJ7tZ2/K+MKj7XzpHujKULFwqLyl6OeEJr9hUoYZtueo22fAR9N0FfkpBogYwbRVUjqWoJhEvkoi5Sj/wkx66AkRtu6Hn1nJeDaNSqQFLYAFFOvXSmbvjMRYiPrUBiWW9jWdoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/3ytnTCbvSC7qBm/Z4gUU6lwngNVsPz32jMYR/DkEw=;
 b=rKcIwyB1DqvJZtxGHRupntYn/7hlqOSvUtxLeqA1heOTc6SwYvQL5qktHhB/bwo+VjMqlL1rcSD52PYchFmSbS96vv4n5MnhRczXt1sCXom4dC9xEW0sXxLBQoA/ohUvKh1Md82f8233V8T4BnyDbHdLAC7NvselDP3tG/MVNxI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR04MB6125.eurprd04.prod.outlook.com (2603:10a6:803:f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Mon, 22 Nov
 2021 13:13:09 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::d0eb:49aa:2a9:9fc4]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::d0eb:49aa:2a9:9fc4%4]) with mapi id 15.20.4713.025; Mon, 22 Nov 2021
 13:13:09 +0000
Date:   Mon, 22 Nov 2021 15:13:06 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] clk: imx: imx8ulp: set suppress_bind_attrs to true
Message-ID: <YZuXYv7jrczCknjJ@ryzen>
References: <20211022131513.17381-1-peng.fan@oss.nxp.com>
 <DU0PR04MB9417315309391B3E19C3F1FF889D9@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB9417315309391B3E19C3F1FF889D9@DU0PR04MB9417.eurprd04.prod.outlook.com>
X-ClientProxiedBy: VE1PR03CA0016.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::28) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
Received: from ryzen (5.12.226.136) by VE1PR03CA0016.eurprd03.prod.outlook.com (2603:10a6:802:a0::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Mon, 22 Nov 2021 13:13:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c78310c2-8530-407a-5a3d-08d9adb9d401
X-MS-TrafficTypeDiagnostic: VI1PR04MB6125:
X-Microsoft-Antispam-PRVS: <VI1PR04MB612580B20A6674F0429C259EF69F9@VI1PR04MB6125.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l8hZDVEyUytAaFZ2YYto1Yh3ne73IGF85p/Zl3kr9WKqIwMGfGkU9srC64jRI1eJgjg50PttG0V0fcweaJ8X6Y0RHqeP4viHRMei+CKUuc18QfZV1a4K23bVlJYs0F3klgvMoM5ZTTAtN1TpPqRLHNBXUkCsyFVj56bdlKe697602R+k2oc/lJo4oi2QFcSt2bGIpNlCYRqJBeSPiGvCnKZsttH+UgJ+Pk3tSApHZK+1jRP29yyVA9Nd1IXFxgJ+FrRseoLGA6ZstaYHjjZMl4CmX+RfOrzQrSli4YxiU6EhqnhPUmKoQEdXXpgvgeo+/efA/oHSLpZyCWAu364cWpPV8OY/BrjWz/djEUM7YmdAFpnGhxgKzm30WnIo6mKzBkJ4QUsEW08OdzjI/+uE380iEc1TAj3TKArb8R5MuvWi+irlNHY+ja3ji58CcOpglWdN52zk71UiDnrhxuPfxlT+Ev/ZsFcfPBH/iHu54Z9GhyVOpHgWGdVCA8dgOx3JbRK3EVKcg+u1C39LsTWfEpXFWL196gnJjWUWZ8okAa3DGPyjxSojXER6PQKE+KXbF96aseBPENCKM4vyhdEBwxjyWRw0OnjrqWDRgR/EV7sZIepfAp51izbYO06xaxKsqv74CwCDZiRaYY4PaBWOfjgQmfBSgKn5fyDb/UCyvw6sEO4CyeUpR6obXgcEwzyGUMj79jpsa3JZuLnrx36Kq6lNQfakCZl/GwUqNzmUr/Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(6862004)(9576002)(55016002)(956004)(316002)(66476007)(8676002)(86362001)(44832011)(9686003)(38100700002)(38350700002)(54906003)(6496006)(186003)(66946007)(508600001)(5660300002)(26005)(66556008)(6636002)(8936002)(83380400001)(4326008)(53546011)(2906002)(33716001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lJsEKIjzOXkhdt4aYzdJAs0qxwTmSL6YI7NiJCcSIDO9cIvmE5mdhaTMZqlg?=
 =?us-ascii?Q?7BVkxvTHXrkxz2iv/9WlxXs8ujwoEqUqGaw8ufSMWK8aCbSJQKxIq4EjNlfo?=
 =?us-ascii?Q?Qx0aGi7d5s0bzCoM6u74zGpuHrujrWWvmEDe4R8weQ2Gs/2uZ6tuBV27HpZ9?=
 =?us-ascii?Q?WMh9d7QLBSwW3wnhi/mDujfhTEOKn/54spca2O6I/B4CNrsEb566K64dwkdL?=
 =?us-ascii?Q?XuiIMHG9e5UiaGrHaibZ6EtkEeJNyrzJQYZOscfLhHDCrHIODoNN17HlwQGN?=
 =?us-ascii?Q?+4e1zxgXWfE9X0mm0SCpmzc4JlBDAXH5v3yVIuW3bsqrThhpzp/VGTNUEy0x?=
 =?us-ascii?Q?WJlnu7QyR1P3LS0WH8JKsSQpRMpslgiRDAGQqBgzHA1oc9uLtacXVKCJR9YF?=
 =?us-ascii?Q?FwUEvtlZ+2QxM+rM1cMCdNFA/vEOL2ApfSv1B47A7U7Rd6M3Z5t7h9UjqIie?=
 =?us-ascii?Q?MmZ+1HryxJ8DUbYyuycGGVGZz+s3NIaHPqH8E/qUPVOLqQ9gWWWaC4NcoS9c?=
 =?us-ascii?Q?Rf3Hgj2PtdVTutmnC0o71Xwyxl1JGHLNVZ6TM0hEFc7e9GO66ST6d1U/Kiec?=
 =?us-ascii?Q?I+rKC0LjE6fMLBc3Wco+bQq+kpVBRcDZikS/WL0dunY23fuleY7wwngtL+zo?=
 =?us-ascii?Q?jctGw4CIUfcs+BECzqiCx+TPnhE+GgkycNuX5UFH8jFaHE/x1ufmjTeDTzE1?=
 =?us-ascii?Q?6NXYGqUz26P34S5Eq6CbqsXlW1HKHJTbrhj+j7g585aKJzSr1m6xVQl651sR?=
 =?us-ascii?Q?4waCc0xA3WVcmU23ZCtEXOHwLvpWm46tC893PeLO8gOgZfFXLwHuHWJVIPnH?=
 =?us-ascii?Q?AoEfUNSdP6s2BmYWnaXeOh/0oMbdfn3jDrpe5xm79yPtNgVe51683N0/ZncU?=
 =?us-ascii?Q?DCZx1y4/WU1CzuZ+I2fkR4J3caetVZSLH4qxG6aGGW9NePNQSnZGqjMAeQuV?=
 =?us-ascii?Q?C/4SSYoPD5FDfLWxTj6AsSM0HFeSQx/rDn6HFlylO/5nbNTsz8PaVTrWIwTF?=
 =?us-ascii?Q?3iVLUsXkzf66aApkgyx79p1txo6XeZjFGqxpcBNC5kL0cSdtJfEOs2slM0TX?=
 =?us-ascii?Q?QIxD2cZEj+hTiEM5jlP4bAuBUTktAQzlJ2DKIimiQGnFP8xmf2Bdq/3evt23?=
 =?us-ascii?Q?BWVeai8BNqARjnd5BBCn2/AB8efYfV629t4Bu5XlHfSsACNkxod78E77sbhq?=
 =?us-ascii?Q?wRX4k/dSzpKTCFkhXyfVxvdzNOwm2SFcbBhfVx/ezPZyvBN8ms+OvaF90+uS?=
 =?us-ascii?Q?hb2R++c66F8eFLXQxGGXcnwnbt8wj23TyAlxTr5zfNboDLBS8uTbwZC1KGD4?=
 =?us-ascii?Q?rmZTTiZCJVASTbVv/YOwab/suN9SZ0WWtirBr3gKkls0C96hsYaXWMVnMhbz?=
 =?us-ascii?Q?xWVfVa+6plGVBtXL5OqUPoPKJ7r+Ek18n2EYvhE1YM7vNpw4jCQc3d/j1tJV?=
 =?us-ascii?Q?oD66yVaWcvRGFylf7Pa/Q/Hadvz/gi3D/h9UYpQ/fmSEUNSHtQeglUMZGCI0?=
 =?us-ascii?Q?Z7opJ/NHjqmOQ7khYvP/UkeF0/YaZ9tdXYpiMUrMrjzsbNNgsJh6eSvOHpnK?=
 =?us-ascii?Q?VRtd9AfQreg/JazYJ+OX/D2r2woFv7yvR+IU4CVl7PONPWetMD+tFUVE8gGt?=
 =?us-ascii?Q?zu5rNG9HR+2uqrlejlcWqOA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c78310c2-8530-407a-5a3d-08d9adb9d401
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 13:13:08.9188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T0kLRumRxfSUj1mc25gyVgTWIJf+X3zrRFhLn6uwXvL0d2RmE4hd+hs6y6g/PVUilfLo5wogbHu+AD80D4eP2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6125
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-11-20 14:04:30, Peng Fan wrote:
> > Subject: [PATCH V2] clk: imx: imx8ulp: set suppress_bind_attrs to true
> 
> Ping..
> 

Applied, thanks.

> Thanks,
> Peng.
> 
> > 
> > From: Peng Fan <peng.fan@nxp.com>
> > 
> > The clock driver is registered as platform devices and it is possible to reloading
> > the driver at runtime.
> > 
> > But actually the clocks should never be removed to make system work,
> > attempting to bind again would result in a crash, because almost all devices
> > depends on clock to function well.
> > 
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> > 
> > V2:
> >  Update commit log to explain more
> > 
> >  drivers/clk/imx/clk-imx8ulp.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/clk/imx/clk-imx8ulp.c b/drivers/clk/imx/clk-imx8ulp.c
> > index 6699437e17b8..8eb1af2d6429 100644
> > --- a/drivers/clk/imx/clk-imx8ulp.c
> > +++ b/drivers/clk/imx/clk-imx8ulp.c
> > @@ -559,6 +559,7 @@ static struct platform_driver imx8ulp_clk_driver = {
> >  	.probe	= imx8ulp_clk_probe,
> >  	.driver = {
> >  		.name		= KBUILD_MODNAME,
> > +		.suppress_bind_attrs = true,
> >  		.of_match_table	= imx8ulp_clk_dt_ids,
> >  	},
> >  };
> > --
> > 2.30.0
>
