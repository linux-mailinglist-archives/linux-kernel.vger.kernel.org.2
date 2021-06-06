Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6243739CCBF
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 06:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhFFEXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 00:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhFFEW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 00:22:57 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E435C061766
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jun 2021 21:20:47 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id t9so11212407pgn.4
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 21:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E4PDzC/R73bE9jPmJKcYh4JETGcn02NCjNur7gAoAsk=;
        b=fB4EWvy1rcDvM7ghU3WRKdvbePGOPcvHIjMaCEtn1Zu+WkeXvm8PXy2FyruDsQvyM3
         ngxu/2Pc+Ql2SCvK4f3UPtOJKV1AjNAF3hI/r+EEQIWA8hXGtBCCTCKJCQCCeq3KwZJ3
         479Mp2I+1RFX38NkSGi8k1ir8ZHaChbkvSxlNClGelMdhlIroGg7SCafvUmDExWTgML8
         /tvegABjp+XvYkU4P0Zqprn45CvgHzO5rc+mxQ2R66V5J7afGwlpQOcuEC0AwWPZjwX/
         ppGKc/bczHseBCsT/7ZD8jO5JkQ7Wu+Pc+fqz4WhC4zvw/0YE06KJXTnI8zgO8Bo9Za4
         Z+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E4PDzC/R73bE9jPmJKcYh4JETGcn02NCjNur7gAoAsk=;
        b=dWoamvUx6RLh77Fvfc0Nl2aO0oP2kFNx/bWDE17rVtnE586oLr3oUqlPy8XJ2pdHZ0
         tLp0ZveNGDTqw8XrvIBIKq51PDCRLWjh63J9eObDNjXsrwhNzhBMh/nE8Ij3C8IJxVD/
         k9A99dJkYVVq655IHG3g1DqnyfTNjwdguiyL8HHk1z8AA5aRlA1ik5RIFgL9NI/YtP8Z
         mrY4XKIH8s0rv6nSNk+33aslaoyz/+ZuO01+yihLk6EkMUDwqPAefDw2rzvSq/usmuAU
         96L7vRQU0WpS4R6GOrqrVqLHJV0IFpyTqSpj8D5cdfMPqJghRPvFK6r73DfVYZPdAZiN
         UNBg==
X-Gm-Message-State: AOAM530hN4pZPgH0JFs6StLJf33uM/uMB0ibj6OhyoOrQfXTJNg98+nh
        3zTq3BSu6ROlTNNL19Lycfhgdw==
X-Google-Smtp-Source: ABdhPJzEVgIYny9BhJRituSgtwy850EhnqB+7PDC4mlCuzvNz8weefC/oB/79N77nRKsFuC3d4Blsw==
X-Received: by 2002:a63:b30a:: with SMTP id i10mr12176783pgf.306.1622953243374;
        Sat, 05 Jun 2021 21:20:43 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id y4sm4817527pfg.112.2021.06.05.21.20.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jun 2021 21:20:43 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: slub: replace local_irq_save with local_irq_disable
Date:   Sun,  6 Jun 2021 12:17:50 +0800
Message-Id: <20210606041750.69403-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The caller of slub_cpu_dead cannot be irq disabled (because slab_mutex is
holding during the processing), there is no need to use irq_save. Just use
irq_disable directly.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/slub.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index ee51857d8e9b..fbf592ef14ff 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2529,13 +2529,12 @@ static void flush_all(struct kmem_cache *s)
 static int slub_cpu_dead(unsigned int cpu)
 {
 	struct kmem_cache *s;
-	unsigned long flags;
 
 	mutex_lock(&slab_mutex);
 	list_for_each_entry(s, &slab_caches, list) {
-		local_irq_save(flags);
+		local_irq_disable();
 		__flush_cpu_slab(s, cpu);
-		local_irq_restore(flags);
+		local_irq_enable();
 	}
 	mutex_unlock(&slab_mutex);
 	return 0;
-- 
2.11.0

