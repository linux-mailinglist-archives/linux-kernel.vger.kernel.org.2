Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2EF32A0AA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576315AbhCBE1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:27:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:37564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235967AbhCBBQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 20:16:20 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4367860C41;
        Tue,  2 Mar 2021 01:15:28 +0000 (UTC)
Date:   Mon, 1 Mar 2021 20:15:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [x86, build] 6dafca9780:
 WARNING:at_arch/x86/kernel/ftrace.c:#ftrace_verify_code
Message-ID: <20210301201526.65ce7f1c@oasis.local.home>
In-Reply-To: <CABCJKudQme=bcNJtNCORUpBnVA_Pkr2Zk_3Nu2EsfnuoE7LJ3g@mail.gmail.com>
References: <20210301074027.GD12822@xsang-OptiPlex-9020>
        <CABCJKuc8H83b_8_Ccp+Cb7O9x5oEu6sPNq63sjGcAJcgiwy0bw@mail.gmail.com>
        <20210301184524.7aa05ac1@gandalf.local.home>
        <CABCJKudQme=bcNJtNCORUpBnVA_Pkr2Zk_3Nu2EsfnuoE7LJ3g@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Mar 2021 16:03:51 -0800
Sami Tolvanen <samitolvanen@google.com> wrote:
> 
> >                 ret = ftrace_verify_code(rec->ip, old);
> > +
> > +               if (__is_defined(CC_USING_NOP_MCOUNT) && ret && old_nop) {
> > +                       /* Compiler could have put in P6_NOP5 */
> > +                       old = P6_NOP5;
> > +                       ret = ftrace_verify_code(rec->ip, old);
> > +               }
> > +  
> 
> Wouldn't that still hit WARN(1) in the initial ftrace_verify_code()
> call if ideal_nops doesn't match?

That was too quickly written ;-)

Take 2:

[ with fixes for setting p6_nop ]

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 7edbd5ee5ed4..e8afc765e00a 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -36,6 +36,7 @@
 #ifdef CONFIG_DYNAMIC_FTRACE
 
 static int ftrace_poke_late = 0;
+static const char p6_nop[] = { P6_NOP5 };
 
 int ftrace_arch_code_modify_prepare(void)
     __acquires(&text_mutex)
@@ -74,7 +75,7 @@ static const char *ftrace_call_replace(unsigned long ip, unsigned long addr)
 	return text_gen_insn(CALL_INSN_OPCODE, (void *)ip, (void *)addr);
 }
 
-static int ftrace_verify_code(unsigned long ip, const char *old_code)
+static int ftrace_verify_code(unsigned long ip, const char *old_code, bool warn)
 {
 	char cur_code[MCOUNT_INSN_SIZE];
 
@@ -87,13 +88,13 @@ static int ftrace_verify_code(unsigned long ip, const char *old_code)
 	 */
 	/* read the text we want to modify */
 	if (copy_from_kernel_nofault(cur_code, (void *)ip, MCOUNT_INSN_SIZE)) {
-		WARN_ON(1);
+		WARN_ON(warn);
 		return -EFAULT;
 	}
 
 	/* Make sure it is what we expect it to be */
 	if (memcmp(cur_code, old_code, MCOUNT_INSN_SIZE) != 0) {
-		WARN_ON(1);
+		WARN_ON(warn);
 		return -EINVAL;
 	}
 
@@ -107,9 +108,9 @@ static int ftrace_verify_code(unsigned long ip, const char *old_code)
  */
 static int __ref
 ftrace_modify_code_direct(unsigned long ip, const char *old_code,
-			  const char *new_code)
+			  const char *new_code, bool verify_warn)
 {
-	int ret = ftrace_verify_code(ip, old_code);
+	int ret = ftrace_verify_code(ip, old_code, verify_warn);
 	if (ret)
 		return ret;
 
@@ -138,7 +139,7 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec, unsigned long ad
 	 * just modify the code directly.
 	 */
 	if (addr == MCOUNT_ADDR)
-		return ftrace_modify_code_direct(ip, old, new);
+		return ftrace_modify_code_direct(ip, old, new, true);
 
 	/*
 	 * x86 overrides ftrace_replace_code -- this function will never be used
@@ -152,12 +153,20 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 {
 	unsigned long ip = rec->ip;
 	const char *new, *old;
+	bool verify_warn = !__is_defined(CC_USING_NOP_MCOUNT);
+	int ret;
 
 	old = ftrace_nop_replace();
 	new = ftrace_call_replace(ip, addr);
 
 	/* Should only be called when module is loaded */
-	return ftrace_modify_code_direct(rec->ip, old, new);
+	ret = ftrace_modify_code_direct(rec->ip, old, new, verify_warn);
+	if (ret && !verify_warn) {
+		/* Compiler could have put in P6_NOP5 */
+		old = p6_nop;
+		ret = ftrace_modify_code_direct(rec->ip, old, new, true);
+	}
+	return ret;
 }
 
 /*
@@ -199,6 +208,8 @@ void ftrace_replace_code(int enable)
 	int ret;
 
 	for_ftrace_rec_iter(iter) {
+		bool verify_warn = true;
+
 		rec = ftrace_rec_iter_record(iter);
 
 		switch (ftrace_test_record(rec, enable)) {
@@ -208,6 +219,7 @@ void ftrace_replace_code(int enable)
 
 		case FTRACE_UPDATE_MAKE_CALL:
 			old = ftrace_nop_replace();
+			verify_warn = !__is_defined(CC_USING_NOP_MCOUNT);
 			break;
 
 		case FTRACE_UPDATE_MODIFY_CALL:
@@ -216,7 +228,14 @@ void ftrace_replace_code(int enable)
 			break;
 		}
 
-		ret = ftrace_verify_code(rec->ip, old);
+		ret = ftrace_verify_code(rec->ip, old, verify_warn);
+
+		if (ret && !verify_warn) {
+			/* Compiler could have put in P6_NOP5 */
+			old = p6_nop;
+			ret = ftrace_verify_code(rec->ip, old, true);
+		}
+
 		if (ret) {
 			ftrace_bug(ret, rec);
 			return;


-- Steve
