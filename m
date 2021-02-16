Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE0831CD4A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 16:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhBPPyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 10:54:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:34264 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229764AbhBPPyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 10:54:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613490807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=82pxYMF3CVVK2ZAIiv1QtTVH8l3scQQ3jNGZTmQQkMo=;
        b=FgnR/v6EmaC2NVDtbpN/smOkhW9MtTe+iF0z8dsiRuedPnI5e4N2c66yin7BGfdLZB5B76
        XnGxsjFeXzO4J7S/7lOlGSm+FKS1WOrX8NOzwNev++kIXRcCeWXTrECne8EC+MGHbt9LnQ
        rDAdQmkrkoT0dcyzkhUnowiIi38daZs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 775DCAD2B;
        Tue, 16 Feb 2021 15:53:27 +0000 (UTC)
Date:   Tue, 16 Feb 2021 16:53:26 +0100
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
Subject: output: was: Re: [PATCH v4] printk: Userspace format enumeration
 support
Message-ID: <YCvqdrBc3wLDClhv@alley>
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
> This patch provides a solution to the issue of silently changed or
> deleted printks: we record pointers to all printk format strings known
> at compile time into a new .printk_fmts section, both in vmlinux and
> modules. At runtime, this can then be iterated by looking at
> <debugfs>/printk/formats/<module>, which emits the same format as
> `printk` itself, which we already export elsewhere (for example, in
> netconsole).
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 5a95c688621f..adf545ba9eb9 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
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
> +	 * _show, so we need to eyeball the entries under printk_fmts_mutex
> +	 * again.
> +	 */
> +	ps = find_printk_fmt_sec(mod);
> +	if (unlikely(!ps)) {
> +		ret = -ENOENT;
> +		goto out_unlock;
> +	}
> +
> +	for (fptr = ps->start; fptr < ps->end; fptr++) {
> +		/* For callsites without KERN_SOH + level preamble. */
> +		if (unlikely(*fptr[0] != KERN_SOH_ASCII))
> +			seq_printf(s, "%c%d", KERN_SOH_ASCII,
> +				   MESSAGE_LOGLEVEL_DEFAULT);
> +		seq_printf(s, "%s%c", *fptr, '\0');
> +	}

This produces something like:

3Warning: unable to open an initial console.
3Failed to execute %s (error %d)
6Kernel memory protection disabled.
3Starting init: %s exists but couldn't execute it (error %d)
6Run %s as init process
7initcall %pS returned %d after %lld usecs
7calling  %pS @ %i
2initrd overwritten (0x%08lx < 0x%08lx) - disabling it.

The loglevel is not well separated. It is neither human readable
nor safe for a machine processing . It works only for single digit.

Also it includes the KERN_SOH and other non-printable blobs.
It looks in less like:

^A3Warning: unable to open an initial console.
^@^A3Failed to execute %s (error %d)
^@^A6Kernel memory protection disabled.
^@^A3Starting init: %s exists but couldn't execute it (error %d)
^@^A6Run %s as init process
^@^A7initcall %pS returned %d after %lld usecs
^@^A7calling  %pS @ %i
^@^A2initrd overwritten (0x%08lx < 0x%08lx) - disabling it.
^@^A5Kernel command line: %s
^@^A5%s^@^A6mem auto-init: clearing system memory may take some time...

I would like to use something already existing. We add only loglevel,
so the syslog format would be the best

<3> Warning: unable to open an initial console.
<3> Failed to execute %s (error %d)
<6> Kernel memory protection disabled.
<3> Starting init: %s exists but couldn't execute it (error %d)
<6> Run %s as init process
<7> initcall %pS returned %d after %lld usecs
<7> calling  %pS @ %i
<2> initrd overwritten (0x%08lx < 0x%08lx) - disabling it.

Regarding the non-printable characters, I would either use the same
escape sequences as in /sys/kernel/debug/dynamic_debug/control

But even better might be to preserve to origianal text
as much as possible. It have to the following text
with the patch below:

<3> Warning: unable to open an initial console.\n
<3> Failed to execute %s (error %d)\n
<6> Kernel memory protection disabled.\n
<3> Starting init: %s exists but couldn't execute it (error %d)\n
<6> Run %s as init process\n
<7> initcall %pS returned %d after %lld usecs\n
<7> calling  %pS @ %i\n
<2> initrd overwritten (0x%08lx < 0x%08lx) - disabling it.\n
<5> Kernel command line: %s\n


Well, it still might be non-trivial to find the string in the code
and see what exactly has changed. It might be pretty useful
to mention even the source_file:line, for example:

<3> init/main.c:1489: Warning: unable to open an initial console.\n
<3> init/main.c:1446: Failed to execute %s (error %d)\n
<6> init/main.c:1398: Kernel memory protection disabled.\n
<3> init/main.c:1366: Starting init: %s exists but couldn't execute it (error %d)\n

The way how to store the filename and line number might be found
in the dynamic_debug code.

> +
> +out_unlock:
> +	mutex_unlock(&printk_fmts_mutex);
> +	return ret;
> +}

I have achieved the last but one output with the following patch
on top of the original one:

From d21d1c6d45fc66beb90de8d3309f925ecb501f1a Mon Sep 17 00:00:00 2001
From: Petr Mladek <pmladek@suse.com>
Date: Fri, 12 Feb 2021 18:43:54 +0100
Subject: [PATCH] better output

---
 fs/seq_file.c            | 21 +++++++++++++++++++++
 include/linux/seq_file.h |  1 +
 kernel/printk/printk.c   | 20 ++++++++++++++------
 3 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index 03a369ccd28c..364587eff9d2 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -376,6 +376,27 @@ void seq_escape(struct seq_file *m, const char *s, const char *esc)
 }
 EXPORT_SYMBOL(seq_escape);
 
+/**
+ *	seq_escape+printf_format - print string into buffer, escaping
+ *		characters that are escaped in printf format,
+ *	@m:	target buffer
+ *	@s:	string
+ *
+ *	Puts string into buffer and escape characters that are
+ *	escaped in printf format.
+ *	Use seq_has_overflowed() to check for errors.
+ */
+void seq_escape_printf_format(struct seq_file *m, const char *s)
+{
+	char *buf;
+	size_t size = seq_get_buf(m, &buf);
+	int ret;
+
+	ret = string_escape_str(s, buf, size, ESCAPE_SPACE | ESCAPE_SPECIAL, NULL);
+	seq_commit(m, ret < size ? ret : -1);
+}
+EXPORT_SYMBOL(seq_escape_printf_format);
+
 void seq_escape_mem_ascii(struct seq_file *m, const char *src, size_t isz)
 {
 	char *buf;
diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index b83b3ae3c877..cfc504a30429 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -127,6 +127,7 @@ void seq_put_hex_ll(struct seq_file *m, const char *delimiter,
 		    unsigned long long v, unsigned int width);
 
 void seq_escape(struct seq_file *m, const char *s, const char *esc);
+void seq_escape_printf_format(struct seq_file *m, const char *s);
 void seq_escape_mem_ascii(struct seq_file *m, const char *src, size_t isz);
 
 void seq_hex_dump(struct seq_file *m, const char *prefix_str, int prefix_type,
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index adf545ba9eb9..77a43b483b7b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -783,6 +783,8 @@ static const char *ps_get_module_name(const struct printk_fmt_sec *ps)
 }
 #endif /* CONFIG_MODULES */
 
+static u16 parse_prefix(const char *text, int *level, enum log_flags *lflags);
+
 static int debugfs_pf_show(struct seq_file *s, void *v)
 {
 	struct module *mod = s->file->f_inode->i_private;
@@ -804,11 +806,17 @@ static int debugfs_pf_show(struct seq_file *s, void *v)
 	}
 
 	for (fptr = ps->start; fptr < ps->end; fptr++) {
-		/* For callsites without KERN_SOH + level preamble. */
-		if (unlikely(*fptr[0] != KERN_SOH_ASCII))
-			seq_printf(s, "%c%d", KERN_SOH_ASCII,
-				   MESSAGE_LOGLEVEL_DEFAULT);
-		seq_printf(s, "%s%c", *fptr, '\0');
+		int level;
+		u16 prefix_len;
+		const char *fmt;
+
+		level = LOGLEVEL_DEFAULT;
+		prefix_len = parse_prefix(fptr[0], &level, NULL);
+		fmt = fptr[0] + prefix_len;
+
+		seq_printf(s, "<%d> ", level);
+		seq_escape_printf_format(s, fmt);
+		seq_printf(s, "\n");
 	}
 
 out_unlock:
@@ -2113,7 +2121,7 @@ static inline u32 printk_caller_id(void)
  *
  * Return: The length of the parsed level and control flags.
  */
-static u16 parse_prefix(char *text, int *level, enum log_flags *lflags)
+static u16 parse_prefix(const char *text, int *level, enum log_flags *lflags)
 {
 	u16 prefix_len = 0;
 	int kern_level;
-- 
2.26.2

