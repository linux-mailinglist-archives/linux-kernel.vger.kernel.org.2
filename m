Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94AE314937
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 08:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhBIHB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 02:01:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:33032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229745AbhBIHBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 02:01:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E212B64E9A;
        Tue,  9 Feb 2021 07:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612854044;
        bh=1oc/Hxzh6LQAwGHHC5YWOt3hkuwq+J2Ol4Flp1dGtVs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ALmUQBIdyWFrvYgxeo+cP6G8g3Eo0DSiKLoWQ/mgKvF1hEgBOVeIsqBHMfaX+ouMB
         90Oh9SeT08NRFFZ3P3N+oKvh6jNGQ5sCaL5Rd3qTW96sadV8BxHnvE7NcR+mX9iopH
         JLdPd5Oq+FLd4M2wxGJwpFI7NVRpOWTpMEP1M3ek=
Date:   Tue, 9 Feb 2021 08:00:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
Subject: Re: [PATCH v2] printk: Userspace format enumeration support
Message-ID: <YCIzGBccfHL0dwgF@kroah.com>
References: <YCIRf1zOk9g2R6fH@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCIRf1zOk9g2R6fH@chrisdown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 04:37:19AM +0000, Chris Down wrote:
> +
> +	file = debugfs_create_file(ps_get_module_name(ps), 0444, dfs_formats,
> +				   mod, &dfs_formats_fops);
> +
> +	if (IS_ERR_OR_NULL(file))

How can file ever be NULL?

And if it is an error, what is the problem here?  You can always feed
the output of a debugfs_* call back into debugfs, and you never need to
check the return values.

> +		ps->file = NULL;
> +	else
> +		ps->file = file;
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
> +	kfree(ps);
> +}
> +
> +static int module_printk_fmts_notify(struct notifier_block *self,
> +				     unsigned long val, void *data)
> +{
> +	struct module *mod = data;
> +
> +	if (mod->printk_fmts_sec_size) {
> +		switch (val) {
> +		case MODULE_STATE_COMING:
> +			store_printk_fmt_sec(mod, mod->printk_fmts_start,
> +					     mod->printk_fmts_start +
> +						     mod->printk_fmts_sec_size);
> +			break;
> +
> +		case MODULE_STATE_GOING:
> +			remove_printk_fmt_sec(mod);
> +			break;
> +		}
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +static const char *ps_get_module_name(const struct printk_fmt_sec *ps)
> +{
> +	return ps->module ? ps->module->name : "vmlinux";
> +}
> +
> +static struct notifier_block module_printk_fmts_nb = {
> +	.notifier_call = module_printk_fmts_notify,
> +};
> +
> +static int __init module_printk_fmts_init(void)
> +{
> +	return register_module_notifier(&module_printk_fmts_nb);
> +}
> +
> +core_initcall(module_printk_fmts_init);
> +
> +#else /* !CONFIG_MODULES */
> +static const char *ps_get_module_name(const struct printk_fmt_sec *ps)
> +{
> +	return "vmlinux";
> +}
> +#endif /* CONFIG_MODULES */
> +
> +static int debugfs_pf_show(struct seq_file *s, void *v)
> +{
> +	struct module *mod = s->file->f_inode->i_private;
> +	struct printk_fmt_sec *ps = NULL;
> +	const char **fptr = NULL;
> +	int ret = 0;
> +
> +	mutex_lock(&printk_fmts_mutex);
> +
> +	/*
> +	 * The entry might have been invalidated in the hlist between _open and
> +	 * _show, which is we need to eyeball the entries under
> +	 * printk_fmts_mutex again.
> +	 */
> +	ps = find_printk_fmt_sec(mod);
> +	if (unlikely(!ps)) {
> +		ret = -ENOENT;
> +		goto out_unlock;
> +	}
> +
> +	for (fptr = ps->start; fptr < ps->end; fptr++) {
> +		/* For callsites without facility/level preamble. */
> +		if (unlikely(*fptr[0] != KERN_SOH_ASCII))
> +			seq_printf(s, "%c%d", KERN_SOH_ASCII,
> +				   MESSAGE_LOGLEVEL_DEFAULT);
> +		seq_printf(s, "%s%c", *fptr, '\0');
> +	}
> +
> +out_unlock:
> +	mutex_unlock(&printk_fmts_mutex);
> +	return ret;
> +}
> +
> +static int debugfs_pf_open(struct inode *inode, struct file *file)
> +{
> +	struct module *mod = inode->i_private;
> +	struct printk_fmt_sec *ps = NULL;
> +	int ret;
> +
> +	/*
> +	 * We can't pass around the printk_fmt_sec because it might be freed
> +	 * before we enter the mutex. Do the hash table lookup each time to
> +	 * check.
> +	 */
> +	mutex_lock(&printk_fmts_mutex);
> +
> +	ps = find_printk_fmt_sec(mod);
> +	if (unlikely(!ps)) {
> +		ret = -ENOENT;
> +		goto out_unlock;
> +	}
> +
> +	ret = single_open_size(file, debugfs_pf_show, NULL, ps->output_size);
> +
> +out_unlock:
> +	mutex_unlock(&printk_fmts_mutex);
> +
> +	return ret;
> +}
> +
> +static int __init init_printk_fmts(void)
> +{
> +	struct dentry *dfs_root = debugfs_create_dir("printk", NULL);
> +	struct dentry *tmp = NULL;
> +
> +	if (IS_ERR_OR_NULL(dfs_root))

Again, how can dfs_root be NULL?

And why care about any error?  No kernel code should ever work
differently if debugfs is acting up or not.

> +		return -ENOMEM;
> +
> +	tmp = debugfs_create_dir("formats", dfs_root);
> +
> +	if (IS_ERR_OR_NULL(tmp))

Again, NULL can never happen.  Where did you copy this logic from?  I
need to go fix that...

thanks,

greg k-h
