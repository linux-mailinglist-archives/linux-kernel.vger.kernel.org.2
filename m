Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94784310D96
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 17:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbhBEO0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 09:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbhBEORT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:17:19 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BC0C06121F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 07:47:09 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id c12so7456059ybf.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 07:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=jIaeLYAzRLuX+Bh9Y7uHrxQjgj3fqKxlpOgYc1EJ990=;
        b=gxafKVSjEdKfMi+epPlKRwmPrE34Nz4U8OjnRmWLqqm/8o7BQY8xx3KC3dFp6fPjPM
         X8HZGZ/5/LtXi1oLUzN0En3X9lftRUQVYepeq7RfrreRHKD+M+CgmYBRIJ8FpM+UXumV
         i6aWJhkv95qOmweLBQxRdIOcKg/8FbF/eBHX9Nor/DJ/znPBx2YZn9KDxaX2IacPF/SX
         x+Bb1Gmu+ncxDnZCkIpsy4Wldr5IUHQSvvG098nSFiYpcXLPRwA7OcKMnHExKNt+p0hU
         6FvKas1BFmtYRhe6iDn9Q5RBGWWmZ6gZiyVg4yIVYUC1Y1IDOw9TJ0q9t8wyb9Sy536H
         vgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jIaeLYAzRLuX+Bh9Y7uHrxQjgj3fqKxlpOgYc1EJ990=;
        b=XhNHi3dShBEc4cqar6hldWurCzbJ2pQnvUkaT3EBcTXBMi9TdS/119jki4/oCsSQjh
         0W4haLU2tDeXyoyigTe5h0+ICjLMSjwTQ7xfdoxHZo4q/Q0ZpZfN4Ye/0xP2ZqiM5vIU
         NaLCZ32cnSYGrNEv8eJzokMxaiz3jHs6pbenKhUa7Ow8mHMlaP04iXeCie+PzEj6eR2K
         yhZk77hG3DeyVsHXWv2bwf3nvwvV29kjHEuhTpXvQtaYPD0QT1J/6zMz5J6RJfSQhN2v
         xRVOOsSSzOXjAys2fjZg5k9cZWXBHJFBZeB9Rt0IIiqTOBwqtGR+sjvE7VA/3Keh2W40
         3rZw==
X-Gm-Message-State: AOAM532fb+tqs8+LQ1kVYHfX97HHCYGfkzplV5xS3vKhdAvZegOSUK24
        0LOURAhRUohixUymEap/Wo48O5UDoyVB9XSe
X-Google-Smtp-Source: ABdhPJywuIcjamxfCRpOr02hXFSCeN+u8fLAfBL1fEi3HK/aV7eWDTn1xkNVkVPGJ9mUhxsCfkPWbZAwBK/wAylo
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:edb8:b79c:2e20:e531])
 (user=andreyknvl job=sendgmr) by 2002:a25:31c3:: with SMTP id
 x186mr6809008ybx.500.1612539587288; Fri, 05 Feb 2021 07:39:47 -0800 (PST)
Date:   Fri,  5 Feb 2021 16:39:13 +0100
In-Reply-To: <cover.1612538932.git.andreyknvl@google.com>
Message-Id: <068ab897dc5e73d4a8d7c919b84339216c2f99da.1612538932.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1612538932.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v2 12/12] arm64: kasan: export MTE symbols for KASAN tests
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

Export mte_enable_kernel_sync() and mte_set_report_once() to fix:

ERROR: modpost: "mte_enable_kernel_sync" [lib/test_kasan.ko] undefined!
ERROR: modpost: "mte_set_report_once" [lib/test_kasan.ko] undefined!

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/kernel/mte.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index 8b27b70e1aac..fc753fb77940 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -120,6 +120,7 @@ void mte_enable_kernel_sync(void)
 {
 	__mte_enable_kernel("synchronous", SCTLR_ELx_TCF_SYNC);
 }
+EXPORT_SYMBOL_GPL(mte_enable_kernel_sync);
 
 void mte_enable_kernel_async(void)
 {
@@ -130,6 +131,7 @@ void mte_set_report_once(bool state)
 {
 	WRITE_ONCE(report_fault_once, state);
 }
+EXPORT_SYMBOL_GPL(mte_set_report_once);
 
 bool mte_report_once(void)
 {
-- 
2.30.0.365.g02bc693789-goog

