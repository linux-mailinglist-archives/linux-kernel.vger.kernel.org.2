Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 773F039049A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 17:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbhEYPIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 11:08:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:33408 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230145AbhEYPIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 11:08:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621955207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=++srTk9VXy4ZDmmQ4lAzccNn6JbhXDObNyZ6O9j7gFQ=;
        b=Z+m9HBC34gzIFSw+d4Lt2yShe7KSuEd+krEZ+VDCC3K2XpVpJjMXSornc/gJuwgSqBVImc
        zPFLPMVqdE7KK1xFKM5YskSm+33zPspyo/ugofqhA8SS7Ljcl0EmnNRZWcL7+7ATCZiLWz
        zVyuTNUjC0DoAizyCpUTA9uMX23LfVU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E366AAB71;
        Tue, 25 May 2021 15:06:46 +0000 (UTC)
Date:   Tue, 25 May 2021 17:06:46 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, kernel-team@fb.com
Subject: Re: [PATCH v6 3/4] printk: Userspace format indexing support
Message-ID: <YK0ShqdTSVTYXGPF@alley>
References: <cover.1621338324.git.chris@chrisdown.name>
 <05d25c65d3f5149c1e8537f74041a7a46bd489d6.1621338324.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05d25c65d3f5149c1e8537f74041a7a46bd489d6.1621338324.git.chris@chrisdown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-05-18 13:00:43, Chris Down wrote:
> We have a number of systems industry-wide that have a subset of their
> functionality that works as follows:
> 
> 1. Receive a message from local kmsg, serial console, or netconsole;
> 2. Apply a set of rules to classify the message;
> 3. Do something based on this classification (like scheduling a
>    remediation for the machine), rinse, and repeat.
> 
> This provides a solution to the issue of silently changed or deleted
> printks: we record pointers to all printk format strings known at
> compile time into a new .printk_index section, both in vmlinux and
> modules. At runtime, this can then be iterated by looking at
> <debugfs>/printk/index/<module>, which emits the following format, both
> readable by humans and able to be parsed by machines:
> 
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index f589b8b60806..40b97d538e12 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> +#ifdef CONFIG_PRINTK_INDEX
> +struct pi_entry {
> +	const char *fmt;
> +	const char *func;
> +	const char *file;
> +	unsigned int line;
> +
> +	/*
> +	 * While printk and pr_* have the level stored in the string at compile
> +	 * time, some subsystems dynamically add it at runtime through the
> +	 * format string. For these dynamic cases, we allow the subsystem to
> +	 * tell us the level at compile time.
> +	 *
> +	 * NULL indicates that the level, if any, is stored in fmt.
> +	 */
> +	const char *level;
> +
> +	/*
> +	 * The format string before and after the fmt, or at least something
> +	 * that would match whatever it could be.
> +	 */
> +	const char *pre_fmt;
> +	const char *post_fmt;

Are you aware of any subsystem having some extra post_fmt, please?

I think about calling this "subsys_fmt" or "subsys_prefix".

Well, the main question is whether we need to store this
at all. Does it bring any useful information?

Note that we do not store the value defined by pr_fmt() which
is yet another automatically added prefix.

I would personally omit these prefixes. The most important
information is:

  + fmt: is the pattern that the system monitors would most likely
	look for.

  + level: says whether the string will appear on console that
      shows only messages below a certain console_loglevel

  + func, file, line: help to find the string in the kernel sources.
      It is useful when investigating what has changed.

For example, pre_fmt="%s %s:" used by dev_printk (4th patch)
is not much useful.


> +} __packed;
> +
> +#define __printk_index_emit(_fmt, _level, _pre_fmt, _post_fmt)		       \
> +	({								       \
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

Should this also be?

	.pre_fmt = __builtin_constant_p(_pre_fmt) ? _pre_fmt : NULL

> +				.post_fmt = _post_fmt,				\

Similar here.

Well, I would remove .pre_fmt and .post_fmt completely.

> +			};						       \
> +			static const struct pi_entry *_entry_ptr	       \
> +			__used __section(".printk_index") = &_entry;	       \
> +		}							       \
> +	})
> +
> +#else /* !CONFIG_PRINTK_INDEX */
> +#define __printk_index_emit(...) do {} while (0)
> +#endif /* CONFIG_PRINTK_INDEX */
> +
> +/*
> + * Some subsystems have their own custom printk that applies a va_format to a
> + * generic format, for example, to include a device number or other metadata
> + * alongside the format supplied by the caller.
> + *
> + * In order to store these in the way they would be emitted by the printk
> + * infrastructure, the subsystem provides us with the start, fixed string, and
> + * any subsequent text in the format string.
> + *
> + * We take a variable argument list as pr_fmt/dev_fmt/etc are sometimes passed
> + * as multiple arguments (eg: `"%s: ", "blah"`), and we must only take the
> + * first one.
> + *
> + * pre and post must be known at compile time, or compilation will fail (since
> + * this is a mistake). If fmt or level is not known at compile time, no index
> + * entry will be made (since this can legitimately happen).

How is this achieved, please? 

__printk_index_emit() creates the entry when the following check is true:

       if (__builtin_constant_p(_fmt) && __builtin_constant_p(_level))

It checks neither _pre_fmt nor _post_fmt.


> + */
> +#define printk_index_subsys_emit(pre, post, level, fmt, ...) \
> +	__printk_index_emit(fmt, level, pre, post)
> +
> +#define printk_index_wrap(_p_func, _fmt, ...)				       \
> +	({								       \
> +		__printk_index_emit(_fmt, NULL, NULL, NULL);		       \
> +		_p_func(_fmt, ##__VA_ARGS__);				       \
> +	})
> +
> +
> --- /dev/null
> +++ b/kernel/printk/index.c
> @@ -0,0 +1,198 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * printk/index.c - Userspace indexing of printk formats
> + */
> +
> +#include <linux/debugfs.h>
> +#include <linux/module.h>
> +#include <linux/printk.h>
> +#include <linux/slab.h>
> +#include <linux/string_helpers.h>
> +
> +#include "internal.h"
> +
> +extern struct pi_entry *__start_printk_index[];
> +extern struct pi_entry *__stop_printk_index[];
> +
> +/* The base dir for module formats, typically debugfs/printk/index/ */
> +static struct dentry *dfs_index;
> +
> +#ifdef CONFIG_MODULES
> +static const char *pi_get_module_name(struct module *mod)
> +{
> +	return mod ? mod->name : "vmlinux";
> +}
> +
> +void pi_create_file(struct module *mod);
> +void pi_remove_file(struct module *mod);

I would personally move all this module-notify-related code right
above pi_init() definition and avoid any forward declarations.


> +
> +static int pi_module_notify(struct notifier_block *nb, unsigned long op,
> +			    void *data)
> +{
> +	struct module *mod = data;
> +
> +	switch (op) {
> +	case MODULE_STATE_COMING:
> +		pi_create_file(mod);
> +		break;
> +	case MODULE_STATE_GOING:
> +		pi_remove_file(mod);
> +		break;
> +	}
> +
> +	return NOTIFY_OK;
> +}

[...]

> +static int pi_show(struct seq_file *s, void *v)
> +{
> +	const struct pi_entry *entry = v;
> +	int level = LOGLEVEL_DEFAULT;
> +	enum printk_info_flags flags = 0;
> +	u16 prefix_len = 0;
> +
> +	if (v == SEQ_START_TOKEN) {
> +		seq_puts(s,
> +			 "# <level[,flags]> filename:line function \"format\"\n");
> +		return 0;
> +	}
> +
> +	if (!entry->fmt)
> +		return 0;

Is this just a paranoid check or is it a valid case?

Is is possible to update __printk_index_emit() to do not create
entries with fmt = NULL ?

We should either remove the above check or add a comment
explaining why it is necessary.


> +
> +	if (entry->level)
> +		printk_parse_prefix(entry->level, &level, &flags);
> +	else
> +		prefix_len = printk_parse_prefix(entry->fmt, &level, &flags);

This is missing:

	if (level == LOGLEVEL_DEFAULT)
		level = default_message_loglevel;

Without it, it produces lines with loglevel <-1>, for example:

<-1> init/do_mounts.c:457 mount_block_root "\n"
<-1> init/do_mounts.c:456 mount_block_root " %s"
<-1> init/do_mounts.c:454 mount_block_root "No filesystem could mount root, tried: "



> +
> +	seq_printf(s, "<%d%s> %s:%d %s \"",
> +			level, flags & LOG_CONT ? ",c" : "", entry->file,
> +			entry->line, entry->func);

It produces the following for continuous lines:

<-1,c> arch/x86/events/core.c:2101 init_hw_perf_events "%s PMU driver.\n"
<-1,c> arch/x86/events/core.c:2091 init_hw_perf_events "no PMU driver, software events only.\n"

But we should print the loglevel only when explicitly defined.
So I would do it the following way:

	if (flags & LOG_CONT) {
		if (level == LOGLEVEL_DEFAULT)
			seq_printf(s, "<c>");
		else
			seq_printf(s, "<%d,c>", level);
	} else {
		if (level == LOGLEVEL_DEFAULT)
			level = default_message_loglevel;
		seq_printf(s, "<%d>", level);
	}

	seq_printf(s, " %s:%d %s \"", entry->file, entry->line, entry->func);

> +	if (entry->pre_fmt)
> +		seq_escape_printf_format(s, entry->pre_fmt);
> +	seq_escape_printf_format(s, entry->fmt + prefix_len);
> +	if (entry->post_fmt)
> +		seq_escape_printf_format(s, entry->post_fmt);
> +	seq_puts(s, "\"\n");
> +
> +	return 0;
> +}
> +
> diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
> index 51615c909b2f..dbeeb2fa74ab 100644
> --- a/kernel/printk/internal.h
> +++ b/kernel/printk/internal.h
> @@ -4,6 +4,8 @@
>   */
>  #include <linux/percpu.h>
>  
> +#include "printk_ringbuffer.h"
> +
>  #ifdef CONFIG_PRINTK
>  
>  #define PRINTK_SAFE_CONTEXT_MASK	0x007ffffff
> @@ -51,6 +53,8 @@ bool printk_percpu_data_ready(void);
>  
>  void defer_console_output(void);
>  
> +u16 printk_parse_prefix(const char *text, int *level,
> +			enum printk_info_flags *flags);

It would be nice to do all this parse_prefix() shuffling and
renaming in another preparatoty patch. I mean to have
two preparaty patches:

    + patch renaming enum log_flags -> printk_info_flags
    + patch renaming parse_prefix -> printk_parse_prefix

That said, I do not resit on it. It is just nice to have ;-)

>  #else
>  
>  /*

I am really happy with the progress. The remaining problems are mostly
with the support for the subsystem-specific printk() callers that was
added in this revision.

Best Regards,
Petr
