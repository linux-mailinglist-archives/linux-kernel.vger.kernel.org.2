Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22BB43CF56F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 09:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbhGTHCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 03:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbhGTHCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 03:02:40 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09D9C061766
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 00:43:15 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id x13-20020a17090a46cdb0290175cf22899cso1972663pjg.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 00:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2RbqEZiSX0zvCsFSti0Yf2rZCpDWl6bafaeM5yD8kWg=;
        b=F5TizzOVyuUWukuBy50Pzl3IBoCLaNbweMj41op+sKYZz1UA1gk7ORcJSm6Tgb4O5b
         teQYFTNRS5ugXJMrD2QxvILumNQCRyb4BRchqVB5mD1lNTLxLDW3g3wTYj2nfB6r6ab3
         fZ42rDMP42/nvHHnIib9dwgSoiSRGD/Wf6NFcSvh1h+iSx+zkQWnwm/dVZXrjXV8G7kG
         iv/ceUrEzq4frV36qm61WUPCGPxj7Z7Jj1iX0lMvP+H+XDLrI41PFp92dspI1B+BO1Ci
         b8U5B64i5en12UNolDEKlAC3BpMqQ4ksOqxW4BbOkpPFAwzEi0vkGNIO/5mYE+9pWKDH
         9sMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2RbqEZiSX0zvCsFSti0Yf2rZCpDWl6bafaeM5yD8kWg=;
        b=dgozY71ALeNgop1J5AcABRvi81exwE37sn3rrP8gq1ak32kbq0tth2/IZZsZxy+GzF
         +8lp+z3FNqp7xV5ZZCN+ZixIo7dkqppz8fbaCRNzyXxGyNZIta93G5/+QLbFC6D75CNT
         CFQtctWQ6ZxfSag0V6glmu/brBKbAK9pokctGb+IPdvJTdsKD5Oi2Y/3h6Wmw1514R0B
         aMPDa4GETXJ+x4AAVzwr0sSWU7ce6JjHsVdM3SeabC3NgL+ziwElKkAodtvwypP0bv5y
         dIEgvcM7xYDQgXXn8sueteZ6OJdOJPj5YbQNDaszMY02zNh9n+UfPJ3luwYvr3BKSzai
         mQxQ==
X-Gm-Message-State: AOAM530I0/nEL1y43iba082whz9bxdfEkZLe3eg5OP08BdeKWhADK5Cl
        vcxLGiZncIZQunRAE/VrIe9Iqw==
X-Google-Smtp-Source: ABdhPJyqls0EZ62wnwCkV7V/qwtCLnrwr6TDsvBPWB0tyUZZ1kOvpthnLenpcx9ICAOtryy6saU1/A==
X-Received: by 2002:a17:90a:62ca:: with SMTP id k10mr27871740pjs.133.1626766995375;
        Tue, 20 Jul 2021 00:43:15 -0700 (PDT)
Received: from localhost.localdomain ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id c2sm24214505pgh.82.2021.07.20.00.43.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jul 2021 00:43:14 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        shy828301@gmail.com, cuibixuan@huawei.com, vbabka@suse.cz
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: mmap_lock: fix disabling preemption directly
Date:   Tue, 20 Jul 2021 15:42:28 +0800
Message-Id: <20210720074228.76342-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 832b50725373 ("mm: mmap_lock: use local locks instead of
disabling preemption") fix a bug by using local locks. But commit
d01079f3d0c0 ("mm/mmap_lock: remove dead code for !CONFIG_TRACING
configurations") changes those lines to original version. I guess
it is introduced by the conflicts fixing on merging.

Fixes: d01079f3d0c0 ("mm/mmap_lock: remove dead code for !CONFIG_TRACING configurations")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/mmap_lock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
index f5852a058ce0..1854850b4b89 100644
--- a/mm/mmap_lock.c
+++ b/mm/mmap_lock.c
@@ -156,14 +156,14 @@ static inline void put_memcg_path_buf(void)
 #define TRACE_MMAP_LOCK_EVENT(type, mm, ...)                                   \
 	do {                                                                   \
 		const char *memcg_path;                                        \
-		preempt_disable();                                             \
+		local_lock(&memcg_paths.lock);                                 \
 		memcg_path = get_mm_memcg_path(mm);                            \
 		trace_mmap_lock_##type(mm,                                     \
 				       memcg_path != NULL ? memcg_path : "",   \
 				       ##__VA_ARGS__);                         \
 		if (likely(memcg_path != NULL))                                \
 			put_memcg_path_buf();                                  \
-		preempt_enable();                                              \
+		local_unlock(&memcg_paths.lock);                               \
 	} while (0)
 
 #else /* !CONFIG_MEMCG */
-- 
2.11.0

