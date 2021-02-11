Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0716F3188D4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 11:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhBKK6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 05:58:09 -0500
Received: from mga18.intel.com ([134.134.136.126]:60711 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230394AbhBKKsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 05:48:12 -0500
IronPort-SDR: pG3RBk4FpLL4vf+Mg3kONjxNV7+TlXruVD1gs/VkfWnLuDkVdtAZ6Gl72RDzpcUlkmdxS8L8Rg
 rkr+OP+isKaw==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="169894626"
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400"; 
   d="scan'208";a="169894626"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 02:45:06 -0800
IronPort-SDR: 21dSgq7fa0xJwBvXYfTapFKJGSh0Tc3D33IoipvYh/sLjy43jrZEMuApjWhr66BpN+VV4TdutS
 aIpvPY6zocKA==
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400"; 
   d="scan'208";a="510779032"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 02:45:01 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lA9Sz-004CZq-Nr; Thu, 11 Feb 2021 12:44:57 +0200
Date:   Thu, 11 Feb 2021 12:44:57 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Timur Tabi <timur@kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        akpm@linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        roman.fietze@magna.com, Kees Cook <keescook@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        akinobu.mita@gmail.com, glider@google.com,
        Andrey Konovalov <andreyknvl@google.com>,
        Marco Elver <elver@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pavel Machek <pavel@ucw.cz>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/3][v3] add support for never printing hashed addresses
Message-ID: <YCUKqUc8GNjZLI16@smile.fi.intel.com>
References: <20210210213453.1504219-1-timur@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210213453.1504219-1-timur@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 03:34:50PM -0600, Timur Tabi wrote:
> [The list of email addresses on CC: is getting quite lengthy,
> so I hope I've included everyone.]
> 
> Although hashing addresses printed via printk does make the
> kernel more secure, it interferes with debugging, especially
> with some functions like print_hex_dump() which always uses
> hashed addresses.
> 
> To avoid having to choose between %p and %px, it's easier to
> add a kernel command line that treats all %p as %px.  This
> encourages developers to use %p more without making debugging
> more difficult.
> 
> Patches #1 and #2 upgrade the kselftest framework so that
> it can report on tests that were skipped outright.  This
> is needed for the test_printf module which will now skip
> %p hashing tests if hashing is disabled.
> 
> Patch #2 upgrades the printf library to check the command
> line.  It also updates test_printf().

Side note to the future contributions.

> Full series:
> 
> Acked-by: Marco Elver <elver@google.com>

That's what you usually add to each patch in the series individually.
You may use simple oneliner for this, i.e. `git filter-branch --msg-filter ...`

-- 
With Best Regards,
Andy Shevchenko


