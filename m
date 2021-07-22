Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEFD3D21AC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 12:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbhGVJYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 05:24:12 -0400
Received: from mail-eopbgr60043.outbound.protection.outlook.com ([40.107.6.43]:13953
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231325AbhGVJVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 05:21:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPzMTLQ5gp96j+miAmLlhOs/kV5ySlTFp/xIKpNPFqiEPKCrFJX/zADBmRx9+T3syww7odEOlinMe1cxPKp29iQVMEhyWa8kCKzWpt3Df4QpHBEH13WEg339bs52ozCfr7aNKsifeyu4mCZfRx06u9olkuwrzdiAJ14aRh9X4khumpHSD1QmY+lcuF+ZIbXtflv4YO3hN+DkpMSuI12TGRY0hQ+l8PFC26fbR0PAwoUzWxBPkNrSZy3hP12swi0DOQgTyKkz9DDysYarOfJR/ch8foSm0QmteHDzJJNrjhZYj16iwKmcKdSDR1v7Y83dv6G4H5O8gvbYod50qZ7dvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3lw0tpL6s6bs7skAAVnMCTVTT/BcREVQRtKQfbABvA=;
 b=cGTR4mFzP0aOxF5Q9nfQM8rzJwRIL9qADlPZOSFh+20Zn3e4qu6Dfm4ddjYLAVOUrL72MCFdQA5eQPzL0r+e6gf4311knsLziztlXVeCGqt3s2rUd5FRiKjXDMEwFUoVXZjRlVJsBZWjYus+BPfPHkXa7kejowAHp/BxNw6cg0ftRPZ8I2C7Ky3KWt1QXtp/wSlHWbwlVaVs9Hpu7wln4ANS8I7iS7/ZKg/qacXpZqEnHNcfkF5/iHeZxbHATd9MRceBrbeLeGTlFbfTZ86+cB6FlT6Odj35UKTDOM4lFgwvczSMiGDih6zuEYKV59/k0gGav3v0R/5nFGWj/WUmRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3lw0tpL6s6bs7skAAVnMCTVTT/BcREVQRtKQfbABvA=;
 b=WvxFPgLoLwd6KrkDNcQjMw14+GxujsSkODchMggRS+d9X3JAd/MTMLXP94kgl7fIm2VsoVdRgxUQgSZ65/8eKrR8jx9G7juUDYuTbNqC1X0Ihw9CBaHAVgcXcDjPDDrgSJElBB27Wkq8sf5W+uUDNzFIFkMYNdZIR0cQyWizDqU=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AM6PR04MB5208.eurprd04.prod.outlook.com (2603:10a6:20b:9::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.28; Thu, 22 Jul
 2021 10:01:38 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::8c66:a7b4:1dc7:2c27]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::8c66:a7b4:1dc7:2c27%8]) with mapi id 15.20.4352.025; Thu, 22 Jul 2021
 10:01:38 +0000
Message-ID: <a6a5d78ff92573ec02b74216e7f691816fa26c11.camel@nxp.com>
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
Date:   Thu, 22 Jul 2021 17:59:24 +0800
In-Reply-To: <CAHp75VduRAcZLOxvk+QByn=Uw6JcEwfsby2QPib1OZTNETeObQ@mail.gmail.com>
References: <20210715120752.29174-1-andriy.shevchenko@linux.intel.com>
         <20210715120752.29174-2-andriy.shevchenko@linux.intel.com>
         <7941107fda10f075395870528f0e52d42e502d92.camel@nxp.com>
         <YPGHbvaCv/x/JlgH@smile.fi.intel.com>
         <bfa0c16e88c0d445137290b2bef104e5fa74d78a.camel@nxp.com>
         <YPVrkAarqSBMY1tV@smile.fi.intel.com>
         <6b2a6408fcff0d064746d7a77db7b9502c66ad20.camel@nxp.com>
         <CAHp75VeTyWe6SWpWMRYh4Ah6LYULNHBuSo7Tq2AX=vdsObnTLw@mail.gmail.com>
         <3cd7393a34ca991184722e57b6c64737973b31c4.camel@nxp.com>
         <CAHp75VduRAcZLOxvk+QByn=Uw6JcEwfsby2QPib1OZTNETeObQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR0401CA0005.apcprd04.prod.outlook.com
 (2603:1096:3:1::15) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from blueberry (119.31.174.66) by SG2PR0401CA0005.apcprd04.prod.outlook.com (2603:1096:3:1::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend Transport; Thu, 22 Jul 2021 10:01:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60efc114-90af-4591-3c1f-08d94cf7b21b
X-MS-TrafficTypeDiagnostic: AM6PR04MB5208:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB5208F9366325BC3EE846FD4F98E49@AM6PR04MB5208.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lg7cY+KsIwX6bQ68vyYHQB6sbOpHHA+dCu7c1Eoy5QFwBdMlTR5OF4VakIoHUQVEJk7OU8LM1jLlmpT6IiC7JeaPqLHSJ651akPN5jeOnKYDZLPidScZRi4OEsV923zNRNWvQeaWgjrNEdStOQrahFUGUkOTuKqOGk3/XIH6j17OP3Fw27LQh1EOC1B9W2H2FLU8ps356YdPdm1w+OLfEHv2pH3FEiu+bE75vdbPPqnoUFRh38rTWsrz2eDjwJwhm6ZBu/lijWpcNFqHZQOHxmTRkwSyvFcqyAVWGPVKJhkepRNci1yC+A2ZNX9XUwrqxDCL2lkvewcBUUZM3aiU6a4qVzcvJKXKKLCR9T8rBMYQE5NiHij/RatleGM2sV+MrTWVMPQ4jWr/ifrIlcPP4frBqZDyoEkBH68mrqI4iqGlGCXrnZcAcZeOHx0sAfq6NuY2GtyFhLMyxvrsUlZsivFwEPxwkABrQ9eskyfQzYFRvxs6sUnJ2FCxnGnbG5ZlgA6043DpH80HXiXBMN/U2RMUXpsF4f4YsVtJXQaC4Baxc6ri6fCNMqqEowZkK5MNsW+iTKi6vEg8HJ55AT/fFGL5IC9DHgPvI91BkVWmr2yi9ROX8ny4gUhHFnRthcLqh6bxe0rarbZgDxcqKsX/pq1ul0uO7B9BT89EbbPR4u4leq7QfNp/avO5zzQr/lO+TuIiiafyyFX5xhFLUrvMU8ZHLzey5canBJ9CrJ5RYHQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(66556008)(26005)(36756003)(6666004)(38100700002)(8676002)(66476007)(66946007)(54906003)(6486002)(8936002)(38350700002)(2906002)(53546011)(52116002)(6916009)(6496006)(7416002)(83380400001)(2616005)(316002)(86362001)(956004)(4326008)(186003)(5660300002)(175924003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YU9OejNJY1ZjVWNzVmRqaUxRb3RVRGxyTWlLakgwd0o4cGpleUtSKzBwTFh4?=
 =?utf-8?B?eGxhMFJ0OVNpcklNY2ZSY3dLSWI1eDIySEc5UnpGSWt0bmNQdDRCS1cySEo5?=
 =?utf-8?B?d2Zld0VqL29pYUhyWjkwRlhJOHZNVVBsN0hPbjhpV1JiYXk2RG5hanY0WlpF?=
 =?utf-8?B?aWNPVmpWcEFFNFdQeElTQWZXamdVUisvUjRhcHZHRjNuTzBuTUw0dUxrWWNq?=
 =?utf-8?B?dmI4TTFqRDl6RmdQQmtiMDJVd3NZdEpiSmtWV0FHQ0plRkxVcCtDa2IxM1B4?=
 =?utf-8?B?YUQwNlk3OVlIb3c0MEhGYkE4OWd4SnN2RWVqdmVBbFkxM2trQWRvbTU4L0Yv?=
 =?utf-8?B?WlZaSkxacjgxa25NaS83bFVyQTN4eUFBVlA0MFh2c1RybmNwdXd1VWVQQk5M?=
 =?utf-8?B?TVUrem90R3hEM3lheld6L3RRdjRTWFlFWEwyMU51NWw0TGViSUJUZVNtcFA0?=
 =?utf-8?B?VjRlWGlURTZaNW1tSTVwZ1lobnhTby85NWdwbkVsMFk4WmR5bm5HaUV3eVh1?=
 =?utf-8?B?QmV6Q3BTQVRDTCswaU1ENDY3WklPOGI3a25jWHNDbFRtRGZ1N0xSVXJoZWZj?=
 =?utf-8?B?ZVhxek9VTUEvd2NWdWJNdlpBWndVODlPQnZ4RFZidmJvSk8rRjM5T2VzUFho?=
 =?utf-8?B?dDZPY0Z0ejk4dU8wRE4wV2ErSEt6Nm5rR0EyUTRGR0VaT2tZQ1ZZWHY4cWd5?=
 =?utf-8?B?TWI4NFVhRkE5djFyOU9XRjlHcUJGTU45a1pDZG9MZ0hzRzhLWkpLYyt0Sldp?=
 =?utf-8?B?V1N2NHpRWXQzbXoxVVRHUWRYWGNzbHNidDZVVDNiR0xSMmZOY25aaGVmSDU2?=
 =?utf-8?B?WUp2QVB0QTMyZWlpd0RkWmZCKzcyQUhkWjQ1ejMwWjFXZ29uUDJTNEZFMjky?=
 =?utf-8?B?THM3dlhlZWFBc2xBOFhRaXRTZzJzclNIb3N0b1NVclF0SDdEampxQkFNU2E3?=
 =?utf-8?B?eS91WVNIK1p4V2N2ZFI4Q2xZcFk3U29HcXFvZVJ1RFZBTFF2aVRUaUhGTGtJ?=
 =?utf-8?B?LzhUTmFuVXdteFBuMThRSlB3MklWbzRZYUdNQnk0VXZFYmpzV1JNVTlsUm44?=
 =?utf-8?B?Y1FoeDV5aFo3NlE4YlZOQ3F4VXJhSHhWY08zZ2w1Nm1ZL0pvTWxpM280aXpW?=
 =?utf-8?B?MTU1bnlkSDg4RTQrLzRZdVdPUVU5Q1FtQmZ4dk1xK1h2dkNQR3llSFZwbERl?=
 =?utf-8?B?TDA3S29sZnBDb0ZiMFpNTlR0NmN4aDJwcnlkR09rOG4rN2xUbklCcDgrWUtH?=
 =?utf-8?B?M1VTOTlZRHNPM3dJY1hlaW5qMXJhakl3T2M4Wlowbmp3ZEhPd3l6ZmRYTTls?=
 =?utf-8?B?aWlWeWVVZHFObnR6Q2EyUkpYY1pRNVhyd1ZlY040Rm45RC83dlFzdTU3cnpN?=
 =?utf-8?B?NlF5aTlzcWFZTXRCVjhCdGkvQTY0RTRXRk01TFdtZTB4a09OK3FYdFJWSFRr?=
 =?utf-8?B?VlBqWDNIMnBQczVBKzVwaXhYUllKV0dtNmIzOUIyYkFoN0xFZlBUQjZWc2I0?=
 =?utf-8?B?UnNFQWlTVlViY2NhNXJoc21oT2E4c1Q0UzRjNVpnMW5FU20vbUdtR1RkK0VY?=
 =?utf-8?B?S1E5WWlCcXhkL1hHcUJJaFJ5ZVpCeXhiankyc0I0MzZ6R1h3VzhHYjkxK2dx?=
 =?utf-8?B?S0FRNW9YblRpYUsvSzFKcWxFZVNpZldZTmpSNVlIVEJTR2I1dGx0SGVicXVm?=
 =?utf-8?B?dm4vV0U1Z3pTOFcvRUpyMTNYQ3JvYng4UWd4a1FiKzhRYk1jTXVXcUNlVkZq?=
 =?utf-8?Q?637L7Kn/eZ6LOJMy7Dl/J/InMr23tIQTD+bsFkT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60efc114-90af-4591-3c1f-08d94cf7b21b
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 10:01:38.0230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jQVQTHCmruiF5mOrXRVvnU+l6iRnUJFwSf//xLOYlsLpFLUuWTtZ+4V09OyCbouK+lBtD03tTjaD2zvg9KBxxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5208
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-07-22 at 12:34 +0300, Andy Shevchenko wrote:
> On Thu, Jul 22, 2021 at 12:11 PM Liu Ying <victor.liu@nxp.com> wrote:
> > On Thu, 2021-07-22 at 10:24 +0300, Andy Shevchenko wrote:
> > > On Thu, Jul 22, 2021 at 9:04 AM Liu Ying <victor.liu@nxp.com> wrote:
> > > > On Mon, 2021-07-19 at 15:09 +0300, Andy Shevchenko wrote:
> > > > > On Mon, Jul 19, 2021 at 11:16:07AM +0800, Liu Ying wrote:
> > > > > > On Fri, 2021-07-16 at 16:19 +0300, Andy Shevchenko wrote:
> > > > > > > On Fri, Jul 16, 2021 at 10:43:57AM +0800, Liu Ying wrote:
> > > > > > > > On Thu, 2021-07-15 at 15:07 +0300, Andy Shevchenko wrote:
> 
> ...
> 
> > > > > core (or even TTY) has a specific function to approximate the baud rate and it
> > > > > tries it 2 or 3 times. In case of *saturated* values it won't progress anyhow
> > > > > because from best rational approximation algorithm the very first attempt would
> > > > > be done against the best possible clock rate.
> > > > > 
> > > > > Can you provide some code skeleton to see?
> > > > 
> > > > Perhaps, two approaches can be taken in driver which uses the
> > > > fractional divider clock:
> > > > 1) Tune prescaler to generate higher rate or lower rate accordingly
> > > > when clk_round_rate() for the fractional divider clock returns lower or
> > > > higher rates then desired rate. This might take several rounds until
> > > > desired rate is satisfied w/wo a tolerated bias.
> > > > 2) Put working clock rates and/or parent clock rates in a table as sort
> > > > of prior knowledge, which means less code for rate negotiation.
> > > 
> > > Often 2) is a bad idea which I'm against from day 1. I prefer to
> > > calculate what can be calculated.
> > > The 1) looks better but requires several (unnecessary IIRC) rounds.
> > > Why not supply the additional parameter(s) to tell that we have a
> > > prescaller with certain limitations?
> > 
> > To me, it's kinda too much information to this common frational divider
> > clk driver.  Making the common driver simple and easy to maintain is
> > important.
> 
> But it has to have it due to the nature of the hardware design. If you
> leave it w/o that you have immediately come into the situation where
> the clock rate will be far too wrong because of *saturated* values.
> Have you done the arithmetics on the paper by the way?
> 
> ...
> 
> > > I might disagree on the grounds of the HW hierarchy and the best that
> > > we may achieve in _one_ pass. For example, for a 16-bit additional
> > > prescaler it will require up to 16 steps to get the best possible
> > 
> > Would that be an unacceptable performance penalty?
> 
> Yes.
> 
> > > values for the m/n. Instead we may supply to this driver the
> > > information about subordinate prescaler and get the best m/n. The
> > > caller will need to just divide the resulting rate by the asked rate
> > > to get a prescaler value.
> > 
> > IMHO, a simpler fractional divider clk driver without the prescaler
> > knowledge wins the tradeoff.
> 
> I'm far from being convinced.
> 
> ...
> 
> > > > > TL;DR: please send a code to discuss.
> 
> ^^^^ I am tired of telling you this, btw.
> 
> > > > It seems that you have some experience on those intel drivers, this
> > > > clock driver and rational algorithm driver and you probably have intel
> > > > HWs to test.  May I encourage you to look into this and decouple the
> > > > prescaler knowledge out :-)
> > > > 
> > > > > Thanks for review and you review of v2 is warmly welcomed!
> > > > 
> > > > I'd like to see patches to decouple the prescaler knowledge out.
> > > 
> > > Then produce them! Currently the code works for all its users and does
> > > not need any changes (documentation is indeed a gap).
> > 
> > IIUC, only the two Intel drivers mentioned before are affected.
> > Rockchip has it's own ->approximation() callback
> 
> ...which is using the same algo, look at the patch 1 of the series. It
> seems you missed to actually review. Just review the series as a
> whole, please!

But, the topic is to decouple the prescaler knowledge.
I reviewed it as a whole though I was not Cc'ed for the patch 1/3. It
looks like Rockchip driver doesn't have to be touched if the prescaler
knowledge is decoupled from this fractional divider clk driver.  If you
consolidate the prescaler knowledge in the Rockchip driver as patch 1/3
does, you touch it.

Regards,
Liu Ying

> 
> >  and i.MX7ulp hasn't
> > the prescaler(IIUC), thus kinda not affected.  So, perhaps you may help
> > look into this and decouple the prescaler knowledge out, as it seems
> > that you have experience on the relevant drivers and HW to test.
> > Anyway, to me, it is _not_ a must to have if you really think it's hard
> > to do or unnesessary :-)
> 
> ...
> 
> > > > V2, like v1, tries to consolidate the knowledge in this fractional
> > > > divider clk driver. So, not the right direction I think.
> > > 
> > > Then why are you commenting here and not there? :-)
> > 
> > Maybe v2 was sent too quickly as the decoupling comment on v1 hasn't
> > been sufficiently discussed :-)
> 
> Maybe.
> 
> > I'll comment v2 briefly.
> 
> Thanks!
> 
> ...
> 
> > > I think I would drop patch 2 from the set (patch 1 is Acked and patch
> > > 3 is definitely needed to describe current state of affairs) on the
> > > grounds of the comments.
> > 
> > Please consider i.MX7ulp, as it hasn't the prescaler IIUC. i.MX7ulp
> > needs NO_PRESCALER flag, if we keep the prescaler knowledge in this
> > driver ofc.
> 
> Then  we need a flag and v2 can go as is.
> 

