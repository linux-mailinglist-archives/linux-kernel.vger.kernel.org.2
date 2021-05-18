Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7525E387945
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 14:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349406AbhERM4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 08:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349394AbhERM4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 08:56:17 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EA9C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 05:54:57 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id p20so11415220ljj.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 05:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K2m3StdkgN8j9sX0OOQRA/hs3X95klSzDGXdeM8HTJY=;
        b=vtTYi9jfJ+11Q8gjuzRabIbIUKKJyqDw2pUtj9GyYq0ftsy8WpejQqwF/PaksTkvyc
         E67MK7KCFtAD9K0Vzv1M8Bxsab4LMuvS1BFcFPicbl5vVl3wbbg36Rvy4C+mDBjmJWnU
         i1RHd6XsD+eheHVLbo1owEAmQdFFLNNmdDC/E3b4o9TVqEUdUGNmZBciHKjvhzGYXx2U
         AIsi+38lT8vu7gcHLdsPM8FJgXs+ZwIwAZFzksPlw5AudK7uFdgkTsCL23j3PHM4mR4r
         xVgDiSS6Vw4y+5jBPhFcNKOUwUSB3g6F23BHUHqi8eSvL4iStYz5xcleD5fjYA5zces/
         KggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K2m3StdkgN8j9sX0OOQRA/hs3X95klSzDGXdeM8HTJY=;
        b=C2pccaZr+JWiXxG4JLsTFwl5QTjbHXoGY658T4JAhm4Q2ao9EtAwUtscbgg3ENu8kA
         lssClDEH2io0ZcNZ/aNogsSGFjVeF7M00LkJSCIcfYpo/zR8N6/dHy0EU5CC4ZvubkRD
         +lwK65B91U0BKWORZoK6ujv7xG88dMh9KR7RIr+2MMGLnwwBt7XDnYB+xDdiuOZvzUTj
         6AKXYljvrUHl1acPyzlbeLd4pHzmqb7NkNLLD29wm9Kn0fcrQ003PBYvW+uki/1Tl+Vd
         6VtOKQu1l6cA42to03rHYY4eXD5h4WNc4DDT5kp4VZ/YpCuilRBh4fJ7dxVNlx9vele+
         chEg==
X-Gm-Message-State: AOAM530aY8PXHqWm+bze7TxbVUvS190HtzDOlixVs4Tw2iySIGQZoIqz
        1bKLq8CusydqAF54W0aSeAr0ag==
X-Google-Smtp-Source: ABdhPJwLowVg+qfPEP4m4gwcjwf2Q+qfSPQ4MZHPbdrFt8a6uEUt7DfWGWjaXSLKdG33muGkuGRptQ==
X-Received: by 2002:a2e:86cc:: with SMTP id n12mr3761996ljj.457.1621342496269;
        Tue, 18 May 2021 05:54:56 -0700 (PDT)
Received: from localhost.localdomain (ti0005a400-2351.bb.online.no. [80.212.254.60])
        by smtp.gmail.com with ESMTPSA id v14sm2265898lfb.201.2021.05.18.05.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 05:54:55 -0700 (PDT)
From:   Odin Ugedal <odin@uged.al>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Odin Ugedal <odin@uged.al>
Subject: [PATCH 1/3] sched/fair: Add tg_load_contrib cfs_rq decay checking
Date:   Tue, 18 May 2021 14:52:00 +0200
Message-Id: <20210518125202.78658-2-odin@uged.al>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210518125202.78658-1-odin@uged.al>
References: <20210518125202.78658-1-odin@uged.al>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure cfs_rq does not contribute to task group load avg when
checking if it is decayed. Due to how the pelt tracking works,
the divider can result in a situation where:

cfs_rq->avg.load_sum = 0
cfs_rq->avg.load_avg = 4
cfs_rq->avg.tg_load_avg_contrib = 4

If pelt tracking in this case does not cross a period, there is no
"change" in load_sum, and therefore load_avg is not recalculated, and
keeps its value.

If this cfs_rq is then removed from the leaf list, it results in a
situation where the load is never removed from the tg. If that happen,
the fiarness is permanently skewed.

Fixes: 039ae8bcf7a5 ("sched/fair: Fix O(nr_cgroups) in the load balancing path")
Signed-off-by: Odin Ugedal <odin@uged.al>
---
 kernel/sched/fair.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3248e24a90b0..ceda53c2a87a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8004,6 +8004,9 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 	if (cfs_rq->avg.runnable_sum)
 		return false;
 
+	if (cfs_rq->tg_load_avg_contrib)
+		return false;
+
 	return true;
 }
 
-- 
2.31.1

