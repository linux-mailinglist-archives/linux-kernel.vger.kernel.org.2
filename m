Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2CD341930
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhCSKCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbhCSKBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:01:53 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA883C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:01:52 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id b78so33574016qkg.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=V8Xuh8uPnnLxOiVNiwLjLFxuzBpy6trzUPCuAOE2xx0=;
        b=E47utFiCvPDllFOUvdxw5MOKvubX8x5bac8nRQH/7SYG0fJYbAZBV+9CZ/3/4SbXMZ
         j/uDGzouAkaKWs+7hEm10fD00d/SyVEbDAMqbhYgqNeNjIlmJM0PYnTX2O+aKOARK+Vb
         gbZbhRoVoGb3LNyn4TqH0HkYIwH3lwLBG/2AZz5tZrcGXcmbrkaH3290cEpVtdLR06fD
         DyXwM0GgpUVDslfY8U5L/SyeyQPbEDSvuoBChD14M7n5FhlE1Uy+0aOlFXFmKJQDIkfC
         4vPQ4BwQRHdoYMNoSh3I971jrh4yi5kOOUOv9jiWyNZlueB+yL2JezBSdvDXQltjetQV
         SfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=V8Xuh8uPnnLxOiVNiwLjLFxuzBpy6trzUPCuAOE2xx0=;
        b=qd7CdN87ke5fpebsNziRiN1dTGuIcRCBKnHnEBt5b5JI1tNZTZBEgCXoAXfA4yiO3v
         NaxiYx9MIPpOin4COY1Mnt45kqTcCcxspoGny2fS7FqQ+oVNkZyRHc70xoJzzRrJQ1CY
         qaMze9WHKuboTcC5OlZjUf6jUjvmtW8MbDtVa1erXovg9uyRJ9RK7odhEocmsgXmniZk
         uShfErjTE0X1GD2HrfD8J+Q0JpZxBCvVQBUXxZDWTf1WWve4G386OTAGe7ezKJsCfy/o
         oaai9KGa32fyCXggPTZPuoh1EvrOnSWLQ74KGRiOtqyLJJfpv8vMHbKMoHP1QyAVYvnF
         A58Q==
X-Gm-Message-State: AOAM532AKpOIU1PBX0hCSWaNoWxrW3LA3qTinMYgGxWr2PcCh+I541Pt
        a6NDhm2SlE/5DPmG9K3UNR91IceP1ek4
X-Google-Smtp-Source: ABdhPJwrKxoMwoQgKcQKrC1l3pkp1V724TOKMdk4pKAw8/iqqYX6l7isxjYsCfysPkn+0D6rQZUe8Z4Ko+sg
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:ad4:4aa8:: with SMTP id
 i8mr8745734qvx.22.1616148112063; Fri, 19 Mar 2021 03:01:52 -0700 (PDT)
Date:   Fri, 19 Mar 2021 10:01:09 +0000
In-Reply-To: <20210319100146.1149909-1-qperret@google.com>
Message-Id: <20210319100146.1149909-2-qperret@google.com>
Mime-Version: 1.0
References: <20210319100146.1149909-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v6 01/38] arm64: lib: Annotate {clear,copy}_page() as position-independent
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

