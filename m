Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94AB13A1759
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 16:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236549AbhFIOgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 10:36:43 -0400
Received: from mail-qv1-f73.google.com ([209.85.219.73]:38821 "EHLO
        mail-qv1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbhFIOgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 10:36:42 -0400
Received: by mail-qv1-f73.google.com with SMTP id i6-20020a0cd8460000b029022689c68e72so11370264qvj.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 07:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ujJ7V2lKU2Osdsi84sTaaJPDcMYpTcXqnHW0Nm4jQfs=;
        b=sph+9QWdALbk3yu47eGVpi1/fvZe4Sedy3rrMZqi93njEFAlesgGBptGBKECL7kcSi
         YO8Hw5xh8o0OCRayGVfKNno48LdfeX/gi3dCqbDROQ7weoro1kLyDMXnSTSS2LC+0gSe
         MN/7D/8ZirGW4FmvA9kwbCTGFZ0Nj0mfnivpJSjTRDXkh0Z5Oscqq+KH6J+lx5fxVRq8
         6fN8IbuSTJorJeinL1eoWPn4ouFT7cFTmkb/nFLlbL0V8mOvZyq8OfM3Mh6SsouBqsEY
         0CpuKDHgUq8vtJh/rxibRv3h/RUjJXNVcakXVDXqVRgdujQDWZUgS1YsHFXla3qzDU/K
         ZPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ujJ7V2lKU2Osdsi84sTaaJPDcMYpTcXqnHW0Nm4jQfs=;
        b=OU+8/LdkywAGe57f+j27fZJJ1zeMTUg0Ob4rveZPvPLaTeb+JLNJntg2qFk4SU/UNU
         lgRWJm/KL4fO+Y/v8umlEtjhKiH8FB8KBDX+CuJE6ZHsvboYz6Xua0C2FCc7tQa2w1wg
         1SzLY5qTYCJIkr+UXbSZJuAr6dOrJLifKoIH0GNJbRKniZy/KAFMB331oPeU+XqARgy/
         EsepEeVWNHzqWqbuIvpdg97Vx4D9N2suyHfoOj560ZSfOoWFhE7NZQ0sbfmW8RfjBg9I
         /Nm+43ZO4Izsq0O0D7bLfFA7NZ2uQyKrJlepY9v+oZrZ0gznPBa1EeXn+Wu+73eQMg6B
         qTvQ==
X-Gm-Message-State: AOAM532lMHfco7cveo3xMexESkj7UYZStuIiC7kbkt6amaeP0uhIPJxV
        CIMAgtNzvaobMSilR6VKBgD+HX9yPQG9
X-Google-Smtp-Source: ABdhPJxOJ0pHTcYhe0gIXSj7GPNB9Ea02/zFe3+FDrz+GqTcx4sztVdzrwjvtnm1Resx1H2L2Bclo5wR9lyd
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:ad4:5ba8:: with SMTP id
 8mr6045636qvq.25.1623249227196; Wed, 09 Jun 2021 07:33:47 -0700 (PDT)
Date:   Wed,  9 Jun 2021 14:33:39 +0000
Message-Id: <20210609143339.1194238-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [PATCH] sched: Fix UCLAMP_FLAG_IDLE setting
From:   Quentin Perret <qperret@google.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qais.yousef@arm.com, rickyiu@google.com,
        wvw@google.com, patrick.bellasi@matbug.net
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
can lead to having the flag set whilst there are active task on the rq.
Specifically, the flag is set in the uclamp_rq_inc() path, which is
called at enqueue time, but cleared in the uclamp_rq_dec_id() which is
called both when dequeueing and task _and_ during cgroup migrations.

Fix this by setting the flag in the uclamp_rq_inc_id() path to ensure
things remain symmetrical.

Reported-by: Rick Yiu <rickyiu@google.com>
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

