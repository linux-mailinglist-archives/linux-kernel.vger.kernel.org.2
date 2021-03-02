Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4637F32A904
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 19:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580487AbhCBSDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1578595AbhCBPZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:25:25 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9716AC0698D2
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 07:01:15 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id s10so294640wre.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 07:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=oOi4Pd0Cf29FRmhNkB2FdW4vfgElKPAhhlmUWrOeLOo=;
        b=DAmMeWzNT5OYqZl5202wU65yxy+Ydp523Zp7hpAs3u6y50OwoTcx758BDuByCvqfpr
         lL66LK7SqeqjJ31D3FeWNNmuzeeAYFbG0jOXhwExojOAYwgKPFB/Upejy1HSGCOeocBz
         Q77qxjqgfA37YlEo0lvNhexw9R25bV/YneXYP1EAd0KGepP8GHBS0pghcx5PMdxRBZgc
         YnHcQtY1pOu1oGjAOse8QuPkG5uwHCk1qvJOhgP1bCeNHMroUAn9rsUMkI+Xf9c0o3tx
         ZwvKhjg5Mi3jbC3w5KrMFXC/hihqbKsMJfhqjnCBux8y/nIV1yUYUWlZYlo8euhBHzJV
         wVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oOi4Pd0Cf29FRmhNkB2FdW4vfgElKPAhhlmUWrOeLOo=;
        b=jyS0/TSmbn7FXxhtyRSegqQdIFnYk1CUdAgVObyYhs038VXKc3TJo30mP0Gm3P4765
         Pks22Ez9lYs16jujprKC7RdX8dVIP677rURS0duxbkDFULSU/PgQHr5WivhqOXPql3iU
         CwigIrRztyK7K+BY0y2T8/BZa9yXBnOCkOtfwBuM98F7XNBoCAZoaqq9rkrVys3GLit0
         /O7zdUbecvryf7ciUhN59INj6uEVCSBM3EOsC5Pwri3KyMPJ/P6bbWMFJMd6Ii3JIJH1
         ZJ/3BJDSsewys2efdBioWVcO8X7kUbq2ewfapVK1NsGagz5pA/D1RNeN6Svzet1b8qjY
         R/Ng==
X-Gm-Message-State: AOAM530GjX7msOZj/o1fUJnO++x0QOVNhrzqYnmi7ZiEquQ6TltzYp7N
        D7qvFRpCX4Wi3riHbup/YESFhAAwDsd9
X-Google-Smtp-Source: ABdhPJy3ARsSSbx99em/qRXAe711Of+WD5kY+Gg+HksN47kkDAMNctzWR2nongDDAS+SviyOgYMF6zN0Mxfb
Sender: "qperret via sendgmr" <qperret@r2d2-qp.c.googlers.com>
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a1c:1dd5:: with SMTP id
 d204mr4338156wmd.127.1614697274353; Tue, 02 Mar 2021 07:01:14 -0800 (PST)
Date:   Tue,  2 Mar 2021 15:00:00 +0000
In-Reply-To: <20210302150002.3685113-1-qperret@google.com>
Message-Id: <20210302150002.3685113-31-qperret@google.com>
Mime-Version: 1.0
References: <20210302150002.3685113-1-qperret@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v3 30/32] KVM: arm64: Page-align the .hyp sections
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, qperret@google.com, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will soon unmap the .hyp sections from the host stage 2 in Protected
nVHE mode, which obvisouly works with at least page granularity, so make
sure to align them correctly.

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

