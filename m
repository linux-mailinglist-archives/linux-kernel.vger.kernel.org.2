Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D724332630B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 14:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbhBZNCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 08:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbhBZNC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 08:02:29 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C17C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 05:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PBW5fMqZ9FXtb+KEYMN/Tp/F1Q20wNnE/zJHQRqGU5w=; b=f8CNU9dI8nvDbS+/Ejisokqg3B
        0tYIw8iSJG0Jv6yDJyqKr3sOHUSSD1cVI1u1JK28XuFl+WjdUfVe0jobUEJ0/56Iwc4eB39khSdqr
        r5m0p91+z7i5NWjNRN22QOq0VWiQn8NUrx1CKSsCR74MtIMFRTfF/7ZTXKzqMl+e4OViI1zjJ3yiy
        Ap5Jj2tQdvtgDOYXtMciOZl84ZGWzrYZfE6lVExVswYbNyrMvhqAdohn9nFaZT26SJsxPqXg6898l
        Z4OAYUtv1fOM5/lc9qZJSEpCfBJNxguStSUXpCoHzpB9hT93tkKHMRXDxLKM7s+P5f48RzVX4BfAc
        Y3vFjcow==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lFckV-0007kT-Au; Fri, 26 Feb 2021 13:01:40 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0621F9864D3; Fri, 26 Feb 2021 13:27:22 +0100 (CET)
Date:   Fri, 26 Feb 2021 13:27:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     bp@alien8.de, jpoimboe@redhat.com, mbenes@suze.cz
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 0/3] objtool: OBJTOOL_ARGS and --backup
Message-ID: <20210226122722.GI4746@worktop.programming.kicks-ass.net>
References: <20210226105742.844988140@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226105742.844988140@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 11:57:42AM +0100, Peter Zijlstra wrote:
> Boris asked for an environment variable to have objtool preserve the original
> object file so that it becomes trivial to inspect what actually changed.

As illustration on my objtool/core + objtool/retpoline branches.

---
$ cat objdiff.sh
#!/bin/bash

name=$1
pre=${name}bj
post=${name}

function to_text {
        obj=$1
        ( objdump -wdr $obj; readelf -W --relocs --symbols $obj ) > ${obj}.tmp
}

to_text $pre
to_text $post

diff -u ${pre}.tmp ${post}.tmp

rm ${pre}.tmp ${post}.tmp
$ OBJTOOL_ARGS="--backup" make O=defconfig-build kernel/sched/core.o
$ ./objdiff.sh defconfig-build/kernel/sched/core.o
--- defconfig-build/kernel/sched/core.obj.tmp	2021-02-26 13:16:29.590845671 +0100
+++ defconfig-build/kernel/sched/core.o.tmp	2021-02-26 13:16:29.633845674 +0100
@@ -1,5 +1,5 @@
 
-defconfig-build/kernel/sched/core.obj:     file format elf64-x86-64
+defconfig-build/kernel/sched/core.o:     file format elf64-x86-64
 
 
 Disassembly of section .text:
@@ -15,7 +15,8 @@
       14:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
       18:	48 83 c3 18          	add    $0x18,%rbx
       1c:	48 89 ee             	mov    %rbp,%rsi
-      1f:	e8 00 00 00 00       	callq  24 <__traceiter_sched_kthread_stop+0x24>	20: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+      1f:	ff d0                	callq  *%rax	20: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+      21:	0f 1f 00             	nopl   (%rax)
       24:	48 8b 03             	mov    (%rbx),%rax
       27:	48 85 c0             	test   %rax,%rax
       2a:	75 e8                	jne    14 <__traceiter_sched_kthread_stop+0x14>
@@ -37,7 +38,8 @@
       53:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
       57:	48 83 c3 18          	add    $0x18,%rbx
       5b:	89 ee                	mov    %ebp,%esi
-      5d:	e8 00 00 00 00       	callq  62 <__traceiter_sched_kthread_stop_ret+0x22>	5e: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+      5d:	ff d0                	callq  *%rax	5e: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+      5f:	0f 1f 00             	nopl   (%rax)
       62:	48 8b 03             	mov    (%rbx),%rax
       65:	48 85 c0             	test   %rax,%rax
       68:	75 e9                	jne    53 <__traceiter_sched_kthread_stop_ret+0x13>
@@ -61,7 +63,8 @@
       8d:	48 83 c3 18          	add    $0x18,%rbx
       91:	4c 89 e2             	mov    %r12,%rdx
       94:	48 89 ee             	mov    %rbp,%rsi
-      97:	e8 00 00 00 00       	callq  9c <__traceiter_sched_kthread_work_queue_work+0x2c>	98: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+      97:	ff d0                	callq  *%rax	98: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+      99:	0f 1f 00             	nopl   (%rax)
       9c:	48 8b 03             	mov    (%rbx),%rax
       9f:	48 85 c0             	test   %rax,%rax
       a2:	75 e5                	jne    89 <__traceiter_sched_kthread_work_queue_work+0x19>
@@ -83,7 +86,8 @@
       c4:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
       c8:	48 83 c3 18          	add    $0x18,%rbx
       cc:	48 89 ee             	mov    %rbp,%rsi
-      cf:	e8 00 00 00 00       	callq  d4 <__traceiter_sched_kthread_work_execute_start+0x24>	d0: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+      cf:	ff d0                	callq  *%rax	d0: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+      d1:	0f 1f 00             	nopl   (%rax)
       d4:	48 8b 03             	mov    (%rbx),%rax
       d7:	48 85 c0             	test   %rax,%rax
       da:	75 e8                	jne    c4 <__traceiter_sched_kthread_work_execute_start+0x14>
@@ -108,7 +112,8 @@
      10d:	48 83 c3 18          	add    $0x18,%rbx
      111:	4c 89 e2             	mov    %r12,%rdx
      114:	48 89 ee             	mov    %rbp,%rsi
-     117:	e8 00 00 00 00       	callq  11c <__traceiter_sched_kthread_work_execute_end+0x2c>	118: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+     117:	ff d0                	callq  *%rax	118: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+     119:	0f 1f 00             	nopl   (%rax)
      11c:	48 8b 03             	mov    (%rbx),%rax
      11f:	48 85 c0             	test   %rax,%rax
      122:	75 e5                	jne    109 <__traceiter_sched_kthread_work_execute_end+0x19>
@@ -130,7 +135,8 @@
      144:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
      148:	48 83 c3 18          	add    $0x18,%rbx
      14c:	48 89 ee             	mov    %rbp,%rsi
-     14f:	e8 00 00 00 00       	callq  154 <__traceiter_sched_waking+0x24>	150: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+     14f:	ff d0                	callq  *%rax	150: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+     151:	0f 1f 00             	nopl   (%rax)
      154:	48 8b 03             	mov    (%rbx),%rax
      157:	48 85 c0             	test   %rax,%rax
      15a:	75 e8                	jne    144 <__traceiter_sched_waking+0x14>
@@ -152,7 +158,8 @@
      184:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
      188:	48 83 c3 18          	add    $0x18,%rbx
      18c:	48 89 ee             	mov    %rbp,%rsi
-     18f:	e8 00 00 00 00       	callq  194 <__traceiter_sched_wakeup+0x24>	190: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+     18f:	ff d0                	callq  *%rax	190: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+     191:	0f 1f 00             	nopl   (%rax)
      194:	48 8b 03             	mov    (%rbx),%rax
      197:	48 85 c0             	test   %rax,%rax
      19a:	75 e8                	jne    184 <__traceiter_sched_wakeup+0x14>
@@ -174,7 +181,8 @@
      1c4:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
      1c8:	48 83 c3 18          	add    $0x18,%rbx
      1cc:	48 89 ee             	mov    %rbp,%rsi
-     1cf:	e8 00 00 00 00       	callq  1d4 <__traceiter_sched_wakeup_new+0x24>	1d0: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+     1cf:	ff d0                	callq  *%rax	1d0: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+     1d1:	0f 1f 00             	nopl   (%rax)
      1d4:	48 8b 03             	mov    (%rbx),%rax
      1d7:	48 85 c0             	test   %rax,%rax
      1da:	75 e8                	jne    1c4 <__traceiter_sched_wakeup_new+0x14>
@@ -202,7 +210,8 @@
      217:	4c 89 e9             	mov    %r13,%rcx
      21a:	4c 89 e2             	mov    %r12,%rdx
      21d:	89 ee                	mov    %ebp,%esi
-     21f:	e8 00 00 00 00       	callq  224 <__traceiter_sched_switch+0x34>	220: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+     21f:	ff d0                	callq  *%rax	220: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+     221:	0f 1f 00             	nopl   (%rax)
      224:	48 8b 03             	mov    (%rbx),%rax
      227:	48 85 c0             	test   %rax,%rax
      22a:	75 e3                	jne    20f <__traceiter_sched_switch+0x1f>
@@ -228,7 +237,8 @@
      25d:	48 83 c3 18          	add    $0x18,%rbx
      261:	44 89 e2             	mov    %r12d,%edx
      264:	48 89 ee             	mov    %rbp,%rsi
-     267:	e8 00 00 00 00       	callq  26c <__traceiter_sched_migrate_task+0x2c>	268: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+     267:	ff d0                	callq  *%rax	268: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+     269:	0f 1f 00             	nopl   (%rax)
      26c:	48 8b 03             	mov    (%rbx),%rax
      26f:	48 85 c0             	test   %rax,%rax
      272:	75 e5                	jne    259 <__traceiter_sched_migrate_task+0x19>
@@ -250,7 +260,8 @@
      294:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
      298:	48 83 c3 18          	add    $0x18,%rbx
      29c:	48 89 ee             	mov    %rbp,%rsi
-     29f:	e8 00 00 00 00       	callq  2a4 <__traceiter_sched_process_free+0x24>	2a0: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+     29f:	ff d0                	callq  *%rax	2a0: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+     2a1:	0f 1f 00             	nopl   (%rax)
      2a4:	48 8b 03             	mov    (%rbx),%rax
      2a7:	48 85 c0             	test   %rax,%rax
      2aa:	75 e8                	jne    294 <__traceiter_sched_process_free+0x14>
@@ -272,7 +283,8 @@
      2d4:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
      2d8:	48 83 c3 18          	add    $0x18,%rbx
      2dc:	48 89 ee             	mov    %rbp,%rsi
-     2df:	e8 00 00 00 00       	callq  2e4 <__traceiter_sched_process_exit+0x24>	2e0: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+     2df:	ff d0                	callq  *%rax	2e0: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+     2e1:	0f 1f 00             	nopl   (%rax)
      2e4:	48 8b 03             	mov    (%rbx),%rax
      2e7:	48 85 c0             	test   %rax,%rax
      2ea:	75 e8                	jne    2d4 <__traceiter_sched_process_exit+0x14>
@@ -294,7 +306,8 @@
      314:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
      318:	48 83 c3 18          	add    $0x18,%rbx
      31c:	48 89 ee             	mov    %rbp,%rsi
-     31f:	e8 00 00 00 00       	callq  324 <__traceiter_sched_wait_task+0x24>	320: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+     31f:	ff d0                	callq  *%rax	320: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+     321:	0f 1f 00             	nopl   (%rax)
      324:	48 8b 03             	mov    (%rbx),%rax
      327:	48 85 c0             	test   %rax,%rax
      32a:	75 e8                	jne    314 <__traceiter_sched_wait_task+0x14>
@@ -316,7 +329,8 @@
      354:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
      358:	48 83 c3 18          	add    $0x18,%rbx
      35c:	48 89 ee             	mov    %rbp,%rsi
-     35f:	e8 00 00 00 00       	callq  364 <__traceiter_sched_process_wait+0x24>	360: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+     35f:	ff d0                	callq  *%rax	360: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+     361:	0f 1f 00             	nopl   (%rax)
      364:	48 8b 03             	mov    (%rbx),%rax
      367:	48 85 c0             	test   %rax,%rax
      36a:	75 e8                	jne    354 <__traceiter_sched_process_wait+0x14>
@@ -341,7 +355,8 @@
      39d:	48 83 c3 18          	add    $0x18,%rbx
      3a1:	4c 89 e2             	mov    %r12,%rdx
      3a4:	48 89 ee             	mov    %rbp,%rsi
-     3a7:	e8 00 00 00 00       	callq  3ac <__traceiter_sched_process_fork+0x2c>	3a8: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+     3a7:	ff d0                	callq  *%rax	3a8: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+     3a9:	0f 1f 00             	nopl   (%rax)
      3ac:	48 8b 03             	mov    (%rbx),%rax
      3af:	48 85 c0             	test   %rax,%rax
      3b2:	75 e5                	jne    399 <__traceiter_sched_process_fork+0x19>
@@ -369,7 +384,8 @@
      3e6:	4c 89 e9             	mov    %r13,%rcx
      3e9:	44 89 e2             	mov    %r12d,%edx
      3ec:	48 89 ee             	mov    %rbp,%rsi
-     3ef:	e8 00 00 00 00       	callq  3f4 <__traceiter_sched_process_exec+0x34>	3f0: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+     3ef:	ff d0                	callq  *%rax	3f0: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+     3f1:	0f 1f 00             	nopl   (%rax)
      3f4:	48 8b 03             	mov    (%rbx),%rax
      3f7:	48 85 c0             	test   %rax,%rax
      3fa:	75 e2                	jne    3de <__traceiter_sched_process_exec+0x1e>
@@ -395,7 +411,8 @@
      42d:	48 83 c3 18          	add    $0x18,%rbx
      431:	4c 89 e2             	mov    %r12,%rdx
      434:	48 89 ee             	mov    %rbp,%rsi
-     437:	e8 00 00 00 00       	callq  43c <__traceiter_sched_stat_wait+0x2c>	438: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+     437:	ff d0                	callq  *%rax	438: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+     439:	0f 1f 00             	nopl   (%rax)
      43c:	48 8b 03             	mov    (%rbx),%rax
      43f:	48 85 c0             	test   %rax,%rax
      442:	75 e5                	jne    429 <__traceiter_sched_stat_wait+0x19>
@@ -420,7 +437,8 @@
      46d:	48 83 c3 18          	add    $0x18,%rbx
      471:	4c 89 e2             	mov    %r12,%rdx
      474:	48 89 ee             	mov    %rbp,%rsi
-     477:	e8 00 00 00 00       	callq  47c <__traceiter_sched_stat_sleep+0x2c>	478: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+     477:	ff d0                	callq  *%rax	478: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+     479:	0f 1f 00             	nopl   (%rax)
      47c:	48 8b 03             	mov    (%rbx),%rax
      47f:	48 85 c0             	test   %rax,%rax
      482:	75 e5                	jne    469 <__traceiter_sched_stat_sleep+0x19>
@@ -445,7 +463,8 @@
      4ad:	48 83 c3 18          	add    $0x18,%rbx
      4b1:	4c 89 e2             	mov    %r12,%rdx
      4b4:	48 89 ee             	mov    %rbp,%rsi
-     4b7:	e8 00 00 00 00       	callq  4bc <__traceiter_sched_stat_iowait+0x2c>	4b8: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+     4b7:	ff d0                	callq  *%rax	4b8: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+     4b9:	0f 1f 00             	nopl   (%rax)
      4bc:	48 8b 03             	mov    (%rbx),%rax
      4bf:	48 85 c0             	test   %rax,%rax
      4c2:	75 e5                	jne    4a9 <__traceiter_sched_stat_iowait+0x19>
@@ -470,7 +489,8 @@
      4ed:	48 83 c3 18          	add    $0x18,%rbx
      4f1:	4c 89 e2             	mov    %r12,%rdx
      4f4:	48 89 ee             	mov    %rbp,%rsi
-     4f7:	e8 00 00 00 00       	callq  4fc <__traceiter_sched_stat_blocked+0x2c>	4f8: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+     4f7:	ff d0                	callq  *%rax	4f8: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+     4f9:	0f 1f 00             	nopl   (%rax)
      4fc:	48 8b 03             	mov    (%rbx),%rax
      4ff:	48 85 c0             	test   %rax,%rax
      502:	75 e5                	jne    4e9 <__traceiter_sched_stat_blocked+0x19>
@@ -498,7 +518,8 @@
      536:	4c 89 e9             	mov    %r13,%rcx
      539:	4c 89 e2             	mov    %r12,%rdx
      53c:	48 89 ee             	mov    %rbp,%rsi
-     53f:	e8 00 00 00 00       	callq  544 <__traceiter_sched_stat_runtime+0x34>	540: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+     53f:	ff d0                	callq  *%rax	540: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+     541:	0f 1f 00             	nopl   (%rax)
      544:	48 8b 03             	mov    (%rbx),%rax
      547:	48 85 c0             	test   %rax,%rax
      54a:	75 e2                	jne    52e <__traceiter_sched_stat_runtime+0x1e>
@@ -524,7 +545,8 @@
      57d:	48 83 c3 18          	add    $0x18,%rbx
      581:	4c 89 e2             	mov    %r12,%rdx
      584:	48 89 ee             	mov    %rbp,%rsi
-     587:	e8 00 00 00 00       	callq  58c <__traceiter_sched_pi_setprio+0x2c>	588: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+     587:	ff d0                	callq  *%rax	588: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+     589:	0f 1f 00             	nopl   (%rax)
      58c:	48 8b 03             	mov    (%rbx),%rax
      58f:	48 85 c0             	test   %rax,%rax
      592:	75 e5                	jne    579 <__traceiter_sched_pi_setprio+0x19>
@@ -552,7 +574,8 @@
      5c6:	44 89 e9             	mov    %r13d,%ecx
      5c9:	44 89 e2             	mov    %r12d,%edx
      5cc:	48 89 ee             	mov    %rbp,%rsi
-     5cf:	e8 00 00 00 00       	callq  5d4 <__traceiter_sched_move_numa+0x34>	5d0: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+     5cf:	ff d0                	callq  *%rax	5d0: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+     5d1:	0f 1f 00             	nopl   (%rax)
      5d4:	48 8b 03             	mov    (%rbx),%rax
      5d7:	48 85 c0             	test   %rax,%rax
      5da:	75 e2                	jne    5be <__traceiter_sched_move_numa+0x1e>
@@ -584,7 +607,8 @@
      61e:	4c 89 e9             	mov    %r13,%rcx
      621:	44 89 e2             	mov    %r12d,%edx
      624:	48 89 ee             	mov    %rbp,%rsi
-     627:	e8 00 00 00 00       	callq  62c <__traceiter_sched_stick_numa+0x3c>	628: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+     627:	ff d0                	callq  *%rax	628: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+     629:	0f 1f 00             	nopl   (%rax)
      62c:	48 8b 03             	mov    (%rbx),%rax
      62f:	48 85 c0             	test   %rax,%rax
      632:	75 df                	jne    613 <__traceiter_sched_stick_numa+0x23>
@@ -617,7 +641,8 @@
      66e:	4c 89 e9             	mov    %r13,%rcx
      671:	44 89 e2             	mov    %r12d,%edx
      674:	48 89 ee             	mov    %rbp,%rsi
-     677:	e8 00 00 00 00       	callq  67c <__traceiter_sched_swap_numa+0x3c>	678: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+     677:	ff d0                	callq  *%rax	678: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+     679:	0f 1f 00             	nopl   (%rax)
      67c:	48 8b 03             	mov    (%rbx),%rax
      67f:	48 85 c0             	test   %rax,%rax
      682:	75 df                	jne    663 <__traceiter_sched_swap_numa+0x23>
@@ -641,7 +666,8 @@
      6a3:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
      6a7:	48 83 c3 18          	add    $0x18,%rbx
      6ab:	89 ee                	mov    %ebp,%esi
-     6ad:	e8 00 00 00 00       	callq  6b2 <__traceiter_sched_wake_idle_without_ipi+0x22>	6ae: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+     6ad:	ff d0                	callq  *%rax	6ae: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+     6af:	0f 1f 00             	nopl   (%rax)
      6b2:	48 8b 03             	mov    (%rbx),%rax
      6b5:	48 85 c0             	test   %rax,%rax
      6b8:	75 e9                	jne    6a3 <__traceiter_sched_wake_idle_without_ipi+0x13>
@@ -662,7 +688,8 @@
      6d4:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
      6d8:	48 83 c3 18          	add    $0x18,%rbx
      6dc:	48 89 ee             	mov    %rbp,%rsi
-     6df:	e8 00 00 00 00       	callq  6e4 <__traceiter_pelt_cfs_tp+0x24>	6e0: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+     6df:	ff d0                	callq  *%rax	6e0: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+     6e1:	0f 1f 00             	nopl   (%rax)
      6e4:	48 8b 03             	mov    (%rbx),%rax
      6e7:	48 85 c0             	test   %rax,%rax
      6ea:	75 e8                	jne    6d4 <__traceiter_pelt_cfs_tp+0x14>
@@ -684,7 +711,8 @@
      714:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
      718:	48 83 c3 18          	add    $0x18,%rbx
      71c:	48 89 ee             	mov    %rbp,%rsi
-     71f:	e8 00 00 00 00       	callq  724 <__traceiter_pelt_rt_tp+0x24>	720: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+     71f:	ff d0                	callq  *%rax	720: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+     721:	0f 1f 00             	nopl   (%rax)
      724:	48 8b 03             	mov    (%rbx),%rax
      727:	48 85 c0             	test   %rax,%rax
      72a:	75 e8                	jne    714 <__traceiter_pelt_rt_tp+0x14>
@@ -706,7 +734,8 @@
      754:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
      758:	48 83 c3 18          	add    $0x18,%rbx
      75c:	48 89 ee             	mov    %rbp,%rsi
-     75f:	e8 00 00 00 00       	callq  764 <__traceiter_pelt_dl_tp+0x24>	760: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+     75f:	ff d0                	callq  *%rax	760: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+     761:	0f 1f 00             	nopl   (%rax)
      764:	48 8b 03             	mov    (%rbx),%rax
      767:	48 85 c0             	test   %rax,%rax
      76a:	75 e8                	jne    754 <__traceiter_pelt_dl_tp+0x14>
@@ -728,7 +757,8 @@
      794:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
      798:	48 83 c3 18          	add    $0x18,%rbx
      79c:	48 89 ee             	mov    %rbp,%rsi
-     79f:	e8 00 00 00 00       	callq  7a4 <__traceiter_pelt_thermal_tp+0x24>	7a0: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+     79f:	ff d0                	callq  *%rax	7a0: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+     7a1:	0f 1f 00             	nopl   (%rax)
      7a4:	48 8b 03             	mov    (%rbx),%rax
      7a7:	48 85 c0             	test   %rax,%rax
      7aa:	75 e8                	jne    794 <__traceiter_pelt_thermal_tp+0x14>
@@ -750,7 +780,8 @@
      7d4:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
      7d8:	48 83 c3 18          	add    $0x18,%rbx
      7dc:	48 89 ee             	mov    %rbp,%rsi
-     7df:	e8 00 00 00 00       	callq  7e4 <__traceiter_pelt_irq_tp+0x24>	7e0: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+     7df:	ff d0                	callq  *%rax	7e0: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+     7e1:	0f 1f 00             	nopl   (%rax)
      7e4:	48 8b 03             	mov    (%rbx),%rax
      7e7:	48 85 c0             	test   %rax,%rax
      7ea:	75 e8                	jne    7d4 <__traceiter_pelt_irq_tp+0x14>
@@ -772,7 +803,8 @@
      814:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
      818:	48 83 c3 18          	add    $0x18,%rbx
      81c:	48 89 ee             	mov    %rbp,%rsi
-     81f:	e8 00 00 00 00       	callq  824 <__traceiter_pelt_se_tp+0x24>	820: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+     81f:	ff d0                	callq  *%rax	820: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+     821:	0f 1f 00             	nopl   (%rax)
      824:	48 8b 03             	mov    (%rbx),%rax
      827:	48 85 c0             	test   %rax,%rax
      82a:	75 e8                	jne    814 <__traceiter_pelt_se_tp+0x14>
@@ -794,7 +826,8 @@
      854:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
      858:	48 83 c3 18          	add    $0x18,%rbx
      85c:	48 89 ee             	mov    %rbp,%rsi
-     85f:	e8 00 00 00 00       	callq  864 <__traceiter_sched_cpu_capacity_tp+0x24>	860: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+     85f:	ff d0                	callq  *%rax	860: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+     861:	0f 1f 00             	nopl   (%rax)
      864:	48 8b 03             	mov    (%rbx),%rax
      867:	48 85 c0             	test   %rax,%rax
      86a:	75 e8                	jne    854 <__traceiter_sched_cpu_capacity_tp+0x14>
@@ -819,7 +852,8 @@
      89d:	48 83 c3 18          	add    $0x18,%rbx
      8a1:	89 ea                	mov    %ebp,%edx
      8a3:	4c 89 e6             	mov    %r12,%rsi
-     8a6:	e8 00 00 00 00       	callq  8ab <__traceiter_sched_overutilized_tp+0x2b>	8a7: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+     8a6:	ff d0                	callq  *%rax	8a7: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+     8a8:	0f 1f 00             	nopl   (%rax)
      8ab:	48 8b 03             	mov    (%rbx),%rax
      8ae:	48 85 c0             	test   %rax,%rax
      8b1:	75 e6                	jne    899 <__traceiter_sched_overutilized_tp+0x19>
@@ -841,7 +875,8 @@
      8d4:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
      8d8:	48 83 c3 18          	add    $0x18,%rbx
      8dc:	48 89 ee             	mov    %rbp,%rsi
-     8df:	e8 00 00 00 00       	callq  8e4 <__traceiter_sched_util_est_cfs_tp+0x24>	8e0: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+     8df:	ff d0                	callq  *%rax	8e0: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+     8e1:	0f 1f 00             	nopl   (%rax)
      8e4:	48 8b 03             	mov    (%rbx),%rax
      8e7:	48 85 c0             	test   %rax,%rax
      8ea:	75 e8                	jne    8d4 <__traceiter_sched_util_est_cfs_tp+0x14>
@@ -863,7 +898,8 @@
      914:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
      918:	48 83 c3 18          	add    $0x18,%rbx
      91c:	48 89 ee             	mov    %rbp,%rsi
-     91f:	e8 00 00 00 00       	callq  924 <__traceiter_sched_util_est_se_tp+0x24>	920: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+     91f:	ff d0                	callq  *%rax	920: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+     921:	0f 1f 00             	nopl   (%rax)
      924:	48 8b 03             	mov    (%rbx),%rax
      927:	48 85 c0             	test   %rax,%rax
      92a:	75 e8                	jne    914 <__traceiter_sched_util_est_se_tp+0x14>
@@ -888,7 +924,8 @@
      95d:	48 83 c3 18          	add    $0x18,%rbx
      961:	44 89 e2             	mov    %r12d,%edx
      964:	48 89 ee             	mov    %rbp,%rsi
-     967:	e8 00 00 00 00       	callq  96c <__traceiter_sched_update_nr_running_tp+0x2c>	968: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+     967:	ff d0                	callq  *%rax	968: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+     969:	0f 1f 00             	nopl   (%rax)
      96c:	48 8b 03             	mov    (%rbx),%rax
      96f:	48 85 c0             	test   %rax,%rax
      972:	75 e5                	jne    959 <__traceiter_sched_update_nr_running_tp+0x19>
@@ -929,7 +966,8 @@
      9fc:	c3                   	retq   
      9fd:	48 8b 05 00 00 00 00 	mov    0x0(%rip),%rax        # a04 <kick_process+0x34>	a00: R_X86_64_PC32	smp_ops+0x24
      a04:	44 89 c7             	mov    %r8d,%edi
-     a07:	e8 00 00 00 00       	callq  a0c <kick_process+0x3c>	a08: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+     a07:	ff d0                	callq  *%rax	a08: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+     a09:	0f 1f 00             	nopl   (%rax)
      a0c:	c3                   	retq   
      a0d:	0f 1f 00             	nopl   (%rax)
 
@@ -3508,7 +3546,8 @@
     2f24:	48 85 c0             	test   %rax,%rax
     2f27:	74 08                	je     2f31 <set_rq_offline.part.0+0x31>
     2f29:	48 89 ef             	mov    %rbp,%rdi
-    2f2c:	e8 00 00 00 00       	callq  2f31 <set_rq_offline.part.0+0x31>	2f2d: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    2f2c:	ff d0                	callq  *%rax	2f2d: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    2f2e:	0f 1f 00             	nopl   (%rax)
     2f31:	48 81 eb c8 00 00 00 	sub    $0xc8,%rbx
     2f38:	4c 39 e3             	cmp    %r12,%rbx
     2f3b:	75 e3                	jne    2f20 <set_rq_offline.part.0+0x20>
@@ -3539,7 +3578,8 @@
     2fa1:	48 85 c0             	test   %rax,%rax
     2fa4:	74 08                	je     2fae <set_rq_online.part.0+0x4e>
     2fa6:	48 89 ef             	mov    %rbp,%rdi
-    2fa9:	e8 00 00 00 00       	callq  2fae <set_rq_online.part.0+0x4e>	2faa: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    2fa9:	ff d0                	callq  *%rax	2faa: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    2fab:	0f 1f 00             	nopl   (%rax)
     2fae:	48 81 eb c8 00 00 00 	sub    $0xc8,%rbx
     2fb5:	4c 39 e3             	cmp    %r12,%rbx
     2fb8:	75 e3                	jne    2f9d <set_rq_online.part.0+0x3d>
@@ -3662,7 +3702,8 @@
     3193:	48 8b 1b             	mov    (%rbx),%rbx
     3196:	4c 89 ff             	mov    %r15,%rdi
     3199:	48 c7 02 00 00 00 00 	movq   $0x0,(%rdx)
-    31a0:	e8 00 00 00 00       	callq  31a5 <finish_task_switch.isra.0+0x95>	31a1: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    31a0:	ff d0                	callq  *%rax	31a1: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    31a2:	0f 1f 00             	nopl   (%rax)
     31a5:	48 85 db             	test   %rbx,%rbx
     31a8:	75 e2                	jne    318c <finish_task_switch.isra.0+0x7c>
     31aa:	41 c6 07 00          	movb   $0x0,(%r15)
@@ -3725,7 +3766,8 @@
     32bb:	48 85 c0             	test   %rax,%rax
     32be:	74 08                	je     32c8 <finish_task_switch.isra.0+0x1b8>
     32c0:	4c 89 e7             	mov    %r12,%rdi
-    32c3:	e8 00 00 00 00       	callq  32c8 <finish_task_switch.isra.0+0x1b8>	32c4: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    32c3:	ff d0                	callq  *%rax	32c4: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    32c5:	0f 1f 00             	nopl   (%rax)
     32c8:	4c 89 e7             	mov    %r12,%rdi
     32cb:	e8 00 00 00 00       	callq  32d0 <finish_task_switch.isra.0+0x1c0>	32cc: R_X86_64_PLT32	kprobe_flush_task-0x4
     32d0:	4c 89 e7             	mov    %r12,%rdi
@@ -3779,7 +3821,8 @@
     3380:	48 89 ef             	mov    %rbp,%rdi
     3383:	48 8b 86 80 00 00 00 	mov    0x80(%rsi),%rax
     338a:	48 8b 80 80 00 00 00 	mov    0x80(%rax),%rax
-    3391:	e8 00 00 00 00       	callq  3396 <hrtick+0x56>	3392: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    3391:	ff d0                	callq  *%rax	3392: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    3393:	0f 1f 00             	nopl   (%rax)
     3396:	c6 83 e0 f4 ff ff 00 	movb   $0x0,-0xb20(%rbx)
     339d:	31 c0                	xor    %eax,%eax
     339f:	5b                   	pop    %rbx
@@ -4124,13 +4167,15 @@
     3844:	41 5d                	pop    %r13
     3846:	41 5e                	pop    %r14
     3848:	41 5f                	pop    %r15
-    384a:	e9 00 00 00 00       	jmpq   384f <__do_set_cpus_allowed+0x5f>	384b: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    384a:	ff e0                	jmpq   *%rax	384b: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    384c:	0f 1f 00             	nopl   (%rax)
     384f:	48 8b 87 80 00 00 00 	mov    0x80(%rdi),%rax
     3856:	48 89 fe             	mov    %rdi,%rsi
     3859:	ba 0a 00 00 00       	mov    $0xa,%edx
     385e:	4c 89 e7             	mov    %r12,%rdi
     3861:	48 8b 40 08          	mov    0x8(%rax),%rax
-    3865:	e8 00 00 00 00       	callq  386a <__do_set_cpus_allowed+0x7a>	3866: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    3865:	ff d0                	callq  *%rax	3866: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    3867:	0f 1f 00             	nopl   (%rax)
     386a:	4c 39 fd             	cmp    %r15,%rbp
     386d:	0f 84 87 00 00 00    	je     38fa <__do_set_cpus_allowed+0x10a>
     3873:	48 8b 85 80 00 00 00 	mov    0x80(%rbp),%rax
@@ -4138,7 +4183,8 @@
     387d:	4c 89 ee             	mov    %r13,%rsi
     3880:	48 89 ef             	mov    %rbp,%rdi
     3883:	48 8b 40 60          	mov    0x60(%rax),%rax
-    3887:	e8 00 00 00 00       	callq  388c <__do_set_cpus_allowed+0x9c>	3888: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    3887:	ff d0                	callq  *%rax	3888: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    3889:	0f 1f 00             	nopl   (%rax)
     388c:	48 8b 85 80 00 00 00 	mov    0x80(%rbp),%rax
     3893:	ba 0a 00 00 00       	mov    $0xa,%edx
     3898:	48 89 ee             	mov    %rbp,%rsi
@@ -4149,18 +4195,21 @@
     38a4:	41 5d                	pop    %r13
     38a6:	41 5e                	pop    %r14
     38a8:	41 5f                	pop    %r15
-    38aa:	e9 00 00 00 00       	jmpq   38af <__do_set_cpus_allowed+0xbf>	38ab: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    38aa:	ff e0                	jmpq   *%rax	38ab: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    38ac:	0f 1f 00             	nopl   (%rax)
     38af:	49 8b 87 80 00 00 00 	mov    0x80(%r15),%rax
     38b6:	4c 89 fe             	mov    %r15,%rsi
     38b9:	4c 89 e7             	mov    %r12,%rdi
     38bc:	48 8b 40 30          	mov    0x30(%rax),%rax
-    38c0:	e8 00 00 00 00       	callq  38c5 <__do_set_cpus_allowed+0xd5>	38c1: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    38c0:	ff d0                	callq  *%rax	38c1: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    38c2:	0f 1f 00             	nopl   (%rax)
     38c5:	49 8b 87 80 00 00 00 	mov    0x80(%r15),%rax
     38cc:	44 89 f2             	mov    %r14d,%edx
     38cf:	4c 89 ee             	mov    %r13,%rsi
     38d2:	4c 89 ff             	mov    %r15,%rdi
     38d5:	48 8b 40 60          	mov    0x60(%rax),%rax
-    38d9:	e8 00 00 00 00       	callq  38de <__do_set_cpus_allowed+0xee>	38da: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    38d9:	ff d0                	callq  *%rax	38da: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    38db:	0f 1f 00             	nopl   (%rax)
     38de:	4d 3b bc 24 30 09 00 00 	cmp    0x930(%r12),%r15
     38e6:	75 69                	jne    3951 <__do_set_cpus_allowed+0x161>
     38e8:	49 8b 87 80 00 00 00 	mov    0x80(%r15),%rax
@@ -4175,19 +4224,22 @@
     390d:	4c 89 fe             	mov    %r15,%rsi
     3910:	4c 89 e7             	mov    %r12,%rdi
     3913:	48 8b 40 30          	mov    0x30(%rax),%rax
-    3917:	e8 00 00 00 00       	callq  391c <__do_set_cpus_allowed+0x12c>	3918: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    3917:	ff d0                	callq  *%rax	3918: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    3919:	0f 1f 00             	nopl   (%rax)
     391c:	49 8b 87 80 00 00 00 	mov    0x80(%r15),%rax
     3923:	44 89 f2             	mov    %r14d,%edx
     3926:	4c 89 ee             	mov    %r13,%rsi
     3929:	4c 89 ff             	mov    %r15,%rdi
     392c:	48 8b 40 60          	mov    0x60(%rax),%rax
-    3930:	e8 00 00 00 00       	callq  3935 <__do_set_cpus_allowed+0x145>	3931: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    3930:	ff d0                	callq  *%rax	3931: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    3932:	0f 1f 00             	nopl   (%rax)
     3935:	49 8b 87 80 00 00 00 	mov    0x80(%r15),%rax
     393c:	4c 89 fe             	mov    %r15,%rsi
     393f:	4c 89 e7             	mov    %r12,%rdi
     3942:	ba 0a 00 00 00       	mov    $0xa,%edx
     3947:	48 8b 00             	mov    (%rax),%rax
-    394a:	e8 00 00 00 00       	callq  394f <__do_set_cpus_allowed+0x15f>	394b: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    394a:	ff d0                	callq  *%rax	394b: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    394c:	0f 1f 00             	nopl   (%rax)
     394f:	eb 8d                	jmp    38de <__do_set_cpus_allowed+0xee>
     3951:	0f 0b                	ud2    
     3953:	eb 93                	jmp    38e8 <__do_set_cpus_allowed+0xf8>
@@ -5345,7 +5397,8 @@
     4927:	48 8b 80 80 00 00 00 	mov    0x80(%rax),%rax
     492e:	48 89 df             	mov    %rbx,%rdi
     4931:	48 8b 40 10          	mov    0x10(%rax),%rax
-    4935:	e8 00 00 00 00       	callq  493a <do_sched_yield+0x3a>	4936: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    4935:	ff d0                	callq  *%rax	4936: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    4937:	0f 1f 00             	nopl   (%rax)
     493a:	c6 03 00             	movb   $0x0,(%rbx)
     493d:	fb                   	sti    
     493e:	5b                   	pop    %rbx
@@ -5697,7 +5750,8 @@
     4dcb:	74 0e                	je     4ddb <sched_rr_get_interval+0xab>
     4dcd:	48 89 de             	mov    %rbx,%rsi
     4dd0:	4c 89 ef             	mov    %r13,%rdi
-    4dd3:	e8 00 00 00 00       	callq  4dd8 <sched_rr_get_interval+0xa8>	4dd4: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    4dd3:	ff d0                	callq  *%rax	4dd4: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    4dd5:	0f 1f 00             	nopl   (%rax)
     4dd8:	41 89 c6             	mov    %eax,%r14d
     4ddb:	41 c6 45 00 00       	movb   $0x0,0x0(%r13)
     4de0:	48 8b 34 24          	mov    (%rsp),%rsi
@@ -5894,7 +5948,8 @@
     50bd:	48 89 de             	mov    %rbx,%rsi
     50c0:	4c 89 e7             	mov    %r12,%rdi
     50c3:	48 8b 80 a8 00 00 00 	mov    0xa8(%rax),%rax
-    50ca:	e8 00 00 00 00       	callq  50cf <set_user_nice.part.0+0x11f>	50cb: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    50ca:	ff d0                	callq  *%rax	50cb: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    50cc:	0f 1f 00             	nopl   (%rax)
     50cf:	41 c6 04 24 00       	movb   $0x0,(%r12)
     50d4:	48 8b 34 24          	mov    (%rsp),%rsi
     50d8:	48 8d bb bc 07 00 00 	lea    0x7bc(%rbx),%rdi
@@ -5923,7 +5978,8 @@
     513c:	48 89 de             	mov    %rbx,%rsi
     513f:	4c 89 e7             	mov    %r12,%rdi
     5142:	48 8b 40 08          	mov    0x8(%rax),%rax
-    5146:	e8 00 00 00 00       	callq  514b <set_user_nice.part.0+0x19b>	5147: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    5146:	ff d0                	callq  *%rax	5147: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    5148:	0f 1f 00             	nopl   (%rax)
     514b:	4c 39 f3             	cmp    %r14,%rbx
     514e:	74 55                	je     51a5 <set_user_nice.part.0+0x1f5>
     5150:	8b 83 9c 03 00 00    	mov    0x39c(%rbx),%eax
@@ -5933,7 +5989,8 @@
     5167:	48 89 de             	mov    %rbx,%rsi
     516a:	4c 89 e7             	mov    %r12,%rdi
     516d:	48 8b 00             	mov    (%rax),%rax
-    5170:	e8 00 00 00 00       	callq  5175 <set_user_nice.part.0+0x1c5>	5171: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    5170:	ff d0                	callq  *%rax	5171: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    5172:	0f 1f 00             	nopl   (%rax)
     5175:	4c 39 f3             	cmp    %r14,%rbx
     5178:	0f 85 35 ff ff ff    	jne    50b3 <set_user_nice.part.0+0x103>
     517e:	49 3b 9c 24 30 09 00 00 	cmp    0x930(%r12),%rbx
@@ -5943,7 +6000,8 @@
     5191:	4c 89 f6             	mov    %r14,%rsi
     5194:	4c 89 e7             	mov    %r12,%rdi
     5197:	48 8b 40 38          	mov    0x38(%rax),%rax
-    519b:	e8 00 00 00 00       	callq  51a0 <set_user_nice.part.0+0x1f0>	519c: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    519b:	ff d0                	callq  *%rax	519c: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    519d:	0f 1f 00             	nopl   (%rax)
     51a0:	e9 0e ff ff ff       	jmpq   50b3 <set_user_nice.part.0+0x103>
     51a5:	49 3b 9c 24 30 09 00 00 	cmp    0x930(%r12),%rbx
     51ad:	74 02                	je     51b1 <set_user_nice.part.0+0x201>
@@ -5952,7 +6010,8 @@
     51b8:	4c 89 f6             	mov    %r14,%rsi
     51bb:	4c 89 e7             	mov    %r12,%rdi
     51be:	48 8b 40 30          	mov    0x30(%rax),%rax
-    51c2:	e8 00 00 00 00       	callq  51c7 <set_user_nice.part.0+0x217>	51c3: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    51c2:	ff d0                	callq  *%rax	51c3: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    51c4:	0f 1f 00             	nopl   (%rax)
     51c7:	eb 87                	jmp    5150 <set_user_nice.part.0+0x1a0>
     51c9:	48 89 df             	mov    %rbx,%rdi
     51cc:	e8 00 00 00 00       	callq  51d1 <set_user_nice.part.0+0x221>	51cd: R_X86_64_PLT32	reweight_task-0x4
@@ -6128,7 +6187,8 @@
     540c:	74 39                	je     5447 <cpu_cgroup_fork+0x97>
     540e:	31 f6                	xor    %esi,%esi
     5410:	48 89 df             	mov    %rbx,%rdi
-    5413:	e8 00 00 00 00       	callq  5418 <cpu_cgroup_fork+0x68>	5414: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    5413:	ff d0                	callq  *%rax	5414: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    5415:	0f 1f 00             	nopl   (%rax)
     5418:	c6 45 00 00          	movb   $0x0,0x0(%rbp)
     541c:	48 8b 34 24          	mov    (%rsp),%rsi
     5420:	48 8d bb bc 07 00 00 	lea    0x7bc(%rbx),%rdi
@@ -6353,12 +6413,14 @@
     57e8:	74 12                	je     57fc <__sched_setscheduler+0x35c>
     57ea:	4c 89 f6             	mov    %r14,%rsi
     57ed:	4c 89 e7             	mov    %r12,%rdi
-    57f0:	e8 00 00 00 00       	callq  57f5 <__sched_setscheduler+0x355>	57f1: R_X86_64_PLT32	__x86_indirect_thunk_rdx-0x4
+    57f0:	ff d2                	callq  *%rdx	57f1: R_X86_64_NONE	__x86_indirect_thunk_rdx-0x4
+    57f2:	0f 1f 00             	nopl   (%rax)
     57f5:	49 8b 86 80 00 00 00 	mov    0x80(%r14),%rax
     57fc:	48 8b 80 a0 00 00 00 	mov    0xa0(%rax),%rax
     5803:	4c 89 f6             	mov    %r14,%rsi
     5806:	4c 89 e7             	mov    %r12,%rdi
-    5809:	e8 00 00 00 00       	callq  580e <__sched_setscheduler+0x36e>	580a: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    5809:	ff d0                	callq  *%rax	580a: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    580b:	0f 1f 00             	nopl   (%rax)
     580e:	49 8b ac 24 c0 09 00 00 	mov    0x9c0(%r12),%rbp
     5816:	48 85 ed             	test   %rbp,%rbp
     5819:	74 0c                	je     5827 <__sched_setscheduler+0x387>
@@ -6453,7 +6515,8 @@
     59a8:	48 8b 6d 00          	mov    0x0(%rbp),%rbp
     59ac:	4c 89 e7             	mov    %r12,%rdi
     59af:	48 c7 02 00 00 00 00 	movq   $0x0,(%rdx)
-    59b6:	e8 00 00 00 00       	callq  59bb <__sched_setscheduler+0x51b>	59b7: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    59b6:	ff d0                	callq  *%rax	59b7: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    59b8:	0f 1f 00             	nopl   (%rax)
     59bb:	48 85 ed             	test   %rbp,%rbp
     59be:	75 e1                	jne    59a1 <__sched_setscheduler+0x501>
     59c0:	4c 89 ee             	mov    %r13,%rsi
@@ -6480,7 +6543,8 @@
     5a13:	44 89 4c 24 08       	mov    %r9d,0x8(%rsp)
     5a18:	4c 89 04 24          	mov    %r8,(%rsp)
     5a1c:	48 8b 00             	mov    (%rax),%rax
-    5a1f:	e8 00 00 00 00       	callq  5a24 <__sched_setscheduler+0x584>	5a20: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    5a1f:	ff d0                	callq  *%rax	5a20: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    5a21:	0f 1f 00             	nopl   (%rax)
     5a24:	44 8b 4c 24 08       	mov    0x8(%rsp),%r9d
     5a29:	4c 8b 04 24          	mov    (%rsp),%r8
     5a2d:	e9 93 fd ff ff       	jmpq   57c5 <__sched_setscheduler+0x325>
@@ -6505,7 +6569,8 @@
     5a7b:	44 89 ca             	mov    %r9d,%edx
     5a7e:	4c 89 f6             	mov    %r14,%rsi
     5a81:	4c 89 e7             	mov    %r12,%rdi
-    5a84:	e8 00 00 00 00       	callq  5a89 <__sched_setscheduler+0x5e9>	5a85: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    5a84:	ff d0                	callq  *%rax	5a85: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    5a86:	0f 1f 00             	nopl   (%rax)
     5a89:	e9 80 fd ff ff       	jmpq   580e <__sched_setscheduler+0x36e>
     5a8e:	49 c7 86 c0 00 00 00 00 0c 00 00 	movq   $0xc00,0xc0(%r14)
     5a99:	41 c7 86 c8 00 00 00 55 55 55 55 	movl   $0x55555555,0xc8(%r14)
@@ -6530,7 +6595,8 @@
     5af3:	44 89 54 24 08       	mov    %r10d,0x8(%rsp)
     5af8:	44 89 0c 24          	mov    %r9d,(%rsp)
     5afc:	48 8b 40 08          	mov    0x8(%rax),%rax
-    5b00:	e8 00 00 00 00       	callq  5b05 <__sched_setscheduler+0x665>	5b01: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    5b00:	ff d0                	callq  *%rax	5b01: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    5b02:	0f 1f 00             	nopl   (%rax)
     5b05:	49 39 ee             	cmp    %rbp,%r14
     5b08:	44 8b 0c 24          	mov    (%rsp),%r9d
     5b0c:	44 8b 54 24 08       	mov    0x8(%rsp),%r10d
@@ -6544,7 +6610,8 @@
     5b32:	4c 89 e7             	mov    %r12,%rdi
     5b35:	44 89 0c 24          	mov    %r9d,(%rsp)
     5b39:	48 8b 40 30          	mov    0x30(%rax),%rax
-    5b3d:	e8 00 00 00 00       	callq  5b42 <__sched_setscheduler+0x6a2>	5b3e: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    5b3d:	ff d0                	callq  *%rax	5b3e: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    5b3f:	0f 1f 00             	nopl   (%rax)
     5b42:	44 8b 54 24 08       	mov    0x8(%rsp),%r10d
     5b47:	44 8b 0c 24          	mov    (%rsp),%r9d
     5b4b:	e9 62 fb ff ff       	jmpq   56b2 <__sched_setscheduler+0x212>
@@ -6561,7 +6628,8 @@
     5b7e:	44 89 4c 24 08       	mov    %r9d,0x8(%rsp)
     5b83:	4c 89 e7             	mov    %r12,%rdi
     5b86:	48 8b 40 38          	mov    0x38(%rax),%rax
-    5b8a:	e8 00 00 00 00       	callq  5b8f <__sched_setscheduler+0x6ef>	5b8b: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    5b8a:	ff d0                	callq  *%rax	5b8b: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    5b8c:	0f 1f 00             	nopl   (%rax)
     5b8f:	44 8b 4c 24 08       	mov    0x8(%rsp),%r9d
     5b94:	4c 8b 04 24          	mov    (%rsp),%r8
     5b98:	e9 31 fc ff ff       	jmpq   57ce <__sched_setscheduler+0x32e>
@@ -7155,7 +7223,8 @@
     64b5:	48 8b 87 50 0b 00 00 	mov    0xb50(%rdi),%rax
     64bc:	48 89 f3             	mov    %rsi,%rbx
     64bf:	48 8b 40 30          	mov    0x30(%rax),%rax
-    64c3:	e8 00 00 00 00       	callq  64c8 <hrtick_start+0x18>	64c4: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    64c3:	ff d0                	callq  *%rax	64c4: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    64c5:	0f 1f 00             	nopl   (%rax)
     64c8:	48 81 fb 10 27 00 00 	cmp    $0x2710,%rbx
     64cf:	be 10 27 00 00       	mov    $0x2710,%esi
     64d4:	48 0f 4d f3          	cmovge %rbx,%rsi
@@ -7249,7 +7318,8 @@
     6616:	a9 00 00 20 00       	test   $0x200000,%eax
     661b:	75 3a                	jne    6657 <resched_curr+0x77>
     661d:	48 8b 05 00 00 00 00 	mov    0x0(%rip),%rax        # 6624 <resched_curr+0x44>	6620: R_X86_64_PC32	smp_ops+0x24
-    6624:	e9 00 00 00 00       	jmpq   6629 <resched_curr+0x49>	6625: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    6624:	ff e0                	jmpq   *%rax	6625: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    6626:	0f 1f 00             	nopl   (%rax)
     6629:	65 8b 05 00 00 00 00 	mov    %gs:0x0(%rip),%eax        # 6630 <resched_curr+0x50>	662c: R_X86_64_PC32	cpu_number-0x4
     6630:	89 c0                	mov    %eax,%eax
     6632:	48 0f a3 05 00 00 00 00 	bt     %rax,0x0(%rip)        # 663a <resched_curr+0x5a>	6636: R_X86_64_PC32	__cpu_online_mask-0x4
@@ -7423,7 +7493,8 @@
     6878:	a9 00 00 20 00       	test   $0x200000,%eax
     687d:	75 3a                	jne    68b9 <wake_up_nohz_cpu+0x89>
     687f:	48 8b 05 00 00 00 00 	mov    0x0(%rip),%rax        # 6886 <wake_up_nohz_cpu+0x56>	6882: R_X86_64_PC32	smp_ops+0x24
-    6886:	e9 00 00 00 00       	jmpq   688b <wake_up_nohz_cpu+0x5b>	6887: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    6886:	ff e0                	jmpq   *%rax	6887: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    6888:	0f 1f 00             	nopl   (%rax)
     688b:	65 8b 05 00 00 00 00 	mov    %gs:0x0(%rip),%eax        # 6892 <wake_up_nohz_cpu+0x62>	688e: R_X86_64_PC32	cpu_number-0x4
     6892:	89 c0                	mov    %eax,%eax
     6894:	48 0f a3 05 00 00 00 00 	bt     %rax,0x0(%rip)        # 689c <wake_up_nohz_cpu+0x6c>	6898: R_X86_64_PC32	__cpu_online_mask-0x4
@@ -7454,7 +7525,8 @@
     68d6:	48 89 fb             	mov    %rdi,%rbx
     68d9:	4c 89 f6             	mov    %r14,%rsi
     68dc:	48 89 df             	mov    %rbx,%rdi
-    68df:	e8 00 00 00 00       	callq  68e4 <walk_tg_tree_from+0x24>	68e0: R_X86_64_PLT32	__x86_indirect_thunk_r13-0x4
+    68df:	41 ff d5             	callq  *%r13	68e0: R_X86_64_NONE	__x86_indirect_thunk_r13-0x4
+    68e2:	66 90                	xchg   %ax,%ax
     68e4:	41 89 c7             	mov    %eax,%r15d
     68e7:	85 c0                	test   %eax,%eax
     68e9:	75 3a                	jne    6925 <walk_tg_tree_from+0x65>
@@ -7465,7 +7537,8 @@
     6903:	75 52                	jne    6957 <walk_tg_tree_from+0x97>
     6905:	4c 89 f6             	mov    %r14,%rsi
     6908:	48 89 df             	mov    %rbx,%rdi
-    690b:	e8 00 00 00 00       	callq  6910 <walk_tg_tree_from+0x50>	690c: R_X86_64_PLT32	__x86_indirect_thunk_r12-0x4
+    690b:	41 ff d4             	callq  *%r12	690c: R_X86_64_NONE	__x86_indirect_thunk_r12-0x4
+    690e:	66 90                	xchg   %ax,%ax
     6910:	85 c0                	test   %eax,%eax
     6912:	75 3e                	jne    6952 <walk_tg_tree_from+0x92>
     6914:	48 39 dd             	cmp    %rbx,%rbp
@@ -7515,7 +7588,8 @@
     699a:	48 8b 83 80 00 00 00 	mov    0x80(%rbx),%rax
     69a1:	48 89 de             	mov    %rbx,%rsi
     69a4:	48 8b 00             	mov    (%rax),%rax
-    69a7:	e8 00 00 00 00       	callq  69ac <activate_task+0x3c>	69a8: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    69a7:	ff d0                	callq  *%rax	69a8: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    69a9:	0f 1f 00             	nopl   (%rax)
     69ac:	c7 43 68 01 00 00 00 	movl   $0x1,0x68(%rbx)
     69b3:	48 83 c4 10          	add    $0x10,%rsp
     69b7:	5b                   	pop    %rbx
@@ -7544,7 +7618,8 @@
     69fb:	48 8b 86 80 00 00 00 	mov    0x80(%rsi),%rax
     6a02:	48 8b 40 08          	mov    0x8(%rax),%rax
     6a06:	48 83 c4 18          	add    $0x18,%rsp
-    6a0a:	e9 00 00 00 00       	jmpq   6a0f <deactivate_task+0x2f>	6a0b: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    6a0a:	ff e0                	jmpq   *%rax	6a0b: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    6a0c:	0f 1f 00             	nopl   (%rax)
     6a0f:	f6 87 58 09 00 00 02 	testb  $0x2,0x958(%rdi)
     6a16:	75 de                	jne    69f6 <deactivate_task+0x16>
     6a18:	89 54 24 14          	mov    %edx,0x14(%rsp)
@@ -7604,7 +7679,8 @@
     6af5:	5b                   	pop    %rbx
     6af6:	c3                   	retq   
     6af7:	48 8b 41 20          	mov    0x20(%rcx),%rax
-    6afb:	e8 00 00 00 00       	callq  6b00 <check_preempt_curr+0x50>	6afc: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    6afb:	ff d0                	callq  *%rax	6afc: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    6afd:	0f 1f 00             	nopl   (%rax)
     6b00:	48 8b 83 30 09 00 00 	mov    0x930(%rbx),%rax
     6b07:	83 78 68 01          	cmpl   $0x1,0x68(%rax)
     6b0b:	75 c6                	jne    6ad3 <check_preempt_curr+0x23>
@@ -7625,7 +7701,8 @@
     6b38:	74 0b                	je     6b45 <ttwu_do_wakeup.constprop.0+0x35>
     6b3a:	48 89 ee             	mov    %rbp,%rsi
     6b3d:	48 89 df             	mov    %rbx,%rdi
-    6b40:	e8 00 00 00 00       	callq  6b45 <ttwu_do_wakeup.constprop.0+0x35>	6b41: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    6b40:	ff d0                	callq  *%rax	6b41: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    6b42:	0f 1f 00             	nopl   (%rax)
     6b45:	48 8b 83 c0 0a 00 00 	mov    0xac0(%rbx),%rax
     6b4c:	48 85 c0             	test   %rax,%rax
     6b4f:	74 45                	je     6b96 <ttwu_do_wakeup.constprop.0+0x86>
@@ -7684,7 +7761,8 @@
     6c37:	48 89 ee             	mov    %rbp,%rsi
     6c3a:	4c 89 ef             	mov    %r13,%rdi
     6c3d:	48 8b 00             	mov    (%rax),%rax
-    6c40:	e8 00 00 00 00       	callq  6c45 <ttwu_do_activate.isra.0+0x65>	6c41: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    6c40:	ff d0                	callq  *%rax	6c41: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    6c42:	0f 1f 00             	nopl   (%rax)
     6c45:	c7 45 68 01 00 00 00 	movl   $0x1,0x68(%rbp)
     6c4c:	44 89 e2             	mov    %r12d,%edx
     6c4f:	48 89 ee             	mov    %rbp,%rsi
@@ -7747,7 +7825,8 @@
     6d25:	74 0a                	je     6d31 <set_task_cpu+0x31>
     6d27:	89 ee                	mov    %ebp,%esi
     6d29:	48 89 df             	mov    %rbx,%rdi
-    6d2c:	e8 00 00 00 00       	callq  6d31 <set_task_cpu+0x31>	6d2d: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    6d2c:	ff d0                	callq  *%rax	6d2d: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    6d2e:	0f 1f 00             	nopl   (%rax)
     6d31:	48 83 83 20 01 00 00 01 	addq   $0x1,0x120(%rbx)
     6d39:	48 0f ba ab 60 09 00 00 02 	btsq   $0x2,0x960(%rbx)
     6d42:	48 83 bb 50 09 00 00 00 	cmpq   $0x0,0x950(%rbx)
@@ -7835,7 +7914,8 @@
     6e94:	74 9c                	je     6e32 <push_cpu_stop+0x42>
     6e96:	48 89 de             	mov    %rbx,%rsi
     6e99:	48 89 ef             	mov    %rbp,%rdi
-    6e9c:	e8 00 00 00 00       	callq  6ea1 <push_cpu_stop+0xb1>	6e9d: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    6e9c:	ff d0                	callq  *%rax	6e9d: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    6e9e:	0f 1f 00             	nopl   (%rax)
     6ea1:	49 89 c5             	mov    %rax,%r13
     6ea4:	48 85 c0             	test   %rax,%rax
     6ea7:	74 89                	je     6e32 <push_cpu_stop+0x42>
@@ -7884,7 +7964,8 @@
     6f4d:	48 89 ee             	mov    %rbp,%rsi
     6f50:	48 89 df             	mov    %rbx,%rdi
     6f53:	48 8b 40 08          	mov    0x8(%rax),%rax
-    6f57:	e8 00 00 00 00       	callq  6f5c <push_cpu_stop+0x16c>	6f58: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    6f57:	ff d0                	callq  *%rax	6f58: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    6f59:	0f 1f 00             	nopl   (%rax)
     6f5c:	41 8b b5 10 0a 00 00 	mov    0xa10(%r13),%esi
     6f63:	48 89 ef             	mov    %rbp,%rdi
     6f66:	e8 00 00 00 00       	callq  6f6b <push_cpu_stop+0x17b>	6f67: R_X86_64_PLT32	set_task_cpu-0x4
@@ -7901,7 +7982,8 @@
     6f9f:	31 d2                	xor    %edx,%edx
     6fa1:	48 89 ee             	mov    %rbp,%rsi
     6fa4:	48 8b 00             	mov    (%rax),%rax
-    6fa7:	e8 00 00 00 00       	callq  6fac <push_cpu_stop+0x1bc>	6fa8: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    6fa7:	ff d0                	callq  *%rax	6fa8: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    6fa9:	0f 1f 00             	nopl   (%rax)
     6fac:	c7 45 68 01 00 00 00 	movl   $0x1,0x68(%rbp)
     6fb3:	4c 89 ef             	mov    %r13,%rdi
     6fb6:	e8 00 00 00 00       	callq  6fbb <push_cpu_stop+0x1cb>	6fb7: R_X86_64_PLT32	resched_curr-0x4
@@ -7971,7 +8053,8 @@
     709e:	48 89 df             	mov    %rbx,%rdi
     70a1:	83 ca 08             	or     $0x8,%edx
     70a4:	48 8b 40 48          	mov    0x48(%rax),%rax
-    70a8:	e8 00 00 00 00       	callq  70ad <try_to_wake_up+0xed>	70a9: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    70a8:	ff d0                	callq  *%rax	70a9: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    70aa:	0f 1f 00             	nopl   (%rax)
     70ad:	41 89 c7             	mov    %eax,%r15d
     70b0:	44 89 fe             	mov    %r15d,%esi
     70b3:	48 89 df             	mov    %rbx,%rdi
@@ -8222,7 +8305,8 @@
     74b5:	48 89 ee             	mov    %rbp,%rsi
     74b8:	4c 89 e7             	mov    %r12,%rdi
     74bb:	48 8b 40 08          	mov    0x8(%rax),%rax
-    74bf:	e8 00 00 00 00       	callq  74c4 <move_queued_task.constprop.0+0x64>	74c0: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    74bf:	ff d0                	callq  *%rax	74c0: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    74c1:	0f 1f 00             	nopl   (%rax)
     74c4:	89 de                	mov    %ebx,%esi
     74c6:	48 89 ef             	mov    %rbp,%rdi
     74c9:	e8 00 00 00 00       	callq  74ce <move_queued_task.constprop.0+0x6e>	74ca: R_X86_64_PLT32	set_task_cpu-0x4
@@ -8246,7 +8330,8 @@
     7522:	4c 89 e7             	mov    %r12,%rdi
     7525:	31 d2                	xor    %edx,%edx
     7527:	48 8b 00             	mov    (%rax),%rax
-    752a:	e8 00 00 00 00       	callq  752f <move_queued_task.constprop.0+0xcf>	752b: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    752a:	ff d0                	callq  *%rax	752b: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    752c:	0f 1f 00             	nopl   (%rax)
     752f:	c7 45 68 01 00 00 00 	movl   $0x1,0x68(%rbp)
     7536:	48 89 ee             	mov    %rbp,%rsi
     7539:	4c 89 e7             	mov    %r12,%rdi
@@ -9116,7 +9201,8 @@
     827b:	f7 c2 00 00 20 00    	test   $0x200000,%edx
     8281:	75 dc                	jne    825f <send_call_function_single_ipi+0x1f>
     8283:	48 8b 05 00 00 00 00 	mov    0x0(%rip),%rax        # 828a <send_call_function_single_ipi+0x4a>	8286: R_X86_64_PC32	smp_ops+0x54
-    828a:	e9 00 00 00 00       	jmpq   828f <send_call_function_single_ipi+0x4f>	828b: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    828a:	ff e0                	jmpq   *%rax	828b: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    828c:	0f 1f 00             	nopl   (%rax)
     828f:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
     8294:	c3                   	retq   
     8295:	65 8b 05 00 00 00 00 	mov    %gs:0x0(%rip),%eax        # 829c <send_call_function_single_ipi+0x5c>	8298: R_X86_64_PC32	cpu_number-0x4
@@ -9173,7 +9259,8 @@
     834a:	74 0f                	je     835b <wake_up_if_idle+0x8b>
     834c:	48 8b 05 00 00 00 00 	mov    0x0(%rip),%rax        # 8353 <wake_up_if_idle+0x83>	834f: R_X86_64_PC32	smp_ops+0x24
     8353:	44 89 e7             	mov    %r12d,%edi
-    8356:	e8 00 00 00 00       	callq  835b <wake_up_if_idle+0x8b>	8357: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    8356:	ff d0                	callq  *%rax	8357: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    8358:	0f 1f 00             	nopl   (%rax)
     835b:	4c 89 ee             	mov    %r13,%rsi
     835e:	48 89 ef             	mov    %rbp,%rdi
     8361:	e8 00 00 00 00       	callq  8366 <wake_up_if_idle+0x96>	8362: R_X86_64_PLT32	_raw_spin_unlock_irqrestore-0x4
@@ -9243,7 +9330,8 @@
     8448:	75 0e                	jne    8458 <try_invoke_on_locked_down_task+0x68>
     844a:	4c 89 e6             	mov    %r12,%rsi
     844d:	48 89 ef             	mov    %rbp,%rdi
-    8450:	e8 00 00 00 00       	callq  8455 <try_invoke_on_locked_down_task+0x65>	8451: R_X86_64_PLT32	__x86_indirect_thunk_rbx-0x4
+    8450:	ff d3                	callq  *%rbx	8451: R_X86_64_NONE	__x86_indirect_thunk_rbx-0x4
+    8452:	0f 1f 00             	nopl   (%rax)
     8455:	41 89 c6             	mov    %eax,%r14d
     8458:	48 8b 34 24          	mov    (%rsp),%rsi
     845c:	4c 89 ef             	mov    %r13,%rdi
@@ -9275,7 +9363,8 @@
     84b6:	eb a4                	jmp    845c <try_invoke_on_locked_down_task+0x6c>
     84b8:	4c 89 e6             	mov    %r12,%rsi
     84bb:	48 89 ef             	mov    %rbp,%rdi
-    84be:	e8 00 00 00 00       	callq  84c3 <try_invoke_on_locked_down_task+0xd3>	84bf: R_X86_64_PLT32	__x86_indirect_thunk_rbx-0x4
+    84be:	ff d3                	callq  *%rbx	84bf: R_X86_64_NONE	__x86_indirect_thunk_rbx-0x4
+    84c0:	0f 1f 00             	nopl   (%rax)
     84c3:	41 89 c6             	mov    %eax,%r14d
     84c6:	eb e6                	jmp    84ae <try_invoke_on_locked_down_task+0xbe>
     84c8:	e8 00 00 00 00       	callq  84cd <try_invoke_on_locked_down_task+0xdd>	84c9: R_X86_64_PLT32	__stack_chk_fail-0x4
@@ -9450,7 +9539,8 @@
     8777:	48 85 c0             	test   %rax,%rax
     877a:	74 08                	je     8784 <sched_fork+0x114>
     877c:	48 89 df             	mov    %rbx,%rdi
-    877f:	e8 00 00 00 00       	callq  8784 <sched_fork+0x114>	8780: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    877f:	ff d0                	callq  *%rax	8780: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    8781:	0f 1f 00             	nopl   (%rax)
     8784:	48 89 ee             	mov    %rbp,%rsi
     8787:	4c 89 ff             	mov    %r15,%rdi
     878a:	e8 00 00 00 00       	callq  878f <sched_fork+0x11f>	878b: R_X86_64_PLT32	_raw_spin_unlock_irqrestore-0x4
@@ -9633,7 +9723,8 @@
     8abb:	48 89 ee             	mov    %rbp,%rsi
     8abe:	48 89 df             	mov    %rbx,%rdi
     8ac1:	48 8b 00             	mov    (%rax),%rax
-    8ac4:	e8 00 00 00 00       	callq  8ac9 <wake_up_new_task+0x199>	8ac5: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    8ac4:	ff d0                	callq  *%rax	8ac5: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    8ac6:	0f 1f 00             	nopl   (%rax)
     8ac9:	c7 45 68 01 00 00 00 	movl   $0x1,0x68(%rbp)
     8ad0:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
     8ad5:	ba 04 00 00 00       	mov    $0x4,%edx
@@ -9646,7 +9737,8 @@
     8af3:	74 0b                	je     8b00 <wake_up_new_task+0x1d0>
     8af5:	48 89 ee             	mov    %rbp,%rsi
     8af8:	48 89 df             	mov    %rbx,%rdi
-    8afb:	e8 00 00 00 00       	callq  8b00 <wake_up_new_task+0x1d0>	8afc: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    8afb:	ff d0                	callq  *%rax	8afc: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    8afd:	0f 1f 00             	nopl   (%rax)
     8b00:	c6 03 00             	movb   $0x0,(%rbx)
     8b03:	48 8b 34 24          	mov    (%rsp),%rsi
     8b07:	4c 89 e7             	mov    %r12,%rdi
@@ -9665,7 +9757,8 @@
     8b37:	ba 04 00 00 00       	mov    $0x4,%edx
     8b3c:	48 89 ef             	mov    %rbp,%rdi
     8b3f:	48 8b 40 48          	mov    0x48(%rax),%rax
-    8b43:	e8 00 00 00 00       	callq  8b48 <wake_up_new_task+0x218>	8b44: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    8b43:	ff d0                	callq  *%rax	8b44: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    8b45:	0f 1f 00             	nopl   (%rax)
     8b48:	41 89 c5             	mov    %eax,%r13d
     8b4b:	e9 66 fe ff ff       	jmpq   89b6 <wake_up_new_task+0x86>
     8b50:	65 8b 05 00 00 00 00 	mov    %gs:0x0(%rip),%eax        # 8b57 <wake_up_new_task+0x227>	8b53: R_X86_64_PC32	cpu_number-0x4
@@ -9808,7 +9901,8 @@
     8d3b:	48 89 c5             	mov    %rax,%rbp
     8d3e:	48 8b 83 80 00 00 00 	mov    0x80(%rbx),%rax
     8d45:	48 8b 40 48          	mov    0x48(%rax),%rax
-    8d49:	e8 00 00 00 00       	callq  8d4e <sched_exec+0x4e>	8d4a: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    8d49:	ff d0                	callq  *%rax	8d4a: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    8d4b:	0f 1f 00             	nopl   (%rax)
     8d4e:	65 8b 15 00 00 00 00 	mov    %gs:0x0(%rip),%edx        # 8d55 <sched_exec+0x55>	8d51: R_X86_64_PC32	cpu_number-0x4
     8d55:	39 d0                	cmp    %edx,%eax
     8d57:	74 5c                	je     8db5 <sched_exec+0xb5>
@@ -9894,7 +9988,8 @@
     8e8d:	48 8b 83 80 00 00 00 	mov    0x80(%rbx),%rax
     8e94:	48 89 ef             	mov    %rbp,%rdi
     8e97:	48 8b 80 b8 00 00 00 	mov    0xb8(%rax),%rax
-    8e9e:	e8 00 00 00 00       	callq  8ea3 <task_sched_runtime+0xc3>	8e9f: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    8e9e:	ff d0                	callq  *%rax	8e9f: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    8ea0:	0f 1f 00             	nopl   (%rax)
     8ea3:	eb 99                	jmp    8e3e <task_sched_runtime+0x5e>
     8ea5:	e8 00 00 00 00       	callq  8eaa <task_sched_runtime+0xca>	8ea6: R_X86_64_PLT32	__stack_chk_fail-0x4
     8eaa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
@@ -9923,7 +10018,8 @@
     8f06:	4c 89 ee             	mov    %r13,%rsi
     8f09:	48 89 ef             	mov    %rbp,%rdi
     8f0c:	48 8b 80 80 00 00 00 	mov    0x80(%rax),%rax
-    8f13:	e8 00 00 00 00       	callq  8f18 <scheduler_tick+0x68>	8f14: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    8f13:	ff d0                	callq  *%rax	8f14: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    8f15:	0f 1f 00             	nopl   (%rax)
     8f18:	48 89 ef             	mov    %rbp,%rdi
     8f1b:	e8 00 00 00 00       	callq  8f20 <scheduler_tick+0x70>	8f1c: R_X86_64_PLT32	calc_global_load_tick-0x4
     8f20:	c6 45 00 00          	movb   $0x0,0x0(%rbp)
@@ -10038,12 +10134,14 @@
     90da:	74 13                	je     90ef <rt_mutex_setprio+0x13f>
     90dc:	4c 89 e6             	mov    %r12,%rsi
     90df:	48 89 ef             	mov    %rbp,%rdi
-    90e2:	e8 00 00 00 00       	callq  90e7 <rt_mutex_setprio+0x137>	90e3: R_X86_64_PLT32	__x86_indirect_thunk_rdx-0x4
+    90e2:	ff d2                	callq  *%rdx	90e3: R_X86_64_NONE	__x86_indirect_thunk_rdx-0x4
+    90e4:	0f 1f 00             	nopl   (%rax)
     90e7:	49 8b 84 24 80 00 00 00 	mov    0x80(%r12),%rax
     90ef:	48 8b 80 a0 00 00 00 	mov    0xa0(%rax),%rax
     90f6:	4c 89 e6             	mov    %r12,%rsi
     90f9:	48 89 ef             	mov    %rbp,%rdi
-    90fc:	e8 00 00 00 00       	callq  9101 <rt_mutex_setprio+0x151>	90fd: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    90fc:	ff d0                	callq  *%rax	90fd: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    90fe:	0f 1f 00             	nopl   (%rax)
     9101:	48 8b 9d c0 09 00 00 	mov    0x9c0(%rbp),%rbx
     9108:	48 85 db             	test   %rbx,%rbx
     910b:	74 29                	je     9136 <rt_mutex_setprio+0x186>
@@ -10053,7 +10151,8 @@
     911f:	48 8b 1b             	mov    (%rbx),%rbx
     9122:	48 89 ef             	mov    %rbp,%rdi
     9125:	48 c7 02 00 00 00 00 	movq   $0x0,(%rdx)
-    912c:	e8 00 00 00 00       	callq  9131 <rt_mutex_setprio+0x181>	912d: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    912c:	ff d0                	callq  *%rax	912d: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    912e:	0f 1f 00             	nopl   (%rax)
     9131:	48 85 db             	test   %rbx,%rbx
     9134:	75 e2                	jne    9118 <rt_mutex_setprio+0x168>
     9136:	c6 45 00 00          	movb   $0x0,0x0(%rbp)
@@ -10098,14 +10197,16 @@
     91d1:	44 89 f2             	mov    %r14d,%edx
     91d4:	4c 89 e6             	mov    %r12,%rsi
     91d7:	48 89 ef             	mov    %rbp,%rdi
-    91da:	e8 00 00 00 00       	callq  91df <rt_mutex_setprio+0x22f>	91db: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    91da:	ff d0                	callq  *%rax	91db: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    91dc:	0f 1f 00             	nopl   (%rax)
     91df:	e9 1d ff ff ff       	jmpq   9101 <rt_mutex_setprio+0x151>
     91e4:	49 8b 84 24 80 00 00 00 	mov    0x80(%r12),%rax
     91ec:	48 89 0c 24          	mov    %rcx,(%rsp)
     91f0:	4c 89 e6             	mov    %r12,%rsi
     91f3:	48 89 ef             	mov    %rbp,%rdi
     91f6:	48 8b 00             	mov    (%rax),%rax
-    91f9:	e8 00 00 00 00       	callq  91fe <rt_mutex_setprio+0x24e>	91fa: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    91f9:	ff d0                	callq  *%rax	91fa: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    91fb:	0f 1f 00             	nopl   (%rax)
     91fe:	48 8b 0c 24          	mov    (%rsp),%rcx
     9202:	e9 af fe ff ff       	jmpq   90b6 <rt_mutex_setprio+0x106>
     9207:	89 44 24 14          	mov    %eax,0x14(%rsp)
@@ -10114,7 +10215,8 @@
     9212:	48 89 ef             	mov    %rbp,%rdi
     9215:	48 89 4c 24 08       	mov    %rcx,0x8(%rsp)
     921a:	89 14 24             	mov    %edx,(%rsp)
-    921d:	e8 00 00 00 00       	callq  9222 <rt_mutex_setprio+0x272>	921e: R_X86_64_PLT32	__x86_indirect_thunk_r8-0x4
+    921d:	41 ff d0             	callq  *%r8	921e: R_X86_64_NONE	__x86_indirect_thunk_r8-0x4
+    9220:	66 90                	xchg   %ax,%ax
     9222:	4d 39 fc             	cmp    %r15,%r12
     9225:	8b 14 24             	mov    (%rsp),%edx
     9228:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
@@ -10130,7 +10232,8 @@
     9255:	89 14 24             	mov    %edx,(%rsp)
     9258:	4c 8b 46 30          	mov    0x30(%rsi),%r8
     925c:	4c 89 fe             	mov    %r15,%rsi
-    925f:	e8 00 00 00 00       	callq  9264 <rt_mutex_setprio+0x2b4>	9260: R_X86_64_PLT32	__x86_indirect_thunk_r8-0x4
+    925f:	41 ff d0             	callq  *%r8	9260: R_X86_64_NONE	__x86_indirect_thunk_r8-0x4
+    9262:	66 90                	xchg   %ax,%ax
     9264:	8b 44 24 14          	mov    0x14(%rsp),%eax
     9268:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
     926d:	8b 14 24             	mov    (%rsp),%edx
@@ -10143,7 +10246,8 @@
     928f:	4c 89 fe             	mov    %r15,%rsi
     9292:	48 89 ef             	mov    %rbp,%rdi
     9295:	48 8b 40 38          	mov    0x38(%rax),%rax
-    9299:	e8 00 00 00 00       	callq  929e <rt_mutex_setprio+0x2ee>	929a: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    9299:	ff d0                	callq  *%rax	929a: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    929b:	0f 1f 00             	nopl   (%rax)
     929e:	48 8b 0c 24          	mov    (%rsp),%rcx
     92a2:	e9 18 fe ff ff       	jmpq   90bf <rt_mutex_setprio+0x10f>
     92a7:	4c 39 a5 30 09 00 00 	cmp    %r12,0x930(%rbp)
@@ -11490,7 +11594,8 @@
     a6fe:	0f 84 f2 00 00 00    	je     a7f6 <sched_move_task+0x176>
     a704:	be 01 00 00 00       	mov    $0x1,%esi
     a709:	48 89 df             	mov    %rbx,%rdi
-    a70c:	e8 00 00 00 00       	callq  a711 <sched_move_task+0x91>	a70d: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    a70c:	ff d0                	callq  *%rax	a70d: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    a70e:	0f 1f 00             	nopl   (%rax)
     a711:	41 83 fd 01          	cmp    $0x1,%r13d
     a715:	0f 84 8a 00 00 00    	je     a7a5 <sched_move_task+0x125>
     a71b:	4c 39 f3             	cmp    %r14,%rbx
@@ -11515,7 +11620,8 @@
     a767:	48 89 de             	mov    %rbx,%rsi
     a76a:	48 89 ef             	mov    %rbp,%rdi
     a76d:	48 8b 40 08          	mov    0x8(%rax),%rax
-    a771:	e8 00 00 00 00       	callq  a776 <sched_move_task+0xf6>	a772: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    a771:	ff d0                	callq  *%rax	a772: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    a773:	0f 1f 00             	nopl   (%rax)
     a776:	4c 39 f3             	cmp    %r14,%rbx
     a779:	0f 85 5c ff ff ff    	jne    a6db <sched_move_task+0x5b>
     a77f:	48 3b 9d 30 09 00 00 	cmp    0x930(%rbp),%rbx
@@ -11525,14 +11631,16 @@
     a791:	4c 89 f6             	mov    %r14,%rsi
     a794:	48 89 ef             	mov    %rbp,%rdi
     a797:	48 8b 40 30          	mov    0x30(%rax),%rax
-    a79b:	e8 00 00 00 00       	callq  a7a0 <sched_move_task+0x120>	a79c: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    a79b:	ff d0                	callq  *%rax	a79c: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    a79d:	0f 1f 00             	nopl   (%rax)
     a7a0:	e9 36 ff ff ff       	jmpq   a6db <sched_move_task+0x5b>
     a7a5:	48 8b 83 80 00 00 00 	mov    0x80(%rbx),%rax
     a7ac:	ba 0e 00 00 00       	mov    $0xe,%edx
     a7b1:	48 89 de             	mov    %rbx,%rsi
     a7b4:	48 89 ef             	mov    %rbp,%rdi
     a7b7:	48 8b 00             	mov    (%rax),%rax
-    a7ba:	e8 00 00 00 00       	callq  a7bf <sched_move_task+0x13f>	a7bb: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    a7ba:	ff d0                	callq  *%rax	a7bb: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    a7bc:	0f 1f 00             	nopl   (%rax)
     a7bf:	4c 39 f3             	cmp    %r14,%rbx
     a7c2:	0f 85 5c ff ff ff    	jne    a724 <sched_move_task+0xa4>
     a7c8:	48 3b 9d 30 09 00 00 	cmp    0x930(%rbp),%rbx
@@ -11542,7 +11650,8 @@
     a7db:	31 d2                	xor    %edx,%edx
     a7dd:	4c 89 f6             	mov    %r14,%rsi
     a7e0:	48 8b 40 38          	mov    0x38(%rax),%rax
-    a7e4:	e8 00 00 00 00       	callq  a7e9 <sched_move_task+0x169>	a7e5: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+    a7e4:	ff d0                	callq  *%rax	a7e5: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+    a7e6:	0f 1f 00             	nopl   (%rax)
     a7e9:	48 89 ef             	mov    %rbp,%rdi
     a7ec:	e8 00 00 00 00       	callq  a7f1 <sched_move_task+0x171>	a7ed: R_X86_64_PLT32	resched_curr-0x4
     a7f1:	e9 2e ff ff ff       	jmpq   a724 <sched_move_task+0xa4>
@@ -12406,7 +12515,8 @@
  410:	4c 89 f6             	mov    %r14,%rsi
  413:	48 89 df             	mov    %rbx,%rdi
  416:	48 8b 40 08          	mov    0x8(%rax),%rax
- 41a:	e8 00 00 00 00       	callq  41f <__schedule+0x3af>	41b: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+ 41a:	ff d0                	callq  *%rax	41b: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+ 41c:	0f 1f 00             	nopl   (%rax)
  41f:	41 f6 86 a8 04 00 00 04 	testb  $0x4,0x4a8(%r14)
  427:	0f 85 ac 02 00 00    	jne    6d9 <__schedule+0x669>
  42d:	4d 8b a6 80 00 00 00 	mov    0x80(%r14),%r12
@@ -12425,7 +12535,8 @@
  470:	4c 89 ea             	mov    %r13,%rdx
  473:	4c 89 f6             	mov    %r14,%rsi
  476:	48 89 df             	mov    %rbx,%rdi
- 479:	e8 00 00 00 00       	callq  47e <__schedule+0x40e>	47a: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+ 479:	ff d0                	callq  *%rax	47a: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+ 47b:	0f 1f 00             	nopl   (%rax)
  47e:	85 c0                	test   %eax,%eax
  480:	74 d9                	je     45b <__schedule+0x3eb>
  482:	4d 8b a6 80 00 00 00 	mov    0x80(%r14),%r12
@@ -12435,14 +12546,16 @@
  49b:	4c 89 f6             	mov    %r14,%rsi
  49e:	48 89 df             	mov    %rbx,%rdi
  4a1:	49 bd 00 00 00 00 00 00 00 00 	movabs $0x0,%r13	4a3: R_X86_64_64	__begin_sched_classes-0xc8
- 4ab:	e8 00 00 00 00       	callq  4b0 <__schedule+0x440>	4ac: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+ 4ab:	ff d0                	callq  *%rax	4ac: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+ 4ad:	0f 1f 00             	nopl   (%rax)
  4b0:	48 ba 00 00 00 00 00 00 00 00 	movabs $0x0,%rdx	4b2: R_X86_64_64	__end_sched_classes-0xc8
  4ba:	4c 39 ea             	cmp    %r13,%rdx
  4bd:	74 27                	je     4e6 <__schedule+0x476>
  4bf:	49 89 d7             	mov    %rdx,%r15
  4c2:	49 8b 47 28          	mov    0x28(%r15),%rax
  4c6:	48 89 df             	mov    %rbx,%rdi
- 4c9:	e8 00 00 00 00       	callq  4ce <__schedule+0x45e>	4ca: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+ 4c9:	ff d0                	callq  *%rax	4ca: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+ 4cb:	0f 1f 00             	nopl   (%rax)
  4ce:	49 89 c4             	mov    %rax,%r12
  4d1:	48 85 c0             	test   %rax,%rax
  4d4:	0f 85 9e fc ff ff    	jne    178 <__schedule+0x108>
@@ -12499,7 +12612,8 @@
  5ea:	4c 89 f6             	mov    %r14,%rsi
  5ed:	48 89 df             	mov    %rbx,%rdi
  5f0:	48 8b 40 30          	mov    0x30(%rax),%rax
- 5f4:	e8 00 00 00 00       	callq  5f9 <__schedule+0x589>	5f5: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+ 5f4:	ff d0                	callq  *%rax	5f5: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+ 5f6:	0f 1f 00             	nopl   (%rax)
  5f9:	48 89 df             	mov    %rbx,%rdi
  5fc:	e8 00 00 00 00       	callq  601 <__schedule+0x591>	5fd: R_X86_64_PLT32	pick_next_task_idle-0x4
  601:	49 89 c4             	mov    %rax,%r12
@@ -12518,7 +12632,8 @@
  643:	4d 8b 24 24          	mov    (%r12),%r12
  647:	48 89 df             	mov    %rbx,%rdi
  64a:	48 c7 02 00 00 00 00 	movq   $0x0,(%rdx)
- 651:	e8 00 00 00 00       	callq  656 <__schedule+0x5e6>	652: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
+ 651:	ff d0                	callq  *%rax	652: R_X86_64_NONE	__x86_indirect_thunk_rax-0x4
+ 653:	0f 1f 00             	nopl   (%rax)
  656:	4d 85 e4             	test   %r12,%r12
  659:	75 e0                	jne    63b <__schedule+0x5cb>
  65b:	c6 03 00             	movb   $0x0,(%rbx)
@@ -12766,7 +12881,8 @@
  9b7:	75 ba                	jne    973 <yield_to+0xc3>
  9b9:	4c 89 e6             	mov    %r12,%rsi
  9bc:	48 89 ef             	mov    %rbp,%rdi
- 9bf:	e8 00 00 00 00       	callq  9c4 <yield_to+0x114>	9c0: R_X86_64_PLT32	__x86_indirect_thunk_rdx-0x4
+ 9bf:	ff d2                	callq  *%rdx	9c0: R_X86_64_NONE	__x86_indirect_thunk_rdx-0x4
+ 9c1:	0f 1f 00             	nopl   (%rax)
  9c4:	84 c0                	test   %al,%al
  9c6:	74 ab                	je     973 <yield_to+0xc3>
  9c8:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
@@ -12849,82 +12965,82 @@
   2b:	0f 85 00 00 00 00    	jne    31 <.altinstr_aux+0x31>	2d: R_X86_64_PC32	.text+0x33bf
   31:	e9 00 00 00 00       	jmpq   36 <__kstrtab___SCK__tp_func_pelt_cfs_tp+0x3>	32: R_X86_64_PC32	.text+0x33f1
 
-Relocation section '.rela.text' at offset 0x21360 contains 1219 entries:
+Relocation section '.rela.text' at offset 0xa928 contains 1219 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000005  000002a800000002 R_X86_64_PC32          0000000000000d80 __tracepoint_sched_kthread_stop + 3c
-0000000000000020  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000000020  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000000045  000002ab00000002 R_X86_64_PC32          0000000000000d20 __tracepoint_sched_kthread_stop_ret + 3c
-000000000000005e  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+000000000000005e  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000000077  000002ae00000002 R_X86_64_PC32          0000000000000cc0 __tracepoint_sched_kthread_work_queue_work + 3c
-0000000000000098  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000000098  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 00000000000000b5  000002b100000002 R_X86_64_PC32          0000000000000c60 __tracepoint_sched_kthread_work_execute_start + 3c
-00000000000000d0  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+00000000000000d0  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 00000000000000f7  000002b400000002 R_X86_64_PC32          0000000000000c00 __tracepoint_sched_kthread_work_execute_end + 3c
-0000000000000118  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000000118  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000000135  000002b700000002 R_X86_64_PC32          0000000000000ba0 __tracepoint_sched_waking + 3c
-0000000000000150  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000000150  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000000175  000002ba00000002 R_X86_64_PC32          0000000000000b40 __tracepoint_sched_wakeup + 3c
-0000000000000190  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000000190  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 00000000000001b5  000002bd00000002 R_X86_64_PC32          0000000000000ae0 __tracepoint_sched_wakeup_new + 3c
-00000000000001d0  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+00000000000001d0  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 00000000000001f9  000002c000000002 R_X86_64_PC32          0000000000000a80 __tracepoint_sched_switch + 3c
-0000000000000220  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000000220  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000000247  000002c300000002 R_X86_64_PC32          0000000000000a20 __tracepoint_sched_migrate_task + 3c
-0000000000000268  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000000268  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000000285  000002c600000002 R_X86_64_PC32          00000000000009c0 __tracepoint_sched_process_free + 3c
-00000000000002a0  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+00000000000002a0  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 00000000000002c5  000002c900000002 R_X86_64_PC32          0000000000000960 __tracepoint_sched_process_exit + 3c
-00000000000002e0  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+00000000000002e0  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000000305  000002cc00000002 R_X86_64_PC32          0000000000000900 __tracepoint_sched_wait_task + 3c
-0000000000000320  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000000320  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000000345  000002cf00000002 R_X86_64_PC32          00000000000008a0 __tracepoint_sched_process_wait + 3c
-0000000000000360  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000000360  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000000387  000002d200000002 R_X86_64_PC32          0000000000000840 __tracepoint_sched_process_fork + 3c
-00000000000003a8  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+00000000000003a8  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 00000000000003c9  000002d500000002 R_X86_64_PC32          00000000000007e0 __tracepoint_sched_process_exec + 3c
-00000000000003f0  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+00000000000003f0  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000000417  000002d800000002 R_X86_64_PC32          0000000000000780 __tracepoint_sched_stat_wait + 3c
-0000000000000438  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000000438  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000000457  000002db00000002 R_X86_64_PC32          0000000000000720 __tracepoint_sched_stat_sleep + 3c
-0000000000000478  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000000478  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000000497  000002de00000002 R_X86_64_PC32          00000000000006c0 __tracepoint_sched_stat_iowait + 3c
-00000000000004b8  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+00000000000004b8  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 00000000000004d7  000002e100000002 R_X86_64_PC32          0000000000000660 __tracepoint_sched_stat_blocked + 3c
-00000000000004f8  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+00000000000004f8  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000000519  000002e400000002 R_X86_64_PC32          0000000000000600 __tracepoint_sched_stat_runtime + 3c
-0000000000000540  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000000540  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000000567  000002e700000002 R_X86_64_PC32          00000000000005a0 __tracepoint_sched_pi_setprio + 3c
-0000000000000588  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000000588  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 00000000000005a9  000002ea00000002 R_X86_64_PC32          0000000000000540 __tracepoint_sched_move_numa + 3c
-00000000000005d0  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+00000000000005d0  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 00000000000005fb  000002ed00000002 R_X86_64_PC32          00000000000004e0 __tracepoint_sched_stick_numa + 3c
-0000000000000628  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000000628  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 000000000000064b  000002f000000002 R_X86_64_PC32          0000000000000480 __tracepoint_sched_swap_numa + 3c
-0000000000000678  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000000678  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000000695  000002f300000002 R_X86_64_PC32          0000000000000420 __tracepoint_sched_wake_idle_without_ipi + 3c
-00000000000006ae  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+00000000000006ae  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 00000000000006c5  000002f600000002 R_X86_64_PC32          00000000000003c0 __tracepoint_pelt_cfs_tp + 3c
-00000000000006e0  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+00000000000006e0  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000000705  000002f900000002 R_X86_64_PC32          0000000000000360 __tracepoint_pelt_rt_tp + 3c
-0000000000000720  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000000720  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000000745  000002fc00000002 R_X86_64_PC32          0000000000000300 __tracepoint_pelt_dl_tp + 3c
-0000000000000760  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000000760  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000000785  000002ff00000002 R_X86_64_PC32          00000000000002a0 __tracepoint_pelt_thermal_tp + 3c
-00000000000007a0  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+00000000000007a0  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 00000000000007c5  0000030200000002 R_X86_64_PC32          0000000000000240 __tracepoint_pelt_irq_tp + 3c
-00000000000007e0  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+00000000000007e0  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000000805  0000030500000002 R_X86_64_PC32          00000000000001e0 __tracepoint_pelt_se_tp + 3c
-0000000000000820  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000000820  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000000845  0000030800000002 R_X86_64_PC32          0000000000000180 __tracepoint_sched_cpu_capacity_tp + 3c
-0000000000000860  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000000860  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000000887  0000030b00000002 R_X86_64_PC32          0000000000000120 __tracepoint_sched_overutilized_tp + 3c
-00000000000008a7  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+00000000000008a7  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 00000000000008c5  0000030e00000002 R_X86_64_PC32          00000000000000c0 __tracepoint_sched_util_est_cfs_tp + 3c
-00000000000008e0  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+00000000000008e0  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000000905  0000031100000002 R_X86_64_PC32          0000000000000060 __tracepoint_sched_util_est_se_tp + 3c
-0000000000000920  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000000920  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000000947  0000031400000002 R_X86_64_PC32          0000000000000000 __tracepoint_sched_update_nr_running_tp + 3c
-0000000000000968  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000000968  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000000985  000003390000000b R_X86_64_32S           0000000000000000 current_task + 0
 0000000000000998  0000033a0000000b R_X86_64_32S           0000000000000000 runqueues + 0
 00000000000009a0  0000033b00000002 R_X86_64_PC32          0000000000000000 this_cpu_off - 4
@@ -12932,7 +13048,7 @@
 00000000000009e6  0000033a0000000b R_X86_64_32S           0000000000000000 runqueues + 0
 00000000000009ee  0000033d0000000b R_X86_64_32S           0000000000000000 __per_cpu_offset + 0
 0000000000000a00  0000033e00000002 R_X86_64_PC32          0000000000000000 smp_ops + 24
-0000000000000a08  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000000a08  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000000a13  0000033a0000000b R_X86_64_32S           0000000000000000 runqueues + 0
 0000000000000a1b  0000033b00000002 R_X86_64_PC32          0000000000000000 this_cpu_off - 4
 0000000000000b48  000003410000000b R_X86_64_32S           0000000000000180 sched_prio_to_weight + 0
@@ -13137,10 +13253,10 @@
 0000000000002edf  0000036400000004 R_X86_64_PLT32         0000000000000000 find_task_by_vpid - 4
 0000000000002f04  0000038000000001 R_X86_64_64            0000000000000000 __begin_sched_classes - c8
 0000000000002f13  0000038100000001 R_X86_64_64            0000000000000000 __end_sched_classes - c8
-0000000000002f2d  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000002f2d  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000002f79  0000038100000001 R_X86_64_64            0000000000000000 __end_sched_classes - c8
 0000000000002f83  0000038000000001 R_X86_64_64            0000000000000000 __begin_sched_classes - c8
-0000000000002faa  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000002faa  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000002fc5  0000038400000004 R_X86_64_PLT32         0000000000000000 unregister_fair_sched_group - 4
 0000000000002fcc  000000040000000b R_X86_64_32S           0000000000000000 .bss + 1a0
 0000000000002fd1  0000035100000004 R_X86_64_PLT32         0000000000000000 _raw_spin_lock_irqsave - 4
@@ -13156,7 +13272,7 @@
 000000000000312b  0000033b00000002 R_X86_64_PC32          0000000000000000 this_cpu_off - 4
 0000000000003132  0000035700000002 R_X86_64_PC32          0000000000000000 __preempt_count - 4
 000000000000315e  000003390000000b R_X86_64_32S           0000000000000000 current_task + 0
-00000000000031a1  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+00000000000031a1  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 00000000000031b9  000003390000000b R_X86_64_32S           0000000000000000 current_task + 0
 00000000000031fd  000003880000000b R_X86_64_32S           0000000000000000 __perf_regs + 0
 0000000000003205  0000033b00000002 R_X86_64_PC32          0000000000000000 this_cpu_off - 4
@@ -13166,7 +13282,7 @@
 0000000000003283  000001c100000002 R_X86_64_PC32          0000000000000000 .data.once - 5
 000000000000328d  0000035700000002 R_X86_64_PC32          0000000000000000 __preempt_count - 4
 000000000000329f  0000035700000002 R_X86_64_PC32          0000000000000000 __preempt_count - 4
-00000000000032c4  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+00000000000032c4  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 00000000000032cc  0000038d00000004 R_X86_64_PLT32         0000000000000000 kprobe_flush_task - 4
 00000000000032d4  0000037700000004 R_X86_64_PLT32         0000000000000000 put_task_stack - 4
 00000000000032ef  000003390000000b R_X86_64_32S           0000000000000000 current_task + 0
@@ -13176,7 +13292,7 @@
 0000000000003335  000000020000000b R_X86_64_32S           0000000000000000 .text + 333b
 000000000000334f  0000033c00000002 R_X86_64_PC32          0000000000000000 cpu_number - 4
 000000000000335f  0000037a00000004 R_X86_64_PLT32         0000000000000000 _raw_spin_lock - 4
-0000000000003392  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000003392  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 00000000000033e9  0000036600000004 R_X86_64_PLT32         0000000000000000 _copy_to_user - 4
 0000000000003476  000003390000000b R_X86_64_32S           0000000000000000 current_task + 0
 000000000000348b  0000036200000004 R_X86_64_PLT32         0000000000000000 security_task_getscheduler - 4
@@ -13209,13 +13325,13 @@
 00000000000037c1  000003390000000b R_X86_64_32S           0000000000000000 current_task + 0
 00000000000037fa  0000033a0000000b R_X86_64_32S           0000000000000000 runqueues + 0
 0000000000003810  0000033d0000000b R_X86_64_32S           0000000000000000 __per_cpu_offset + 0
-0000000000003866  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
-0000000000003888  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
-00000000000038c1  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
-00000000000038da  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
-0000000000003918  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
-0000000000003931  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
-000000000000394b  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000003866  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000003888  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
+00000000000038c1  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
+00000000000038da  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000003918  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000003931  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
+000000000000394b  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000003974  000003520000000b R_X86_64_32S           0000000000000560 balance_push_callback + 0
 00000000000039c2  0000039700000004 R_X86_64_PLT32         0000000000000000 rcuwait_wake_up - 4
 00000000000039f8  000001910000000b R_X86_64_32S           0000000000000000 .data..percpu + 0
@@ -13322,7 +13438,7 @@
 000000000000490d  0000033b00000002 R_X86_64_PC32          0000000000000000 this_cpu_off - 4
 0000000000004915  0000037a00000004 R_X86_64_PLT32         0000000000000000 _raw_spin_lock - 4
 0000000000004923  000003390000000b R_X86_64_32S           0000000000000000 current_task + 0
-0000000000004936  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000004936  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000004963  0000035700000002 R_X86_64_PC32          0000000000000000 __preempt_count - 4
 000000000000497b  000003390000000b R_X86_64_32S           0000000000000000 current_task + 0
 0000000000004985  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 6c
@@ -13373,7 +13489,7 @@
 0000000000004d75  0000036200000004 R_X86_64_PLT32         0000000000000000 security_task_getscheduler - 4
 0000000000004d81  0000036300000004 R_X86_64_PLT32         0000000000000000 rcu_read_unlock_strict - 4
 0000000000004db3  000003ba00000004 R_X86_64_PLT32         0000000000004ca0 task_rq_lock - 4
-0000000000004dd4  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000004dd4  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000004dec  0000035300000004 R_X86_64_PLT32         0000000000000000 _raw_spin_unlock_irqrestore - 4
 0000000000004df1  0000036300000004 R_X86_64_PLT32         0000000000000000 rcu_read_unlock_strict - 4
 0000000000004dfc  000003bb00000004 R_X86_64_PLT32         0000000000000000 jiffies_to_timespec64 - 4
@@ -13391,12 +13507,12 @@
 0000000000005043  0000039d0000000b R_X86_64_32S           0000000000000000 fair_sched_class + 0
 0000000000005053  000003410000000b R_X86_64_32S           0000000000000180 sched_prio_to_weight + 0
 0000000000005067  000003c20000000b R_X86_64_32S           00000000000000e0 sched_prio_to_wmult + 0
-00000000000050cb  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+00000000000050cb  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 00000000000050e0  0000035300000004 R_X86_64_PLT32         0000000000000000 _raw_spin_unlock_irqrestore - 4
-0000000000005147  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
-0000000000005171  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
-000000000000519c  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
-00000000000051c3  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000005147  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000005171  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
+000000000000519c  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
+00000000000051c3  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 00000000000051cd  000003c300000004 R_X86_64_PLT32         0000000000000000 reweight_task - 4
 00000000000051eb  0000034500000004 R_X86_64_PLT32         0000000000000000 __stack_chk_fail - 4
 0000000000005228  000003390000000b R_X86_64_32S           0000000000000000 current_task + 0
@@ -13408,7 +13524,7 @@
 000000000000535b  000003c500000004 R_X86_64_PLT32         0000000000000000 security_task_setnice - 4
 000000000000539f  000003c600000004 R_X86_64_PLT32         0000000000000000 capable - 4
 00000000000053d1  000003ba00000004 R_X86_64_PLT32         0000000000004ca0 task_rq_lock - 4
-0000000000005414  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000005414  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000005428  0000035300000004 R_X86_64_PLT32         0000000000000000 _raw_spin_unlock_irqrestore - 4
 0000000000005466  000003c800000004 R_X86_64_PLT32         0000000000000000 set_task_rq_fair - 4
 0000000000005493  0000034500000004 R_X86_64_PLT32         0000000000000000 __stack_chk_fail - 4
@@ -13419,8 +13535,8 @@
 000000000000574e  000003c20000000b R_X86_64_32S           00000000000000e0 sched_prio_to_wmult + 0
 00000000000057a5  0000039d0000000b R_X86_64_32S           0000000000000000 fair_sched_class + 0
 00000000000057ac  000003ca0000000b R_X86_64_32S           0000000000000000 rt_sched_class + 0
-00000000000057f1  000003cb00000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rdx - 4
-000000000000580a  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+00000000000057f1  000003cb00000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rdx - 4
+000000000000580a  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000005839  0000035300000004 R_X86_64_PLT32         0000000000000000 _raw_spin_unlock_irqrestore - 4
 00000000000058a2  000003c600000004 R_X86_64_PLT32         0000000000000000 capable - 4
 0000000000005914  000003390000000b R_X86_64_32S           0000000000000000 current_task + 0
@@ -13428,19 +13544,19 @@
 000000000000596f  000003cc00000004 R_X86_64_PLT32         0000000000000000 security_task_setscheduler - 4
 0000000000005981  000003cd00000004 R_X86_64_PLT32         0000000000000000 cpuset_read_lock - 4
 000000000000599a  0000035100000004 R_X86_64_PLT32         0000000000000000 _raw_spin_lock_irqsave - 4
-00000000000059b7  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+00000000000059b7  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 00000000000059c7  0000035300000004 R_X86_64_PLT32         0000000000000000 _raw_spin_unlock_irqrestore - 4
 00000000000059e4  000003ce00000004 R_X86_64_PLT32         0000000000000000 __checkparam_dl - 4
-0000000000005a20  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000005a20  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000005a33  000003cf00000004 R_X86_64_PLT32         0000000000000000 cpuset_read_unlock - 4
 0000000000005a3b  000003d000000004 R_X86_64_PLT32         0000000000000000 rt_mutex_adjust_pi - 4
 0000000000005a4e  000003d100000004 R_X86_64_PLT32         0000000000000000 sched_dl_overflow - 4
-0000000000005a85  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000005a85  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000005ac7  0000035300000004 R_X86_64_PLT32         0000000000000000 _raw_spin_unlock_irqrestore - 4
 0000000000005ad7  000003cf00000004 R_X86_64_PLT32         0000000000000000 cpuset_read_unlock - 4
-0000000000005b01  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
-0000000000005b3e  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
-0000000000005b8b  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000005b01  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000005b3e  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000005b8b  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000005bd6  000003c600000004 R_X86_64_PLT32         0000000000000000 capable - 4
 0000000000005bef  0000035700000002 R_X86_64_PC32          0000000000000000 __preempt_count - 4
 0000000000005cc5  0000035300000004 R_X86_64_PLT32         0000000000000000 _raw_spin_unlock_irqrestore - 4
@@ -13481,7 +13597,7 @@
 0000000000006397  0000034500000004 R_X86_64_PLT32         0000000000000000 __stack_chk_fail - 4
 000000000000640d  0000034500000004 R_X86_64_PLT32         0000000000000000 __stack_chk_fail - 4
 000000000000648d  0000034500000004 R_X86_64_PLT32         0000000000000000 __stack_chk_fail - 4
-00000000000064c4  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+00000000000064c4  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 00000000000064de  0000033a0000000b R_X86_64_32S           0000000000000000 runqueues + 0
 00000000000064ed  0000033b00000002 R_X86_64_PC32          0000000000000000 this_cpu_off - 4
 00000000000065f7  0000033c00000002 R_X86_64_PC32          0000000000000000 cpu_number - 4
@@ -13519,25 +13635,25 @@
 0000000000006898  000003a100000002 R_X86_64_PC32          0000000000000000 __cpu_online_mask - 4
 00000000000068a1  000002f300000002 R_X86_64_PC32          0000000000000420 __tracepoint_sched_wake_idle_without_ipi + 3c
 00000000000068b4  000002f400000004 R_X86_64_PLT32         00000000000000c8 __SCT__tp_func_sched_wake_idle_without_ipi - 4
-00000000000068e0  000003eb00000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_r13 - 4
-000000000000690c  000003ec00000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_r12 - 4
-00000000000069a8  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+00000000000068e0  000003eb00000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_r13 - 4
+000000000000690c  000003ec00000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_r12 - 4
+00000000000069a8  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000006a86  0000033a0000000b R_X86_64_32S           0000000000000000 runqueues + 0
 0000000000006a8e  0000033d0000000b R_X86_64_32S           0000000000000000 __per_cpu_offset + 0
 0000000000006ad6  000003e100000004 R_X86_64_PLT32         00000000000065e0 resched_curr - 4
-0000000000006afc  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000006afc  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000006b19  000003f100000004 R_X86_64_PLT32         0000000000006ab0 check_preempt_curr - 4
-0000000000006b41  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000006b41  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000006b9c  0000033c00000002 R_X86_64_PC32          0000000000000000 cpu_number - 4
 0000000000006ba6  000003a100000002 R_X86_64_PC32          0000000000000000 __cpu_online_mask - 4
 0000000000006bb3  000002ba00000002 R_X86_64_PC32          0000000000000b40 __tracepoint_sched_wakeup + 3c
 0000000000006bc4  000002bb00000004 R_X86_64_PLT32         0000000000000030 __SCT__tp_func_sched_wakeup - 4
-0000000000006c41  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000006c41  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000006c6d  000003f200000004 R_X86_64_PLT32         0000000000000000 __delayacct_blkio_end - 4
 0000000000006c76  000003390000000b R_X86_64_32S           0000000000000000 current_task + 0
 0000000000006c95  0000033a0000000b R_X86_64_32S           0000000000000000 runqueues + 0
 0000000000006c9d  0000033d0000000b R_X86_64_32S           0000000000000000 __per_cpu_offset + 0
-0000000000006d2d  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000006d2d  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000006d79  000003c800000004 R_X86_64_PLT32         0000000000000000 set_task_rq_fair - 4
 0000000000006db1  0000033c00000002 R_X86_64_PC32          0000000000000000 cpu_number - 4
 0000000000006dbb  000003a100000002 R_X86_64_PC32          0000000000000000 __cpu_online_mask - 4
@@ -13548,18 +13664,18 @@
 0000000000006e13  0000036c00000004 R_X86_64_PLT32         0000000000000000 _raw_spin_lock_irq - 4
 0000000000006e1b  0000037a00000004 R_X86_64_PLT32         0000000000000000 _raw_spin_lock - 4
 0000000000006e26  0000033d0000000b R_X86_64_32S           0000000000000000 __per_cpu_offset + 0
-0000000000006e9d  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000006e9d  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000006eb0  0000033d0000000b R_X86_64_32S           0000000000000000 __per_cpu_offset + 0
 0000000000006ec7  000003d600000004 R_X86_64_PLT32         0000000000000000 __put_task_struct - 4
 0000000000006ee9  0000037300000004 R_X86_64_PLT32         0000000000000000 refcount_warn_saturate - 4
-0000000000006f58  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000006f58  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000006f67  000003f500000004 R_X86_64_PLT32         0000000000006d00 set_task_cpu - 4
-0000000000006fa8  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000006fa8  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000006fb7  000003e100000004 R_X86_64_PLT32         00000000000065e0 resched_curr - 4
 0000000000006fe9  000003390000000b R_X86_64_32S           0000000000000000 current_task + 0
 0000000000007003  0000035100000004 R_X86_64_PLT32         0000000000000000 _raw_spin_lock_irqsave - 4
 000000000000701a  0000035300000004 R_X86_64_PLT32         0000000000000000 _raw_spin_unlock_irqrestore - 4
-00000000000070a9  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+00000000000070a9  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 00000000000070c9  0000033a0000000b R_X86_64_32S           0000000000000000 runqueues + 0
 00000000000070ea  000003f500000004 R_X86_64_PLT32         0000000000006d00 set_task_cpu - 4
 00000000000070fe  0000033d0000000b R_X86_64_32S           0000000000000000 __per_cpu_offset + 0
@@ -13590,12 +13706,12 @@
 00000000000073aa  0000034500000004 R_X86_64_PLT32         0000000000000000 __stack_chk_fail - 4
 0000000000007431  000003d600000004 R_X86_64_PLT32         0000000000000000 __put_task_struct - 4
 0000000000007448  0000037300000004 R_X86_64_PLT32         0000000000000000 refcount_warn_saturate - 4
-00000000000074c0  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+00000000000074c0  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 00000000000074ca  000003f500000004 R_X86_64_PLT32         0000000000006d00 set_task_cpu - 4
 00000000000074d9  0000033a0000000b R_X86_64_32S           0000000000000000 runqueues + 0
 00000000000074e1  0000033d0000000b R_X86_64_32S           0000000000000000 __per_cpu_offset + 0
 00000000000074e9  0000037a00000004 R_X86_64_PLT32         0000000000000000 _raw_spin_lock - 4
-000000000000752b  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+000000000000752b  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 000000000000753f  000003f100000004 R_X86_64_PLT32         0000000000006ab0 check_preempt_curr - 4
 000000000000764c  0000035300000004 R_X86_64_PLT32         0000000000000000 _raw_spin_unlock_irqrestore - 4
 0000000000007664  000003f900000004 R_X86_64_PLT32         0000000000000000 wait_for_completion - 4
@@ -13690,7 +13806,7 @@
 00000000000082e0  0000033d0000000b R_X86_64_32S           0000000000000000 __per_cpu_offset + 0
 0000000000008338  0000035100000004 R_X86_64_PLT32         0000000000000000 _raw_spin_lock_irqsave - 4
 000000000000834f  0000033e00000002 R_X86_64_PC32          0000000000000000 smp_ops + 24
-0000000000008357  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000008357  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000008362  0000035300000004 R_X86_64_PLT32         0000000000000000 _raw_spin_unlock_irqrestore - 4
 0000000000008382  0000033c00000002 R_X86_64_PC32          0000000000000000 cpu_number - 4
 000000000000838c  000003a100000002 R_X86_64_PC32          0000000000000000 __cpu_online_mask - 4
@@ -13700,12 +13816,12 @@
 00000000000083d1  0000033d0000000b R_X86_64_32S           0000000000000000 __per_cpu_offset + 0
 00000000000083d9  0000033d0000000b R_X86_64_32S           0000000000000000 __per_cpu_offset + 0
 0000000000008422  0000035100000004 R_X86_64_PLT32         0000000000000000 _raw_spin_lock_irqsave - 4
-0000000000008451  0000040d00000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rbx - 4
+0000000000008451  0000040d00000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rbx - 4
 0000000000008460  0000035300000004 R_X86_64_PLT32         0000000000000000 _raw_spin_unlock_irqrestore - 4
 0000000000008490  000003b900000004 R_X86_64_PLT32         0000000000004c40 __task_rq_lock - 4
 000000000000849d  0000033a0000000b R_X86_64_32S           0000000000000000 runqueues + 0
 00000000000084a5  0000033d0000000b R_X86_64_32S           0000000000000000 __per_cpu_offset + 0
-00000000000084bf  0000040d00000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rbx - 4
+00000000000084bf  0000040d00000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rbx - 4
 00000000000084c9  0000034500000004 R_X86_64_PLT32         0000000000000000 __stack_chk_fail - 4
 0000000000008536  000003c600000004 R_X86_64_PLT32         0000000000000000 capable - 4
 000000000000859b  0000041200000004 R_X86_64_PLT32         0000000000000000 proc_dointvec_minmax - 4
@@ -13721,7 +13837,7 @@
 00000000000086ef  0000035100000004 R_X86_64_PLT32         0000000000000000 _raw_spin_lock_irqsave - 4
 0000000000008726  0000033c00000002 R_X86_64_PC32          0000000000000000 cpu_number - 4
 0000000000008739  000003c800000004 R_X86_64_PLT32         0000000000000000 set_task_rq_fair - 4
-0000000000008780  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000008780  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 000000000000878b  0000035300000004 R_X86_64_PLT32         0000000000000000 _raw_spin_unlock_irqrestore - 4
 000000000000886b  000003410000000b R_X86_64_32S           0000000000000180 sched_prio_to_weight + 0
 000000000000887f  000003c20000000b R_X86_64_32S           00000000000000e0 sched_prio_to_wmult + 0
@@ -13734,11 +13850,11 @@
 0000000000008a40  000003c800000004 R_X86_64_PLT32         0000000000000000 set_task_rq_fair - 4
 0000000000008a77  000003b900000004 R_X86_64_PLT32         0000000000004c40 __task_rq_lock - 4
 0000000000008a93  0000041900000004 R_X86_64_PLT32         0000000000000000 post_init_entity_util_avg - 4
-0000000000008ac5  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000008ac5  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000008ae1  000003f100000004 R_X86_64_PLT32         0000000000006ab0 check_preempt_curr - 4
-0000000000008afc  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000008afc  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000008b0b  0000035300000004 R_X86_64_PLT32         0000000000000000 _raw_spin_unlock_irqrestore - 4
-0000000000008b44  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000008b44  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000008b53  0000033c00000002 R_X86_64_PC32          0000000000000000 cpu_number - 4
 0000000000008b5d  000003a100000002 R_X86_64_PC32          0000000000000000 __cpu_online_mask - 4
 0000000000008b6a  000002bd00000002 R_X86_64_PC32          0000000000000ae0 __tracepoint_sched_wakeup_new + 3c
@@ -13768,7 +13884,7 @@
 0000000000008cec  000003b400000004 R_X86_64_PLT32         0000000000000000 cpumask_next - 4
 0000000000008d09  000003390000000b R_X86_64_32S           0000000000000000 current_task + 0
 0000000000008d2c  0000035100000004 R_X86_64_PLT32         0000000000000000 _raw_spin_lock_irqsave - 4
-0000000000008d4a  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000008d4a  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000008d51  0000033c00000002 R_X86_64_PC32          0000000000000000 cpu_number - 4
 0000000000008d5f  0000039300000002 R_X86_64_PC32          0000000000000000 __cpu_active_mask - 4
 0000000000008d86  0000035300000004 R_X86_64_PLT32         0000000000000000 _raw_spin_unlock_irqrestore - 4
@@ -13777,7 +13893,7 @@
 0000000000008dd9  0000034500000004 R_X86_64_PLT32         0000000000000000 __stack_chk_fail - 4
 0000000000008e2e  000003ba00000004 R_X86_64_PLT32         0000000000004ca0 task_rq_lock - 4
 0000000000008e5a  0000035300000004 R_X86_64_PLT32         0000000000000000 _raw_spin_unlock_irqrestore - 4
-0000000000008e9f  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000008e9f  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000008ea6  0000034500000004 R_X86_64_PLT32         0000000000000000 __stack_chk_fail - 4
 0000000000008eb9  0000033a0000000b R_X86_64_32S           0000000000000000 runqueues + 0
 0000000000008ec1  0000033c00000002 R_X86_64_PC32          0000000000000000 cpu_number - 4
@@ -13785,7 +13901,7 @@
 0000000000008edb  0000042500000004 R_X86_64_PLT32         0000000000000000 arch_scale_freq_tick - 4
 0000000000008ee0  0000042600000004 R_X86_64_PLT32         0000000000000000 sched_clock_tick - 4
 0000000000008ee8  0000037a00000004 R_X86_64_PLT32         0000000000000000 _raw_spin_lock - 4
-0000000000008f14  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000008f14  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000008f1c  0000042700000004 R_X86_64_PLT32         0000000000000000 calc_global_load_tick - 4
 0000000000008f25  0000042800000004 R_X86_64_PLT32         0000000000000000 perf_event_task_tick - 4
 0000000000008f32  0000033d0000000b R_X86_64_32S           0000000000000000 __per_cpu_offset + 0
@@ -13795,18 +13911,18 @@
 0000000000008fa7  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 6c
 0000000000009002  000003b900000004 R_X86_64_PLT32         0000000000004c40 __task_rq_lock - 4
 00000000000090a4  0000039d0000000b R_X86_64_32S           0000000000000000 fair_sched_class + 0
-00000000000090e3  000003cb00000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rdx - 4
-00000000000090fd  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
-000000000000912d  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+00000000000090e3  000003cb00000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rdx - 4
+00000000000090fd  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
+000000000000912d  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 000000000000916d  0000033c00000002 R_X86_64_PC32          0000000000000000 cpu_number - 4
 0000000000009177  000003a100000002 R_X86_64_PC32          0000000000000000 __cpu_online_mask - 4
 0000000000009180  000002e700000002 R_X86_64_PC32          00000000000005a0 __tracepoint_sched_pi_setprio + 3c
 0000000000009194  000002e800000004 R_X86_64_PLT32         00000000000000a8 __SCT__tp_func_sched_pi_setprio - 4
-00000000000091db  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
-00000000000091fa  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
-000000000000921e  0000042f00000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_r8 - 4
-0000000000009260  0000042f00000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_r8 - 4
-000000000000929a  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+00000000000091db  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
+00000000000091fa  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
+000000000000921e  0000042f00000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_r8 - 4
+0000000000009260  0000042f00000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_r8 - 4
+000000000000929a  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 00000000000092ed  000003d30000000b R_X86_64_32S           0000000000000000 dl_sched_class + 0
 000000000000931f  000003ca0000000b R_X86_64_32S           0000000000000000 rt_sched_class + 0
 000000000000936d  0000034500000004 R_X86_64_PLT32         0000000000000000 __stack_chk_fail - 4
@@ -13984,12 +14100,12 @@
 000000000000a621  0000035100000004 R_X86_64_PLT32         0000000000000000 _raw_spin_lock_irqsave - 4
 000000000000a62f  000000040000000b R_X86_64_32S           0000000000000000 .bss + 1a0
 000000000000a6a5  000003ba00000004 R_X86_64_PLT32         0000000000004ca0 task_rq_lock - 4
-000000000000a70d  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+000000000000a70d  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 000000000000a734  0000035300000004 R_X86_64_PLT32         0000000000000000 _raw_spin_unlock_irqrestore - 4
-000000000000a772  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
-000000000000a79c  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
-000000000000a7bb  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
-000000000000a7e5  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+000000000000a772  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
+000000000000a79c  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
+000000000000a7bb  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
+000000000000a7e5  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 000000000000a7ed  000003e100000004 R_X86_64_PLT32         00000000000065e0 resched_curr - 4
 000000000000a815  000003c800000004 R_X86_64_PLT32         0000000000000000 set_task_rq_fair - 4
 000000000000a849  0000034500000004 R_X86_64_PLT32         0000000000000000 __stack_chk_fail - 4
@@ -14034,8 +14150,8 @@
 000000000000331b  0000015500000002 R_X86_64_PC32          0000000000000000 .altinstr_aux + e
 00000000000033b1  0000015500000002 R_X86_64_PC32          0000000000000000 .altinstr_aux + 20
 00000000000037d9  0000039600000004 R_X86_64_PLT32         0000000000000000 raise_softirq_irqoff - 4
-000000000000384b  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
-00000000000038ab  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+000000000000384b  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
+00000000000038ab  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 00000000000039cd  0000037a00000004 R_X86_64_PLT32         0000000000000000 _raw_spin_lock - 4
 0000000000003a20  0000037a00000004 R_X86_64_PLT32         0000000000000000 _raw_spin_lock - 4
 0000000000004940  0000032900000004 R_X86_64_PLT32         0000000000000740 schedule - 4
@@ -14046,13 +14162,13 @@
 0000000000006571  0000037300000004 R_X86_64_PLT32         0000000000000000 refcount_warn_saturate - 4
 00000000000065c7  000003d600000004 R_X86_64_PLT32         0000000000000000 __put_task_struct - 4
 00000000000065d4  0000037300000004 R_X86_64_PLT32         0000000000000000 refcount_warn_saturate - 4
-0000000000006625  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000006625  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 00000000000066b6  0000035300000004 R_X86_64_PLT32         0000000000000000 _raw_spin_unlock_irqrestore - 4
 00000000000066cd  0000035300000004 R_X86_64_PLT32         0000000000000000 _raw_spin_unlock_irqrestore - 4
-0000000000006887  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
-0000000000006a0b  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000006887  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000006a0b  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 00000000000081f9  0000035300000004 R_X86_64_PLT32         0000000000000000 _raw_spin_unlock_irqrestore - 4
-000000000000828b  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+000000000000828b  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 00000000000082fd  0000036300000004 R_X86_64_PLT32         0000000000000000 rcu_read_unlock_strict - 4
 000000000000836c  0000036300000004 R_X86_64_PLT32         0000000000000000 rcu_read_unlock_strict - 4
 000000000000837b  0000036300000004 R_X86_64_PLT32         0000000000000000 rcu_read_unlock_strict - 4
@@ -14071,7 +14187,7 @@
 000000000000a5ff  0000049900000004 R_X86_64_PLT32         0000000000000000 call_rcu - 4
 000000000000a673  0000035300000004 R_X86_64_PLT32         0000000000000000 _raw_spin_unlock_irqrestore - 4
 
-Relocation section '.rela.data' at offset 0x285a8 contains 316 entries:
+Relocation section '.rela.data' at offset 0x14a20 contains 316 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000000200000001 R_X86_64_64            0000000000000000 .text + a4f0
 0000000000000008  0000000200000001 R_X86_64_64            0000000000000000 .text + a5d0
@@ -14390,7 +14506,7 @@
 0000000000002e80  000002ad00000001 R_X86_64_64            0000000000000040 __traceiter_sched_kthread_stop_ret + 0
 0000000000002e90  000002aa00000001 R_X86_64_64            0000000000000000 __traceiter_sched_kthread_stop + 0
 
-Relocation section '.rela__tracepoints_ptrs' at offset 0x2a348 contains 37 entries:
+Relocation section '.rela__tracepoints_ptrs' at offset 0x16858 contains 37 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  000002a800000002 R_X86_64_PC32          0000000000000d80 __tracepoint_sched_kthread_stop + 0
 0000000000000004  000002ab00000002 R_X86_64_PC32          0000000000000d20 __tracepoint_sched_kthread_stop_ret + 0
@@ -14430,7 +14546,7 @@
 000000000000008c  0000031100000002 R_X86_64_PC32          0000000000000060 __tracepoint_sched_util_est_se_tp + 0
 0000000000000090  0000031400000002 R_X86_64_PC32          0000000000000000 __tracepoint_sched_update_nr_running_tp + 0
 
-Relocation section '.rela.static_call.text' at offset 0x2a6c0 contains 37 entries:
+Relocation section '.rela.static_call.text' at offset 0x16cf8 contains 37 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000001  000002aa00000002 R_X86_64_PC32          0000000000000000 __traceiter_sched_kthread_stop - 4
 0000000000000009  000002ad00000002 R_X86_64_PC32          0000000000000040 __traceiter_sched_kthread_stop_ret - 4
@@ -14470,389 +14586,389 @@
 0000000000000119  0000031300000002 R_X86_64_PC32          0000000000000900 __traceiter_sched_util_est_se_tp - 4
 0000000000000121  0000031600000002 R_X86_64_PC32          0000000000000940 __traceiter_sched_update_nr_running_tp - 4
 
-Relocation section '.rela___ksymtab_gpl+__tracepoint_pelt_cfs_tp' at offset 0x2aa38 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+__tracepoint_pelt_cfs_tp' at offset 0x17700 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  000002f600000002 R_X86_64_PC32          00000000000003c0 __tracepoint_pelt_cfs_tp + 0
 0000000000000004  0000000800000002 R_X86_64_PC32          0000000000000000 __kstrtab___tracepoint_pelt_cfs_tp + 0
 0000000000000008  0000000900000002 R_X86_64_PC32          0000000000000019 __kstrtabns___tracepoint_pelt_cfs_tp + 0
 
-Relocation section '.rela___ksymtab_gpl+__traceiter_pelt_cfs_tp' at offset 0x2aa80 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+__traceiter_pelt_cfs_tp' at offset 0x17758 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  000002f800000002 R_X86_64_PC32          00000000000006c0 __traceiter_pelt_cfs_tp + 0
 0000000000000004  0000000c00000002 R_X86_64_PC32          000000000000001a __kstrtab___traceiter_pelt_cfs_tp + 0
 0000000000000008  0000000d00000002 R_X86_64_PC32          0000000000000032 __kstrtabns___traceiter_pelt_cfs_tp + 0
 
-Relocation section '.rela___ksymtab_gpl+__SCK__tp_func_pelt_cfs_tp' at offset 0x2aac8 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+__SCK__tp_func_pelt_cfs_tp' at offset 0x177b0 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000031700000002 R_X86_64_PC32          0000000000002cf0 __SCK__tp_func_pelt_cfs_tp + 0
 0000000000000004  0000001000000002 R_X86_64_PC32          0000000000000033 __kstrtab___SCK__tp_func_pelt_cfs_tp + 0
 0000000000000008  0000001100000002 R_X86_64_PC32          000000000000004e __kstrtabns___SCK__tp_func_pelt_cfs_tp + 0
 
-Relocation section '.rela___ksymtab_gpl+__SCT__tp_func_pelt_cfs_tp' at offset 0x2ab10 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+__SCT__tp_func_pelt_cfs_tp' at offset 0x17808 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  000002f700000002 R_X86_64_PC32          00000000000000d0 __SCT__tp_func_pelt_cfs_tp + 0
 0000000000000004  0000001400000002 R_X86_64_PC32          000000000000004f __kstrtab___SCT__tp_func_pelt_cfs_tp + 0
 0000000000000008  0000001500000002 R_X86_64_PC32          000000000000006a __kstrtabns___SCT__tp_func_pelt_cfs_tp + 0
 
-Relocation section '.rela___ksymtab_gpl+__tracepoint_pelt_rt_tp' at offset 0x2ab58 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+__tracepoint_pelt_rt_tp' at offset 0x17860 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  000002f900000002 R_X86_64_PC32          0000000000000360 __tracepoint_pelt_rt_tp + 0
 0000000000000004  0000001800000002 R_X86_64_PC32          000000000000006b __kstrtab___tracepoint_pelt_rt_tp + 0
 0000000000000008  0000001900000002 R_X86_64_PC32          0000000000000083 __kstrtabns___tracepoint_pelt_rt_tp + 0
 
-Relocation section '.rela___ksymtab_gpl+__traceiter_pelt_rt_tp' at offset 0x2aba0 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+__traceiter_pelt_rt_tp' at offset 0x178b8 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  000002fb00000002 R_X86_64_PC32          0000000000000700 __traceiter_pelt_rt_tp + 0
 0000000000000004  0000001c00000002 R_X86_64_PC32          0000000000000084 __kstrtab___traceiter_pelt_rt_tp + 0
 0000000000000008  0000001d00000002 R_X86_64_PC32          000000000000009b __kstrtabns___traceiter_pelt_rt_tp + 0
 
-Relocation section '.rela___ksymtab_gpl+__SCK__tp_func_pelt_rt_tp' at offset 0x2abe8 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+__SCK__tp_func_pelt_rt_tp' at offset 0x17910 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000031800000002 R_X86_64_PC32          0000000000002ce0 __SCK__tp_func_pelt_rt_tp + 0
 0000000000000004  0000002000000002 R_X86_64_PC32          000000000000009c __kstrtab___SCK__tp_func_pelt_rt_tp + 0
 0000000000000008  0000002100000002 R_X86_64_PC32          00000000000000b6 __kstrtabns___SCK__tp_func_pelt_rt_tp + 0
 
-Relocation section '.rela___ksymtab_gpl+__SCT__tp_func_pelt_rt_tp' at offset 0x2ac30 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+__SCT__tp_func_pelt_rt_tp' at offset 0x17968 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  000002fa00000002 R_X86_64_PC32          00000000000000d8 __SCT__tp_func_pelt_rt_tp + 0
 0000000000000004  0000002400000002 R_X86_64_PC32          00000000000000b7 __kstrtab___SCT__tp_func_pelt_rt_tp + 0
 0000000000000008  0000002500000002 R_X86_64_PC32          00000000000000d1 __kstrtabns___SCT__tp_func_pelt_rt_tp + 0
 
-Relocation section '.rela___ksymtab_gpl+__tracepoint_pelt_dl_tp' at offset 0x2ac78 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+__tracepoint_pelt_dl_tp' at offset 0x179c0 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  000002fc00000002 R_X86_64_PC32          0000000000000300 __tracepoint_pelt_dl_tp + 0
 0000000000000004  0000002800000002 R_X86_64_PC32          00000000000000d2 __kstrtab___tracepoint_pelt_dl_tp + 0
 0000000000000008  0000002900000002 R_X86_64_PC32          00000000000000ea __kstrtabns___tracepoint_pelt_dl_tp + 0
 
-Relocation section '.rela___ksymtab_gpl+__traceiter_pelt_dl_tp' at offset 0x2acc0 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+__traceiter_pelt_dl_tp' at offset 0x17a18 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  000002fe00000002 R_X86_64_PC32          0000000000000740 __traceiter_pelt_dl_tp + 0
 0000000000000004  0000002c00000002 R_X86_64_PC32          00000000000000eb __kstrtab___traceiter_pelt_dl_tp + 0
 0000000000000008  0000002d00000002 R_X86_64_PC32          0000000000000102 __kstrtabns___traceiter_pelt_dl_tp + 0
 
-Relocation section '.rela___ksymtab_gpl+__SCK__tp_func_pelt_dl_tp' at offset 0x2ad08 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+__SCK__tp_func_pelt_dl_tp' at offset 0x17a70 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000031900000002 R_X86_64_PC32          0000000000002cd0 __SCK__tp_func_pelt_dl_tp + 0
 0000000000000004  0000003000000002 R_X86_64_PC32          0000000000000103 __kstrtab___SCK__tp_func_pelt_dl_tp + 0
 0000000000000008  0000003100000002 R_X86_64_PC32          000000000000011d __kstrtabns___SCK__tp_func_pelt_dl_tp + 0
 
-Relocation section '.rela___ksymtab_gpl+__SCT__tp_func_pelt_dl_tp' at offset 0x2ad50 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+__SCT__tp_func_pelt_dl_tp' at offset 0x17ac8 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  000002fd00000002 R_X86_64_PC32          00000000000000e0 __SCT__tp_func_pelt_dl_tp + 0
 0000000000000004  0000003400000002 R_X86_64_PC32          000000000000011e __kstrtab___SCT__tp_func_pelt_dl_tp + 0
 0000000000000008  0000003500000002 R_X86_64_PC32          0000000000000138 __kstrtabns___SCT__tp_func_pelt_dl_tp + 0
 
-Relocation section '.rela___ksymtab_gpl+__tracepoint_pelt_irq_tp' at offset 0x2ad98 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+__tracepoint_pelt_irq_tp' at offset 0x17b20 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000030200000002 R_X86_64_PC32          0000000000000240 __tracepoint_pelt_irq_tp + 0
 0000000000000004  0000003800000002 R_X86_64_PC32          0000000000000139 __kstrtab___tracepoint_pelt_irq_tp + 0
 0000000000000008  0000003900000002 R_X86_64_PC32          0000000000000152 __kstrtabns___tracepoint_pelt_irq_tp + 0
 
-Relocation section '.rela___ksymtab_gpl+__traceiter_pelt_irq_tp' at offset 0x2ade0 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+__traceiter_pelt_irq_tp' at offset 0x17b78 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000030400000002 R_X86_64_PC32          00000000000007c0 __traceiter_pelt_irq_tp + 0
 0000000000000004  0000003c00000002 R_X86_64_PC32          0000000000000153 __kstrtab___traceiter_pelt_irq_tp + 0
 0000000000000008  0000003d00000002 R_X86_64_PC32          000000000000016b __kstrtabns___traceiter_pelt_irq_tp + 0
 
-Relocation section '.rela___ksymtab_gpl+__SCK__tp_func_pelt_irq_tp' at offset 0x2ae28 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+__SCK__tp_func_pelt_irq_tp' at offset 0x17bd0 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000031a00000002 R_X86_64_PC32          0000000000002cb0 __SCK__tp_func_pelt_irq_tp + 0
 0000000000000004  0000004000000002 R_X86_64_PC32          000000000000016c __kstrtab___SCK__tp_func_pelt_irq_tp + 0
 0000000000000008  0000004100000002 R_X86_64_PC32          0000000000000187 __kstrtabns___SCK__tp_func_pelt_irq_tp + 0
 
-Relocation section '.rela___ksymtab_gpl+__SCT__tp_func_pelt_irq_tp' at offset 0x2ae70 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+__SCT__tp_func_pelt_irq_tp' at offset 0x17c28 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000030300000002 R_X86_64_PC32          00000000000000f0 __SCT__tp_func_pelt_irq_tp + 0
 0000000000000004  0000004400000002 R_X86_64_PC32          0000000000000188 __kstrtab___SCT__tp_func_pelt_irq_tp + 0
 0000000000000008  0000004500000002 R_X86_64_PC32          00000000000001a3 __kstrtabns___SCT__tp_func_pelt_irq_tp + 0
 
-Relocation section '.rela___ksymtab_gpl+__tracepoint_pelt_se_tp' at offset 0x2aeb8 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+__tracepoint_pelt_se_tp' at offset 0x17c80 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000030500000002 R_X86_64_PC32          00000000000001e0 __tracepoint_pelt_se_tp + 0
 0000000000000004  0000004800000002 R_X86_64_PC32          00000000000001a4 __kstrtab___tracepoint_pelt_se_tp + 0
 0000000000000008  0000004900000002 R_X86_64_PC32          00000000000001bc __kstrtabns___tracepoint_pelt_se_tp + 0
 
-Relocation section '.rela___ksymtab_gpl+__traceiter_pelt_se_tp' at offset 0x2af00 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+__traceiter_pelt_se_tp' at offset 0x17cd8 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000030700000002 R_X86_64_PC32          0000000000000800 __traceiter_pelt_se_tp + 0
 0000000000000004  0000004c00000002 R_X86_64_PC32          00000000000001bd __kstrtab___traceiter_pelt_se_tp + 0
 0000000000000008  0000004d00000002 R_X86_64_PC32          00000000000001d4 __kstrtabns___traceiter_pelt_se_tp + 0
 
-Relocation section '.rela___ksymtab_gpl+__SCK__tp_func_pelt_se_tp' at offset 0x2af48 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+__SCK__tp_func_pelt_se_tp' at offset 0x17d30 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000031b00000002 R_X86_64_PC32          0000000000002ca0 __SCK__tp_func_pelt_se_tp + 0
 0000000000000004  0000005000000002 R_X86_64_PC32          00000000000001d5 __kstrtab___SCK__tp_func_pelt_se_tp + 0
 0000000000000008  0000005100000002 R_X86_64_PC32          00000000000001ef __kstrtabns___SCK__tp_func_pelt_se_tp + 0
 
-Relocation section '.rela___ksymtab_gpl+__SCT__tp_func_pelt_se_tp' at offset 0x2af90 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+__SCT__tp_func_pelt_se_tp' at offset 0x17d88 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000030600000002 R_X86_64_PC32          00000000000000f8 __SCT__tp_func_pelt_se_tp + 0
 0000000000000004  0000005400000002 R_X86_64_PC32          00000000000001f0 __kstrtab___SCT__tp_func_pelt_se_tp + 0
 0000000000000008  0000005500000002 R_X86_64_PC32          000000000000020a __kstrtabns___SCT__tp_func_pelt_se_tp + 0
 
-Relocation section '.rela___ksymtab_gpl+__tracepoint_sched_cpu_capacity_tp' at offset 0x2afd8 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+__tracepoint_sched_cpu_capacity_tp' at offset 0x17de0 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000030800000002 R_X86_64_PC32          0000000000000180 __tracepoint_sched_cpu_capacity_tp + 0
 0000000000000004  0000005800000002 R_X86_64_PC32          000000000000020b __kstrtab___tracepoint_sched_cpu_capacity_tp + 0
 0000000000000008  0000005900000002 R_X86_64_PC32          000000000000022e __kstrtabns___tracepoint_sched_cpu_capacity_tp + 0
 
-Relocation section '.rela___ksymtab_gpl+__traceiter_sched_cpu_capacity_tp' at offset 0x2b020 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+__traceiter_sched_cpu_capacity_tp' at offset 0x17e38 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000030a00000002 R_X86_64_PC32          0000000000000840 __traceiter_sched_cpu_capacity_tp + 0
 0000000000000004  0000005c00000002 R_X86_64_PC32          000000000000022f __kstrtab___traceiter_sched_cpu_capacity_tp + 0
 0000000000000008  0000005d00000002 R_X86_64_PC32          0000000000000251 __kstrtabns___traceiter_sched_cpu_capacity_tp + 0
 
-Relocation section '.rela___ksymtab_gpl+__SCK__tp_func_sched_cpu_capacity_tp' at offset 0x2b068 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+__SCK__tp_func_sched_cpu_capacity_tp' at offset 0x17e90 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000031c00000002 R_X86_64_PC32          0000000000002c90 __SCK__tp_func_sched_cpu_capacity_tp + 0
 0000000000000004  0000006000000002 R_X86_64_PC32          0000000000000252 __kstrtab___SCK__tp_func_sched_cpu_capacity_tp + 0
 0000000000000008  0000006100000002 R_X86_64_PC32          0000000000000277 __kstrtabns___SCK__tp_func_sched_cpu_capacity_tp + 0
 
-Relocation section '.rela___ksymtab_gpl+__SCT__tp_func_sched_cpu_capacity_tp' at offset 0x2b0b0 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+__SCT__tp_func_sched_cpu_capacity_tp' at offset 0x17ee8 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000030900000002 R_X86_64_PC32          0000000000000100 __SCT__tp_func_sched_cpu_capacity_tp + 0
 0000000000000004  0000006400000002 R_X86_64_PC32          0000000000000278 __kstrtab___SCT__tp_func_sched_cpu_capacity_tp + 0
 0000000000000008  0000006500000002 R_X86_64_PC32          000000000000029d __kstrtabns___SCT__tp_func_sched_cpu_capacity_tp + 0
 
-Relocation section '.rela___ksymtab_gpl+__tracepoint_sched_overutilized_tp' at offset 0x2b0f8 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+__tracepoint_sched_overutilized_tp' at offset 0x17f40 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000030b00000002 R_X86_64_PC32          0000000000000120 __tracepoint_sched_overutilized_tp + 0
 0000000000000004  0000006800000002 R_X86_64_PC32          000000000000029e __kstrtab___tracepoint_sched_overutilized_tp + 0
 0000000000000008  0000006900000002 R_X86_64_PC32          00000000000002c1 __kstrtabns___tracepoint_sched_overutilized_tp + 0
 
-Relocation section '.rela___ksymtab_gpl+__traceiter_sched_overutilized_tp' at offset 0x2b140 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+__traceiter_sched_overutilized_tp' at offset 0x17f98 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000030d00000002 R_X86_64_PC32          0000000000000880 __traceiter_sched_overutilized_tp + 0
 0000000000000004  0000006c00000002 R_X86_64_PC32          00000000000002c2 __kstrtab___traceiter_sched_overutilized_tp + 0
 0000000000000008  0000006d00000002 R_X86_64_PC32          00000000000002e4 __kstrtabns___traceiter_sched_overutilized_tp + 0
 
-Relocation section '.rela___ksymtab_gpl+__SCK__tp_func_sched_overutilized_tp' at offset 0x2b188 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+__SCK__tp_func_sched_overutilized_tp' at offset 0x17ff0 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000031d00000002 R_X86_64_PC32          0000000000002c80 __SCK__tp_func_sched_overutilized_tp + 0
 0000000000000004  0000007000000002 R_X86_64_PC32          00000000000002e5 __kstrtab___SCK__tp_func_sched_overutilized_tp + 0
 0000000000000008  0000007100000002 R_X86_64_PC32          000000000000030a __kstrtabns___SCK__tp_func_sched_overutilized_tp + 0
 
-Relocation section '.rela___ksymtab_gpl+__SCT__tp_func_sched_overutilized_tp' at offset 0x2b1d0 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+__SCT__tp_func_sched_overutilized_tp' at offset 0x18048 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000030c00000002 R_X86_64_PC32          0000000000000108 __SCT__tp_func_sched_overutilized_tp + 0
 0000000000000004  0000007400000002 R_X86_64_PC32          000000000000030b __kstrtab___SCT__tp_func_sched_overutilized_tp + 0
 0000000000000008  0000007500000002 R_X86_64_PC32          0000000000000330 __kstrtabns___SCT__tp_func_sched_overutilized_tp + 0
 
-Relocation section '.rela___ksymtab_gpl+__tracepoint_sched_util_est_cfs_tp' at offset 0x2b218 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+__tracepoint_sched_util_est_cfs_tp' at offset 0x180a0 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000030e00000002 R_X86_64_PC32          00000000000000c0 __tracepoint_sched_util_est_cfs_tp + 0
 0000000000000004  0000007800000002 R_X86_64_PC32          0000000000000331 __kstrtab___tracepoint_sched_util_est_cfs_tp + 0
 0000000000000008  0000007900000002 R_X86_64_PC32          0000000000000354 __kstrtabns___tracepoint_sched_util_est_cfs_tp + 0
 
-Relocation section '.rela___ksymtab_gpl+__traceiter_sched_util_est_cfs_tp' at offset 0x2b260 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+__traceiter_sched_util_est_cfs_tp' at offset 0x180f8 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000031000000002 R_X86_64_PC32          00000000000008c0 __traceiter_sched_util_est_cfs_tp + 0
 0000000000000004  0000007c00000002 R_X86_64_PC32          0000000000000355 __kstrtab___traceiter_sched_util_est_cfs_tp + 0
 0000000000000008  0000007d00000002 R_X86_64_PC32          0000000000000377 __kstrtabns___traceiter_sched_util_est_cfs_tp + 0
 
-Relocation section '.rela___ksymtab_gpl+__SCK__tp_func_sched_util_est_cfs_tp' at offset 0x2b2a8 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+__SCK__tp_func_sched_util_est_cfs_tp' at offset 0x18150 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000031e00000002 R_X86_64_PC32          0000000000002c70 __SCK__tp_func_sched_util_est_cfs_tp + 0
 0000000000000004  0000008000000002 R_X86_64_PC32          0000000000000378 __kstrtab___SCK__tp_func_sched_util_est_cfs_tp + 0
 0000000000000008  0000008100000002 R_X86_64_PC32          000000000000039d __kstrtabns___SCK__tp_func_sched_util_est_cfs_tp + 0
 
-Relocation section '.rela___ksymtab_gpl+__SCT__tp_func_sched_util_est_cfs_tp' at offset 0x2b2f0 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+__SCT__tp_func_sched_util_est_cfs_tp' at offset 0x181a8 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000030f00000002 R_X86_64_PC32          0000000000000110 __SCT__tp_func_sched_util_est_cfs_tp + 0
 0000000000000004  0000008400000002 R_X86_64_PC32          000000000000039e __kstrtab___SCT__tp_func_sched_util_est_cfs_tp + 0
 0000000000000008  0000008500000002 R_X86_64_PC32          00000000000003c3 __kstrtabns___SCT__tp_func_sched_util_est_cfs_tp + 0
 
-Relocation section '.rela___ksymtab_gpl+__tracepoint_sched_util_est_se_tp' at offset 0x2b338 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+__tracepoint_sched_util_est_se_tp' at offset 0x18200 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000031100000002 R_X86_64_PC32          0000000000000060 __tracepoint_sched_util_est_se_tp + 0
 0000000000000004  0000008800000002 R_X86_64_PC32          00000000000003c4 __kstrtab___tracepoint_sched_util_est_se_tp + 0
 0000000000000008  0000008900000002 R_X86_64_PC32          00000000000003e6 __kstrtabns___tracepoint_sched_util_est_se_tp + 0
 
-Relocation section '.rela___ksymtab_gpl+__traceiter_sched_util_est_se_tp' at offset 0x2b380 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+__traceiter_sched_util_est_se_tp' at offset 0x18258 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000031300000002 R_X86_64_PC32          0000000000000900 __traceiter_sched_util_est_se_tp + 0
 0000000000000004  0000008c00000002 R_X86_64_PC32          00000000000003e7 __kstrtab___traceiter_sched_util_est_se_tp + 0
 0000000000000008  0000008d00000002 R_X86_64_PC32          0000000000000408 __kstrtabns___traceiter_sched_util_est_se_tp + 0
 
-Relocation section '.rela___ksymtab_gpl+__SCK__tp_func_sched_util_est_se_tp' at offset 0x2b3c8 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+__SCK__tp_func_sched_util_est_se_tp' at offset 0x182b0 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000031f00000002 R_X86_64_PC32          0000000000002c60 __SCK__tp_func_sched_util_est_se_tp + 0
 0000000000000004  0000009000000002 R_X86_64_PC32          0000000000000409 __kstrtab___SCK__tp_func_sched_util_est_se_tp + 0
 0000000000000008  0000009100000002 R_X86_64_PC32          000000000000042d __kstrtabns___SCK__tp_func_sched_util_est_se_tp + 0
 
-Relocation section '.rela___ksymtab_gpl+__SCT__tp_func_sched_util_est_se_tp' at offset 0x2b410 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+__SCT__tp_func_sched_util_est_se_tp' at offset 0x18308 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000031200000002 R_X86_64_PC32          0000000000000118 __SCT__tp_func_sched_util_est_se_tp + 0
 0000000000000004  0000009400000002 R_X86_64_PC32          000000000000042e __kstrtab___SCT__tp_func_sched_util_est_se_tp + 0
 0000000000000008  0000009500000002 R_X86_64_PC32          0000000000000452 __kstrtabns___SCT__tp_func_sched_util_est_se_tp + 0
 
-Relocation section '.rela___ksymtab_gpl+__tracepoint_sched_update_nr_running_tp' at offset 0x2b458 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+__tracepoint_sched_update_nr_running_tp' at offset 0x18360 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000031400000002 R_X86_64_PC32          0000000000000000 __tracepoint_sched_update_nr_running_tp + 0
 0000000000000004  0000009800000002 R_X86_64_PC32          0000000000000453 __kstrtab___tracepoint_sched_update_nr_running_tp + 0
 0000000000000008  0000009900000002 R_X86_64_PC32          000000000000047b __kstrtabns___tracepoint_sched_update_nr_running_tp + 0
 
-Relocation section '.rela___ksymtab_gpl+__traceiter_sched_update_nr_running_tp' at offset 0x2b4a0 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+__traceiter_sched_update_nr_running_tp' at offset 0x183b8 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000031600000002 R_X86_64_PC32          0000000000000940 __traceiter_sched_update_nr_running_tp + 0
 0000000000000004  0000009c00000002 R_X86_64_PC32          000000000000047c __kstrtab___traceiter_sched_update_nr_running_tp + 0
 0000000000000008  0000009d00000002 R_X86_64_PC32          00000000000004a3 __kstrtabns___traceiter_sched_update_nr_running_tp + 0
 
-Relocation section '.rela___ksymtab_gpl+__SCK__tp_func_sched_update_nr_running_tp' at offset 0x2b4e8 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+__SCK__tp_func_sched_update_nr_running_tp' at offset 0x18410 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000032000000002 R_X86_64_PC32          0000000000002c50 __SCK__tp_func_sched_update_nr_running_tp + 0
 0000000000000004  000000a000000002 R_X86_64_PC32          00000000000004a4 __kstrtab___SCK__tp_func_sched_update_nr_running_tp + 0
 0000000000000008  000000a100000002 R_X86_64_PC32          00000000000004ce __kstrtabns___SCK__tp_func_sched_update_nr_running_tp + 0
 
-Relocation section '.rela___ksymtab_gpl+__SCT__tp_func_sched_update_nr_running_tp' at offset 0x2b530 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+__SCT__tp_func_sched_update_nr_running_tp' at offset 0x18468 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000031500000002 R_X86_64_PC32          0000000000000120 __SCT__tp_func_sched_update_nr_running_tp + 0
 0000000000000004  000000a400000002 R_X86_64_PC32          00000000000004cf __kstrtab___SCT__tp_func_sched_update_nr_running_tp + 0
 0000000000000008  000000a500000002 R_X86_64_PC32          00000000000004f9 __kstrtabns___SCT__tp_func_sched_update_nr_running_tp + 0
 
-Relocation section '.rela___ksymtab_gpl+migrate_disable' at offset 0x2b578 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+migrate_disable' at offset 0x184c0 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000032100000002 R_X86_64_PC32          0000000000000980 migrate_disable + 0
 0000000000000004  000000a800000002 R_X86_64_PC32          00000000000004fa __kstrtab_migrate_disable + 0
 0000000000000008  000000a900000002 R_X86_64_PC32          000000000000050a __kstrtabns_migrate_disable + 0
 
-Relocation section '.rela___ksymtab_gpl+migrate_enable' at offset 0x2b5c0 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+migrate_enable' at offset 0x18518 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000032200000002 R_X86_64_PC32          0000000000007ba0 migrate_enable + 0
 0000000000000004  000000ac00000002 R_X86_64_PC32          000000000000050b __kstrtab_migrate_enable + 0
 0000000000000008  000000ad00000002 R_X86_64_PC32          000000000000051a __kstrtabns_migrate_enable + 0
 
-Relocation section '.rela___ksymtab_gpl+set_cpus_allowed_ptr' at offset 0x2b608 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+set_cpus_allowed_ptr' at offset 0x18570 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000032300000002 R_X86_64_PC32          0000000000007c10 set_cpus_allowed_ptr + 0
 0000000000000004  000000b000000002 R_X86_64_PC32          000000000000051b __kstrtab_set_cpus_allowed_ptr + 0
 0000000000000008  000000b100000002 R_X86_64_PC32          0000000000000530 __kstrtabns_set_cpus_allowed_ptr + 0
 
-Relocation section '.rela___ksymtab_gpl+kick_process' at offset 0x2b650 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+kick_process' at offset 0x185c8 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000032400000002 R_X86_64_PC32          00000000000009d0 kick_process + 0
 0000000000000004  000000b400000002 R_X86_64_PC32          0000000000000531 __kstrtab_kick_process + 0
 0000000000000008  000000b500000002 R_X86_64_PC32          000000000000053e __kstrtabns_kick_process + 0
 
-Relocation section '.rela___ksymtab+wake_up_process' at offset 0x2b698 contains 3 entries:
+Relocation section '.rela___ksymtab+wake_up_process' at offset 0x18620 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000032500000002 R_X86_64_PC32          00000000000073b0 wake_up_process + 0
 0000000000000004  000000b800000002 R_X86_64_PC32          000000000000053f __kstrtab_wake_up_process + 0
 0000000000000008  000000b900000002 R_X86_64_PC32          000000000000054f __kstrtabns_wake_up_process + 0
 
-Relocation section '.rela___ksymtab+single_task_running' at offset 0x2b6e0 contains 3 entries:
+Relocation section '.rela___ksymtab+single_task_running' at offset 0x18678 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000032600000002 R_X86_64_PC32          0000000000000a10 single_task_running + 0
 0000000000000004  000000bc00000002 R_X86_64_PC32          0000000000000550 __kstrtab_single_task_running + 0
 0000000000000008  000000bd00000002 R_X86_64_PC32          0000000000000564 __kstrtabns_single_task_running + 0
 
-Relocation section '.rela___ksymtab+kstat' at offset 0x2b728 contains 3 entries:
+Relocation section '.rela___ksymtab+kstat' at offset 0x186d0 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000032700000002 R_X86_64_PC32          00000000000000a0 kstat + 0
 0000000000000004  000000c000000002 R_X86_64_PC32          0000000000000565 __kstrtab_kstat + 0
 0000000000000008  000000c100000002 R_X86_64_PC32          000000000000056b __kstrtabns_kstat + 0
 
-Relocation section '.rela___ksymtab+kernel_cpustat' at offset 0x2b770 contains 3 entries:
+Relocation section '.rela___ksymtab+kernel_cpustat' at offset 0x18728 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000032800000002 R_X86_64_PC32          0000000000000040 kernel_cpustat + 0
 0000000000000004  000000c400000002 R_X86_64_PC32          000000000000056c __kstrtab_kernel_cpustat + 0
 0000000000000008  000000c500000002 R_X86_64_PC32          000000000000057b __kstrtabns_kernel_cpustat + 0
 
-Relocation section '.rela___ksymtab+schedule' at offset 0x2b7b8 contains 3 entries:
+Relocation section '.rela___ksymtab+schedule' at offset 0x18780 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000032900000002 R_X86_64_PC32          0000000000000740 schedule + 0
 0000000000000004  000000c800000002 R_X86_64_PC32          000000000000057c __kstrtab_schedule + 0
 0000000000000008  000000c900000002 R_X86_64_PC32          0000000000000585 __kstrtabns_schedule + 0
 
-Relocation section '.rela___ksymtab+default_wake_function' at offset 0x2b800 contains 3 entries:
+Relocation section '.rela___ksymtab+default_wake_function' at offset 0x187d8 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000032a00000002 R_X86_64_PC32          0000000000007450 default_wake_function + 0
 0000000000000004  000000cc00000002 R_X86_64_PC32          0000000000000586 __kstrtab_default_wake_function + 0
 0000000000000008  000000cd00000002 R_X86_64_PC32          000000000000059c __kstrtabns_default_wake_function + 0
 
-Relocation section '.rela___ksymtab+set_user_nice' at offset 0x2b848 contains 3 entries:
+Relocation section '.rela___ksymtab+set_user_nice' at offset 0x18830 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000032b00000002 R_X86_64_PC32          00000000000051f0 set_user_nice + 0
 0000000000000004  000000d000000002 R_X86_64_PC32          000000000000059d __kstrtab_set_user_nice + 0
 0000000000000008  000000d100000002 R_X86_64_PC32          00000000000005ab __kstrtabns_set_user_nice + 0
 
-Relocation section '.rela___ksymtab_gpl+sched_set_fifo' at offset 0x2b890 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+sched_set_fifo' at offset 0x18888 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000032c00000002 R_X86_64_PC32          00000000000063a0 sched_set_fifo + 0
 0000000000000004  000000d400000002 R_X86_64_PC32          00000000000005ac __kstrtab_sched_set_fifo + 0
 0000000000000008  000000d500000002 R_X86_64_PC32          00000000000005bb __kstrtabns_sched_set_fifo + 0
 
-Relocation section '.rela___ksymtab_gpl+sched_set_fifo_low' at offset 0x2b8d8 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+sched_set_fifo_low' at offset 0x188e0 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000032d00000002 R_X86_64_PC32          0000000000006420 sched_set_fifo_low + 0
 0000000000000004  000000d800000002 R_X86_64_PC32          00000000000005bc __kstrtab_sched_set_fifo_low + 0
 0000000000000008  000000d900000002 R_X86_64_PC32          00000000000005cf __kstrtabns_sched_set_fifo_low + 0
 
-Relocation section '.rela___ksymtab_gpl+sched_set_normal' at offset 0x2b920 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+sched_set_normal' at offset 0x18938 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000032e00000002 R_X86_64_PC32          0000000000005fd0 sched_set_normal + 0
 0000000000000004  000000dc00000002 R_X86_64_PC32          00000000000005d0 __kstrtab_sched_set_normal + 0
 0000000000000008  000000dd00000002 R_X86_64_PC32          00000000000005e1 __kstrtabns_sched_set_normal + 0
 
-Relocation section '.rela___ksymtab+__cond_resched' at offset 0x2b968 contains 3 entries:
+Relocation section '.rela___ksymtab+__cond_resched' at offset 0x18990 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000032f00000002 R_X86_64_PC32          0000000000000870 __cond_resched + 0
 0000000000000004  000000e000000002 R_X86_64_PC32          00000000000005e2 __kstrtab___cond_resched + 0
 0000000000000008  000000e100000002 R_X86_64_PC32          00000000000005f1 __kstrtabns___cond_resched + 0
 
-Relocation section '.rela___ksymtab+__cond_resched_lock' at offset 0x2b9b0 contains 3 entries:
+Relocation section '.rela___ksymtab+__cond_resched_lock' at offset 0x189e8 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000033000000002 R_X86_64_PC32          00000000000049a0 __cond_resched_lock + 0
 0000000000000004  000000e400000002 R_X86_64_PC32          00000000000005f2 __kstrtab___cond_resched_lock + 0
 0000000000000008  000000e500000002 R_X86_64_PC32          0000000000000606 __kstrtabns___cond_resched_lock + 0
 
-Relocation section '.rela___ksymtab+__cond_resched_rwlock_read' at offset 0x2b9f8 contains 3 entries:
+Relocation section '.rela___ksymtab+__cond_resched_rwlock_read' at offset 0x18a40 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000033100000002 R_X86_64_PC32          00000000000049e0 __cond_resched_rwlock_read + 0
 0000000000000004  000000e800000002 R_X86_64_PC32          0000000000000607 __kstrtab___cond_resched_rwlock_read + 0
 0000000000000008  000000e900000002 R_X86_64_PC32          0000000000000622 __kstrtabns___cond_resched_rwlock_read + 0
 
-Relocation section '.rela___ksymtab+__cond_resched_rwlock_write' at offset 0x2ba40 contains 3 entries:
+Relocation section '.rela___ksymtab+__cond_resched_rwlock_write' at offset 0x18a98 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000033200000002 R_X86_64_PC32          0000000000004960 __cond_resched_rwlock_write + 0
 0000000000000004  000000ec00000002 R_X86_64_PC32          0000000000000623 __kstrtab___cond_resched_rwlock_write + 0
 0000000000000008  000000ed00000002 R_X86_64_PC32          000000000000063f __kstrtabns___cond_resched_rwlock_write + 0
 
-Relocation section '.rela___ksymtab+yield' at offset 0x2ba88 contains 3 entries:
+Relocation section '.rela___ksymtab+yield' at offset 0x18af0 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000033300000002 R_X86_64_PC32          00000000000007e0 yield + 0
 0000000000000004  000000f000000002 R_X86_64_PC32          0000000000000640 __kstrtab_yield + 0
 0000000000000008  000000f100000002 R_X86_64_PC32          0000000000000646 __kstrtabns_yield + 0
 
-Relocation section '.rela___ksymtab_gpl+yield_to' at offset 0x2bad0 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+yield_to' at offset 0x18b48 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000033400000002 R_X86_64_PC32          00000000000008b0 yield_to + 0
 0000000000000004  000000f400000002 R_X86_64_PC32          0000000000000647 __kstrtab_yield_to + 0
 0000000000000008  000000f500000002 R_X86_64_PC32          0000000000000650 __kstrtabns_yield_to + 0
 
-Relocation section '.rela___ksymtab+io_schedule_timeout' at offset 0x2bb18 contains 3 entries:
+Relocation section '.rela___ksymtab+io_schedule_timeout' at offset 0x18ba0 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000033500000002 R_X86_64_PC32          0000000000000000 io_schedule_timeout + 0
 0000000000000004  000000f800000002 R_X86_64_PC32          0000000000000651 __kstrtab_io_schedule_timeout + 0
 0000000000000008  000000f900000002 R_X86_64_PC32          0000000000000665 __kstrtabns_io_schedule_timeout + 0
 
-Relocation section '.rela___ksymtab+io_schedule' at offset 0x2bb60 contains 3 entries:
+Relocation section '.rela___ksymtab+io_schedule' at offset 0x18bf8 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000033600000002 R_X86_64_PC32          0000000000000810 io_schedule + 0
 0000000000000004  000000fc00000002 R_X86_64_PC32          0000000000000666 __kstrtab_io_schedule + 0
 0000000000000008  000000fd00000002 R_X86_64_PC32          0000000000000672 __kstrtabns_io_schedule + 0
 
-Relocation section '.rela___ksymtab_gpl+sched_show_task' at offset 0x2bba8 contains 3 entries:
+Relocation section '.rela___ksymtab_gpl+sched_show_task' at offset 0x18c50 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000033700000002 R_X86_64_PC32          0000000000002b90 sched_show_task + 0
 0000000000000004  0000010000000002 R_X86_64_PC32          0000000000000673 __kstrtab_sched_show_task + 0
 0000000000000008  0000010100000002 R_X86_64_PC32          0000000000000683 __kstrtabns_sched_show_task + 0
 
-Relocation section '.rela.initcallearly.init' at offset 0x2bbf0 contains 1 entry:
+Relocation section '.rela.initcallearly.init' at offset 0x18ca0 contains 1 entry:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000013700000002 R_X86_64_PC32          0000000000000000 .init.text + 58
 
-Relocation section '.rela.altinstructions' at offset 0x2bc08 contains 11 entries:
+Relocation section '.rela.altinstructions' at offset 0x192f8 contains 243 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000000200000002 R_X86_64_PC32          0000000000000000 .text + b83
 0000000000000004  0000010c00000002 R_X86_64_PC32          0000000000000000 .altinstr_replacement + 0
@@ -14865,14 +14981,246 @@
 0000000000000041  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 33b0
 0000000000000045  0000010c00000002 R_X86_64_PC32          0000000000000000 .altinstr_replacement + f
 000000000000004e  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 33b0
+000000000000005b  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 384a
+000000000000005f  000004be00000002 R_X86_64_PC32          0000000000000000 __x86_alt_jmp_rax + 0
+0000000000000068  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 38aa
+000000000000006c  000004be00000002 R_X86_64_PC32          0000000000000000 __x86_alt_jmp_rax + 0
+0000000000000075  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6624
+0000000000000079  000004be00000002 R_X86_64_PC32          0000000000000000 __x86_alt_jmp_rax + 0
+0000000000000082  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6886
+0000000000000086  000004be00000002 R_X86_64_PC32          0000000000000000 __x86_alt_jmp_rax + 0
+000000000000008f  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6a0a
+0000000000000093  000004be00000002 R_X86_64_PC32          0000000000000000 __x86_alt_jmp_rax + 0
+000000000000009c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 828a
+00000000000000a0  000004be00000002 R_X86_64_PC32          0000000000000000 __x86_alt_jmp_rax + 0
+00000000000000a9  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1f
+00000000000000ad  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+00000000000000b6  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5d
+00000000000000ba  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+00000000000000c3  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 97
+00000000000000c7  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+00000000000000d0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + cf
+00000000000000d4  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+00000000000000dd  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 117
+00000000000000e1  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+00000000000000ea  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 14f
+00000000000000ee  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+00000000000000f7  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 18f
+00000000000000fb  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+0000000000000104  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1cf
+0000000000000108  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+0000000000000111  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 21f
+0000000000000115  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+000000000000011e  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 267
+0000000000000122  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+000000000000012b  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 29f
+000000000000012f  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+0000000000000138  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2df
+000000000000013c  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+0000000000000145  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 31f
+0000000000000149  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+0000000000000152  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 35f
+0000000000000156  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+000000000000015f  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3a7
+0000000000000163  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+000000000000016c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3ef
+0000000000000170  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+0000000000000179  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 437
+000000000000017d  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+0000000000000186  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 477
+000000000000018a  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+0000000000000193  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4b7
+0000000000000197  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+00000000000001a0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4f7
+00000000000001a4  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+00000000000001ad  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 53f
+00000000000001b1  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+00000000000001ba  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 587
+00000000000001be  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+00000000000001c7  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5cf
+00000000000001cb  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+00000000000001d4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 627
+00000000000001d8  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+00000000000001e1  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 677
+00000000000001e5  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+00000000000001ee  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6ad
+00000000000001f2  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+00000000000001fb  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6df
+00000000000001ff  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+0000000000000208  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 71f
+000000000000020c  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+0000000000000215  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 75f
+0000000000000219  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+0000000000000222  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 79f
+0000000000000226  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+000000000000022f  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7df
+0000000000000233  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+000000000000023c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 81f
+0000000000000240  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+0000000000000249  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 85f
+000000000000024d  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+0000000000000256  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8a6
+000000000000025a  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+0000000000000263  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8df
+0000000000000267  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+0000000000000270  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 91f
+0000000000000274  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+000000000000027d  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 967
+0000000000000281  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+000000000000028a  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a07
+000000000000028e  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+0000000000000297  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2f2c
+000000000000029b  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+00000000000002a4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2fa9
+00000000000002a8  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+00000000000002b1  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 31a0
+00000000000002b5  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+00000000000002be  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 32c3
+00000000000002c2  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+00000000000002cb  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3391
+00000000000002cf  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+00000000000002d8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3865
+00000000000002dc  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+00000000000002e5  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3887
+00000000000002e9  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+00000000000002f2  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 38c0
+00000000000002f6  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+00000000000002ff  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 38d9
+0000000000000303  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+000000000000030c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3917
+0000000000000310  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+0000000000000319  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3930
+000000000000031d  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+0000000000000326  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 394a
+000000000000032a  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+0000000000000333  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4935
+0000000000000337  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+0000000000000340  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4dd3
+0000000000000344  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+000000000000034d  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 50ca
+0000000000000351  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+000000000000035a  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5146
+000000000000035e  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+0000000000000367  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5170
+000000000000036b  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+0000000000000374  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 519b
+0000000000000378  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+0000000000000381  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 51c2
+0000000000000385  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+000000000000038e  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5413
+0000000000000392  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+000000000000039b  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 57f0
+000000000000039f  000004c000000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rdx + 0
+00000000000003a8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5809
+00000000000003ac  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+00000000000003b5  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 59b6
+00000000000003b9  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+00000000000003c2  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5a1f
+00000000000003c6  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+00000000000003cf  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5a84
+00000000000003d3  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+00000000000003dc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5b00
+00000000000003e0  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+00000000000003e9  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5b3d
+00000000000003ed  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+00000000000003f6  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5b8a
+00000000000003fa  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+0000000000000403  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 64c3
+0000000000000407  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+0000000000000410  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 68df
+0000000000000414  000004c100000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_r13 + 0
+000000000000041d  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 690b
+0000000000000421  000004c200000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_r12 + 0
+000000000000042a  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 69a7
+000000000000042e  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+0000000000000437  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6afb
+000000000000043b  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+0000000000000444  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6b40
+0000000000000448  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+0000000000000451  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6c40
+0000000000000455  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+000000000000045e  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6d2c
+0000000000000462  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+000000000000046b  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6e9c
+000000000000046f  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+0000000000000478  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6f57
+000000000000047c  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+0000000000000485  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6fa7
+0000000000000489  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+0000000000000492  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 70a8
+0000000000000496  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+000000000000049f  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 74bf
+00000000000004a3  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+00000000000004ac  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 752a
+00000000000004b0  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+00000000000004b9  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8356
+00000000000004bd  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+00000000000004c6  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8450
+00000000000004ca  000004c300000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rbx + 0
+00000000000004d3  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 84be
+00000000000004d7  000004c300000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rbx + 0
+00000000000004e0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 877f
+00000000000004e4  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+00000000000004ed  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8ac4
+00000000000004f1  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+00000000000004fa  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8afb
+00000000000004fe  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+0000000000000507  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8b43
+000000000000050b  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+0000000000000514  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8d49
+0000000000000518  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+0000000000000521  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8e9e
+0000000000000525  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+000000000000052e  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8f13
+0000000000000532  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+000000000000053b  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 90e2
+000000000000053f  000004c000000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rdx + 0
+0000000000000548  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 90fc
+000000000000054c  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+0000000000000555  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 912c
+0000000000000559  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+0000000000000562  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 91da
+0000000000000566  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+000000000000056f  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 91f9
+0000000000000573  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+000000000000057c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 921d
+0000000000000580  000004c400000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_r8 + 0
+0000000000000589  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 925f
+000000000000058d  000004c400000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_r8 + 0
+0000000000000596  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9299
+000000000000059a  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+00000000000005a3  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a70c
+00000000000005a7  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+00000000000005b0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a771
+00000000000005b4  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+00000000000005bd  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a79b
+00000000000005c1  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+00000000000005ca  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a7ba
+00000000000005ce  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+00000000000005d7  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a7e4
+00000000000005db  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+00000000000005e4  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 41a
+00000000000005e8  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+00000000000005f1  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 479
+00000000000005f5  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+00000000000005fe  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 4ab
+0000000000000602  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+000000000000060b  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 4c9
+000000000000060f  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+0000000000000618  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 5f4
+000000000000061c  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+0000000000000625  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 651
+0000000000000629  000004bf00000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rax + 0
+0000000000000632  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 9bf
+0000000000000636  000004c000000002 R_X86_64_PC32          0000000000000000 __x86_alt_call_rdx + 0
 
-Relocation section '.rela.altinstr_replacement' at offset 0x2bd10 contains 3 entries:
+Relocation section '.rela.altinstr_replacement' at offset 0x1a9d8 contains 3 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000006  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3316
 000000000000000b  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3323
 0000000000000010  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 33f1
 
-Relocation section '.rela__bug_table' at offset 0x2bd58 contains 94 entries:
+Relocation section '.rela__bug_table' at offset 0x1b310 contains 94 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 25ac
 0000000000000004  000002a500000002 R_X86_64_PC32          0000000000000064 .LC21 + 4
@@ -14969,7 +15317,7 @@
 0000000000000228  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a844
 000000000000022c  000002a600000002 R_X86_64_PC32          00000000000000d1 .LC34 + 4
 
-Relocation section '.rela.discard.reachable' at offset 0x2c628 contains 32 entries:
+Relocation section '.rela.discard.reachable' at offset 0x1bc60 contains 32 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 25ae
 0000000000000004  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2a72
@@ -15004,7 +15352,7 @@
 0000000000000078  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a78a
 000000000000007c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a846
 
-Relocation section '.rela.init.text' at offset 0x2c928 contains 115 entries:
+Relocation section '.rela.init.text' at offset 0x1c490 contains 115 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000009  0000011e0000000b R_X86_64_32S           0000000000000000 .rodata.str1.1 + 78
 0000000000000011  0000035400000004 R_X86_64_PLT32         0000000000000000 strcmp - 4
@@ -15122,7 +15470,7 @@
 0000000000000513  0000041300000004 R_X86_64_PLT32         0000000000000000 static_key_disable - 4
 0000000000000519  0000048f00000002 R_X86_64_PC32          000000000000000c scheduler_running - 8
 
-Relocation section '.rela.text.unlikely' at offset 0x2d3f0 contains 47 entries:
+Relocation section '.rela.text.unlikely' at offset 0x1d1c0 contains 47 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000010  000001210000000b R_X86_64_32S           0000000000000000 .rodata.str1.8 + 298
 0000000000000017  0000035700000002 R_X86_64_PC32          0000000000000000 __preempt_count - 4
@@ -15172,7 +15520,7 @@
 00000000000001fa  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a271
 0000000000000262  0000033700000004 R_X86_64_PLT32         0000000000002b90 sched_show_task - 4
 
-Relocation section '.rela.smp_locks' at offset 0x2d858 contains 45 entries:
+Relocation section '.rela.smp_locks' at offset 0x1d6e0 contains 45 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2bae
 0000000000000004  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2f4a
@@ -15220,7 +15568,7 @@
 00000000000000ac  0000013700000002 R_X86_64_PC32          0000000000000000 .init.text + 4af
 00000000000000b0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a42e
 
-Relocation section '.rela.sched.text' at offset 0x2dc90 contains 83 entries:
+Relocation section '.rela.sched.text' at offset 0x1e5b8 contains 83 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 000000000000000a  000003390000000b R_X86_64_32S           0000000000000000 current_task + 0
 0000000000000038  0000038200000004 R_X86_64_PLT32         0000000000000000 blk_flush_plug_list - 4
@@ -15245,24 +15593,24 @@
 00000000000002eb  000003a100000002 R_X86_64_PC32          0000000000000000 __cpu_online_mask - 4
 00000000000002f8  000002c000000002 R_X86_64_PC32          0000000000000a80 __tracepoint_sched_switch + 3c
 000000000000030f  000002c100000004 R_X86_64_PLT32         0000000000000040 __SCT__tp_func_sched_switch - 4
-000000000000041b  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+000000000000041b  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000000442  0000039d0000000b R_X86_64_32S           0000000000000000 fair_sched_class + 0
 000000000000044f  000003a20000000b R_X86_64_32S           0000000000000000 idle_sched_class + 0
 0000000000000465  000003a20000000b R_X86_64_32S           0000000000000000 idle_sched_class + 0
-000000000000047a  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+000000000000047a  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 00000000000004a3  0000038000000001 R_X86_64_64            0000000000000000 __begin_sched_classes - c8
-00000000000004ac  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+00000000000004ac  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 00000000000004b2  0000038100000001 R_X86_64_64            0000000000000000 __end_sched_classes - c8
-00000000000004ca  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+00000000000004ca  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 00000000000004ef  000003a300000004 R_X86_64_PLT32         0000000000000000 __perf_event_task_sched_out - 4
 00000000000004fb  000003880000000b R_X86_64_32S           0000000000000000 __perf_regs + 0
 0000000000000503  0000033b00000002 R_X86_64_PC32          0000000000000000 this_cpu_off - 4
 000000000000053c  0000038900000004 R_X86_64_PLT32         0000000000000000 ___perf_sw_event - 4
 0000000000000549  000003a400000004 R_X86_64_PLT32         0000000000000000 enter_lazy_tlb - 4
-00000000000005f5  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+00000000000005f5  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 00000000000005fd  000003a500000004 R_X86_64_PLT32         0000000000000000 pick_next_task_idle - 4
 0000000000000614  000003a600000004 R_X86_64_PLT32         0000000000000000 profile_hits - 4
-0000000000000652  0000033800000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rax - 4
+0000000000000652  0000033800000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rax - 4
 0000000000000668  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 25ac
 000000000000066f  0000035700000002 R_X86_64_PC32          0000000000000000 __preempt_count - 4
 0000000000000681  0000035700000002 R_X86_64_PC32          0000000000000000 __preempt_count - 4
@@ -15294,7 +15642,7 @@
 000000000000092b  0000033d0000000b R_X86_64_32S           0000000000000000 __per_cpu_offset + 0
 0000000000000949  0000037a00000004 R_X86_64_PLT32         0000000000000000 _raw_spin_lock - 4
 0000000000000951  0000037a00000004 R_X86_64_PLT32         0000000000000000 _raw_spin_lock - 4
-00000000000009c0  000003cb00000004 R_X86_64_PLT32         0000000000000000 __x86_indirect_thunk_rdx - 4
+00000000000009c0  000003cb00000000 R_X86_64_NONE          0000000000000000 __x86_indirect_thunk_rdx - 4
 00000000000009dd  000003e100000004 R_X86_64_PLT32         00000000000065e0 resched_curr - 4
 00000000000009ed  0000032900000004 R_X86_64_PLT32         0000000000000740 schedule - 4
 0000000000000a26  000003390000000b R_X86_64_32S           0000000000000000 current_task + 0
@@ -15306,7 +15654,7 @@
 00000000000007c3  000003ab00000004 R_X86_64_PLT32         0000000000000000 io_wq_worker_running - 4
 000000000000080a  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 48fc
 
-Relocation section '.rela__jump_table' at offset 0x2e458 contains 87 entries:
+Relocation section '.rela__jump_table' at offset 0x1ef50 contains 87 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3162
 0000000000000004  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 324e
@@ -15396,7 +15744,7 @@
 00000000000001c4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a8b6
 00000000000001c8  0000031400000018 R_X86_64_PC64          0000000000000000 __tracepoint_sched_update_nr_running_tp + 8
 
-Relocation section '.rela.altinstr_aux' at offset 0x2ec80 contains 9 entries:
+Relocation section '.rela.altinstr_aux' at offset 0x1f7b0 contains 9 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000002  0000038b00000002 R_X86_64_PC32          0000000000000000 boot_cpu_data + 38
 0000000000000014  0000038b00000002 R_X86_64_PC32          0000000000000000 boot_cpu_data + 64
@@ -15408,7 +15756,7 @@
 000000000000002d  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 33bf
 0000000000000032  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 33f1
 
-Relocation section '.rela.discard.unreachable' at offset 0x2ed58 contains 15 entries:
+Relocation section '.rela.discard.unreachable' at offset 0x1f8c8 contains 15 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 4e8
 0000000000000004  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4c34
@@ -15426,7 +15774,7 @@
 0000000000000034  0000013700000002 R_X86_64_PC32          0000000000000000 .init.text + 12e
 0000000000000038  0000013700000002 R_X86_64_PC32          0000000000000000 .init.text + 130
 
-Relocation section '.rela.rodata' at offset 0x2eec0 contains 8 entries:
+Relocation section '.rela.rodata' at offset 0x1fc70 contains 8 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000048  0000011e00000001 R_X86_64_64            0000000000000000 .rodata.str1.1 + 13a
 0000000000000058  0000011e00000001 R_X86_64_64            0000000000000000 .rodata.str1.1 + 13c
@@ -15437,7 +15785,7 @@
 00000000000000a8  0000011e00000001 R_X86_64_64            0000000000000000 .rodata.str1.1 + 146
 00000000000000b8  0000011e00000001 R_X86_64_64            0000000000000000 .rodata.str1.1 + 148
 
-Relocation section '.rela.discard.addressable' at offset 0x2ef80 contains 73 entries:
+Relocation section '.rela.discard.addressable' at offset 0x1ff88 contains 73 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000013700000001 R_X86_64_64            0000000000000000 .init.text + 58
 0000000000000008  0000033700000001 R_X86_64_64            0000000000002b90 sched_show_task + 0
@@ -15513,7 +15861,7 @@
 0000000000000238  000004b700000001 R_X86_64_64            0000000000002e30 __SCK__tp_func_sched_wakeup + 0
 0000000000000240  000004b800000001 R_X86_64_64            0000000000002e40 __SCK__tp_func_sched_waking + 0
 
-Relocation section '.rela_error_injection_whitelist' at offset 0x2f658 contains 28 entries:
+Relocation section '.rela_error_injection_whitelist' at offset 0x208f0 contains 28 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  000003be00000001 R_X86_64_64            0000000000004e90 __ia32_sys_sched_rr_get_interval_time32 + 0
 0000000000000010  000003c100000001 R_X86_64_64            0000000000004f50 __x64_sys_sched_rr_get_interval_time32 + 0
@@ -15544,12 +15892,12 @@
 00000000000001a0  000003c400000001 R_X86_64_64            0000000000005210 __ia32_sys_nice + 0
 00000000000001b0  000003c700000001 R_X86_64_64            00000000000052e0 __x64_sys_nice + 0
 
-Relocation section '.rela.init.setup' at offset 0x2f8f8 contains 2 entries:
+Relocation section '.rela.init.setup' at offset 0x20bb0 contains 2 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  000001c500000001 R_X86_64_64            0000000000000000 .init.rodata + 0
 0000000000000008  0000013700000001 R_X86_64_64            0000000000000000 .init.text + 0
 
-Relocation section '.rela_ftrace_events' at offset 0x2f928 contains 26 entries:
+Relocation section '.rela_ftrace_events' at offset 0x218d0 contains 26 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000000300000001 R_X86_64_64            0000000000000000 .data + 1c20
 0000000000000008  0000000300000001 R_X86_64_64            0000000000000000 .data + 1cc0
@@ -15578,7 +15926,7 @@
 00000000000000c0  0000000300000001 R_X86_64_64            0000000000000000 .data + 2b20
 00000000000000c8  0000000300000001 R_X86_64_64            0000000000000000 .data + 2bc0
 
-Relocation section '.rela.ref.data' at offset 0x2fb98 contains 144 entries:
+Relocation section '.rela.ref.data' at offset 0x221e8 contains 144 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000018b00000001 R_X86_64_64            0000000000000000 .rodata + 224
 0000000000000008  0000000200000001 R_X86_64_64            0000000000000000 .text + 3a60
@@ -15725,7 +16073,7 @@
 0000000000000698  0000026100000001 R_X86_64_64            0000000000000000 .ref.data + 690
 00000000000006a0  000004a200000001 R_X86_64_64            0000000000000000 trace_event_raw_init + 0
 
-Relocation section '.rela__tracepoints' at offset 0x30918 contains 148 entries:
+Relocation section '.rela__tracepoints' at offset 0x23d48 contains 148 entries:
     Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
 0000000000000000  0000027600000001 R_X86_64_64            0000000000000000 __tracepoints_strings + 0
 0000000000000018  0000032000000001 R_X86_64_64            0000000000002c50 __SCK__tp_func_sched_update_nr_running_tp + 0
@@ -15876,7 +16224,2185 @@
 0000000000000da0  000002a900000001 R_X86_64_64            0000000000000000 __SCT__tp_func_sched_kthread_stop + 0
 0000000000000da8  000002aa00000001 R_X86_64_64            0000000000000000 __traceiter_sched_kthread_stop + 0
 
-Symbol table '.symtab' contains 1214 entries:
+Relocation section '.rela.static_call_sites' at offset 0x342f8 contains 28 entries:
+    Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
+0000000000000000  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6651
+0000000000000004  000004a400000002 R_X86_64_PC32          0000000000002d00 __SCK__tp_func_sched_wake_idle_without_ipi + 0
+0000000000000008  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 68b3
+000000000000000c  000004a400000002 R_X86_64_PC32          0000000000002d00 __SCK__tp_func_sched_wake_idle_without_ipi + 0
+0000000000000010  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6bc3
+0000000000000014  000004b700000002 R_X86_64_PC32          0000000000002e30 __SCK__tp_func_sched_wakeup + 0
+0000000000000018  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6dda
+000000000000001c  000004b400000002 R_X86_64_PC32          0000000000002e00 __SCK__tp_func_sched_migrate_task + 0
+0000000000000020  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 71a8
+0000000000000024  000004b800000002 R_X86_64_PC32          0000000000002e40 __SCK__tp_func_sched_waking + 0
+0000000000000028  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 72b1
+000000000000002c  000004b700000002 R_X86_64_PC32          0000000000002e30 __SCK__tp_func_sched_wakeup + 0
+0000000000000030  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 72e5
+0000000000000034  000004b800000002 R_X86_64_PC32          0000000000002e40 __SCK__tp_func_sched_waking + 0
+0000000000000038  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7ff2
+000000000000003c  000004b100000002 R_X86_64_PC32          0000000000002dd0 __SCK__tp_func_sched_wait_task + 0
+0000000000000040  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 82bd
+0000000000000044  000004a400000002 R_X86_64_PC32          0000000000002d00 __SCK__tp_func_sched_wake_idle_without_ipi + 0
+0000000000000048  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 83a9
+000000000000004c  000004a400000002 R_X86_64_PC32          0000000000002d00 __SCK__tp_func_sched_wake_idle_without_ipi + 0
+0000000000000050  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8b7a
+0000000000000054  000004b600000002 R_X86_64_PC32          0000000000002e20 __SCK__tp_func_sched_wakeup_new + 0
+0000000000000058  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9193
+000000000000005c  000004a800000002 R_X86_64_PC32          0000000000002d40 __SCK__tp_func_sched_pi_setprio + 0
+0000000000000060  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a8e1
+0000000000000064  0000032000000002 R_X86_64_PC32          0000000000002c50 __SCK__tp_func_sched_update_nr_running_tp + 0
+0000000000000068  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 30e
+000000000000006c  000004b500000002 R_X86_64_PC32          0000000000002e10 __SCK__tp_func_sched_switch + 0
+
+Relocation section '.rela.orc_unwind_ip' at offset 0x39958 contains 2144 entries:
+    Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
+0000000000000000  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 0
+0000000000000004  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1
+0000000000000008  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2
+000000000000000c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2f
+0000000000000010  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 30
+0000000000000014  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 31
+0000000000000018  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 40
+000000000000001c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 41
+0000000000000020  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 42
+0000000000000024  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6d
+0000000000000028  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6e
+000000000000002c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6f
+0000000000000030  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 70
+0000000000000034  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 72
+0000000000000038  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 73
+000000000000003c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 74
+0000000000000040  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a5
+0000000000000044  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a8
+0000000000000048  0000000200000002 R_X86_64_PC32          0000000000000000 .text + aa
+000000000000004c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + ab
+0000000000000050  0000000200000002 R_X86_64_PC32          0000000000000000 .text + b0
+0000000000000054  0000000200000002 R_X86_64_PC32          0000000000000000 .text + b1
+0000000000000058  0000000200000002 R_X86_64_PC32          0000000000000000 .text + b2
+000000000000005c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + df
+0000000000000060  0000000200000002 R_X86_64_PC32          0000000000000000 .text + e0
+0000000000000064  0000000200000002 R_X86_64_PC32          0000000000000000 .text + e1
+0000000000000068  0000000200000002 R_X86_64_PC32          0000000000000000 .text + f0
+000000000000006c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + f2
+0000000000000070  0000000200000002 R_X86_64_PC32          0000000000000000 .text + f3
+0000000000000074  0000000200000002 R_X86_64_PC32          0000000000000000 .text + f4
+0000000000000078  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 125
+000000000000007c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 128
+0000000000000080  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 12a
+0000000000000084  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 12b
+0000000000000088  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 130
+000000000000008c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 131
+0000000000000090  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 132
+0000000000000094  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 15f
+0000000000000098  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 160
+000000000000009c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 161
+00000000000000a0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 170
+00000000000000a4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 171
+00000000000000a8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 172
+00000000000000ac  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 19f
+00000000000000b0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1a0
+00000000000000b4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1a1
+00000000000000b8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1b0
+00000000000000bc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1b1
+00000000000000c0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1b2
+00000000000000c4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1df
+00000000000000c8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1e0
+00000000000000cc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1e1
+00000000000000d0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1f0
+00000000000000d4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1f2
+00000000000000d8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1f4
+00000000000000dc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1f5
+00000000000000e0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1f6
+00000000000000e4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 22d
+00000000000000e8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 230
+00000000000000ec  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 232
+00000000000000f0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 234
+00000000000000f4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 235
+00000000000000f8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 240
+00000000000000fc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 242
+0000000000000100  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 243
+0000000000000104  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 244
+0000000000000108  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 275
+000000000000010c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 278
+0000000000000110  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 27a
+0000000000000114  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 27b
+0000000000000118  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 280
+000000000000011c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 281
+0000000000000120  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 282
+0000000000000124  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2af
+0000000000000128  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2b0
+000000000000012c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2b1
+0000000000000130  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2c0
+0000000000000134  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2c1
+0000000000000138  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2c2
+000000000000013c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2ef
+0000000000000140  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2f0
+0000000000000144  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2f1
+0000000000000148  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 300
+000000000000014c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 301
+0000000000000150  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 302
+0000000000000154  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 32f
+0000000000000158  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 330
+000000000000015c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 331
+0000000000000160  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 340
+0000000000000164  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 341
+0000000000000168  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 342
+000000000000016c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 36f
+0000000000000170  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 370
+0000000000000174  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 371
+0000000000000178  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 380
+000000000000017c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 382
+0000000000000180  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 383
+0000000000000184  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 384
+0000000000000188  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3b5
+000000000000018c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3b8
+0000000000000190  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3ba
+0000000000000194  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3bb
+0000000000000198  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3c0
+000000000000019c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3c2
+00000000000001a0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3c4
+00000000000001a4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3c5
+00000000000001a8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3c6
+00000000000001ac  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3fd
+00000000000001b0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 400
+00000000000001b4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 402
+00000000000001b8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 404
+00000000000001bc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 405
+00000000000001c0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 410
+00000000000001c4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 412
+00000000000001c8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 413
+00000000000001cc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 414
+00000000000001d0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 445
+00000000000001d4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 448
+00000000000001d8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 44a
+00000000000001dc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 44b
+00000000000001e0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 450
+00000000000001e4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 452
+00000000000001e8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 453
+00000000000001ec  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 454
+00000000000001f0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 485
+00000000000001f4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 488
+00000000000001f8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 48a
+00000000000001fc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 48b
+0000000000000200  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 490
+0000000000000204  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 492
+0000000000000208  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 493
+000000000000020c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 494
+0000000000000210  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4c5
+0000000000000214  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4c8
+0000000000000218  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4ca
+000000000000021c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4cb
+0000000000000220  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4d0
+0000000000000224  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4d2
+0000000000000228  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4d3
+000000000000022c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4d4
+0000000000000230  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 505
+0000000000000234  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 508
+0000000000000238  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 50a
+000000000000023c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 50b
+0000000000000240  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 510
+0000000000000244  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 512
+0000000000000248  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 514
+000000000000024c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 515
+0000000000000250  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 516
+0000000000000254  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 54d
+0000000000000258  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 550
+000000000000025c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 552
+0000000000000260  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 554
+0000000000000264  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 555
+0000000000000268  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 560
+000000000000026c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 562
+0000000000000270  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 563
+0000000000000274  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 564
+0000000000000278  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 595
+000000000000027c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 598
+0000000000000280  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 59a
+0000000000000284  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 59b
+0000000000000288  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5a0
+000000000000028c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5a2
+0000000000000290  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5a4
+0000000000000294  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5a5
+0000000000000298  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5a6
+000000000000029c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5dd
+00000000000002a0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5e0
+00000000000002a4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5e2
+00000000000002a8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5e4
+00000000000002ac  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5e5
+00000000000002b0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5f0
+00000000000002b4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5f2
+00000000000002b8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5f4
+00000000000002bc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5f6
+00000000000002c0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5f7
+00000000000002c4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5f8
+00000000000002c8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 635
+00000000000002cc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 638
+00000000000002d0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 63a
+00000000000002d4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 63c
+00000000000002d8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 63e
+00000000000002dc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 63f
+00000000000002e0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 640
+00000000000002e4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 642
+00000000000002e8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 644
+00000000000002ec  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 646
+00000000000002f0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 647
+00000000000002f4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 648
+00000000000002f8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 685
+00000000000002fc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 688
+0000000000000300  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 68a
+0000000000000304  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 68c
+0000000000000308  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 68e
+000000000000030c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 68f
+0000000000000310  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 690
+0000000000000314  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 691
+0000000000000318  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 692
+000000000000031c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6bd
+0000000000000320  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6be
+0000000000000324  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6bf
+0000000000000328  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6c0
+000000000000032c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6c1
+0000000000000330  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6c2
+0000000000000334  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6ef
+0000000000000338  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6f0
+000000000000033c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6f1
+0000000000000340  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 700
+0000000000000344  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 701
+0000000000000348  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 702
+000000000000034c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 72f
+0000000000000350  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 730
+0000000000000354  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 731
+0000000000000358  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 740
+000000000000035c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 741
+0000000000000360  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 742
+0000000000000364  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 76f
+0000000000000368  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 770
+000000000000036c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 771
+0000000000000370  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 780
+0000000000000374  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 781
+0000000000000378  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 782
+000000000000037c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7af
+0000000000000380  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7b0
+0000000000000384  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7b1
+0000000000000388  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7c0
+000000000000038c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7c1
+0000000000000390  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7c2
+0000000000000394  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7ef
+0000000000000398  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7f0
+000000000000039c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7f1
+00000000000003a0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 800
+00000000000003a4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 801
+00000000000003a8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 802
+00000000000003ac  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 82f
+00000000000003b0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 830
+00000000000003b4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 831
+00000000000003b8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 840
+00000000000003bc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 841
+00000000000003c0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 842
+00000000000003c4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 86f
+00000000000003c8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 870
+00000000000003cc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 871
+00000000000003d0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 880
+00000000000003d4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 882
+00000000000003d8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 883
+00000000000003dc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 884
+00000000000003e0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8b4
+00000000000003e4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8b7
+00000000000003e8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8b9
+00000000000003ec  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8ba
+00000000000003f0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8c0
+00000000000003f4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8c1
+00000000000003f8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8c2
+00000000000003fc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8ef
+0000000000000400  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8f0
+0000000000000404  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8f1
+0000000000000408  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 900
+000000000000040c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 901
+0000000000000410  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 902
+0000000000000414  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 92f
+0000000000000418  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 930
+000000000000041c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 931
+0000000000000420  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 940
+0000000000000424  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 942
+0000000000000428  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 943
+000000000000042c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 944
+0000000000000430  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 975
+0000000000000434  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 978
+0000000000000438  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 97a
+000000000000043c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 97b
+0000000000000440  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 980
+0000000000000444  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9c3
+0000000000000448  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9d0
+000000000000044c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a0d
+0000000000000450  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a10
+0000000000000454  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a27
+0000000000000458  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a30
+000000000000045c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a68
+0000000000000460  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a70
+0000000000000464  0000000200000002 R_X86_64_PC32          0000000000000000 .text + aa8
+0000000000000468  0000000200000002 R_X86_64_PC32          0000000000000000 .text + ab0
+000000000000046c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + ace
+0000000000000470  0000000200000002 R_X86_64_PC32          0000000000000000 .text + ad0
+0000000000000474  0000000200000002 R_X86_64_PC32          0000000000000000 .text + b07
+0000000000000478  0000000200000002 R_X86_64_PC32          0000000000000000 .text + b10
+000000000000047c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + b71
+0000000000000480  0000000200000002 R_X86_64_PC32          0000000000000000 .text + b80
+0000000000000484  0000000200000002 R_X86_64_PC32          0000000000000000 .text + b89
+0000000000000488  0000000200000002 R_X86_64_PC32          0000000000000000 .text + b90
+000000000000048c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + b91
+0000000000000490  0000000200000002 R_X86_64_PC32          0000000000000000 .text + b94
+0000000000000494  0000000200000002 R_X86_64_PC32          0000000000000000 .text + c6c
+0000000000000498  0000000200000002 R_X86_64_PC32          0000000000000000 .text + c6d
+000000000000049c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + c80
+00000000000004a0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + c81
+00000000000004a4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + c84
+00000000000004a8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + d38
+00000000000004ac  0000000200000002 R_X86_64_PC32          0000000000000000 .text + d39
+00000000000004b0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + d4c
+00000000000004b4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + d50
+00000000000004b8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + d51
+00000000000004bc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + d54
+00000000000004c0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + e1f
+00000000000004c4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + e20
+00000000000004c8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + e33
+00000000000004cc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + e40
+00000000000004d0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + e41
+00000000000004d4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + e44
+00000000000004d8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + f04
+00000000000004dc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + f05
+00000000000004e0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + f18
+00000000000004e4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + f20
+00000000000004e8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + f21
+00000000000004ec  0000000200000002 R_X86_64_PC32          0000000000000000 .text + f24
+00000000000004f0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + fe7
+00000000000004f4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + fe8
+00000000000004f8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + ffb
+00000000000004fc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1000
+0000000000000500  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1001
+0000000000000504  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1004
+0000000000000508  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 10e5
+000000000000050c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 10e6
+0000000000000510  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 10eb
+0000000000000514  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 10f0
+0000000000000518  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 10f1
+000000000000051c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 10f4
+0000000000000520  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 11e4
+0000000000000524  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 11e5
+0000000000000528  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 11f8
+000000000000052c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1200
+0000000000000530  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1201
+0000000000000534  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1204
+0000000000000538  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 12e3
+000000000000053c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 12e4
+0000000000000540  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 12f7
+0000000000000544  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1300
+0000000000000548  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1301
+000000000000054c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1304
+0000000000000550  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 13fc
+0000000000000554  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 13fd
+0000000000000558  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1411
+000000000000055c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1420
+0000000000000560  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1421
+0000000000000564  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1424
+0000000000000568  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1527
+000000000000056c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1528
+0000000000000570  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 153b
+0000000000000574  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1540
+0000000000000578  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1541
+000000000000057c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1544
+0000000000000580  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 161b
+0000000000000584  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 161c
+0000000000000588  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1621
+000000000000058c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1630
+0000000000000590  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1631
+0000000000000594  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1634
+0000000000000598  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 171f
+000000000000059c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1720
+00000000000005a0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1733
+00000000000005a4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1740
+00000000000005a8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1741
+00000000000005ac  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1744
+00000000000005b0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1840
+00000000000005b4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1841
+00000000000005b8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 185a
+00000000000005bc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1860
+00000000000005c0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1861
+00000000000005c4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1864
+00000000000005c8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1973
+00000000000005cc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1974
+00000000000005d0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1987
+00000000000005d4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1990
+00000000000005d8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1991
+00000000000005dc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1997
+00000000000005e0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1ad8
+00000000000005e4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1ad9
+00000000000005e8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1af7
+00000000000005ec  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1b00
+00000000000005f0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1b01
+00000000000005f4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1b04
+00000000000005f8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1bb8
+00000000000005fc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1bb9
+0000000000000600  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1bcc
+0000000000000604  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1bd0
+0000000000000608  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1bd2
+000000000000060c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1bd7
+0000000000000610  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1bdc
+0000000000000614  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1be1
+0000000000000618  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1be5
+000000000000061c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1be9
+0000000000000620  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1bed
+0000000000000624  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1ccf
+0000000000000628  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1cd0
+000000000000062c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1cd1
+0000000000000630  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1cd3
+0000000000000634  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1cd5
+0000000000000638  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1cd7
+000000000000063c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1cd9
+0000000000000640  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1cda
+0000000000000644  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1d09
+0000000000000648  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1d10
+000000000000064c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1d12
+0000000000000650  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1d16
+0000000000000654  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1d2b
+0000000000000658  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1d2d
+000000000000065c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1d2e
+0000000000000660  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1d52
+0000000000000664  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1d54
+0000000000000668  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1d59
+000000000000066c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1d60
+0000000000000670  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1d62
+0000000000000674  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1d66
+0000000000000678  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1d7b
+000000000000067c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1d7d
+0000000000000680  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1d7e
+0000000000000684  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1d9d
+0000000000000688  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1d9f
+000000000000068c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1da4
+0000000000000690  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1db0
+0000000000000694  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1db2
+0000000000000698  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1db6
+000000000000069c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1dcb
+00000000000006a0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1dcd
+00000000000006a4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1dce
+00000000000006a8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1df7
+00000000000006ac  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1df9
+00000000000006b0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1dfe
+00000000000006b4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1e00
+00000000000006b8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1e02
+00000000000006bc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1e06
+00000000000006c0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1e1b
+00000000000006c4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1e1d
+00000000000006c8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1e1e
+00000000000006cc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1e42
+00000000000006d0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1e44
+00000000000006d4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1e49
+00000000000006d8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1e50
+00000000000006dc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1e52
+00000000000006e0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1e56
+00000000000006e4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1e6b
+00000000000006e8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1e6d
+00000000000006ec  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1e6e
+00000000000006f0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1e92
+00000000000006f4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1e94
+00000000000006f8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1e99
+00000000000006fc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1ea0
+0000000000000700  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1ea2
+0000000000000704  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1ea6
+0000000000000708  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1ebb
+000000000000070c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1ebd
+0000000000000710  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1ebe
+0000000000000714  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1eec
+0000000000000718  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1eee
+000000000000071c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1ef3
+0000000000000720  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1f00
+0000000000000724  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1f02
+0000000000000728  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1f06
+000000000000072c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1f1b
+0000000000000730  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1f1d
+0000000000000734  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1f1e
+0000000000000738  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1f49
+000000000000073c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1f52
+0000000000000740  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1f53
+0000000000000744  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1f55
+0000000000000748  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1f5a
+000000000000074c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1f60
+0000000000000750  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1f62
+0000000000000754  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1f66
+0000000000000758  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1f7b
+000000000000075c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1f7d
+0000000000000760  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1f7e
+0000000000000764  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1fa7
+0000000000000768  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1fa9
+000000000000076c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1fae
+0000000000000770  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1fb0
+0000000000000774  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1fb2
+0000000000000778  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1fb6
+000000000000077c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1fcb
+0000000000000780  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1fcd
+0000000000000784  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1fce
+0000000000000788  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1ff7
+000000000000078c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1ff9
+0000000000000790  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 1ffe
+0000000000000794  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2000
+0000000000000798  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2002
+000000000000079c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2006
+00000000000007a0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 201b
+00000000000007a4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 201d
+00000000000007a8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 201e
+00000000000007ac  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 204c
+00000000000007b0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 204e
+00000000000007b4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2053
+00000000000007b8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2060
+00000000000007bc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2062
+00000000000007c0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2066
+00000000000007c4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 207b
+00000000000007c8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 207d
+00000000000007cc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 207e
+00000000000007d0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 20ab
+00000000000007d4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 20ad
+00000000000007d8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 20b2
+00000000000007dc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 20c0
+00000000000007e0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 20c2
+00000000000007e4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 20c6
+00000000000007e8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 20db
+00000000000007ec  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 20dd
+00000000000007f0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 20de
+00000000000007f4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2107
+00000000000007f8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2109
+00000000000007fc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 210e
+0000000000000800  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2110
+0000000000000804  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2112
+0000000000000808  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2116
+000000000000080c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 212b
+0000000000000810  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 212d
+0000000000000814  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 212e
+0000000000000818  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 215c
+000000000000081c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 215e
+0000000000000820  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2163
+0000000000000824  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2170
+0000000000000828  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2172
+000000000000082c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2176
+0000000000000830  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 218b
+0000000000000834  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 218d
+0000000000000838  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 218e
+000000000000083c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 21bc
+0000000000000840  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 21be
+0000000000000844  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 21c3
+0000000000000848  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 21d0
+000000000000084c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 21d2
+0000000000000850  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 21d6
+0000000000000854  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 21eb
+0000000000000858  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 21ed
+000000000000085c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 21ee
+0000000000000860  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2219
+0000000000000864  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 221f
+0000000000000868  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2225
+000000000000086c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2231
+0000000000000870  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2232
+0000000000000874  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2234
+0000000000000878  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2239
+000000000000087c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2240
+0000000000000880  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2242
+0000000000000884  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2246
+0000000000000888  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 225b
+000000000000088c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 225d
+0000000000000890  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 225e
+0000000000000894  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2289
+0000000000000898  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 228f
+000000000000089c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2295
+00000000000008a0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 229b
+00000000000008a4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 22a1
+00000000000008a8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 22a7
+00000000000008ac  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 22b3
+00000000000008b0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 22b4
+00000000000008b4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 22b6
+00000000000008b8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 22bb
+00000000000008bc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 22c0
+00000000000008c0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 22c2
+00000000000008c4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 22c6
+00000000000008c8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 22db
+00000000000008cc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 22dd
+00000000000008d0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 22de
+00000000000008d4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 22fd
+00000000000008d8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 22ff
+00000000000008dc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2304
+00000000000008e0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2310
+00000000000008e4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2312
+00000000000008e8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2317
+00000000000008ec  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2319
+00000000000008f0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 231b
+00000000000008f4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 231f
+00000000000008f8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2323
+00000000000008fc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2371
+0000000000000900  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 237a
+0000000000000904  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 238a
+0000000000000908  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 238c
+000000000000090c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2398
+0000000000000910  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2399
+0000000000000914  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 239b
+0000000000000918  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 239d
+000000000000091c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 239f
+0000000000000920  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 23a1
+0000000000000924  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 23a6
+0000000000000928  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 23aa
+000000000000092c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 23ab
+0000000000000930  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 23ad
+0000000000000934  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 23af
+0000000000000938  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 23b1
+000000000000093c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 23b3
+0000000000000940  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 23b4
+0000000000000944  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 23db
+0000000000000948  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 23e0
+000000000000094c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 23e1
+0000000000000950  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 23e4
+0000000000000954  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2516
+0000000000000958  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2517
+000000000000095c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 253c
+0000000000000960  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2540
+0000000000000964  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2541
+0000000000000968  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 254c
+000000000000096c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2584
+0000000000000970  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2585
+0000000000000974  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 258a
+0000000000000978  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 25a6
+000000000000097c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 25a7
+0000000000000980  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 25ac
+0000000000000984  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 25b0
+0000000000000988  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 25bf
+000000000000098c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 25c0
+0000000000000990  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 25c2
+0000000000000994  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 25cb
+0000000000000998  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 25cd
+000000000000099c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 25d4
+00000000000009a0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 25d5
+00000000000009a4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2656
+00000000000009a8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 265a
+00000000000009ac  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 265c
+00000000000009b0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 265e
+00000000000009b4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2660
+00000000000009b8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2661
+00000000000009bc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2743
+00000000000009c0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2750
+00000000000009c4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2752
+00000000000009c8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2753
+00000000000009cc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 278c
+00000000000009d0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 278e
+00000000000009d4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 278f
+00000000000009d8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 27c1
+00000000000009dc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 27d0
+00000000000009e0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 27d2
+00000000000009e4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 27d3
+00000000000009e8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 27d7
+00000000000009ec  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2881
+00000000000009f0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2885
+00000000000009f4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2887
+00000000000009f8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2888
+00000000000009fc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 28ac
+0000000000000a00  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 28b0
+0000000000000a04  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 28d2
+0000000000000a08  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 28e0
+0000000000000a0c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2913
+0000000000000a10  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2920
+0000000000000a14  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 295e
+0000000000000a18  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2960
+0000000000000a1c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2961
+0000000000000a20  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2965
+0000000000000a24  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2969
+0000000000000a28  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 29df
+0000000000000a2c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 29e0
+0000000000000a30  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 29e1
+0000000000000a34  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 29e2
+0000000000000a38  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 29eb
+0000000000000a3c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 29f0
+0000000000000a40  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 29f1
+0000000000000a44  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2a5f
+0000000000000a48  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2a60
+0000000000000a4c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2a68
+0000000000000a50  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2a69
+0000000000000a54  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2a70
+0000000000000a58  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2a73
+0000000000000a5c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2a80
+0000000000000a60  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2a88
+0000000000000a64  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2a89
+0000000000000a68  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2b82
+0000000000000a6c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2b83
+0000000000000a70  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2b84
+0000000000000a74  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2b90
+0000000000000a78  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2b92
+0000000000000a7c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2b94
+0000000000000a80  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2b95
+0000000000000a84  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2bc8
+0000000000000a88  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2bca
+0000000000000a8c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2bcc
+0000000000000a90  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2bcd
+0000000000000a94  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2bda
+0000000000000a98  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2be0
+0000000000000a9c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2be3
+0000000000000aa0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2bf0
+0000000000000aa4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2c28
+0000000000000aa8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2c30
+0000000000000aac  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2c68
+0000000000000ab0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2c70
+0000000000000ab4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2c71
+0000000000000ab8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2c97
+0000000000000abc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2c98
+0000000000000ac0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2ca0
+0000000000000ac4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2ca1
+0000000000000ac8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2ca4
+0000000000000acc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2e04
+0000000000000ad0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2e05
+0000000000000ad4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2e18
+0000000000000ad8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2e20
+0000000000000adc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2e21
+0000000000000ae0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2e43
+0000000000000ae4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2e48
+0000000000000ae8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2e50
+0000000000000aec  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2e51
+0000000000000af0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2e6c
+0000000000000af4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2e71
+0000000000000af8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2e80
+0000000000000afc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2e82
+0000000000000b00  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2e83
+0000000000000b04  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2ebc
+0000000000000b08  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2ebe
+0000000000000b0c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2ebf
+0000000000000b10  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2ef1
+0000000000000b14  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2f00
+0000000000000b18  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2f02
+0000000000000b1c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2f0d
+0000000000000b20  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2f11
+0000000000000b24  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2f5b
+0000000000000b28  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2f5c
+0000000000000b2c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2f5e
+0000000000000b30  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2f5f
+0000000000000b34  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2f60
+0000000000000b38  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2f62
+0000000000000b3c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2f63
+0000000000000b40  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2f64
+0000000000000b44  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2fbb
+0000000000000b48  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2fbc
+0000000000000b4c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2fbe
+0000000000000b50  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2fbf
+0000000000000b54  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2fc0
+0000000000000b58  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 2fc1
+0000000000000b5c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3022
+0000000000000b60  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3027
+0000000000000b64  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3030
+0000000000000b68  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3032
+0000000000000b6c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3033
+0000000000000b70  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3037
+0000000000000b74  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 30e2
+0000000000000b78  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 30e6
+0000000000000b7c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 30e8
+0000000000000b80  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 30e9
+0000000000000b84  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 310d
+0000000000000b88  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3110
+0000000000000b8c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3111
+0000000000000b90  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3114
+0000000000000b94  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 31ec
+0000000000000b98  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 31ed
+0000000000000b9c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 32e5
+0000000000000ba0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 32ea
+0000000000000ba4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3340
+0000000000000ba8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3341
+0000000000000bac  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3349
+0000000000000bb0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 33a0
+0000000000000bb4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 33a1
+0000000000000bb8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 33a2
+0000000000000bbc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 33a6
+0000000000000bc0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 33b0
+0000000000000bc4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3409
+0000000000000bc8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3410
+0000000000000bcc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3412
+0000000000000bd0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3419
+0000000000000bd4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 341b
+0000000000000bd8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 341c
+0000000000000bdc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 341d
+0000000000000be0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3421
+0000000000000be4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 34fd
+0000000000000be8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3501
+0000000000000bec  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3502
+0000000000000bf0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3504
+0000000000000bf4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3506
+0000000000000bf8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3508
+0000000000000bfc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3509
+0000000000000c00  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 353c
+0000000000000c04  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3540
+0000000000000c08  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3542
+0000000000000c0c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3549
+0000000000000c10  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 354b
+0000000000000c14  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 354c
+0000000000000c18  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 354d
+0000000000000c1c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3551
+0000000000000c20  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 362d
+0000000000000c24  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3631
+0000000000000c28  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3632
+0000000000000c2c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3634
+0000000000000c30  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3636
+0000000000000c34  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3638
+0000000000000c38  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3639
+0000000000000c3c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 366c
+0000000000000c40  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3670
+0000000000000c44  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3672
+0000000000000c48  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3676
+0000000000000c4c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3678
+0000000000000c50  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3679
+0000000000000c54  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 367a
+0000000000000c58  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 36d5
+0000000000000c5c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 36d9
+0000000000000c60  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 36db
+0000000000000c64  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 36dd
+0000000000000c68  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 36df
+0000000000000c6c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 36e0
+0000000000000c70  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3732
+0000000000000c74  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3733
+0000000000000c78  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3735
+0000000000000c7c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3737
+0000000000000c80  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3739
+0000000000000c84  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 373a
+0000000000000c88  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3741
+0000000000000c8c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3750
+0000000000000c90  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 37e2
+0000000000000c94  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 37f0
+0000000000000c98  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 37f2
+0000000000000c9c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 37f4
+0000000000000ca0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3800
+0000000000000ca4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3805
+0000000000000ca8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3806
+0000000000000cac  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 383e
+0000000000000cb0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3840
+0000000000000cb4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3846
+0000000000000cb8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3848
+0000000000000cbc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 384a
+0000000000000cc0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 384f
+0000000000000cc4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 389f
+0000000000000cc8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 38a4
+0000000000000ccc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 38a6
+0000000000000cd0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 38a8
+0000000000000cd4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 38aa
+0000000000000cd8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 38af
+0000000000000cdc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3955
+0000000000000ce0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3960
+0000000000000ce4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3962
+0000000000000ce8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3963
+0000000000000cec  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 39ca
+0000000000000cf0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 39cc
+0000000000000cf4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 39d1
+0000000000000cf8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 39d2
+0000000000000cfc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 39d4
+0000000000000d00  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 39d5
+0000000000000d04  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3a1d
+0000000000000d08  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3a1f
+0000000000000d0c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3a24
+0000000000000d10  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3a51
+0000000000000d14  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3a60
+0000000000000d18  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3a62
+0000000000000d1c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3a63
+0000000000000d20  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3a67
+0000000000000d24  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3a6d
+0000000000000d28  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3ad3
+0000000000000d2c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3ad4
+0000000000000d30  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3ad5
+0000000000000d34  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3ad7
+0000000000000d38  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3ad8
+0000000000000d3c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3afc
+0000000000000d40  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3b00
+0000000000000d44  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3b02
+0000000000000d48  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3b03
+0000000000000d4c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3b07
+0000000000000d50  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3b0d
+0000000000000d54  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3b73
+0000000000000d58  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3b74
+0000000000000d5c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3b75
+0000000000000d60  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3b77
+0000000000000d64  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3b78
+0000000000000d68  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3b9c
+0000000000000d6c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3ba0
+0000000000000d70  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3ba2
+0000000000000d74  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3ba7
+0000000000000d78  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3bab
+0000000000000d7c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3baf
+0000000000000d80  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3bb3
+0000000000000d84  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3c14
+0000000000000d88  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3c15
+0000000000000d8c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3c16
+0000000000000d90  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3c18
+0000000000000d94  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3c1a
+0000000000000d98  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3c1b
+0000000000000d9c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3c3e
+0000000000000da0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3c40
+0000000000000da4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3c42
+0000000000000da8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3c43
+0000000000000dac  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3c47
+0000000000000db0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3c4e
+0000000000000db4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3cbd
+0000000000000db8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3cbe
+0000000000000dbc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3cbf
+0000000000000dc0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3cc1
+0000000000000dc4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3cc2
+0000000000000dc8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3ce6
+0000000000000dcc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3cf0
+0000000000000dd0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3cf2
+0000000000000dd4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3cf7
+0000000000000dd8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3cfb
+0000000000000ddc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3cff
+0000000000000de0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3d03
+0000000000000de4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3d6c
+0000000000000de8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3d6d
+0000000000000dec  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3d6e
+0000000000000df0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3d70
+0000000000000df4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3d72
+0000000000000df8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3d73
+0000000000000dfc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3d96
+0000000000000e00  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3da0
+0000000000000e04  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3da1
+0000000000000e08  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3da4
+0000000000000e0c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3e3b
+0000000000000e10  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3e3c
+0000000000000e14  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3e60
+0000000000000e18  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3e61
+0000000000000e1c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3e64
+0000000000000e20  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3f07
+0000000000000e24  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3f08
+0000000000000e28  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3f2c
+0000000000000e2c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3f30
+0000000000000e30  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3f31
+0000000000000e34  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3f34
+0000000000000e38  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3fe2
+0000000000000e3c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 3fe3
+0000000000000e40  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 400a
+0000000000000e44  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4010
+0000000000000e48  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4011
+0000000000000e4c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4014
+0000000000000e50  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 40b1
+0000000000000e54  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 40b2
+0000000000000e58  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 40d6
+0000000000000e5c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 40e0
+0000000000000e60  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 40e1
+0000000000000e64  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 40e4
+0000000000000e68  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4197
+0000000000000e6c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4198
+0000000000000e70  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 41c3
+0000000000000e74  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 41d0
+0000000000000e78  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 41d1
+0000000000000e7c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 41d4
+0000000000000e80  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 427e
+0000000000000e84  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 427f
+0000000000000e88  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 42aa
+0000000000000e8c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 42b0
+0000000000000e90  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 42b1
+0000000000000e94  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 42b4
+0000000000000e98  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 437a
+0000000000000e9c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 437b
+0000000000000ea0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 43a6
+0000000000000ea4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 43b0
+0000000000000ea8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 43b1
+0000000000000eac  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 43b4
+0000000000000eb0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4466
+0000000000000eb4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4467
+0000000000000eb8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 448b
+0000000000000ebc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4490
+0000000000000ec0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4491
+0000000000000ec4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4494
+0000000000000ec8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4556
+0000000000000ecc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4557
+0000000000000ed0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4580
+0000000000000ed4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4582
+0000000000000ed8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4587
+0000000000000edc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4589
+0000000000000ee0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 458d
+0000000000000ee4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4591
+0000000000000ee8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4598
+0000000000000eec  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4648
+0000000000000ef0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4649
+0000000000000ef4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 464a
+0000000000000ef8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 464c
+0000000000000efc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 464e
+0000000000000f00  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4650
+0000000000000f04  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4651
+0000000000000f08  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 467c
+0000000000000f0c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4680
+0000000000000f10  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4682
+0000000000000f14  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4684
+0000000000000f18  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4689
+0000000000000f1c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 468d
+0000000000000f20  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4691
+0000000000000f24  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4698
+0000000000000f28  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 475f
+0000000000000f2c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4760
+0000000000000f30  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4761
+0000000000000f34  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4763
+0000000000000f38  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4765
+0000000000000f3c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4767
+0000000000000f40  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4768
+0000000000000f44  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4793
+0000000000000f48  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 47a0
+0000000000000f4c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 47a1
+0000000000000f50  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 47a4
+0000000000000f54  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 48c8
+0000000000000f58  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 48c9
+0000000000000f5c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 48f4
+0000000000000f60  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4900
+0000000000000f64  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4901
+0000000000000f68  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 493f
+0000000000000f6c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4944
+0000000000000f70  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 494d
+0000000000000f74  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4950
+0000000000000f78  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4958
+0000000000000f7c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4960
+0000000000000f80  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 496f
+0000000000000f84  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4973
+0000000000000f88  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 499e
+0000000000000f8c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 499f
+0000000000000f90  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 49af
+0000000000000f94  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 49b3
+0000000000000f98  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 49de
+0000000000000f9c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 49df
+0000000000000fa0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 49ef
+0000000000000fa4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 49f8
+0000000000000fa8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4a24
+0000000000000fac  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4a25
+0000000000000fb0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4a26
+0000000000000fb4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4a30
+0000000000000fb8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4a31
+0000000000000fbc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4a3b
+0000000000000fc0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4a79
+0000000000000fc4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4a7a
+0000000000000fc8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4a7b
+0000000000000fcc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4a94
+0000000000000fd0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4a95
+0000000000000fd4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4a96
+0000000000000fd8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4aa0
+0000000000000fdc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4aa2
+0000000000000fe0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4aae
+0000000000000fe4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4ab0
+0000000000000fe8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4ab5
+0000000000000fec  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4ab6
+0000000000000ff0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4ab7
+0000000000000ff4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4abe
+0000000000000ff8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4b1a
+0000000000000ffc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4b1d
+0000000000001000  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4b1e
+0000000000001004  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4b20
+0000000000001008  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4b22
+000000000000100c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4b24
+0000000000001010  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4b26
+0000000000001014  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4b27
+0000000000001018  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4c34
+000000000000101c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4c40
+0000000000001020  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4c42
+0000000000001024  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4c43
+0000000000001028  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4c4b
+000000000000102c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4c83
+0000000000001030  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4c84
+0000000000001034  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4c86
+0000000000001038  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4c87
+000000000000103c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4ca0
+0000000000001040  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4ca2
+0000000000001044  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4cab
+0000000000001048  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4cb0
+000000000000104c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4cb1
+0000000000001050  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4cb9
+0000000000001054  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4cfa
+0000000000001058  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4cfe
+000000000000105c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4d00
+0000000000001060  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4d02
+0000000000001064  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4d04
+0000000000001068  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4d05
+000000000000106c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4d2a
+0000000000001070  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4d30
+0000000000001074  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4d32
+0000000000001078  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4d34
+000000000000107c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4d36
+0000000000001080  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4d37
+0000000000001084  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4d38
+0000000000001088  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4d3c
+000000000000108c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4d9d
+0000000000001090  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4da1
+0000000000001094  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4da2
+0000000000001098  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4da4
+000000000000109c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4da6
+00000000000010a0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4da8
+00000000000010a4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4da9
+00000000000010a8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4e2e
+00000000000010ac  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4e30
+00000000000010b0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4e31
+00000000000010b4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4e35
+00000000000010b8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4e6f
+00000000000010bc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4e70
+00000000000010c0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4e71
+00000000000010c4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4e82
+00000000000010c8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4e90
+00000000000010cc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4e91
+00000000000010d0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4e95
+00000000000010d4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4ecf
+00000000000010d8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4ed0
+00000000000010dc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4ed1
+00000000000010e0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4ee2
+00000000000010e4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4ef0
+00000000000010e8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4ef1
+00000000000010ec  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4ef5
+00000000000010f0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4f2f
+00000000000010f4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4f30
+00000000000010f8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4f31
+00000000000010fc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4f43
+0000000000001100  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4f50
+0000000000001104  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4f51
+0000000000001108  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4f55
+000000000000110c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4f8f
+0000000000001110  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4f90
+0000000000001114  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4f91
+0000000000001118  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4fa3
+000000000000111c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4fb0
+0000000000001120  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4fb2
+0000000000001124  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4fb4
+0000000000001128  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4fb6
+000000000000112c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4fb8
+0000000000001130  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4fb9
+0000000000001134  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4fbd
+0000000000001138  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 4fc4
+000000000000113c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 50fc
+0000000000001140  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 50fd
+0000000000001144  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 50fe
+0000000000001148  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5100
+000000000000114c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5102
+0000000000001150  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5104
+0000000000001154  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5106
+0000000000001158  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5107
+000000000000115c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 51ef
+0000000000001160  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 51f0
+0000000000001164  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 520d
+0000000000001168  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5210
+000000000000116c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5212
+0000000000001170  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 521e
+0000000000001174  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 521f
+0000000000001178  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 529b
+000000000000117c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 529d
+0000000000001180  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 529f
+0000000000001184  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 52a0
+0000000000001188  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 52bd
+000000000000118c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 52bf
+0000000000001190  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 52c1
+0000000000001194  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 52c2
+0000000000001198  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 52d9
+000000000000119c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 52e0
+00000000000011a0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 52e2
+00000000000011a4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 52ee
+00000000000011a8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 52ef
+00000000000011ac  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 536b
+00000000000011b0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 536d
+00000000000011b4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 536f
+00000000000011b8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5370
+00000000000011bc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 538d
+00000000000011c0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 538f
+00000000000011c4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5391
+00000000000011c8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5392
+00000000000011cc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 53a9
+00000000000011d0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 53b0
+00000000000011d4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 53b2
+00000000000011d8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 53b4
+00000000000011dc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 53b5
+00000000000011e0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 53b6
+00000000000011e4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 53bd
+00000000000011e8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5440
+00000000000011ec  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5441
+00000000000011f0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5442
+00000000000011f4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5444
+00000000000011f8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5446
+00000000000011fc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5447
+0000000000001200  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5497
+0000000000001204  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 54a0
+0000000000001208  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 54a2
+000000000000120c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 54a7
+0000000000001210  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 54ac
+0000000000001214  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 54ae
+0000000000001218  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 54af
+000000000000121c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 54b2
+0000000000001220  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 54b8
+0000000000001224  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5868
+0000000000001228  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5869
+000000000000122c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 586a
+0000000000001230  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 586c
+0000000000001234  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 586e
+0000000000001238  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5870
+000000000000123c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5872
+0000000000001240  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5873
+0000000000001244  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5e70
+0000000000001248  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5e71
+000000000000124c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5e72
+0000000000001250  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5e76
+0000000000001254  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5f5f
+0000000000001258  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5f60
+000000000000125c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5f61
+0000000000001260  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5f62
+0000000000001264  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5fcb
+0000000000001268  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5fd0
+000000000000126c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 5fd4
+0000000000001270  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6020
+0000000000001274  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6021
+0000000000001278  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 602d
+000000000000127c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6030
+0000000000001280  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6032
+0000000000001284  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6033
+0000000000001288  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6034
+000000000000128c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6038
+0000000000001290  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 613a
+0000000000001294  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 613e
+0000000000001298  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 613f
+000000000000129c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6141
+00000000000012a0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6142
+00000000000012a4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 61bd
+00000000000012a8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 61c0
+00000000000012ac  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 61ff
+00000000000012b0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6200
+00000000000012b4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6215
+00000000000012b8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6220
+00000000000012bc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6234
+00000000000012c0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6240
+00000000000012c4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6241
+00000000000012c8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6242
+00000000000012cc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6246
+00000000000012d0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 632f
+00000000000012d4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6330
+00000000000012d8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6331
+00000000000012dc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6332
+00000000000012e0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 639b
+00000000000012e4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 63a0
+00000000000012e8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 63a4
+00000000000012ec  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6407
+00000000000012f0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6408
+00000000000012f4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6411
+00000000000012f8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6420
+00000000000012fc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6424
+0000000000001300  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6487
+0000000000001304  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6488
+0000000000001308  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6491
+000000000000130c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 64a0
+0000000000001310  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 64af
+0000000000001314  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 64b0
+0000000000001318  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 64b1
+000000000000131c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 64b5
+0000000000001320  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6504
+0000000000001324  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6505
+0000000000001328  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 650a
+000000000000132c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6512
+0000000000001330  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 651a
+0000000000001334  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 651f
+0000000000001338  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6520
+000000000000133c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6575
+0000000000001340  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6580
+0000000000001344  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 65d8
+0000000000001348  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 65e0
+000000000000134c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 666e
+0000000000001350  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6670
+0000000000001354  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6672
+0000000000001358  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 667d
+000000000000135c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 667e
+0000000000001360  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 66ac
+0000000000001364  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 66b3
+0000000000001368  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 66b5
+000000000000136c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 66ba
+0000000000001370  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 66c6
+0000000000001374  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 66ca
+0000000000001378  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 66cc
+000000000000137c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 66d1
+0000000000001380  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 66e0
+0000000000001384  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 66e2
+0000000000001388  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 66e4
+000000000000138c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 66e6
+0000000000001390  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 66e8
+0000000000001394  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 66e9
+0000000000001398  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 66ea
+000000000000139c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6725
+00000000000013a0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6728
+00000000000013a4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 672a
+00000000000013a8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 672c
+00000000000013ac  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 672e
+00000000000013b0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6730
+00000000000013b4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6731
+00000000000013b8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 67c3
+00000000000013bc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 67c4
+00000000000013c0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 67c6
+00000000000013c4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 67c8
+00000000000013c8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 67ca
+00000000000013cc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 67cc
+00000000000013d0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 67cd
+00000000000013d4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 682d
+00000000000013d8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6830
+00000000000013dc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 68c2
+00000000000013e0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 68c4
+00000000000013e4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 68c9
+00000000000013e8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 68ce
+00000000000013ec  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 68d2
+00000000000013f0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 68d6
+00000000000013f4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6926
+00000000000013f8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 692a
+00000000000013fc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 692c
+0000000000001400  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 692e
+0000000000001404  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6930
+0000000000001408  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6932
+000000000000140c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6933
+0000000000001410  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 695f
+0000000000001414  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6960
+0000000000001418  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6963
+000000000000141c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6970
+0000000000001420  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6971
+0000000000001424  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6978
+0000000000001428  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 69b7
+000000000000142c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 69b8
+0000000000001430  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 69b9
+0000000000001434  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 69d9
+0000000000001438  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 69e0
+000000000000143c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 69e4
+0000000000001440  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6a0a
+0000000000001444  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6a0f
+0000000000001448  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6a74
+000000000000144c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6a80
+0000000000001450  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6aa1
+0000000000001454  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6ab0
+0000000000001458  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6abf
+000000000000145c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6ad4
+0000000000001460  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6ad5
+0000000000001464  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6af6
+0000000000001468  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6af7
+000000000000146c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6b0f
+0000000000001470  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6b10
+0000000000001474  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6b11
+0000000000001478  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6b15
+000000000000147c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6b97
+0000000000001480  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6b98
+0000000000001484  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6b99
+0000000000001488  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6bd6
+000000000000148c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6be0
+0000000000001490  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6be2
+0000000000001494  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6be7
+0000000000001498  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6beb
+000000000000149c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6c56
+00000000000014a0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6c58
+00000000000014a4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6c5a
+00000000000014a8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6c5f
+00000000000014ac  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6cb2
+00000000000014b0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6cc0
+00000000000014b4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6ce9
+00000000000014b8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6cf0
+00000000000014bc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6cf7
+00000000000014c0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6d00
+00000000000014c4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6d02
+00000000000014c8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6d04
+00000000000014cc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6d05
+00000000000014d0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6d08
+00000000000014d4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6da8
+00000000000014d8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6da9
+00000000000014dc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6dab
+00000000000014e0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6dad
+00000000000014e4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6dae
+00000000000014e8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6df0
+00000000000014ec  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6df2
+00000000000014f0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6df4
+00000000000014f4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6dfc
+00000000000014f8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6e00
+00000000000014fc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6e63
+0000000000001500  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6e66
+0000000000001504  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6e68
+0000000000001508  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6e6a
+000000000000150c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6e6b
+0000000000001510  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6ece
+0000000000001514  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6ecf
+0000000000001518  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6ed1
+000000000000151c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6ed3
+0000000000001520  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6ed4
+0000000000001524  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6ef0
+0000000000001528  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6ef1
+000000000000152c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6ef3
+0000000000001530  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6ef5
+0000000000001534  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6ef6
+0000000000001538  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6fc0
+000000000000153c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6fc2
+0000000000001540  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6fc4
+0000000000001544  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6fc6
+0000000000001548  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6fc8
+000000000000154c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6fcc
+0000000000001550  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6fcd
+0000000000001554  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 6fd4
+0000000000001558  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7038
+000000000000155c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7039
+0000000000001560  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 703a
+0000000000001564  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 703c
+0000000000001568  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 703e
+000000000000156c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7040
+0000000000001570  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7042
+0000000000001574  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7043
+0000000000001578  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 73ae
+000000000000157c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 73b0
+0000000000001580  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 73bc
+0000000000001584  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 73c0
+0000000000001588  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 73c2
+000000000000158c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 73c4
+0000000000001590  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 73c5
+0000000000001594  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 73c6
+0000000000001598  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 743c
+000000000000159c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 743d
+00000000000015a0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 743f
+00000000000015a4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7441
+00000000000015a8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7442
+00000000000015ac  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7450
+00000000000015b0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7459
+00000000000015b4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7460
+00000000000015b8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7462
+00000000000015bc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7466
+00000000000015c0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 746a
+00000000000015c4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7547
+00000000000015c8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7548
+00000000000015cc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 754a
+00000000000015d0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 754b
+00000000000015d4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7561
+00000000000015d8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7570
+00000000000015dc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7572
+00000000000015e0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 757f
+00000000000015e4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7581
+00000000000015e8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7586
+00000000000015ec  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 758a
+00000000000015f0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 758b
+00000000000015f4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7595
+00000000000015f8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 76cf
+00000000000015fc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 76d0
+0000000000001600  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 76d1
+0000000000001604  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 76d3
+0000000000001608  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 76d5
+000000000000160c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 76d7
+0000000000001610  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 76d9
+0000000000001614  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 76da
+0000000000001618  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7a5c
+000000000000161c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7a60
+0000000000001620  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7a62
+0000000000001624  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7a64
+0000000000001628  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7a69
+000000000000162c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7a6a
+0000000000001630  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7a6e
+0000000000001634  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7a74
+0000000000001638  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7b36
+000000000000163c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7b3a
+0000000000001640  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7b3b
+0000000000001644  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7b3d
+0000000000001648  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7b3f
+000000000000164c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7b41
+0000000000001650  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7b42
+0000000000001654  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7b97
+0000000000001658  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7ba0
+000000000000165c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7ba1
+0000000000001660  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7bf4
+0000000000001664  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7bf5
+0000000000001668  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7c00
+000000000000166c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7c01
+0000000000001670  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7c10
+0000000000001674  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7c17
+0000000000001678  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7c20
+000000000000167c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7c22
+0000000000001680  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7c24
+0000000000001684  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7c26
+0000000000001688  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7c28
+000000000000168c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7c29
+0000000000001690  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7c2a
+0000000000001694  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7c38
+0000000000001698  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7c53
+000000000000169c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7c55
+00000000000016a0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7d07
+00000000000016a4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7d0a
+00000000000016a8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7d0b
+00000000000016ac  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7d0d
+00000000000016b0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7d0f
+00000000000016b4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7d11
+00000000000016b8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7d13
+00000000000016bc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7d14
+00000000000016c0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7e00
+00000000000016c4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7e02
+00000000000016c8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7e04
+00000000000016cc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7e06
+00000000000016d0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7e07
+00000000000016d4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7e0b
+00000000000016d8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7e7f
+00000000000016dc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7e82
+00000000000016e0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7e84
+00000000000016e4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7e86
+00000000000016e8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7e88
+00000000000016ec  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7e89
+00000000000016f0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7e94
+00000000000016f4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7e95
+00000000000016f8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7e97
+00000000000016fc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7e99
+0000000000001700  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7e9b
+0000000000001704  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7e9c
+0000000000001708  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7ef9
+000000000000170c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7efa
+0000000000001710  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7efc
+0000000000001714  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7efe
+0000000000001718  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7f00
+000000000000171c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7f01
+0000000000001720  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7f10
+0000000000001724  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7f12
+0000000000001728  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7f14
+000000000000172c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7f16
+0000000000001730  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7f18
+0000000000001734  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7f19
+0000000000001738  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7f1d
+000000000000173c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7f2d
+0000000000001740  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7fc1
+0000000000001744  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7fc2
+0000000000001748  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7fc3
+000000000000174c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7fc5
+0000000000001750  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7fc7
+0000000000001754  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7fc9
+0000000000001758  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7fcb
+000000000000175c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 7fcc
+0000000000001760  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8083
+0000000000001764  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8090
+0000000000001768  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8092
+000000000000176c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8094
+0000000000001770  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8098
+0000000000001774  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 809c
+0000000000001778  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 80a7
+000000000000177c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 814a
+0000000000001780  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 814b
+0000000000001784  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 814c
+0000000000001788  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 814e
+000000000000178c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8150
+0000000000001790  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8151
+0000000000001794  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8156
+0000000000001798  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8160
+000000000000179c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8162
+00000000000017a0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 816b
+00000000000017a4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 816d
+00000000000017a8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 816e
+00000000000017ac  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 816f
+00000000000017b0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 81eb
+00000000000017b4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 81ef
+00000000000017b8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 81f4
+00000000000017bc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 81f6
+00000000000017c0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 81f8
+00000000000017c4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 81fd
+00000000000017c8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 822b
+00000000000017cc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 822c
+00000000000017d0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 822e
+00000000000017d4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8230
+00000000000017d8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8232
+00000000000017dc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8233
+00000000000017e0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8240
+00000000000017e4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 82c4
+00000000000017e8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 82d0
+00000000000017ec  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 82dc
+00000000000017f0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 82e6
+00000000000017f4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 82e7
+00000000000017f8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 82f8
+00000000000017fc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 82fa
+0000000000001800  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 82fc
+0000000000001804  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8301
+0000000000001808  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8367
+000000000000180c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8369
+0000000000001810  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 836b
+0000000000001814  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8370
+0000000000001818  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8376
+000000000000181c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8378
+0000000000001820  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 837a
+0000000000001824  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 837f
+0000000000001828  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 83b3
+000000000000182c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 83c0
+0000000000001830  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 83e7
+0000000000001834  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 83f0
+0000000000001838  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 83f2
+000000000000183c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 83f4
+0000000000001840  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 83f6
+0000000000001844  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 83ff
+0000000000001848  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8403
+000000000000184c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 840a
+0000000000001850  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8411
+0000000000001854  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8478
+0000000000001858  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 847c
+000000000000185c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 847d
+0000000000001860  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 847f
+0000000000001864  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8481
+0000000000001868  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8483
+000000000000186c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8485
+0000000000001870  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8486
+0000000000001874  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 84cd
+0000000000001878  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 84d0
+000000000000187c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 84d7
+0000000000001880  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 84e0
+0000000000001884  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 84eb
+0000000000001888  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 84f0
+000000000000188c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 84f2
+0000000000001890  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 84f7
+0000000000001894  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 84fc
+0000000000001898  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8500
+000000000000189c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8503
+00000000000018a0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 850a
+00000000000018a4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8648
+00000000000018a8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8649
+00000000000018ac  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 864a
+00000000000018b0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 864c
+00000000000018b4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 864e
+00000000000018b8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8650
+00000000000018bc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8651
+00000000000018c0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8668
+00000000000018c4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8670
+00000000000018c8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8672
+00000000000018cc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8677
+00000000000018d0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8679
+00000000000018d4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 867b
+00000000000018d8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 867c
+00000000000018dc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 867d
+00000000000018e0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8684
+00000000000018e4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 880a
+00000000000018e8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 880b
+00000000000018ec  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 880c
+00000000000018f0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 880e
+00000000000018f4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8810
+00000000000018f8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8812
+00000000000018fc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8814
+0000000000001900  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8815
+0000000000001904  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8819
+0000000000001908  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 881f
+000000000000190c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8820
+0000000000001910  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8822
+0000000000001914  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8824
+0000000000001918  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8826
+000000000000191c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8828
+0000000000001920  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8829
+0000000000001924  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 88f4
+0000000000001928  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8900
+000000000000192c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8901
+0000000000001930  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8910
+0000000000001934  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8932
+0000000000001938  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8934
+000000000000193c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8936
+0000000000001940  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 893e
+0000000000001944  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8945
+0000000000001948  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8949
+000000000000194c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8b27
+0000000000001950  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8b28
+0000000000001954  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8b29
+0000000000001958  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8b2b
+000000000000195c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8b2d
+0000000000001960  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8b2f
+0000000000001964  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8b30
+0000000000001968  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8bae
+000000000000196c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8bb0
+0000000000001970  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8bb1
+0000000000001974  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8bb2
+0000000000001978  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8be3
+000000000000197c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8be4
+0000000000001980  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8be9
+0000000000001984  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8bf0
+0000000000001988  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8bf2
+000000000000198c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8bfd
+0000000000001990  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8c04
+0000000000001994  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8c32
+0000000000001998  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8c33
+000000000000199c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8c35
+00000000000019a0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8c36
+00000000000019a4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8c40
+00000000000019a8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8c42
+00000000000019ac  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8c4b
+00000000000019b0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8c52
+00000000000019b4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8c81
+00000000000019b8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8c82
+00000000000019bc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8c84
+00000000000019c0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8c85
+00000000000019c4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8c90
+00000000000019c8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8caa
+00000000000019cc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8cb0
+00000000000019d0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8cb2
+00000000000019d4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8cbd
+00000000000019d8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8cc4
+00000000000019dc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8cfa
+00000000000019e0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8cfb
+00000000000019e4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8cfd
+00000000000019e8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8cfe
+00000000000019ec  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8d00
+00000000000019f0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8d02
+00000000000019f4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8d03
+00000000000019f8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8d04
+00000000000019fc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8d18
+0000000000001a00  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8db0
+0000000000001a04  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8db1
+0000000000001a08  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8db2
+0000000000001a0c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8db4
+0000000000001a10  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8db5
+0000000000001a14  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8dc9
+0000000000001a18  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8dd0
+0000000000001a1c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8dd1
+0000000000001a20  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8dd3
+0000000000001a24  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8dd8
+0000000000001a28  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8ddd
+0000000000001a2c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8de0
+0000000000001a30  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8de1
+0000000000001a34  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8de2
+0000000000001a38  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8de9
+0000000000001a3c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8e25
+0000000000001a40  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8e26
+0000000000001a44  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8e27
+0000000000001a48  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8e28
+0000000000001a4c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8eaa
+0000000000001a50  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8eb0
+0000000000001a54  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8eb2
+0000000000001a58  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8eb4
+0000000000001a5c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8eb5
+0000000000001a60  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8eb6
+0000000000001a64  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8f50
+0000000000001a68  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8f51
+0000000000001a6c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8f53
+0000000000001a70  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8f55
+0000000000001a74  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8f5a
+0000000000001a78  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8f6b
+0000000000001a7c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8f70
+0000000000001a80  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8f71
+0000000000001a84  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8f72
+0000000000001a88  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8fad
+0000000000001a8c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8fb0
+0000000000001a90  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8fb2
+0000000000001a94  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8fb4
+0000000000001a98  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8fb6
+0000000000001a9c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8fbb
+0000000000001aa0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8fbf
+0000000000001aa4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8fc0
+0000000000001aa8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 8fc4
+0000000000001aac  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9152
+0000000000001ab0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9153
+0000000000001ab4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9154
+0000000000001ab8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9156
+0000000000001abc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9158
+0000000000001ac0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 915a
+0000000000001ac4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 915c
+0000000000001ac8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 915d
+0000000000001acc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9399
+0000000000001ad0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 93a0
+0000000000001ad4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 93d8
+0000000000001ad8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 93e0
+0000000000001adc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 93e7
+0000000000001ae0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 93f0
+0000000000001ae4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 948b
+0000000000001ae8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9490
+0000000000001aec  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9515
+0000000000001af0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9520
+0000000000001af4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 956d
+0000000000001af8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9570
+0000000000001afc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9574
+0000000000001b00  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 95e3
+0000000000001b04  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 95e4
+0000000000001b08  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9600
+0000000000001b0c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 960f
+0000000000001b10  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9610
+0000000000001b14  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 961c
+0000000000001b18  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9620
+0000000000001b1c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9624
+0000000000001b20  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9690
+0000000000001b24  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9691
+0000000000001b28  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 96ad
+0000000000001b2c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 96b0
+0000000000001b30  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 96b2
+0000000000001b34  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 96b4
+0000000000001b38  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 96b6
+0000000000001b3c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 96b7
+0000000000001b40  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 96b8
+0000000000001b44  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 96bf
+0000000000001b48  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9754
+0000000000001b4c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9758
+0000000000001b50  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9759
+0000000000001b54  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 975b
+0000000000001b58  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 975d
+0000000000001b5c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 975f
+0000000000001b60  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9760
+0000000000001b64  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 98e9
+0000000000001b68  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 98f0
+0000000000001b6c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 98f1
+0000000000001b70  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 98fa
+0000000000001b74  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9945
+0000000000001b78  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9946
+0000000000001b7c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9947
+0000000000001b80  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9961
+0000000000001b84  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9970
+0000000000001b88  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9971
+0000000000001b8c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 997a
+0000000000001b90  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 99c6
+0000000000001b94  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 99c7
+0000000000001b98  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 99c8
+0000000000001b9c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 99e2
+0000000000001ba0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 99f0
+0000000000001ba4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 99f2
+0000000000001ba8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 99f3
+0000000000001bac  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 99f7
+0000000000001bb0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9a28
+0000000000001bb4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9a29
+0000000000001bb8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9a2b
+0000000000001bbc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9a2c
+0000000000001bc0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9a64
+0000000000001bc4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9a65
+0000000000001bc8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9a67
+0000000000001bcc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9a68
+0000000000001bd0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9a72
+0000000000001bd4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9a80
+0000000000001bd8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9a81
+0000000000001bdc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9a82
+0000000000001be0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9a86
+0000000000001be4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9ad8
+0000000000001be8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9ad9
+0000000000001bec  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9ada
+0000000000001bf0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9adb
+0000000000001bf4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9b13
+0000000000001bf8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9b20
+0000000000001bfc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9b21
+0000000000001c00  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9b22
+0000000000001c04  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9b26
+0000000000001c08  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9b78
+0000000000001c0c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9b79
+0000000000001c10  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9b7a
+0000000000001c14  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9b7b
+0000000000001c18  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9bb4
+0000000000001c1c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9bc0
+0000000000001c20  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9bc2
+0000000000001c24  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9c01
+0000000000001c28  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9c02
+0000000000001c2c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9c10
+0000000000001c30  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9c37
+0000000000001c34  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9c40
+0000000000001c38  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9c42
+0000000000001c3c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9c44
+0000000000001c40  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9c45
+0000000000001c44  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9c46
+0000000000001c48  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9ce5
+0000000000001c4c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9ce6
+0000000000001c50  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9ce8
+0000000000001c54  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9cea
+0000000000001c58  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9cef
+0000000000001c5c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9cf0
+0000000000001c60  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9cf2
+0000000000001c64  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9cf7
+0000000000001c68  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9cf9
+0000000000001c6c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9cfb
+0000000000001c70  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9cff
+0000000000001c74  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9d07
+0000000000001c78  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9d0e
+0000000000001c7c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9e55
+0000000000001c80  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9e56
+0000000000001c84  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9e57
+0000000000001c88  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9e59
+0000000000001c8c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9e5b
+0000000000001c90  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9e5d
+0000000000001c94  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9e5f
+0000000000001c98  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9e64
+0000000000001c9c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9e70
+0000000000001ca0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9e8a
+0000000000001ca4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9e90
+0000000000001ca8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9ece
+0000000000001cac  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9ed0
+0000000000001cb0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9f25
+0000000000001cb4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9f30
+0000000000001cb8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9f52
+0000000000001cbc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9f55
+0000000000001cc0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9f5d
+0000000000001cc4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9f68
+0000000000001cc8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9fcc
+0000000000001ccc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9fcd
+0000000000001cd0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9fce
+0000000000001cd4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9fd0
+0000000000001cd8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 9fd1
+0000000000001cdc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a03e
+0000000000001ce0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a040
+0000000000001ce4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a042
+0000000000001ce8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a044
+0000000000001cec  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a045
+0000000000001cf0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a04d
+0000000000001cf4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a0e4
+0000000000001cf8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a0e5
+0000000000001cfc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a0e7
+0000000000001d00  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a0e9
+0000000000001d04  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a0ea
+0000000000001d08  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a10f
+0000000000001d0c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a110
+0000000000001d10  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a112
+0000000000001d14  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a114
+0000000000001d18  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a115
+0000000000001d1c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a177
+0000000000001d20  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a178
+0000000000001d24  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a17a
+0000000000001d28  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a17c
+0000000000001d2c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a17d
+0000000000001d30  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a17f
+0000000000001d34  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a180
+0000000000001d38  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a1a8
+0000000000001d3c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a1b0
+0000000000001d40  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a1b1
+0000000000001d44  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a1b2
+0000000000001d48  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a1bd
+0000000000001d4c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a220
+0000000000001d50  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a221
+0000000000001d54  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a222
+0000000000001d58  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a223
+0000000000001d5c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a230
+0000000000001d60  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a232
+0000000000001d64  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a236
+0000000000001d68  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a238
+0000000000001d6c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a23a
+0000000000001d70  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a23e
+0000000000001d74  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a23f
+0000000000001d78  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a24a
+0000000000001d7c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a2c0
+0000000000001d80  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a2c3
+0000000000001d84  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a2c4
+0000000000001d88  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a2c6
+0000000000001d8c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a2c8
+0000000000001d90  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a2ca
+0000000000001d94  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a2cc
+0000000000001d98  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a2cd
+0000000000001d9c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a2d7
+0000000000001da0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a2e0
+0000000000001da4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a2e1
+0000000000001da8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a303
+0000000000001dac  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a304
+0000000000001db0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a30a
+0000000000001db4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a30b
+0000000000001db8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a310
+0000000000001dbc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a312
+0000000000001dc0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a319
+0000000000001dc4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a31a
+0000000000001dc8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a31b
+0000000000001dcc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a31f
+0000000000001dd0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a44a
+0000000000001dd4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a44b
+0000000000001dd8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a44c
+0000000000001ddc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a44e
+0000000000001de0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a450
+0000000000001de4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a451
+0000000000001de8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a46c
+0000000000001dec  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a470
+0000000000001df0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a472
+0000000000001df4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a478
+0000000000001df8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a4c8
+0000000000001dfc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a4ca
+0000000000001e00  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a4cb
+0000000000001e04  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a4de
+0000000000001e08  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a4e0
+0000000000001e0c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a4e1
+0000000000001e10  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a4ea
+0000000000001e14  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a4f0
+0000000000001e18  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a514
+0000000000001e1c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a520
+0000000000001e20  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a521
+0000000000001e24  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a52c
+0000000000001e28  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a5c1
+0000000000001e2c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a5c2
+0000000000001e30  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a5c7
+0000000000001e34  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a5cb
+0000000000001e38  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a5d0
+0000000000001e3c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a5e4
+0000000000001e40  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a5f0
+0000000000001e44  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a603
+0000000000001e48  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a610
+0000000000001e4c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a611
+0000000000001e50  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a672
+0000000000001e54  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a677
+0000000000001e58  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a680
+0000000000001e5c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a682
+0000000000001e60  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a684
+0000000000001e64  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a686
+0000000000001e68  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a688
+0000000000001e6c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a689
+0000000000001e70  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a68a
+0000000000001e74  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a691
+0000000000001e78  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a750
+0000000000001e7c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a751
+0000000000001e80  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a752
+0000000000001e84  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a754
+0000000000001e88  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a756
+0000000000001e8c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a758
+0000000000001e90  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a75a
+0000000000001e94  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a75b
+0000000000001e98  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a84d
+0000000000001e9c  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a850
+0000000000001ea0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a851
+0000000000001ea4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a858
+0000000000001ea8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a8a4
+0000000000001eac  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a8a5
+0000000000001eb0  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a8a6
+0000000000001eb4  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a8ab
+0000000000001eb8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a8b0
+0000000000001ebc  0000000200000002 R_X86_64_PC32          0000000000000000 .text + a8e8
+0000000000001ec0  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 0
+0000000000001ec4  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 5
+0000000000001ec8  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 8
+0000000000001ecc  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + d
+0000000000001ed0  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 10
+0000000000001ed4  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 15
+0000000000001ed8  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 18
+0000000000001edc  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 1d
+0000000000001ee0  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 20
+0000000000001ee4  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 25
+0000000000001ee8  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 28
+0000000000001eec  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 2d
+0000000000001ef0  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 30
+0000000000001ef4  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 35
+0000000000001ef8  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 38
+0000000000001efc  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 3d
+0000000000001f00  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 40
+0000000000001f04  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 45
+0000000000001f08  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 48
+0000000000001f0c  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 4d
+0000000000001f10  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 50
+0000000000001f14  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 55
+0000000000001f18  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 58
+0000000000001f1c  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 5d
+0000000000001f20  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 60
+0000000000001f24  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 65
+0000000000001f28  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 68
+0000000000001f2c  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 6d
+0000000000001f30  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 70
+0000000000001f34  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 75
+0000000000001f38  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 78
+0000000000001f3c  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 7d
+0000000000001f40  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 80
+0000000000001f44  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 85
+0000000000001f48  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 88
+0000000000001f4c  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 8d
+0000000000001f50  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 90
+0000000000001f54  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 95
+0000000000001f58  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 98
+0000000000001f5c  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 9d
+0000000000001f60  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + a0
+0000000000001f64  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + a5
+0000000000001f68  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + a8
+0000000000001f6c  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + ad
+0000000000001f70  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + b0
+0000000000001f74  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + b5
+0000000000001f78  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + b8
+0000000000001f7c  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + bd
+0000000000001f80  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + c0
+0000000000001f84  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + c5
+0000000000001f88  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + c8
+0000000000001f8c  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + cd
+0000000000001f90  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + d0
+0000000000001f94  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + d5
+0000000000001f98  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + d8
+0000000000001f9c  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + dd
+0000000000001fa0  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + e0
+0000000000001fa4  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + e5
+0000000000001fa8  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + e8
+0000000000001fac  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + ed
+0000000000001fb0  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + f0
+0000000000001fb4  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + f5
+0000000000001fb8  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + f8
+0000000000001fbc  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + fd
+0000000000001fc0  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 100
+0000000000001fc4  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 105
+0000000000001fc8  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 108
+0000000000001fcc  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 10d
+0000000000001fd0  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 110
+0000000000001fd4  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 115
+0000000000001fd8  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 118
+0000000000001fdc  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 11d
+0000000000001fe0  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 120
+0000000000001fe4  0000000600000002 R_X86_64_PC32          0000000000000000 .static_call.text + 125
+0000000000001fe8  0000013700000002 R_X86_64_PC32          0000000000000000 .init.text + 0
+0000000000001fec  0000013700000002 R_X86_64_PC32          0000000000000000 .init.text + 1
+0000000000001ff0  0000013700000002 R_X86_64_PC32          0000000000000000 .init.text + 57
+0000000000001ff4  0000013700000002 R_X86_64_PC32          0000000000000000 .init.text + 132
+0000000000001ff8  0000013700000002 R_X86_64_PC32          0000000000000000 .init.text + 134
+0000000000001ffc  0000013700000002 R_X86_64_PC32          0000000000000000 .init.text + 136
+0000000000002000  0000013700000002 R_X86_64_PC32          0000000000000000 .init.text + 138
+0000000000002004  0000013700000002 R_X86_64_PC32          0000000000000000 .init.text + 139
+0000000000002008  0000013700000002 R_X86_64_PC32          0000000000000000 .init.text + 13a
+000000000000200c  0000013700000002 R_X86_64_PC32          0000000000000000 .init.text + 522
+0000000000002010  0000013700000002 R_X86_64_PC32          0000000000000000 .init.text + 523
+0000000000002014  0000013700000002 R_X86_64_PC32          0000000000000000 .init.text + 525
+0000000000002018  0000013700000002 R_X86_64_PC32          0000000000000000 .init.text + 527
+000000000000201c  0000013700000002 R_X86_64_PC32          0000000000000000 .init.text + 529
+0000000000002020  0000013700000002 R_X86_64_PC32          0000000000000000 .init.text + 52b
+0000000000002024  0000013700000002 R_X86_64_PC32          0000000000000000 .init.text + 52c
+0000000000002028  0000013a00000002 R_X86_64_PC32          0000000000000000 .text.unlikely + 0
+000000000000202c  0000013a00000002 R_X86_64_PC32          0000000000000000 .text.unlikely + 2c
+0000000000002030  0000013a00000002 R_X86_64_PC32          0000000000000000 .text.unlikely + 2d
+0000000000002034  0000013a00000002 R_X86_64_PC32          0000000000000000 .text.unlikely + 53
+0000000000002038  0000013a00000002 R_X86_64_PC32          0000000000000000 .text.unlikely + 12b
+000000000000203c  0000013a00000002 R_X86_64_PC32          0000000000000000 .text.unlikely + 12d
+0000000000002040  0000013a00000002 R_X86_64_PC32          0000000000000000 .text.unlikely + 12f
+0000000000002044  0000013a00000002 R_X86_64_PC32          0000000000000000 .text.unlikely + 134
+0000000000002048  0000013a00000002 R_X86_64_PC32          0000000000000000 .text.unlikely + 139
+000000000000204c  0000013a00000002 R_X86_64_PC32          0000000000000000 .text.unlikely + 15a
+0000000000002050  0000013a00000002 R_X86_64_PC32          0000000000000000 .text.unlikely + 172
+0000000000002054  0000013a00000002 R_X86_64_PC32          0000000000000000 .text.unlikely + 237
+0000000000002058  0000013a00000002 R_X86_64_PC32          0000000000000000 .text.unlikely + 238
+000000000000205c  0000013a00000002 R_X86_64_PC32          0000000000000000 .text.unlikely + 252
+0000000000002060  0000013a00000002 R_X86_64_PC32          0000000000000000 .text.unlikely + 266
+0000000000002064  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 0
+0000000000002068  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 1
+000000000000206c  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 5
+0000000000002070  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 6c
+0000000000002074  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 6d
+0000000000002078  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 6e
+000000000000207c  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 70
+0000000000002080  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 71
+0000000000002084  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 74
+0000000000002088  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 2c8
+000000000000208c  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 2c9
+0000000000002090  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 732
+0000000000002094  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 740
+0000000000002098  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 741
+000000000000209c  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 74b
+00000000000020a0  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 797
+00000000000020a4  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 798
+00000000000020a8  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 79d
+00000000000020ac  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 79e
+00000000000020b0  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 79f
+00000000000020b4  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 7a0
+00000000000020b8  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 7c1
+00000000000020bc  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 7c2
+00000000000020c0  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 7c7
+00000000000020c4  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 7dd
+00000000000020c8  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 7e0
+00000000000020cc  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 7e4
+00000000000020d0  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 809
+00000000000020d4  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 80e
+00000000000020d8  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 810
+00000000000020dc  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 811
+00000000000020e0  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 86f
+00000000000020e4  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 871
+00000000000020e8  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 884
+00000000000020ec  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 885
+00000000000020f0  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 8a5
+00000000000020f4  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 8a6
+00000000000020f8  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 8b0
+00000000000020fc  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 8b2
+0000000000002100  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 8b4
+0000000000002104  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 8b6
+0000000000002108  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 8b8
+000000000000210c  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 8bc
+0000000000002110  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 8bd
+0000000000002114  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 8ca
+0000000000002118  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 8cf
+000000000000211c  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 8d1
+0000000000002120  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 905
+0000000000002124  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 906
+0000000000002128  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 993
+000000000000212c  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 994
+0000000000002130  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 995
+0000000000002134  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 997
+0000000000002138  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 999
+000000000000213c  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 99b
+0000000000002140  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 99d
+0000000000002144  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + 99e
+0000000000002148  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + a1b
+000000000000214c  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + a20
+0000000000002150  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + a21
+0000000000002154  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + a4b
+0000000000002158  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + a4c
+000000000000215c  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + a50
+0000000000002160  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + a56
+0000000000002164  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + a60
+0000000000002168  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + a61
+000000000000216c  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + a70
+0000000000002170  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + a71
+0000000000002174  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + a93
+0000000000002178  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + a94
+000000000000217c  0000014f00000002 R_X86_64_PC32          0000000000000000 .sched.text + a96
+
+Symbol table '.symtab' contains 1221 entries:
    Num:    Value          Size Type    Bind   Vis      Ndx Name
      0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT  UND 
      1: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS core.c
@@ -17092,3 +19618,10 @@
   1211: 0000000000002e70    16 OBJECT  GLOBAL DEFAULT    3 __SCK__tp_func_sched_kthread_work_queue_work
   1212: 0000000000002e80    16 OBJECT  GLOBAL DEFAULT    3 __SCK__tp_func_sched_kthread_stop_ret
   1213: 0000000000002e90    16 OBJECT  GLOBAL DEFAULT    3 __SCK__tp_func_sched_kthread_stop
+  1214: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __x86_alt_jmp_rax
+  1215: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __x86_alt_call_rax
+  1216: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __x86_alt_call_rdx
+  1217: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __x86_alt_call_r13
+  1218: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __x86_alt_call_r12
+  1219: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __x86_alt_call_rbx
+  1220: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND __x86_alt_call_r8
