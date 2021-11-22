Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1556A458F60
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 14:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239349AbhKVNbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 08:31:18 -0500
Received: from mail-eopbgr50076.outbound.protection.outlook.com ([40.107.5.76]:27934
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239532AbhKVNaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 08:30:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PeC6fH7ygFBCIEO7m6pF3nU6oQ34D585QHokGvo3Xnl1UmxiXAXNNZrILiuARzt3oHTeG7hKf7x8Avc1ReesZNXmdT60vd2efgUDfWJ4WGxCHBmx9tpwaTf//bEiEd9UWpvMSNMvPFAAjk99QtOtOk3bVlQJv4/ALghqLy/R94/n87YRVN3kK58yrSckUgJgOqkW+sbLGBZgH/qTEe2UQDLQMw8eKonIXzZhz3H7rzovShKzoiJYR24KMlM6cZNPrl1JYK403EKO5f+PgXTHrNDAHDnzfFJefNE9P5duYlfZKEJKvN53ijf4x4UfsHBM9Rm4IZQn/SIKAvOYvxnBjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57uvii6jGvn69udcsSAGPJBdI/Rnd5nl7DesJpRr7Xs=;
 b=kq8kvNJnhWKvU5CfOcNeK0bPbbYYf3R644guddwEPOPiRIFzjlGSXH5wJxxUFhAQ+FfCgKYKEyb4NnT3nIcx6WxQ/l7hRH/BknwIS5UUVBKazS09zr2EFVeV2qz44WJCobFtm4O2Y5g9Nz3bSpa2odb+2WLz0pJbROqRnx+riknsqFQuy8JGbeqslEDj+DSjep0ing6wo3RK3G0gEqOkIFIWVJn8SjD9E8xrFvBtOhXtpV8kBoTHH2/hTJPEuNnIyBfPs2fXiNvk1ps19b/0wLRNkRvAavUCE8Cml/Vzx1fWucTXwbClV1N4+CZT2jJe7pHkWKPDOgL3TFyziAWqBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57uvii6jGvn69udcsSAGPJBdI/Rnd5nl7DesJpRr7Xs=;
 b=IVr5EzUiSABTfioX/gE0LjINpahprbfn0U8JVhHPNf9773OFi6DjIY9MCAv0Y/y9BYNyS0kHDoagYoVw9kMwWQHEQQW179HBIwq6Wb9Fudt15cNAR/WMbh+fSpnU8ZuYzdBHOL9SaLAjoF1MU0gsI7Nv7rNKpG7NYEK9MqDFwO8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR04MB6271.eurprd04.prod.outlook.com (2603:10a6:803:f7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Mon, 22 Nov
 2021 13:27:17 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::d0eb:49aa:2a9:9fc4]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::d0eb:49aa:2a9:9fc4%4]) with mapi id 15.20.4713.025; Mon, 22 Nov 2021
 13:27:17 +0000
Date:   Mon, 22 Nov 2021 15:27:14 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     cgel.zte@gmail.com
Cc:     festevam@gmail.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, s.hauer@pengutronix.de, sboyd@kernel.org,
        shawnguo@kernel.org, zealci@zte.com.cn, deng.changcheng@zte.com.cn
Subject: Re: [PATCH v2] clk: imx: Use div64_ul instead of do_div
Message-ID: <YZuasg75VV84zd5v@ryzen>
References: <20211117013853.158777-1-deng.changcheng@zte.com.cn>
 <20211118080634.165275-1-deng.changcheng@zte.com.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118080634.165275-1-deng.changcheng@zte.com.cn>
X-ClientProxiedBy: VI1P18901CA0007.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:801::17) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
Received: from ryzen (5.12.226.136) by VI1P18901CA0007.EURP189.PROD.OUTLOOK.COM (2603:10a6:801::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend Transport; Mon, 22 Nov 2021 13:27:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75404fe5-df1e-4647-4efd-08d9adbbcda0
X-MS-TrafficTypeDiagnostic: VI1PR04MB6271:
X-Microsoft-Antispam-PRVS: <VI1PR04MB62714685B54ADBF5636424C7F69F9@VI1PR04MB6271.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Uf4pISCm1sAjmso7f/m1rZcVSJFOPwLmT6Sog9uAeOTvoiykeW5zdJ5yZwqR92qTI30tGXnaQ+c52OerNUs/7GfaaASNgBkBdGEhKQC7/WGdUlC69A/J2dJIhscI5Awl8O0+tdxXLlYGhl+Ffs+Fysvjakz5CyOZVr3usHxnK87kZ/vbhz/cnKYuIQkeRBU8p2N8zMo0in1c7ceGeKMyw1Guro9uy5lSfwzagxrfKtgxzCQlStQXNCnbHOxSfzqmpuZYdE1WMNFZdh/a+7vfwXFTRQPBzZ+iLUQskSpcUmtvGDBInPGun+zO54N590u4gs/ZZDODyRpV817/J67fR4doyqCjy5rQEv3l3fLMeYiYZ0uxwYOBUOR6sGnrXrl5W26Svzcb0Vr74/FXg2MqIXdetr86s9uiC8nij1Qx5Qsg4uzyu+DmRANdsZoGg5af7ZdDgCeNYowwoKG+4iehyqxMVQcuTgJInYNbZkGwllMJpU/mZhavt6YZZZcYKSY+OkkwAZ+QSK05tPfOAXjicIgCjiuc4WtoNsAcQrhs0G0KSiTjaYJrJqAsdHYUWBSwVKqsWc8TUuBKMCpQuzAPa7vSCgObqqnyiBlndotOgnj5+cs9RX6gGtCLUgMqwBoEUzOOb1W5mr+NfNQ13R3JZbz8qikYhSfHoJJJ3Mz0667Rj2nDebCWI6RMQEIeNEfHHe0FzF24X+hN6wGfxOeNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(956004)(7416002)(8676002)(8936002)(6916009)(508600001)(316002)(9576002)(2906002)(83380400001)(33716001)(44832011)(9686003)(4326008)(5660300002)(55016002)(52116002)(86362001)(66476007)(66556008)(6496006)(38100700002)(38350700002)(186003)(26005)(53546011)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QlJYRsQDuUZl81c4j/skLNtYF83BnK7MGyV2moC2dxOi36NzfNtjPJfWIc+M?=
 =?us-ascii?Q?j3WlMcM1XAeZupy5Tpw8oJ3YgnGnlwIHDoSfS7gIQh6kvLBpWJKQvNuuOtdi?=
 =?us-ascii?Q?Fcfn3QCLkQePOFqOETjyXI6hyi5q+cZZMRww8UOIQizYuyEeoAi3hNiKqcyM?=
 =?us-ascii?Q?Pou1e0tP+5+O91y2Heh3UP4yFU2DPwcnYK/opMQA7DZha296Ed3FhTOihwNY?=
 =?us-ascii?Q?+E8KdFsD1PULlNtPtA/+g1itxPTsBgXk3hSDvqyjhzCspLagl3Vfj0lXvUW6?=
 =?us-ascii?Q?iakvV+N3xhZxMFvBS0DKUddbrm5DJBSxxJut7E0GBnIY+MOK+sqNc/099re+?=
 =?us-ascii?Q?4Z0rjbrBJRBUKxe4oMTJbuv4G/OyDaxynbd/dzG010Qp8+h+BCUHN060QF2P?=
 =?us-ascii?Q?Kxv4B93UGEEzlfd4h54JRm7EajT6o0RizeFmZRFEAe2MgULCYf1eSxr6V6DN?=
 =?us-ascii?Q?LBbaEgYlo0vDeb7/U+aR4CpI7GTr16fETcSetSEFAtLfXqsQi/kj85VEJFbA?=
 =?us-ascii?Q?HMKgxFPXLNIGoqJhDnLsFavSrRta6vAxRj/M/RdYC5GLgGo5hwjl7A+nhVuU?=
 =?us-ascii?Q?nsljvQJEv2HExX3NsrN7rgSkb9Bk6TFdom40SqmE1n7xBPQfWUlRbJyqWkxs?=
 =?us-ascii?Q?5ut/JoRSRdRtTwAqrLd8IR8Dubc8MdK88Cvp3XQJUIlLv3OOgHBhz999hlDX?=
 =?us-ascii?Q?rzeOjwg/Xp3zBp5gCcjSlIyPpYmxfqz/hW2WKeBlVGH8bn5tQWwUJAuIIiwN?=
 =?us-ascii?Q?oJxQNwkx+JQEJsYKknCDzMY0IfoIrrgBzc1X1lGXNweSdfalCrsJcc5uM92L?=
 =?us-ascii?Q?bI4ncY38KuI81cuUarJRN2w08gYIZSuQcBtS1jSHGEZeOtcjgAaTstszmQCI?=
 =?us-ascii?Q?YYXAvdeBO5QQlvmOSSOFIvghEdZWdSJmvrxlheti38siwIM4XiFOOB3/Vq8F?=
 =?us-ascii?Q?5oJqYP+gJb5BK6T28XO3MoWjMt8fRf+gii51xO4s1vdGB+JDM/1gRCn0h5hv?=
 =?us-ascii?Q?hgv7G8URr0f8lDeYm929WknFvUHdnhAq/HIl6ywgJpC4foNiFrb6YLz+UVr/?=
 =?us-ascii?Q?gqaD+AXhmLHaaEDXa1+8eP39sO3K/p+0CTxxLfTdiCYELZQKoZx/6kpcZqre?=
 =?us-ascii?Q?VO+7/fGPRcuZZm3qzHWxczcRYH9LfelL4Ra959eicQfuGbeKr+XA8mY9QY3b?=
 =?us-ascii?Q?aQ7vMgW0i3UGvI8WRQt87BSoBCnZip/LEZ4/Xa5emC0vT9a9Jy/XVHEzIGuY?=
 =?us-ascii?Q?k/uw0rDDDDSqQxjD+f85ZlnbkbVpp1IqnXHZzD7kLl4dAOJZYbw1+2JfVD2N?=
 =?us-ascii?Q?QiqW8LSmvYn54n9xoL1dEGim0CYYomYHcAdxf9ZZowT2+uGWruGaQ9dDCbnv?=
 =?us-ascii?Q?n5Cj4N6cBbA8q5IJT7DaBZk8Imp8f6Uek8WFQhZTrSrhkG6RwURpit9ePQkQ?=
 =?us-ascii?Q?gr6nJ5lnaBACu47Q8kvNq2KzTvwnNsfA0Q4mucIiO3eczlkeZ/4xWucUHQ+j?=
 =?us-ascii?Q?xdnEmiXUTi04uWAcpAuHA45UVHLg1IjbU3ExMTf9lDfBqoV8uWa7ivU/v3hX?=
 =?us-ascii?Q?9WN9WZxTPSN5XhD+Ywa+DrrVzlX4afPCW8QRtdQOawcpcY/FdrB6+lzdVk7s?=
 =?us-ascii?Q?E+joIcts/SGNeQXD6+/di2s=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75404fe5-df1e-4647-4efd-08d9adbbcda0
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 13:27:17.1459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EAobFbs6Nr/f0sVHxcewT0pjTxVRwR9cin0dA37vyrEH9dzS6fxyDznN0w7vwKpLpQ4nHngHOSEGVTFmr1752A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6271
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

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

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
