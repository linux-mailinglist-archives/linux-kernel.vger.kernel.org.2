Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544CD3CCC90
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 05:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbhGSDVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 23:21:10 -0400
Received: from mail-eopbgr70079.outbound.protection.outlook.com ([40.107.7.79]:14658
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233720AbhGSDVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 23:21:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bEL0bJOjeKHk2hppEQVCE2z4fEGPczZTnyQiZWNVEhs0OjYFGtl4u76Ljoa9Tw4odXIoLoea7Bx34xkWPOF+sYZZ3xHYo4dwT8X2GXlzpmaOflmDUm/470sj9mu8J/3zW28/tx62xt8QtjWl4LqEHHuOpw72Elh2+0KXRj7lP9VGdprSL+VG3WgBUlS7Ha8/9Nul5FYnh+Id2Yx7h4jPc1flstMb7/sHMHI3iYOimPbXWUpOG5MikL/N4TJYvdG1+LiaQSbK1pA0JdVqniAPd7+IK/d6ot8ILXLyFa7GDUYfuJqNMTkzGGycCantiO8oSwDolJPngymio28EVIQECQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvIJK6hc1uvGiyYhnExc+UtllW3zbf2N/IRX12z61Ew=;
 b=PGkwzC3mhSlHawOuvNUAqIy2YWr4dKVR4td1jCW/TI4AwQdpUUG5G6mCnHmKSBs+jSV85Mzh2JMBjQHqjKXx7Lf4voKB8Wq73uUTmcFYVVQ+suHYED5XQW+Z7F3Gd1nYP+NIJTqEvhJLf2VP7H1W3L5be2abI27Ww/E6cldL0D/BaSKdx2zAGg9Rp3XuqY4EcvQghH5LR22CJY9/vGgPWwVOmEDEq02dEQe1pueYKkjChziOPXOnvc+bCBXN9fZ7mFaVA7oYoZCMaV+SfKFUQcC1jyFVCvLI4yT+A4tvDK7P5iW52TRaJWWpfUd+/RKnBy49mmg04MWpRDGUyDf0nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvIJK6hc1uvGiyYhnExc+UtllW3zbf2N/IRX12z61Ew=;
 b=LzREP5aUspOQuAx5ciwPq7lnS4PlDP4wYfRSmL/JyyV6DDKDihBSoLkhr04r4cjAZXAAuTqofromGK/6aEm27aXq1OFep8DVoZFrI87VQxmGBupJPDUIuw29a6M57PSwjzIggqfvZCYOx/TlB0MBtlFBvfroolB8QtxISkK55TI=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AM5PR0402MB2786.eurprd04.prod.outlook.com (2603:10a6:203:99::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Mon, 19 Jul
 2021 03:18:07 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::8c66:a7b4:1dc7:2c27]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::8c66:a7b4:1dc7:2c27%7]) with mapi id 15.20.4331.032; Mon, 19 Jul 2021
 03:18:07 +0000
Message-ID: <bfa0c16e88c0d445137290b2bef104e5fa74d78a.camel@nxp.com>
Subject: Re: [PATCH v1 2/3] clk: fractional-divider: Introduce NO_PRESCALER
 flag
From:   Liu Ying <victor.liu@nxp.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Date:   Mon, 19 Jul 2021 11:16:07 +0800
In-Reply-To: <YPGHbvaCv/x/JlgH@smile.fi.intel.com>
References: <20210715120752.29174-1-andriy.shevchenko@linux.intel.com>
         <20210715120752.29174-2-andriy.shevchenko@linux.intel.com>
         <7941107fda10f075395870528f0e52d42e502d92.camel@nxp.com>
         <YPGHbvaCv/x/JlgH@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0143.apcprd06.prod.outlook.com
 (2603:1096:1:1f::21) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from blueberry (119.31.174.66) by SG2PR06CA0143.apcprd06.prod.outlook.com (2603:1096:1:1f::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 03:18:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f364f49c-76ca-4b45-7ccc-08d94a63d460
X-MS-TrafficTypeDiagnostic: AM5PR0402MB2786:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0402MB2786700F23946ADCD718C9ED98E19@AM5PR0402MB2786.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2CFMhLGfb2aVpAFYOQBSUE+zpuAaVR52IzlPZ0nYs63WYrmK0H2RAM/70WdWKPZk3xIKGgbRjlNDjpOAWWy/qJYJHdlckkGQW7onv3S96xBHQGuZsiIvpXm6F5bn8QIMhpbvpcIHUo4fP1oUgJuoFxPC93dnaPA5mZlhZyKUd1KMb6JRatIkT0iEzOGQrwJjbpGrkm3P5AxpCAEOR5Xg1t1ZQryjUfMAzGUZ/FBkrroKlAT6dxDK9PVPnckJjvyXnOj744gFS/BKnt/ek7qO50o9GYCKNg2p9/trZpuliUielgdhVXrLfHTOCvWJIYofifjj+dysTOb6xho1fvw0tFCL4qvBODd5MI/y3rlyv09Y7v73h1N089n9hzJeNEi9/qcnETWa7dYhgg1h3zk01l4wmzcwGm586f9nEGsfIoh1FAhlNEfGdgy0g55Zy5fj2k4/ciHO7HpVwzcDzYD5Khh3TNy8S58DavWiVIQ7fS9pqiRQvGv7j/8i45y3z1Mwr2gcmDjKLBa8+AZ+22CdwPe7YrW1d1KK4OKxfFEtF9Gd1pbjbqdW8UWDZn2YMmetdCmNiFwjdSbTNuXRgU5kpUnnf9p4tSLkgnPgNv9IhhWnAzEE1kBs8Q33ze3jg97HW/CdoOST9C6hqPhOdZfFSwlshXa5LuTORyFf3MJnDD7GV+9AXOdV1VzUDYHFQ9b3ve3tBAo5BGj4vlg54KlyiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(8936002)(6486002)(8676002)(38350700002)(38100700002)(956004)(66556008)(5660300002)(2906002)(66476007)(66946007)(2616005)(36756003)(26005)(6916009)(316002)(4326008)(54906003)(83380400001)(186003)(86362001)(52116002)(6496006)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXQ5UlVNaE5aZldleCtDZ29LQm5TWkZXNVczMHMzQ1U3c20rRzd4UFhHZmtl?=
 =?utf-8?B?eG01UHNDeGhBV2NwVEVOM0hDSDBuOGY0TzFVYmdCTlkxYVVrcHNFelZNdTFT?=
 =?utf-8?B?bEZrWUhZZGRJNVZ2K2tiZ0ZFLy9ySFhCb3RZMTZIZDI4Y2NaUVJDRWIvTjg4?=
 =?utf-8?B?ZURkUlJISVFqNlNiRXhjcEdaRERtelI1d1NtTmNRb1Await4OWxpNTYvWkVv?=
 =?utf-8?B?alhLUzc0enQ5VEtXSDNaK2Y2ZThDZkdmemhMdnB6Q1lBUzkyU0hJTFF2Z1d5?=
 =?utf-8?B?eEJkc0Z4L3UxUXBHWjNrbXF3Z0Foek81U2syRndDdG5JZjg3M0RoTVpJUGZI?=
 =?utf-8?B?K3pSSlQ5dzZzYXU4eEdKN2ZVaW5hTXBTR3hOZExwRGxmYmwzMXRidWtMWFhF?=
 =?utf-8?B?SnQxM0RPYjhHQmh1V0hwT04vVTR5OEF3emxPalFCbTI5T21hZEMzOGx5UFM2?=
 =?utf-8?B?bnhNd0R4T1IrbmFUYzF4Q1pIZDlIdWVDZk04MkgrS0FPTENmc2tlV2VjUjZI?=
 =?utf-8?B?S2VJK0M4QWlDOHhpTktZVDY3T1B3dVJFWjVudmdrTitpOXFxbG5hQzZFLzZj?=
 =?utf-8?B?QmxCd0ZPOFZwaXRvTmtKUGQrZXBsL0E1WXN2UG1RTDQ4Qm9HZitkMmJ4eHpH?=
 =?utf-8?B?VFJ6NW9BZ2RhaVRsTm55bXZMNUxaVU1uNnJ6Rk4vTmRSRmNiM0tqaXJKYlpY?=
 =?utf-8?B?dkR0N1J2cWZQVWdwZXJWSFE4Ui9KaW9JTEZoSENYQzEwKzBJQlJyY2FCRmtZ?=
 =?utf-8?B?aTZNYU5DSVNNK2dRRWFtaHg4RkRlb0xsL2xOYzdEY0xEekVsT05YeVE1Nk45?=
 =?utf-8?B?RStUK1k1eDRBZ3RHS1QwYjRHTWN1QS9aS1FhVGZZcmNsdVU5VjBjR2FXTUlB?=
 =?utf-8?B?YVNnM281eU5zZXAycUtvTGRJMEtWVjBXaDlKcFRpdmNaOHlUVHM4MXdleDhp?=
 =?utf-8?B?NktLMEx6djlVTk04T0p2QW04SXh1QmU3aXE0Vnl1SmM2VFlnVDJtSTBoUnJG?=
 =?utf-8?B?ViszZGpEMXN4Q2NoUkZMcVlSUms3Y3pHZ0RDaVdCbWY4YUVMZ1oxR3lWMDd3?=
 =?utf-8?B?dDlmZno0U240SEovMFVIVzZWWjlhZ1dMQzRkdDRxdzFEZXQ0Q3cyN3JTcWJr?=
 =?utf-8?B?c05pVDJPU1JtQTE2dFhXZUk1TjJ0elF4MWNsaVc0ejFvYjhieGlHNklLMWpt?=
 =?utf-8?B?ZjNaRXNSdDdER1RQeW4yc05OK2dJbUE1OUkyaFRXN1A3em9wUFQ3NG5jY1Fp?=
 =?utf-8?B?b3hVTlIyK3FkeTFXNGV0MkZiVHZSOXFiV24zNmJQKzZRSkN3Yms1M0J6MWtp?=
 =?utf-8?B?SGlrYWo2K0tBUmE2Nm5lRCtVL3Bza3pGS1pxSjJQVW1CNW54UDhBcXo0QmZy?=
 =?utf-8?B?N1d4NS91RFVzdnRMWXFjYW01SitNKzNlTVJ5TGQwL3Q5bFBkUGZveVhWZjA4?=
 =?utf-8?B?ZEI5Rkx5STJ3SDM4SlBNbGJYMkR4MGQ5WHlFQ29JL1lhSzQ5TlFCZHVqYk9O?=
 =?utf-8?B?b0w4NWJmWTdsZjFsZ1JlNlcvWDA3RXV3M05VTmFNUkFXSWYzY2ZrNFhqUGJq?=
 =?utf-8?B?bFdvQUorQWRaUkJFYStVZTZiamN0WE9ybEtraWtLWm5HMEVUWG1rb1VMRVN4?=
 =?utf-8?B?ZHIwZnI5amlhUXNuM2YzRjhpU2o4VDl6SnRCcGZrczlJUTBldHpoOURUcjhC?=
 =?utf-8?B?c241WXJlY21HQzVDbEdhRkNLM2xqUm10ZWN4YXlrRFVzUEJvb09xV0QxdFRJ?=
 =?utf-8?Q?bp1ls+MenisDZwzbgkhFg7tI9WQw6rnOA1brkuq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f364f49c-76ca-4b45-7ccc-08d94a63d460
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 03:18:07.6191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QMnzUg5y/JAJtI0rh2aCxS0/VNiCVp4BWY+vkxKTOzm6ppzperYFr2bnPDmgU/Bpllr7tAmjITU0ioA8x4r9UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2786
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-07-16 at 16:19 +0300, Andy Shevchenko wrote:
> On Fri, Jul 16, 2021 at 10:43:57AM +0800, Liu Ying wrote:
> > On Thu, 2021-07-15 at 15:07 +0300, Andy Shevchenko wrote:
> > > The newly introduced flag, when set, makes the flow to skip
> > > the assumption that the caller will use an additional 2^scale
> > > prescaler to get the desired clock rate.
> > 
> > Now, I start to be aware of the reason why the "left shifting" is
> > needed but still not 100% sure that details are all right. IIUC, you
> > are considering a potential HW prescaler here, while I thought the HW
> > model is just a fractional divider(M/N) and the driver is fully
> > agnostic to the potential HW prescaler.
> 
> It's not AFAICS. Otherwise we will get saturated values which is much worse
> then shifted left frequency. Anyway, this driver appeared first for the hardware
> that has it for all users, so currently the assumption stays.
> 
> ...
> 
> > >  	scale = fls_long(*parent_rate / rate - 1);
> > > -	if (scale > fd->nwidth)
> > > +	if (scale > fd->nwidth && !(fd->flags & CLK_FRAC_DIVIDER_NO_PRESCALER))
> > >  		rate <<= scale - fd->nwidth;
> > 
> > First of all, check the CLK_FRAC_DIVIDER_NO_PRESCALER flag for the
> > entire above snippet of code?
> 
> OK.
> 
> > Second and more important, it seems that it would be good to decouple
> > the prescaler knowledge from this fractional divider clk driver so as
> > to make it simple(Output rate = (m / n) * parent_rate).  This way, the
> > CLK_FRAC_DIVIDER_NO_PRESCALER flag is not even needed at the first
> > place, which means rational_best_approximation() just _directly_
> > offer best_{numerator,denominator} for all cases.
> 
> Feel free to submit a patch, just give a good test to avoid breakage of almost
> all users of this driver.

Maybe someone may do that.  I just shared my thought that it sounds
like a good idea to decouple the prescaler knowledge from this
fractional divider clk driver.

> 
> > Further more, is it
> > possilbe for rational_best_approximation() to make sure there is no
> > risk of overflow for best_{numerator,denominator}, since
> > max_{numerator,denominator} are already handed over to
> > rational_best_approximation()?
> 
> How? It can not be satisfied for all possible inputs.

Just have rational_best_approximation() make sure
best_{numerator,denominator} are in the range of
[1, max_{numerator,denominator}] for all given_{numerator,denominator}.
At the same time, best_numerator/best_denominator should be as close
to given_numerator/given_denominator as possible. For this particular
fractional divider clk use case, clk_round_rate() can be called
multiple times until users find rounded rate is ok.

> 
> > Overflowed/unreasonable
> > best_{numerator,denominator} don't sound like the "best" offered value.
> 
> I don't follow here. If you got saturated values it means that your input is
> not convergent. In practice it means that we will supply quite a bad value to
> the caller.

Just like I mentioned above, if given_{numerator,denominator} are not
convergent, best_numerator/best_denominator should be as close
to given_numerator/given_denominator as possible and at the same time
best_{numerator,denominator} are in the range of
[1, max_{numerator,denominator}].  This way, caller may have chance to
propose convergent inputs.

Regards,
Liu Ying

> 
> > If that's impossible, then audit best_{numerator,denominator} after
> > calling rational_best_approximation()?
> 
> And? I do not understand what you will do if you get the values of m and n
> as m = 1, n = 2^nlim - 1.
> 
> > Make sense?
> 
> Not really. I probably miss your point, sorry.
> 
> So, I will submit v2 with addressed first comment and LKP noticed compiler
> error.
> 

