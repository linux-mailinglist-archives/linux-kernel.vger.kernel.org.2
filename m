Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2700C366981
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 12:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237138AbhDUKwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 06:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236099AbhDUKwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 06:52:47 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0058EC06138A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 03:52:09 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id 91-20020adf92e40000b029010470a9ebc4so11392502wrn.14
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 03:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=958qgNOMMQHBKiudXbOhYcKipML0hl7ML/vSp0CTCqA=;
        b=e4RwU/x5IzvdYtTruaVeAg8cfueMN5BJshXP8pv9Q+HnHtMBceFhACbcGE3soTOgpc
         trfZnV8dj77WSwGo0mkof3682PcrXAe+cVxI+/m2NWIC1pub3IEPhtD1qmNQ7jjfPkCS
         T76lyZLUX2V04rWtEHo/QifvHBRgKzwvNsL0sd4zjsNvAmOr+HvyE1kX/KeinDOfBIgx
         ENPqRwZKBIE0UTLq9iWBGJje4ZMwFlI1DZog/3pA2vE55gaIkzs+mmQ196mp8PYqEcfq
         2/b/UCfHKASERuiv1Os5WDJ1UVqNfafFoz+HPmG/8SG6cvVkPY8Ixp0S0ando9EZoGua
         Bg8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=958qgNOMMQHBKiudXbOhYcKipML0hl7ML/vSp0CTCqA=;
        b=l72/6K+3QyQtTtwhVS+L4r28zVbuDjIuyp3Xntg5t8A5iuX3ixQrQj+f7bEZZmFwYG
         DvZl3he3gTgjABlFGULcrXRAVxMgcP8xYqszZsFr5JhyJr0uRVnOGy5xGHwotde/fjRe
         m8NgEHqpT251Az/kkQqDSuv0qbyEHgNNdXlu3nkDvX7Vybjhva7vawIu7x7hM5oOKprL
         lmpjpNdxxD400tMUT0YPHFOWOztVpRFWO4XFceDQjcq1Wqpo4IgcAmL5+LnlrHNDupAi
         QAhhU5+Xjvra/8xm3quAnUY7eT/5WsPfsoF6z6hxheobmO+JbruKn/WLbdNl3+UKGDkC
         p78A==
X-Gm-Message-State: AOAM531KbYpBrTSYDW03TVmjMi0VsOd7s8rrzyL3SdkPkA6TtCZPcqBQ
        qwr7N7XSVVmQnLfsFhVCI4TQWZuFBQ==
X-Google-Smtp-Source: ABdhPJwBXkyuJWMZa2OUSRCCtP5kyDXU8thulTzdIfrwDxtxhQDYmMHY0T5AhyrTNdE1RBS4CvoHbhoO6A==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:c552:ee7c:6a14:80cc])
 (user=elver job=sendgmr) by 2002:a05:600c:4fd4:: with SMTP id
 o20mr9476694wmq.166.1619002328581; Wed, 21 Apr 2021 03:52:08 -0700 (PDT)
Date:   Wed, 21 Apr 2021 12:51:32 +0200
In-Reply-To: <20210421105132.3965998-1-elver@google.com>
Message-Id: <20210421105132.3965998-4-elver@google.com>
Mime-Version: 1.0
References: <20210421105132.3965998-1-elver@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH v2 3/3] kfence: use power-efficient work queue to run delayed work
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org
Cc:     glider@google.com, dvyukov@google.com, jannh@google.com,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kasan-dev@googlegroups.com, hdanton@sina.com
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
index 9742649f3f88..e18fbbd5d9b4 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -636,7 +636,8 @@ static void toggle_allocation_gate(struct work_struct *work)
 	/* Disable static key and reset timer. */
 	static_branch_disable(&kfence_allocation_key);
 #endif
-	schedule_delayed_work(&kfence_timer, msecs_to_jiffies(kfence_sample_interval));
+	queue_delayed_work(system_power_efficient_wq, &kfence_timer,
+			   msecs_to_jiffies(kfence_sample_interval));
 }
 static DECLARE_DELAYED_WORK(kfence_timer, toggle_allocation_gate);
 
@@ -665,7 +666,7 @@ void __init kfence_init(void)
 	}
 
 	WRITE_ONCE(kfence_enabled, true);
-	schedule_delayed_work(&kfence_timer, 0);
+	queue_delayed_work(system_power_efficient_wq, &kfence_timer, 0);
 	pr_info("initialized - using %lu bytes for %d objects at 0x%p-0x%p\n", KFENCE_POOL_SIZE,
 		CONFIG_KFENCE_NUM_OBJECTS, (void *)__kfence_pool,
 		(void *)(__kfence_pool + KFENCE_POOL_SIZE));
-- 
2.31.1.368.gbe11c130af-goog

