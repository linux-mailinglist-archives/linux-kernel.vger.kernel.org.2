Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3533738C61F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 13:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbhEUMAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 08:00:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:56835 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230138AbhEUMAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 08:00:32 -0400
IronPort-SDR: IDLUEa0KXgG51GtPP2rYzQIqL5SVjNeb+zopv8+3GYa63nlgY9t2nGCH7vQ4RrbNbWYffl/Kk1
 Z6CeQaFwVOJA==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="198383135"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="198383135"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 04:59:08 -0700
IronPort-SDR: 964GNzNNcueW7f3X+WLXZ13B02Xofd6Gu9fJaDkF68VNSvJ82YDwp/y/0znW57e2L83MY8k6pL
 SG5vvUXG/BMw==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="462463118"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 04:59:06 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lk3nz-00Dha1-CT; Fri, 21 May 2021 14:59:03 +0300
Date:   Fri, 21 May 2021 14:59:03 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Yury Norov <yury.norov@gmail.com>,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] linux/bits.h: Fix compilation error with GENMASK
Message-ID: <YKeghxRY4FeOKuwb@smile.fi.intel.com>
References: <20210511203716.117010-1-rikard.falkeborn@gmail.com>
 <20210520134112.ee15f156f1b7dbd3d8f16471@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520134112.ee15f156f1b7dbd3d8f16471@linux-foundation.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 01:41:12PM -0700, Andrew Morton wrote:
> On Tue, 11 May 2021 22:37:15 +0200 Rikard Falkeborn <rikard.falkeborn@gmail.com> wrote:
> 
> > --- a/include/linux/const.h
> > +++ b/include/linux/const.h
> > @@ -3,4 +3,12 @@
> >  
> >  #include <vdso/const.h>
> >  
> > +/*
> > + * This returns a constant expression while determining if an argument is
> > + * a constant expression, most importantly without evaluating the argument.
> > + * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
> > + */
> > +#define __is_constexpr(x) \
> > +	(sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
> 
> Boggle.
> 
> Could someone please sometime enhance that comment a bit?  What need
> does this thing satisfy and how on earth does it work?

Some summary based on (links from) https://vegard.wiki/w/is_constexpr() ?

-- 
With Best Regards,
Andy Shevchenko


