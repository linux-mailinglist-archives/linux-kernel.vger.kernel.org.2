Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958BB3345F4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 18:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbhCJR6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233556AbhCJR56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:57:58 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD67C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:57:58 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id n16so7241873wro.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AbQOhTo5qTBDcGKT4ROquEtU01mLpiQKpICJ+GOnoG0=;
        b=JzpUXZ4hpdoBvUyEsWDm2q1s1QRxAl2wx4lPyxgUQpUIJ7F0aVV92HnT2t7d2+gB78
         bUz/2TCUabh7EGBtNVRZShXzUflsBTbBP8+TtuPJERTGtDDbxvky8XAhZfj+cyxBTIOr
         VWwXSeTf22kfUPlEI+Gwhr+nqoB0tAKIffsGWkZdhNwdwyheRpKO2ypsVssGnl+iZBcG
         DoFVBZxFu50SG2HHLuRMrZtkXo9vsu4OjCirEILdzOmzM58CyNEo/DRyzmIvNtEoaf8R
         gisXQSUy9RC42Ahgk3HJDSsgTcaFEJri7l2kjGdD/YjK4DU4vgnl3B/RH4W0CV1cQkKX
         HAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AbQOhTo5qTBDcGKT4ROquEtU01mLpiQKpICJ+GOnoG0=;
        b=ZVxLXBescwZq4yhP6O9Cyihrfteg+UkCyJJY029VxKJYWUPaWGWxVzeKyDNQo8YSvQ
         s8HDRuv8ilYB1G2V/2xRyvmmFSGYh/iPmej8zl1mdu1tmFJ2m6ZGem7Ec45yie13Q4Ii
         6cAI+tkZqS5qE76dhgUxrNI5g3BSWRYBOS+NqEf6JdydtieJ7IMNHLkqtIhAOZO9cPzs
         fv8Uscke4JVfUmdigH+wAUmwAWrsNQ8xXTqvwerHJtl8b4YGf1ykqX6CISdqAPsROxMQ
         RSpXaMGrUjxfGT9MgHd6fUG2HcNT3LWxfg0pKGyCQvohLQHeNyh895ksiqz3cmRGgO61
         2jKg==
X-Gm-Message-State: AOAM531E5bqerwbjPuEBgB/zFrTKicG50JESo4hBunZQVHWHpMTmBdl/
        mOAdtdo75TOsrMU44MCKLZJl8weJ3Rf0
X-Google-Smtp-Source: ABdhPJyoHV7k5VKRC4cMLOuiadpNjmOubi8A8GxCIf77avXZ6hUq1pIFK8fqsdVSlzJaLhL/5cbha4JM2YHV
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a1c:7210:: with SMTP id
 n16mr4388170wmc.13.1615399076669; Wed, 10 Mar 2021 09:57:56 -0800 (PST)
Date:   Wed, 10 Mar 2021 17:57:18 +0000
In-Reply-To: <20210310175751.3320106-1-qperret@google.com>
Message-Id: <20210310175751.3320106-2-qperret@google.com>
Mime-Version: 1.0
References: <20210310175751.3320106-1-qperret@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v4 01/34] arm64: lib: Annotate {clear,copy}_page() as position-independent
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

From: Will Deacon <will@kernel.org>

clear_page() and copy_page() are suitable for use outside of the kernel
address space, so annotate them as position-independent code.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/lib/clear_page.S | 4 ++--
 arch/arm64/lib/copy_page.S  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/lib/clear_page.S b/arch/arm64/lib/clear_page.S
index 073acbf02a7c..b84b179edba3 100644
--- a/arch/arm64/lib/clear_page.S
+++ b/arch/arm64/lib/clear_page.S
@@ -14,7 +14,7 @@
  * Parameters:
  *	x0 - dest
  */
-SYM_FUNC_START(clear_page)
+SYM_FUNC_START_PI(clear_page)
 	mrs	x1, dczid_el0
 	and	w1, w1, #0xf
 	mov	x2, #4
@@ -25,5 +25,5 @@ SYM_FUNC_START(clear_page)
 	tst	x0, #(PAGE_SIZE - 1)
 	b.ne	1b
 	ret
-SYM_FUNC_END(clear_page)
+SYM_FUNC_END_PI(clear_page)
 EXPORT_SYMBOL(clear_page)
diff --git a/arch/arm64/lib/copy_page.S b/arch/arm64/lib/copy_page.S
index e7a793961408..29144f4cd449 100644
--- a/arch/arm64/lib/copy_page.S
+++ b/arch/arm64/lib/copy_page.S
@@ -17,7 +17,7 @@
  *	x0 - dest
  *	x1 - src
  */
-SYM_FUNC_START(copy_page)
+SYM_FUNC_START_PI(copy_page)
 alternative_if ARM64_HAS_NO_HW_PREFETCH
 	// Prefetch three cache lines ahead.
 	prfm	pldl1strm, [x1, #128]
@@ -75,5 +75,5 @@ alternative_else_nop_endif
 	stnp	x16, x17, [x0, #112 - 256]
 
 	ret
-SYM_FUNC_END(copy_page)
+SYM_FUNC_END_PI(copy_page)
 EXPORT_SYMBOL(copy_page)
-- 
2.30.1.766.gb4fecdf3b7-goog

