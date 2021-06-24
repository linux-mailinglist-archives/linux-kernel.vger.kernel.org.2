Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92EB3B3123
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 16:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbhFXOUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 10:20:00 -0400
Received: from mail1.windriver.com ([147.11.146.13]:57608 "EHLO mail1.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230170AbhFXOT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 10:19:59 -0400
X-Greylist: delayed 2995 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Jun 2021 10:19:59 EDT
Received: from mail.windriver.com (mail.wrs.com [147.11.1.11])
        by mail1.wrs.com (8.15.2/8.15.2) with ESMTPS id 15ODR1w0024012
        (version=TLSv1.1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Thu, 24 Jun 2021 06:27:02 -0700
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com [147.11.82.252])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 15ODR0Mg009102
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Jun 2021 06:27:00 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Thu, 24 Jun 2021 06:26:59 -0700
Received: from pek-lpd-ccm2.wrs.com (128.224.179.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2242.10 via Frontend Transport; Thu, 24 Jun 2021 06:26:58 -0700
From:   Yun Zhou <yun.zhou@windriver.com>
To:     <rostedt@goodmis.org>
CC:     <linux-kernel@vger.kernel.org>,
        <kernel-hardening@lists.openwall.com>, <ying.xue@windriver.com>,
        <ps-ccm-rr@windriver.com>
Subject: [PATCH] seq_buf: let seq_buf_putmem_hex support len larger than 8
Date:   Thu, 24 Jun 2021 21:16:46 +0800
Message-ID: <20210624131646.17878-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I guess the original intention of seq_buf_putmem_hex is to dump the raw
memory to seq_buf according to 64 bits integer number. It tries to output
numbers in reverse, with the high bits in the front and the low bits in
the back. If the length of the raw memory is equal to 8, e.g.
"01 23 45 67 89 ab cd ef" in memory, it will be dumped as "efcdab8967452301".

But if the length of the raw memory is larger than 8, the first value of
start_len will larger than 8, than seq_buf will save the last data, not
the eighth one, e.g. "01 23 45 67 89 ab cd ef 11" in memory, it will be
dumped as "11efcdab8967452301". I think it is not the original
intention of the function.

More seriously, if the length of the raw memory is larger than 9, the
start_len will be larger than 9, then hex will overflow, and the stack will be
corrupted. I do not kown if it can be exploited by hacker. But I am sure
it will cause kernel panic when the length of memory is more than 32 bytes.

[  448.551471] Unable to handle kernel paging request at virtual address 3438376c
[  448.558678] pgd = 6eaf278e
[  448.561376] [3438376c] *pgd=00000000
[  448.564945] Internal error: Oops: 5 [#2] PREEMPT ARM
[  448.569899] Modules linked in:
[  448.572951] CPU: 0 PID: 368 Comm: cat Tainted: G        W        4.18.40-yocto-standard #18
[  448.581374] Hardware name: Xilinx Zynq Platform
[  448.585901] PC is at trace_seq_putmem_hex+0x6c/0x84
[  448.590768] LR is at 0x20643032
[  448.593901] pc : [<c009a85c>]    lr : [<20643032>]    psr: 60000093
[  448.600159] sp : d980dc08  ip : 00000020  fp : c05f58cc
[  448.605375] r10: c05e5f30  r9 : 00000031  r8 : 00000000
[  448.610584] r7 : 20643032  r6 : 37663666  r5 : 36343730  r4 : 34383764
[  448.617103] r3 : 00001000  r2 : 00000042  r1 : d980dc00  r0 : 00000000
...
[  448.907962] [<c009a85c>] (trace_seq_putmem_hex) from [<c010b008>] (trace_raw_output_write+0x58/0x9c)
[  448.917094] [<c010b008>] (trace_raw_output_write) from [<c00964c0>] (print_trace_line+0x144/0x3e8)
[  448.926050] [<c00964c0>] (print_trace_line) from [<c0098710>] (ftrace_dump+0x204/0x254)
[  448.934053] [<c0098710>] (ftrace_dump) from [<c0098780>] (trace_die_handler+0x20/0x34)
[  448.941975] [<c0098780>] (trace_die_handler) from [<c003cff8>] (notifier_call_chain+0x48/0x6c)
[  448.950581] [<c003cff8>] (notifier_call_chain) from [<c003d19c>] (__atomic_notifier_call_chain+0x3c/0x50)
[  448.960142] [<c003d19c>] (__atomic_notifier_call_chain) from [<c003d1cc>] (atomic_notifier_call_chain+0x1c/0x24)
[  448.970306] [<c003d1cc>] (atomic_notifier_call_chain) from [<c003d204>] (notify_die+0x30/0x3c)
[  448.978908] [<c003d204>] (notify_die) from [<c001361c>] (die+0xc4/0x258)
[  448.985604] [<c001361c>] (die) from [<c00173e8>] (__do_kernel_fault.part.0+0x5c/0x7c)
[  448.993438] [<c00173e8>] (__do_kernel_fault.part.0) from [<c043a270>] (do_page_fault+0x158/0x394)
[  449.002305] [<c043a270>] (do_page_fault) from [<c00174dc>] (do_DataAbort+0x40/0xec)
[  449.009959] [<c00174dc>] (do_DataAbort) from [<c0009970>] (__dabt_svc+0x50/0x80)

Additionally, the address of data ptr keeps in the same value in multiple
loops, the value of data buffer will not be picked forever.

Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
---
 lib/seq_buf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/seq_buf.c b/lib/seq_buf.c
index 6aabb609dd87..948c8b55f666 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -229,7 +229,7 @@ int seq_buf_putmem_hex(struct seq_buf *s, const void *mem,
 	WARN_ON(s->size == 0);
 
 	while (len) {
-		start_len = min(len, HEX_CHARS - 1);
+		start_len = min(len, MAX_MEMHEX_BYTES);
 #ifdef __BIG_ENDIAN
 		for (i = 0, j = 0; i < start_len; i++) {
 #else
@@ -248,6 +248,8 @@ int seq_buf_putmem_hex(struct seq_buf *s, const void *mem,
 		seq_buf_putmem(s, hex, j);
 		if (seq_buf_has_overflowed(s))
 			return -1;
+
+		data += start_len;
 	}
 	return 0;
 }
-- 
2.26.1

