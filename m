Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63FA838C585
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 13:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbhEULSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 07:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhEULSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 07:18:02 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16BBC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 04:16:39 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id u9-20020a05620a4549b02902e956c2a3c8so15953877qkp.20
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 04:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+QJiicZEZmfMKgY/pq0Y5eLW/e6KZlrhFiiHdcX6gWY=;
        b=SjYh/4Oeno4AVQ0LwbsTcjYcJhcRTY8VWO6h6DlXv1OFswWLALLNIR/vEtKlhnEdPs
         MCNA5RMMnbZHlIANEoFDu9Pwx7BSo8eKYUy+1vV1vUIzqUegkp7vtXmPkueRrzloFTQg
         wVA/VTcVXcHnUSMW9y4DRGbNKo6HSxGmzfwzoL/yxa5YwNyd8IkkbjfrgArikfvvMCyD
         QrRekNbh+rZ7OhaUbrG12wGY22bY/466IoKcv/cQRtqbTD2aCiXx/is7OwXUirgi0AGg
         C4RFrAVAxl9uvLGbYGcNhWbfac1BXCTzaveSGd9yK8XxMuXxFlUZJ060JpZ1I1iN8vFg
         2hpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+QJiicZEZmfMKgY/pq0Y5eLW/e6KZlrhFiiHdcX6gWY=;
        b=iQ9d72kTBkCBytqx+GCqfbg5CbhNf5BMs8TMAFFgTeNsYtzE2Z1WGsiapVF8iDZluJ
         oNTApoSsMjnA9r3VWwZCT4x2xdnrDbWuc7WRf0PiSSXLg4c1KS91BEMSroQsNhgyMUs3
         j3csQTt8PXAxXKp80x3FQ6kgNu7YZWl/eGnQN3TnSFVTfxMGNZQNWHvUdw1a4uHz0MuY
         6hlLMIOzn9mTk2Ys4L51U2t/H7QD3lKBfOF/7SxSj7yDzOutT5jXMvSN+TxdCzBjlqOP
         Zq+pTLejqxUZL0lQS8c8PsHrPm++FwJjven3dOG2bHlUbb++uxeKhsxlLr/c924wHn6c
         wf1g==
X-Gm-Message-State: AOAM5310iLgjYZSadiXTVnFxqY3/TKLK7yAz3pwEJt3tesqyzF9pPRfX
        FInb/QPXHMES2o+Fux5HtKlNzht4DA==
X-Google-Smtp-Source: ABdhPJwhXZ66s93o3N9GuOPp1PuhXBp5f6gVrIaPsVNiGS/i/YTpzrfxUWA9DXyLPx2iWgJOArZQbbfPhg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:a932:cdd6:7230:17ba])
 (user=elver job=sendgmr) by 2002:a0c:ba0c:: with SMTP id w12mr11900436qvf.41.1621595798787;
 Fri, 21 May 2021 04:16:38 -0700 (PDT)
Date:   Fri, 21 May 2021 13:16:30 +0200
Message-Id: <20210521111630.472579-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH] kfence: unconditionally use unbound work queue
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org
Cc:     glider@google.com, dvyukov@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unconditionally use unbound work queue, and not just if
wq_power_efficient is true. Because if the system is idle, KFENCE may
wait, and by being run on the unbound work queue, we permit the
scheduler to make better scheduling decisions and not require pinning
KFENCE to the same CPU upon waking up.

Fixes: 36f0b35d0894 ("kfence: use power-efficient work queue to run delayed work")
Reported-by: Hillf Danton <hdanton@sina.com>
Signed-off-by: Marco Elver <elver@google.com>
---
 mm/kfence/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 4d21ac44d5d3..d7666ace9d2e 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -636,7 +636,7 @@ static void toggle_allocation_gate(struct work_struct *work)
 	/* Disable static key and reset timer. */
 	static_branch_disable(&kfence_allocation_key);
 #endif
-	queue_delayed_work(system_power_efficient_wq, &kfence_timer,
+	queue_delayed_work(system_unbound_wq, &kfence_timer,
 			   msecs_to_jiffies(kfence_sample_interval));
 }
 static DECLARE_DELAYED_WORK(kfence_timer, toggle_allocation_gate);
@@ -666,7 +666,7 @@ void __init kfence_init(void)
 	}
 
 	WRITE_ONCE(kfence_enabled, true);
-	queue_delayed_work(system_power_efficient_wq, &kfence_timer, 0);
+	queue_delayed_work(system_unbound_wq, &kfence_timer, 0);
 	pr_info("initialized - using %lu bytes for %d objects at 0x%p-0x%p\n", KFENCE_POOL_SIZE,
 		CONFIG_KFENCE_NUM_OBJECTS, (void *)__kfence_pool,
 		(void *)(__kfence_pool + KFENCE_POOL_SIZE));
-- 
2.31.1.818.g46aad6cb9e-goog

