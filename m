Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5BB1376705
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 16:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237647AbhEGO1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 10:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235948AbhEGO07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 10:26:59 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 87221C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 07:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=M9VvS8e9uZJKj3MO0SwqDdKf35V5JGIaFIP2nALz/jg=; b=H38Gs9Zw3OgBa
        Li1eGnNy9a5Rsg+JMnP7ee052GW4mWrLV3JNxl9ojDTewrNw79RntahEIc5U+zi6
        UWLiEcdEZJWMYwHbiC4qy/Mhf2HEt6vlii14tItnKbReQ/w+X+H+cceFSPvGVuMV
        clIu5ZRjQasWBLRxLi8WUa6KMAQBbs=
Received: from xhacker (unknown [101.86.20.15])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygDHzprLTZVgPsubAA--.61735S2;
        Fri, 07 May 2021 22:25:15 +0800 (CST)
Date:   Fri, 7 May 2021 22:19:59 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: mm: Remove setup_zero_page()
Message-ID: <20210507221959.2db29936@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygDHzprLTZVgPsubAA--.61735S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar1rCr4Utr1kAr17JrW7CFg_yoW8GF1xpr
        WrGa48urW3Jrs7GFZ2yryqvr18JFn3K34SqryUCwn8Za17Zrn2qr95Kw1rZryqkr4ruayF
        ka4xJ34S93WUAa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyFb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E
        4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
        WUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
        Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rV
        WrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_
        GrUvcSsGvfC2KfnxnUUI43ZEXa7IU5PpnJUUUUU==
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The empty_zero_page sits at .bss..page_aligned section, so will be
cleared to zero during clearing bss, we don't need to clear it again.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Anup Patel <anup@brainfault.org>
---

Hi Palmer,

This patch was one of v3 series of "riscv: improve self-protection"
and acked by Anup. I checked Linus tree this tonight, it seems the v2 or
v1 was merged, this patch is missing, so I rebased and sent out this patch.
If it's late for linux-5.13, then I can rebase again once linux-5.13-rc1
is released.

Thanks in advance

 arch/riscv/mm/init.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index dfb5e4f7a670..4a68b029e3d2 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -67,11 +67,6 @@ static void __init zone_sizes_init(void)
 	free_area_init(max_zone_pfns);
 }
 
-static void __init setup_zero_page(void)
-{
-	memset((void *)empty_zero_page, 0, PAGE_SIZE);
-}
-
 #if defined(CONFIG_MMU) && defined(CONFIG_DEBUG_VM)
 static inline void print_mlk(char *name, unsigned long b, unsigned long t)
 {
@@ -862,7 +857,6 @@ RESERVEDMEM_OF_DECLARE(elfcorehdr, "linux,elfcorehdr", elfcore_hdr_setup);
 void __init paging_init(void)
 {
 	setup_vm_final();
-	setup_zero_page();
 }
 
 void __init misc_mem_init(void)
-- 
2.31.0


