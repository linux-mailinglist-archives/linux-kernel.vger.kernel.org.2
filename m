Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D4F3152E2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 16:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbhBIPd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 10:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbhBIPdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 10:33:20 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72257C061788
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 07:32:39 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id f7so12439788qtd.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 07:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=3AT4g9LoM2snc1rY1VWM+BOoG0vxl/R52Ax9ZAP8Pps=;
        b=k1rtx4PVnaiy+LETQTREcYXHER5+5AtyI3qZdPOa8yc5S/IvoVwgzbcyPuYjfURKvg
         mf4cqSh4ZwqBgI8a+f159HJ/KZ69L+b7JQPGx/NI0eaDx4bYrKRv9zFAK6kU5b/YJ845
         po7rt3mNdjrXT3aJIkJnbiwQdDCobCP9saAYr1jSmLoC9RSVXql5JnsCNmlA1R3fIYa1
         Y7Ibjl484v9hpYK2vDeOd16qcawlXCInsfIY3nn4LMsio+qOuHihaIu9CAOIZoiquRu8
         lp2bgQmlg9iX3G1e3GeBB6Pwb9wwsi7KD+vGdpJ4kn34mEoP0n7pfYM+q5bddzEwO+AK
         tJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=3AT4g9LoM2snc1rY1VWM+BOoG0vxl/R52Ax9ZAP8Pps=;
        b=jRnurUEK7IngY4NgIcG0cwrbiTexdZ3mVXHka8Q24sW3dgZ0YVNqQlOUFizzw1TG52
         RFjyWdoHOVCSqmJmn6DlZ8MQxr6Myw/3lG1mlZ8B2am2kkdjJcJkQByECxRiSNHmA0Pm
         I7NEUZ0R2dfPCGMh66CMugKi6j3LY9IIVHs891WwqBtLRFvGJ3YsL8Vm/00MqE0TCUZy
         +1CHFFei4ThgPBo43Ix05FVG+3OSCppTC1xBFDrSlOKo2UNk91mPoIS3rqzg3LmnFzr6
         TTzdGmGH59Hbc9k0P33UVxuU0gKP0tf8m0tdGR0C6oyaL284JMP8oADTiEa5qieyH4fG
         iMdA==
X-Gm-Message-State: AOAM530Tal8/wnxUoE31J9RbIIhM08z3n9+n+NXPytf9Zonp21RkOYfU
        CcWDr88ZhssmTWGXaRUZ9inNANnay1ANcPet
X-Google-Smtp-Source: ABdhPJwqugpPv8aDmVT/yfBcKnIX6EZIt6gbuf4077PS4mJNXAU2C7zv0XGdDILLP2NH6/qeAePdFV7TCMapcfTP
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:55a0:b27b:af1c:327])
 (user=andreyknvl job=sendgmr) by 2002:a0c:ee89:: with SMTP id
 u9mr21350165qvr.40.1612884758518; Tue, 09 Feb 2021 07:32:38 -0800 (PST)
Date:   Tue,  9 Feb 2021 16:32:30 +0100
Message-Id: <dd36936c3d99582a623c8f01345f618ed4c036dd.1612884525.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH mm] arm64: kasan: fix MTE symbols exports
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only export MTE symbols when KASAN-KUnit tests are enabled.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Andrew, please squash this into:
"arm64: kasan: export MTE symbols for KASAN tests"
---
 arch/arm64/kernel/mte.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index a66c2806fc4d..788ef0c3a25e 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -113,13 +113,17 @@ void mte_enable_kernel(void)
 	sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_SYNC);
 	isb();
 }
+#if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
 EXPORT_SYMBOL_GPL(mte_enable_kernel);
+#endif
 
 void mte_set_report_once(bool state)
 {
 	WRITE_ONCE(report_fault_once, state);
 }
+#if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
 EXPORT_SYMBOL_GPL(mte_set_report_once);
+#endif
 
 bool mte_report_once(void)
 {
-- 
2.30.0.478.g8a0d178c01-goog

