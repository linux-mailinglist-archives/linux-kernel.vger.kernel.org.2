Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C8333462A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 19:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbhCJR7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbhCJR7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:59:06 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABF9C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:59:06 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id i5so8318930wrp.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gpovMkXHvDEd7Q1vbye6zBnrPUcdwhSYcDTZCWLwbWg=;
        b=EykAkvQxBXiDzdm6FE4Uy5mf7/ey2u/c+U5eLurLHPbE8jOinaMNiPrzd4uPyZwUZL
         2r0ZxYaUbj1XS7bDR/Mb1V8xcCBkPAGfIzGS5aU2R8y9FQN6UiYCnReXBwvS+lmODCoR
         SuLRCs3v6esu/pGnhhVYIhxo5hM8+cAzHRNj6ARFbIIXvItGTWgs46jw+pcEOvB6mOCk
         tYi+qFS0/ePTkbt0zYmXp2NVpom3ZglGq//Drt94PX6dESV2KONoPjhoxQjYEj1GZ6sA
         I7bAth+4o+atC2uZJUJNQSU8KOV+souLg6H4/Yv5ckKbF63NE/By69s4N3aq6kMVvb2t
         6FKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gpovMkXHvDEd7Q1vbye6zBnrPUcdwhSYcDTZCWLwbWg=;
        b=m6sCyylc/+V5uiAVBytrkGXplyDgcLqPD5bnUUz60wTp+DSKlc5yWxhxwBekqLgmKM
         aGNOgrIWJq8FF3F/rCh00pC5hLyxVah3G5g2bhsgU5vZJGbUd1S5Ik8VAHXz85OG3SWX
         0Ks8b9DAG7WJndVdiwtdS5PzzKsDD6UpyUUlib4eyX2666TUXQ4MAk+RKmxBOV1a3Z13
         GFRD62OyvGE1IxGt17MStVjQybqSEIlLGntVfjChaAl2QgMufbpGqYzBq5S9zjlAZzQ7
         buZY2HdIRIcog4ItQz4J2gJzHjVxE+YYSy0n5zBd5e5M7u3INwjAVBniM0e972y/emr9
         8/2Q==
X-Gm-Message-State: AOAM531/W9/OzGAXe+bkzsVXAzIoI7WAIa/FSYjNrw638A33hPeortzo
        CCe+dBHtATOi/eFv7rKL3TQwG5EH2Z8j
X-Google-Smtp-Source: ABdhPJziRnNwKB8Ne6xf3o0qOfV9qCZo6Q3H55q9W1Ku8THlZcg0eIahqVQjh17lDsKSyjkP5RcbAP3UO7Jm
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a05:600c:2247:: with SMTP id
 a7mr4544145wmm.131.1615399145092; Wed, 10 Mar 2021 09:59:05 -0800 (PST)
Date:   Wed, 10 Mar 2021 17:57:49 +0000
In-Reply-To: <20210310175751.3320106-1-qperret@google.com>
Message-Id: <20210310175751.3320106-33-qperret@google.com>
Mime-Version: 1.0
References: <20210310175751.3320106-1-qperret@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v4 32/34] KVM: arm64: Page-align the .hyp sections
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, qperret@google.com, robh+dt@kernel.org,
        ardb@kernel.org
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
2.30.1.766.gb4fecdf3b7-goog

