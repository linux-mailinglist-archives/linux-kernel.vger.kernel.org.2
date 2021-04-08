Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3DE358DBF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 21:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbhDHTwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 15:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbhDHTwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 15:52:41 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5DBC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 12:52:29 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so2003695pjv.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 12:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=Dv3GENB/Y40xX2jz/kW6MZelZZZqs8YuMnMPes1GrZA=;
        b=cDdAvT9hZ3NaDaxSwVWVQU25BuQnvdJONCfOOK8xysu+/KlqZVP906T0OW14a9uTkZ
         ltHU4tnwUgBNdDwELMNPpv93wOVzMiaeiId4qfcOcFvQzQpLM33x903uV1/i2nEXwuvo
         aUEUK45T4bcAQ45QrP+oSyo4ffUtXWKPTEIBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=Dv3GENB/Y40xX2jz/kW6MZelZZZqs8YuMnMPes1GrZA=;
        b=uM5bA6riCXITWSnHT7sBi1AjET0vqM7u3pHMm9nLzeunCD80uIoGSxyU4HCJ62Ewfn
         6OJoGpYBx4c32uc621JntWEZL3bJeWNc9cVo7+EZdn2gOy3uMurjahf4Vlp1BJOyepOA
         QwGPEKa6JCihITwu/pYEiKBYFZl0lY/2dMRwugtFZDMHyDFPvln3bFUdgWiJ0SLWEBHv
         b3j58zkluHQsmbW4CWV9pgU/gpwSpvLQR8bGuUg5UrpepGqA/kdwym7H70ngkAW/RQ74
         +X3B53dKdov53lMyc0FwPsjhVHqSrMOGq8epwFH1uqPmzCGrIkEbKJxrx+rPhYuWCPVc
         GvOQ==
X-Gm-Message-State: AOAM531+UWZoLHCtUtiEFhkXAf3HEa+Ep0Fe5SEM/39NhdJQ5Erj0hqK
        1FykAiaGX/4+xFr/pKVWod6vsw==
X-Google-Smtp-Source: ABdhPJwWOGCtADaVvO6UehsrQU0jphiIco0MDm4kpiUDL0ct+Ne1LHVhDImzegFaThbKTS+ui+yZNw==
X-Received: by 2002:a17:90a:3ee1:: with SMTP id k88mr10435049pjc.174.1617911549400;
        Thu, 08 Apr 2021 12:52:29 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:44c3:3248:e7f5:1bbd])
        by smtp.gmail.com with ESMTPSA id c9sm236878pfl.169.2021.04.08.12.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 12:52:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YG7XQK1FCofMZsqM@alley>
References: <20210331030520.3816265-1-swboyd@chromium.org> <20210331030520.3816265-4-swboyd@chromium.org> <YG27p1AhiOKJOm+y@alley> <161786283299.3790633.9395579294249054249@swboyd.mtv.corp.google.com> <YG7XQK1FCofMZsqM@alley>
Subject: Re: [PATCH v3 03/12] dump_stack: Add vmlinux build ID to stack traces
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
To:     Petr Mladek <pmladek@suse.com>
Date:   Thu, 08 Apr 2021 12:52:27 -0700
Message-ID: <161791154751.3790633.14778133079958701015@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Petr Mladek (2021-04-08 03:13:20)
> It helped with the vmlinux buildid. I see the following:
>=20
> [  551.435942][ T1803] test_printf: loaded.
> [  551.436667][ T1803] ------------[ cut here ]------------
> [  551.437561][ T1803] kernel BUG at lib/test_printf.c:689!
> [  551.438352][ T1803] invalid opcode: 0000 [#1] SMP NOPTI
> [  551.438359][ T1803] CPU: 3 PID: 1803 Comm: modprobe Kdump: loaded Tain=
ted: G            E     5.12.0-rc6-default+ #176 e51781e52aaf4d6dfea7a18574=
c104c8bfd7c37f
> [  551.438363][ T1803] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009)=
, BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
> [  551.438365][ T1803] RIP: 0010:test_printf_init+0x561/0xc99 [test_print=
f c2388ff0552611501b4d2ad58d8e5ca441d9a350]

It shows it for the test module here.

> [  551.443090][ T1803] Code: 00 48 c7 c7 b8 36 1b c0 e8 19 f9 ff ff b9 ab=
 00 00 00 48 c7 c2 93 36 1b c0 be 08 00 00 00 48 c7 c7 af 36 1b c0 e8 fc f8=
 ff ff <0f> 0b 8b 05 44 07 00 00 8b 35 3a 07 00 00 8b 1d 3c 07 00 00 85 c0
> [  551.443094][ T1803] RSP: 0018:ffffb62c0039bc78 EFLAGS: 00010282
> [  551.443096][ T1803] RAX: 0000000000000000 RBX: ffffb62c0039bc80 RCX: f=
fffd62bffc00b70
> [  551.443098][ T1803] RDX: 0000000000000000 RSI: 0000000000000000 RDI: f=
fffffffa0352fd5
> [  551.443099][ T1803] RBP: ffffffffc01b7367 R08: 0000000000000001 R09: 0=
000000000000001
> [  551.443100][ T1803] R10: 0000000000000000 R11: 0000000000000001 R12: f=
fff9bc08c87c820
> [  551.443101][ T1803] R13: 0000000000000001 R14: ffff9bc0d2798480 R15: f=
fffb62c0039be90
> [  551.443102][ T1803] FS:  00007f5767485b80(0000) GS:ffff9bc0ffc00000(00=
00) knlGS:0000000000000000
> [  551.443103][ T1803] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  551.443105][ T1803] CR2: 00007f5766b36ef0 CR3: 0000000100368004 CR4: 0=
000000000370ee0
> [  551.443108][ T1803] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0=
000000000000000
> [  551.443108][ T1803] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0=
000000000000400
> [  551.443109][ T1803] Call Trace:
> [  551.443113][ T1803]  ? __test+0x13c/0x149 [test_printf]

But not here. I missed a place in the x86 code, printk_stack_address()
uses %pB, so I'll need to introduce %pBb to indicate that we're printing
a backtrace with a build ID, oof!

It must be obvious by now but I didn't test on x86. Let me go scrounge
for some hardware...

> [  551.443116][ T1803]  ? rcu_read_lock_sched_held+0x52/0x80
> [  551.443120][ T1803]  do_one_initcall+0x5b/0x2d0
> [  551.443125][ T1803]  do_init_module+0x5b/0x21c
> [  551.443127][ T1803]  load_module+0x1eaa/0x23c0
> [  551.443130][ T1803]  ? show_modinfo_version+0x30/0x30
> [  551.443134][ T1803]  ? __do_sys_finit_module+0xad/0x110
> [  551.443135][ T1803]  __do_sys_finit_module+0xad/0x110
> [  551.443138][ T1803]  do_syscall_64+0x33/0x40
> [  551.443139][ T1803]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  551.443143][ T1803] RIP: 0033:0x7f5766b5b2a9
> [
>=20
> Note that it still does not show the build id for the module. It fails
> in the module init call and the build id should be already initialized
> at this stage.
>=20
> One more thing. I am not familiar with the elf-related code.
> Is it safe to access (nhdr + 1)? Do we need a check that
> it is still withing the given section?

Should be safe given that the elf note header is prepended to the name buff=
er
and the descriptor buffer. The 'n_namesz' member of the header tells us how
many bytes after the header is reserved for the name and the 'n_descsz' mem=
ber
of the header tells us how many bytes after the name is reserved for the
description (where the build ID data is). I did the nhdr + 1 thing to make =
the
pointer point to the name directly after the header. The name is NUL termin=
ated
per the elf spec. See the man page[1] for elf and the section about notes:

"""
Notes (Nhdr)
       ELF notes allow for appending arbitrary information for the
       system to use.  They are largely used by core files (e_type of
       ET_CORE), but many projects define their own set of extensions.
       For example, the GNU tool chain uses ELF notes to pass
       information from the linker to the C library.

       Note sections contain a series of notes (see the struct
       definitions below).  Each note is followed by the name field
       (whose length is defined in n_namesz) and then by the descriptor
       field (whose length is defined in n_descsz) and whose starting
       address has a 4 byte alignment.  Neither field is defined in the
       note struct due to their arbitrary lengths.
"""

[1] https://man7.org/linux/man-pages/man5/elf.5.html


Can you try this patch for x86? I'll dig up some hardware in the meantime.

-----8<----
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 7ad5eea99b2b..be2de39bf16f 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -69,7 +69,7 @@ static void printk_stack_address(unsigned long address, i=
nt reliable,
 				 const char *log_lvl)
 {
 	touch_nmi_watchdog();
-	printk("%s %s%pB\n", log_lvl, reliable ? "" : "? ", (void *)address);
+	printk("%s %s%pBb\n", log_lvl, reliable ? "" : "? ", (void *)address);
 }
=20
 static int copy_code(struct pt_regs *regs, u8 *buf, unsigned long src,
diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index 2569a4792480..f760cb839775 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -96,6 +96,7 @@ extern int sprint_symbol(char *buffer, unsigned long addr=
ess);
 extern int sprint_symbol_build_id(char *buffer, unsigned long address);
 extern int sprint_symbol_no_offset(char *buffer, unsigned long address);
 extern int sprint_backtrace(char *buffer, unsigned long address);
+extern int sprint_backtrace_build_id(char *buffer, unsigned long address);
=20
 int lookup_symbol_name(unsigned long addr, char *symname);
 int lookup_symbol_attrs(unsigned long addr, unsigned long *size, unsigned =
long *offset, char *modname, char *name);
@@ -149,6 +150,12 @@ static inline int sprint_backtrace(char *buffer, unsig=
ned long addr)
 	return 0;
 }
=20
+static inline int sprint_backtrace_build_id(char *buffer, unsigned long ad=
dr)
+{
+	*buffer =3D '\0';
+	return 0;
+}
+
 static inline int lookup_symbol_name(unsigned long addr, char *symname)
 {
 	return -ERANGE;
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 74e792e0f7b8..b835992e76c2 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -473,6 +473,26 @@ int sprint_backtrace(char *buffer, unsigned long addre=
ss)
 	return __sprint_symbol(buffer, address, -1, 1, 0);
 }
=20
+/**
+ * sprint_backtrace_build_id - Look up a backtrace symbol and return it in=
 a text buffer
+ * @buffer: buffer to be stored
+ * @address: address to lookup
+ *
+ * This function is for stack backtrace and does the same thing as
+ * sprint_symbol() but with modified/decreased @address. If there is a
+ * tail-call to the function marked "noreturn", gcc optimized out code aft=
er
+ * the call so that the stack-saved return address could point outside of =
the
+ * caller. This function ensures that kallsyms will find the original call=
er
+ * by decreasing @address. This function also appends the module build ID =
to
+ * the @buffer if @address is within a kernel module.
+ *
+ * This function returns the number of bytes stored in @buffer.
+ */
+int sprint_backtrace_build_id(char *buffer, unsigned long address)
+{
+	return __sprint_symbol(buffer, address, -1, 1, 1);
+}
+
 /* To avoid using get_symbol_offset for every symbol, we carry prefix alon=
g. */
 struct kallsym_iter {
 	loff_t pos;
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 91a70125148c..571f9aa74b89 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -966,7 +966,9 @@ char *symbol_string(char *buf, char *end, void *ptr,
 	value =3D (unsigned long)ptr;
=20
 #ifdef CONFIG_KALLSYMS
-	if (*fmt =3D=3D 'B')
+	if (*fmt =3D=3D 'B' && fmt[1] =3D=3D 'b')
+		sprint_backtrace_build_id(sym, value);
+	else if (*fmt =3D=3D 'B')
 		sprint_backtrace(sym, value);
 	else if (*fmt =3D=3D 'S' && (fmt[1] =3D=3D 'b' || (fmt[1] =3D=3D 'R' && f=
mt[2] =3D=3D 'b')))
 		sprint_symbol_build_id(sym, value);
