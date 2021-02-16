Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96BF331CD6E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 17:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhBPQB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 11:01:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:38208 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229708AbhBPQBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 11:01:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613491228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JipK6xkF+8oNavIVFVqoSZnucmL1iuE/CDXl5MQc5pU=;
        b=vMjqzU3jM4ZE03eciuSLI8Yj8wdJrupjqdIZlTuUhziJRXvq3ThnvsqBz0ijeI+6NIlNqN
        UbEhVy98N5IOqDkbaevsm4AgzgG5OLA3OUyZvpFbGaYNpuL6F7IBaogBynVzpaXEBvqKsJ
        s54P6RSVumEs7cS05H/7r7hIyixsNG4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CE113AE47;
        Tue, 16 Feb 2021 16:00:27 +0000 (UTC)
Date:   Tue, 16 Feb 2021 17:00:27 +0100
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
Subject: debugfs: was: Re: [PATCH v4] printk: Userspace format enumeration
 support
Message-ID: <YCvsGzv3qlsWU+UE@alley>
References: <YCafCKg2bAlOw08H@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCafCKg2bAlOw08H@chrisdown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
> 
> This patch provides a solution to the issue of silently changed or
> deleted printks: we record pointers to all printk format strings known
> at compile time into a new .printk_fmts section, both in vmlinux and
> modules. At runtime, this can then be iterated by looking at
> <debugfs>/printk/formats/<module>, which emits the same format as
> `printk` itself, which we already export elsewhere (for example, in
> netconsole).

> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 5a95c688621f..adf545ba9eb9 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> +
> +static const struct file_operations dfs_formats_fops = {
> +	.open    = debugfs_pf_open,
> +	.read    = seq_read,
> +	.llseek  = seq_lseek,
> +	.release = single_release,
> +};
> +
> +static size_t printk_fmt_size(const char *fmt)
> +{
> +	size_t sz = strlen(fmt) + 1;
> +
> +	/*
> +	 * Some printk formats don't start with KERN_SOH + level. We will add
> +	 * it later when rendering the output.
> +	 */
> +	if (unlikely(fmt[0] != KERN_SOH_ASCII))
> +		sz += 2;

This approach is hard to maintain. It might be pretty hard and error
prone to count the size if we want to provide more information.

There are many files in debugfs with not-well defined size.
They are opened by seq_open_private(). It allows to add
a line by line by an iterator.

For example:

	+ /sys/kernel/debug/dynamic_debug/control is opened by
	  ddebug_proc_open() in lib/dynamic_debug.c

	+ /sys/kernel/debug/tracing/available_filter_functions
	  is opened by ftrace_avail_open() in kernel/trace/ftrace.c



> +
> +	return sz;
> +}
> +
> +static struct printk_fmt_sec *find_printk_fmt_sec(struct module *mod)
> +{
> +	struct printk_fmt_sec *ps = NULL;
> +
> +	hash_for_each_possible(printk_fmts_mod_sections, ps, hnode,
> +			       (unsigned long)mod)
> +		if (ps->module == mod)
> +			return ps;
> +
> +	return NULL;
> +}
> +
> +static void store_printk_fmt_sec(struct module *mod, const char **start,
> +				 const char **end)
> +{
> +	struct printk_fmt_sec *ps = NULL;
> +	const char **fptr = NULL;
> +	size_t size = 0;
> +
> +	ps = kmalloc(sizeof(struct printk_fmt_sec), GFP_KERNEL);
> +	if (!ps)
> +		return;
> +
> +	ps->module = mod;
> +	ps->start = start;
> +	ps->end = end;
> +
> +	for (fptr = ps->start; fptr < ps->end; fptr++)
> +		size += printk_fmt_size(*fptr);
> +
> +	mutex_lock(&printk_fmts_mutex);
> +	hash_add(printk_fmts_mod_sections, &ps->hnode, (unsigned long)mod);
> +	mutex_unlock(&printk_fmts_mutex);
> +
> +	ps->file = debugfs_create_file(ps_get_module_name(ps), 0444,
> +				       dfs_formats, mod, &dfs_formats_fops);
> +
> +	if (!IS_ERR(ps->file))
> +		d_inode(ps->file)->i_size = size;

We should revert the changes when the file could not get crated.
It does not make sense to keep the structure when the file is not
there.

I guess that remove_printk_fmt_sec() would even crash when
ps->file was set to an error code.

> +}
> +
> +#ifdef CONFIG_MODULES
> +static void remove_printk_fmt_sec(struct module *mod)
> +{
> +	struct printk_fmt_sec *ps = NULL;
> +
> +	if (WARN_ON_ONCE(!mod))
> +		return;
> +
> +	mutex_lock(&printk_fmts_mutex);
> +
> +	ps = find_printk_fmt_sec(mod);
> +	if (!ps) {
> +		mutex_unlock(&printk_fmts_mutex);
> +		return;
> +	}
> +
> +	hash_del(&ps->hnode);
> +
> +	mutex_unlock(&printk_fmts_mutex);
> +
> +	debugfs_remove(ps->file);

IMHO, we should remove the file before we remove the way how
to read it. This should be done in the opposite order
than in store_printk_fmt_sec().

> +	kfree(ps);
> +}
> +

Best Regards,
Petr
