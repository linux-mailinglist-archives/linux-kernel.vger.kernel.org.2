Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F03B3D30E7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 02:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbhGVXsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 19:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbhGVXsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 19:48:35 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88EDAC061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 17:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=06FIoFo1++Bs1nXh2OQvBAB1I83x6yDvJoaM9tHykL0=; b=SsW/nOBciSh6t
        7FOb3GX9o3RWpNlrvTVWFF+pJUz/WWgTX9JVb7f8Cjf4wwQwd9E/nqNjudYmuY2l
        a3ysWsjbPf6N6u9VxDRh6BmzdeGwO+ADjP0e1ePxbU3RmxvVkfks3x+tf5055Fxb
        cVOKDxI+1N7z8nX7spu2vp68NMitbc=
Received: from xhacker (unknown [101.86.20.15])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygAnL3coDfpgk9guAA--.6267S2;
        Fri, 23 Jul 2021 08:28:24 +0800 (CST)
Date:   Fri, 23 Jul 2021 08:22:26 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andreas Schwab <schwab@linux-m68k.org>,
        Atish Patra <atishp@atishpatra.org>
Subject: [PATCH] riscv: stacktrace: pin the task's stack in get_wchan
Message-ID: <20210723082226.7b7b4707@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygAnL3coDfpgk9guAA--.6267S2
X-Coremail-Antispam: 1UD129KBjvJXoWxury3JF1UCF43Xry7Xr4fZrb_yoW5uF1kpr
        13AF17CFW8Xr42yr13Ar1rXr48GFyDAay7Jr97tr15CF15Gw18X34DJanrGr1DXw1jqFy7
        Gr1Dtw4kKr4DJaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyqb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
        W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I
        3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
        WUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
        wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcI
        k0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
        6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUqEoXUUUUU
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <jszhang@kernel.org>

Pin the task's stack before calling walk_stackframe() in get_wchan().
This can fix the panic as reported by Andreas when CONFIG_VMAP_STACK=y:

[   65.609696] Unable to handle kernel paging request at virtual address ffffffd0003bbde8
[   65.610460] Oops [#1]
[   65.610626] Modules linked in: virtio_blk virtio_mmio rtc_goldfish btrfs blake2b_generic libcrc32c xor raid6_pq sg dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua efivarfs
[   65.611670] CPU: 2 PID: 1 Comm: systemd Not tainted 5.14.0-rc1-1.g34fe32a-default #1 openSUSE Tumbleweed (unreleased) c62f7109153e5a0897ee58ba52393ad99b070fd2
[   65.612334] Hardware name: riscv-virtio,qemu (DT)
[   65.613008] epc : get_wchan+0x5c/0x88
[   65.613334]  ra : get_wchan+0x42/0x88
[   65.613625] epc : ffffffff800048a4 ra : ffffffff8000488a sp : ffffffd00021bb90
[   65.614008]  gp : ffffffff817709f8 tp : ffffffe07fe91b80 t0 : 00000000000001f8
[   65.614411]  t1 : 0000000000020000 t2 : 0000000000000000 s0 : ffffffd00021bbd0
[   65.614818]  s1 : ffffffd0003bbdf0 a0 : 0000000000000001 a1 : 0000000000000002
[   65.615237]  a2 : ffffffff81618008 a3 : 0000000000000000 a4 : 0000000000000000
[   65.615637]  a5 : ffffffd0003bc000 a6 : 0000000000000002 a7 : ffffffe27d370000
[   65.616022]  s2 : ffffffd0003bbd90 s3 : ffffffff8071a81e s4 : 0000000000003fff
[   65.616407]  s5 : ffffffffffffc000 s6 : 0000000000000000 s7 : ffffffff81618008
[   65.616845]  s8 : 0000000000000001 s9 : 0000000180000040 s10: 0000000000000000
[   65.617248]  s11: 000000000000016b t3 : 000000ff00000000 t4 : 0c6aec92de5e3fd7
[   65.617672]  t5 : fff78f60608fcfff t6 : 0000000000000078
[   65.618088] status: 0000000000000120 badaddr: ffffffd0003bbde8 cause: 000000000000000d
[   65.618621] [<ffffffff800048a4>] get_wchan+0x5c/0x88
[   65.619008] [<ffffffff8022da88>] do_task_stat+0x7a2/0xa46
[   65.619325] [<ffffffff8022e87e>] proc_tgid_stat+0xe/0x16
[   65.619637] [<ffffffff80227dd6>] proc_single_show+0x46/0x96
[   65.619979] [<ffffffff801ccb1e>] seq_read_iter+0x190/0x31e
[   65.620341] [<ffffffff801ccd70>] seq_read+0xc4/0x104
[   65.620633] [<ffffffff801a6bfe>] vfs_read+0x6a/0x112
[   65.620922] [<ffffffff801a701c>] ksys_read+0x54/0xbe
[   65.621206] [<ffffffff801a7094>] sys_read+0xe/0x16
[   65.621474] [<ffffffff8000303e>] ret_from_syscall+0x0/0x2
[   65.622169] ---[ end trace f24856ed2b8789c5 ]---
[   65.622832] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/kernel/stacktrace.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index ff467b98c3e3..ac7593607fa6 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -132,8 +132,12 @@ unsigned long get_wchan(struct task_struct *task)
 {
 	unsigned long pc = 0;
 
-	if (likely(task && task != current && !task_is_running(task)))
+	if (likely(task && task != current && !task_is_running(task))) {
+		if (!try_get_task_stack(task))
+			return 0;
 		walk_stackframe(task, NULL, save_wchan, &pc);
+		put_task_stack(task);
+	}
 	return pc;
 }
 
-- 
2.32.0


