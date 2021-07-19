Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771C83CECD0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381326AbhGSRiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 13:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352237AbhGSQB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 12:01:27 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CEDC076741
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 08:52:23 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id r18-20020adfce920000b029013bbfb19640so8932573wrn.17
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 09:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=feVKBadnlv5HmZyKh3LYcmKfEyHeKjcrialc9HWN4XY=;
        b=IKjUVCJ2VPBwD5hRxxGra1Tpa9UOCcXRHB34fy/06eNrYIRZDjL5DqXnYwhC3UB8LH
         s+4aLRjWlqNXgZ94qMZljQIrMCuUi1fKaahaTrBNRw99j9RzHOT9tlr5MMGr/bFX48im
         hoW7+uLcVzMq7QKjQTi7SSdLd6/+JENULRDmxnK7Flz1KELDk6YxZ72lUCBbY07fS5NP
         co1vL9spgsVObEli7xXbUYOoQBu7SpkEUDYz2lSwlL6OdHShDF6cL9iTNkDjsOZpl6R3
         G7GcThq/Sbrh0JrwmBsMNE0nTBjUkQeNZl2zQNpJvqyGQW6yFZEKSko/0X/GQW2TxfsB
         Epig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=feVKBadnlv5HmZyKh3LYcmKfEyHeKjcrialc9HWN4XY=;
        b=AP/5CG1BNrC41tOxRdm3hDpJfqirCMd2dOJJpml629M9QddvT+FdlDZtgWOI8muhPr
         RKcSBBOy5pbZ2earMndtQHNmyrntkLnor2u8j80iFRc56q/4LPnW7NZioQn/UmsitmaI
         ZXpsL8kK9us6DvLuzM97ECRG7wAT0gG24QenqIBC7FwEbPUvt46RHWHEo3h5706HxrHW
         cY/bC2JlopAPOnFacU1rEkKAaFXWwS8xePv83oUYNZeQlBWI9odaItup06zc2RsbmvB2
         MRI+osiUYeL+vfCH02JSSEGBxoWBgBwfW938ciNFRPBiNv2CLx7oO2e58FN7usBMh43q
         HcOg==
X-Gm-Message-State: AOAM5339Ufc4D/gEuddWVrib+/4y63n7rYZIWZEh4JZ4fyUikkR/YSDF
        3Nehzg/zxKf9CRDdXXWm8vaYXsod9b/M
X-Google-Smtp-Source: ABdhPJzkyt6qm3tQ2oXgsoU473i8FAMR54DBw3KFQJfZyO/gpCBb3yKqKKNIuV7eayW9Spkfqdb/Qjm0TXlc
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:83e0:11ac:c870:2b97])
 (user=qperret job=sendgmr) by 2002:a05:600c:4285:: with SMTP id
 v5mr13491671wmc.189.1626711420668; Mon, 19 Jul 2021 09:17:00 -0700 (PDT)
Date:   Mon, 19 Jul 2021 17:16:55 +0100
In-Reply-To: <20210719161656.3833943-1-qperret@google.com>
Message-Id: <20210719161656.3833943-2-qperret@google.com>
Mime-Version: 1.0
References: <20210719161656.3833943-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH v4 1/2] sched: Fix UCLAMP_FLAG_IDLE setting
From:   Quentin Perret <qperret@google.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qais.yousef@arm.com, rickyiu@google.com,
        wvw@google.com, patrick.bellasi@matbug.net, xuewen.yan94@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UCLAMP_FLAG_IDLE flag is set on a runqueue when dequeueing the last
active task to maintain the last uclamp.max and prevent blocked util
from suddenly becoming visible.

However, there is an asymmetry in how the flag is set and cleared which
can lead to having the flag set whilst there are active tasks on the rq.
Specifically, the flag is cleared in the uclamp_rq_inc() path, which is
called at enqueue time, but set in uclamp_rq_dec_id() which is called
both when dequeueing a task _and_ in the update_uclamp_active() path. As
a result, when both uclamp_rq_{dec,ind}_id() are called from
update_uclamp_active(), the flag ends up being set but not cleared,
hence leaving the runqueue in a broken state.

Fix this by clearing the flag in update_uclamp_active() as well.

Fixes: e496187da710 ("sched/uclamp: Enforce last task's UCLAMP_MAX")
Reported-by: Rick Yiu <rickyiu@google.com>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 kernel/sched/core.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cf16f8fda9a6..e801d2c3077b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1619,6 +1619,23 @@ static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
 		uclamp_rq_dec_id(rq, p, clamp_id);
 }
 
+static inline void uclamp_rq_reinc_id(struct rq *rq, struct task_struct *p,
+				      enum uclamp_id clamp_id)
+{
+	if (!p->uclamp[clamp_id].active)
+		return;
+
+	uclamp_rq_dec_id(rq, p, clamp_id);
+	uclamp_rq_inc_id(rq, p, clamp_id);
+
+	/*
+	 * Make sure to clear the idle flag if we've transiently reached 0
+	 * active tasks on rq.
+	 */
+	if (clamp_id == UCLAMP_MAX && (rq->uclamp_flags & UCLAMP_FLAG_IDLE))
+		rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
+}
+
 static inline void
 uclamp_update_active(struct task_struct *p)
 {
@@ -1642,12 +1659,8 @@ uclamp_update_active(struct task_struct *p)
 	 * affecting a valid clamp bucket, the next time it's enqueued,
 	 * it will already see the updated clamp bucket value.
 	 */
-	for_each_clamp_id(clamp_id) {
-		if (p->uclamp[clamp_id].active) {
-			uclamp_rq_dec_id(rq, p, clamp_id);
-			uclamp_rq_inc_id(rq, p, clamp_id);
-		}
-	}
+	for_each_clamp_id(clamp_id)
+		uclamp_rq_reinc_id(rq, p, clamp_id);
 
 	task_rq_unlock(rq, p, &rf);
 }
-- 
2.32.0.402.g57bb445576-goog

