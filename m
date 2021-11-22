Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11526458F77
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 14:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238205AbhKVNha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 08:37:30 -0500
Received: from mail-eopbgr30076.outbound.protection.outlook.com ([40.107.3.76]:61422
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231935AbhKVNh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 08:37:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RhKbjF0J5fmeBE0/MxzaI7WrCLBeiTfKTSNDhMUb+cXscoTPPlxhrVNikhaofQQRQMWtTW0ekw0pZmOMhE4+P16LFeTyfr0pAhq4beo+QHa+AzJK4RG9tmxaO13gTIEshCYaBL+aCbTHeNhncDxBsHvcRNiLS3zY1Nw8lxsr3F6C/VHrrT524mjcXEtGrO1og6eCbGyM1CDDwT2yNrFnaITaQ25VMx2SEWJxb02CtyBlf8gB1kYtO7aHdmZjk35CgPgp0+/l81LiHzfVma2JvP9wdFUvl+BGjojmMphAJZI+xh2BZaTbeGayvWw1JgwjkSPICtaR93ltym63omQCmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TA80l3nz/AUkM6LwOIS1uJ2ORPL7wl6d1ZXo7zjivO0=;
 b=Rads589um4NbFTRcaWE+rKmex7RO+Kk8tgCHuy8vmXhl29zkEyA5Fv+9iCugg2EbkTbbcLNBJ+fi0O6hYuFR6mc+5WKDuQbQ0SZEGzWnafPLqY/cqi74wbEk2xQZd16jY6q7tT0Lzk/FH1L/moJkkA/mDwlWLOKjT1/NL0cCQxvHL/RAwnyfMJltBe3ZtwdXvXu3+/EbnbR07nEByG9iJpIASVH6ln3UKIHvzJwHFQpncZHFGTmSE1j0dZ/ei8n7azzNgaBGv7YGg5Ta6aEtkEVRNmiAyiVWassVUCVEQFtg3aujm725rlVJVwUfXm/JHZ71TnGEIpVEPWMHFoNPhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TA80l3nz/AUkM6LwOIS1uJ2ORPL7wl6d1ZXo7zjivO0=;
 b=HaYE3hSKOCQeGCqkherOFRc/QJB2p1P2y/XWt6wzwfMyBkPQTi+uOnPenB3+lgZc7tmNodVbrFrj7LeJVZPXwN/l1mut+r3knZh/Sd7E0sU/vuH8t9No4D1uWb1WPLzthfSQ0DPrtIWP3DkqtPw0OgPavot1kpxbKubzlKAMnL0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR0402MB3839.eurprd04.prod.outlook.com (2603:10a6:803:21::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Mon, 22 Nov
 2021 13:34:18 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::d0eb:49aa:2a9:9fc4]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::d0eb:49aa:2a9:9fc4%4]) with mapi id 15.20.4713.025; Mon, 22 Nov 2021
 13:34:18 +0000
Date:   Mon, 22 Nov 2021 15:34:16 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     cgel.zte@gmail.com
Cc:     festevam@gmail.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, s.hauer@pengutronix.de, sboyd@kernel.org,
        shawnguo@kernel.org, zealci@zte.com.cn, deng.changcheng@zte.com.cn
Subject: Re: [PATCH v2] clk: imx: Use div64_ul instead of do_div
Message-ID: <YZucWFCMnUt2e3jG@ryzen>
References: <20211117013853.158777-1-deng.changcheng@zte.com.cn>
 <20211118080634.165275-1-deng.changcheng@zte.com.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118080634.165275-1-deng.changcheng@zte.com.cn>
X-ClientProxiedBy: VI1PR08CA0147.eurprd08.prod.outlook.com
 (2603:10a6:800:d5::25) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
Received: from ryzen (5.12.226.136) by VI1PR08CA0147.eurprd08.prod.outlook.com (2603:10a6:800:d5::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend Transport; Mon, 22 Nov 2021 13:34:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b72751d-7a6a-41e6-0055-08d9adbcc8cf
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3839:
X-Microsoft-Antispam-PRVS: <VI1PR0402MB38396F8A2368C0CD65AE44B4F69F9@VI1PR0402MB3839.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YoMXhND+UU54y+7DkhS9cRgva7S+4CQqbmbm1olRwrHQ+mJdbye8wq8kLqxS8Rl5mIj/YVpTfY4TCgnWkO5uG8FXqHc1dZNxzTVtzkIrHxd4Wxs+PrKRp6Lc1eEWer1LnKu2u0rssJ3+O7izKHf50GyhYEtfDyft26GvhZmM6mlJR+K76rgwA9Rt0jxviOR9fabe1bKfJxwbz+ppWcRdJjcIsfM9i8nSuWU/Ih2Lf439RRtKbdGgp7j8926LgLfNLXefxmO7vs/qVU3+oJczHrW1uPHPDpf93EHidIfdH9/dZocTqikeda1erGo6+YU58S3G143zhFwz+4FOyD8Miuazt6wq/lpj5GVdKlekhlbbjz8oWZcjXjGeCKQ/4Kb8UvAVyP70jPpBtu9Mo9FF4TRGyRSZC11Rj6XPYyoemNkvLyHXTlaHtFihE1FwBQlpqNmVcX04jQDHa4gA0wVGyoRgOpyqz5b9NpbZD6V2o6GedvFF0wUFirefabj7k/6L5uq0wcYnczwyd+BHpYylasQu9/ZXOkAnM038tgNO8HszWDEJ6+HLA+JVPgXpvc2FwBl5wBUWGQ7Jh6vtsL2VK4nVt3pLaljd1s/5AFdtf78cnKgxFb9MPCjlJl3EevYg7Rs5CLNcV2d0B0QlMRo3dIZS5Cw4NnsDqNTjjJnR5eyOxALNTMNf/5MIW8hd+qTtv2Bu78INDWH4llvgM4BcKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(33716001)(44832011)(956004)(7416002)(5660300002)(9576002)(316002)(83380400001)(66946007)(38100700002)(38350700002)(6916009)(66556008)(66476007)(186003)(26005)(52116002)(6496006)(86362001)(8676002)(8936002)(4326008)(2906002)(53546011)(9686003)(55016002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ii6LMAuIomc+nAf9Vrfi4Wk14S+CvOUHCwmfpLZ6FBz2cOyVEvHkfUbzIWA9?=
 =?us-ascii?Q?OErByDd6iZHyIctH7kypzTEmXQZUe1SRNs1iNSEoajiMIGjn0xdXi23ryOdo?=
 =?us-ascii?Q?rNtb2kfcZaX82ivXyJ+yyUbonJFZHFThXrgj3SaQFagk6wZZMUiSDWFK9sj2?=
 =?us-ascii?Q?BIe5/XqY1ZJ5vKiJZaM5/sBpw1B4v0WMAo/gt1aXUypu8wfK9hxlDOHsrhUZ?=
 =?us-ascii?Q?vNRrLCpNKzStMDRRN+RYXvKZcINV51htLCj43nWyykkZ08frur9LLotl0OFV?=
 =?us-ascii?Q?LkgwvyGKhK4cij+CPFDM+olBDvwsfjKWY7oyw/o76lVU+YSyQtnQfi00Z03A?=
 =?us-ascii?Q?5o6CuA3hPf4Kg9ttdA7UOxShPBLCw0PlhMsQQgzL1GG0Ib62tmzjWViJTNhq?=
 =?us-ascii?Q?gvaJ0wTEvfI8nVl5wqJeYKJjZGTgfY143jpJK0b6JbM2D94SJM1o5fjKD+Dz?=
 =?us-ascii?Q?w+PazJmty1sDRms1j28cPZzpkrcFvtcxo+jMPtbcRWRMi5aGR3GiVUt8HKBk?=
 =?us-ascii?Q?BgoD7TyN1EMB9kXmMs71BiNbouaN4gWuB4nIRIKU2k5+Rlz+R3sAH5fANVY7?=
 =?us-ascii?Q?iXyUC3EZ+WG4UmeNLkGHPJLQ4zfKsHRKCGhIMUyvaicsL5orz7Zrjt5ysKMv?=
 =?us-ascii?Q?PzeWpCfEXmGyeMKiOBlltqW8jtU6eFxWwK7SAQ1Fz9HaWc885lIEyHyRJN2I?=
 =?us-ascii?Q?hNEarkhUdqHlcp+TQXkDzOfjElHCv4nO6fV6/tDpDp6oMeleXR6q/DuAldl/?=
 =?us-ascii?Q?WWKxcr7aBfMbj5ee9Vy7Oe5/AnDX68BaDk7hwiXWzP/XYhV5ilOZE7C9kDTH?=
 =?us-ascii?Q?uwv4xO03G6JGSVHiPKaTaDWRWZFo0EKhFDdPy4QinRV86HwtSQtbx2HA8AZZ?=
 =?us-ascii?Q?ygv59ouylQ2KA2kDBvpqAmcZYhNFWOhRdZiK/m7wf1oVxxAMaHgUOvm1+MQg?=
 =?us-ascii?Q?J11Dlsia8QfRAAhC9l2ZmzW94MoAJo+fDNp0ZTkB4rOW4wKM8eMi6Ga1SCBL?=
 =?us-ascii?Q?Qj/W4bWP+uJDuHcmz3Sokb0J1Q5GNr+Sp7it8NYA8/MFCBw+KpqloOSoFBS3?=
 =?us-ascii?Q?e+XO54zCCpI3syScgd9AbkztoodFFwU2a11pTdY3FQWfzT6RJYnGizrKsA7p?=
 =?us-ascii?Q?p4JQrYfPMo2i0EPVoKnfZkuXalLRF4RsqXiOidxcQl08mBXblxZJpVhmSLfa?=
 =?us-ascii?Q?YucQfBU4Y8fBNgnBLzT3P2ZayPMs73I4gmNUEs0Z1gZYqme9V5NIoLdX/mCq?=
 =?us-ascii?Q?b5dpgzCrRYpKn3YAh87BoxiuqTcxxtNsPtwjnfZ4pa9V5dJ4TTcynf/tJ4Tk?=
 =?us-ascii?Q?nQu5Du/S5p9wgWFzBBmfpSkw6yQGTnTT233Vk9T/wiMeoCK+HdClO4OoWSpC?=
 =?us-ascii?Q?f69IScaXFWu2zf6ZpvgzDzq054NyMJ9FNXMxtcKoOYyXLqeNs1gasQAWAMqc?=
 =?us-ascii?Q?b9VQ/Mthg+JdLXg6IYlOIudUQVM2U8yQsrfQlKd/G/i29WJJdge5Ik9i+oaO?=
 =?us-ascii?Q?TmMXqSplQB/WrBqcze1W8n57v8Srgqidgcx4H85Az5UQ4wbK1dLmaBQJTjA+?=
 =?us-ascii?Q?hO/uqfYi7IrdOg5wACLeqXu/udP22czKtetYgGlUb8G6ttk1CJ4gmd5keW+x?=
 =?us-ascii?Q?ru4CVNErqvyhknBvq2f0BAs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b72751d-7a6a-41e6-0055-08d9adbcc8cf
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 13:34:18.5481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QPYjU6vtvO3eiFA/ks/PZiANDC+pM1tDBMryzI/Xym5eewbLT1y8FftxnksQI8IwsaKWQ2Oet1u95qFMtor8SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3839
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-11-18 08:06:34, cgel.zte@gmail.com wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> do_div() does a 64-by-32 division. Here the divisor is an unsigned long
> which on some platforms is 64 bit wide. So use div64_ul instead of do_div
> to avoid a possible truncation.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>

For future patches, please do not send the new version as a reply to the
older one. It gets confusing.

Applied, thanks.

> ---
>  drivers/clk/imx/clk-pllv3.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
> index 20ee9611ba6e..55497e0585a6 100644
> --- a/drivers/clk/imx/clk-pllv3.c
> +++ b/drivers/clk/imx/clk-pllv3.c
> @@ -247,7 +247,7 @@ static long clk_pllv3_av_round_rate(struct clk_hw *hw, unsigned long rate,
>  	div = rate / parent_rate;
>  	temp64 = (u64) (rate - div * parent_rate);
>  	temp64 *= mfd;
> -	do_div(temp64, parent_rate);
> +	temp64 = div64_ul(temp64, parent_rate);
>  	mfn = temp64;
>  
>  	temp64 = (u64)parent_rate;
> @@ -277,7 +277,7 @@ static int clk_pllv3_av_set_rate(struct clk_hw *hw, unsigned long rate,
>  	div = rate / parent_rate;
>  	temp64 = (u64) (rate - div * parent_rate);
>  	temp64 *= mfd;
> -	do_div(temp64, parent_rate);
> +	temp64 = div64_ul(temp64, parent_rate);
>  	mfn = temp64;
>  
>  	val = readl_relaxed(pll->base);
> @@ -334,7 +334,7 @@ static struct clk_pllv3_vf610_mf clk_pllv3_vf610_rate_to_mf(
>  		/* rate = parent_rate * (mfi + mfn/mfd) */
>  		temp64 = rate - parent_rate * mf.mfi;
>  		temp64 *= mf.mfd;
> -		do_div(temp64, parent_rate);
> +		temp64 = div64_ul(temp64, parent_rate);
>  		mf.mfn = temp64;
>  	}
>  
> -- 
> 2.25.1
>
