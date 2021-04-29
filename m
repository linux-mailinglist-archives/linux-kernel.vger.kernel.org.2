Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB8836E4C5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 08:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238661AbhD2GVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 02:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhD2GVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 02:21:10 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75A2C06138C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 23:20:23 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id s20so18352922plr.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 23:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=8b3IKfTAHchSA8Kg2o6JAtVdRWR5diw6ByIr64wbCtY=;
        b=X6TFxKy4+tEl+6wwelMT/v40t6YoPtLIxqUx1PRDUVD94h6teFZOSZMc2Zn8NP5MaL
         fAkNmgtmpdY9gErwaJPtLHrDi/YRDp2sLphzska9oAx64jaZnrqcSJS8vizSqa197OhS
         gHmGkOxFw6labMnPsxyBG7oiQONVuS+8xOTpUOtctDdKTC5AGM3HXtHlOq75E0ZyKbAo
         AsdtxquJ23wdGOrs81Lh7EleIjn+CiVUZ2QekUWzrfh9p3JCuRYIMex5+wiz33ives5D
         nVVz9yJreqa06B9be9PAxRP3EVsCqpMPbL01gdDANW+06qXrjvJA1maLpyIODJyIJZ12
         DBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=8b3IKfTAHchSA8Kg2o6JAtVdRWR5diw6ByIr64wbCtY=;
        b=GphGjfAwyuFQfh/ZM3CutxZCxQ8k/rxZJq3yHvMUE7mSIM9/74wjEs/4HmZsXBk/za
         J+L7HXLf2TPaSyXZOOT9D57s7BuF16xZYFoYFjLFj9blD4Mys+IvgQPta0wLB82INSu0
         R1fML6zqhzz+UdSb33czuwhFD2UIFOSDNgwf2vTfaIWii+52JZRfH75VXcNWVkGMy06P
         ZucrVaQsv+T/IteE8s6Em7K/LmTSOkLAq5eeBKXSZKJFx9l5hSS9RHDugRoI1A+FufJj
         3d6yPZLzN2GONO3o6gLjckwx7oeEme7KGWj2rZAwYkXG365RvtBLfDq+VcX78I9aLHIb
         NkVw==
X-Gm-Message-State: AOAM530EWA5JV7rdxrF74HoKqiGzMxz4dBT2w1T5CVM7p1ozpKfx4ss6
        0w/6WYB4F/wWNqd0dpvBDPdLEw==
X-Google-Smtp-Source: ABdhPJwH27db/OIQrKWCFQjxIUzJnwXLZ4eKMAYxpE6kf50hIv9EHWkL4Sobf+Fd4sBbitfoWmIjAQ==
X-Received: by 2002:a17:90a:cf10:: with SMTP id h16mr10477666pju.49.1619677222725;
        Wed, 28 Apr 2021 23:20:22 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id ga1sm1288336pjb.5.2021.04.28.23.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 23:20:22 -0700 (PDT)
Subject: [PATCH] RISC-V: insn: Use a raw spinlock to protect TEXT_POKE*
Date:   Wed, 28 Apr 2021 23:17:13 -0700
Message-Id: <20210429061713.783628-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        peterz@infradead.org, jpoimboe@redhat.com, jbaron@akamai.com,
        rostedt@goodmis.org, ardb@kernel.org,
        Atish Patra <Atish.Patra@wdc.com>,
        Anup Patel <Anup.Patel@wdc.com>, akpm@linux-foundation.org,
        rppt@kernel.org, mhiramat@kernel.org, zong.li@sifive.com,
        guoren@linux.alibaba.com, wangkefeng.wang@huawei.com,
        0x7f454c46@gmail.com, chenhuang5@huawei.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Palmer Dabbelt <palmerdabbelt@google.com>,
        Changbin Du <changbin.du@gmail.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:         linux-riscv@lists.infradead.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

We currently use text_mutex to protect the fixmap sections from
concurrent callers.  This is convienent for kprobes as the generic code
already holds text_mutex, but ftrace doesn't which triggers a lockdep
assertion.  We could take text_mutex for ftrace, but the jump label
implementation (which is currently taking text_mutex) isn't explicitly
listed as being sleepable and it's called from enough places it seems
safer to just avoid sleeping.

arm64 and parisc, the other two TEXT_POKE-style patching
implemnetations, already use raw spinlocks.  abffa6f3b157 ("arm64:
convert patch_lock to raw lock") lays out the case for a raw spinlock as
opposed to a regular spinlock, and while I don't know of anyone using rt
on RISC-V I'm sure it'll eventually show up and I don't see any reason
to wait.

Fixes: ebc00dde8a97 ("riscv: Add jump-label implementation")
Reported-by: Changbin Du <changbin.du@gmail.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/include/asm/fixmap.h |  3 +++
 arch/riscv/kernel/jump_label.c  |  2 --
 arch/riscv/kernel/patch.c       | 13 +++++++++----
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
index 54cbf07fb4e9..d1c0a1f123cf 100644
--- a/arch/riscv/include/asm/fixmap.h
+++ b/arch/riscv/include/asm/fixmap.h
@@ -24,8 +24,11 @@ enum fixed_addresses {
 	FIX_HOLE,
 	FIX_PTE,
 	FIX_PMD,
+
+	/* Only used in kernel/insn.c */
 	FIX_TEXT_POKE1,
 	FIX_TEXT_POKE0,
+
 	FIX_EARLYCON_MEM_BASE,
 
 	__end_of_permanent_fixed_addresses,
diff --git a/arch/riscv/kernel/jump_label.c b/arch/riscv/kernel/jump_label.c
index 20e09056d141..45bb32f91b5c 100644
--- a/arch/riscv/kernel/jump_label.c
+++ b/arch/riscv/kernel/jump_label.c
@@ -35,9 +35,7 @@ void arch_jump_label_transform(struct jump_entry *entry,
 		insn = RISCV_INSN_NOP;
 	}
 
-	mutex_lock(&text_mutex);
 	patch_text_nosync(addr, &insn, sizeof(insn));
-	mutex_unlock(&text_mutex);
 }
 
 void arch_jump_label_transform_static(struct jump_entry *entry,
diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index 0b552873a577..dfa7ee8eb63f 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -19,6 +19,8 @@ struct patch_insn {
 	atomic_t cpu_count;
 };
 
+static DEFINE_RAW_SPINLOCK(patch_lock);
+
 #ifdef CONFIG_MMU
 /*
  * The fix_to_virt(, idx) needs a const value (not a dynamic variable of
@@ -54,13 +56,14 @@ static int patch_insn_write(void *addr, const void *insn, size_t len)
 	void *waddr = addr;
 	bool across_pages = (((uintptr_t) addr & ~PAGE_MASK) + len) > PAGE_SIZE;
 	int ret;
+	unsigned long flags = 0;
 
 	/*
-	 * Before reaching here, it was expected to lock the text_mutex
-	 * already, so we don't need to give another lock here and could
-	 * ensure that it was safe between each cores.
+	 * FIX_TEXT_POKE{0,1} are only used for text patching, but we must
+	 * ensure that concurrent callers do not re-map these before we're done
+	 * with them.
 	 */
-	lockdep_assert_held(&text_mutex);
+	raw_spin_lock_irqsave(&patch_lock, flags);
 
 	if (across_pages)
 		patch_map(addr + len, FIX_TEXT_POKE1);
@@ -74,6 +77,8 @@ static int patch_insn_write(void *addr, const void *insn, size_t len)
 	if (across_pages)
 		patch_unmap(FIX_TEXT_POKE1);
 
+	raw_spin_unlock_irqrestore(&patch_lock, flags);
+
 	return ret;
 }
 NOKPROBE_SYMBOL(patch_insn_write);
-- 
2.31.1.498.g6c1eba8ee3d-goog

