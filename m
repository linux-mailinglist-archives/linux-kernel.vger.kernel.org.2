Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2A63F9F29
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 20:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhH0Sua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 14:50:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56869 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230005AbhH0Su0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 14:50:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630090177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GWQt+/o6sV0efXCcp5VZH7IExBj/AANB8sEodLm9MsY=;
        b=femuMgJs7v2iz6WGE2bU4xRg2quyIf6ZAgpU/nJIVmV7XQmWQk1D8J9rQ6iDDmPm34RU+Y
        id6jzYRjmxwOSHoZLhqSTmIVjYCDyrIJvK3+kYukGoMPlaimSg5xik7l17WgDvmGVdK32m
        d91ro+Ls1n9zIS8d4nVvslGiBTjNvyA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-ApZ6tVpFOVmv0_QhnjaPSg-1; Fri, 27 Aug 2021 14:49:35 -0400
X-MC-Unique: ApZ6tVpFOVmv0_QhnjaPSg-1
Received: by mail-wr1-f69.google.com with SMTP id n10-20020a5d660a0000b02901551ef5616eso2108469wru.20
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 11:49:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GWQt+/o6sV0efXCcp5VZH7IExBj/AANB8sEodLm9MsY=;
        b=cEAmstANaXOLJmpX0qFqs/a+HZGa1JT6+xrThbRdv5FFcRU4Bsez8nBv963azC6xt9
         ShbPbXmCKJce46aX0/bUDijA72s1JvccbA5HLYM38UzByxU08LD59WDL6hHCkg4JNLYI
         sXtiIiIez+KVkMDjiT4FiV7nMHc/LCMVjwMsHCa4SqsVGargH2yLUSTTIUYJ5V6dvyfJ
         VO6nRhw9coA/9Y0Y9rUuK+werCsOAFSTjvEDrsuu4rxi9qYYirz8Rr3quP2nHJhNmi5d
         8z55W+srq2qkguVIW7NJaotDW/CfNL5KqKBnmFDUZ00J+6MDZgZ/CVuM6rF1pweTdEIq
         ZYsg==
X-Gm-Message-State: AOAM530jQs77gR0NrySRZMeXGAfrdGz5JcZu+7BvoI3CiiQVA/KBdRwE
        V1ri/pygZ0leQJaBlQoVJ3FCSz3ddJwc6Rc51LxI4cA6Z72bHcDrX57utwrjp66mLCocZ8sqmw3
        PgyIWJm0i+uGnoWHT1IrQkWaJbw7htOO+7bM9VmhkOUV2+4UAyMIdfcjlmYkvAJ78PBQV5mUDcU
        mi
X-Received: by 2002:a1c:2905:: with SMTP id p5mr21199334wmp.146.1630090174653;
        Fri, 27 Aug 2021 11:49:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyuCWLnmrYOGEUvvdTMIXZ03bKBwvK/3MfE10rufdf5tlrjvWMFLwKkzQf8n+LhkraPc3axgA==
X-Received: by 2002:a1c:2905:: with SMTP id p5mr21199305wmp.146.1630090174357;
        Fri, 27 Aug 2021 11:49:34 -0700 (PDT)
Received: from vian.redhat.com ([2a0c:5a80:1e06:4300:1420:811d:467:5b5f])
        by smtp.gmail.com with ESMTPSA id d9sm6821806wrm.21.2021.08.27.11.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 11:49:34 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, juri.lelli@redhat.com, mtosatti@redhat.com,
        nilal@redhat.com, frederic@kernel.org,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [PATCH] sched/core: Bypass arch_scale_freq_tick() on nohz_full CPUs
Date:   Fri, 27 Aug 2021 20:49:10 +0200
Message-Id: <20210827184910.2163948-1-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch_scale_freq_tick() calculations generally track the increment of
frequency performance counters in between scheduler ticks to provide
estimations on how DVFS swayed frequency on that CPU. This information
eventually allows for more precise scheduling decisions. It's all fine
and good, but nohz_full CPUs are capable of disabling the tick
indefinitely and potentially trigger overflows in
arch_scale_freq_tick()'s calculations once it's eventually re-enabled.

This will happen for both users of this interface: x86 and arm64. And
it's also relevant that the heuristic on what to do in case of
operations overflowing varies depending on the implementation. It goes
from fully disabling frequency invariance scaling on all CPUS, to
ignoring this is a possibility.

It's arguable that nohz_full CPUs are unlikely to benefit much from this
feature, since their aim is to allow for uninterrupted execution of a
single task, effectively getting the scheduler out of the way. Also,
DVFS itself is also unlikely be used on most nohz_full systems, given
its effects on latency.

So get around this by not calling arch_scale_freq_tick() on nohz_full
CPUs.

Note that tick_nohz_full_cpu() relies on a static branch, which avoids
degrading performance on the rest of systems.

Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---
 kernel/sched/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2fd623b2270d..8c04ec0e073a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5016,7 +5016,13 @@ void scheduler_tick(void)
 	unsigned long thermal_pressure;
 	u64 resched_latency;
 
-	arch_scale_freq_tick();
+	/*
+	 * nohz_full CPUs are capable of disabling the scheduler tick
+	 * indefinitely, potentially overflowing arch_scale_freq_tick()
+	 * calculations once it's re-enabled.
+	 */
+	if (!tick_nohz_full_cpu(smp_processor_id()))
+		arch_scale_freq_tick();
 	sched_clock_tick();
 
 	rq_lock(rq, &rf);
-- 
2.31.1

