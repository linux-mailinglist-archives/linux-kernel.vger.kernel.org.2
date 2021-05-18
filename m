Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB239387A01
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 15:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349641AbhERNch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 09:32:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:64739 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244870AbhERNcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 09:32:36 -0400
IronPort-SDR: IDXagzsG2msXSGWSbm0A6vqAETO+bNPxhIes1lowaGf9d4a92V0IstacP6PWG6M8e29rJa7sRY
 IphIJsIdZ7Hg==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="221763516"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="221763516"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 06:31:06 -0700
IronPort-SDR: hToZD6NcTSbW2WjbDEdEM2M/sniwPXmG56whsAnbJuB/tnWkLoMzGY2IVuW1xfes2KZlXwMUvp
 7zrtsy5LYOmg==
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="630442137"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 06:31:02 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lizoJ-00Cxp0-B0; Tue, 18 May 2021 16:30:59 +0300
Date:   Tue, 18 May 2021 16:30:59 +0300
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
Message-ID: <YKPBk+7lTzs8WFAk@smile.fi.intel.com>
References: <cover.1621338324.git.chris@chrisdown.name>
 <05d25c65d3f5149c1e8537f74041a7a46bd489d6.1621338324.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05d25c65d3f5149c1e8537f74041a7a46bd489d6.1621338324.git.chris@chrisdown.name>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 01:00:43PM +0100, Chris Down wrote:
> We have a number of systems industry-wide that have a subset of their
> functionality that works as follows:
> 
> 1. Receive a message from local kmsg, serial console, or netconsole;
> 2. Apply a set of rules to classify the message;
> 3. Do something based on this classification (like scheduling a
>    remediation for the machine), rinse, and repeat.
> 
> As a couple of examples of places we have this implemented just inside
> Facebook, although this isn't a Facebook-specific problem, we have this
> inside our netconsole processing (for alarm classification), and as part
> of our machine health checking. We use these messages to determine
> fairly important metrics around production health, and it's important
> that we get them right.
> 
> While for some kinds of issues we have counters, tracepoints, or metrics
> with a stable interface which can reliably indicate the issue, in order
> to react to production issues quickly we need to work with the interface
> which most kernel developers naturally use when developing: printk.
> 
> Most production issues come from unexpected phenomena, and as such
> usually the code in question doesn't have easily usable tracepoints or
> other counters available for the specific problem being mitigated. We
> have a number of lines of monitoring defence against problems in
> production (host metrics, process metrics, service metrics, etc), and
> where it's not feasible to reliably monitor at another level, this kind
> of pragmatic netconsole monitoring is essential.
> 
> As one would expect, monitoring using printk is rather brittle for a
> number of reasons -- most notably that the message might disappear
> entirely in a new version of the kernel, or that the message may change
> in some way that the regex or other classification methods start to
> silently fail.
> 
> One factor that makes this even harder is that, under normal operation,
> many of these messages are never expected to be hit. For example, there
> may be a rare hardware bug which one wants to detect if it was to ever
> happen again, but its recurrence is not likely or anticipated. This
> precludes using something like checking whether the printk in question
> was printed somewhere fleetwide recently to determine whether the
> message in question is still present or not, since we don't anticipate
> that it should be printed anywhere, but still need to monitor for its
> future presence in the long-term.
> 
> This class of issue has happened on a number of occasions, causing
> unhealthy machines with hardware issues to remain in production for
> longer than ideal. As a recent example, some monitoring around
> blk_update_request fell out of date and caused semi-broken machines to
> remain in production for longer than would be desirable.
> 
> Searching through the codebase to find the message is also extremely
> fragile, because many of the messages are further constructed beyond
> their callsite (eg. btrfs_printk and other module-specific wrappers,
> each with their own functionality). Even if they aren't, guessing the
> format and formulation of the underlying message based on the aesthetics
> of the message emitted is not a recipe for success at scale, and our
> previous issues with fleetwide machine health checking demonstrate as
> much.
> 
> This provides a solution to the issue of silently changed or deleted
> printks: we record pointers to all printk format strings known at
> compile time into a new .printk_index section, both in vmlinux and
> modules. At runtime, this can then be iterated by looking at
> <debugfs>/printk/index/<module>, which emits the following format, both
> readable by humans and able to be parsed by machines:
> 
>     $ head -1 vmlinux; shuf -n 5 vmlinux
>     # <level[,flags]> filename:line function "format"
>     <5> block/blk-settings.c:661 disk_stack_limits "%s: Warning: Device %s is misaligned\n"
>     <4> kernel/trace/trace.c:8296 trace_create_file "Could not create tracefs '%s' entry\n"
>     <6> arch/x86/kernel/hpet.c:144 _hpet_print_config "hpet: %s(%d):\n"
>     <6> init/do_mounts.c:605 prepare_namespace "Waiting for root device %s...\n"
>     <6> drivers/acpi/osl.c:1410 acpi_no_auto_serialize_setup "ACPI: auto-serialization disabled\n"
> 
> This mitigates the majority of cases where we have a highly-specific
> printk which we want to match on, as we can now enumerate and check
> whether the format changed or the printk callsite disappeared entirely
> in userspace. This allows us to catch changes to printks we monitor
> earlier and decide what to do about it before it becomes problematic.
> 
> There is no additional runtime cost for printk callers or printk itself,
> and the assembly generated is exactly the same.

...

> +#define __printk_index_emit(_fmt, _level, _pre_fmt, _post_fmt)		       \

> +	({								       \

do {} while (0) is more generic than ({ GCC extension.


> +		if (__builtin_constant_p(_fmt) && __builtin_constant_p(_level)) { \
> +			/*
> +			 * The compiler may not be able to eliminate the
> +			 * non-constant variants of _fmt and _level, so we need
> +			 * to make sure that it doesn't see any hypothetical
> +			 * assignment for non-constants even though this is
> +			 * already inside the __builtin_constant_p guard.
> +			 */						       \
> +			static const struct pi_entry _entry		       \
> +			__used = {		       \
> +				.fmt = __builtin_constant_p(_fmt) ? (_fmt) : NULL, \
> +				.func = __func__,			       \
> +				.file = __FILE__,			       \
> +				.line = __LINE__,			       \
> +				.level = __builtin_constant_p(_level) ? (_level) : NULL, \
> +				.pre_fmt = _pre_fmt,			       \
> +				.post_fmt = _post_fmt,			       \
> +			};						       \
> +			static const struct pi_entry *_entry_ptr	       \
> +			__used __section(".printk_index") = &_entry;	       \
> +		}							       \

Something wrong with indentation of some of the \
Also in here and in the rest of the series.

> +	})

...

> +/*
> + * printk/index.c - Userspace indexing of printk formats

Keeping file name in the file is not the best idea.

> + */

...

> +static const char *pi_get_module_name(struct module *mod)
> +{
> +	return mod ? mod->name : "vmlinux";

First of all, you have several occurrences of the "vmlinux" literal.
Second, can't you get it from somewhere else? Is it even guaranteed that the
name is always the same?

> +}

...

> +	switch (op) {
> +	case MODULE_STATE_COMING:
> +		pi_create_file(mod);
> +		break;
> +	case MODULE_STATE_GOING:
> +		pi_remove_file(mod);
> +		break;

Missed default.

> +	}

...

> +static void __init pi_setup_module_notifier(void)
> +{
> +}

One line and marked inline?

...

> +static void *pi_start(struct seq_file *s, loff_t *pos);

Not sure I understand why forward declaration is here.
(I deliberately left more context below)

> +static void *pi_next(struct seq_file *s, void *v, loff_t *pos)
> +{
> +	const struct module *mod = s->file->f_inode->i_private;
> +	struct pi_entry *entry = pi_get_entry(mod, *pos);
> +
> +	(*pos)++;
> +
> +	return entry;
> +}
> +
> +static void *pi_start(struct seq_file *s, loff_t *pos)
> +{
> +	/*
> +	 * Make show() print the header line. Do not update *pos because
> +	 * pi_next() still has to return the entry at index 0 later.
> +	 */
> +	if (*pos == 0)
> +		return SEQ_START_TOKEN;
> +
> +	return pi_next(s, NULL, pos);
> +}

...

> +#define seq_escape_printf_format(s, src) \
> +	seq_escape_str(s, src, ESCAPE_ANY | ESCAPE_NAP | ESCAPE_APPEND, "\"\\")

Hmm... But after your ESCAPE_SPECIAL update why " is in @only?
Not sure about back slash either.

...

> +		seq_puts(s,
> +			 "# <level[,flags]> filename:line function \"format\"\n");

One line.

...

> +	if (entry->pre_fmt)
> +		seq_escape_printf_format(s, entry->pre_fmt);

> +	if (entry->post_fmt)
> +		seq_escape_printf_format(s, entry->post_fmt);

Maybe you can make seq_escape_printf_format() NULL-aware?

...

> +static void pi_stop(struct seq_file *p, void *v)
> +{
> +}

One line?

...

> +static const struct seq_operations dfs_index_seq_ops = {
> +	.start = pi_start,
> +	.next  = pi_next,
> +	.show  = pi_show,
> +	.stop  = pi_stop,
> +};
DEFINE_SEQ_SHOW_ATTRIBUTE(...);

...

> +
> +

One blank line is enough here and everywhere else.

...

> +static int __init pi_init(void)
> +{
> +	struct dentry *dfs_root = debugfs_create_dir("printk", NULL);
> +
> +	dfs_index = debugfs_create_dir("index", dfs_root);
> +	pi_setup_module_notifier();
> +	pi_create_file(NULL);
> +
> +	return 0;
> +}

No __exit? (There is a corresponding call for exit)

...

> +u16 printk_parse_prefix(const char *text, int *level,
>  			enum printk_info_flags *flags)

Now one line?

-- 
With Best Regards,
Andy Shevchenko


