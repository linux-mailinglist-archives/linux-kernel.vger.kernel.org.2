Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9103E1285
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 12:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240316AbhHEKWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 06:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240017AbhHEKWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 06:22:14 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660FEC061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 03:22:00 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id p2-20020a5d48c20000b0290150e4a5e7e0so1749419wrs.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 03:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Hr5kx8IRhOqofpW69k0vt45j6LLZG/KW9z8/ZmEFZKA=;
        b=utr8s1thoEPynFe7sJR5HiEt3iZ/I2OMlFVXUYFyXg2MQ0rWE5h0YbSBiK10RZ6gAY
         +Nxl80jejVi6Jg9iSkjZCOD6pm/sYewiPBsZ31X07Fv2B+kNra5Yh1xX19xLWGvRQPvT
         yAdNatkcuAyfJf30wCehU84P5mkgW3i6iIwc0m9tlAZHzr7WQiPTAIGqNZyFV8WOQAZr
         YgR24Say5tC4XuVZmLHvSq7ZtWHGv5GjZ1srPd5JLmfAXYTV98LhYazB/ckG0PQprHwk
         3UBeDLNfMNsl+26WWYf/OC3MjkTkb2r/+7zihXWFfhXfATQq0EUIpejU6Sc/FGFBT/zX
         3WeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Hr5kx8IRhOqofpW69k0vt45j6LLZG/KW9z8/ZmEFZKA=;
        b=YBh8JVWWrltiwuTHicT4J2vEBhMv+R7E2/E4hw5CYCc0BMwxbbU+qxu5SBhI5mP7/x
         7GR4zWHjdcB0g1JrMLioYf1Alub9PKaKpUsQjTE+pkhavJqk5y5Rf1m3sjcOQuePHGSq
         9booiPewnjc4TiT4qDVRGgiipSb0suNvSzI4g/9aXFKzLNTFrevDahaR3pV3Egp4ph3x
         UE5qoURR7H6lrU0KdduXUCn+ktjZwXXNXJ2+07YyhWdztX11RAIov3NLfk7Pm5V6zj5E
         61++gDBLjS5SO5qvqmyjfk8Rn3bLAbnu3LhT5Dm74U5B/XH3ccHGWuT84Fqe0pRImY+z
         20ww==
X-Gm-Message-State: AOAM5328IGP4/3OMrls4mC2rkX6PNTWHWS1FU2LMEAq8JZGkdVpXx4tx
        ucA/cUi6y8FTk04Q7EDOD3plmfLePv6/
X-Google-Smtp-Source: ABdhPJx2aJDCFkyX0I0oXb+iH33hfk5eKVksi6FGy5Yzzp/q9252Mdz60iU2Uw57ZUnQuQp7Y4n023adSnFY
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:fd92:a1bb:45f5:2fef])
 (user=qperret job=sendgmr) by 2002:a05:600c:2942:: with SMTP id
 n2mr4166523wmd.161.1628158918804; Thu, 05 Aug 2021 03:21:58 -0700 (PDT)
Date:   Thu,  5 Aug 2021 11:21:53 +0100
In-Reply-To: <20210805102154.590709-1-qperret@google.com>
Message-Id: <20210805102154.590709-2-qperret@google.com>
Mime-Version: 1.0
References: <20210805102154.590709-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH v5 1/2] sched: Fix UCLAMP_FLAG_IDLE setting
From:   Quentin Perret <qperret@google.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qais.yousef@arm.com, rickyiu@google.com,
        wvw@google.com, patrick.bellasi@matbug.net
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UCLAMP_FLAG_IDLE flag is set on a runqueue when dequeueing the last
uclamp active task (that is, when buckets.tasks reaches 0 for all
buckets) to maintain the last uclamp.max and prevent blocked util from
suddenly becoming visible.

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
Reviewed-by: Qais Yousef <qais.yousef@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 kernel/sched/core.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 314f70db3e5c..df0480ad59b0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1621,6 +1621,23 @@ static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
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
@@ -1644,12 +1661,8 @@ uclamp_update_active(struct task_struct *p)
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
2.32.0.554.ge1b32706d8-goog

