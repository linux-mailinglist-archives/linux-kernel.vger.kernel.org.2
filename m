Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFF330B0F5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 20:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbhBAT5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 14:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbhBATp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 14:45:26 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF756C0617A9
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 11:44:08 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id j13so6555478qvy.19
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 11:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=9ElhXeWA9hrtQUSa92BHDv89rLolOBWVaEOaHObQHiY=;
        b=scCt97wjEnPKthR1OEsfg6XHzgS7EdRFiyeoCwu46hVwq5SF3m83dULHz0MWmmLGZl
         yY1Mcb/oHxqrO0CQyzz2RZvmAnQ0bHwXgancVwJ8Kf9cil1iktYwcALcUpt8omkBBHc3
         kkd4KIyCpQULEzuHjoILesZuKjI3HCZjm6xFhHFB/41fKMgY+HzZ0fmHsvzGSo5PJQRd
         1qzDE52vdQilfVBIZo6KxqHC32etk1l7O9n0C3A7cR60R+7EJMBESajOp8+nVQnDVT7t
         X0qHdKFBkQ62nf38KxTN6Kq6kGBIJL7HtiqGEajvgyY3xCf6RvAxjkhQOoK7XuBRQGSn
         QsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9ElhXeWA9hrtQUSa92BHDv89rLolOBWVaEOaHObQHiY=;
        b=DmRpEDpT4bER1H/e3w2k5/AUbDhXjDRol+8uondeE4LvB+Bj+n6I6MOseFmOe9f6h0
         WYasBHvbdZAchbAnGMcH0j1sQ+QLFo8Vg09CWZL4WJ7MQKdBEJzM3vvidw31+SJEckzZ
         HOYe65g23V1DZPrZD8XAIIru1tAUR88TPFblSabgePGJKyvHYsvZgLNm/sDyBZGXJ/2q
         ohkLL4uTaNmOl5q6dltenGMY3yeXlnYWdiUk179v+n9/ATQTNr6iutRCAwlzHPZU9IyB
         8mjglmphrHCSyMrKa9MTPkjn/F60MotaSPACsvpCflh5bwZWmRwUDAHPmVOpDyJXb56Y
         G4fA==
X-Gm-Message-State: AOAM532kego8P6LjOSIqNHemZSKnyu86aaozjhevTR74jLeQxkLlnm39
        oOIaT7FfuDmvsZQMoaYV7YdZkDQuLgy19cwz
X-Google-Smtp-Source: ABdhPJyGsScV89G9MAWMKyK7rBzUxlUepSEM9x8u78kzqVlPK95BXbpBATuTGNJidQ0HrKqL6DgEfGQHE22rUIOh
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6214:11ab:: with SMTP id
 u11mr16841497qvv.17.1612208648056; Mon, 01 Feb 2021 11:44:08 -0800 (PST)
Date:   Mon,  1 Feb 2021 20:43:36 +0100
In-Reply-To: <cover.1612208222.git.andreyknvl@google.com>
Message-Id: <d128216d3b0aea0b4178e11978f5dd3e8dbeb590.1612208222.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1612208222.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH 12/12] arm64: kasan: export MTE symbols for KASAN tests
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
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

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/kernel/mte.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index 8b27b70e1aac..2c91bd288ea4 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -120,6 +120,7 @@ void mte_enable_kernel_sync(void)
 {
 	__mte_enable_kernel("synchronous", SCTLR_ELx_TCF_SYNC);
 }
+EXPORT_SYMBOL(mte_enable_kernel_sync);
 
 void mte_enable_kernel_async(void)
 {
@@ -130,6 +131,7 @@ void mte_set_report_once(bool state)
 {
 	WRITE_ONCE(report_fault_once, state);
 }
+EXPORT_SYMBOL(mte_set_report_once);
 
 bool mte_report_once(void)
 {
-- 
2.30.0.365.g02bc693789-goog

