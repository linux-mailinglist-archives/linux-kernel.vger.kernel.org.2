Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E93039773D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 17:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234495AbhFAPzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 11:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbhFAPzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 11:55:15 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CB5C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 08:53:33 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l11-20020a05600c4f0bb029017a7cd488f5so2239570wmq.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 08:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=VFIoQD4qrPW/qYAFsIyDwvwOZ9V+jP/7FIYDt1yCrb4=;
        b=BHU7tvdqmSo1hf0RvadYnGAHKFwL/OSyV3RMb3exulAs1UJ82zyXND+JO6tr4mzIXJ
         U76gQSbLdKjmXebHQ2VNuo9QcHIVK2EFquGJ0dtQdjqk6and/22VlwarYUPHvHWSxlE/
         jCDnpGD5EOIRJ+5eqlhWSNaTnowgBlmxTIFplycpdtRPTNXFNvLfMP//hcrAQoXvNXUm
         pfP1vqCZcbMk6pTA0XkYAdDSuxWUllmZa2KnRDhVVO0slXR4zERFBejtCGBik6HSjdEK
         SjZOsUg7JXZbDfkTncXoveGJ7sStRXiZ0KvjzJLMksCIO9yF/Bi3kIsR9bxnuR6qB1tY
         p0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VFIoQD4qrPW/qYAFsIyDwvwOZ9V+jP/7FIYDt1yCrb4=;
        b=lFcq6LwV8pyaIhtqoXrEbOknhHPiO2RUbtdpLH1lZsZNPhhXf+5Th9yVlZvbMIi8pZ
         4adUBHmRcBmKH5geSo4+x8pSNVCJdg0YpFo2v5wQKpVkFM87p6XStU9UbYaVj+dZOzqx
         +f7zGYhL2IhypVAv1kG9pGUSKiXmuUl1PpH4WS3OCbz87riHbKB3mRgyknXmQZ76xcw6
         Ulm5Of9JybG0FMaJCenGrWjFdp5zvo2LYbxcWvh7xGyNHLbaDyFyi4LzEMbj2WVLxWkT
         VTeopzF7UxAXLCIzuFX2f/Q/4TSjjJJ9ZPEg4g9kAyV+zdzty02BO0HXpeEq8TcHYYzp
         QiYg==
X-Gm-Message-State: AOAM533HXEu0ASgsma3gPquOnUAcCFUGQO03QFSzFWCR92/svg7O6ww5
        FfHlnvChb3ZyX/J8JcN1EV2kJw==
X-Google-Smtp-Source: ABdhPJyKi6kzcv8ZG6flBXlxFCvc7lLBGHOozthgCR7KsbZhMi/Fq2t4h3miFMId7da5nkarS+MxNw==
X-Received: by 2002:a05:600c:2142:: with SMTP id v2mr9971128wml.9.1622562812026;
        Tue, 01 Jun 2021 08:53:32 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:ac51:a684:201f:b56f])
        by smtp.gmail.com with ESMTPSA id r7sm3937125wma.9.2021.06.01.08.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 08:53:31 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org
Cc:     odin@uged.al, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/pelt: check that *_avg are null when *_sum are
Date:   Tue,  1 Jun 2021 17:53:28 +0200
Message-Id: <20210601155328.19487-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check that we never break the rule that pelt's avg values are null if
pelt's sum are.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

This is what I used for patch 20210601085832.12626-1-vincent.guittot@linaro.org

 kernel/sched/fair.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a2c30e52de76..c17feadeafcc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8021,6 +8021,15 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 	if (cfs_rq->avg.runnable_sum)
 		return false;
 
+	/*
+	 * _avg must be null when _sum are null because _avg = _sum / divider
+	 * Make sure that rounding and/or propagation of PELT values never
+	 * break this.
+	 */
+	SCHED_WARN_ON(cfs_rq->avg.load_avg ||
+		      cfs_rq->avg.util_avg ||
+		      cfs_rq->avg.runnable_avg);
+
 	return true;
 }
 
-- 
2.17.1

