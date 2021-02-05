Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C757A311128
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 20:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbhBERpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 12:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbhBEPzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:55:20 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E62CC0617A9
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 09:35:20 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id z19so5756965qtv.20
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 09:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=V3NcBz/sBuF9R5rbEs4mkivGfi7JQffIAtJVZQe6PVQ=;
        b=AyFbGRtZMQocl7Q5NZT214tJhO130JH2kzAWqSjD8+Setp/oN6e7y7y8sPvxLQ8TH6
         UfeGhuUInm0NPCAigeTNrpGzDs0p+CeVjTEmhqouTHFWmbb5IGwrv+hy3nMqEPJ5yukw
         flPCVMav/pLrs8OsAbd8op8i84uJ0cBQXHIGczYU7OYXZ71NdHwo97Qy9Ohdp+Cmvc9v
         5BhyH/fScylRm+CG12IxCgd5lj5u7a/9pl8SjQluL9wg2B8jUpNlP9gDHyB0ZVrHMbwx
         6xr1/x0bN5rWepIoZ6NFyCEI08m5yhNOXHjLn12fmIibIaQ1QXL1I94o8s+BOLGB96yU
         1XHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=V3NcBz/sBuF9R5rbEs4mkivGfi7JQffIAtJVZQe6PVQ=;
        b=Y+kHfQ2RAqT05cHwec6GYCnWkGA86HirX8ydLk25ATItCYYSLCAt9iZ121oyXltobv
         fYfvjItKw6o+W2bt8O4xTDeJbzYFfdST82rPVFgLMFhPPpVUaIXRHIgqv9lxuqLDRYYw
         RNPRhtLYBIx54NmdPKdutMrqwoL6wSLUlX1VrK7fAKSzCtRVplh1D061aedlhrdGdTCK
         veXWCTOWNFZ2EmA+PVcPT4ptGnwA4XQOaIp4WzqNb1YWXI9iTIoSS4KyRgle5iaK32EX
         uxWIW/93+T7VrIlh3haD/KCzLIRIEchXmKhqT7vtmYc/BQnOKcP9n7t0f0qpx8O4l4Ie
         aMiA==
X-Gm-Message-State: AOAM532URopldaVxtKhDK8f2GUQZ6VekFTNBQ12tULmax99qSDV5lbzL
        N/FBoYb5YP+onutTN6G7KJr4mlRJxDyHBEGg
X-Google-Smtp-Source: ABdhPJweLbaw7VFlVSS/J9c4mZHXhCjW3eIz5PFMh/DXiJO3ThcuygtX+EQLe2kTQSSSDZUfps4nI4nhEccmHL6m
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:edb8:b79c:2e20:e531])
 (user=andreyknvl job=sendgmr) by 2002:a0c:eda6:: with SMTP id
 h6mr5378538qvr.19.1612546519544; Fri, 05 Feb 2021 09:35:19 -0800 (PST)
Date:   Fri,  5 Feb 2021 18:34:46 +0100
In-Reply-To: <cover.1612546384.git.andreyknvl@google.com>
Message-Id: <14da91876a25a6ae5b2096f7c06ebbc6deb3cf6b.1612546384.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1612546384.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v3 mm 12/13] arm64: kasan: export MTE symbols for KASAN tests
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export mte_enable_kernel() and mte_set_report_once() to fix:

ERROR: modpost: "mte_enable_kernel" [lib/test_kasan.ko] undefined!
ERROR: modpost: "mte_set_report_once" [lib/test_kasan.ko] undefined!

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/kernel/mte.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index 203108d51d40..a66c2806fc4d 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -113,11 +113,13 @@ void mte_enable_kernel(void)
 	sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_SYNC);
 	isb();
 }
+EXPORT_SYMBOL_GPL(mte_enable_kernel);
 
 void mte_set_report_once(bool state)
 {
 	WRITE_ONCE(report_fault_once, state);
 }
+EXPORT_SYMBOL_GPL(mte_set_report_once);
 
 bool mte_report_once(void)
 {
-- 
2.30.0.365.g02bc693789-goog

