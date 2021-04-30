Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286E136F424
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 04:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhD3Csf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 22:48:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:45916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229591AbhD3Cse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 22:48:34 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4CF561406;
        Fri, 30 Apr 2021 02:47:44 +0000 (UTC)
Date:   Thu, 29 Apr 2021 22:47:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, peterz@infradead.org, jpoimboe@redhat.com,
        jbaron@akamai.com, ardb@kernel.org,
        Atish Patra <Atish.Patra@wdc.com>,
        Anup Patel <Anup.Patel@wdc.com>, akpm@linux-foundation.org,
        rppt@kernel.org, mhiramat@kernel.org, zong.li@sifive.com,
        guoren@linux.alibaba.com, wangkefeng.wang@huawei.com,
        0x7f454c46@gmail.com, chenhuang5@huawei.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: Re: [PATCH] RISC-V: insn: Use a raw spinlock to protect TEXT_POKE*
Message-ID: <20210429224742.391154ae@oasis.local.home>
In-Reply-To: <20210429215451.yuey5gzmfh2dkzp5@mail.google.com>
References: <20210429061713.783628-1-palmer@dabbelt.com>
        <20210429123007.5144fc0d@gandalf.local.home>
        <20210429215451.yuey5gzmfh2dkzp5@mail.google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Apr 2021 05:54:51 +0800
Changbin Du <changbin.du@gmail.com> wrote:

> The problem is that lockdep cannot handle locks across tasks since we use
> stopmachine to patch code for risc-v. So there's a false positive report.
> See privious disscussion here:

> https://lkml.org/lkml/2021/4/29/63

Please use lore.kernel.org, lkml.org is highly unreliable, and is
considered deprecated for use of referencing linux kernel archives.

Would the following patch work?

(note, I did not even compile test it)

-- Steve

diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index 845002cc2e57..19acbb4aaeff 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -25,6 +25,8 @@ struct dyn_arch_ftrace {
 };
 #endif
 
+extern int running_ftrace;
+
 #ifdef CONFIG_DYNAMIC_FTRACE
 /*
  * A general call in RISC-V is a pair of insts:
diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index 7f1e5203de88..834ab4fad637 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -11,15 +11,19 @@
 #include <asm/cacheflush.h>
 #include <asm/patch.h>
 
+int running_ftrace;
+
 #ifdef CONFIG_DYNAMIC_FTRACE
 int ftrace_arch_code_modify_prepare(void) __acquires(&text_mutex)
 {
 	mutex_lock(&text_mutex);
+	running_ftrace = 1;
 	return 0;
 }
 
 int ftrace_arch_code_modify_post_process(void) __releases(&text_mutex)
 {
+	running_ftrace = 0;
 	mutex_unlock(&text_mutex);
 	return 0;
 }
diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index 0b552873a577..4cd1c79a9689 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -12,6 +12,7 @@
 #include <asm/cacheflush.h>
 #include <asm/fixmap.h>
 #include <asm/patch.h>
+#include <asm/ftrace.h>
 
 struct patch_insn {
 	void *addr;
@@ -59,8 +60,13 @@ static int patch_insn_write(void *addr, const void *insn, size_t len)
 	 * Before reaching here, it was expected to lock the text_mutex
 	 * already, so we don't need to give another lock here and could
 	 * ensure that it was safe between each cores.
+	 *
+	 * ftrace uses stop machine, and even though the text_mutex is
+	 * held, the stop machine task that calls this function will not
+	 * be the owner.
 	 */
-	lockdep_assert_held(&text_mutex);
+	if (!running_ftrace)
+		lockdep_assert_held(&text_mutex);
 
 	if (across_pages)
 		patch_map(addr + len, FIX_TEXT_POKE1);
