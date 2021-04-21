Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9C7366980
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 12:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236243AbhDUKws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 06:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236175AbhDUKwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 06:52:41 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9046EC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 03:52:06 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id bf25-20020a0564021a59b0290385169cebf8so7427403edb.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 03:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=S7gKkVqw6gJJUkQX3/NKZ5hEYF7HuP5mcybwHhcoGA8=;
        b=BKLqZcruEVs1tQhMgavhobMYH3pkurizK7K0prlTtT7UrKBFybRppZodySbtpHep4Q
         dahuNpp+xKHhDa+OyyRnw8e2sf/QI9FxUpG+uLlUXHrf2chSK+ctL7VnE3D26Z4yixzt
         aqrvmWwUE9nVzIqIDx963uaNsvyOloDReUzMky+nBXxdQBFjLZuyH05HxCwsqKB2cnQ3
         4mGy0+AnDgPt4VsmVV67b2DM0GvFf9qXOzs3jKk56lYF0E6l2UPZ9yg+vySmVVouOi+d
         ZcuQyL1tcho+GmMD5X26B1MJaXgBGDD2AkS/iWonncxyQv+YGdXrwBVcfiHto03hxFSk
         50Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=S7gKkVqw6gJJUkQX3/NKZ5hEYF7HuP5mcybwHhcoGA8=;
        b=jvPCh8OyaF9OYmfzGH5ehWFY8er49dLoUX0v/Iyj3R3uEmKEWu5PYLQEJLkzpCJ1Kw
         63sMwaFBSdvv3rcje3Z/yGRpmGR82AFvcsHe4a772rivqFjeVtOyeDs7uU0C+k0irU7z
         HMETdOI22JkEB4HhCrR/OwRIAjHg62vr22r0YySUOj0mnILRdA7gBZqPyHDLcaL3ZRFf
         WMlmO145JYZtLEwN94dWyVdPlOxQI537z5neJQ1sfKAJm3vWqUPq3edpctAOBCAWhLuA
         ZZfF5ndXnjpu7Bq4nwa/1yCCJgxXhjmDHz+usmU5RooRN1Pon8YskvZI92NwVmE19Pcw
         Xz9w==
X-Gm-Message-State: AOAM531B5HXRMpU8hfso0Cm7hhZhnvfb1TwWJxQ7e6VhlhQO41NhSYho
        NQCvWoLASOlv0/jvzEAPpBeSrmQsUg==
X-Google-Smtp-Source: ABdhPJyjCmPDiQcNUfvf1eIuCw4ql8YdC3rYLPuX10VxgctCoYcEuZQUMCVPDf2UQQgpokCHE10ey+Upqw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:c552:ee7c:6a14:80cc])
 (user=elver job=sendgmr) by 2002:a17:906:3d41:: with SMTP id
 q1mr31542346ejf.282.1619002325029; Wed, 21 Apr 2021 03:52:05 -0700 (PDT)
Date:   Wed, 21 Apr 2021 12:51:31 +0200
In-Reply-To: <20210421105132.3965998-1-elver@google.com>
Message-Id: <20210421105132.3965998-3-elver@google.com>
Mime-Version: 1.0
References: <20210421105132.3965998-1-elver@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH v2 2/3] kfence: maximize allocation wait timeout duration
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org
Cc:     glider@google.com, dvyukov@google.com, jannh@google.com,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kasan-dev@googlegroups.com, hdanton@sina.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The allocation wait timeout was initially added because of warnings due
to CONFIG_DETECT_HUNG_TASK=y [1]. While the 1 sec timeout is sufficient
to resolve the warnings (given the hung task timeout must be 1 sec or
larger) it may cause unnecessary wake-ups if the system is idle.
[1] https://lkml.kernel.org/r/CADYN=9J0DQhizAGB0-jz4HOBBh+05kMBXb4c0cXMS7Qi5NAJiw@mail.gmail.com

Fix it by computing the timeout duration in terms of the current
sysctl_hung_task_timeout_secs value.

Signed-off-by: Marco Elver <elver@google.com>
---
 mm/kfence/core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 235d726f88bc..9742649f3f88 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -20,6 +20,7 @@
 #include <linux/moduleparam.h>
 #include <linux/random.h>
 #include <linux/rcupdate.h>
+#include <linux/sched/sysctl.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -621,7 +622,16 @@ static void toggle_allocation_gate(struct work_struct *work)
 	/* Enable static key, and await allocation to happen. */
 	static_branch_enable(&kfence_allocation_key);
 
-	wait_event_timeout(allocation_wait, atomic_read(&kfence_allocation_gate), HZ);
+	if (sysctl_hung_task_timeout_secs) {
+		/*
+		 * During low activity with no allocations we might wait a
+		 * while; let's avoid the hung task warning.
+		 */
+		wait_event_timeout(allocation_wait, atomic_read(&kfence_allocation_gate),
+				   sysctl_hung_task_timeout_secs * HZ / 2);
+	} else {
+		wait_event(allocation_wait, atomic_read(&kfence_allocation_gate));
+	}
 
 	/* Disable static key and reset timer. */
 	static_branch_disable(&kfence_allocation_key);
-- 
2.31.1.368.gbe11c130af-goog

