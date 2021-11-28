Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E79B460767
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 17:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358299AbhK1QUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 11:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358152AbhK1QSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 11:18:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4F8C061746
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 08:14:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE8E660FEF
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 16:14:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C4CC53FC7;
        Sun, 28 Nov 2021 16:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638116097;
        bh=EISRwtT6a67IdIj4/hZElSg1YibLzkj4w6ZbgU3blVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vAH6L/KcOcN75/rLs5688vzmsPhitHpT1faPJuZHuLUaMMsET3nyJ3SkpAPdGfKHv
         kn20n3RwRwsYxfE4VsMrnx9x47uNGpkgXIdUhkN2DgIFyI/ukTU/4/ZQHqCx8JpC8M
         hTpM1BdAKeYzq3gISSD2PizLejukCS/lq8QPBaPbwb9G72IxaxYFD3dZSQ+8MBW5ZS
         1dmZugcsTLXaNULjnqNSbMiAAlURg3MPsGjmymcXj6K+TsN0U42iI9aL5QAQ7FIMss
         QJ90YepRR704ZLiSq+XYWZv242Rbsxv0qHmBkwaZs9MEChRevZkBgPBiT3z2h/IC9c
         RxIm4ZJMBNGrw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atishp@atishpatra.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm-riscv@lists.infradead.org
Subject: [PATCH 1/5] riscv: remove cpu_stop()
Date:   Mon, 29 Nov 2021 00:07:37 +0800
Message-Id: <20211128160741.2122-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211128160741.2122-1-jszhang@kernel.org>
References: <20211128160741.2122-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Except arch_cpu_idle_dead(), no users of this function. So remove
cpu_stop() and fold its code into arch_cpu_idle_dead().

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/include/asm/smp.h    | 2 --
 arch/riscv/kernel/cpu-hotplug.c | 8 +-------
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index a7d2811f3536..e2b0d6c40a6c 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -63,8 +63,6 @@ asmlinkage void smp_callin(void);
 #if defined CONFIG_HOTPLUG_CPU
 int __cpu_disable(void);
 void __cpu_die(unsigned int cpu);
-void cpu_stop(void);
-#else
 #endif /* CONFIG_HOTPLUG_CPU */
 
 #else
diff --git a/arch/riscv/kernel/cpu-hotplug.c b/arch/riscv/kernel/cpu-hotplug.c
index df84e0c13db1..be7f05b542bb 100644
--- a/arch/riscv/kernel/cpu-hotplug.c
+++ b/arch/riscv/kernel/cpu-hotplug.c
@@ -14,12 +14,6 @@
 #include <asm/cpu_ops.h>
 #include <asm/sbi.h>
 
-void cpu_stop(void);
-void arch_cpu_idle_dead(void)
-{
-	cpu_stop();
-}
-
 bool cpu_has_hotplug(unsigned int cpu)
 {
 	if (cpu_ops[cpu]->cpu_stop)
@@ -75,7 +69,7 @@ void __cpu_die(unsigned int cpu)
 /*
  * Called from the idle thread for the CPU which has been shutdown.
  */
-void cpu_stop(void)
+void arch_cpu_idle_dead(void)
 {
 	idle_task_exit();
 
-- 
2.34.0

