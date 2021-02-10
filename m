Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD11316BD0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 17:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbhBJQyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 11:54:52 -0500
Received: from mga01.intel.com ([192.55.52.88]:54648 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230229AbhBJQvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 11:51:20 -0500
IronPort-SDR: 4JMgB1ajJ5Gb4sG8ygu9nZxS2bwWIm6o8mu7b9SGXxeXh/lyjCvPr7/UqfSKVuJFe2kQ3z+9xh
 0ctN5nBOidew==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="201219533"
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="201219533"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 08:49:35 -0800
IronPort-SDR: yfCmCOl9oytqv5g7tFa5BuQnDa930f7dDh0uikElaOg0eD2f78RZHjzTbm1AomoJOA0VReRq/8
 bqQFBs2DOClQ==
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="420598086"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 08:49:33 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l9sgE-003m67-8z; Wed, 10 Feb 2021 18:49:30 +0200
Date:   Wed, 10 Feb 2021 18:49:30 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Li Zefan <lizefan@huawei.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 6/8] lib: bitmap: support "N" as an alias for size of
 bitmap
Message-ID: <YCQOmkfEH0lLJY8l@smile.fi.intel.com>
References: <20210209225907.78405-1-paul.gortmaker@windriver.com>
 <20210209225907.78405-7-paul.gortmaker@windriver.com>
 <CAAH8bW_fJi_PeHrXsPZzLtRP=-L99QJBXEvHkN9w6DBP-1FPWQ@mail.gmail.com>
 <20210210155825.GA28155@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210155825.GA28155@windriver.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 10:58:25AM -0500, Paul Gortmaker wrote:
> [Re: [PATCH 6/8] lib: bitmap: support "N" as an alias for size of bitmap] On 09/02/2021 (Tue 15:16) Yury Norov wrote:
> 
> > On Tue, Feb 9, 2021 at 3:01 PM Paul Gortmaker
> > <paul.gortmaker@windriver.com> wrote:
> 
> [...]
> 
> > > -static const char *bitmap_getnum(const char *str, unsigned int *num)
> > > +static const char *bitmap_getnum(const char *str, unsigned int *num,
> > > +                                unsigned int lastbit)
> > 
> > The idea of struct bitmap_region is avoid passing the lastbit to the functions.
> > But here you do pass. Can you please be consistent? Or if I misunderstand
> > the idea of struct bitmap_region, can you please clarify it?
> > 
> > Also, I don't think that in this specific case it's worth it to create
> > a hierarchy of
> > structures. Just adding lastbits to struct region will be simpler and more
> > transparent.
> 
> I'm getting mixed messages from different people as to what is wanted here.
> 
> Here is what the code looks like now; only relevant lines shown:
> 
>  -------------------------------
> int bitmap_parselist(const char *buf, unsigned long *maskp, int nmaskbits)
> {
> 
>         struct region r;
> 
>         bitmap_parse_region(buf, &r);       <-----------
>         bitmap_check_region(&r);
>         bitmap_set_region(&r, maskp, nmaskbits);
> }
> 
> static const char *bitmap_parse_region(const char *str, struct region *r)
> {
>         bitmap_getnum(str, &r->start);
>         bitmap_getnum(str + 1, &r->end);
>         bitmap_getnum(str + 1, &r->off);
>         bitmap_getnum(str + 1, &r->group_len);
> }
> 
> static const char *bitmap_getnum(const char *str, unsigned int *num)
> {
> 	/* PG: We need nmaskbits here for N processing. */
> }
>  -------------------------------
> 
> 
> Note the final function - the one where you asked to locate the N
> processing into -- does not take a region.  So even if we bundle nbits
> into the region struct, it doesn't get the data to where we need it.
> 
> Choices:
> 
> 1) pass in nbits just like bitmap_set_region() does currently.
> 
> 2) add nbits to region and pass full region instead of start/end/off.
> 
> 2a) add nbits to region and pass full region and also start/end/off.
> 
> 3) use *num as a bi-directional data path and initialize with nbits.
> 
> 
> Yury doesn't want us add any function args -- i.e. not to do #1.
> 
> Andy didn't like #2 because it "hides" that we are writing to r.
> 
> I ruled out sending 2a -- bitmap_getnum(str, r, &r->end)  because
> it adds an arg, AND seems rather redundant to pass r and r->field.
> 
> The #3 is the smallest change - but seems like we are trying to be
> too clever just to save a line of code or a couple bytes. (see below)
> 
> Yury - in your reply to patch 5, you indicate you wrote the region
> code and want me to go back to putting nbits into region directly.
> 
> Can you guys please clarify who is maintainer and hence exactly how
> you want this relatively minor detail handled?  I'll gladly do it
> in whatever way the maintainer wants just to get this finally done.

Funny that there is no maintainer of the code.
That said, I consider #1 or #3 is good enough. Rationale for
- #1: it doesn't touch purity of getnum(), I think it's good enough not to know
  region details
- #3 (as you posted below): I like how it looks like (one nit below, though)

But let's put this way, I think Yury had done a lot in the area, let's listen
more to him than to me.

> I'd rather not keep going in circles and guessing and annoying everyone
> else on the Cc: list by filling their inbox any more than I already have.
> 
> That would help a lot in getting this finished.

Agree!

> Example #3 -- not sent..
> 
> +#define DECLARE_REGION(rname, initval) \
> +struct region rname = {                \
> +       .start = initval,               \
> +       .off = initval,                 \
> +       .group_len = initval,           \
> +       .end = initval,                 \
> +}
> 
> [...]
> 
> -       struct region r;
> +       DECLARE_REGION(r, nmaskbits - 1);       /* "N-N:N/N" */

I would initialize with nmaskbits to be sure the value is invalid, but it will
add some code, below, so up to you, guys.

> +/*
> + * Seeing 'N' tells us to leave the value of "num" unchanged (which will
> + * be the max value for the width of the bitmap, set via DECLARE_REGION).
> + */
>  static const char *bitmap_getnum(const char *str, unsigned int *num)
>  {
>         unsigned long long n;
>         unsigned int len;
>  
> +       if (str[0] == 'N')      /* nothing to do, just advance str */
> +               return str + 1;
> 

-- 
With Best Regards,
Andy Shevchenko


