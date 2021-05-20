Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B2538A11F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 11:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbhETJ20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 05:28:26 -0400
Received: from mga04.intel.com ([192.55.52.120]:24867 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231666AbhETJ1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 05:27:23 -0400
IronPort-SDR: cWOkXYduA5qKUN/MtpytHctGf1RxpkWxEy3ykWYK9U5Ldg39uYau+t7juocRwbEmVDvU+Avk+T
 FRmonAlThUjQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="199234727"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="199234727"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 02:26:02 -0700
IronPort-SDR: e2kRdTBuU+cGLF5ifsXjUJTHofaOGVDRAQxUSVOjNml5BvguQ9kS3HqNQeRDoGJNB7Li0ZT73U
 fo/28D5QCZdw==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="394814487"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 02:25:58 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ljewF-00DRfL-6M; Thu, 20 May 2021 12:25:55 +0300
Date:   Thu, 20 May 2021 12:25:55 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Chris Down <chris@chrisdown.name>, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>, Jessica Yu <jeyu@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
Subject: Re: [PATCH v6 3/4] printk: Userspace format indexing support
Message-ID: <YKYrIzUGV7VlDu9D@smile.fi.intel.com>
References: <cover.1621338324.git.chris@chrisdown.name>
 <05d25c65d3f5149c1e8537f74041a7a46bd489d6.1621338324.git.chris@chrisdown.name>
 <YKPBk+7lTzs8WFAk@smile.fi.intel.com>
 <YKPKMCNz2hccaXfR@chrisdown.name>
 <YKPkkiCX6gdSa/rI@smile.fi.intel.com>
 <bdbcf438-50d3-7429-36e8-c077e31bc695@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdbcf438-50d3-7429-36e8-c077e31bc695@rasmusvillemoes.dk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 08:59:06AM +0200, Rasmus Villemoes wrote:
> On 18/05/2021 18.00, Andy Shevchenko wrote:
> > On Tue, May 18, 2021 at 03:07:44PM +0100, Chris Down wrote:
> >> Andy Shevchenko writes:

...

> >>>> +	return mod ? mod->name : "vmlinux";
> >>>
> >>> First of all, you have several occurrences of the "vmlinux" literal.
> >>> Second, can't you get it from somewhere else? Is it even guaranteed that the
> >>> name is always the same?
> >>
> >> Hmm, I don't know if it's guaranteed, but we already have similar logic in
> >> (as one example) livepatch, which seems to suggest it's not obviously wrong:
> >>
> >>     % grep -R '"vmlinux"' kernel/livepatch/
> >>     kernel/livepatch/core.c:                       sympos, name, objname ? objname : "vmlinux");
> >>     kernel/livepatch/core.c:        bool sec_vmlinux = !strcmp(sec_objname, "vmlinux");
> >>     kernel/livepatch/core.c:                sym_vmlinux = !strcmp(sym_objname, "vmlinux");
> >>     kernel/livepatch/core.c:        if (strcmp(objname ? objname : "vmlinux", sec_objname))
> >>     kernel/livepatch/core.c:        name = klp_is_module(obj) ? obj->name : "vmlinux";
> >>     kernel/livepatch/core.c:                                klp_is_module(obj) ? obj->name : "vmlinux");
> >>     kernel/livepatch/core.c:                                klp_is_module(obj) ? obj->name : "vmlinux");
> >>     kernel/livepatch/core.c:        if (!strcmp(mod->name, "vmlinux")) {
> >>
> >> Is there another name or method you'd prefer? :-)
> >>
> >> As for the literals, are you saying that you prefer that it's symbolised as
> >> a macro or static char, or do you know of an API where this kind of name can
> >> be canonically accessed?
> > 
> > I have heard that modern GCC (at least) can utilize same constant literals in a
> > single compilation unit, so it won't be duplicated.
> 
> Yes, except it's not gcc but ld, string deduplication happens across
> compilation units, and "modern" isn't required, SHF_STRINGS and
> SHF_MERGE have been part of the ELF spec for decades, with support in
> binutils landing around 2001-04-13 AFAICT.
> 
> IOW, don't uglify the code by introducing macros or const char[]
> objects. Using string literals is just fine.

What I'm talking about is two things:
 - is it guaranteed that the name is always the same?
 - is it guaranteed that nobody will make a mistake in the name when typing it
   over and over?

  ...

> >>>> +static int __init pi_init(void)
> > 
> >>> No __exit? (There is a corresponding call for exit)
> >>
> >> Hmm, can't printk only be built in to the kernel, so it can't be unloaded?
> >> At least it looks that way from Kconfig. Maybe I'm missing something and
> >> there's some other way that might be invoked?
> > 
> > While it's true, it may help in these cases:
> >  1) getting things done in a clean way
> 
> Huh?
> 
> >  2) finding bugs during boot cycle
> 
> What bugs would code that doesn't get executed find?
> 
> >  3) (possibly) making better debugging in virtual environments
> 
> How?
> 
> >  4) (also possibly) clean up something which shouldn't be seen by the next
> >     (unsecure) kernel, like kexec.
> 
> Tearing down a few debugfs files wouldn't touch a lot of memory, the
> printk format strings are very unlikely to be sensitive, and I highly
> doubt __exit code is kept around and run at kexec time anyway.

I admit that I'm on a learning curve in this area, and perhaps it was unclear
from the above that the list I gave is what I think may or might be relevant.

> IOW, please do not bloat the kernel image with __exit code in things
> which cannot be built modular.

Why we have exitcall in the code which can't be modular? Is somebody going to
clean that up? (Ex. `git grep -w __exitcall`)

-- 
With Best Regards,
Andy Shevchenko


