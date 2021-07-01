Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53CDE3B9557
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 19:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbhGARVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 13:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhGARVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 13:21:17 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A93C061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 10:18:45 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u8so9173245wrq.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 10:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ZjbYHcTVSHQtbbwfJxfmq7wLQhURDlEsagZ7G5mEEw8=;
        b=QOntgaZBzm35HQoxrL0Hlu6Za5AbHLosR4q6dIUJahIj+XKH0wicCeLSFIERG895Tn
         afY4J4zLSH7uf75hshcMEeAHkb4SKSDqPtemdFT6anhOv0NEeJAaZUPB1xR29dGPjnZ7
         mIHTgo9qtN/gMXxS1efKuHFTrENQMyZz4DPbi9452kNkge7jYkpsuOAeXkFvflA8DQMZ
         aZS19Efgm8AayM9jcaaBYaRVWaJyyb/WQtPcR4yVBBKz76zStqv/8MRPB15w6p8HGuua
         +qMzW6A/GMnkx7k8SSydoNKFTMyXlKQ06jbEMcyUMfHIJdOt190yLNHZD9T1NXQThRqT
         faGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZjbYHcTVSHQtbbwfJxfmq7wLQhURDlEsagZ7G5mEEw8=;
        b=cohQbuxwAK0MusvzcnfH7ZeuFF/rWLYBQ8FkvXdgmpCMxqNzrZhOITlZWrY/4Bq6JT
         VTGZt67ZucyT8H+b6rtcR+pl18aQAs4kW2tZgyUB/6cmKsPV+oaDSOCZXruXwhByj1Kd
         4mdn+ljIF+hyy2ILID9tK3/DrvnazZNV087Br0cFf9i0UmAUVwk4LxSpDZDO95NlXllA
         VHqLOYREluKFkGWtcQpWbHaXnfXsXBp/y83unns/vY4SgfqIqYX5M54R9yjCmt7BKiOO
         dvXmALoflL3Y0UpjaELWtupTYgbzqY2G8zuk2uvSENUHwNYje7f60tL1JhotN05Vf9nv
         VQCg==
X-Gm-Message-State: AOAM53366S++qxg1XrRsvqZa7T+8NPTHhmKPK1fb4PomQmt5WUvV7Y0I
        Z+VHEh/++YKtsLPavIyTtF8Gjw==
X-Google-Smtp-Source: ABdhPJzpCsMYhenI42CSvHZgnuQ1REmnRM16tprVCQMadEdgKEPMztYXplKST1/ta5VUf50Sc1mxAA==
X-Received: by 2002:adf:cf09:: with SMTP id o9mr306168wrj.40.1625159924385;
        Thu, 01 Jul 2021 10:18:44 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:613c:1766:3718:552d])
        by smtp.gmail.com with ESMTPSA id u15sm10021828wmq.48.2021.07.01.10.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 10:18:43 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        odin@uged.al, sachinp@linux.vnet.ibm.com
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/fair: Sync load_sum with load_avg after dequeue
Date:   Thu,  1 Jul 2021 19:18:37 +0200
Message-Id: <20210701171837.32156-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 9e077b52d86a ("sched/pelt: Check that *_avg are null when *_sum are")
reported some inconsitencies between *_avg and *_sum.

commit 1c35b07e6d39 ("sched/fair: Ensure _sum and _avg values stay consistent")
fixed some but one remains when dequeuing load.

sync the cfs's load_sum with its load_avg after dequeuing the load of a
sched_entity.

Fixes: 9e077b52d86a ("sched/pelt: Check that *_avg are null when *_sum are")
Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

I have been able to trigger a WARN on my system even with the patch
listed above. This patch fixes it.
Sachin could you test that it also fixes yours ?

kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 11d22943753f..48fc7dfc2f66 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3037,8 +3037,9 @@ enqueue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 static inline void
 dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+	u32 divider = get_pelt_divider(&se->avg);
 	sub_positive(&cfs_rq->avg.load_avg, se->avg.load_avg);
-	sub_positive(&cfs_rq->avg.load_sum, se_weight(se) * se->avg.load_sum);
+	cfs_rq->avg.load_sum = cfs_rq->avg.load_avg * divider;
 }
 #else
 static inline void
-- 
2.17.1

