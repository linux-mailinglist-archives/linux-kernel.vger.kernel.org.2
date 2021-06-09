Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDDB3A0891
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 02:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbhFIArf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 20:47:35 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]:45845 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbhFIArd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 20:47:33 -0400
Received: by mail-qk1-f178.google.com with SMTP id d196so17025806qkg.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 17:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=h7/0+77ndabR+mxgeXAoHMyf1o3rde7WHj0V90p1QaI=;
        b=IVvfQXHZK2mgQNL2VKhZdBH2cFdFVnvi67WIksJs+EJTPZ80DCLgf6x7V0AY/DP9n5
         KPgwdo1s2mo3JDGJ5fuatqamvtcwaG4T8fEJK/Bw5QsiOjn1lOzxUTZKZAxJNUd24r8e
         A/aqF+NmNP+nGi30Dk5FMvJrh3Wz9//HGGRNayhIhz52mo5L9fGeviQ6LlXK55xH/WgF
         sUM6DamMUuZvFX8BQzFtBwq9U07uUGNbw1p4n9xg0w6r3BeQihTedZ0KERAwA+nav6oV
         +7aiaCkIUJGK6A8RasaLwtoBEykds2pKFqqfqW1vv0VeIfpvk+epR+C56PAYWG+NdO61
         laPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h7/0+77ndabR+mxgeXAoHMyf1o3rde7WHj0V90p1QaI=;
        b=gmUHKpTyz7WCMdHZ81P87qk1RdBCsSzr34CU+U01PfiYC0BLBM4VqIPa7qB8PgPD5s
         3GJA72ztYDfAxaJ5WqW4Tqbt3JiliuWF0FU8SilEZhkDJu3JIDMcsrByNdWNLoaL9oov
         RYISs5Nog54JaBtzuzk4q+E5oob8M7Tp3VxOG5nc98UoH1JzbSmn04ZIGs/4u9o4kB51
         jEj8m/me4Wrde9TPem/2u0sVmT/03Ar5ZGAss+voTfFiNaBSW1VAMEhwyaLqtmPosn/a
         Heu0i+lVXRcQNglo4lXnX8YezvkU5kVYbvSfOmWDJOFCKMbf9TTT6YfpPcp+cUcpx55h
         wZMw==
X-Gm-Message-State: AOAM532zrhkDyOjtTURwRizCMyEKPY5ZHWdGtZW6d+f9w+W1650sU7UM
        uBHLkyW9qI1Cjb5b5E8L4lSrZw==
X-Google-Smtp-Source: ABdhPJziHWaxeJQaB1odr8nTuQIw3SApIPPJKWycUP6hFCST1MTMEPuGtiIWcoxNijhifWrDO7tqkg==
X-Received: by 2002:ae9:ed91:: with SMTP id c139mr1724055qkg.454.1623199466063;
        Tue, 08 Jun 2021 17:44:26 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id n194sm12869011qka.66.2021.06.08.17.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 17:44:25 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com, tyhicks@linux.microsoft.com,
        kernelfans@gmail.com, akpm@linux-foundation.org,
        madvenka@linux.microsoft.com
Subject: [PATCH v15 03/15] arm64: hibernate: abstract ttrb0 setup function
Date:   Tue,  8 Jun 2021 20:44:07 -0400
Message-Id: <20210609004419.936873-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210609004419.936873-1-pasha.tatashin@soleen.com>
References: <20210609004419.936873-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, only hibernate sets custom ttbr0 with safe idmaped function.
Kexec, is also going to be using this functionality when relocation code
is going to be idmapped.

Move the setup sequence to a dedicated cpu_install_ttbr0() for custom
ttbr0.

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/mmu_context.h | 24 ++++++++++++++++++++++++
 arch/arm64/kernel/hibernate.c        | 21 +--------------------
 2 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index d3cef9133539..85eb92a2ffcb 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -115,6 +115,30 @@ static inline void cpu_install_idmap(void)
 	cpu_switch_mm(lm_alias(idmap_pg_dir), &init_mm);
 }
 
+/*
+ * Load our new page tables. A strict BBM approach requires that we ensure that
+ * TLBs are free of any entries that may overlap with the global mappings we are
+ * about to install.
+ *
+ * For a real hibernate/resume/kexec cycle TTBR0 currently points to a zero
+ * page, but TLBs may contain stale ASID-tagged entries (e.g. for EFI runtime
+ * services), while for a userspace-driven test_resume cycle it points to
+ * userspace page tables (and we must point it at a zero page ourselves).
+ *
+ * We change T0SZ as part of installing the idmap. This is undone by
+ * cpu_uninstall_idmap() in __cpu_suspend_exit().
+ */
+static inline void cpu_install_ttbr0(phys_addr_t ttbr0, unsigned long t0sz)
+{
+	cpu_set_reserved_ttbr0();
+	local_flush_tlb_all();
+	__cpu_set_tcr_t0sz(t0sz);
+
+	/* avoid cpu_switch_mm() and its SW-PAN and CNP interactions */
+	write_sysreg(ttbr0, ttbr0_el1);
+	isb();
+}
+
 /*
  * Atomically replaces the active TTBR1_EL1 PGD with a new VA-compatible PGD,
  * avoiding the possibility of conflicting TLB entries being allocated.
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index fa2d1cb844a7..39f0da125876 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -212,26 +212,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	if (rc)
 		return rc;
 
-	/*
-	 * Load our new page tables. A strict BBM approach requires that we
-	 * ensure that TLBs are free of any entries that may overlap with the
-	 * global mappings we are about to install.
-	 *
-	 * For a real hibernate/resume cycle TTBR0 currently points to a zero
-	 * page, but TLBs may contain stale ASID-tagged entries (e.g. for EFI
-	 * runtime services), while for a userspace-driven test_resume cycle it
-	 * points to userspace page tables (and we must point it at a zero page
-	 * ourselves).
-	 *
-	 * We change T0SZ as part of installing the idmap. This is undone by
-	 * cpu_uninstall_idmap() in __cpu_suspend_exit().
-	 */
-	cpu_set_reserved_ttbr0();
-	local_flush_tlb_all();
-	__cpu_set_tcr_t0sz(t0sz);
-	write_sysreg(trans_ttbr0, ttbr0_el1);
-	isb();
-
+	cpu_install_ttbr0(trans_ttbr0, t0sz);
 	*phys_dst_addr = virt_to_phys(page);
 
 	return 0;
-- 
2.25.1

