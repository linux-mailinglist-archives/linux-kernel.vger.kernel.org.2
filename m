Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B2A3B1A46
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbhFWMhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhFWMhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:37:06 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0578C061756
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 05:34:48 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id h17-20020adff4d10000b029011a7b7961dbso1013785wrp.15
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 05:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=T0nSoJ5wzCyMprwr8b/+7hv8RW3/0jpCRYtsGO6gL4Q=;
        b=TByi0SbBnqTnjMPgblA791r9/PtSoxty8K5P02++XsSzLWpYVq4k1HpUUmsPdxIAB5
         Y6GG8enviW5savGoi0XIfwyNwb247sON2Q8P5r7UZNMr35OYxYFC5eDb8w9Yd6WIFkTf
         LdGecknpLWj+Q/t7074wAfwMnybPj7Is4MGT8DJM62BdfiAu3Ybyqt9yYuFlu55KOaxt
         dVm8mbWBZGXYZdog4XKJqQSN/YAkT7irkn7OiMmE/jq7x6RGFcXiEdp2J4fhTxckha+D
         uECYcftFoBYJsef/vIFJ5nOh0xwnjrRLQ4HUOS2rq7HOPN3tPIwJCC5S5tgruA7J0bqB
         ruZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=T0nSoJ5wzCyMprwr8b/+7hv8RW3/0jpCRYtsGO6gL4Q=;
        b=eAuW+woYw+D6rYxJ81JJStfTOy1Fw+wSLOpJExq/5gFGyhRO0QPmQzRSySY9KXw/4/
         80DUaUHGfzIBdVOW8dDo9eGvwfGfa3cSI6D2d2rOpKuToM/RU0JUH+0hHmpV8FnDKbdw
         8mp9Imr92YFZotemaq4jK1oS3R7EPXtPjTuTQIB0JRNHhZc1cukOaXJsyXnjM0mAePAA
         ny4X8CUTCeeiOnHqAcmmX1/c7/gLcahN7JmK51uLRcMFmofOcYAdKOBctPW+XN1hCQlz
         HdoOvB3vUOo/NzxyYfu8YK6dVAxguafR+r4XOBAq0bhbMvSYaLZH2g+SzjqA32arx1Y3
         AAGA==
X-Gm-Message-State: AOAM530FjD2wRFsHtZQhRft17mDLLyEy0blVmE9F6amuGjyNmfgEr67V
        otjOY9HlxoKgR8RYlOyU/P/tB7f5UQWX
X-Google-Smtp-Source: ABdhPJwtdIeL9bm/b1l+yYiZ6Wf1aYJWJnuIXZjmBJLSPP0kAGVIA3o5mfWS9QiZtgUNXtEP/+/+2KmGL84a
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a05:6000:8b:: with SMTP id
 m11mr11018582wrx.22.1624451687474; Wed, 23 Jun 2021 05:34:47 -0700 (PDT)
Date:   Wed, 23 Jun 2021 12:34:39 +0000
In-Reply-To: <20210623123441.592348-1-qperret@google.com>
Message-Id: <20210623123441.592348-2-qperret@google.com>
Mime-Version: 1.0
References: <20210623123441.592348-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH v3 1/3] sched: Fix UCLAMP_FLAG_IDLE setting
From:   Quentin Perret <qperret@google.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qais.yousef@arm.com, rickyiu@google.com,
        wvw@google.com, patrick.bellasi@matbug.net, xuewen.yan94@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        qperret@google.com
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

Fix this by clearing the flag in uclamp_idle_reset() which is also
called in both paths to ensure things remain symmetrical.

Fixes: e496187da710 ("sched/uclamp: Enforce last task's UCLAMP_MAX")
Reported-by: Rick Yiu <rickyiu@google.com>
Reviewed-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 kernel/sched/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4ca80df205ce..e514a093a0ba 100644
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
2.32.0.288.g62a8d224e6-goog

