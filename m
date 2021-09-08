Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5633403E8F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 19:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352521AbhIHRr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 13:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352654AbhIHRr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 13:47:26 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AD9C0612AD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 10:46:06 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id ot2-20020a17090b3b4200b0019127f8ed87so1673677pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 10:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=aaBn2iXv53pXLMpiXjb2tRcWKw3T+uDqL/GiUgDTj90=;
        b=D8NMx+XLy53uY1MXIUeXls4zKXDMKxbddVBrQJWu3xrIJ5jdxzR0mgoJ63iKhkMsqr
         aOLKAnoQmfPZsOTxtij8B1CZU4ToG4ZYG3YhJXVxCQE2a4DPBMa9S3X0PE2hgKtTmrPI
         fiqyr0h3bmAVFPhWjTmTKz8CZcLQHyg/s6CCPOEmC41NdjcIueK6M/tjaylhwR62S+Td
         DvQblqoqk4gLxnngThLTQfx6AaEq6w5q+kgz0A2j19xcfGc3SB94mReerWW8VCrvZZg8
         cJSN8f1JZWPt7xDbBwggAO4P7dgbUeTxNGeRtZEyLS/TVIwPIlCz2uYfysPefrQsglQ/
         m4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aaBn2iXv53pXLMpiXjb2tRcWKw3T+uDqL/GiUgDTj90=;
        b=C2xDvc/FS11+wgagcqg7rmseqaBnL8/I+sgDHakPlRikPyMfBAd56v71Ey0ctI5uGx
         q8x8i+KlIyhUHmxQ8YApcc43PFrgPCBjTtXkUXCdhY0b0MUgDByTirIqOHMeg5iPIq4g
         pwP+MjH72ibm4Po9y9iLLOo8GzZhIPU/BkuuLe3lhprIXjfXC+ECFQfKe0BbJo4jcynh
         iu7IDL5FVNRRhPxEtcJInWgM3DvULlNgBZvnO9JtJRT+lkG0HGm6hNrUDSK+Sjym1cEq
         NDscNXuuPz3hi9ODHawajeJ+plVmSkbjzWLmFki5XcmC1EM19MH9LNjaIu+DEXEvpoDF
         Rx2Q==
X-Gm-Message-State: AOAM530ESJ70xIb21vXn9pbfCXwstIjjpsM02XwvQHB93DR+XCX6c/0x
        AnihgebwoUpg1+QU2R6VY43v1Q==
X-Google-Smtp-Source: ABdhPJzjfhCk2uyKvxy2K4fTatUNYsz+fdJinoh+ch/Q3oNcaLUf6O7ySpbJTJicDZgHah1nC/wrjQ==
X-Received: by 2002:a17:90a:460e:: with SMTP id w14mr5457656pjg.0.1631123165618;
        Wed, 08 Sep 2021 10:46:05 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id b5sm3108466pfr.26.2021.09.08.10.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 10:46:05 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com, vincent.chen@sifive.com
Subject: [RFC PATCH v8 19/21] riscv: Allocate space for vector registers in start_thread()
Date:   Thu,  9 Sep 2021 01:45:31 +0800
Message-Id: <5d99eab37a683d21e0cec75bfcec96ad8b480d02.1631121222.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631121222.git.greentime.hu@sifive.com>
References: <cover.1631121222.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It allocates memory space for vector registers in start_thread() instead of
allocating in vstate_restore() in this patch. We can allocate memory here
so that it will be more readable.

Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/include/asm/switch_to.h |  7 +------
 arch/riscv/kernel/process.c        | 15 +++++++++++++--
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index de0573dad78f..b48c9c974564 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -103,12 +103,6 @@ static inline void vstate_restore(struct task_struct *task,
 {
 	if ((regs->status & SR_VS) != SR_VS_OFF) {
 		struct __riscv_v_state *vstate = &(task->thread.vstate);
-
-		/* Allocate space for vector registers. */
-		if (!vstate->datap) {
-			vstate->datap = kzalloc(riscv_vsize, GFP_ATOMIC);
-			vstate->size = riscv_vsize;
-		}
 		__vstate_restore(vstate, vstate->datap);
 		__vstate_clean(regs);
 	}
@@ -127,6 +121,7 @@ static inline void __switch_to_vector(struct task_struct *prev,
 
 #else
 #define has_vector false
+#define riscv_vsize (0)
 #define vstate_save(task, regs) do { } while (0)
 #define vstate_restore(task, regs) do { } while (0)
 #define __switch_to_vector(__prev, __next) do { } while (0)
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 0b86e9e531c9..05ff5f934e7e 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -97,7 +97,16 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
 	}
 
 	if (has_vector) {
+		struct __riscv_v_state *vstate = &(current->thread.vstate);
+
+		/* Enable vector and allocate memory for vector registers. */
+		if (!vstate->datap) {
+			vstate->datap = kzalloc(riscv_vsize, GFP_KERNEL);
+			if (WARN_ON(!vstate->datap))
+				return;
+		}
 		regs->status |= SR_VS_INITIAL;
+
 		/*
 		 * Restore the initial value to the vector register
 		 * before starting the user program.
@@ -121,9 +130,11 @@ void flush_thread(void)
 	memset(&current->thread.fstate, 0, sizeof(current->thread.fstate));
 #endif
 #ifdef CONFIG_VECTOR
-	/* Reset vector state */
+	/* Reset vector state and keep datap pointer. */
 	vstate_off(current, task_pt_regs(current));
-	memset(&current->thread.vstate, 0, sizeof(current->thread.vstate));
+	memset(&current->thread.vstate, 0, RISCV_V_STATE_DATAP);
+	if (current->thread.vstate.datap)
+		memset(current->thread.vstate.datap, 0, riscv_vsize);
 #endif
 }
 
-- 
2.31.1

