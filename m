Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1A13EB41D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 12:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239851AbhHMKim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 06:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235482AbhHMKil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 06:38:41 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D44C061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 03:38:15 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso1040888pjh.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 03:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wb+uduTJVU+Q+I0bdgQ7CYu7XXOHIlVR7bsVSo1eKE4=;
        b=doDCzqDIpeCdeqR4X+xvbtG6wia6MICmN7cfZE1GICfZwgHFvUrAdt5bOUSA/RFNrd
         LtcNVNJRT4hNJh12FSM5n2wLVUzykZck0U1QQOuGMVcGQKlan6prUU7AvcFuAq3u+ruk
         R7841akUmq1nVR9DGmzyTUJkciEFohBawAVEqKF5xRi1YLUPAxW4dKe3c+AA6CNmyFkK
         5NqVBVjRDygxHKONRPUJlZCwlMdh32moX1CSB7luF2y3QxqmJRa6AHYOmbSpd+0jDU0g
         Dr3JG2MRQWb3aMM2trI/ULgBkTuONQSALTK01+hfVPAtfAHrn/sdMpqigSuL/k2vL48p
         evVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wb+uduTJVU+Q+I0bdgQ7CYu7XXOHIlVR7bsVSo1eKE4=;
        b=eFNwpRJtS4y+HPRrGEVzgu8KRA9t481ZyYUpfgtP6SKrlR+91Zaj5baaI75AxlhXD8
         w364KAdoBIjfEk5tkcUDH/QxBjeNaVxsWQHAw1+Q/tfPiUdetF7oDF7iYKROleTx+CaV
         w0ybemk60AVZtwpz+4OOLj+d1yf6vEJGKTxdJYjBbrwPpyNb/oViaQ5eOHJQATbPfDBY
         K4a4ROK/ryqk7vyg8rz1BPXNVEfR9S3LLOdzfYAOVKPX6TA2QJZ+uchaZzMgX1HXuwad
         C8eWCps6OGkF1LkvRuZcoqddcca5Q/MSrSf9k6aYoO+3rnN9LcSbtE44+6Pjr1BXRtAk
         2N/Q==
X-Gm-Message-State: AOAM53237nrCKyPcqtzy8aoUJWvSXoXLZ29F+9xfe9H+CXH8GkWlPoQN
        Aof7SkIzzkvUZgVFLdq8BYYZJw==
X-Google-Smtp-Source: ABdhPJyalLlpcNVdYB/LwDrXDGBqzJJxmPbAFFX7ylbJhEFjtdt3EOwq7IpwXrq61/Z5lNsO4v0EVw==
X-Received: by 2002:a63:2217:: with SMTP id i23mr1801072pgi.448.1628851094686;
        Fri, 13 Aug 2021 03:38:14 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id r11sm1522653pjd.26.2021.08.13.03.38.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Aug 2021 03:38:14 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] x86/unwind/orc: fix the check of stack addresses
Date:   Fri, 13 Aug 2021 18:38:04 +0800
Message-Id: <20210813103804.62215-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In our server, we saw a kernel panic, the call trace is like below.

  BUG: stack guard page was hit at 000000001ff76a9e (stack is
       0000000095d6f9f7..00000000dd56db03)
  kernel stack overflow (page fault): 0000 [#1] SMP NOPTI
  RIP: 0010:unwind_next_frame+0x34e/0x570
  RSP: 0000:fffffe000221a8f0 EFLAGS: 00010002
  RAX: 0000000000000001 RBX: fffffe000221a930 RCX: 0000000000000001
  RDX: 0000000000000010 RSI: ffff8a01c3b0adc0 RDI: ffffa6b9f75c7fc8
  RBP: 0000000000000004 R08: ffffffff9b200982 R09: ffffffff9bc48718
  R10: ffffffff9bc48714 R11: 0000000000000014 R12: ffffffff9bdf54fa
  R13: ffffffff9b20098c R14: fffffe0002213ff0 R15: ffffa6b9f75c7fc8
  FS:  00007f1ea9f0c700(0000) GS:ffff8a4c4f7c0000(0000)
  knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: ffffa6b9f75c8048 CR3: 00000025c7064000 CR4: 0000000000340ee0
  Call Trace:
   <NMI>
   perf_callchain_kernel+0x125/0x140
   ? interrupt_entry+0xac/0xc3
   get_perf_callchain+0x113/0x280
   perf_callchain+0x6f/0x80
   perf_prepare_sample+0x87/0x510
   perf_event_output_forward+0x2a/0x80
   ? sched_clock+0x5/0x10
   ? sched_clock_cpu+0xc/0xa0
   ? arch_perf_update_userpage+0xd0/0xe0
   __perf_event_overflow+0x4f/0xf0
   perf_ibs_handle_irq+0x37d/0x4e0
   ? interrupt_entry+0xac/0xc3
   ? interrupt_entry+0xac/0xc3
   ? __set_pte_vaddr+0x32/0x50
   ? __set_pte_vaddr+0x32/0x50
   ? set_pte_vaddr+0x3c/0x60
   ? __native_set_fixmap+0x24/0x30
   ? native_set_fixmap+0x40/0x60
   ? ghes_copy_tofrom_phys+0x99/0x130
   ? apei_read+0x90/0xb0
   ? interrupt_entry+0xac/0xc3
   ? __ghes_peek_estatus.isra.15+0x51/0xc0
   ? perf_ibs_nmi_handler+0x34/0x56
   ? sched_clock+0x5/0x10
   perf_ibs_nmi_handler+0x34/0x56
   nmi_handle+0x70/0x170
   default_do_nmi+0x4e/0x100
   do_nmi+0x156/0x1a0
   end_repeat_nmi+0x16/0x50

The register of CR2 is the fault address, where is 0xffffa6b9f75c8048.
And the stack range of the current task is [0xffffa6b9f75c4000,
0xffffa6b9f75c7fff]. We can see that 0xffffa6b9f75c8048 goes beyond
the range. So we saw kernel panic.

    perf_callchain_kernel
        unwind_next_frame
            deref_stack_regs(state, addr, ip, sp)
            {
                struct pt_regs *regs = (struct pt_regs *)addr;

                if (!stack_access_ok(state, addr, sizeof(struct pt_regs)))
                    return false;

                *ip = READ_ONCE_NOCHECK(regs->ip); // regs->ip trigger panic
            }

We can see the value of @state through crash tool, and the @addr and
@regs are 0xffffa6b9f75c7fc8.

crash> struct unwind_state.stack_info fffffe000221a930 -x
  stack_info = {
    type = STACK_TYPE_TASK,
    begin = 0xffffa6b9f75c4000,
    end = 0xffffa6b9f75c8000,
    next_sp = 0x0
  }

The aim of stack_access_ok() is to check the range if it is valid, where
the range is [0xffffa6b9f75c7fc8, 0xffffa6b9f75c7fc8 + sizeof(struct
pt_regs)]. The size of 'struct pt_regs' is 168, so the range goes beyond
the stack range. However, it passes its check. The reason is that
get_stack_info() only checks the @addr whether it is in the valid stack
range but ignores the 'len'. We need to recheck the range if it is valid
after get_stack_info returns to fix this issue.

Fixes: ee9f8fce9964 ("x86/unwind: Add the ORC unwinder")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/x86/kernel/unwind_orc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 187a86e0e753..54c3037d2687 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -336,11 +336,13 @@ static bool stack_access_ok(struct unwind_state *state, unsigned long _addr,
 	struct stack_info *info = &state->stack_info;
 	void *addr = (void *)_addr;
 
-	if (!on_stack(info, addr, len) &&
-	    (get_stack_info(addr, state->task, info, &state->stack_mask)))
+	if (on_stack(info, addr, len))
+		return true;
+
+	if (get_stack_info(addr, state->task, info, &state->stack_mask))
 		return false;
 
-	return true;
+	return on_stack(info, addr, len);
 }
 
 static bool deref_stack_reg(struct unwind_state *state, unsigned long addr,
-- 
2.11.0

