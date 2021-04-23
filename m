Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAD7369463
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 16:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237106AbhDWOJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 10:09:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:7602 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229549AbhDWOJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 10:09:27 -0400
IronPort-SDR: j/pXUwxbWynoWTmvpKD/BybvFTGtuijWRnNxTscS3fq5XkZMsziwJFxo4RBFSCDwpe5AoKUxXw
 C7e1weNSI8ug==
X-IronPort-AV: E=McAfee;i="6200,9189,9963"; a="195629273"
X-IronPort-AV: E=Sophos;i="5.82,245,1613462400"; 
   d="scan'208";a="195629273"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 07:08:49 -0700
IronPort-SDR: WCFB/a5kjM960RwDycgkcNCtazkoWMOJGJwMuHe/qYLdJi+DPDmWkHKGz1RSl9v2M9r8+PmBBu
 yuOA1OH0Ue5A==
X-IronPort-AV: E=Sophos;i="5.82,245,1613462400"; 
   d="scan'208";a="385102517"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 07:08:44 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lZwU5-006Zub-9V; Fri, 23 Apr 2021 17:08:41 +0300
Date:   Fri, 23 Apr 2021 17:08:41 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-doc@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v5 05/13] module: Add printk formats to add module build
 ID to stacktraces
Message-ID: <YILU6R0OMUXo3wA7@smile.fi.intel.com>
References: <20210420215003.3510247-1-swboyd@chromium.org>
 <20210420215003.3510247-6-swboyd@chromium.org>
 <YIARTVqnN8t/FA/P@smile.fi.intel.com>
 <161913520061.46595.8469966711677906076@swboyd.mtv.corp.google.com>
 <YILKpQ2KsBXCoHlG@smile.fi.intel.com>
 <dabbab72-7534-66e2-21e1-6e0005bdc2d7@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dabbab72-7534-66e2-21e1-6e0005bdc2d7@rasmusvillemoes.dk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 03:45:56PM +0200, Rasmus Villemoes wrote:
> On 23/04/2021 15.24, Andy Shevchenko wrote:
> > On Thu, Apr 22, 2021 at 04:46:40PM -0700, Stephen Boyd wrote:
> 
> >>>> +#include <linux/kernel.h>
> >>>
> >>> What do you need this header for?
> >>>
> >>
> >> For typeof_member().
> > 
> > Argh... We really need to split this and container_of to something else. Having
> > entire kernel.h for that is an overkill.
> > 
> 
> Yeah, we should have a type-macros.h (or type-helpers or whatever) that
> doesn't include any other kernel headers, just stddef.h (which is
> compiler-provided) for offsetof(), providing
> 
> typeof_member
> sizeof_member
> container_of
> same_type
> type_min
> type_max
> is_signed_type
> __choose_type
> 
> or whatever their names are currently.

Put in my TODO list. Not sure when it will go, though.

-- 
With Best Regards,
Andy Shevchenko


