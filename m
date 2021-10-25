Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9FF04395A1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 14:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbhJYMKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 08:10:55 -0400
Received: from mail-eopbgr70045.outbound.protection.outlook.com ([40.107.7.45]:26785
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231129AbhJYMKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 08:10:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUVicnZJO5As8dOFOK0GO3w5PCe8L0ve0eq1fnQBjZuyAcohlFuk3ic+qC4wyiDG4FE+1xWysofJ3bOf8U1yETrSkwClsphq4xfjVZRSeeMAT6gHeLRYJckQhKsmQBt8sY/7nzgXHh6ozE7xXVWFSBdUY6JY4jhloG8xTrvxwyLFQLcW8E9ppGD2Hh1k5SyCIEQimchs/pSDoyceF1AZEzHwgP5d0sqmS48yrXGPTvdAH0RufRlgTVaHpJupGnThwc5gLLwNW24lxXY/OhCeze6dEJzM5Y9edSAnjIF0cGwF0MZMypewKdMYHXEgSDkg2FbX1nq2WujyMYhE4HkFag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KRWS4lRQ1wvdDP2acBVcNvcIdkjHr+Lcjflri5mDZeU=;
 b=KnmXWu3Wl2x5WWlXS31VqJIWkoM4ap3rlbaQp7Qjx4la+4dOP4DdfNQTmfqzD8B6ktcDGZZUT2bpPbuyq/cplxWmVZyVRctIbzLt3vQUo/Nriq4wRxZJTEjzsH459JjWk1lOZDZmi8VPY9WAxScI8P0RlrftnQ9k1jKOlEJVnnwBfL7cBIqaDq9pjL4zcW6+Un4FwDCazusR1eseenygAE5aWX2/YyyeEAuEKOUhtAnNRmdBjSzIbnTi8zkzPVeMEmu2jF/Pv49P8iVtxPsUuW4WtYQKWJ/zpGhErQWQk10DEg6R/I3hSlhRf8T8Zlf9bUpzsVCDbFFCoOD8Ny459Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRWS4lRQ1wvdDP2acBVcNvcIdkjHr+Lcjflri5mDZeU=;
 b=rfkqdPD13GyHB4z4ZTgN1wKE/iekeqDQNtOkqgu+Mw5M8qc6oiOaMOfbcT+a1b+Cr1/q7B1SR0LxLkt5anvvLGHDfNc0u3xsY0CnFInkAAswfuKUhpM9W5MVWP16c/rtq/mwyyZBAHf9dtEg0UQ3nSh1vptHSiZJdsPb0rzPHP8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 12:08:27 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::885c:ddee:c614:9787]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::885c:ddee:c614:9787%7]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 12:08:27 +0000
Date:   Mon, 25 Oct 2021 15:08:25 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     sboyd@kernel.org, mturquette@baylibre.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2] clk: imx: gate off peripheral clock slice
Message-ID: <YXaeOa9CsT3cd/u+@ryzen>
References: <20211025122902.1151-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025122902.1151-1-peng.fan@oss.nxp.com>
X-ClientProxiedBy: VI1PR07CA0268.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::35) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
Received: from ryzen (188.26.41.202) by VI1PR07CA0268.eurprd07.prod.outlook.com (2603:10a6:803:b4::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.11 via Frontend Transport; Mon, 25 Oct 2021 12:08:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c844781-bcac-4599-8847-08d997b026b4
X-MS-TrafficTypeDiagnostic: VI1PR04MB4688:
X-Microsoft-Antispam-PRVS: <VI1PR04MB4688DBA3E5F5142617BF0BF9F6839@VI1PR04MB4688.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uPsnZAVHCZgl3roamYskySPvAF/oBjjy7hsQCtoYooRS0YXMA/h5Jqb0vHH1ecvTnwBlRlfjPnROgw5Pp/Y5V2h7276MKcSF3PI+i7SG4e215UmWdK6QO3S8/igEedapiqwhuAeJOYBRzVPh9oHlTczqaTziaXm0PBLESqhjHl0oxS9oIkBz757cFKNx2DPKh5ivSScMMa5FbPry1RroJPpnzw9Z9QuHTf8f7QIFh3/bGE1BgmxCml/AiErphgHo2W10PQBFG7Jh3j+nZFsScN81Bix8KMUYr4FwKGp1AUKlg+ZBayY9w8wWT3u8kGBtKjsyIEr1dbb2l1zGq8MKLbSvPP5PeQ4m3vW2PJDJlLWjSq8boUnePJhySgDLgzaL+2vA4LuDBrndqGvSrMWgeqdwMaGRY2sHFpImIsK/QDxQG+t6RrrXEtW2G4WPtyNOdDSoZ8yV7IkzPJ7OLc6VAb6P8maPj9fRhOu7ybkwvau/CRH+tksUD6Yng0l3dVjuOiYESiK9E7PY7ZfGOk3N8rkFJeS6Eh4ejOzYd2P/qreCs/4og6c6OMfszKTf+3Nq1aNRjyGr8lpe4Oo/+lC9iwO3APoaS6j32dtBb3tLAAVnRKzsXXlG+YHML/Xo2pjkC30pZgLwtSTs7kDJxq4r6/ky2UDl9482dZU3z40riCTnXFuB6pcRNzXqiYujKwvl4qSvPc6rf6vXeD+2ncAgHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(66946007)(956004)(2906002)(66556008)(66476007)(33716001)(316002)(6862004)(53546011)(4326008)(44832011)(8936002)(9576002)(508600001)(83380400001)(186003)(52116002)(26005)(5660300002)(6496006)(86362001)(9686003)(55016002)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J9/UReYlLCMJLsqJ5Y69ZpcFFj4k4D1/cmnIbgYGsJzT3OSWyzlE27w2eRyb?=
 =?us-ascii?Q?UsDhTtXmNj7R/fUhxFTsRoD8oQhzaEDCfjlyCF5dA5rL6xqQXUSoktGWi912?=
 =?us-ascii?Q?TVXHcOK2JTvb1NW4PCZUGZvLHYmjWp1r73xaqmrYna6SrnSnfH6l01BMW3yT?=
 =?us-ascii?Q?WNc+Ym7124zfqvDwS96TyQj8EPGbMAhE1C+s0ZC9GFin4ILK2BOm+sBjo5Wa?=
 =?us-ascii?Q?jgmEcyqMrhm3tk5xF1AoA0EQB0ebH/Mcb9PXwMJo6oIj3KjsIcx4GHp93tk8?=
 =?us-ascii?Q?nAyeMNMPdJfcGFmi5XffDrm2BuhD72bHBvuB1VJDCRKJ1V4v05gc10oh+uP0?=
 =?us-ascii?Q?l9eRSBbPUs9E8hnBB1CNm9f9Y8f6RVbZzIP0j4GAjoHf9h+VyFSX6U8de336?=
 =?us-ascii?Q?PPgys+koOoy7RwLhmQMxKhQZUdqjMdWKQFfhUTdZkrBO8rAzBdEGEU2pMr3I?=
 =?us-ascii?Q?NMz5NIPXUIPZo1/PMIi43j4XJf+5j8/xyU7PMfqyl1/TcjlykqqmVYw4dbog?=
 =?us-ascii?Q?tU7aqN3y3LkC35M6fPVb2SPAE0wELXWF//QDogN3T2SbItjcQbQBJxg+SveQ?=
 =?us-ascii?Q?PGFYK877Bb7YQaFBu5rNt1XMXrxzisQ9hn26qluJKPpOUyShvBu8Y73QQUCD?=
 =?us-ascii?Q?NT4D8k2XD01WX87xOZmAO2gZheaK+36eHUy4L9Xz5yN9D7cOMSmG8FZAfKUW?=
 =?us-ascii?Q?HMqv3nyXXdZt6o400UaH3rAoARKDbXNL2IZg0XofyT65n598SKyhDMJNusXm?=
 =?us-ascii?Q?KaqnhgK6inmwIbQCv8Q4XHA5s/CR+3xZEUPSs7S/tz2qtKAFVh1tPOyLr7q+?=
 =?us-ascii?Q?9THQ3iLi5f7FgqtSK/MYwxT0tJ68O41/WH65eAoPzRcqe6Hybx+ydNTUFGEv?=
 =?us-ascii?Q?phfm/Hz2SA67XV8AcQyF+6arrMLMwObXeuBZsMZv1S33MfJrv6En8O+1Ayp0?=
 =?us-ascii?Q?ZOvJNbXcsCULpsnDf9DWFPJxNBIrcNI6nFwgKGeBuZWypYlgUujB3yAX7u8p?=
 =?us-ascii?Q?X0GL5zpowP+M72Mewhv/W3mE9g9li3cXmGmiWOfnBV9rwKKxG5m6oCVDAOuv?=
 =?us-ascii?Q?OtZhjvPuBb7oIb3YQETt7mhd5dq1SaDKenufuVkwmejF/bAbIHF3IVyNRbJ7?=
 =?us-ascii?Q?VmSoZfJyZYUDPLQudlz9J3vOLTep3xs59EQSgdDcLuR7IqDK/2pu13qyzHUT?=
 =?us-ascii?Q?s1TysBmmHyyx5A3YLJPt+EPjm8D59rm9OOIJsKW1B2EEnDLyWCvLbo6fwiVY?=
 =?us-ascii?Q?ob97+/vIYwoMx1GpexBYCwdkuziiX2IxT+OKPr9azGBkCyOg772+mqDQ9DM0?=
 =?us-ascii?Q?6zR/UwgkExA7s0iQxdwxaWsUd7Gh1ttZUF/ETfzWuzDsSW4DQ6QRv5UMz48T?=
 =?us-ascii?Q?ZUGpTyMd3j9GdM9ezmoWxXs7HcnOwuZDv8p4vnjfov+kh582S3OLAvdbijqr?=
 =?us-ascii?Q?vBvs3xYU8esUp/nBhCKW8fAlCg2XR9+O2n036oIUoDuOeInCFqHFDlBLcvKz?=
 =?us-ascii?Q?oUoB1RblaEmyfdgEh7YVVrIt7yvgthGkWzs7fc2pdSjmD5UcZgy7vwKPh49o?=
 =?us-ascii?Q?MEA+FqQ00+gjuDg3zqAE4ZLEJFgeaBWiGzuiJp0fsbhTmSvUduC6J8seow+t?=
 =?us-ascii?Q?ZoTrRb+wY1EbNb1mymIVe10=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c844781-bcac-4599-8847-08d997b026b4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 12:08:27.0598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CQ0wyo0OrHusqPVzrPY3+tzq3+T4ip2GXnQWXaWOPUsrOQqT7BjJc6Wvr2uMlqCVTftgU1jcZIvYjAq9Ds3MrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4688
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-10-25 20:29:02, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The Peripheral clocks are default enabled when SoC power on, and
> bootloader not gate off the clocks when booting Linux Kernel.
> 
> So Linux Kernel is not aware the peripheral clocks are enabled and
> still take them as disabled because of enable count is zero.
> 
> Then Peripheral clock's source without clock gated off could be
> changed when have assigned-parents in device tree
> 
> However, per i.MX8M* reference mannual, "Peripheral clock slices must
> be stopped to change the clock source", so need to gate off the
> the peripheral clock when registering the clocks to avoid glitch.
> 
> Tested boot on i.MX8MM/P-EVK board
> 
> Fixes: d3ff9728134e ("clk: imx: Add imx composite clock")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V2:
>  Add Fixes tag
> 
>  drivers/clk/imx/clk-composite-8m.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
> index 2dfd6149e528..ee41fbf90589 100644
> --- a/drivers/clk/imx/clk-composite-8m.c
> +++ b/drivers/clk/imx/clk-composite-8m.c
> @@ -184,6 +184,7 @@ struct clk_hw *__imx8m_clk_hw_composite(const char *name,
>  	struct clk_mux *mux = NULL;
>  	const struct clk_ops *divider_ops;
>  	const struct clk_ops *mux_ops;
> +	u32 val;
>  
>  	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
>  	if (!mux)
> @@ -216,8 +217,14 @@ struct clk_hw *__imx8m_clk_hw_composite(const char *name,
>  		div->width = PCG_PREDIV_WIDTH;
>  		divider_ops = &imx8m_clk_composite_divider_ops;
>  		mux_ops = &clk_mux_ops;
> -		if (!(composite_flags & IMX_COMPOSITE_FW_MANAGED))
> +		if (!(composite_flags & IMX_COMPOSITE_FW_MANAGED)) {
>  			flags |= CLK_SET_PARENT_GATE;
> +			if (!(flags & CLK_IS_CRITICAL)) {
> +				val = readl(reg);
> +				val &= ~BIT(PCG_CGC_SHIFT);
> +				writel(val, reg);
> +			}
> +		}

Though I'm usually against special cases like this one. I think the clock
core needs some generic flag that would read the state from HW on probe
and/or another generic flag for disabling on probe.

But for now, I'm OK with this:

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

>  	}
>  
>  	div->lock = &imx_ccm_lock;
> -- 
> 2.30.0
>
