Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92B032A919
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 19:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442226AbhCBSLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244264AbhCBP2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:28:22 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34DAC0610CB
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 07:00:09 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id b62so1311768wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 07:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=AbQOhTo5qTBDcGKT4ROquEtU01mLpiQKpICJ+GOnoG0=;
        b=MfW/XHtPJX0w2ipZVk2ijDvDAMfL6HCaJrecrAAwfFAlbKa/hgXriwrQC/xOMitILV
         HdeX+FO8dVOXvJ349UOGKSfzw/G8uO3yAwL6GNM/TEN+7BJOpvN6cPTje25i9rOjEdFo
         Ze8aV5OUD8zbeIjktjuBv3Fx4bJTcKIUqeaNFPiZzdrljYxVNzrXJrvbLcKWBzbh478I
         gL8cwdt0E3dCMiyFlf1XGEThwupYU3c9H/mT2wRIck9dvEg3atzKumxpxoJ5g+SNIHGF
         FMI1FTzWJ4QlMmJ+28ZhCaYFXCUALVIdDv9d3OE6oZERGtFbYN4KyiSg+RbRZnI4i231
         Mmfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AbQOhTo5qTBDcGKT4ROquEtU01mLpiQKpICJ+GOnoG0=;
        b=mI3onTpOBy4SnccnlRZRyPSF00qiX28imZamyZ2O/eN4QSw+9Qwl4JO1SSl7cn4I4J
         MsSBhWH3jtpuyg8RQ9Ms5Fx6/Z9JFe8jhI6LUcrDVGbr6W7/Kz+niz06ogR5SAGLLqKB
         NB86/WGYtmJclBitO38QkSOjj2noIYJlOKHpIVPKPUm3nHOodplNogsbagf+4ienzTBw
         Ll8TgltJGGmaazSev37UicxmSw2HzVg+a392GGKEBIubu6eaDRv84cYFau7y2LB/uBy5
         YYEtL9mCnEGqFtcr6218z87WWQ91Z+BK0nDjxEw4f93PPH0GqsSkuevKRYSdJckQ6Fpa
         za2w==
X-Gm-Message-State: AOAM531puqbhJRyCsXdaRyyhxfH8j4cmkrxDhFncIEF5+Ld8viloQU3t
        FkHL74ayqDh2S6dUrwhCLguycy40On2E
X-Google-Smtp-Source: ABdhPJxKe/abaoaQDAN0ud0u087kNQ1v1cFYLoKd692l087a2pLQ0SHZGffvQJSKkW0kxuZW5igSyzEjrCP4
Sender: "qperret via sendgmr" <qperret@r2d2-qp.c.googlers.com>
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a05:600c:4c11:: with SMTP id
 d17mr4573540wmp.86.1614697208554; Tue, 02 Mar 2021 07:00:08 -0800 (PST)
Date:   Tue,  2 Mar 2021 14:59:31 +0000
In-Reply-To: <20210302150002.3685113-1-qperret@google.com>
Message-Id: <20210302150002.3685113-2-qperret@google.com>
Mime-Version: 1.0
References: <20210302150002.3685113-1-qperret@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v3 01/32] arm64: lib: Annotate {clear,copy}_page() as position-independent
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

