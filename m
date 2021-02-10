Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768FF316BE9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 17:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbhBJQ6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 11:58:37 -0500
Received: from mga06.intel.com ([134.134.136.31]:7976 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232903AbhBJQ6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 11:58:07 -0500
IronPort-SDR: jtMW4iIy6IQgyN1+zdQZT2Ypa8twsbmJYPNdXZRYqopHnB30jc/JmLtcrZwhPM7mUZBgqt6tE6
 4WsG8Ke3zqww==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="243600272"
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="243600272"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 08:54:20 -0800
IronPort-SDR: YaHAI6bJQoUB7zMRBVuvHxXrWC1N8RXcKfsBSKreSHGJXC5Jz648w2uzLzbxNb4NTkGf52nZ2R
 SwwyG1s397/A==
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="586375276"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 08:54:15 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l9skl-003m9n-6t; Wed, 10 Feb 2021 18:54:11 +0200
Date:   Wed, 10 Feb 2021 18:54:11 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Timur Tabi <timur@kernel.org>, Petr Mladek <pmladek@suse.com>,
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
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 0/3][RESEND] add support for never printing hashed
 addresses
Message-ID: <YCQPs9qg8dbSOh0S@smile.fi.intel.com>
References: <20210210051814.845713-1-timur@kernel.org>
 <6da0be5a-7cb0-4943-e61f-7c3275e60cb6@i-love.sakura.ne.jp>
 <20210210111836.2468f10a@gandalf.local.home>
 <e996ff2f-d350-1399-bb6b-8373bf70e687@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e996ff2f-d350-1399-bb6b-8373bf70e687@i-love.sakura.ne.jp>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 01:39:41AM +0900, Tetsuo Handa wrote:
> On 2021/02/11 1:18, Steven Rostedt wrote:
> > The point of this exercise is to be able to debug the *same* kernel that
> > someone is having issues with. And this is to facilitate that debugging.
> 
> That's too difficult to use. If a problem is not reproducible, we will have
> no choice but always specify "never hash pointers" command line option. If a
> problem is reproducible, we can rebuild that kernel with "never hash pointers"
> config option turned on.

I think what you are targeting is something like dynamic debug approach where
you can choose which prints to enable/disable and what enable/disable in them.

In that case you specifically apply a command line option and enable only files
/ lines in the files.

-- 
With Best Regards,
Andy Shevchenko


