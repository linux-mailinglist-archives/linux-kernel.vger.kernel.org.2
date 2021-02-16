Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF3F31CECC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 18:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhBPRPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 12:15:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:44636 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229916AbhBPROx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 12:14:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613495646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DqRemUsTixwJWG/IHKoUURn/bDh/YuzEoMp4VdMyPVo=;
        b=dcFtB5SXl6o0blq2R82iC7tnJsyZRu60Y6Kqz8HQI1+r/A12gLpvieaYxGeM/Y0e5MkJUd
        3W0zd3sYr3ivzS6I8eoWalTfBYEL5IInVNrsxTo1JaOE8qB5LhNbV6NxMXrdlP7uDRcXca
        BJeRRJcDotaQqDZ4JTxL4/E4qfuOKBA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 826D2B7A4;
        Tue, 16 Feb 2021 17:14:06 +0000 (UTC)
Date:   Tue, 16 Feb 2021 18:14:05 +0100
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
Subject: code style: Re: [PATCH v4] printk: Userspace format enumeration
 support
Message-ID: <YCv9Xb7ePnDy9xRf@alley>
References: <YCafCKg2bAlOw08H@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCafCKg2bAlOw08H@chrisdown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is from Nitpicker's department.

On Fri 2021-02-12 15:30:16, Chris Down wrote:
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
> This patch provides a solution to the issue of silently changed or
> deleted printks: we record pointers to all printk format strings known
> at compile time into a new .printk_fmts section, both in vmlinux and
> modules. At runtime, this can then be iterated by looking at
> <debugfs>/printk/formats/<module>, which emits the same format as
> `printk` itself, which we already export elsewhere (for example, in
> netconsole).

Please show how the format really look like. It is not
exactly as in netconsole.


> As an example of how simple a parser for this format can be:
> 
>     $ cat pf.py
>     #!/usr/bin/env python
>     with open("/sys/kernel/debug/printk/formats/vmlinux") as f:
>         raw_fmts = f.read().split("\x00")[:-1]
>         for raw_fmt in raw_fmts:
>             level, fmt = raw_fmt[1], raw_fmt[2:]
>             print(f"Level {level}: {fmt!r}")
> 
>     $ ./pf.py | shuf -n 5
>     Level 4: 'Build ID is too large to include in vmcoreinfo: %u > %u\n'
>     Level 3: 'BIOS bug, no explicit IRQ entries, using default mptable. (tell your hw vendor)\n'
>     Level 3: 'Failed to execute %s (error %d)\n'
>     Level 3: 'CHRDEV "%s" minor range requested (%u-%u) is out of range of maximum range (%u-%u) for a single major\n'
>     Level 3: "slub_debug option '%c' unknown. skipped\n"

This looks much better than the original content. The kernel should
produce something human readable out of box.

Ah, this should have been mentioned in the reply prefixed by "output".

> diff --git a/init/Kconfig b/init/Kconfig
> index ab2e916f7e8b..f1f37a060235 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -764,6 +764,20 @@ config PRINTK_SAFE_LOG_BUF_SHIFT
>  		     13 =>   8 KB for each CPU
>  		     12 =>   4 KB for each CPU
>  
> +config PRINTK_ENUMERATION
> +	bool "Printk enumeration debugfs interface"
> +
> +	depends on PRINTK && DEBUG_FS
> +	help
> +	  Add support for enumeration of all printk formats known at compile
> +	  time at <debugfs>/printk/formats/<module>.
> +
> +	  This can be used as part of maintaining daemons which monitor
> +	  /dev/kmsg, as it permits auditing the printk formats present in a
> +	  kernel, allowing monitoring of cases where monitored printks are
> +	  changed or no longer present.
> +
> +	  There is no additional runtime cost to printk with this enabled.
> +
>  #
>  # Architectures with an unreliable sched_clock() should select this:
>  #
> diff --git a/kernel/module.c b/kernel/module.c
> index 1e5aad812310..7b0f2a2f428e 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -3429,6 +3429,11 @@ static int find_module_sections(struct module *mod, struct load_info *info)
>  						sizeof(unsigned long),
>  						&mod->num_kprobe_blacklist);
>  #endif
> +#ifdef CONFIG_PRINTK_ENUMERATION
> +	mod->printk_fmts_start = section_objs(info, ".printk_fmts",
> +					      sizeof(*mod->printk_fmts_start),
> +					      &mod->printk_fmts_sec_size);

I wonder if we could find a better name for the configure switch.
I have troubles to imagine what printk enumeration might mean.
Well, it might be because I am not a native speaker.

Anyway, the word "enumeration" is used only in the configure option.
Everything else is "printk_fmt"

What about DEBUG_PRINTK_FORMATS?

> +#endif
>  #ifdef CONFIG_HAVE_STATIC_CALL_INLINE
>  	mod->static_call_sites = section_objs(info, ".static_call_sites",
>  					      sizeof(*mod->static_call_sites),
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 5a95c688621f..adf545ba9eb9 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -47,6 +47,8 @@
>  #include <linux/sched/clock.h>
>  #include <linux/sched/debug.h>
>  #include <linux/sched/task_stack.h>
> +#include <linux/debugfs.h>
> +#include <linux/hashtable.h>
>  
>  #include <linux/uaccess.h>
>  #include <asm/sections.h>
> @@ -617,6 +619,222 @@ static ssize_t msg_print_ext_body(char *buf, size_t size,
>  	return len;
>  }

printk.c is already too big. Please, implement this feature in a
separate source file, e.g. kernel/printk/debug_formats.c.

Please, use kernel/printk/internal.h if you need some function
from printk.c that have not been public before.

> +#ifdef CONFIG_PRINTK_ENUMERATION
> +
> +/*
> + * debugfs/printk/formats/ - userspace enumeration of printk formats
> + *
> + * The format is the same as typically used by printk, <KERN_SOH><level>fmt,
> + * with each distinct format separated by \0.
> + */


> struct printk_fmt_sec {
> +	struct hlist_node hnode;
> +	struct module *module;

Please, use "struct module *mod". It is a more common.

> +	struct dentry *file;
> +	const char **start;
> +	const char **end;
> +};

Please, document the meaning of the fields, ideally using the doc
style or how is the style called:

/**
 * struct printk_fmt_sec - 
 * @hnode:	node for the hash table
 * @new_func:	pointer to the patched function code


> +
> +/* The base dir for module formats, typically debugfs/printk/formats/ */
> +struct dentry *dfs_formats;
> +
> +/*
> + * Stores .printk_fmt section boundaries for vmlinux and all loaded modules.
> + * Add entries with store_printk_fmt_sec, remove entries with
> + * remove_printk_fmt_sec.
> + */
> +static DEFINE_HASHTABLE(printk_fmts_mod_sections, 8);

The hash table looks like an overkill. This is slow path. There are
typically only tens of loaded modules. Even the module loader
uses plain list for iterating the list of modules.

> +
> +/* Protects printk_fmts_mod_sections */
> +static DEFINE_MUTEX(printk_fmts_mutex);

What is the rule for using "printk_fmts" and "printk_fmt", please?
I can't find the system here ;-)

Anyway, I would prefer to use "printk_fmt" everywhere.
Or maybe even "pf_".

> +
> +static const char *ps_get_module_name(const struct printk_fmt_sec *ps);
> +static int debugfs_pf_open(struct inode *inode, struct file *file);

There are used many different:

   + shortcuts: fmt, fmts, ps, fmt_sec, dfs

   + styles/ordering: ps_get_module_name() vs.
		      find_printk_fmt_sec() vs.
		      printk_fmt_size() vs.
		      debugfs_pf_open()

It might be bearable because there is not much code. But it would
still help a lot when we make it more consistent. Many subsystems
prefer using a feature-specific prefix.

It might be "printk_fmt_" or "pf_" [*] in this case. And we could use
names like:

	+ struct pf_object [**]
	+ pf_get_object_name()
	+ pf_find_object()
	+ pf_fops,
	+ pf_open()
	+ pf_release()
	+ pf_mutex,
	+ pf_add_object()
	+ pf_remove_object()
	+ pf_module_notify

[*] "pf_" is inspired by kernel/printk/printk_ringbuffer.c that
     uses "prb_" prefix.

[**] The "object" is either vmlinux or module. I took this naming from
     include/linux/livepatch.h and kernel/livepatch/*.
     The livepatch code needs to handle vmlinux name a special way
     as well. Also notice that the livepatch code uses klp_ prefix ;-)

Best Regards,
Petr
