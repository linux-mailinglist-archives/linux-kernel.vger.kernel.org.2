Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5533C3D1DF5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 08:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhGVFXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 01:23:44 -0400
Received: from mail-db8eur05on2044.outbound.protection.outlook.com ([40.107.20.44]:16033
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229502AbhGVFXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 01:23:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGY11tDk+KYbVy6on+GBsBTuKCXh9vnxEBzov9UrWp2iaeDQVTIESyEy4Gq9AVBA5tzXFigd4UdGS9HuosUTIlPw4F2lZC2056EncJXqOJeVJdnVijgfLUHJMj8pqSpXYMGRYVwGLx8t4h+mysxnSBXF0bNrNsEzZc+6nkcKUXdbRGGQA64pe2FQXmtseD2pRUXuGs62sLHg93QKDkwmLYGWb+zCXwgzzhEbCBBJk/TVr5EAmFIZRDBSEDi++WCU2lZeUpqTFcZchS9W+2ONoKvJH/ZEy1oVfUL4+gB1sDub59rVDbhp/3nhYKJj85Gn38ZXYz5RdF5CaH/CjE+73Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guOCFOz5bMLkuCJG5xm4j+UG3ecXaQIU09iAHbsp+zE=;
 b=epM2P3JlttW518a2K8Ng/LA68aQSFNnC7a+Ta34rI5imHpdLq2fHTwVgBkYv5hXIM9aOz0K3l8FlA5CdGYapBttunHk2bwBcmgKdg7lbE4rIKRdQQhELueyNkBg9cwViAIPzbE/JlOgowkkOwdVH2Msv9qMbdNnEF4hiebXi7n1r7v7OtPlcpNgGxsyCpRMPs7U8U1NHRMjTS/ChiwaYJ6NaVbh6NvI1BQOh7iX1Am0So6jWWQC1Kp+Wf6aXt1gLRWW58G9qid9+foK/aJ432aeEoOl8xgBY8sn5GWs6GkayU5NPTVJ+MwDlHN+QALOXy5XHOsRZ0G3maZJVpifS+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guOCFOz5bMLkuCJG5xm4j+UG3ecXaQIU09iAHbsp+zE=;
 b=fCo2FeFaP47Wwj4IpS7YC+ZJsmgbx+0Vw8txFlbL9Haes44/x3GyWmup31jrNpOMJYpAj2AGucStzck1ps3DgwlDf1heyT8oyy61wReAPErTwKsUIfJ1NPIWqFHpqiObaTh57U/IqwCvDYYa5pW8tgCKxyjYlf0JWYtiAXbyPQQ=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AM6PR04MB5286.eurprd04.prod.outlook.com (2603:10a6:20b:f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.25; Thu, 22 Jul
 2021 06:04:16 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::8c66:a7b4:1dc7:2c27]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::8c66:a7b4:1dc7:2c27%8]) with mapi id 15.20.4352.025; Thu, 22 Jul 2021
 06:04:16 +0000
Message-ID: <6b2a6408fcff0d064746d7a77db7b9502c66ad20.camel@nxp.com>
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
Date:   Thu, 22 Jul 2021 14:02:01 +0800
In-Reply-To: <YPVrkAarqSBMY1tV@smile.fi.intel.com>
References: <20210715120752.29174-1-andriy.shevchenko@linux.intel.com>
         <20210715120752.29174-2-andriy.shevchenko@linux.intel.com>
         <7941107fda10f075395870528f0e52d42e502d92.camel@nxp.com>
         <YPGHbvaCv/x/JlgH@smile.fi.intel.com>
         <bfa0c16e88c0d445137290b2bef104e5fa74d78a.camel@nxp.com>
         <YPVrkAarqSBMY1tV@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:3:18::16) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from blueberry (119.31.174.66) by SG2PR02CA0028.apcprd02.prod.outlook.com (2603:1096:3:18::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend Transport; Thu, 22 Jul 2021 06:04:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2eda96d-596f-492a-9ff7-08d94cd68966
X-MS-TrafficTypeDiagnostic: AM6PR04MB5286:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB52862B88E6924C943CFBDAFE98E49@AM6PR04MB5286.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eDQjo5vlHKkgrRKjMwWOHwIoprO4TijxQI367G7Y6LzaYD7f1vdzibbxmbln9uHt1BEdgQtI6s4VLSAit854iut7LcWAQWtfoPiCOfwXEtN+l8omWjD34wuLLPqaZGe/Em/Upgw1NcI29TyC6eD4x+ytrOfTU4OrDBM9eHmWE4lqVKe0dDQJ0GEo+j9wGkYdtcqc3SvegnpVHRZxexqc5YDufYTnYhf+VBxLYAdSDOhH7Xt/9GVbeYXJrxxOe/DP3vOof62ylXWsy7OKiRlVPPt3SW6AmypL3xStis51vdt2jyzsMbSOJvI+cn+tTeQ37HNH3U0BtrYw5ECxthGYMKh/fsZcUpbLcS+X2a6O43IXQxeaUDnH02su6eoqtMtMGt+Zl/tz+N+SNw4XEv2E6QiIy1nYcqtecU/KlJz/FY9N4wSacfnwC4Lued8VftnecXJzCyaM+yFwkyNb7WLMEbazeAn1HOVNvIkwT1IhPQi4LGqvw5BG2yw7RqCB66c5mQRTI9uRzqL4j05OmOplXBO2mwQn+nKqRtEZPJeqmqWh9j489+Hyia1yHNJT1/f5f6e1qP0HiA0OKXQUC9qlCLRcT5vrlBC/uD/mh4ekf7gFZNRAyy+Y2nUic0CiiH/HDjMQsv+ugyd9N4l6Rf2P4rmT3egjtFP+6XEwzJ/Bk9lRTH9eG1xZXezQ7872AEil0EcSJquqkZixaB6oOziQHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(5660300002)(2906002)(26005)(38350700002)(4326008)(86362001)(8936002)(6666004)(83380400001)(956004)(66946007)(52116002)(6486002)(316002)(54906003)(478600001)(8676002)(38100700002)(66556008)(186003)(2616005)(66476007)(36756003)(6496006)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cC9jenNuc2hPTUtVeFIzcm1vdzY4K1MybUxiSWh1elI1clU2c21yQzh5T3VE?=
 =?utf-8?B?alA4MDdiTEc1TzJvUUJwOTFRVmxpUzNva2l3SFQzcGU2ekxYc0c2M3lxdnVk?=
 =?utf-8?B?WmxKNnhyb0JwU1l5MEpacDJlVkVTS2gwWGhQclgxcG1iajFVUTlRZGxHZ0lB?=
 =?utf-8?B?bENVVEhrSXBjUWRyV2lIbEZDV21BSEV2OGhEdHBxaWllU3lSRyt0SkphdkFi?=
 =?utf-8?B?b2FhNHV3VWY3c2Vpd1lIOWw3SmZDNE1qUkg3M1RJMTQvQ1hRNUZiTjlRWCtv?=
 =?utf-8?B?aDNqRndoMldXanUySEFKMzd5R29QRThZRjBEaktmYzBDQXorcm5ZS0dDY1ZV?=
 =?utf-8?B?WE1GSUdGWis5OTBJb0IzbW5MSkllaXkwcG9PSlUzM3J5NmZCVCt2MTY5UktW?=
 =?utf-8?B?YzJ3UTYyYS9JUXhKQStQTVVFZXFqVVlla0ZjU1EwVjBSblptelNuVmpXR0VJ?=
 =?utf-8?B?NzJCUTkyY3ppTkl1K3BEUHppK240c29lNUJ4Z3lWM2FqbDYza25aRCsxRHQ1?=
 =?utf-8?B?Zk9iaXNVWTNwWXBBaisrZkdhRGZaaXhjWHRQcXJ0WWRSUE10dkxHbXR4Vk5z?=
 =?utf-8?B?eHRaUm1JU3FEdkdsdUtZKzBWQmRiQ01CWWtvdWlPejhpQXhlazl4SC9iS1Ux?=
 =?utf-8?B?Q01ieWlXdmdaN2hOWVRaeUNsNXk4UDAxTncrRlE1cnRvdUF3ckNteTZJUENB?=
 =?utf-8?B?ejVJUWNwSUlqbWo4NkhKKzNzb2JKdk9vME9rdlV2cmM0MjNIbFBXaUI4eExp?=
 =?utf-8?B?VlEveGIzRkxMc21NNDhNaWVwQnRkdXIxcEk5Y1lUNEttWEpKMzVMMklISEl0?=
 =?utf-8?B?K0oxRmhWYk14YXpaR1RVb3M4NVNKbThvNVovejZSUWRuWjZYbG5LcjM1dGt4?=
 =?utf-8?B?L01YSGlCY3ZuS0VBNTVXYWpJTEY1K0N6Y0g0V3hodlNYRzVJQWxnYmNEUEhD?=
 =?utf-8?B?ZnJOM08zTFczRGhLdDRqVFhzWWtSTFB2L1NOV1JrbC9Eakp2UkdETFRHSS95?=
 =?utf-8?B?MGs2ZzlEOTlZRElFYjI5VG5RUEhqcTJzK0ZlampwUWRybksyMFFMaHNHNkJO?=
 =?utf-8?B?UnN2ZVNWaGk4R0QrRVpWWXdtMFp5cTh6QUtlcXRXOGRaRWdYaVpoMStGSEZU?=
 =?utf-8?B?QlZSZWxleXl4YkNlQTNLZUJZQURxVXVSVEtlSGF3eWY5VGZneDhzelBqNlpx?=
 =?utf-8?B?VXVWQ2JkUXNHUmJzN3N6M3dCV1hJRTFNOVgyNm9KczdpYTBHWXVDUXlXL0Mv?=
 =?utf-8?B?MDBGM2JxWUx0bjJkZkM4NG5Rby9FR04vQWQwN215aTcyZCtaMG1za2pCYXNJ?=
 =?utf-8?B?UFhnSVk3M282YkRtMHNTZHRpS1JJZVNCQllLWlI2aWdxOHRRbzBZYXBXVndZ?=
 =?utf-8?B?Y1JDd21QclFzWkNPQXlLY09LZEdjM2xqYmJsOHZRbWxCZVl6R3NHbWlNTDQz?=
 =?utf-8?B?ZWdTdTNOZGMydFJBcHh6ZEpQMlRHNFQxOXBkOW5xSDd5M3A5clhETldqcDVt?=
 =?utf-8?B?TnlRZk9HWHYyVlVUOENRT2ZHbkZSU2ppa1hGdGQ3M09haXJBSE43Z0hpa1ht?=
 =?utf-8?B?UHZKSFgwMkxZSmFwVXZERWlIaVFaN3FtcHJGQ2xrN3lWbzFGTXdLOFNaMEFV?=
 =?utf-8?B?SEQzcTBBM25kSk5XaGZyYllQUWNhQ3d0NFRZeWozU1luaGE4M3RGQmpLRmxU?=
 =?utf-8?B?ekZybXJVcU1uSDAzN3RHZThWdWtuN0xObEZKQ21HeUVVaWNicWFyNzFHcDlH?=
 =?utf-8?Q?1hhlSSU/qIPgzm9FLz4UVXP1fVzOe5QQ6rSARIE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2eda96d-596f-492a-9ff7-08d94cd68966
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 06:04:16.3254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SkbhmtapevK1T4yduRqrJD9SltjxSokZWiETzQZ0pqhW7Jt3KPmy7EiGzuJk3L8k0lIxSPCaY3On5JHrhxGVmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5286
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-07-19 at 15:09 +0300, Andy Shevchenko wrote:
> On Mon, Jul 19, 2021 at 11:16:07AM +0800, Liu Ying wrote:
> > On Fri, 2021-07-16 at 16:19 +0300, Andy Shevchenko wrote:
> > > On Fri, Jul 16, 2021 at 10:43:57AM +0800, Liu Ying wrote:
> > > > On Thu, 2021-07-15 at 15:07 +0300, Andy Shevchenko wrote:
> 
> ...
> 
> > > > Second and more important, it seems that it would be good to decouple
> > > > the prescaler knowledge from this fractional divider clk driver so as
> > > > to make it simple(Output rate = (m / n) * parent_rate).  This way, the
> > > > CLK_FRAC_DIVIDER_NO_PRESCALER flag is not even needed at the first
> > > > place, which means rational_best_approximation() just _directly_
> > > > offer best_{numerator,denominator} for all cases.
> > > 
> > > Feel free to submit a patch, just give a good test to avoid breakage of almost
> > > all users of this driver.
> > 
> > Maybe someone may do that.
> 
> Perhaps. The idea per se is good I think, but I doubt that the implementation
> will be plausible.
> 
> > I just shared my thought that it sounds
> > like a good idea
> 
> Thanks!
> 
> > to decouple the prescaler knowledge from this
> > fractional divider clk driver.
> 
> Are you suggesting that each of the device that has _private_ pre-scaler has to
> be a clock provider at the same time?

Maybe it depends on specific devices.  But, if a device is designed to
dedicatedly control clocks, being a clock provider seems to be
intuitive.

> 
> OTOH you will probably need irrespresentable hierarchy to avoid saturated values.
> 
> At least those two issues I believe makes the idea fade in complications of the
> actual implementation. But again, send the code (you or anybody else) and we will
> see how it looks like.

Aside from making this fractional divider clk driver simple, there
seems to be another reason for decoupling the prescaler knowledge from
the driver.  That is, the 'left shifting' done in
clk_fd_general_approximation()/clk_fd_round_rate() is likely to cause
mis-match bewteen 'rate = clk_round_rate(clk, r);' and
'clk_set_rate(clk, r); rate = clk_get_rate(clk);' as kerneldoc
of clk_round_rate() mentions that they are kinda equivalent
in include/linux/clk.h. clk_fd_set_rate() doesn't really contain the
'left shifting'.

So, it looks like decoupling is the right way to go.

> 
> ...
> 
> > > > Further more, is it
> > > > possilbe for rational_best_approximation() to make sure there is no
> > > > risk of overflow for best_{numerator,denominator}, since
> > > > max_{numerator,denominator} are already handed over to
> > > > rational_best_approximation()?
> > > 
> > > How? It can not be satisfied for all possible inputs.
> > 
> > Just have rational_best_approximation() make sure
> > best_{numerator,denominator} are in the range of
> > [1, max_{numerator,denominator}] for all given_{numerator,denominator}.
> > At the same time, best_numerator/best_denominator should be as close
> > to given_numerator/given_denominator as possible. For this particular
> > fractional divider clk use case, clk_round_rate() can be called
> > multiple times until users find rounded rate is ok.
> 
> How is it supposed to work IRL? E.g. this driver is being used for UART. Serial

I guess the drivers are drivers/acpi/acpi_lpss.c and drivers/mfd/intel-
lpss.c? Both for Intel.

> core (or even TTY) has a specific function to approximate the baud rate and it
> tries it 2 or 3 times. In case of *saturated* values it won't progress anyhow
> because from best rational approximation algorithm the very first attempt would
> be done against the best possible clock rate.
> 
> Can you provide some code skeleton to see?

Perhaps, two approaches can be taken in driver which uses the
fractional divider clock:
1) Tune prescaler to generate higher rate or lower rate accordingly
when clk_round_rate() for the fractional divider clock returns lower or
higher rates then desired rate. This might take several rounds until
desired rate is satisfied w/wo a tolerated bias.
2) Put working clock rates and/or parent clock rates in a table as sort
of prior knowledge, which means less code for rate negotiation.

> 
> ...
> 
> > > > Overflowed/unreasonable
> > > > best_{numerator,denominator} don't sound like the "best" offered value.
> > > 
> > > I don't follow here. If you got saturated values it means that your input is
> > > not convergent. In practice it means that we will supply quite a bad value to
> > > the caller.
> > 
> > Just like I mentioned above, if given_{numerator,denominator} are not
> > convergent, best_numerator/best_denominator should be as close
> > to given_numerator/given_denominator as possible and at the same time
> > best_{numerator,denominator} are in the range of
> > [1, max_{numerator,denominator}].  This way, caller may have chance to
> > propose convergent inputs.
> 
> How? Again, provide some code to understand this better.
> (Spoiler: arithmetics won't allow you to do this. Or maybe
>  I'm badly missing something very simple and obvious...)
> 
> And, if it's possible to achieve, are you suggesting that part of
> what CCF driver should do the users will have been doing by their
> own?

Well, I just think it doesn't seem to be necessary for the CCF/common
frational drivider clk driver to have the prescaler knowledge. The
prescaler knowledge can be in a dedicated clk provider(if appropriate)
or somewhere else. 

> 
> TL;DR: please send a code to discuss.

It seems that you have some experience on those intel drivers, this
clock driver and rational algorithm driver and you probably have intel
HWs to test.  May I encourage you to look into this and decouple the
prescaler knowledge out :-)

> 
> Thanks for review and you review of v2 is warmly welcomed!

I'd like to see patches to decouple the prescaler knowledge out. 
V2, like v1, tries to consolidate the knowledge in this fractional
divider clk driver. So, not the right direction I think.

Regards,
Liu Ying

> 

