Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895233AC4ED
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 09:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbhFRH1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 03:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbhFRH1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 03:27:10 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C999C061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 00:25:00 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id bb10-20020a17090b008ab029016eef083425so7186942pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 00:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oQ7j4KWfTTyvLXb9Q14D2rlz0l6gky8bN6zkafs2a1E=;
        b=IjMTgC4PAPXDufNja9BoQndIkB7TliHo6U/WgmL53vKrOB41w0sMmLwqflatryB2L/
         go341RGiCwhWowAhF6El6Dvurd49CNgtdR01AOw07lagrSEFZUo+cwcMqFwZoPAS97bH
         FzhD8lSyNUm9er0sVexgieu/pO4nakGLn9IoPF1HA0tOBVI/dFfRcsCBIt/d+oTDI5Fq
         JqUOOc+OiL9MMMVd7u89gkeBM+3bOKjVPG0DdFQJNj3/q3nu2bl/YUf/yo5hIo3056dw
         IWVGI1eWuPT5m5Wo+v5pUYmYMK40jBI8NRKAwDHYlnwRYryekpiAMNEP3WslYUp6nCmm
         byzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oQ7j4KWfTTyvLXb9Q14D2rlz0l6gky8bN6zkafs2a1E=;
        b=IuAWLTEXdJ/NdaQ37bF1Ovjx1xHtixNwM5u+zzw/Xpq+j8VS0fxqK7afOYY8/+1Hnc
         LLH3r1irFnQ69DGeq1WaIKhR9d96D6Jr2Fx/8Uip5/S9/0Ap41l4bCEf/9kubU3XbE1G
         6w77WLUG7LE42qwsP9wYbJW2wfZKTUCSmdK5XVyd2tUUw9R8MFvie+H58B6YSqJf7ISW
         xONHxI4erRlrFvsOoGD7w8Dcs78yauF2tuz54nl2e7kSz+tS1fVxz5tbo9XDegbJJmWt
         c0CSM0JhqWTc2kYJfe71ogfKGV6Mltjq5OyHJBlAIQEFl4OHD41E4xBdQtv8IB5AfuiB
         ol5Q==
X-Gm-Message-State: AOAM530Wwk5xVa9oatzUnQZmfJ3gd7tBiIrO3AMMSfUiU9AteLjezRXB
        8M3AbmzEdvVWEfv6asKN/1g=
X-Google-Smtp-Source: ABdhPJzktkn8nQZGs7YoFSms8BBQtuQot2odU78DrgDzz2ahNpH7oYYyR2Ef4m+Km4NLmgVAG9XlRQ==
X-Received: by 2002:a17:902:d704:b029:121:4e28:de0b with SMTP id w4-20020a170902d704b02901214e28de0bmr2162040ply.50.1624001100156;
        Fri, 18 Jun 2021 00:25:00 -0700 (PDT)
Received: from BJ10918PCW.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id v8sm6991065pff.34.2021.06.18.00.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 00:24:59 -0700 (PDT)
From:   Xuewen Yan <xuewen.yan94@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com
Cc:     rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        patrick.bellasi@arm.com, zhang.lyra@gmail.com
Subject: [PATCH] sched/uclamp: Fix getting unreasonable ucalmp_max when rq is idle
Date:   Fri, 18 Jun 2021 15:23:49 +0800
Message-Id: <20210618072349.503-1-xuewen.yan94@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xuewen Yan <xuewen.yan@unisoc.com>

Now in uclamp_rq_util_with(), when the task != NULL, the uclamp_max as following:
uc_rq_max = rq->uclamp[UCLAMP_MAX].value;
uc_eff_max = uclamp_eff_value(p, UCLAMP_MAX);
uclamp_max = max{uc_rq_max, uc_eff_max};

Consider the following scenario:
(1)the rq is idle, the uc_rq_max is last task's UCLAMP_MAX;
(2)the p's uc_eff_max < uc_rq_max.

The result is the uclamp_max = uc_rq_max instead of uc_eff_max, it is unreasonable.

The scenario often happens in find_energy_efficient_cpu(), when the task has smaller UCLAMP_MAX.

Inserts whether the rq is idle in the uclamp_rq_util_with().

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 kernel/sched/sched.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a189bec13729..0feef6af89f2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2550,7 +2550,10 @@ unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
 
 	if (p) {
 		min_util = max(min_util, uclamp_eff_value(p, UCLAMP_MIN));
-		max_util = max(max_util, uclamp_eff_value(p, UCLAMP_MAX));
+		if (rq->uclamp_flags & UCLAMP_FLAG_IDLE)
+			max_util = uclamp_eff_value(p, UCLAMP_MAX);
+		else
+			max_util = max(max_util, uclamp_eff_value(p, UCLAMP_MAX));
 	}
 
 	/*
-- 
2.25.1

