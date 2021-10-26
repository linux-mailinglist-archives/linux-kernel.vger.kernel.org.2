Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA19843BB2C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 21:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236916AbhJZTp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 15:45:28 -0400
Received: from mga12.intel.com ([192.55.52.136]:39468 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234018AbhJZTp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 15:45:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="210081452"
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="210081452"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 12:43:03 -0700
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="664683139"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 12:43:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mfSLJ-001IPm-K4;
        Tue, 26 Oct 2021 22:42:41 +0300
Date:   Tue, 26 Oct 2021 22:42:41 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Qian Cai <quic_qiancai@quicinc.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bitmap: simplify GENMASK(size - 1, 0) lines
Message-ID: <YXhaMVTymVNzOlGT@smile.fi.intel.com>
References: <20211026144108.35373-1-quic_qiancai@quicinc.com>
 <YXhOEEOSG+fgEy+t@yury-ThinkPad>
 <YXhVVvG9keoVWJyK@smile.fi.intel.com>
 <YXhW8K7DxadyVgx3@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXhW8K7DxadyVgx3@yury-ThinkPad>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc: Greg (see below)

On Tue, Oct 26, 2021 at 12:28:48PM -0700, Yury Norov wrote:
> On Tue, Oct 26, 2021 at 10:21:58PM +0300, Andy Shevchenko wrote:
> > On Tue, Oct 26, 2021 at 11:54:16AM -0700, Yury Norov wrote:
> > > On Tue, Oct 26, 2021 at 10:41:08AM -0400, Qian Cai wrote:
> > > > Since "size" is an "unsigned int", the rvalue "size - 1" will still be
> > > > "unsigned int" according to the C standard (3.2.1.5 Usual arithmetic
> > > > conversions). Therefore, GENMASK(size - 1, 0) will always return 0UL. Those
> > > > are also caught by GCC (W=2):
> > > > 
> > > > ./include/linux/find.h: In function 'find_first_bit':
> > > > ./include/linux/bits.h:25:22: warning: comparison of unsigned expression in '< 0' is always false [-Wtype-limits]
> > > >    25 |   __is_constexpr((l) > (h)), (l) > (h), 0)))
> > > >       |                      ^
> > > > ./include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
> > > >    16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> > > >       |                                                              ^
> > > > ./include/linux/bits.h:25:3: note: in expansion of macro '__is_constexpr'
> > > >    25 |   __is_constexpr((l) > (h)), (l) > (h), 0)))
> > > >       |   ^~~~~~~~~~~~~~
> > > > ./include/linux/bits.h:38:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
> > > >    38 |  (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> > > >       |   ^~~~~~~~~~~~~~~~~~~
> > > > ./include/linux/find.h:119:31: note: in expansion of macro 'GENMASK'
> > > >   119 |   unsigned long val = *addr & GENMASK(size - 1, 0);
> > > >       |                               ^~~~~~~
> > > > ./include/linux/bits.h:25:34: warning: comparison of unsigned expression in '< 0' is always false [-Wtype-limits]
> > > >    25 |   __is_constexpr((l) > (h)), (l) > (h), 0)))
> > > >       |                                  ^
> > > > ./include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
> > > >    16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> > > >       |                                                              ^
> > > > ./include/linux/bits.h:38:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
> > > >    38 |  (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> > > >       |   ^~~~~~~~~~~~~~~~~~~
> > > > ./include/linux/find.h:119:31: note: in expansion of macro 'GENMASK'
> > > >   119 |   unsigned long val = *addr & GENMASK(size - 1, 0);
> > > >       |                               ^~~~~~~
> > > > 
> > > > Signed-off-by: Qian Cai <quic_qiancai@quicinc.com>
> > > > ---
> > > >  include/linux/find.h | 28 ++++++++--------------------
> > > >  1 file changed, 8 insertions(+), 20 deletions(-)
> > > > 
> > > > diff --git a/include/linux/find.h b/include/linux/find.h
> > > > index 5bb6db213bcb..5ce2b17aea42 100644
> > > > --- a/include/linux/find.h
> > > > +++ b/include/linux/find.h
> > > > @@ -115,11 +115,8 @@ unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
> > > >  static inline
> > > >  unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
> > > >  {
> > > > -	if (small_const_nbits(size)) {
> > > > -		unsigned long val = *addr & GENMASK(size - 1, 0);
> > > > -
> > > > -		return val ? __ffs(val) : size;
> > > > -	}
> > > > +	if (small_const_nbits(size))
> > > > +		return size;
> > > >  
> > > >  	return _find_first_bit(addr, size);
> > > >  }
> > > 
> > > [...]
> > > 
> > > Nice catch! I'm a bit concerned that small_const_nbits() will never
> > > allow GENMASK() to be passed with size == 0, but the patch looks
> > > good to me overall.
> > 
> > Can you explain to me how it is supposed to work?
> > 
> > For example,
> > 
> >     x = 0xaa55;
> >     size = 5;
> > 
> >     printf("%lu\n", find_first_bit(&x, size));
> > 
> > In the resulting code we will always have 5 as the result,
> > but is it correct one?
> 
> I think it would work really bad and fail to load the kernel
> for many systems, especially those with NR_CPUS == 64 or less.
> 
> That's why I think Apr 1 branch is a good place  for it.

Ah, I have got you. We are on the same page then.

Now, I have checked that email appearance in the upstream:

$ git log --oneline --author="quic_qiancai@quicinc.com"
95cadae320be fortify: strlen: Avoid shadowing previous locals
94560f6156fe Revert "arm pl011 serial: support multi-irq request"

While first one perhaps okay, although it also refers to W=2,
I have now doubts if the "Revert" was really thought through
and not just yet another UMN-like experiment.

Greg, what do you think is the best course of actions here?

-- 
With Best Regards,
Andy Shevchenko


