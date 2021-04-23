Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091A6369301
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 15:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236064AbhDWNZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 09:25:39 -0400
Received: from mga12.intel.com ([192.55.52.136]:31798 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229456AbhDWNZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 09:25:36 -0400
IronPort-SDR: kK0FOKpcJsrVU5ds7uOD45vpKD5enBULxfLehoun9FPz+s+dUqUjrCnZxsnhMZKTMcRF8bu0Um
 8XKmNBmVRJmw==
X-IronPort-AV: E=McAfee;i="6200,9189,9963"; a="175551467"
X-IronPort-AV: E=Sophos;i="5.82,245,1613462400"; 
   d="scan'208";a="175551467"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 06:24:59 -0700
IronPort-SDR: fU1MwX/zwew2GLGuBMdwnSfJshhZBEqFxXeg9B7pmIkZEYkobjV2mCQOh8Iy5uLxNUnvqaJ/o1
 edoxgT6ZBkWQ==
X-IronPort-AV: E=Sophos;i="5.82,245,1613462400"; 
   d="scan'208";a="456222695"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 06:24:56 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lZvnh-006ZPI-4z; Fri, 23 Apr 2021 16:24:53 +0300
Date:   Fri, 23 Apr 2021 16:24:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v5 05/13] module: Add printk formats to add module build
 ID to stacktraces
Message-ID: <YILKpQ2KsBXCoHlG@smile.fi.intel.com>
References: <20210420215003.3510247-1-swboyd@chromium.org>
 <20210420215003.3510247-6-swboyd@chromium.org>
 <YIARTVqnN8t/FA/P@smile.fi.intel.com>
 <161913520061.46595.8469966711677906076@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161913520061.46595.8469966711677906076@swboyd.mtv.corp.google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 04:46:40PM -0700, Stephen Boyd wrote:
> Quoting Andy Shevchenko (2021-04-21 04:49:33)
> > On Tue, Apr 20, 2021 at 02:49:55PM -0700, Stephen Boyd wrote:

...

> > > Example:
> > 
> > Please, shrink the example to leave only meaningful lines.
> > 
> > Why, e.g., do we need to see register dump, is it somehow different?
> 
> Can you format it how you would like to see it? Should it be a unified
> diff? I agree it would help to see "what changed" but also don't know
> what you want so opted to provide more information, not less. I was
> worried about the questions like "do you change other parts of a splat?"
> so I just put the whole thing there.


Before:
 ...line X...
 ...
 ...line Y...

After:
 ...line X'...
 ...
 ...line Y'...

Three lines of example per each paragraph, in each of them the middle one is
simply [...].

...

> > > +#ifdef CONFIG_STACKTRACE_BUILD_ID
> > > +     /* Module build ID */
> > > +     unsigned char build_id[BUILD_ID_SIZE_MAX];
> > 
> > Is it really string of characters? Perhaps u8 will be more explicit.
> 
> I'm just matching the build ID API that uses unsigned char. If you want
> u8 then we should update more places. I could do that in a followup
> patch, but this one is already sorta big.

Unsigned char here is confusing. I would prefer a prerequisite patch to fix
other places first.

...

> > > +#include <linux/kernel.h>
> > 
> > What do you need this header for?
> > 
> 
> For typeof_member().

Argh... We really need to split this and container_of to something else. Having
entire kernel.h for that is an overkill.

-- 
With Best Regards,
Andy Shevchenko


