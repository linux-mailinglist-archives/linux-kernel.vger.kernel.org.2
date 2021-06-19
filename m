Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041093ADA4E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 16:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbhFSOM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 10:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234063AbhFSOMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 10:12:18 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4F4C061574
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 07:10:06 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id b3so3870627wrm.6
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 07:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6g7vlVbhoRZSF7+EmrRdxzOP/EHGvFfqkkjwETya/KE=;
        b=kjMBUY3h3UMTyLQUbc28lJ70mF0Ggl/Z+C4o5tHPUcVFtGPII28NP36weIPnVxdIw3
         sWpCjcYZVo4izzyMLTgvzAaJCod4JxphZYTUjdwkBnBFMkp5iiO92vxK0lJmiuQmjjGU
         uyJdIGWuKnkQBGFb7Ts12IHJLjx7g2xC3rxUPdgWLMr0JFAWQn2lD35IBq17SmtBLUio
         DQx3TGmzOId64bieow58imzwYQ8fPTgcwSyR41v0tYXK6A/RbVUOXBIVYozdZt/wZRYD
         Lfn0W0VOyEKeeXhKFrO9wYGp8N0t74qgDWdqWM5as8c1jxeJTW2+AhTRHih6Rl/7KdGm
         MJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6g7vlVbhoRZSF7+EmrRdxzOP/EHGvFfqkkjwETya/KE=;
        b=h2FbUosJBdJkoEpeqxFhfKyKJvnlHimOMxO+TSstTOKLDwiWcTHmCQp+JWy80rEx7z
         vfxs11TA7Y/nfs966TWu2kwkknl+wpv47hxzD+FdHZhseY4LH3a59ICjJFaFOr6/19TU
         2Ms/3kfRJwzpV2XxMUaLUWA3uzxFVlWyTFJgRI9W9RZwtarAGVibkFdrFTPk9+rsOe1j
         DkglQA3K0dklJpJfXJrFLJOV+VQpvKXkZuCvyoF1Wzyzk/3+07Oad5JsJ3+FucUJasvZ
         3pxsI1diN+2kZ93v0FAPkVRZDk/poyd0GMEQPSyuIdENzrtD35oo/ZK5faHcwc5yPBzQ
         eQNA==
X-Gm-Message-State: AOAM53189An2ii3hdpGt+ttol4QiqsF4yu/zUQwt+pYdRY1UHMcH5QAQ
        mejuN3HFXiDcqXzgDhlqwkuB0Q==
X-Google-Smtp-Source: ABdhPJwJHJqgwj+z7ObRlMdOuqA4Jx8jhBKQRQmNXinJqXxj94gI8wVZ5HhsevkGxDk8YxEoIqWRig==
X-Received: by 2002:adf:a34e:: with SMTP id d14mr18045203wrb.325.1624111804985;
        Sat, 19 Jun 2021 07:10:04 -0700 (PDT)
Received: from localhost.localdomain ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id y16sm8379350wrp.51.2021.06.19.07.10.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jun 2021 07:10:04 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        mariottiluca1@hotmail.it, holger@applied-asynchrony.com,
        pedroni.pietro.96@gmail.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH FIXES/IMPROVEMENTS 1/7] block, bfq: let also stably merged queues enjoy weight raising
Date:   Sat, 19 Jun 2021 16:09:42 +0200
Message-Id: <20210619140948.98712-2-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210619140948.98712-1-paolo.valente@linaro.org>
References: <20210619140948.98712-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merged bfq_queues are kept out of weight-raising (low-latency)
mechanisms. The reason is that these queues are usually created for
non-interactive and non-soft-real-time tasks. Yet this is not the case
for stably-merged queues. These queues are merged just because they
are created shortly after each other. So they may easily serve the I/O
of an interactive or soft-real time application, if the application
happens to spawn multiple processes.

To address this issue, this commits lets also stably-merged queued
enjoy weight raising.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index acd1f881273e..da2363f12e53 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1729,10 +1729,23 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 		bfqq->entity.new_weight == 40;
 	*interactive = !in_burst && idle_for_long_time &&
 		bfqq->entity.new_weight == 40;
+	/*
+	 * Merged bfq_queues are kept out of weight-raising
+	 * (low-latency) mechanisms. The reason is that these queues
+	 * are usually created for non-interactive and
+	 * non-soft-real-time tasks. Yet this is not the case for
+	 * stably-merged queues. These queues are merged just because
+	 * they are created shortly after each other. So they may
+	 * easily serve the I/O of an interactive or soft-real time
+	 * application, if the application happens to spawn multiple
+	 * processes. So let also stably-merged queued enjoy weight
+	 * raising.
+	 */
 	wr_or_deserves_wr = bfqd->low_latency &&
 		(bfqq->wr_coeff > 1 ||
 		 (bfq_bfqq_sync(bfqq) &&
-		  bfqq->bic && (*interactive || soft_rt)));
+		  (bfqq->bic || RQ_BIC(rq)->stably_merged) &&
+		   (*interactive || soft_rt)));
 
 	/*
 	 * Using the last flag, update budget and check whether bfqq
-- 
2.20.1

