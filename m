Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D845D3931BE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 17:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236834AbhE0PHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 11:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236762AbhE0PHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 11:07:11 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5DCC061760
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:05:37 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id e8so240536qvp.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+EiR776LGRIVUqs8E6nTUaQXNk2yNVD65j0QM2uVzow=;
        b=OoTpQqa+5r8BlTD7ijih47CrLq8A6B9RbRxoHM1uCuW1Z7lER6etpTCJW6b36pKuoO
         /Ib+oumN81PGrjvwhUucnW8PIIX/xfixSd/82C9Ngo0OghsxdhoPMN9YB8akCg4px1aZ
         XzXeqso3LANa1DVqRQz9crazOLSsLdTmD5xQcuItCBxnRmMyC6R44//8WloWI52+WiPZ
         UYEUxuuFElnKBjvp82oC1mMOpZWb2Z7QJCVc/Q8PHNr52Va/jYqVOiEiP6SEjdDDqhBD
         2jLNo0uWAKW+fjYBYBBF+rnqF8xkm+S4zZh0UrJJEjyMpmAzJzUiWOzMjiANp5dxzvof
         YSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+EiR776LGRIVUqs8E6nTUaQXNk2yNVD65j0QM2uVzow=;
        b=JuAc+o+50UMQOJOOUmMR6sq5DlBl/xTzPGcrlgVNOGhrDL56TScRUozkx9aL9y6oPl
         8T+SrGAAAwZfFv/Raq3OzjmWnCM+8eMoVJl+we4uy5MpngDk8saRXjXVQ8ZR6UmS4fqw
         3VaQRtDTOgduW9n9qbyUKxLKcsLfSWZendBevI6I2D7vdlwnwFHaxrr15xXMsYoL7fnd
         oOz793NHHmrFPHQRxrWwLKDSJzGx/jh8Fycb3S81EdbbOBGbwDwgBtM1Xf7VIOnoiC7h
         a5rvhr9N7YG7PB1so1wsD/epv68HFe/iUg08oQ/i6/xOOkHq8ghRVbP/kxCvglCcMVfy
         2sOw==
X-Gm-Message-State: AOAM530Obz8TnZeTkdwacaP+1U5Lw8XKNLz87E7TbshAQeduaTGSJrkf
        Np0t2wlYXXszX3tMlF36avGeMA==
X-Google-Smtp-Source: ABdhPJzTP3oV1R+n8kGbXURQLbsLJZ4X6S2bcFpIfYYBkRufEHUPnqQYpI7uOymwC/kI/WMb3ZRyIw==
X-Received: by 2002:ad4:4773:: with SMTP id d19mr4316997qvx.0.1622127936544;
        Thu, 27 May 2021 08:05:36 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id x10sm1447468qkh.124.2021.05.27.08.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 08:05:36 -0700 (PDT)
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
Subject: [PATCH 05/18] arm64: trans_pgd: hibernate: Add trans_pgd_copy_el2_vectors
Date:   Thu, 27 May 2021 11:05:13 -0400
Message-Id: <20210527150526.271941-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210527150526.271941-1-pasha.tatashin@soleen.com>
References: <20210527150526.271941-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Users of trans_pgd may also need a copy of vector table because it is
also may be overwritten if a linear map can be overwritten.

Move setup of EL2 vectors from hibernate to trans_pgd, so it can be
later shared with kexec as well.

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/trans_pgd.h |  3 +++
 arch/arm64/include/asm/virt.h      |  3 +++
 arch/arm64/kernel/hibernate.c      | 28 ++++++++++------------------
 arch/arm64/mm/trans_pgd.c          | 20 ++++++++++++++++++++
 4 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/include/asm/trans_pgd.h b/arch/arm64/include/asm/trans_pgd.h
index 5d08e5adf3d5..e0760e52d36d 100644
--- a/arch/arm64/include/asm/trans_pgd.h
+++ b/arch/arm64/include/asm/trans_pgd.h
@@ -36,4 +36,7 @@ int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
 int trans_pgd_idmap_page(struct trans_pgd_info *info, phys_addr_t *trans_ttbr0,
 			 unsigned long *t0sz, void *page);
 
+int trans_pgd_copy_el2_vectors(struct trans_pgd_info *info,
+			       phys_addr_t *el2_vectors);
+
 #endif /* _ASM_TRANS_TABLE_H */
diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index 4216c8623538..bfbb66018114 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -67,6 +67,9 @@
  */
 extern u32 __boot_cpu_mode[2];
 
+extern char __hyp_stub_vectors[];
+#define ARM64_VECTOR_TABLE_LEN	SZ_2K
+
 void __hyp_set_vectors(phys_addr_t phys_vector_base);
 void __hyp_reset_vectors(void);
 
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index c764574a1acb..0b8bad8bb6eb 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -48,12 +48,6 @@
  */
 extern int in_suspend;
 
-/* temporary el2 vectors in the __hibernate_exit_text section. */
-extern char hibernate_el2_vectors[];
-
-/* hyp-stub vectors, used to restore el2 during resume from hibernate. */
-extern char __hyp_stub_vectors[];
-
 /*
  * The logical cpu number we should resume on, initialised to a non-cpu
  * number.
@@ -428,6 +422,7 @@ int swsusp_arch_resume(void)
 	void *zero_page;
 	size_t exit_size;
 	pgd_t *tmp_pg_dir;
+	phys_addr_t el2_vectors;
 	void __noreturn (*hibernate_exit)(phys_addr_t, phys_addr_t, void *,
 					  void *, phys_addr_t, phys_addr_t);
 	struct trans_pgd_info trans_info = {
@@ -455,6 +450,14 @@ int swsusp_arch_resume(void)
 		return -ENOMEM;
 	}
 
+	if (is_hyp_callable()) {
+		rc = trans_pgd_copy_el2_vectors(&trans_info, &el2_vectors);
+		if (rc) {
+			pr_err("Failed to setup el2 vectors\n");
+			return rc;
+		}
+	}
+
 	exit_size = __hibernate_exit_text_end - __hibernate_exit_text_start;
 	/*
 	 * Copy swsusp_arch_suspend_exit() to a safe page. This will generate
@@ -467,25 +470,14 @@ int swsusp_arch_resume(void)
 		return rc;
 	}
 
-	/*
-	 * The hibernate exit text contains a set of el2 vectors, that will
-	 * be executed at el2 with the mmu off in order to reload hyp-stub.
-	 */
-	__flush_dcache_area(hibernate_exit, exit_size);
-
 	/*
 	 * KASLR will cause the el2 vectors to be in a different location in
 	 * the resumed kernel. Load hibernate's temporary copy into el2.
 	 *
 	 * We can skip this step if we booted at EL1, or are running with VHE.
 	 */
-	if (is_hyp_callable()) {
-		phys_addr_t el2_vectors = (phys_addr_t)hibernate_exit;
-		el2_vectors += hibernate_el2_vectors -
-			       __hibernate_exit_text_start;     /* offset */
-
+	if (is_hyp_callable())
 		__hyp_set_vectors(el2_vectors);
-	}
 
 	hibernate_exit(virt_to_phys(tmp_pg_dir), resume_hdr.ttbr1_el1,
 		       resume_hdr.reenter_kernel, restore_pblist,
diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
index 527f0a39c3da..61549451ed3a 100644
--- a/arch/arm64/mm/trans_pgd.c
+++ b/arch/arm64/mm/trans_pgd.c
@@ -322,3 +322,23 @@ int trans_pgd_idmap_page(struct trans_pgd_info *info, phys_addr_t *trans_ttbr0,
 
 	return 0;
 }
+
+/*
+ * Create a copy of the vector table so we can call HVC_SET_VECTORS or
+ * HVC_SOFT_RESTART from contexts where the table may be overwritten.
+ */
+int trans_pgd_copy_el2_vectors(struct trans_pgd_info *info,
+			       phys_addr_t *el2_vectors)
+{
+	void *hyp_stub = trans_alloc(info);
+
+	if (!hyp_stub)
+		return -ENOMEM;
+	*el2_vectors = virt_to_phys(hyp_stub);
+	memcpy(hyp_stub, &__hyp_stub_vectors, ARM64_VECTOR_TABLE_LEN);
+	__flush_icache_range((unsigned long)hyp_stub,
+			     (unsigned long)hyp_stub + ARM64_VECTOR_TABLE_LEN);
+	__flush_dcache_area(hyp_stub, ARM64_VECTOR_TABLE_LEN);
+
+	return 0;
+}
-- 
2.25.1

