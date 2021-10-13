Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E6642C0FD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 15:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbhJMNJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 09:09:52 -0400
Received: from mga18.intel.com ([134.134.136.126]:50207 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234911AbhJMNJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 09:09:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="214363153"
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="214363153"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 06:07:47 -0700
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="460765949"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.159])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 06:07:44 -0700
Received: from andy by smile with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1madyw-000LGN-1h;
        Wed, 13 Oct 2021 16:07:42 +0300
Date:   Wed, 13 Oct 2021 16:07:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mike Tipton <mdtipton@codeaurora.org>,
        Andy Shevchenko <andy@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] clk: Add write operation for clk_parent debugfs node
Message-ID: <YWbaHtQpVyrrGm0k@smile.fi.intel.com>
References: <20211007182158.7490-1-semen.protsenko@linaro.org>
 <YWXaKevf8D0kKYXo@smile.fi.intel.com>
 <CAPLW+4==u6Lpi-tRpGCFjuCBUARsarJx=Lg2QVAbvXX7hOyRVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPLW+4==u6Lpi-tRpGCFjuCBUARsarJx=Lg2QVAbvXX7hOyRVg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 02:35:48PM +0300, Sam Protsenko wrote:
> On Tue, 12 Oct 2021 at 21:55, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Oct 07, 2021 at 09:21:58PM +0300, Sam Protsenko wrote:

...

> > > +#ifdef CLOCK_ALLOW_WRITE_DEBUGFS
> > > +     if (core->num_parents > 1)
> > > +             debugfs_create_file("clk_parent", 0644, root, core,
> > > +                                 &current_parent_rw_fops);
> > > +     else
> > > +#endif
> >
> > > +     {
> > > +             if (core->num_parents > 0)
> > > +                     debugfs_create_file("clk_parent", 0444, root, core,
> > > +                                         &current_parent_fops);
> > > +     }
> >
> > Currently there is no need to add the {} along with increased indentation
> > level. I.o.w. the 'else if' is valid in C.
> 
> Without those {} we have two bad options:
> 
>   1. When putting subsequent 'if' block on the same indentation level
> as 'else': looks ok-ish for my taste (though inconsistent with #ifdef
> code) and checkpatch swears:
> 
>         WARNING: suspect code indent for conditional statements (8, 8)
>         #82: FILE: drivers/clk/clk.c:3334:
>         +    else
>         [...]
>              if (core->num_parents > 0)

>   2. When adding 1 additional indentation level for subsequent 'if'
> block: looks plain ugly to me, inconsistent for the case when
> CLOCK_ALLOW_WRITE_DEBUGFS is not defined, but checkpatch is happy
> 
> I still think that the way I did that (with curly braces) is better
> one: it's consistent for all cases, looking ok, checkpatch is happy
> too. But isn't it hairsplitting? This particular case is not described
> in kernel coding style doc, so it's about personal preferences.
> 
> If it's still important to you -- please provide exact code snippet
> here (with indentations) for what you desire, I'll send v6. But
> frankly I'd rather spend my time on something more useful. This is
> minor patch, and I don't see any maintainers wishing to pull it yet.

I meant

#ifdef CLOCK_ALLOW_WRITE_DEBUGFS
	if (core->num_parents > 1)
		debugfs_create_file("clk_parent", 0644, root, core,
				    &current_parent_rw_fops);
	else
#endif
	if (core->num_parents > 0)
		debugfs_create_file("clk_parent", 0444, root, core,
				    &current_parent_fops);

But after looking at the present code, this variant is occurred 5x-10x
times less. So, only nit-picks then (note additional {} along with no
blank line):

#ifdef CLOCK_ALLOW_WRITE_DEBUGFS
	if (core->num_parents > 1) {
		debugfs_create_file("clk_parent", 0644, root, core,
				    &current_parent_rw_fops);
	} else
#endif
	{
		if (core->num_parents > 0)
			debugfs_create_file("clk_parent", 0444, root, core,
					    &current_parent_fops);
	}


-- 
With Best Regards,
Andy Shevchenko


