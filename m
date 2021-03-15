Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607AB33BEE7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 15:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239441AbhCOOvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 10:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236451AbhCOOfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 10:35:43 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A17BC06175F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:35:43 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id f9so8294391wml.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=V8Xuh8uPnnLxOiVNiwLjLFxuzBpy6trzUPCuAOE2xx0=;
        b=Nz2UlNJsd1OuTRMmwb29WE3c6in8/OlAyj62Nd/wk6kQylS1Nph4kVvwEncfOMYoc/
         v2jBBn0+f1Sqad3Fr+XGYtzAoR5if9jPVr9ZlG2JqUGI2kjUyp9tHOIOeO2EVvbWDMjV
         5SR+Xr67g035zmB0zfXCIPMaxI2qHem0Fr8K+b2ujs5IX6F5cxq79OOwSvbjeqrbHzOF
         5A11xNQKXiDEOBGrO3GMCQYVJQ+C6HKNP+eLxSRYndYG+lB74ZJ0uAF7H44HgzogN4W0
         1CtMR4wAYEtAKuGn4XzGCOrVpERvEm54sciDEgPjaM1RommkB6DCMy/ngLl/KaKQNCBl
         zSVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=V8Xuh8uPnnLxOiVNiwLjLFxuzBpy6trzUPCuAOE2xx0=;
        b=nJKh1UHbJxkDYC9+vd2k9m3ORjRdDB6yoCSSBG1bPiuXWg7vu7hQe5EWh4SFE4vQIY
         DZ/cw18x17++dBEYiGQISfUmi5cqcNTbQm9wz06V6Aiyt2zi/tJszMXwDeC+E8o4RWMi
         PKwyU3xORPxQCcbVfwRnH5LgEtsRysDTs94EEocnIT8FMjRAZuIt2KPnU4NWqbQLIVL0
         YOA2FGHmUPRzc2sHPnVNHz1HavUQVXE0LYLvSsVZug+vrW/gZxroCA/ae/Ve1e6Q0Je2
         TWUNiKtVufMbqxcVSv1M4xHZKjVYhmdl6r/Wd8SRV60kt5/pcIP1bCRSPJ75HzEZtU7x
         Ywvg==
X-Gm-Message-State: AOAM533lS9/zA5bLV9siOKUvRa0zef3E9oyN+k7qycBNpf0uM5LbykGb
        e5TAjHYKnsZM9npZfBdu3BGjD7ts1CRG
X-Google-Smtp-Source: ABdhPJzR1b4aR6QaQ60ISv7IHqOCyLzBmRTfzqmQXTTEq7n/TXFLvP84XEuBt+n493T0JhKm+QtbDMICVRWV
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a7b:c750:: with SMTP id
 w16mr9005wmk.184.1615818942004; Mon, 15 Mar 2021 07:35:42 -0700 (PDT)
Date:   Mon, 15 Mar 2021 14:35:01 +0000
In-Reply-To: <20210315143536.214621-1-qperret@google.com>
Message-Id: <20210315143536.214621-2-qperret@google.com>
Mime-Version: 1.0
References: <20210315143536.214621-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v5 01/36] arm64: lib: Annotate {clear,copy}_page() as position-independent
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
2.31.0.rc2.261.g7f71774620-goog

