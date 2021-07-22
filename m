Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F553D206D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 11:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhGVIai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 04:30:38 -0400
Received: from mail-eopbgr00052.outbound.protection.outlook.com ([40.107.0.52]:51479
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230419AbhGVIaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 04:30:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUC17JzOq5DeG8ZoGxDL0GDlWoxm/2xZofxT25fVg0XUKIPqqOhINgC70w11A8hpGxiq9CkkgNSDhtm05r6uFzjSzAJKzw7Q0fAUk+gcI04naaJT95lB0cU0qpaXcl+J7F5lGr9ZNjldIwvAlUxByiwHkCFV/Rd9covlyw4PSORSxdey1+5M2+kUNWyy91ojVySyb1FP0o0/8t8gDEQ05owlZglUJnFIJ4huJQaUhLuwLAaZEYV6dC4xJERCcSEduk5WOdgQdQyMB/0WarXTXiyih9ZCKIIBoq4xMfEEkNm8NHGdxmMxCgQ1bbCr1/5D2JQrqdk3rTNHQzf67JfvpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6m6oL1cIQxiN6sWWq41ryMlisj7W9Eux+yNLJAwDNM=;
 b=dr0b9i8LgOHdDZUxsmjCO02uZnfpv7HhqHGVAoyron7tyiP2Xefn3lxARgyvU7/P0ayDgB0o0f5R/pAIxikbozcqxn51S1T2cnMOx8wl9tgY6CN/9sevEY+3Ep9evDwrPD0rS+jVMe6Tdzgedlx554wane5iFVDnquB3VCTI5QHqY3dDQoPlIHlimlmd7rDQoJknT7iGLZtNczQMFRkXYSKvZ8P9KNRKpvMWPSaDFIalOLFpZznfDRMEQ8tsuULF/DK7rAj2t39oPGOxhqI3eZklNrjL8Yus8rKR1GIq9N9Zl9eiATZQplgUYE9YhtE3KQ3p1H6xQYZ09mpsSiI+4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6m6oL1cIQxiN6sWWq41ryMlisj7W9Eux+yNLJAwDNM=;
 b=o4JEOBdFKokzu/e6wuAQODjg4uTrivwdx53uXUPDU8A94FiE880u70fK0R69VWhHe86vzjIq7XuujdZppH5r4COfoW693okfB4Ae/f2t9qwwXmbWPjSas/4auAciBppdTgCOUkLjf1HlrxaccJd3i2JGKZ/U/h1X1/jzQ/IcJrM=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AM6PR04MB6184.eurprd04.prod.outlook.com (2603:10a6:20b:b4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Thu, 22 Jul
 2021 09:11:08 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::8c66:a7b4:1dc7:2c27]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::8c66:a7b4:1dc7:2c27%8]) with mapi id 15.20.4352.025; Thu, 22 Jul 2021
 09:11:08 +0000
Message-ID: <3cd7393a34ca991184722e57b6c64737973b31c4.camel@nxp.com>
Subject: Re: [PATCH v1 2/3] clk: fractional-divider: Introduce NO_PRESCALER
 flag
From:   Liu Ying <victor.liu@nxp.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Date:   Thu, 22 Jul 2021 17:08:52 +0800
In-Reply-To: <CAHp75VeTyWe6SWpWMRYh4Ah6LYULNHBuSo7Tq2AX=vdsObnTLw@mail.gmail.com>
References: <20210715120752.29174-1-andriy.shevchenko@linux.intel.com>
         <20210715120752.29174-2-andriy.shevchenko@linux.intel.com>
         <7941107fda10f075395870528f0e52d42e502d92.camel@nxp.com>
         <YPGHbvaCv/x/JlgH@smile.fi.intel.com>
         <bfa0c16e88c0d445137290b2bef104e5fa74d78a.camel@nxp.com>
         <YPVrkAarqSBMY1tV@smile.fi.intel.com>
         <6b2a6408fcff0d064746d7a77db7b9502c66ad20.camel@nxp.com>
         <CAHp75VeTyWe6SWpWMRYh4Ah6LYULNHBuSo7Tq2AX=vdsObnTLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::20)
 To AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from blueberry (119.31.174.66) by SGBP274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend Transport; Thu, 22 Jul 2021 09:11:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3dcfe46c-66b9-4bfa-ee93-08d94cf0a414
X-MS-TrafficTypeDiagnostic: AM6PR04MB6184:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB61846D96E73FDA261E33C92698E49@AM6PR04MB6184.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: myv2TFbMi3HMYO6PoZQJUll4xKMTK1h/17AlNxun7F7Uy5WnwJxWMPsBTpwwtmjmtbpCTnSHsJkBnU+mwwzn3zmQxDIZDZKeJ04sX/6v9BoCmVex22tQk8YS2xQxhHjolpnFoM+gKhEjPgJLFCZ2DRah8M+PShxpAlkvX5kIXJEAT0jFFcNZyYid1/OmAKXJS0EkzYU0GlO8lAF9u5Eujt6ZkdEHnZPaFDX4AHdIQOv0iaZbg4xjOqURwnBgw6uHHNzhcy1WFi/4iJ66S/gCjitC44t9AETO5wTrRGzAYp0gnmBRBrZ/42BZBRFGpNVb7dr8QmhMPOLBcqWLFou9tZ85LMOU6269YwSV2Z/t8m/XyrbSuJMbIc6VTAZF2gdkTSSd/MMLP5zg0iF4WH3lNeX5iS7rm7Za9/WHKZmK07jMFhCFGg7zdQdaL96SDAEwRhYVKyOWvszFwk8Dhz7hFNJVbpd+dh9uzhytqMwoklfwX7H9N4MKmvWoTcPP21tAiogRhtqqP9Hb53qz0kRf2wj3xw1FnWd9ySgVpa99vmZ5Hr6tcF/ag06hqP8NERDf8f1N76TijJhZkWKRSoSx+9IcuV5zdg6VMuaeFiw5Av/AHPf+fiKmWVbu9GBj27EY4JnPWmIktHgRSFcBrYaV+hXtyFIbicWRxk2RJMGsevcm3P49WnZ4REYJkM9JrSJFBvWwgb+DttzRrORCL27KeupwR7c3h7ySJyJZbwQZA0Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(6486002)(2906002)(52116002)(2616005)(86362001)(4326008)(66556008)(66946007)(5660300002)(6916009)(508600001)(8936002)(956004)(6666004)(54906003)(7416002)(38350700002)(38100700002)(26005)(6496006)(316002)(66476007)(83380400001)(36756003)(53546011)(8676002)(175924003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WElWZTk4a0JYTjVzdnZnbU1xTUFWbi9SYU9pSjFkUTNHaXNjU09GVmEwY2sw?=
 =?utf-8?B?U1dSeTRlNzdNa0pnZ2ZqYzRIWmRHM00vd1k2YW1pS2NXMFZTRWVvUTN4d1B5?=
 =?utf-8?B?dkFlRm5IQ0l3bmovR1orT0NlWGF3cXhzc3RKMkdmaC9mZG5XNWh3R2FXNmor?=
 =?utf-8?B?dm5CcU5qK01ieTIzMGhjWmc3bk5IV25tWFZjb0xXL1ZsM0JQTkVZZW5lSnhp?=
 =?utf-8?B?Qk9KRmlaeDY0RWVHQ294NitJdHhTbERJV1g1KzVrMFdsTWJrTlRXcTltcnNl?=
 =?utf-8?B?VVI0bGhPVWlsVEliVFI0STlXdWZIRnIvdFY2MEhyVTdGb0hTWENrWVZuOThH?=
 =?utf-8?B?b29tdXBUUWhqWjRqNEtvc2JnTmlSaStmbThlQ05yZW12czJ5UkoxNzBmVlBT?=
 =?utf-8?B?WEgzRHA3NTk1VjNBWEhqeWpseVl0cHZLc1MwU0dDRngwNXJWa0FadEVlZUlt?=
 =?utf-8?B?RW9SeXE1M0J5QXdtQTlkQ2hkWkpXRTEvOVRMakdFcmYyYXNFcTR0NGJxMnlQ?=
 =?utf-8?B?QXltZVVvTUdkWTB3VGlYd1FJZUNQWXFEbDdNMU94eFJ1MVZIRHk1dHJqU1d1?=
 =?utf-8?B?TzVHbCs2dWVrY2ZWeXJDZTZWNkowOVg5dGwvQ3FnTEVqMHcrTWJPYUJJZVJ4?=
 =?utf-8?B?UVlaQXJZOFd4c08xcjgwWnQyNGZLeDlpTmNmQUh3WU5BWDFOeUR1aVZubUZr?=
 =?utf-8?B?NTNuRlVZZ3FUQnkyRkRXdVFsSDFoK21TR0JKU0FkMDkrUDhyN2pwOTFGbU1x?=
 =?utf-8?B?TzB0WlhQNzB0WlhVRnpuUVdYenVNRmtnWUlPRG1QOU53YWtUTXdsbFE4K2xT?=
 =?utf-8?B?MG0zUTRvZHlIUFVMdndNN082OGM0QUd3K1doRFpCRHMva2ZVSG1nVHhQTUE2?=
 =?utf-8?B?aUh1M29YNy9mbW1yeVIzeE1SNFlKdm1BdDIraWlJNVJNMTZhUHIwT2xaQmRx?=
 =?utf-8?B?Sk5sQi94bTMzTlhUWVNERXcrUktkcTUxNFVzKzd3c0dhNCsycTRvMG4rWCs0?=
 =?utf-8?B?bzBQWG5iMTVjSnJSMDk1RVgvY0VDeXovTXlZZGxJR01ZbzExRUJ1YTFmUUJY?=
 =?utf-8?B?OFlyRi9zZG40SUhOTmphWkdzR1FxQTZLS25SMDJBQUt3b054RDJEV05zZG5K?=
 =?utf-8?B?Q2t3emd5UWdwbmQ5UlExRDFUbVpic2Zta3FKYzlyQUhqU1Mxay9nTnJReFlJ?=
 =?utf-8?B?L3dvTm8vMlhCNnJzaVpXL1NpQnhQd1I2OEEwaUpzSHBCMUlURlkvNCtERjhl?=
 =?utf-8?B?T0NGeXNUeEo3c29VU25YaXNLSWJlT3FvNjJZMFFKSDNmSjc0Zjd2a21GL1ZS?=
 =?utf-8?B?QzZuL2hUVzV2dUI4aEwveVFEN3M3RFdmempIWlNMWEZsMWZPcjN6L3JpRSt2?=
 =?utf-8?B?SXUxT29YajZCamRwTXpNZ1F3bERZYWFHY3JyQVVQZk5ZUHdkOEdoaFQ5RWFH?=
 =?utf-8?B?bjUvL1MrMlIzSUU1S0piYWEzVU9kd2h5TXl5VFE5ZUFGU1kyWE9MTmJMcTB2?=
 =?utf-8?B?WTJOUEk3QlFBc1NUWCt5ZTkzZXBDN1U5MkVPSERGR1dVRHVSMW4zRXVPUnpi?=
 =?utf-8?B?SlVSWG5ST0t0UnR5RUYwRk0xSGY4bkpiUnRHSzRWMDM2LzJLMTN6c01VTmZ2?=
 =?utf-8?B?S1d6VmVqU1lSUjhkekp6YnJ2VmU4d3o3WE5vOXFKbHFuUlUzc1dpZjJRTVEw?=
 =?utf-8?B?Szk4QnN0RmNxWlJ2QVl5UkJmQm9wS09OS09mMFYxbUVaNEw1L0RCaFIxUE4x?=
 =?utf-8?Q?bn1rskDnvmMf4BALcgwWjwIFbgQ3+uUf/1EQ/FH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dcfe46c-66b9-4bfa-ee93-08d94cf0a414
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 09:11:08.1190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p7w3ewlIGIUUp/86DUm+q+YWG4AaikUb4n2jXGqHyqhBkZzLBs/3/WvRJHNyEWGBp8xuPlQGrJQysDy0EDFVRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6184
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-07-22 at 10:24 +0300, Andy Shevchenko wrote:
> On Thu, Jul 22, 2021 at 9:04 AM Liu Ying <victor.liu@nxp.com> wrote:
> > On Mon, 2021-07-19 at 15:09 +0300, Andy Shevchenko wrote:
> > > On Mon, Jul 19, 2021 at 11:16:07AM +0800, Liu Ying wrote:
> > > > On Fri, 2021-07-16 at 16:19 +0300, Andy Shevchenko wrote:
> > > > > On Fri, Jul 16, 2021 at 10:43:57AM +0800, Liu Ying wrote:
> > > > > > On Thu, 2021-07-15 at 15:07 +0300, Andy Shevchenko wrote:
> > > > > > Second and more important, it seems that it would be good to decouple
> > > > > > the prescaler knowledge from this fractional divider clk driver so as
> > > > > > to make it simple(Output rate = (m / n) * parent_rate).  This way, the
> > > > > > CLK_FRAC_DIVIDER_NO_PRESCALER flag is not even needed at the first
> > > > > > place, which means rational_best_approximation() just _directly_
> > > > > > offer best_{numerator,denominator} for all cases.
> > > > > 
> > > > > Feel free to submit a patch, just give a good test to avoid breakage of almost
> > > > > all users of this driver.
> > > > 
> > > > Maybe someone may do that.
> > > 
> > > Perhaps. The idea per se is good I think, but I doubt that the implementation
> > > will be plausible.
> > > 
> > > > I just shared my thought that it sounds
> > > > like a good idea
> > > 
> > > Thanks!
> > > 
> > > > to decouple the prescaler knowledge from this
> > > > fractional divider clk driver.
> > > 
> > > Are you suggesting that each of the device that has _private_ pre-scaler has to
> > > be a clock provider at the same time?
> > 
> > Maybe it depends on specific devices.  But, if a device is designed to
> > dedicatedly control clocks, being a clock provider seems to be
> > intuitive.
> 
> OK.
> 
> > > OTOH you will probably need irrespresentable hierarchy to avoid saturated values.
> > > 
> > > At least those two issues I believe makes the idea fade in complications of the
> > > actual implementation. But again, send the code (you or anybody else) and we will
> > > see how it looks like.
> > 
> > Aside from making this fractional divider clk driver simple, there
> > seems to be another reason for decoupling the prescaler knowledge from
> > the driver.  That is, the 'left shifting' done in
> > clk_fd_general_approximation()/clk_fd_round_rate() is likely to cause
> > mis-match bewteen 'rate = clk_round_rate(clk, r);' and
> > 'clk_set_rate(clk, r); rate = clk_get_rate(clk);' as kerneldoc
> > of clk_round_rate() mentions that they are kinda equivalent
> > in include/linux/clk.h. clk_fd_set_rate() doesn't really contain the
> > 'left shifting'.
> > 
> > So, it looks like decoupling is the right way to go.
> 
> OK.
> 
> ...
> 
> > > > > > Further more, is it
> > > > > > possilbe for rational_best_approximation() to make sure there is no
> > > > > > risk of overflow for best_{numerator,denominator}, since
> > > > > > max_{numerator,denominator} are already handed over to
> > > > > > rational_best_approximation()?
> > > > > 
> > > > > How? It can not be satisfied for all possible inputs.
> > > > 
> > > > Just have rational_best_approximation() make sure
> > > > best_{numerator,denominator} are in the range of
> > > > [1, max_{numerator,denominator}] for all given_{numerator,denominator}.
> > > > At the same time, best_numerator/best_denominator should be as close
> > > > to given_numerator/given_denominator as possible. For this particular
> > > > fractional divider clk use case, clk_round_rate() can be called
> > > > multiple times until users find rounded rate is ok.
> > > 
> > > How is it supposed to work IRL? E.g. this driver is being used for UART. Serial
> > 
> > I guess the drivers are drivers/acpi/acpi_lpss.c and drivers/mfd/intel-
> > lpss.c? Both for Intel.
> 
> At least those I have knowledge of. Others, if any, seem to have taken
> this into account.
> 
> > > core (or even TTY) has a specific function to approximate the baud rate and it
> > > tries it 2 or 3 times. In case of *saturated* values it won't progress anyhow
> > > because from best rational approximation algorithm the very first attempt would
> > > be done against the best possible clock rate.
> > > 
> > > Can you provide some code skeleton to see?
> > 
> > Perhaps, two approaches can be taken in driver which uses the
> > fractional divider clock:
> > 1) Tune prescaler to generate higher rate or lower rate accordingly
> > when clk_round_rate() for the fractional divider clock returns lower or
> > higher rates then desired rate. This might take several rounds until
> > desired rate is satisfied w/wo a tolerated bias.
> > 2) Put working clock rates and/or parent clock rates in a table as sort
> > of prior knowledge, which means less code for rate negotiation.
> 
> Often 2) is a bad idea which I'm against from day 1. I prefer to
> calculate what can be calculated.
> The 1) looks better but requires several (unnecessary IIRC) rounds.
> Why not supply the additional parameter(s) to tell that we have a
> prescaller with certain limitations?

To me, it's kinda too much information to this common frational divider
clk driver.  Making the common driver simple and easy to maintain is
important.

> 
> ...
> 
> > > > > > Overflowed/unreasonable
> > > > > > best_{numerator,denominator} don't sound like the "best" offered value.
> > > > > 
> > > > > I don't follow here. If you got saturated values it means that your input is
> > > > > not convergent. In practice it means that we will supply quite a bad value to
> > > > > the caller.
> > > > 
> > > > Just like I mentioned above, if given_{numerator,denominator} are not
> > > > convergent, best_numerator/best_denominator should be as close
> > > > to given_numerator/given_denominator as possible and at the same time
> > > > best_{numerator,denominator} are in the range of
> > > > [1, max_{numerator,denominator}].  This way, caller may have chance to
> > > > propose convergent inputs.
> > > 
> > > How? Again, provide some code to understand this better.
> > > (Spoiler: arithmetics won't allow you to do this. Or maybe
> > >  I'm badly missing something very simple and obvious...)
> > > 
> > > And, if it's possible to achieve, are you suggesting that part of
> > > what CCF driver should do the users will have been doing by their
> > > own?
> > 
> > Well, I just think it doesn't seem to be necessary for the CCF/common
> > frational drivider clk driver to have the prescaler knowledge. The
> > prescaler knowledge can be in a dedicated clk provider(if appropriate)
> > or somewhere else.
> 
> I might disagree on the grounds of the HW hierarchy and the best that
> we may achieve in _one_ pass. For example, for a 16-bit additional
> prescaler it will require up to 16 steps to get the best possible

Would that be an unacceptable performance penalty?

> values for the m/n. Instead we may supply to this driver the
> information about subordinate prescaler and get the best m/n. The
> caller will need to just divide the resulting rate by the asked rate
> to get a prescaler value.

IMHO, a simpler fractional divider clk driver without the prescaler
knowledge wins the tradeoff.

> 
> ...
> 
> > > TL;DR: please send a code to discuss.
> > 
> > It seems that you have some experience on those intel drivers, this
> > clock driver and rational algorithm driver and you probably have intel
> > HWs to test.  May I encourage you to look into this and decouple the
> > prescaler knowledge out :-)
> > 
> > > Thanks for review and you review of v2 is warmly welcomed!
> > 
> > I'd like to see patches to decouple the prescaler knowledge out.
> 
> Then produce them! Currently the code works for all its users and does
> not need any changes (documentation is indeed a gap).

IIUC, only the two Intel drivers mentioned before are affected.
Rockchip has it's own ->approximation() callback and i.MX7ulp hasn't
the prescaler(IIUC), thus kinda not affected.  So, perhaps you may help
look into this and decouple the prescaler knowledge out, as it seems
that you have experience on the relevant drivers and HW to test.
Anyway, to me, it is _not_ a must to have if you really think it's hard
to do or unnesessary :-)

> 
> > V2, like v1, tries to consolidate the knowledge in this fractional
> > divider clk driver. So, not the right direction I think.
> 
> Then why are you commenting here and not there? :-)

Maybe v2 was sent too quickly as the decoupling comment on v1 hasn't
been sufficiently discussed :-) I'll comment v2 briefly.

> I think I would drop patch 2 from the set (patch 1 is Acked and patch
> 3 is definitely needed to describe current state of affairs) on the
> grounds of the comments.

Please consider i.MX7ulp, as it hasn't the prescaler IIUC. i.MX7ulp
needs NO_PRESCALER flag, if we keep the prescaler knowledge in this
driver ofc.

Regards,
Liu Ying



