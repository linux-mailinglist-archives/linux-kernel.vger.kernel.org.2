Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C74396FB1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 10:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbhFAJAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 05:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbhFAJAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 05:00:33 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C1EC061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 01:58:51 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id f17so6240513wmf.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 01:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=SYj5XOcLWaHVrLKkqf4tl8LWfg6GdKIbZSQPsS6lgRQ=;
        b=ecdnxXlfW3dgKE/h79dgCsKW3XMKIwM86XHciWQJ40L4F3/gE3yCthM25bb92YS726
         NDnrnXh4Yo+c3vJO6kGtpdhTDfAPUUzPeUrYR799Wgvm/IIh1Mqb310+gXtpmkZ57Af/
         /Uq3PxYURqYUtkUevSPpDtU0iPxZ7dLyIRcvvXmfYcZFwtk4Q/Z2n2lmN8gl2t8b63jU
         3nsAlGV0yXr4JMynfRAHwR7GGRhNsR0Cf1fsR/ER+7QzoxjTp4UPuXPU+ajOTbeP/Umv
         vZS8dVgQIJeQvt1ALJpu6E9xa/4O2jEwbagVdIgB4JE9l6JTtes3SxxPtt0i4u/yc3xE
         2ffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SYj5XOcLWaHVrLKkqf4tl8LWfg6GdKIbZSQPsS6lgRQ=;
        b=K/thKpdo3zir8ddLITZuGglw2H0dVcDN1BjkvUzb/proumYOBFazGKRjF4vTbV4A8/
         vzWtBg+GfWJye18vgI3qtJ3A2qARN2oL42TogWqfCm1VxEsYpjFPBoo7UgGc17YgAdT4
         KBeS9jawKevkz7O241NNvS55W9JJDSsUQv2da9+L0Mc9E2MliRUQYWavq+SLWUy/8k8c
         pK7ovnkJlseKAKUyx2qlDC3gjTmgEVR6Bb/6GMG2Wj78JFMqMThpAVe4X+EumRwX1Ng3
         Iq5vf1AgSS8zpiY5aYNGFFUZoA7cz46icQlQdinvG9Ix7wOKghXvG3Ymt3mCpOHsIorI
         rVQQ==
X-Gm-Message-State: AOAM530EtuGL0SLbjCRgaXGR4YjXE53GVo+2aAJE8wiv4d6MATWRGUY1
        mV0Ok8JsiQcBQrDmkh31itb2Cw==
X-Google-Smtp-Source: ABdhPJyjGTFB5WFPiY2SLrWQzSbTbtocbh8R144ySFDAMiaal9+DFNuTQEisZEY+aFNmV67oxOGWEg==
X-Received: by 2002:a05:600c:430a:: with SMTP id p10mr5245275wme.155.1622537930518;
        Tue, 01 Jun 2021 01:58:50 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:6c00:9595:b314:5291])
        by smtp.gmail.com with ESMTPSA id 32sm2906434wrs.5.2021.06.01.01.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 01:58:49 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org
Cc:     odin@uged.al, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/pelt: ensure that *_sum is always synced with *_avg
Date:   Tue,  1 Jun 2021 10:58:32 +0200
Message-Id: <20210601085832.12626-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rounding in PELT calculation happening when entities are attached/detached
of a cfs_rq can result into situations where util/runnable_avg is not null
but util/runnable_sum is. This is normally not possible so we need to
ensure that util/runnable_sum stays synced with util/runnable_avg.

detach_entity_load_avg() is the last place where we don't sync
util/runnable_sum with util/runnbale_avg when moving some sched_entities

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

While studying the problem raised by Odin, I have faced such situation
where the cfs_rq was removed from the list because of all *_sum being null
but runnbale_avg was not null.

kernel/sched/fair.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 161b92aa1c79..9b7da61ace51 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3720,11 +3720,17 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
  */
 static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+	/*
+	 * cfs_rq->avg.period_contrib can be used for both cfs_rq and se.
+	 * See ___update_load_avg() for details.
+	 */
+	u32 divider = get_pelt_divider(&cfs_rq->avg);
+
 	dequeue_load_avg(cfs_rq, se);
 	sub_positive(&cfs_rq->avg.util_avg, se->avg.util_avg);
-	sub_positive(&cfs_rq->avg.util_sum, se->avg.util_sum);
+	cfs_rq->avg.util_sum = cfs_rq->avg.util_avg * divider;
 	sub_positive(&cfs_rq->avg.runnable_avg, se->avg.runnable_avg);
-	sub_positive(&cfs_rq->avg.runnable_sum, se->avg.runnable_sum);
+	cfs_rq->avg.runnable_sum = cfs_rq->avg.runnable_avg * divider;
 
 	add_tg_cfs_propagate(cfs_rq, -se->avg.load_sum);
 
-- 
2.17.1

