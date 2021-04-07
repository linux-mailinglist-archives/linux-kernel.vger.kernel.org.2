Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C64356FD8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 17:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353359AbhDGPHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 11:07:31 -0400
Received: from mga11.intel.com ([192.55.52.93]:41706 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242586AbhDGPH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:07:29 -0400
IronPort-SDR: uqt+0s0C/M44787dW2QEuIxYoYVBk4dz3nZf7R4RGvWk3jvb0AzmXbhwuLvD7WFOLwguR+XZCr
 oU2b5i5pt/kA==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="190123293"
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="190123293"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 08:07:19 -0700
IronPort-SDR: DoDEm7SOJomqulRq1VRGRBl1KuHBQIu9o8e/pOc5LbOmC/NuW4+Qm41Cf9B8Z173F84x8bhkqz
 qrl0Xe4m239Q==
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="519469002"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 08:07:15 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lU9lw-0022JS-AH; Wed, 07 Apr 2021 18:07:12 +0300
Date:   Wed, 7 Apr 2021 18:07:12 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 04/12] module: Add printk format to add module build
 ID to stacktraces
Message-ID: <YG3KoKbBeEQprLlp@smile.fi.intel.com>
References: <20210331030520.3816265-1-swboyd@chromium.org>
 <20210331030520.3816265-5-swboyd@chromium.org>
 <YG3HqcI173aPn0l+@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG3HqcI173aPn0l+@alley>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 04:54:33PM +0200, Petr Mladek wrote:
> On Tue 2021-03-30 20:05:12, Stephen Boyd wrote:
> > Let's make kernel stacktraces easier to identify by including the build
> > ID[1] of a module if the stacktrace is printing a symbol from a module.
> > This makes it simpler for developers to locate a kernel module's full
> > debuginfo for a particular stacktrace. Combined with
> > scripts/decode_stracktrace.sh, a developer can download the matching
> > debuginfo from a debuginfod[2] server and find the exact file and line
> > number for the functions plus offsets in a stacktrace that match the
> > module. This is especially useful for pstore crash debugging where the
> > kernel crashes are recorded in something like console-ramoops and the
> > recovery kernel/modules are different or the debuginfo doesn't exist on
> > the device due to space concerns (the debuginfo can be too large for
> > space limited devices).

...

> It shows wrong build id for vmlinux.
> And it does not show the build if for the module at all.

From your previous messages and this seems like virtualization breaks the
access / use of build ID :-(

-- 
With Best Regards,
Andy Shevchenko


