Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 134DE30E34F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 20:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhBCTcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 14:32:21 -0500
Received: from mga07.intel.com ([134.134.136.100]:38621 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229957AbhBCTcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 14:32:19 -0500
IronPort-SDR: /W9l062rcCZ9z29mYqOUwV4+VpY4L42/UYs0LK79IfZbfIl3G2M5oSubHi4FYeP83RoE5P0B1E
 SIZlqort0w3A==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="245178857"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="245178857"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 11:30:31 -0800
IronPort-SDR: rk+x0kdRJQ2cymIKplWCGUcSjS3JrXe3MwBpXeb8yoLu7a7kPaAwIFvRxBkTgfW8d4dCqcFn6k
 bIbIw7/7T1ZA==
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="406761288"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 11:30:27 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l7Nr6-001iCt-9m; Wed, 03 Feb 2021 21:30:24 +0200
Date:   Wed, 3 Feb 2021 21:30:24 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Timur Tabi <timur@kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, vbabka@suse.cz, linux-mm@kvack.org,
        willy@infradead.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, roman.fietze@magna.com,
        keescook@chromium.org, john.ogness@linutronix.de,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        akinobu.mita@gmail.com
Subject: Re: [PATCH][RESEND] lib/vsprintf: make-printk-non-secret printks all
 addresses as unhashed
Message-ID: <YBr50OxRnoZJ4jTw@smile.fi.intel.com>
References: <20210202213633.755469-1-timur@kernel.org>
 <YBpyzxBYIYapHaDT@alley>
 <YBqlooegQgEfPG4T@alley>
 <19c1c17e-d0b3-326e-97ec-a4ec1ebee749@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19c1c17e-d0b3-326e-97ec-a4ec1ebee749@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 12:58:41PM -0600, Timur Tabi wrote:
> On 2/3/21 7:31 AM, Petr Mladek wrote:
> > Also please make sure that lib/test_printf.c will work with
> > the new option.
> 
> As you suspected, it doesn't work:
> 
> [  206.966478] test_printf: loaded.
> [  206.966528] test_printf: plain 'p' does not appear to be hashed
> [  206.966740] test_printf: failed 1 out of 388 tests
> 
> What should I do about this?
> 
> On one hand, it is working as expected: %p is not hashed, and that should be
> a warning.
> 
> On the other hand, maybe test_printf should be aware of the command line
> parameter and test to make sure that %p is NOT hashed?

test_printf.c should be altered accordingly to avoid any failed test cases.
I.o.w. you need to have some kind of conditional there:

 if (kernel_cmdline_parameter_foo)
	expect bar
 else
	expect baz

-- 
With Best Regards,
Andy Shevchenko


