Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB3B3A2F16
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 17:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbhFJPP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 11:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbhFJPPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 11:15:23 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058A0C061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 08:13:18 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id v25-20020a1cf7190000b0290197a4be97b7so3099081wmh.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 08:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KjrvPKczD32pyYol7ZfAefwj3/shsdn1DI6kv805EQ4=;
        b=K/o2lTEqiXNNWGndUXFy1Pb6NlJFK+pFuMEmWSv7YiX8PKFJdAMHEzc6fWuGC4ds9k
         a+/dWAgiPnIFhDE7WhEO/xj1VGmAo/DQ+ytUwOJjdf+yaRRn/F7OO0QyZq6xqPWT7YP5
         4HEcawJ0JvFNx1WSEuEIPCBafbOYYyRhkDjgkOcZ2A58oTPtOqJGyMs8Pm0M0t5oBvf3
         ce8Y6BgR/tAH9fJzNdGH/gxADXojSWRM5gYPPf6gTqO3Ys4ePZOvu2Ut2GmQpycdE+wF
         u5hGtFhFlw2sByNkofsEuHRituDloLRLr/7rHYzevvP4lmg/Eczsn8yJMqmXXa0GfLeA
         +8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KjrvPKczD32pyYol7ZfAefwj3/shsdn1DI6kv805EQ4=;
        b=BQJ4uFEScYTtQwiOD7zUlhmz3p7wyjOCIkYFRElQpP7pdzN42NWuBLSZPtUSlBjl/D
         /OZsHEZ93q4MyRFdWvKPXDGWiqKMBfL1txfTyVc2SUDqKq/iMxALJsx++TJ6JlzZXy0k
         hFmBHaajsbc2C8b2UnFCP9vU8td+nKV8S6O4THh8FmY7kwzdXy9X0+Tti7+z4fQXRHMy
         VwTEcalMGdKsqAx/RQr8GGlkIoW9PIYmTKnR1I49MqLZvYREMCOLH6SWfjB10hOeF89c
         LCyuHnbT6YSaxeNLyv0q5r7xZ3RaqpliJhdihutjrTBo8pLTm5ca761JERsQCQ50NTqd
         92UQ==
X-Gm-Message-State: AOAM532IhkRy2pzL0YknT+4HD6iD00yk7t5i5dqmxW0Nl9M4YPPEWiWq
        Fs+IIozOZnATbsJL6RLwkQvQSPP0ZpIT
X-Google-Smtp-Source: ABdhPJzxgpXct+4VmuWQObj0fbaPHYA6/aHAzn2G6A2Qq7xUPNrGY4q0rca2zLIKTPNMIsg4IW8AJzVtkp9u
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:adf:ef51:: with SMTP id
 c17mr6145803wrp.51.1623337996468; Thu, 10 Jun 2021 08:13:16 -0700 (PDT)
Date:   Thu, 10 Jun 2021 15:13:04 +0000
In-Reply-To: <20210610151306.1789549-1-qperret@google.com>
Message-Id: <20210610151306.1789549-2-qperret@google.com>
Mime-Version: 1.0
References: <20210610151306.1789549-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [PATCH v2 1/3] sched: Fix UCLAMP_FLAG_IDLE setting
From:   Quentin Perret <qperret@google.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qais.yousef@arm.com, rickyiu@google.com,
        wvw@google.com, patrick.bellasi@matbug.net, xuewen.yan94@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Quentin Perret <qperret@google.com>
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

Fix this by setting the flag in the uclamp_rq_inc_id() path to ensure
things remain symmetrical.

Fixes: e496187da710 ("sched/uclamp: Enforce last task's UCLAMP_MAX")
Reported-by: Rick Yiu <rickyiu@google.com>
Reviewed-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 kernel/sched/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5226cc26a095..3b213402798e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -980,6 +980,7 @@ static inline void uclamp_idle_reset(struct rq *rq, enum uclamp_id clamp_id,
 	if (!(rq->uclamp_flags & UCLAMP_FLAG_IDLE))
 		return;
 
+	rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
 	WRITE_ONCE(rq->uclamp[clamp_id].value, clamp_value);
 }
 
@@ -1252,10 +1253,6 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
 
 	for_each_clamp_id(clamp_id)
 		uclamp_rq_inc_id(rq, p, clamp_id);
-
-	/* Reset clamp idle holding when there is one RUNNABLE task */
-	if (rq->uclamp_flags & UCLAMP_FLAG_IDLE)
-		rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
 }
 
 static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
-- 
2.32.0.272.g935e593368-goog

