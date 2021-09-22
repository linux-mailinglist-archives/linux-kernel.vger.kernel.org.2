Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972A1413FE3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 05:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhIVDG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 23:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbhIVDG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 23:06:28 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F641C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 20:04:59 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id r7so459736pjo.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 20:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OzjyexXGMsh3c/BWbQIsZAeDJA8HHMrn8lzjhBC6h/Q=;
        b=fLr2Fl2fRRlfjOxUaBSTdppnUEqVtDuDmx6v5QcqRqAvKiQxidUP0XV9qB3f/t/oDB
         V6UD9Pgp0YOKGB4jUzGpBq9dbj6TFQJp+ZBWCjtDIiaR4IeNVVCiFzD+4uSR9DcfOy9p
         miUrYBtysmKfaMSEfli99mhyGnX3wxlpgAlik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OzjyexXGMsh3c/BWbQIsZAeDJA8HHMrn8lzjhBC6h/Q=;
        b=6z1Ub5lZQoC8CPVc2DM5Aecs8bc29zQDjgI2D7XYdWQ2az3LN9tlakddHQBZpJ1GfX
         EDyTd47iFmukh3M/3gsOHpUSxiabVRHRIcyeE3ibTrv7MQXlVADxKaxoiwIats35+rXU
         wmWjrrYRwM0GPJa58yuFZNSzBFxaPaTTe+ddi3reeAtnTKrg1/jFmdc3HAt0Fy9v26Xu
         jwkAubguI574fgY4baT9fNbaamlRSTs6kaHi/rHwbe1oxBimg0DE0kQjAeriTd0/gEW0
         281po9VPtlCkm5GnT9nr9A0Ym/vXfM4tFPGwWwKg0MUfyMwA+Cpy1WPsTyrKpdWOvLA8
         BB3A==
X-Gm-Message-State: AOAM530cM0iBeRMH0Vb/zWvrzXL3jhMUmKjFUDjedtLVimkH1GpMUM8y
        WXvuJmEG77q5j3gSfR/Pao5A+g==
X-Google-Smtp-Source: ABdhPJzKtdb80CS01qkLG8h2+HWRucfiiCFIYusYMyQsm6KzKgwH4+vO1VhqOqD+zLzp9jzuTZ/a+Q==
X-Received: by 2002:a17:90a:9285:: with SMTP id n5mr8738669pjo.29.1632279898736;
        Tue, 21 Sep 2021 20:04:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q3sm530474pgf.18.2021.09.21.20.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 20:04:58 -0700 (PDT)
Date:   Tue, 21 Sep 2021 20:04:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Vito Caputo <vcaputo@pengaru.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>, peterz@infradead.org,
        luto@kernel.org, jannh@google.com
Subject: Re: CONFIG_ORC_UNWINDER=y breaks get_wchan()?
Message-ID: <202109211931.E6E33500E8@keescook>
References: <20210921193249.el476vlhg5k6lfcq@shells.gnugeneration.com>
 <20210922001537.4ktg3r2ky3b3r6yp@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922001537.4ktg3r2ky3b3r6yp@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 05:15:37PM -0700, Josh Poimboeuf wrote:
> On Tue, Sep 21, 2021 at 12:32:49PM -0700, Vito Caputo wrote:
> > Is this an oversight of the ORC_UNWINDER implementation?  It's
> > arguably a regression to completely break wchans for tools like `ps -o
> > wchan` and `top`, or my window manager and its separate monitoring
> > utility.  Presumably there are other tools out there sampling wchans
> > for monitoring as well, there's also an internal use of get_chan() in
> > kernel/sched/fair.c for sleep profiling.
> > 
> > I've occasionally seen when monitoring at a high sample rate (60hz) on
> > something churny like a parallel kernel or systemd build, there's a
> > spurious non-zero sample coming out of /proc/[pid]/wchan containing a
> > hexadecimal address like 0xffffa9ebc181bcf8.  This all smells broken,
> > is get_wchan() occasionally spitting out random junk here kallsyms
> > can't resolve, because get_chan() is completely ignorant of
> > ORC_UNWINDER's effects?
> 
> Hi Vito,
> 
> Thanks for reporting this.  Does this patch fix your issue?
> 
>   https://lkml.kernel.org/r/20210831083625.59554-1-zhengqi.arch@bytedance.com
> 
> Though, considering wchan has been silently broken for four years, I do
> wonder what the impact would be if we were to just continue to show "0"
> (and change frame pointers to do the same).
> 
> The kernel is much more cautious than it used to be about exposing this
> type of thing.  Can you elaborate on your use case?
> 
> If we do keep it, we might want to require CAP_SYS_ADMIN anyway, for
> similar reasons as 
> 
>   f8a00cef1720 ("proc: restrict kernel stack dumps to root")

Normally wchan is protected by:

	ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS)

I might argue that this check isn't right -- it needs to be using
f_cred, but I'll let Jann answer more there.

> ... since presumably proc_pid_wchan()'s use of '%ps' can result in an
> actual address getting printed if the unwind gets confused, thanks to
> __sprint_symbol()'s backup option if kallsyms_lookup_buildid() doesn't
> find a name.

Ew, yeah, __sprint_symbol() falls back to exposing addresses. :(

        name = kallsyms_lookup_buildid(address, &size, &offset, &modname, &buildid,
                                       buffer);
        if (!name)
                return sprintf(buffer, "0x%lx", address - symbol_offset);

Thought I can't immediately think of what wouldn't be symbolized by
kallsyms_lookup_buildid(), but given it fails open, I can totally
believe there is. :)

	is_ksym_addr()
	module_address_lookup()
	bpf_address_lookup()
	ftrace_mod_address_lookup()

> Though, instead of requiring CAP_SYS_ADMIN, maybe we can just fix
> __sprint_symbol() to not expose addresses?
> 
> Or is there some other reason for needing CAP_SYS_ADMIN?  Jann?

While it's not very high fidelity, I don't like having the kernel
symbols exposed like this because userspace can basically sample the
execution path of syscalls, etc. It's not a raw value, but it still
creeps me out given that it can be probed.

So, if it's been broken for 4 years under ORC, how about we just disable
wchan permanently? (Untested...)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 49be8c8ef555..cfa60e22a5de 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -452,7 +452,7 @@ int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
 static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 			struct pid *pid, struct task_struct *task, int whole)
 {
-	unsigned long vsize, eip, esp, wchan = 0;
+	unsigned long vsize, eip, esp = 0;
 	int priority, nice;
 	int tty_pgrp = -1, tty_nr = 0;
 	sigset_t sigign, sigcatch;
@@ -540,8 +540,6 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 		unlock_task_sighand(task, &flags);
 	}
 
-	if (permitted && (!whole || num_threads < 2))
-		wchan = get_wchan(task);
 	if (!whole) {
 		min_flt = task->min_flt;
 		maj_flt = task->maj_flt;
@@ -600,16 +598,10 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	seq_put_decimal_ull(m, " ", sigcatch.sig[0] & 0x7fffffffUL);
 
 	/*
-	 * We used to output the absolute kernel address, but that's an
-	 * information leak - so instead we show a 0/1 flag here, to signal
-	 * to user-space whether there's a wchan field in /proc/PID/wchan.
-	 *
-	 * This works with older implementations of procps as well.
+	 * We used to output the absolute kernel address, and then just
+	 * a symbol. But both are information leaks.
 	 */
-	if (wchan)
-		seq_puts(m, " 1");
-	else
-		seq_puts(m, " 0");
+	seq_puts(m, " 0");
 
 	seq_put_decimal_ull(m, " ", 0);
 	seq_put_decimal_ull(m, " ", 0);
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 533d5836eb9a..52484cd77f99 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -378,24 +378,10 @@ static const struct file_operations proc_pid_cmdline_ops = {
 };
 
 #ifdef CONFIG_KALLSYMS
-/*
- * Provides a wchan file via kallsyms in a proper one-value-per-file format.
- * Returns the resolved symbol.  If that fails, simply return the address.
- */
 static int proc_pid_wchan(struct seq_file *m, struct pid_namespace *ns,
 			  struct pid *pid, struct task_struct *task)
 {
-	unsigned long wchan;
-
-	if (ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
-		wchan = get_wchan(task);
-	else
-		wchan = 0;
-
-	if (wchan)
-		seq_printf(m, "%ps", (void *) wchan);
-	else
-		seq_putc(m, '0');
+	seq_putc(m, '0');
 
 	return 0;
 }

If not that, then we need to fix the fallback: (Also untested...)


diff --git a/fs/proc/base.c b/fs/proc/base.c
index 533d5836eb9a..0f228c421e5f 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -393,7 +393,7 @@ static int proc_pid_wchan(struct seq_file *m, struct pid_namespace *ns,
 		wchan = 0;
 
 	if (wchan)
-		seq_printf(m, "%ps", (void *) wchan);
+		seq_printf(m, "%pSf", (void *) wchan);
 	else
 		seq_putc(m, '0');
 
diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index a1d6fc82d7f0..8cce2b5c36df 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -96,6 +96,7 @@ const char *kallsyms_lookup(unsigned long addr,
 extern int sprint_symbol(char *buffer, unsigned long address);
 extern int sprint_symbol_build_id(char *buffer, unsigned long address);
 extern int sprint_symbol_no_offset(char *buffer, unsigned long address);
+extern int sprint_symbol_no_fallback(char *buffer, unsigned long address);
 extern int sprint_backtrace(char *buffer, unsigned long address);
 extern int sprint_backtrace_build_id(char *buffer, unsigned long address);
 
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 0ba87982d017..06ebd27dcd3a 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -418,7 +418,8 @@ int lookup_symbol_attrs(unsigned long addr, unsigned long *size,
 
 /* Look up a kernel symbol and return it in a text buffer. */
 static int __sprint_symbol(char *buffer, unsigned long address,
-			   int symbol_offset, int add_offset, int add_buildid)
+			   int symbol_offset, int add_offset, int add_buildid,
+			   int fallback)
 {
 	char *modname;
 	const unsigned char *buildid;
@@ -429,8 +430,11 @@ static int __sprint_symbol(char *buffer, unsigned long address,
 	address += symbol_offset;
 	name = kallsyms_lookup_buildid(address, &size, &offset, &modname, &buildid,
 				       buffer);
-	if (!name)
+	if (!name) {
+		if (!fallback)
+			return sprintf(buffer, "0");
 		return sprintf(buffer, "0x%lx", address - symbol_offset);
+	}
 
 	if (name != buffer)
 		strcpy(buffer, name);
@@ -470,7 +474,7 @@ static int __sprint_symbol(char *buffer, unsigned long address,
  */
 int sprint_symbol(char *buffer, unsigned long address)
 {
-	return __sprint_symbol(buffer, address, 0, 1, 0);
+	return __sprint_symbol(buffer, address, 0, 1, 0, 1);
 }
 EXPORT_SYMBOL_GPL(sprint_symbol);
 
@@ -487,7 +491,7 @@ EXPORT_SYMBOL_GPL(sprint_symbol);
  */
 int sprint_symbol_build_id(char *buffer, unsigned long address)
 {
-	return __sprint_symbol(buffer, address, 0, 1, 1);
+	return __sprint_symbol(buffer, address, 0, 1, 1, 1);
 }
 EXPORT_SYMBOL_GPL(sprint_symbol_build_id);
 
@@ -504,10 +508,27 @@ EXPORT_SYMBOL_GPL(sprint_symbol_build_id);
  */
 int sprint_symbol_no_offset(char *buffer, unsigned long address)
 {
-	return __sprint_symbol(buffer, address, 0, 0, 0);
+	return __sprint_symbol(buffer, address, 0, 0, 0, 1);
 }
 EXPORT_SYMBOL_GPL(sprint_symbol_no_offset);
 
+/**
+ * sprint_symbol_no_fallback - Look up a kernel symbol and return it in a text buffer
+ * @buffer: buffer to be stored
+ * @address: address to lookup
+ *
+ * This function looks up a kernel symbol with @address and stores its name
+ * and module name to @buffer if possible. If no symbol was found, returns
+ * "0".
+ *
+ * This function returns the number of bytes stored in @buffer.
+ */
+int sprint_symbol_no_fallback(char *buffer, unsigned long address)
+{
+	return __sprint_symbol(buffer, address, 0, 0, 0, 0);
+}
+EXPORT_SYMBOL_GPL(sprint_symbol_no_fallback);
+
 /**
  * sprint_backtrace - Look up a backtrace symbol and return it in a text buffer
  * @buffer: buffer to be stored
@@ -524,7 +545,7 @@ EXPORT_SYMBOL_GPL(sprint_symbol_no_offset);
  */
 int sprint_backtrace(char *buffer, unsigned long address)
 {
-	return __sprint_symbol(buffer, address, -1, 1, 0);
+	return __sprint_symbol(buffer, address, -1, 1, 0, 1);
 }
 
 /**
@@ -544,7 +565,7 @@ int sprint_backtrace(char *buffer, unsigned long address)
  */
 int sprint_backtrace_build_id(char *buffer, unsigned long address)
 {
-	return __sprint_symbol(buffer, address, -1, 1, 1);
+	return __sprint_symbol(buffer, address, -1, 1, 1, 1);
 }
 
 /* To avoid using get_symbol_offset for every symbol, we carry prefix along. */
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index d7ad44f2c8f5..83c1065da996 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -999,6 +999,8 @@ char *symbol_string(char *buf, char *end, void *ptr,
 		sprint_backtrace(sym, value);
 	else if (*fmt == 'S' && (fmt[1] == 'b' || (fmt[1] == 'R' && fmt[2] == 'b')))
 		sprint_symbol_build_id(sym, value);
+	else if (*fmt == 'S' && fmt[1] == 'f')
+		sprint_symbol_no_fallback(sym, value);
 	else if (*fmt != 's')
 		sprint_symbol(sym, value);
 	else
@@ -2268,6 +2270,8 @@ early_param("no_hash_pointers", no_hash_pointers_enable);
  * - 's' For symbolic direct pointers (or function descriptors) without offset
  * - '[Ss]R' as above with __builtin_extract_return_addr() translation
  * - 'S[R]b' as above with module build ID (for use in backtraces)
+ * - 'Sf' For symbolic direct pointers (or function descriptors) without offset
+ *        without fallback to unsymbolized address.
  * - '[Ff]' %pf and %pF were obsoleted and later removed in favor of
  *	    %ps and %pS. Be careful when re-using these specifiers.
  * - 'B' For backtraced symbolic direct pointers with offset


-- 
Kees Cook
