Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A31366A21
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 13:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238192AbhDULuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 07:50:14 -0400
Received: from mga17.intel.com ([192.55.52.151]:23349 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230516AbhDULuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 07:50:13 -0400
IronPort-SDR: 2LzjT24BGDcCIaYsvNOUW+MRu7HbPXy5XLyQoyxfXXC/oE6RWzwOJ8x+6AwCbEAXgtlFOjpc9I
 z7NLFnoJc0aw==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="175790771"
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="175790771"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 04:49:39 -0700
IronPort-SDR: LeZS64Dz8X1emN1lnLuT4RJTIMGqxPxWrV8dcRLsJPUquCcfnPkn4kCsw+wl4nh0/1yXmeRkVa
 7kbArOFiF2Hw==
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="455313292"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 04:49:36 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lZBML-0062F7-Cn; Wed, 21 Apr 2021 14:49:33 +0300
Date:   Wed, 21 Apr 2021 14:49:33 +0300
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
Message-ID: <YIARTVqnN8t/FA/P@smile.fi.intel.com>
References: <20210420215003.3510247-1-swboyd@chromium.org>
 <20210420215003.3510247-6-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420215003.3510247-6-swboyd@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 02:49:55PM -0700, Stephen Boyd wrote:
> Let's make kernel stacktraces easier to identify by including the build
> ID[1] of a module if the stacktrace is printing a symbol from a module.
> This makes it simpler for developers to locate a kernel module's full
> debuginfo for a particular stacktrace. Combined with
> scripts/decode_stracktrace.sh, a developer can download the matching
> debuginfo from a debuginfod[2] server and find the exact file and line
> number for the functions plus offsets in a stacktrace that match the
> module. This is especially useful for pstore crash debugging where the
> kernel crashes are recorded in something like console-ramoops and the
> recovery kernel/modules are different or the debuginfo doesn't exist on
> the device due to space concerns (the debuginfo can be too large for
> space limited devices).
> 
> Originally, I put this on the %pS format, but that was quickly rejected
> given that %pS is used in other places such as ftrace where build IDs
> aren't meaningful. There was some discussions on the list to put every
> module build ID into the "Modules linked in:" section of the stacktrace
> message but that quickly becomes very hard to read once you have more
> than three or four modules linked in. It also provides too much
> information when we don't expect each module to be traversed in a
> stacktrace. Having the build ID for modules that aren't important just
> makes things messy. Splitting it to multiple lines for each module
> quickly explodes the number of lines printed in an oops too, possibly
> wrapping the warning off the console. And finally, trying to stash away
> each module used in a callstack to provide the ID of each symbol printed
> is cumbersome and would require changes to each architecture to stash
> away modules and return their build IDs once unwinding has completed.
> 
> Instead, we opt for the simpler approach of introducing new printk
> formats '%pS[R]b' for "pointer symbolic backtrace with module build ID"
> and '%pBb' for "pointer backtrace with module build ID" and then
> updating the few places in the architecture layer where the stacktrace
> is printed to use this new format.
> 
> Example:

Please, shrink the example to leave only meaningful lines.

Why, e.g., do we need to see register dump, is it somehow different?

...

> +#ifdef CONFIG_STACKTRACE_BUILD_ID
> +	/* Module build ID */
> +	unsigned char build_id[BUILD_ID_SIZE_MAX];

Is it really string of characters? Perhaps u8 will be more explicit.

...

> +#include <linux/kernel.h>

What do you need this header for?

-- 
With Best Regards,
Andy Shevchenko


