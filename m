Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7552C34ECAA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 17:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbhC3PgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 11:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbhC3Pf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 11:35:27 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CD2C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 08:35:27 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id k188so14745582qkb.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 08:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=q7MsrOk2npJtSNdwNIXd9WmInrGYWhEX/by2Gk6QS24=;
        b=TMlZyMKLF6+u73+vvDs10ucDaUCG/DH7NE0rd/9/9/C0wXaIUSqOSu0YqNP3qDF3ua
         gs80vXCGa+Q3MBcCQzUrspjRaJ8ZsXbXAoX3Bk03Wyvta6OcI86hcUYy7l6lIbI1zNK5
         IXuhVvS7QRTZeNiOzsWIBqamgVGdNEAj1pcVP+wDbk0UlAI6q5zb1htWm0kW/9Sr4lfN
         vrJY4Q3zbffDzrZ0ik4myEBrn4vsQkU9ZwAI5AufdkqKL38pSbci7UI3Xhr8eQPp073O
         vXqwOu1u/RQAVFPjX3ylAhJ2T4oaZvReSjlDw3Hj3N9QxPxm/ctYliZjDrZD/v6WXsdI
         zVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=q7MsrOk2npJtSNdwNIXd9WmInrGYWhEX/by2Gk6QS24=;
        b=QKx6Md0E8klCRWPGXeLOhQilgn4cwOE3QEAEQ1XEtZFQvea5LajjUbm7lkL+FlE7UL
         FQQFncdQoVIb4Ir9lzlVOkP3OqUT7FLSzvDSBlgOYED74XxbQdcbD/1Wp7kBdUth/+r9
         7vAFluVTfjV4xGacCbftK8cBUUdMjn2x/I/Smkkb6gWSVZVlOeaMu5jrvvJIzGoag/cT
         ByalaQpCp8iCkamoRLGMdS/4zJxAy3L3Hb6dHFisxHRlNsy1JTkbkvtkcLXyZW1psb2b
         C2dj/Lz+Rmmap97XdD+L5z+4e85reQOfe9/pCRDreBerV2SS5U4AkoYtw1fX7Xrq09T1
         PGIQ==
X-Gm-Message-State: AOAM531Q2WQLK4VajGRLVi9FoNxNLhdgowozyKtHUFGuokGbYVFMwt54
        OyqLnvuWCf0+aIt+/9iHlDXL+ibauyDzBbMr
X-Google-Smtp-Source: ABdhPJxZie0Pgr6yuUoIaRSVo3tk5+dKFfBmuFnR4wJcoDADwMUFyZHcXz/XLlpiWT+/jEP2GAaownmByR8COW6h
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:f567:b52b:fb1e:b54e])
 (user=andreyknvl job=sendgmr) by 2002:a0c:ed2c:: with SMTP id
 u12mr31246924qvq.30.1617118526298; Tue, 30 Mar 2021 08:35:26 -0700 (PDT)
Date:   Tue, 30 Mar 2021 17:35:23 +0200
Message-Id: <2dc799014d31ac13fd97bd906bad33e16376fc67.1617118501.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH] kasan: fix conflict with page poisoning
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When page poisoning is enabled, it accesses memory that is marked as
poisoned by KASAN, which leas to false-positive KASAN reports.

Suppress the reports by adding KASAN annotations to unpoison_page()
(poison_page() already has them).

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/page_poison.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/page_poison.c b/mm/page_poison.c
index 65cdf844c8ad..655dc5895604 100644
--- a/mm/page_poison.c
+++ b/mm/page_poison.c
@@ -77,12 +77,14 @@ static void unpoison_page(struct page *page)
 	void *addr;
 
 	addr = kmap_atomic(page);
+	kasan_disable_current();
 	/*
 	 * Page poisoning when enabled poisons each and every page
 	 * that is freed to buddy. Thus no extra check is done to
 	 * see if a page was poisoned.
 	 */
-	check_poison_mem(addr, PAGE_SIZE);
+	check_poison_mem(kasan_reset_tag(addr), PAGE_SIZE);
+	kasan_enable_current();
 	kunmap_atomic(addr);
 }
 
-- 
2.31.0.291.g576ba9dcdaf-goog

