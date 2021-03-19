Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB6734196A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhCSKDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbhCSKDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:03:09 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06796C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:03:09 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id f9so12711843wml.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AA7WNBlUpAMSn2MPgzLs0H4xGSlUKHXKOJZW0a7DVr8=;
        b=g6COKlYT+eckZdu5xAOckwGpUXKA9H6Qgud4TFedl+pq2YS9z0gDuP+KNGqmM+ZTED
         ht7R/jAxdq01sOoYtLegobcdL/BF4TLsBHewEY7qhv3/Ob2uLkuy/dFaqNWUtUxXPDW4
         Ik8ybK59zS1JZ/59bk91tr0PVu6Ab6kfoJ9TkSQ9a+LACl8aC1AXyL8bGVFi6TgxbhvP
         Re24YoLaRJt6Z1lunO6V0LZdNPjWpeRaLzn5ITQasNnPF5QzgNYAZYgsDY7EuS8jZmxz
         bjZ/pEV0OsrP0ehBWaOvArfR/BzilI9l9ZLsphurimgP4WEXDXAcfiqpC02XwUt1Ky9O
         KPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AA7WNBlUpAMSn2MPgzLs0H4xGSlUKHXKOJZW0a7DVr8=;
        b=o+sY6gwY9XQHzvGhLdA7ZP5kfbSXZMe2pi6AzH4IgW7cwmAABSt5Sz+3fti1WXs7jt
         RZXw8zLoh4H6WfBpfqU6SEcyVXcgSDVyRaOVFqdUzEzwXRM6VRBKgQP14EDBYdYaltIV
         pPhmalW0sjaq7j075lhEBJ28hiGLp/ZJ8lWbnHMRzs+/OvXzi+xalTKG7mdV9+g+6oqn
         1ZXnEE7Jsq1EAjp3YT1YKdCa6A1T1iwzEu+QVJa3dhvMICkA51CNoRrOigfzZf/u/jZD
         Sqyh6XLyCTlc47Tpu6fuXsYTmRbUkLsAeNMTDwwdXAuCtES6QfpFxy9GOTc5vNRiOSvh
         fgYw==
X-Gm-Message-State: AOAM5334Ia3Juqmc0a1p3/9+CyQlWAAsO1KMyZ49XS+hitDdds7skiyK
        xBketEzUwriXiheoq/mI2AZqTYtLf8Oz
X-Google-Smtp-Source: ABdhPJxdoamqBPvUaIPZGeaUvK2O5XS8PpgugDa2anPwgCns8QoOGnR1vBU/siA6pmqWqUz4MxMaMhNseFSJ
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a7b:c18e:: with SMTP id
 y14mr1312625wmi.1.1616148187003; Fri, 19 Mar 2021 03:03:07 -0700 (PDT)
Date:   Fri, 19 Mar 2021 10:01:44 +0000
In-Reply-To: <20210319100146.1149909-1-qperret@google.com>
Message-Id: <20210319100146.1149909-37-qperret@google.com>
Mime-Version: 1.0
References: <20210319100146.1149909-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v6 36/38] KVM: arm64: Page-align the .hyp sections
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, seanjc@google.com, mate.toth-pal@arm.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, tabba@google.com, ardb@kernel.org,
        mark.rutland@arm.com, dbrazdil@google.com, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will soon unmap the .hyp sections from the host stage 2 in Protected
nVHE mode, which obviously works with at least page granularity, so make
sure to align them correctly.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kernel/vmlinux.lds.S | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index e96173ce211b..709d2c433c5e 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -15,9 +15,11 @@
 
 #define HYPERVISOR_DATA_SECTIONS				\
 	HYP_SECTION_NAME(.rodata) : {				\
+		. = ALIGN(PAGE_SIZE);				\
 		__hyp_rodata_start = .;				\
 		*(HYP_SECTION_NAME(.data..ro_after_init))	\
 		*(HYP_SECTION_NAME(.rodata))			\
+		. = ALIGN(PAGE_SIZE);				\
 		__hyp_rodata_end = .;				\
 	}
 
@@ -72,21 +74,14 @@ ENTRY(_text)
 jiffies = jiffies_64;
 
 #define HYPERVISOR_TEXT					\
-	/*						\
-	 * Align to 4 KB so that			\
-	 * a) the HYP vector table is at its minimum	\
-	 *    alignment of 2048 bytes			\
-	 * b) the HYP init code will not cross a page	\
-	 *    boundary if its size does not exceed	\
-	 *    4 KB (see related ASSERT() below)		\
-	 */						\
-	. = ALIGN(SZ_4K);				\
+	. = ALIGN(PAGE_SIZE);				\
 	__hyp_idmap_text_start = .;			\
 	*(.hyp.idmap.text)				\
 	__hyp_idmap_text_end = .;			\
 	__hyp_text_start = .;				\
 	*(.hyp.text)					\
 	HYPERVISOR_EXTABLE				\
+	. = ALIGN(PAGE_SIZE);				\
 	__hyp_text_end = .;
 
 #define IDMAP_TEXT					\
@@ -322,11 +317,12 @@ SECTIONS
 #include "image-vars.h"
 
 /*
- * The HYP init code and ID map text can't be longer than a page each,
- * and should not cross a page boundary.
+ * The HYP init code and ID map text can't be longer than a page each. The
+ * former is page-aligned, but the latter may not be with 16K or 64K pages, so
+ * it should also not cross a page boundary.
  */
-ASSERT(__hyp_idmap_text_end - (__hyp_idmap_text_start & ~(SZ_4K - 1)) <= SZ_4K,
-	"HYP init code too big or misaligned")
+ASSERT(__hyp_idmap_text_end - __hyp_idmap_text_start <= PAGE_SIZE,
+	"HYP init code too big")
 ASSERT(__idmap_text_end - (__idmap_text_start & ~(SZ_4K - 1)) <= SZ_4K,
 	"ID map text too big or misaligned")
 #ifdef CONFIG_HIBERNATION
-- 
2.31.0.rc2.261.g7f71774620-goog

