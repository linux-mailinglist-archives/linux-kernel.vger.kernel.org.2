Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEA232A067
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345194AbhCBESE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:18:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:34992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346390AbhCAXqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 18:46:15 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4C80601FE;
        Mon,  1 Mar 2021 23:45:25 +0000 (UTC)
Date:   Mon, 1 Mar 2021 18:45:24 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [x86, build] 6dafca9780:
 WARNING:at_arch/x86/kernel/ftrace.c:#ftrace_verify_code
Message-ID: <20210301184524.7aa05ac1@gandalf.local.home>
In-Reply-To: <CABCJKuc8H83b_8_Ccp+Cb7O9x5oEu6sPNq63sjGcAJcgiwy0bw@mail.gmail.com>
References: <20210301074027.GD12822@xsang-OptiPlex-9020>
        <CABCJKuc8H83b_8_Ccp+Cb7O9x5oEu6sPNq63sjGcAJcgiwy0bw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Mar 2021 14:14:51 -0800
Sami Tolvanen <samitolvanen@google.com> wrote:

> Basically, the problem is that ftrace_replace_code() expects to find
> ideal_nops[NOP_ATOMIC5] here, which in this case is 66:66:66:66:90,
> while objtool has replaced the __fentry__ call with 0f:1f:44:00:00.
> 
> As ideal_nops changes depending on kernel config and hardware, when
> CC_USING_NOP_MCOUNT is defined we could either change
> ftrace_nop_replace() to always use P6_NOP5, or skip
> ftrace_verify_code() in ftrace_replace_code() for
> FTRACE_UPDATE_MAKE_CALL.

So I hacked up the code to get -mnop-record to work on x86, and checked the
vmlinux and it gives me:

ffffffff81bc6120 <schedule>:
ffffffff81bc6120:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
ffffffff81bc6125:       55                      push   %rbp
ffffffff81bc6126:       65 48 8b 2c 25 c0 7d 01 00      mov    %gs:0x17dc0,%rbp ffffffff81bc612b: R_X86_64_32S  current_task
ffffffff81bc612f:       53                      push   %rbx
ffffffff81bc6130:       48 8b 45 18             mov    0x18(%rbp),%rax


Which is the 0f:1f:44:00:00, and it works fine for me.

Now, that could be because the ideal_nops[NOP_ATOMIC5] is the same, which
would explain this.

No, we should *not* change ftrace_nop_replace() to always use any P6_NOP5,
as there was a reason we did this. Because not all nops are the same, and
this gets called for *every* function that is traced.

No, we should not skip ftrace_verify_code() *ever*. (/me was just
referencing on twitter the scenario where ftrace bricked e1000e cards).

This is probably why I never was much for the compiler conversion into nops,
because it may chose the wrong one for the architecture.

What we could do, is if the nop chosen by the compiler is not the ideal
nop, to go back and modify all the nops added by the compiler to the ideal
one, which would keep it using the most efficient one.

Or, add something like this:

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 7edbd5ee5ed4..aef3ea53f931 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -152,12 +152,19 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 {
 	unsigned long ip = rec->ip;
 	const char *new, *old;
+	int ret;
 
 	old = ftrace_nop_replace();
 	new = ftrace_call_replace(ip, addr);
 
 	/* Should only be called when module is loaded */
-	return ftrace_modify_code_direct(rec->ip, old, new);
+	ret = ftrace_modify_code_direct(rec->ip, old, new);
+	if (__is_defined(CC_USING_NOP_MCOUNT) && ret) {
+		/* Compiler could have put in P6_NOP5 */
+		old = P6_NOP5;
+		ret = ftrace_modify_code_direct(rec->ip, old, new);
+	}
+	return ret;
 }
 
 /*
@@ -199,6 +206,8 @@ void ftrace_replace_code(int enable)
 	int ret;
 
 	for_ftrace_rec_iter(iter) {
+		bool old_nop = false;
+
 		rec = ftrace_rec_iter_record(iter);
 
 		switch (ftrace_test_record(rec, enable)) {
@@ -208,6 +217,7 @@ void ftrace_replace_code(int enable)
 
 		case FTRACE_UPDATE_MAKE_CALL:
 			old = ftrace_nop_replace();
+			old_nop = true;
 			break;
 
 		case FTRACE_UPDATE_MODIFY_CALL:
@@ -217,6 +227,13 @@ void ftrace_replace_code(int enable)
 		}
 
 		ret = ftrace_verify_code(rec->ip, old);
+
+		if (__is_defined(CC_USING_NOP_MCOUNT) && ret && old_nop) {
+			/* Compiler could have put in P6_NOP5 */
+			old = P6_NOP5;
+			ret = ftrace_verify_code(rec->ip, old);
+		}
+
 		if (ret) {
 			ftrace_bug(ret, rec);
 			return;


-- Steve
