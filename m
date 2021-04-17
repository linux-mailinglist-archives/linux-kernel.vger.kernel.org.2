Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF98362CF0
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 04:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbhDQCgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 22:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbhDQCgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 22:36:16 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2763C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 19:35:49 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id m18so12704698plc.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 19:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WBtF7ShZgOdDfRdkPjIMUaShKz3kOJxiC9/QGP7brzE=;
        b=W0yoxzvP5XGbiyELAXVqcBl+TKvA92hXvOeD+2U4Kv8XBM4ELg70LpCy4QaeAjHU4S
         QJ1JZDVw1G1sybiYw5VwvlgLJ70+YaO9jie1hMG51MQfuJxA7WRrKrW6EVfJlNhrKaOv
         ksqqEQF4Ym5pcssHmP7G0SfblD8zFGyVNQbYhc3x03jyvkMytY6FqDTNaEk4TQMj/c8F
         /lMsnMr7IFiwtik1AaDzGljUe+itg2ftjCelgnnOU5f7mmcyTZXGYSUubI1NFR0cF+Re
         I/kPNzQCZLwxuxhVeCQsFnzd0ODYp9KJrfaMbJBIOFFnz4RKL/HA63n3ebF6p3BvzMUl
         +33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WBtF7ShZgOdDfRdkPjIMUaShKz3kOJxiC9/QGP7brzE=;
        b=iPuWl4fIvHTmSpnwBXeKqqOFJXVLi/LfL84qwcQMdTbHqNUbUD4v3NIgI39bMvfE2Z
         Bm2eBelcWF25Wf2LLr4/Fe0D46C/CemN2NGwRZI1K1bgx48rPvouUbqxe8rw/X2mSjuK
         NeXwi5YfU5F3DC/K/xT0kGn/Y5hOE67qYvxJLkLRtDudeJW2oSWA9kyj0utWrDqfaP0u
         3aJ/vknXdGuE8aWP5nd3uoLyEXpw4wW8HfxnxEzU3FlvnuoyKM9D6IKkbaEcPYNzaP3g
         az0NnsJA6WGs+UzM2gxxzBdAKgrf25RZPht5woNIQ29rHQ9wiCjL23q26JR0jPTX8N7Z
         7aJA==
X-Gm-Message-State: AOAM530gbFWl7S9biXEt8k7HUTvaDTo9KBf3fX/eYl+8mAbiqew4qeCS
        A7CDiAd7nKpvnZT6jemXl00=
X-Google-Smtp-Source: ABdhPJwcKV+tIspk6bhs64F3SfxnyLS+DJsCdMGPbkZ3MCsaeIaNruTQPwxKyHbURrLp1edDZ7uJqA==
X-Received: by 2002:a17:902:7b85:b029:e9:5e4e:e873 with SMTP id w5-20020a1709027b85b02900e95e4ee873mr12439496pll.7.1618626949199;
        Fri, 16 Apr 2021 19:35:49 -0700 (PDT)
Received: from vultr.guest ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id o9sm6562049pfh.217.2021.04.16.19.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 19:35:48 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] riscv: patch: remove lockdep assertion on lock text_mutex
Date:   Sat, 17 Apr 2021 10:35:32 +0800
Message-Id: <20210417023532.354714-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function patch_insn_write() expects that the text_mutex is already
held. There's a case that text_mutex is acquired by ftrace_run_update_code()
under syscall context but then patch_insn_write() will be executed under the
migration kthread context as we involves stop machine. So we should remove
the assertion, or it can cause warning storm in kernel message.

[  104.641978] ------------[ cut here ]------------
[  104.642327] WARNING: CPU: 0 PID: 13 at arch/riscv/kernel/patch.c:63 patch_insn_write+0x166/0x17c
[  104.643587] Modules linked in:
[  104.644691] CPU: 0 PID: 13 Comm: migration/0 Not tainted 5.12.0-rc7-00067-g9cdbf6467424 #102
[  104.644907] Hardware name: riscv-virtio,qemu (DT)
[  104.645068] Stopper: multi_cpu_stop+0x0/0x17e <- 0x0
[  104.645349] epc : patch_insn_write+0x166/0x17c
[  104.645467]  ra : patch_insn_write+0x162/0x17c
[  104.645534] epc : ffffffe0000059c6 ra : ffffffe0000059c2 sp : ffffffe002a33c70
[  104.645580]  gp : ffffffe0019e5518 tp : ffffffe002a232c0 t0 : ffffffe01295e8a8
[  104.645622]  t1 : 0000000000000001 t2 : 0000000000000000 s0 : ffffffe002a33cc0
[  104.645675]  s1 : ffffffe000007f72 a0 : 0000000000000000 a1 : ffffffffffffffff
[  104.645716]  a2 : 0000000000000001 a3 : 0000000000000000 a4 : 0000000000000001
[  104.645757]  a5 : ffffffe0799e45c8 a6 : 00000000000ca097 a7 : 0000000000000000
[  104.645798]  s2 : 0000000000000008 s3 : 0000000000000f72 s4 : ffffffe002a33ce0
[  104.645839]  s5 : 0000000000000f7a s6 : 0000000000000003 s7 : 0000000000000003
[  104.645880]  s8 : 0000000000000004 s9 : 0000000000000002 s10: 0000000000000000
[  104.645920]  s11: 0000000000000002 t3 : 0000000000000001 t4 : ffffffe000c615c8
[  104.645958]  t5 : 0000000000007fff t6 : 0000000000000380
[  104.645998] status: 0000000000000100 badaddr: 0000000000000000 cause: 0000000000000003
[  104.646081] Call Trace:
[  104.646147] [<ffffffe0000059c6>] patch_insn_write+0x166/0x17c
[  104.646280] [<ffffffe0000059ec>] patch_text_nosync+0x10/0x32
[  104.646317] [<ffffffe000007d0c>] ftrace_update_ftrace_func+0x74/0xac
[  104.646352] [<ffffffe0000d338a>] ftrace_modify_all_code+0x9c/0x144
[  104.646387] [<ffffffe0000d3444>] __ftrace_modify_code+0x12/0x1c
[  104.646420] [<ffffffe0000c4c2c>] multi_cpu_stop+0xa8/0x17e
[  104.646451] [<ffffffe0000c4474>] cpu_stopper_thread+0xb2/0x156
[  104.646489] [<ffffffe00003645e>] smpboot_thread_fn+0x102/0x1ea
[  104.646524] [<ffffffe0000311b0>] kthread+0x132/0x148
[  104.646556] [<ffffffe000002e02>] ret_from_exception+0x0/0x14
[  104.646657] ---[ end trace ccf71babb9de4d5b ]---
[  104.647444] ------------[ cut here ]------------

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 arch/riscv/kernel/patch.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index 0b552873a577..6d2ed9c15065 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -49,19 +49,18 @@ static void patch_unmap(int fixmap)
 }
 NOKPROBE_SYMBOL(patch_unmap);
 
+
+/*
+ * Before reaching here, it was expected to lock the text_mutex
+ * already, so we don't need to give another lock here and could
+ * ensure that it was safe between each cores.
+ */
 static int patch_insn_write(void *addr, const void *insn, size_t len)
 {
 	void *waddr = addr;
 	bool across_pages = (((uintptr_t) addr & ~PAGE_MASK) + len) > PAGE_SIZE;
 	int ret;
 
-	/*
-	 * Before reaching here, it was expected to lock the text_mutex
-	 * already, so we don't need to give another lock here and could
-	 * ensure that it was safe between each cores.
-	 */
-	lockdep_assert_held(&text_mutex);
-
 	if (across_pages)
 		patch_map(addr + len, FIX_TEXT_POKE1);
 
-- 
2.27.0

