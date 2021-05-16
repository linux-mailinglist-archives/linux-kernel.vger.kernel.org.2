Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C87B381EFB
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 15:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbhEPNG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 09:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhEPNG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 09:06:27 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7310C061573
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 06:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Subject:
        Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=9XSWgvtGgHdvv9Bbyxs7s1XV1bpHtBG/T4fhJlW4Qv8=; b=RuVSp13QeD5l6
        CTo0p/2zptFllZH4Vpzp1xS8ZSomDQO/9f8nReNr5SQNl0puyCDQJoSaArGr21ui
        rD/XbdRjoTUogL/YYZoS2iKF7FsAow1RnMEnCWduJZgmV2tFEfrbQKvTPJrjtkSq
        8qYzOh1dXYwVnBapXxIcLUM4qu1IaI=
Received: from xhacker (unknown [101.86.20.15])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygBnbzd7GKFgmcroAA--.17615S2;
        Sun, 16 May 2021 21:04:59 +0800 (CST)
Date:   Sun, 16 May 2021 20:59:42 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: Add __init section marker to some functions again
Message-ID: <20210516205942.4671f4e6@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygBnbzd7GKFgmcroAA--.17615S2
X-Coremail-Antispam: 1UD129KBjvJXoW7GFyDJF4kJFWfJry5XFWkZwb_yoW8Jr4Dpr
        W0kr4F9rWY9Fn7Ca42yrykuFy5J3ZYg3W3Kr1UCas5JFsxJ3yqv3Z5Za4UZr1qqFykuF9Y
        kry5Cry2vw18A37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUy2b7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E
        4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
        WUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
        Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rV
        WrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_
        Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jY6wZUUUUU=
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <jszhang@kernel.org>

These functions are not needed after booting, so mark them as __init
to move them to the __init section.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/kernel/cpufeature.c | 2 +-
 arch/riscv/mm/context.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index a2848dc36927..d959d207a40d 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -59,7 +59,7 @@ bool __riscv_isa_extension_available(const unsigned long *isa_bitmap, int bit)
 }
 EXPORT_SYMBOL_GPL(__riscv_isa_extension_available);
 
-void riscv_fill_hwcap(void)
+void __init riscv_fill_hwcap(void)
 {
 	struct device_node *node;
 	const char *isa;
diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 6d445f2888ec..63dc0b9bd8aa 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -213,7 +213,7 @@ static inline void set_mm(struct mm_struct *mm, unsigned int cpu)
 		set_mm_noasid(mm);
 }
 
-static int asids_init(void)
+static int __init asids_init(void)
 {
 	unsigned long old;
 
-- 
2.31.0


