Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5920C414CFC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 17:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236432AbhIVPaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 11:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbhIVPaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 11:30:08 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D0AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 08:28:38 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id m21so2999095pgu.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 08:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kp0DKxYvjStU9lLWJtLQliS/mXlIIBkYQTnbdZfBCzE=;
        b=D5TUqu83Rbx8goxjtEUmUrqUWsvsTOIx2eW7pCLs3HhFTKoq8sjupa1Mo/TqMWyPCM
         YBCATZaRsjXgWQjzPDoDN+e0qHNzLINwjO4LaDBqM+Vmug1fKMb43OsBMIwvq4t+9TY2
         GE1l7w8qrpmu3fQCjV1A52r8N6XWz3BbE0Z1TN7neq12Z12RgAwQxyI6LFQVysYe2HvE
         aV99P+vNQqUfFkZ7DHvM7/nnhwW7ploLm7LP2ZHtHzmCZeYCwIYVXH2ZtV8X63Vkd0nP
         1mqfyNEtpJ1grBCSkHFaGKY7VF3AOD/c6scYRq9u1h5++KbMz6bj9qGXd8KzKBgt18Xy
         b9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kp0DKxYvjStU9lLWJtLQliS/mXlIIBkYQTnbdZfBCzE=;
        b=kzpsHs8MIwsYVJ+RM0wruUGDkCybC1AbOAcr0fKEkGkqPVi6Pmnr2ICPHn40amJe+m
         bEnQFM7Boz3T2OC7Xs4LEqvpZSBDmGZ41tIKr+XZ0C5o42238F5nGmf267ZXWN5KwaSB
         wIJ5DemGJ5mVW8jyhkVK4MnwTVqYG2JW8CNJCVmFQZT4Yp90aZIWyzlVr3FKfgtyNBbX
         AbT+6Mh+lnXFn24Pjh5rDGupjhihaVtRqCyXOrG4WfvEJ46i1KP+f6qPyhOQTW1Hz5+2
         gOB+JttxK5Hk7ntOzMmrwYfjVQr809tN1/xVsmnlZj4r8w8MEJSTKV76gcYy79wXP7I4
         dDVg==
X-Gm-Message-State: AOAM532brAiAlyyh9OUVmvAd5OsQ324rzX9as3fLaYvV344eD/Yl7bN+
        bkuYgcB93BQIqH9kbaLAddA=
X-Google-Smtp-Source: ABdhPJwzBOGmnpoUbHW+VZBWNC4IQ7EVl0xzVd2oXnxyijuXxiB3uZqcUW9/9PFrZ1mrsGCdoxxwjA==
X-Received: by 2002:a63:3d8c:: with SMTP id k134mr208828pga.394.1632324517574;
        Wed, 22 Sep 2021 08:28:37 -0700 (PDT)
Received: from edumazet1.svl.corp.google.com ([2620:15c:2c4:201:9ca8:a7b7:b32f:a7fb])
        by smtp.gmail.com with ESMTPSA id b17sm3178446pgl.61.2021.09.22.08.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 08:28:37 -0700 (PDT)
From:   Eric Dumazet <eric.dumazet@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH] mm: do not acquire zone lock in is_free_buddy_page()
Date:   Wed, 22 Sep 2021 08:28:33 -0700
Message-Id: <20210922152833.4023972-1-eric.dumazet@gmail.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

Grabbing zone lock in is_free_buddy_page() gives a wrong sense of safety,
and has potential performance implications when zone is experiencing
lock contention.

In any case, if a caller needs a stable result, it should grab zone
lock before calling this function.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Hugh Dickins <hughd@google.com>
---
 mm/page_alloc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e115e21524739341d409b28379942241ed403060..cd8a72372b047e55c4cde80fe6b7a428d7721027 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -9354,21 +9354,21 @@ void __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
 }
 #endif
 
+/*
+ * This function returns a stable result only if called under zone lock.
+ */
 bool is_free_buddy_page(struct page *page)
 {
-	struct zone *zone = page_zone(page);
 	unsigned long pfn = page_to_pfn(page);
-	unsigned long flags;
 	unsigned int order;
 
-	spin_lock_irqsave(&zone->lock, flags);
 	for (order = 0; order < MAX_ORDER; order++) {
 		struct page *page_head = page - (pfn & ((1 << order) - 1));
 
-		if (PageBuddy(page_head) && buddy_order(page_head) >= order)
+		if (PageBuddy(page_head) &&
+		    buddy_order_unsafe(page_head) >= order)
 			break;
 	}
-	spin_unlock_irqrestore(&zone->lock, flags);
 
 	return order < MAX_ORDER;
 }
-- 
2.33.0.464.g1972c5931b-goog

