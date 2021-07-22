Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8D63D26EB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 17:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbhGVPBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 11:01:50 -0400
Received: from mga06.intel.com ([134.134.136.31]:59349 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230343AbhGVPBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 11:01:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="272788297"
X-IronPort-AV: E=Sophos;i="5.84,261,1620716400"; 
   d="scan'208";a="272788297"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 08:42:22 -0700
X-IronPort-AV: E=Sophos;i="5.84,261,1620716400"; 
   d="scan'208";a="433170406"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 08:42:20 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1m6apx-00H1rQ-GS; Thu, 22 Jul 2021 18:42:13 +0300
Date:   Thu, 22 Jul 2021 18:42:13 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Subject: Re: [PATCH v2 2/3] clk: fractional-divider: Introduce NO_PRESCALER
 flag
Message-ID: <YPmR1Sq1x1YtScl0@smile.fi.intel.com>
References: <20210716133448.24890-1-andriy.shevchenko@linux.intel.com>
 <20210716133448.24890-2-andriy.shevchenko@linux.intel.com>
 <9117e5212a3b743ca541918ec2b701c159ac752c.camel@nxp.com>
 <CAHp75Vdm8nO-zT0vyKcB1hOXkR7_2RY-2P_fnkjV5BCc+uoqXQ@mail.gmail.com>
 <08ca856c013aba60e686f050e06a6e3179de6030.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08ca856c013aba60e686f050e06a6e3179de6030.camel@nxp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 05:43:49PM +0800, Liu Ying wrote:
> On Thu, 2021-07-22 at 12:38 +0300, Andy Shevchenko wrote:
> > On Thu, Jul 22, 2021 at 12:33 PM Liu Ying <victor.liu@nxp.com> wrote:
> > > On Fri, 2021-07-16 at 16:34 +0300, Andy Shevchenko wrote:
> > > > The newly introduced flag, when set, makes the flow to skip
> > > > the assumption that the caller will use an additional 2^scale
> > > > prescaler to get the desired clock rate.
> > > 
> > > As I mentioned in v1 comment, it seems to be good to decouple the
> > > prescaler knowledge from this common fractional divider clk driver.
> > > This way, we'll make it simpler and easier to maintain. Also, then, the
> > > NO_PRESCALER flag is not needed at all.  However, it seems that two
> > > Intel drivers which use the frational divider drivers will be affected
> > > and rate negotiation logics need to be implemented for them.  Please
> > > consider if it's doable or not.
> > 
> > The current driver works for the certain hardware without this change.
> > If you think it's better, submit a proposal we will discuss.
> 
> Well, I'm not afford to do so. Just share an idea. I haven't got the
> intel HW to test.  As I mentioned in v1 comment, it seems that you have
> experience on relevent drivers and HW to test, may I encourage you to
> do that :-) Or forget that if you really think you won't do that.

Noted. I am in support of this idea, and will help with testing on Intel HW
if anyone submits the code.

> > > If we ultimately keep the prescaler knowledge here, please consider to
> > > add the NO_PRESCALER flag for i.MX7ulp as it hasn't the prescaler IIUC.
> > 
> > You mean there is a code which is currently using this driver w/o
> > taking into account this prescaller flavour? Can you, please, point
> > out, I'll definitely update it. Thanks for the catch!
> 
> drivers/clk/imx/clk-composite-7ulp.c

Thanks, I'll update in v3. Can you, please, look the other patch(es)?

-- 
With Best Regards,
Andy Shevchenko


