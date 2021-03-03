Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4972132BFD1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579236AbhCCSap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:30:45 -0500
Received: from mga06.intel.com ([134.134.136.31]:45588 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1382998AbhCCQ2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 11:28:20 -0500
IronPort-SDR: X98ptwmCA8JW+xOSZQev0BMOr1Mr6nBRgVFg6bxYqCP9Gz33YFpHCL/3dEj1NQscjHTZxW0BMA
 M+t1RSwapXqw==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="248629274"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="248629274"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 08:17:07 -0800
IronPort-SDR: HK6BqoCOxzow7Nb+DpilmIyDt0ONRht09Opyru2m3nxMWlc57oeZ9IbhzMHuvtnLb6GkVpB1SI
 TFaQCPef4zeA==
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="384042326"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 08:17:04 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lHUBJ-009g4x-EE; Wed, 03 Mar 2021 18:17:01 +0200
Date:   Wed, 3 Mar 2021 18:17:01 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Petr Mladek <pmladek@suse.com>, Stephen Boyd <swboyd@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 5/7] printk: Make %pS and friends print module build ID
Message-ID: <YD+2fRo4J/ffQF8z@smile.fi.intel.com>
References: <20210301174749.1269154-1-swboyd@chromium.org>
 <20210301174749.1269154-6-swboyd@chromium.org>
 <YD9kNphaSRPk83KJ@alley>
 <20210303100012.0e6e4de3@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303100012.0e6e4de3@gandalf.local.home>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 10:00:12AM -0500, Steven Rostedt wrote:
> On Wed, 3 Mar 2021 11:25:58 +0100
> Petr Mladek <pmladek@suse.com> wrote:
> 
> > Alternative solution would be to minimize the information, for
> > example, by printing only the modules that appear in the backtrace.
> > But this might be complicated to implement.
> 
> It could be a list after the backtrace perhaps, and not part of the
> "modules linked in"?
> 
> But then you need a generic way of capturing those modules in the backtrace
> that works for every architecture.

> Honestly, I don't even know what a buildid is, and it is totally useless
> information for myself. What exactly is it used for?

Dunno Stephen's motivation, but build ID is very useful when you do tracing,
then based on ID the decoders can know what exactly was the layout of the
binary and list of (exported) functions, etc.

At least that was my (shallow) experience with perf last time I have tried it.

-- 
With Best Regards,
Andy Shevchenko


