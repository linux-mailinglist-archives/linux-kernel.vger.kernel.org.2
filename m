Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB6D3C8305
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 12:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbhGNKlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 06:41:24 -0400
Received: from mga02.intel.com ([134.134.136.20]:20183 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229518AbhGNKlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 06:41:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="197509553"
X-IronPort-AV: E=Sophos;i="5.84,238,1620716400"; 
   d="scan'208";a="197509553"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 03:38:31 -0700
X-IronPort-AV: E=Sophos;i="5.84,238,1620716400"; 
   d="scan'208";a="571132598"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 03:38:28 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m3cHW-00DHDb-Fl; Wed, 14 Jul 2021 13:38:22 +0300
Date:   Wed, 14 Jul 2021 13:38:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Subject: Re: [RFC PATCH] clk: fractional-divider: Correct max_{m,n} handed
 over to rational_best_approximation()
Message-ID: <YO6+nkzDlNM/KJio@smile.fi.intel.com>
References: <20210714064129.1321277-1-victor.liu@nxp.com>
 <YO6qfQMcvr9szZTJ@smile.fi.intel.com>
 <1f1b38f9c42093bea5e6a8ccb458bdf799069157.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f1b38f9c42093bea5e6a8ccb458bdf799069157.camel@nxp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 06:10:46PM +0800, Liu Ying wrote:
> On Wed, 2021-07-14 at 12:12 +0300, Andy Shevchenko wrote:
> > On Wed, Jul 14, 2021 at 02:41:29PM +0800, Liu Ying wrote:

...

> > > /*
> > >  * Get rate closer to *parent_rate to guarantee there is no overflow
> > >  * for m and n. In the result it will be the nearest rate left shifted
> > >  * by (scale - fd->nwidth) bits.
> > >  */
> > 
> > I don't know how to rephrase above comment better.
> > 
> > > scale = fls_long(*parent_rate / rate - 1);
> > > if (scale > fd->nwidth)
> > > 	rate <<= scale - fd->nwidth;
> > 
> > This takes an advantage of the numbers be in a form of
> > 
> > 	n = k * 2^m, (1)
> > 
> > where m will be scale in the snippet above. Thus, if n can be represented by
> > (1), we opportunistically reduce amount of bits needed for it by shifting right
> > by m bits.
> > 
> > Does it make sense?
> 
> Thanks for your explaination.
> But, sorry, Jacky and I still don't understand this.

Okay, We have two values in question:
 r_o (original rate of the parent clock)
 r_u (the rate user asked for)

We have a pre-scaler block which asks for
 m (denominator)
 n (nominator)
values to be provided to satisfy the (2)

	r_u ~= r_o * m / n, (2)

where we try our best to make it "=" instead of "~=".

Now, m and n have the limitation by a range, e.g.

	n >= 1, n < N_lim, where N_lim = 2^nlim. (3)

Hence, from (2) and (3), assuming the worst case m = 1,

	ln2(r_o / r_u) <= nlim. (4)

The above code tries to satisfy (4).

Have you got it now?

> > The code looks good to me, btw, although I dunno if you need to call the newly
> > introduced function before or after the above mentioned snippet.
> 
> Assuming that snippet is fully orthogonal to this patch, then it
> doesn't matter if it's before or after.

Please, double check this. Because you play with limits, while we expect them
to satisfy (3).

-- 
With Best Regards,
Andy Shevchenko


