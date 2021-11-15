Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A612E45029C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 11:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237569AbhKOKlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 05:41:53 -0500
Received: from mga03.intel.com ([134.134.136.65]:65461 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237554AbhKOKlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 05:41:18 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="233358804"
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="233358804"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 02:38:14 -0800
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="671461205"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 02:38:12 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mmZND-0071tm-OB;
        Mon, 15 Nov 2021 12:38:03 +0200
Date:   Mon, 15 Nov 2021 12:38:03 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v1 1/1] printk: Remove printk.h inclusion in percpu.h
Message-ID: <YZI4i5hsgD4pDjoQ@smile.fi.intel.com>
References: <20211112140749.80042-1-andriy.shevchenko@linux.intel.com>
 <YY6vV2zUTdH5SNt5@fedora>
 <YZIs1FvxA0hKylNd@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZIs1FvxA0hKylNd@alley>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 10:48:04AM +0100, Petr Mladek wrote:
> On Fri 2021-11-12 13:15:51, Dennis Zhou wrote:
> > On Fri, Nov 12, 2021 at 04:07:49PM +0200, Andy Shevchenko wrote:
> > > After the commit 42a0bb3f7138 ("printk/nmi: generic solution for safe printk
> > > in NMI") the printk.h is not needed anymore in percpu.h.
> > > 
> > > Moreover `make headerdep` complains (an excerpt)
> > > 
> > > In file included from linux/printk.h,
> > >                  from linux/dynamic_debug.h:188
> > >                  from linux/printk.h:559 <-- here
> > >                  from linux/percpu.h:9
> > >                  from linux/idr.h:17
> > > include/net/9p/client.h:13: warning: recursive header inclusion
> > > 
> > > Yeah, it's not a root cause of this, but removing will help to reduce
> > > the noise.
> > > 
> > > Fixes: 42a0bb3f7138 ("printk/nmi: generic solution for safe printk
> > > in NMI")
> 
> Yup, the include was there because of printk_func_t definition that
> was removed by the above commit.
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> > Hey Andrew, it doesn't seem like I have anything big coming through
> > percpu, do you mind taking this. I might have some stuff due to sh, but
> > I'm still working on that with them.
> 
> I assume that either Andrew or Dennis will take this patch.

I assumed you take it, that's why I haven't Cc'ed Andrew in the first place,
but it seems you have a consensus with Dennis that Andrew is the best
maintainer to take this. So, I'll send v2 with tags and Cc to him.

Thanks!

-- 
With Best Regards,
Andy Shevchenko


