Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E175A387D01
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 18:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350480AbhERQBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 12:01:44 -0400
Received: from mga11.intel.com ([192.55.52.93]:46908 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244966AbhERQBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 12:01:43 -0400
IronPort-SDR: nFa8S1VKkl8cvQPZ10AOJZEO0Z3m9azcWqiblNwPh43VKfpeTbxrs8lqqpYTVoS9v+fzb9G++M
 7662MsYG0TuQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="197659682"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="197659682"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 09:00:25 -0700
IronPort-SDR: y+0J+1xGgdIpmt4FA5OcUZRaefg1GQMnuMU5SRAplNy83ASyclEiqJKqBWEtE8sAUPMXQcKsgR
 hecqEK/B33dw==
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="394914894"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 09:00:22 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lj28o-00CzcL-Mr; Tue, 18 May 2021 19:00:18 +0300
Date:   Tue, 18 May 2021 19:00:18 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Jessica Yu <jeyu@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, kernel-team@fb.com
Subject: Re: [PATCH v6 3/4] printk: Userspace format indexing support
Message-ID: <YKPkkiCX6gdSa/rI@smile.fi.intel.com>
References: <cover.1621338324.git.chris@chrisdown.name>
 <05d25c65d3f5149c1e8537f74041a7a46bd489d6.1621338324.git.chris@chrisdown.name>
 <YKPBk+7lTzs8WFAk@smile.fi.intel.com>
 <YKPKMCNz2hccaXfR@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKPKMCNz2hccaXfR@chrisdown.name>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 03:07:44PM +0100, Chris Down wrote:
> Andy Shevchenko writes:

...

> > > +	return mod ? mod->name : "vmlinux";
> > 
> > First of all, you have several occurrences of the "vmlinux" literal.
> > Second, can't you get it from somewhere else? Is it even guaranteed that the
> > name is always the same?
> 
> Hmm, I don't know if it's guaranteed, but we already have similar logic in
> (as one example) livepatch, which seems to suggest it's not obviously wrong:
> 
>     % grep -R '"vmlinux"' kernel/livepatch/
>     kernel/livepatch/core.c:                       sympos, name, objname ? objname : "vmlinux");
>     kernel/livepatch/core.c:        bool sec_vmlinux = !strcmp(sec_objname, "vmlinux");
>     kernel/livepatch/core.c:                sym_vmlinux = !strcmp(sym_objname, "vmlinux");
>     kernel/livepatch/core.c:        if (strcmp(objname ? objname : "vmlinux", sec_objname))
>     kernel/livepatch/core.c:        name = klp_is_module(obj) ? obj->name : "vmlinux";
>     kernel/livepatch/core.c:                                klp_is_module(obj) ? obj->name : "vmlinux");
>     kernel/livepatch/core.c:                                klp_is_module(obj) ? obj->name : "vmlinux");
>     kernel/livepatch/core.c:        if (!strcmp(mod->name, "vmlinux")) {
> 
> Is there another name or method you'd prefer? :-)
> 
> As for the literals, are you saying that you prefer that it's symbolised as
> a macro or static char, or do you know of an API where this kind of name can
> be canonically accessed?

I have heard that modern GCC (at least) can utilize same constant literals in a
single compilation unit, so it won't be duplicated.

But more serious here is the guarantees of the name. Shouldn't it come from
KBuild / Makefile into some header like version do?

livepatch has to be fixed accordingly.

...

> > > +#define seq_escape_printf_format(s, src) \
> > > +	seq_escape_str(s, src, ESCAPE_ANY | ESCAPE_NAP | ESCAPE_APPEND, "\"\\")
> > 
> > Hmm... But after your ESCAPE_SPECIAL update why " is in @only?
> > Not sure about back slash either.
> 
> Good question! It's because ESCAPE_NAP (used to reduce scope of
> ESCAPE_OCTAL) will cause double quote and backslash to be ignored for
> quoting otherwise, even with ESCAPE_SPECIAL from ESCAPE_ANY.

Ah, makes sense. Yep, it's a bit complicated, but okay, perhaps it needs a
comment near to the macro.

> I touched on this briefly in the changelog for the patch adding the quote to
> ESCAPE_SPECIAL:
> 
> From "string_helpers: Escape double quotes in escape_special":
> > One can of course, alternatively, use ESCAPE_APPEND with a quote in
> > @only, but without this patch quotes are coerced into hex or octal which
> > can hurt readability quite significantly.
> 
> Maybe you know of a more intuitive way to deal with this? :-)

...

> > > +static int __init pi_init(void)

> > No __exit? (There is a corresponding call for exit)
> 
> Hmm, can't printk only be built in to the kernel, so it can't be unloaded?
> At least it looks that way from Kconfig. Maybe I'm missing something and
> there's some other way that might be invoked?

While it's true, it may help in these cases:
 1) getting things done in a clean way
 2) finding bugs during boot cycle
 3) (possibly) making better debugging in virtual environments
 4) (also possibly) clean up something which shouldn't be seen by the next
    (unsecure) kernel, like kexec.

I'm not sure about these, but it what comes to my mind.

-- 
With Best Regards,
Andy Shevchenko


