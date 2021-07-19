Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE6A3CED7F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384985AbhGSSmf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 19 Jul 2021 14:42:35 -0400
Received: from shelob.surriel.com ([96.67.55.147]:48214 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384096AbhGSSUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 14:20:19 -0400
Received: from [2603:3005:d05:2b00:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <riel@shelob.surriel.com>)
        id 1m5YVR-00033U-C0; Mon, 19 Jul 2021 15:00:45 -0400
Date:   Mon, 19 Jul 2021 15:00:41 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, kernel-team@fb.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Subject: [PATCH] x86,mm: print likely CPU at segfault time
Message-ID: <20210719150041.3c719c94@imladris.surriel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 14d31a44a5186c94399dc9518ba80adf64c99772 Mon Sep 17 00:00:00 2001
From: Rik van Riel <riel@butters.home.surriel.com>
Date: Mon, 19 Jul 2021 14:49:17 -0400
Subject: [PATCH] x86,mm: print likely CPU at segfault time

In a large enough fleet of computers, it is common to have a few bad
CPUs. Those can often be identified by seeing that some commonly run
kernel code (that runs fine everywhere else) keeps crashing on the
same CPU core on a particular bad system.

One of the failure modes observed is that either the instruction pointer,
or some register used to specify the address of data that needs to be
fetched gets corrupted, resulting in something like a kernel page fault,
null pointer dereference, NX violation, or similar.

Those kernel failures are often preceded by similar looking userspace
failures. It would be useful to know if those are also happening on
the same CPU cores, to get a little more confirmation that it is indeed
a hardware issue.

Adding a printk to show_signal_msg() achieves that purpose. It isn't
perfect since the task might get rescheduled on another CPU between
when the fault hit and when the message is printed, but it should be
good enough to show correlation between userspace and kernel errors
when dealing with a bad CPU.

$ ./segfault
Segmentation fault (core dumped)
$ dmesg | grep segfault
segfault[1349]: segfault at 0 ip 000000000040113a sp 00007ffc6d32e360 error 4 in segfault[401000+1000] on CPU 0

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 arch/x86/mm/fault.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index b2eefdefc108..dd6c89c23a3a 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -777,6 +777,8 @@ show_signal_msg(struct pt_regs *regs, unsigned long error_code,
 
 	print_vma_addr(KERN_CONT " in ", regs->ip);
 
+	printk(KERN_CONT " on CPU %d", raw_smp_processor_id());
+
 	printk(KERN_CONT "\n");
 
 	show_opcodes(regs, loglvl);
-- 
2.24.1


