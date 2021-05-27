Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E25D3931C1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 17:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236854AbhE0PHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 11:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236766AbhE0PHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 11:07:12 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5ECC061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:05:39 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id 82so920050qki.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uRcNIBXOyaSrsQwthVpy1hwauBBMN7Vivxx0utjD54U=;
        b=baw560aO1zilTRnsPH5ODSQM+umpDLJom0wWm7jrdVnxroTvnRw1ujP0UhZKxl4h16
         N38nZKepAcYoE0UAEpaMfhWdP2zvyq4n22H9pFgq0X6dglCZZhNLhxbZjmXHThU2ZZJd
         FBIZs0K2hc/GsDRn7wCKSuSUDkhiWtOHZ6MQT3KjWhvmW/VAXRRm2CmpHf13D+JUuP5U
         jngl4FpHRuskS3sFTcK/T1B7mB3OYSga5Z7occBeWpVtPNsXbCtuGJExnBIOgMY8UZJJ
         adKCXSP8eR+kApqLmL1Xc5egVdLNQ8x4y3pH9ptqd38tuCXkVllnx9kYOl5J496pyK3b
         lgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uRcNIBXOyaSrsQwthVpy1hwauBBMN7Vivxx0utjD54U=;
        b=BS8BXeK0jQLyiwkQpxAM3gFf/7jfQ3SwXUgn/HdLaQ6TNdCoMy6bCD/LvnUvdrjhZ7
         5KwAau8JESh1zqExRKX8SqxIeRqaJHig697XJyl6rfnHtU+TvPxSN9vxfCUI5Jkyq4hq
         4Uh19QcSqbBEWtGo9jDzVY0dj1k+Va2uSUXYDXIbop5EF+g2tldB3LMKkB86NAyjQLj+
         uJ1v7z2lt7Khl6sFigqXhYV9Jk9NoMRhxMgvd/YgqLiFjoPtKtUWF6y9fBVUocnH1V30
         WYpZCb+9QG6ht1BKeFxg+ArGDVDbtfBN7giBX6OTmLXkLT/4Vw1pWqDo63YxAKbQGZzm
         7rgA==
X-Gm-Message-State: AOAM533uo0j5Sk3nc1RzQpwij/qP7pDB848ymjnMINdevh2DlW+MyCzO
        Oo69OLjlrzddXuQ7XvcuQ5hGfQ==
X-Google-Smtp-Source: ABdhPJxMXmwEgisa5gA4j+w8k9Kb9fYN4u/mCq3bmdSU3qA/vvzD6gnPAIKYpynHFW3vyiVzDRiyAQ==
X-Received: by 2002:a05:620a:1126:: with SMTP id p6mr4086588qkk.120.1622127938229;
        Thu, 27 May 2021 08:05:38 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id x10sm1447468qkh.124.2021.05.27.08.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 08:05:37 -0700 (PDT)
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
Subject: [PATCH 06/18] arm64: hibernate: abstract ttrb0 setup function
Date:   Thu, 27 May 2021 11:05:14 -0400
Message-Id: <20210527150526.271941-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210527150526.271941-1-pasha.tatashin@soleen.com>
References: <20210527150526.271941-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, only hibernate sets custom ttbr0 with safe idmaped function.
Kexec, is also going to be using this functinality when relocation code
is going to be idmapped.

Move the setup seqeuence to a dedicated cpu_install_ttbr0() for custom
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
index 0b8bad8bb6eb..ded5115bcb63 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -206,26 +206,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
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

