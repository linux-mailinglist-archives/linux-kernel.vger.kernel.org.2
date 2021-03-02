Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8AE732A964
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 19:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580833AbhCBSVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:21:43 -0500
Received: from mga06.intel.com ([134.134.136.31]:34803 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1447268AbhCBPdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:33:18 -0500
IronPort-SDR: yBONr8JFZIXgcK14onfp8saPU445QnqpqtNWtxA/2+JXLk0XoOyFct/se3gXfJRHEHrPdEIEc/
 J7TtOXIjZRRA==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="248258123"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="248258123"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 07:29:58 -0800
IronPort-SDR: 15rbFgAnk1wAoW7qk1qh3Hjl7Tu8j51q4BNQ81ulINlDE+FX3Och0OoDdI2Pe48lHAUUROIIQu
 U2P/3RJuIUYQ==
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="368995015"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 07:29:52 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lH6y4-009Pvb-Jh; Tue, 02 Mar 2021 17:29:48 +0200
Date:   Tue, 2 Mar 2021 17:29:48 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Petr Mladek <pmladek@suse.com>, Marco Elver <elver@google.com>,
        Timur Tabi <timur@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        roman.fietze@magna.com, Kees Cook <keescook@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pavel Machek <pavel@ucw.cz>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH 3/3] [v4] lib/vsprintf: no_hash_pointers prints all
 addresses as unhashed
Message-ID: <YD5Z7Ax6vcAejoqR@smile.fi.intel.com>
References: <20210214161348.369023-1-timur@kernel.org>
 <20210214161348.369023-4-timur@kernel.org>
 <CAMuHMdULKZCJevVJcp7TxzLdWLjsQPhE8hqxhnztNi9bjT_cEw@mail.gmail.com>
 <CANpmjNNm-4s16_KQ1_NqFN4XOESJh4_=33LHQzt+p4V0Cy=Xzw@mail.gmail.com>
 <CAMuHMdWWsZ-vTGZCeLtcwLTuBYpeP0STfhrK37wiwmyfsQ798A@mail.gmail.com>
 <YD49x/UGUq6MSE39@alley>
 <8893ff08-1e50-316c-f632-cd37be1690d5@suse.cz>
 <CAMuHMdUB4DZxHo=j1+EsSsoGCdWmDO9mBo0cUtAH4OYHy3sBzw@mail.gmail.com>
 <20210302090811.620ae7d0@gandalf.local.home>
 <CAMuHMdVYJ0ydFEZ+xPLt27J9pBW+B8pJNPBDZ2Vw5g5k1atarg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVYJ0ydFEZ+xPLt27J9pBW+B8pJNPBDZ2Vw5g5k1atarg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 03:28:09PM +0100, Geert Uytterhoeven wrote:
> On Tue, Mar 2, 2021 at 3:08 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Tue, 2 Mar 2021 14:49:42 +0100
> > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > So this is basically a kernel tinyfication issue, right? Is that still pursued
> > > > today? Are there better config options suitable for this than CONFIG_DEBUG_KERNEL?
> > >
> > > As long as I hear about products running Linux on SoCs with 10 MiB of
> > > SRAM, I think the answer is yes.
> > > I'm not immediately aware of a better config option.  There are no more
> > > TINY options left, and EXPERT selects DEBUG_KERNEL.
> >
> > Since the trace_printk() uses the same type of notice, I wonder if we could
> > make this into a helper function and just pass in the top part.
> >
> > +       pr_warn("**********************************************************\n");
> > +       pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> > +       pr_warn("**                                                      **\n");
> >
> >
> > +       pr_warn("** This system shows unhashed kernel memory addresses   **\n");
> > +       pr_warn("** via the console, logs, and other interfaces. This    **\n");
> > +       pr_warn("** might reduce the security of your system.            **\n");
> >
> > Only the above section is really unique. The rest can be a boiler plate.
> 
> Good idea. drivers/iommu/iommu-debugfs.c has a third copy.

+1. Let's keep it in some helper that can be added if we have a corresponding
functionality.

> > +       pr_warn("**                                                      **\n");
> > +       pr_warn("** If you see this message and you are not debugging    **\n");
> > +       pr_warn("** the kernel, report this immediately to your system   **\n");
> > +       pr_warn("** administrator!                                       **\n");
> > +       pr_warn("**                                                      **\n");
> > +       pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> > +       pr_warn("**********************************************************\n");
> 
> Fortunately gcc is already smart enough to deduplicate identical strings,
> but only in the same source file.

-- 
With Best Regards,
Andy Shevchenko


