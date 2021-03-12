Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A53E338B51
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 12:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbhCLLPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 06:15:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:60686 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233690AbhCLLOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 06:14:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615547688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xVkhtPLHlKvQQE6/4ipGzdgEmMwZXrE9kE9Xt9lGULg=;
        b=DljNc/jBtuMZjQN05T7GqYUSAzXue2D+VB+0nkP+5SdOQFNLv+AVLIkyx5qp+d5/ekoQAo
        aiOtLKb46KIoSHfZhOubCtaJf4sXB2TnUsZoVmV12VRnk5Z2OZ0/EFPf5Iy0yXc2x3EeED
        ScqLoF1BxInSeia95kZPwhYzIlaFuHQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C5302B035;
        Fri, 12 Mar 2021 11:14:48 +0000 (UTC)
Date:   Fri, 12 Mar 2021 12:14:48 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
Subject: Re: [PATCH v5] printk: Userspace format enumeration support
Message-ID: <YEtNKMF3KH1kUDxY@alley>
References: <YEgvR6Wc1xt0qupy@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEgvR6Wc1xt0qupy@chrisdown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-03-10 02:30:31, Chris Down wrote:
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
 
> This patch provides a solution to the issue of silently changed or
> deleted printks: we record pointers to all printk format strings known
> at compile time into a new .printk_index section, both in vmlinux and
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
> diff --git a/fs/seq_file.c b/fs/seq_file.c
> index 71a274e7f903..0fd3ae1051d9 100644
> --- a/fs/seq_file.c
> +++ b/fs/seq_file.c
> @@ -376,6 +376,27 @@ void seq_escape(struct seq_file *m, const char *s, const char *esc)
>  }
>  EXPORT_SYMBOL(seq_escape);
>  
> +/**
> + *	seq_escape_printf_format - print string into buffer, escaping
> + *		characters that are escaped in printf format (including '"')
> + *	@m:	target buffer
> + *	@s:	string
> + *
> + *	Puts string into buffer and escape characters that are
> + *	escaped in printf format.
> + *	Use seq_has_overflowed() to check for errors.
> + */
> +void seq_escape_printf_format(struct seq_file *m, const char *s)
> +{
> +	char *buf;
> +	size_t size = seq_get_buf(m, &buf);
> +	int ret;
> +
> +	ret = string_escape_str(s, buf, size, ESCAPE_PRINTF, NULL);
> +	seq_commit(m, ret < size ? ret : -1);
> +}
> +EXPORT_SYMBOL(seq_escape_printf_format);
> +

Please, create this API in a separate patch and add Al Viro into CC.

>  void seq_escape_mem_ascii(struct seq_file *m, const char *src, size_t isz)
>  {
>  	char *buf;
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 34b7e0d2346c..d4e45714405f 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -309,6 +309,17 @@
>  #define ACPI_PROBE_TABLE(name)
>  #endif
>  
> +#ifdef CONFIG_PRINTK_INDEX
> +#define PRINTK_INDEX							\
> +	.printk_index : AT(ADDR(.printk_index) - LOAD_OFFSET) {		\
> +		__start_printk_index = .;				\
> +		*(.printk_index)						\
> +		__stop_printk_index = .;					\
> +	}
> +#else
> +#define PRINTK_INDEX
> +#endif

Please, move this below #define TRACEDATA. We should follow the
existing ordering of these definitions.

> +
>  #ifdef CONFIG_THERMAL
>  #define THERMAL_TABLE(name)						\
>  	. = ALIGN(8);							\
> @@ -480,6 +491,8 @@
>  									\
>  	TRACEDATA							\
>  									\
> +	PRINTK_INDEX							\
> +									\
>  	/* Kernel symbol table: Normal symbols */			\
>  	__ksymtab         : AT(ADDR(__ksymtab) - LOAD_OFFSET) {		\
>  		__start___ksymtab = .;					\
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 7a0bcb5b1ffc..5d466b4a23b9 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -516,6 +516,12 @@ struct module {
>  	struct klp_modinfo *klp_info;
>  #endif
>  
> +#ifdef CONFIG_PRINTK_INDEX
> +	unsigned int printk_index_size;
> +	struct pi_object *printk_index_start;

Sigh, you probably got somehow confused by the pi_object name
that I proposed last time. It was intended for a structure
describing the whole module or vmlinux. You are using
it here for one entry in the format table.

> +	struct pi_sec *pi_sec;

It seems that it will be enough to store pointer to
the dentry.

> +#endif

So, plese use:

#ifdef CONFIG_PRINTK_INDEX
	struct pi_entry *pi_entries;
	unsigned int pi_num_entries;
	struct dentry *pi_file;
#endif

"pi_" prefix fits the rest of the API. "entry" will get
explained below in printk.h.

Also, please, add Jessica Yu <jeyu@kernel.org> into CC. She should be
aware of this change.

> +
>  #ifdef CONFIG_MODULE_UNLOAD
>  	/* What modules depend on me? */
>  	struct list_head source_list;
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index d3c08095a9a3..cd2977df820e 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -164,6 +164,11 @@ static inline void printk_nmi_direct_exit(void) { }
>  struct dev_printk_info;
>  
>  #ifdef CONFIG_PRINTK
> +enum log_flags {
> +	LOG_NEWLINE	= 2,	/* text ended with a newline */
> +	LOG_CONT	= 8,	/* text is a fragment of a continuation line */
> +};

Please, rename the structure to "printk_info_flags" and put it into
kernel/printk/printk_ringbuffer.h

These values are used by @flags in struct printk_info. It would even
makes sense to replace

-	u8	flags:5;	/* internal record flags */
+	enum printk_info_flags	flags:5;	/* internal record flags */

But I am not sure if enum might be a bitfield in C.

The name "log_flags" comes from the commit 084681d14e429cb6
"printk: flush continuation lines immediately to console". It was
stored in struct log.

The name was misleading. "struct log" contained meta information for
a single printk record (line). But the name "log" suggests that it is
a global flag for the entire log.

We should have renamed the structure when replacing "struct log" but
we missed it.

Please, do this in a separate patch. Also please rename the variables
using this type from "lflags" to "info_flags".

> +
>  asmlinkage __printf(4, 0)
>  int vprintk_emit(int facility, int level,
>  		 const struct dev_printk_info *dev_info,
> @@ -173,12 +178,12 @@ asmlinkage __printf(1, 0)
>  int vprintk(const char *fmt, va_list args);
>  
>  asmlinkage __printf(1, 2) __cold
> -int printk(const char *fmt, ...);
> +int _printk(const char *fmt, ...);
>  
>  /*
>   * Special printk facility for scheduler/timekeeping use only, _DO_NOT_USE_ !
>   */
> -__printf(1, 2) __cold int printk_deferred(const char *fmt, ...);
> +__printf(1, 2) __cold int _printk_deferred(const char *fmt, ...);
>  
>  /*
>   * Please don't use printk_ratelimit(), because it shares ratelimiting state
> @@ -206,6 +211,7 @@ void __init setup_log_buf(int early);
>  __printf(1, 2) void dump_stack_set_arch_desc(const char *fmt, ...);
>  void dump_stack_print_info(const char *log_lvl);
>  void show_regs_print_info(const char *log_lvl);
> +u16 parse_prefix(const char *text, int *level, enum log_flags *lflags);

Please, rename it to printk_parse_prefix() and define it in
kernel/printk/internal.h.

>  extern asmlinkage void dump_stack(void) __cold;
>  extern void printk_safe_flush(void);
>  extern void printk_safe_flush_on_panic(void);
> @@ -301,6 +307,64 @@ extern int kptr_restrict;
>  #define pr_fmt(fmt) fmt
>  #endif
>  
> +struct module;
> +
> +#ifdef CONFIG_PRINTK_INDEX
> +extern void pi_sec_store(struct module *mod);
> +extern void pi_sec_remove(struct module *mod);
> +
> +struct pi_object {
> +	const char *fmt;
> +	const char *func;
> +	const char *file;
> +	unsigned int line;
> +};

It seems that you got confused by pi_object name that I proposed last time.

"object" was supposed to be used for structure storing information
about module or vmlinux. It is "struct pi_sec" in this patch.

You used it for storing the information about the particular format.
This structure did not exist in the previous patch at all.

The name makes some sense even this way. But it confuses me because
we use it in livepatch code the other way.

Please, rename this structure to "pi_entry"?

> +
> +extern struct pi_object __start_printk_index[];
> +extern struct pi_object __stop_printk_index[];

These are used only in index.c. It should be enough to do this
declaration there.

> +
> +#define pi_sec_elf_embed(_p_func, _fmt, ...)				       \
> +	({								       \
> +		int _p_ret;						       \
> +									       \
> +		if (__builtin_constant_p(_fmt)) {			       \
> +			/*
> +			 * The compiler may not be able to eliminate this, so
> +			 * we need to make sure that it doesn't see any
> +			 * hypothetical assignment for non-constants even
> +			 * though this is already inside the
> +			 * __builtin_constant_p guard.
> +			 */						       \
> +			static struct pi_object _pi			       \
> +			__section(".printk_index") = {			       \
> +				.fmt = __builtin_constant_p(_fmt) ? (_fmt) : NULL, \
> +				.func = __func__,			       \
> +				.file = __FILE__,			       \
> +				.line = __LINE__,			       \
> +			};						       \
> +			_p_ret = _p_func(_pi.fmt, ##__VA_ARGS__);	       \
> +		} else							       \
> +			_p_ret = _p_func(_fmt, ##__VA_ARGS__);		       \
> +									       \
> +		_p_ret;							       \
> +	})
> +
> +#define printk(fmt, ...) pi_sec_elf_embed(_printk, fmt, ##__VA_ARGS__)
> +#define printk_deferred(fmt, ...)					       \
> +	pi_sec_elf_embed(_printk_deferred, fmt, ##__VA_ARGS__)
> +#else /* !CONFIG_PRINTK_INDEX */
> +static inline void pi_sec_store(struct module *mod)
> +{
> +}
> +
> +static inline void pi_sec_remove(struct module *mod)
> +{
> +}
> +
> +#define printk(...) _printk(__VA_ARGS__)
> +#define printk_deferred(...) _printk_deferred(__VA_ARGS__)
> +#endif /* CONFIG_PRINTK_INDEX */
> +
>  /**
>   * pr_emerg - Print an emergency-level message
>   * @fmt: format string
> diff --git a/init/Kconfig b/init/Kconfig
> index ab2e916f7e8b..085190760b49 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -764,6 +764,20 @@ config PRINTK_SAFE_LOG_BUF_SHIFT
>  		     13 =>   8 KB for each CPU
>  		     12 =>   4 KB for each CPU
>  
> +config PRINTK_INDEX
> +	bool "Printk indexing debugfs interface"
> +	depends on PRINTK && DEBUG_FS
> +	help
> +	  Add support for indexing of all printk formats known at compile time
> +	  at <debugfs>/printk/index/<module>.
> +
> +	  This can be used as part of maintaining daemons which monitor
> +	  /dev/kmsg, as it permits auditing the printk formats present in a
> +	  kernel, allowing monitoring of cases where monitored printks are

Nit: I would say: "allowing to detect cases where motitored printks are..."

I understand monitoring as a continuous process while the printk
formats are likely checked only once when the monitor gets started.


> +	  changed or no longer present.
> +
> +	  There is no additional runtime cost to printk with this enabled.
> +
>  #
>  # Architectures with an unreliable sched_clock() should select this:
>  #
> diff --git a/kernel/module.c b/kernel/module.c
> index 1e5aad812310..44df2913a046 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -1064,6 +1064,7 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
>  	blocking_notifier_call_chain(&module_notify_list,
>  				     MODULE_STATE_GOING, mod);
>  	klp_module_going(mod);
> +	pi_sec_remove(mod);

Is there any particular reason why this is not done via the module
notifier, please?

Other subsystems hardcode their callbacks here only when they
require some special ordering that could not be achieved by
the notifiers.

The hardcoded callbacks complicate the error paths in
the module loader code.

Using notifiers would also help to avoid several declarations
in the global printk.h.

>  	ftrace_release_mod(mod);
>  
>  	async_synchronize_full();

> diff --git a/kernel/printk/index.c b/kernel/printk/index.c
> new file mode 100644
> index 000000000000..8765d982c8d9
> --- /dev/null
> +++ b/kernel/printk/index.c
> @@ -0,0 +1,183 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * printk/index.c - Userspace indexing of printk formats
> + */
> +
> +#include <linux/debugfs.h>
> +#include <linux/module.h>
> +#include <linux/printk.h>
> +#include <linux/slab.h>
> +
> +/**
> + * struct pi_sec - printk index section metadata
> + *
> + * @file:  The debugfs file where userspace can index these printk formats
> + * @start: Section start boundary
> + * @end:   Section end boundary
> + *
> + * Allocated and populated by pi_sec_store.
> + *
> + * @mod is NULL if the printk formats in question are built in to vmlinux
> + * itself.

@mod is not longer in this structure.

> + *
> + * @file may be an ERR_PTR value if the file or one of its ancestors was not
> + * successfully created.
> + */
> +struct pi_sec {
> +	struct dentry *file;
> +	struct pi_object *start;
> +	struct pi_object *end;
> +};

This structure should not be needed, see below.

> +
> +/* The base dir for module formats, typically debugfs/printk/index/ */
> +struct dentry *dfs_index;
> +
> +#ifdef CONFIG_MODULES
> +static const char *pi_get_module_name(struct module *mod)
> +{
> +	return mod ? mod->name : "vmlinux";
> +}
> +
> +void pi_sec_remove(struct module *mod)
> +{
> +	if (!mod || !mod->pi_sec)
> +		return;
> +
> +	debugfs_remove(mod->pi_sec->file);
> +	kfree(mod->pi_sec);
> +	mod->pi_sec = NULL;
> +}
> +#else
> +static const char *pi_get_module_name(struct module *mod)
> +{
> +	return "vmlinux";
> +}
> +
> +void pi_sec_remove(struct module *mod)
> +{
> +}
> +#endif
>
> +static void *pi_next(struct seq_file *s, void *v, loff_t *pos)
> +{
> +	const struct pi_sec *ps = s->file->f_inode->i_private;
> +	struct pi_object *pi = NULL;

Please, call the variables by the content and not by prefix.
A variable called "pi" might include anything used by "pi" API.

> +	loff_t idx = *pos - 1;

Why is -1 here, please?

Later note: I guess that it is because you wanted to reuse
    this in pi_start(). Uff, it made the code really
    twisted.

> +
> +	++*pos;
> +
> +	if (idx == -1)
> +		return SEQ_START_TOKEN;

This would not happen if you did not substraced the one above.

> +
> +	pi = ps->start + idx;
> +
> +	return pi < ps->end ? pi : NULL;
> +}

Honestly, the names and the coding style made the function almost
unreadable.

OK, I suggest that pi_next will return pointer to struct pi_entry.
The code might look like:

static struct pi_entry *pi_get_entry(struct module *mod, int idx)
{
	struct pi_entry *entries;
	int num_entries;

	if (mod) {
		entries = mod->entries;
		num_entries = num->num_entries;
	} else {
		entries = vmlinux_entries;
		num_entries = vmlinux_num_entries;
	}

	if (idx >= num_entries)
		return NULL;

	return entries[idx];
}

static void *pi_next(struct seq_file *s, void *v, loff_t *pos)
{
	const struct module *mod = (struct module*)s->file->f_inode->i_private;
	struct pi_entry *entry;

	entry = pi_get_entry(mod, *pos);
	*(pos)++;

	return entry;
}

> +
> +static void *pi_start(struct seq_file *s, loff_t *pos)
> +{
> +	return pi_next(s, NULL, pos);

Grr, you complicated pi_next() just return SEQ_START_TOKEN here
and keep pos as is? The following should do the same job:

static void *pi_start(struct seq_file *s, loff_t *pos)
{
	return SEQ_START_TOKEN;
}

Do not forget to move it above pi_next() where it belongs logically.


> +}
> +
> +static int pi_show(struct seq_file *s, void *v)
> +{

We are passing struct pi_entry via "v" pointer now:

static int pi_show(struct seq_file *s, void *v)
{
	const struct pi_entry *entry = v;
	int level = LOGLEVEL_DEFAULT;
	enum printk_info_flags info_flags = 0;
	u16 prefix_len;

	if (v == SEQ_START_TOKEN) {
		seq_puts(s,
			 "# <level[,flags]> filename:line function \"format\"\n");
		return 0;
	}

	prefix_len = printk_parse_prefix(entry->fmt, &level, &lflags);
	seq_printf(s, "<%d%s> %s:%d %s \"",
			level, info_flags & LOG_CONT ? ",c" : "", entry->file,
			entry->line, entry->func);
	seq_escape_printf_format(s, entry->fmt + prefix_len);
	seq_puts(s, "\"\n");

	return 0;
}


> +static void pi_stop(struct seq_file *p, void *v)
> +{
> +}
> +
> +static const struct seq_operations dfs_index_seq_ops = {
> +	.start = pi_start,
> +	.next  = pi_next,
> +	.show  = pi_show,
> +	.stop  = pi_stop,
> +};
> +
> +
> +static int pi_open(struct inode *inode, struct file *file)
> +{
> +	return seq_open(file, &dfs_index_seq_ops);
> +}
> +
> +static const struct file_operations dfs_index_fops = {
> +	.open    = pi_open,
> +	.read    = seq_read,
> +	.llseek  = seq_lseek,
> +	.release = seq_release
> +};
> +
> +
> +void pi_sec_store(struct module *mod)

Please, rename this to pi_add_module(). We do not really store
anything here. I would write the code this way:

static struct dentry *pi_create_file(struct module *mod, cost char *name)
{
	return debugfs_create_file(name, 0444, dfs_index,
				   mod, &dfs_index_fops);

}

static void pi_remove_file(struct dentry *dentry)
{
	debugfs_remove(dentry);
}

static struct pi_entry *vmlinux_entries;
static int vmlinux_num_entries;

static int __init pi_init(void)
{
	struct dentry *dfs_root;

	dfs_root = debugfs_create_dir("printk", NULL);
	dfs_index = debugfs_create_dir("index", dfs_root);

	/* vmlinux is handled via local variables */
	vmlinux_entries = __start_printk_index;
	vmlinux_num_entries = __stop_printk_index - __start_printk_index;
	pi_create_file(NULL, "vmlinux");

	return 0;
}

The modules should be handled by notifiers:

static int pi_module_notify(struct notifier_block *nb, unsigned long op,
			     void *data)

	struct module *mod = data;

	switch (op) {
		case MODULE_STATE_COMING:
			mod->pi_file = pi_create_file(mod, mod->name);
			break;
		case MODULE_STATE_GOING:
			pi_remove_file(mod->pi_file);
			break;
		}
	}

	return NOTIFY_OK;
}

> diff --git a/lib/string_helpers.c b/lib/string_helpers.c
> index 7f2d5fbaf243..86bee1b4d392 100644
> --- a/lib/string_helpers.c
> +++ b/lib/string_helpers.c
> @@ -436,6 +436,24 @@ static bool escape_hex(unsigned char c, char **dst, char *end)
>  	return true;
>  }
>  
> +static bool escape_quote(unsigned char c, char **dst, char *end)
> +{
> +	char *out = *dst;
> +
> +	if (c != '"')
> +		return false;
> +
> +	if (out < end)
> +		*out = '\\';
> +	++out;
> +	if (out < end)
> +		*out = '"';
> +	++out;
> +
> +	*dst = out;
> +	return true;

Hmm, we should bundle this into escape_special(). The opposite
unescape_special() already handles the double quotes.

IMHO, the escape() and unescape() API should be in sync.

Of course, we need to make sure that it does not break some
existing users.

Please, try to udpate escape_special() and check if it is OK
for the existing users.

Anyway, please, update this API in a separate patch. Also add
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
and Rasmus Villemoes <linux@rasmusvillemoes.dk> into CC.

> +}
> +

Please, try to put more effort into creating the function and
variable names. I know that I am probably too picky about it.
But you seem to be the other extreme.

Inconsistent, ambiguous, or meaningless names might make even few
lines of code hard to follow. It makes it write-only.
It is hard to review and maintain.

Best Regards,
Petr
