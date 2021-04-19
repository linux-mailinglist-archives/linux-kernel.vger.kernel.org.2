Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F857363E04
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 10:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238458AbhDSIvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 04:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238433AbhDSIv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 04:51:29 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE9CC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 01:50:59 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id a16-20020a05620a02f0b02902dfd77467bfso4191708qko.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 01:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1R4Jr4Y0fNVqtFmGdn7fmPgc472QE3HJBlQ1cDdhzt4=;
        b=TMBkauBIAfAP9XjeDFGJnDsoFke73tSPJe4f2mEkud+WWPz6Mmq/1Nmg9lVrWBd39+
         wVZW66TOGiC/4Ki0pXPQjVxoAR3nGwKHALc1Ct9l34Kt0v1OvcKspHmEYuiTNhUHlDoc
         GdRPD0UYmpqr3hdeh3FftJau7nFiZGQrtf6jjq7py7gEI0eNQZCPn4wYZcki74Z99Jqu
         I2rECNJ42gZOOteD2/QXjDdO2WkkqubnFqYsY3bVuIb8W90FgIa4Pxxd5Bue+mLBI+yq
         JAaaAr30YToUOB+CPUGwKJ9GaqomjYg3czrf7Zu+35YAkKMEoWrKlDLTIVYnKeDKZQPK
         sgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1R4Jr4Y0fNVqtFmGdn7fmPgc472QE3HJBlQ1cDdhzt4=;
        b=VsBN3QAnceVQg+m1GNBLT7P/1ucjs2cilxwLu31yqxsyVjyuASkTW6DMg5JYKOddhk
         gcFLQOjwjO4s35/IrPmAHuGc1RiSKx7ycF+HlyOn9VRQuQIDpAwNDpHcvgG4nxbID5Uj
         P76lS1PI/6mHXsHMZXafMLhOBRa5f+DA2d+6acNoes0fMwAyC4mLeL6PkKmdHTDJzmG0
         hzqBDRG7CDYl1W6IzEG39vboOanekF0qhyfZNEuGj9xJZXo3Hh8Y+kS5d4Cb0MOPGnBd
         qLijBVYoT/gGFz2L/sPDjxnUMx0JHL8EibbDH+bjwEvPqPDJOEGP7+0pZ+AsZ0J+yaoa
         JKyg==
X-Gm-Message-State: AOAM531Je6sfGsSPmgmJ5T5qDvc622xPK5Bx18yLSTeG/Asdm4rAM0s/
        gYlRH/pAnFOxm3s+LnalfUFtrGFJ8Q==
X-Google-Smtp-Source: ABdhPJyfu1Y3YRhkFKwn8cRYHRc0nLt0o6kvgfbB8Wf5OVUUnfByumSzTxb1FCZL47h5AmiWMHIJhPJIaA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:92f8:c03b:1448:ada5])
 (user=elver job=sendgmr) by 2002:a0c:a98d:: with SMTP id a13mr4682439qvb.39.1618822258947;
 Mon, 19 Apr 2021 01:50:58 -0700 (PDT)
Date:   Mon, 19 Apr 2021 10:50:26 +0200
In-Reply-To: <20210419085027.761150-1-elver@google.com>
Message-Id: <20210419085027.761150-3-elver@google.com>
Mime-Version: 1.0
References: <20210419085027.761150-1-elver@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH 2/3] kfence: maximize allocation wait timeout duration
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org
Cc:     glider@google.com, dvyukov@google.com, jannh@google.com,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kasan-dev@googlegroups.com
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
index 5f0a56041549..73e7b621fb36 100644
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
@@ -626,7 +627,16 @@ static void toggle_allocation_gate(struct work_struct *work)
 
 	WRITE_ONCE(kfence_timer_waiting, true);
 	smp_mb(); /* See comment in __kfence_alloc(). */
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
 	smp_store_release(&kfence_timer_waiting, false); /* Order after wait_event(). */
 
 	/* Disable static key and reset timer. */
-- 
2.31.1.368.gbe11c130af-goog

