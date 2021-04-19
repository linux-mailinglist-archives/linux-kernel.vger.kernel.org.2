Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B10B363E05
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 10:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238475AbhDSIvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 04:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238462AbhDSIvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 04:51:33 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE64BC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 01:51:02 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id n67-20020a1c59460000b0290114d1a03f5bso5141631wmb.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 01:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=p3g1jw5/hGDj5wABho0AViDXSgtC45K4NGeFzanUCY4=;
        b=i3pEmtzl9Y9yr4qP/FhB0UAxWQWx/TnwZWDJLCOZjiYThK2wDLH3szcJMq2jBHWGJx
         8lFlpz7eCUTbgNuCkNQ/hQMlCZlFckio/wKwBGDbzGmVMwZfhRiNgrp6fhGIvchgW4CT
         XgW3GA3rjsfNWlg9Ak/qghjRMZzJTTPTZLC15L+71r2yQ3d3x1dJieJjnmrHUfKPvHNj
         80c1OeguGlK61udIO/VqiVdPCwrOzA1MVB00mGpwxLMHiPLokUL6rHh3h8K54EZ+5jQV
         Xj4CaPbXrHqInHKQL3DbmVxUm4bBEvj4y0mZRN14HGYW1CSp8X4Tf/Z/yJ7JMQNTcAoS
         9EFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=p3g1jw5/hGDj5wABho0AViDXSgtC45K4NGeFzanUCY4=;
        b=EbujYjf6XpxSNDBT4wlfef6Rf+ub+kbLWLVf2lwVXQ02zn/HpLNT1YkEr7VcUVLoFE
         LhmBDu7emS/GhdQl6KOBkSsJSe8kCFGIgALJvzZbjt5EH9xU5OL0Mv1xLQ9r6oUTFbnt
         Q8y/dfiuDy1zI9Lj2UrMp0O1Bxql77Zda1GHAW2gtscj9DEOn+pdF050MQdYCbnZuK1n
         wmaBb5Py2qTBUb2UcAZmJMFJ2orvS/w7iFQupiOuhlPVUrrSXDNZk+iMpMJk+dLxXSiq
         KddC9xj/2azdjB1qnt00sz98gzlHQhSfTX4pse+O78/jVid03Meedyb7PK0u9XZcKw7m
         Rgzg==
X-Gm-Message-State: AOAM532Q9KDrK7Z1zfhpfgtbEOUfo9RAtZF4b/2vcWqpYG/UlSDrRVxK
        EDx1jB/BS3R4t1o6VH2ap2VxftpCkg==
X-Google-Smtp-Source: ABdhPJw7p0IZNRzHEhoYVbNtBdDWX3bV3Cz4INszTsP30Q+/zUXpsgM1fhE69590WodfIcGOTAxlKDhPmw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:92f8:c03b:1448:ada5])
 (user=elver job=sendgmr) by 2002:a1c:4d0e:: with SMTP id o14mr20041525wmh.141.1618822261465;
 Mon, 19 Apr 2021 01:51:01 -0700 (PDT)
Date:   Mon, 19 Apr 2021 10:50:27 +0200
In-Reply-To: <20210419085027.761150-1-elver@google.com>
Message-Id: <20210419085027.761150-4-elver@google.com>
Mime-Version: 1.0
References: <20210419085027.761150-1-elver@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH 3/3] kfence: use power-efficient work queue to run delayed work
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org
Cc:     glider@google.com, dvyukov@google.com, jannh@google.com,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the power-efficient work queue, to avoid the pathological case where
we keep pinning ourselves on the same possibly idle CPU on systems that
want to be power-efficient [1].
[1] https://lwn.net/Articles/731052/

Signed-off-by: Marco Elver <elver@google.com>
---
 mm/kfence/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 73e7b621fb36..7e20cd9690a2 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -642,7 +642,8 @@ static void toggle_allocation_gate(struct work_struct *work)
 	/* Disable static key and reset timer. */
 	static_branch_disable(&kfence_allocation_key);
 #endif
-	schedule_delayed_work(&kfence_timer, msecs_to_jiffies(kfence_sample_interval));
+	queue_delayed_work(system_power_efficient_wq, &kfence_timer,
+			   msecs_to_jiffies(kfence_sample_interval));
 }
 static DECLARE_DELAYED_WORK(kfence_timer, toggle_allocation_gate);
 
@@ -671,7 +672,7 @@ void __init kfence_init(void)
 	}
 
 	WRITE_ONCE(kfence_enabled, true);
-	schedule_delayed_work(&kfence_timer, 0);
+	queue_delayed_work(system_power_efficient_wq, &kfence_timer, 0);
 	pr_info("initialized - using %lu bytes for %d objects at 0x%p-0x%p\n", KFENCE_POOL_SIZE,
 		CONFIG_KFENCE_NUM_OBJECTS, (void *)__kfence_pool,
 		(void *)(__kfence_pool + KFENCE_POOL_SIZE));
-- 
2.31.1.368.gbe11c130af-goog

