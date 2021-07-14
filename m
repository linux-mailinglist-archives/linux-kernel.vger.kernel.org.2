Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544D93C8177
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 11:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238797AbhGNJZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 05:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238291AbhGNJZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 05:25:19 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E349C061760
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 02:22:28 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id h15-20020adffd4f0000b0290137e68ed637so1146555wrs.22
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 02:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Qyc6ohzjuGWO87gzL/Z+Is02vLbY2suPFPQ1nEFYzSU=;
        b=AgQnCrNOd7i5dBNRA+Pqzh0QH1Aavvx/jvqVMlgotATgmfiQ9tML534h2Yt0Wp6UVD
         dPCrTzqm3k828aTupcVUKNvi1boNjXELkbENaolWJCSx3FLNUG5vZY14y1N3UaxiQka5
         +q+oEgzkBkNs6xz8EJ6+xX00OSYkkSX47ur8ATJ2uzpAtZh4TbLoyw6PlDiOrEPI7ePs
         h3eyPY50SvRZx/kOkqepKO3iRLDAsYfLa6LAL+akoR+aYpsPu7dxAcRztxsEHgLOr6OL
         Zx1N3zurNs4uK7PulQxbL3PGcncwcgxZBhtst0DHt/kWg1ICnEil0BewSj5afs/vQH71
         JD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Qyc6ohzjuGWO87gzL/Z+Is02vLbY2suPFPQ1nEFYzSU=;
        b=RCCKUNdYCKIGATxxCzb6qFTpujfHVyjWTBEzOt5KvuFVES2tOGs5l2BemchiezdPuI
         ewxR+XMplO9XuznNDo2Mw4EZhZjnXumq6zyiyIzSWWIQEMtmXuIxHLptFBkS8ZzqPqlI
         hyZ/HJiZIhMsEbPS+9auyYyesIDMHdN3bGCkgJVfKAbnRSNf/VS+S4gbFyEpS5Aubfmv
         BbU55ph1obCVHS+0H4foMO+yS6Xa1r0Rdjb0sSnH1yhsD2N6+ZnG/OxPn98JNlyNmvMd
         FDp+IKErucnbS5wxak1oGmwMvrYPTtuEhrIUyp+IS/FGtOtNNcViv2KYIcEmyib/ZXlq
         rKlw==
X-Gm-Message-State: AOAM531Ir4p8BB2I5Y361IunkWuolfpyEVahLbBXngKp/LAlfFAr0NBs
        PwX5Ojt99OTXVHpofKvVfEmqKOi088w=
X-Google-Smtp-Source: ABdhPJzYuKhDVZIN8Rj3HEws6Yo8UjiKSv5LM81gKwrWyru/o3IaiXXaws7mE9L6DdcQ7W3fAYE05yBPxQ4=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:89ec:cd11:7e8b:63fe])
 (user=glider job=sendgmr) by 2002:a05:600c:2248:: with SMTP id
 a8mr2892376wmm.141.1626254546797; Wed, 14 Jul 2021 02:22:26 -0700 (PDT)
Date:   Wed, 14 Jul 2021 11:22:21 +0200
Message-Id: <20210714092222.1890268-1-glider@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH mm v5 1/2] kfence: move the size check to the beginning of __kfence_alloc()
From:   Alexander Potapenko <glider@google.com>
To:     akpm@linux-foundation.org
Cc:     dvyukov@google.com, elver@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, stable@vger.kernel.org,
        gregkh@linuxfoundation.org, jrdr.linux@gmail.com,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check the allocation size before toggling kfence_allocation_gate.
This way allocations that can't be served by KFENCE will not result in
waiting for another CONFIG_KFENCE_SAMPLE_INTERVAL without allocating
anything.

Suggested-by: Marco Elver <elver@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Marco Elver <elver@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org # 5.12+
Signed-off-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Marco Elver <elver@google.com>
---
 mm/kfence/core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index d7666ace9d2e4..2623ff401a104 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -733,6 +733,13 @@ void kfence_shutdown_cache(struct kmem_cache *s)
 
 void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
 {
+	/*
+	 * Perform size check before switching kfence_allocation_gate, so that
+	 * we don't disable KFENCE without making an allocation.
+	 */
+	if (size > PAGE_SIZE)
+		return NULL;
+
 	/*
 	 * allocation_gate only needs to become non-zero, so it doesn't make
 	 * sense to continue writing to it and pay the associated contention
@@ -757,9 +764,6 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
 	if (!READ_ONCE(kfence_enabled))
 		return NULL;
 
-	if (size > PAGE_SIZE)
-		return NULL;
-
 	return kfence_guarded_alloc(s, size, flags);
 }
 
-- 
2.32.0.93.g670b81a890-goog

