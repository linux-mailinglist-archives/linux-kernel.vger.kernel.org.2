Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8247442F167
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 14:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239156AbhJOMww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 08:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239113AbhJOMwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 08:52:44 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2F6C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 05:50:38 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n40-20020a05600c3ba800b0030da2439b21so2883506wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 05:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4e98HL8b8j9zl+V8KV5tJU/uoSgZF9BT6s1NMo16bIE=;
        b=l4Uk/ZaTDP4+GsawSFt1DqXa3NbjCi6poOfKF/ZUVmk8g4mlRw1GTkXnJCdAttrAps
         yQcrqiySYWB9hG0a0uAs6iFzj+zDO9orvM4D3gYDUwwIq7dt0h713TCGOttVd2JW4+q5
         a+sj+/nl9eTwwQM7kiU/vjjkDiiYYpKEDSLrKrpDHuQkZRJEK7ZbWMtiVp/MBu3bR7HT
         sLxsU5xGR25XYQeBkoU0D/Z7+eEW5qEKnJqjteuAMZY31aOBY+lyJFlAte077Ss+GLIq
         z6w8e2KSd8gCLSjGUXEl6T/kW9YNOhwPawmtlWlxSciQ8+5dibjTjLk+yQNemmQ/hZMG
         pyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4e98HL8b8j9zl+V8KV5tJU/uoSgZF9BT6s1NMo16bIE=;
        b=hLq8k0bzt7EOL9IuzQYFdhZlKL2vERIj6pa1iVGdleqjIT0vdSOQiWChIP5OEW4fCO
         nvtvaWEQWf3heFbnxx8b7uskQik0nUvo2Q8w3WSOP27G7JF7/mtGag3QeVIFOx8qLBuG
         31ZpNSUAtKc8OUEnA25sie9Q0B8Q/MVmt35f/qE6+nvrrXGsh8oE4q2cSV3UdxLlq6Mj
         PXn4F3NVYFfUHkKovFXfisdqcTluPBBq8y9qli4kHGqHlcSxGU829zvhfP4MbvM2IutT
         FEWvUUny+PvycTByKqj4VkaiXxYwQzhibRS/dOTlPcHZVlDmTVos8PpZdadEOtcdOzud
         nqFg==
X-Gm-Message-State: AOAM533xygPe/SXOEjdPl5iPGXpugSuJtrTQu8vraKk3yVKd2ZZSBeuu
        VTOfgGi4h+yyG+145G+1ZMZlVA==
X-Google-Smtp-Source: ABdhPJxMIiXpJGhYQSZMzqRdFVlX4BFs9q3qa9FV6POAzRWXHP5cqCZ2pLko+AvlUh9qDQDcFA6Xbg==
X-Received: by 2002:a1c:9ac4:: with SMTP id c187mr26221406wme.18.1634302237068;
        Fri, 15 Oct 2021 05:50:37 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:7ce7:a27f:aba7:bb9d])
        by smtp.gmail.com with ESMTPSA id a2sm5468403wrq.9.2021.10.15.05.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 05:50:36 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 4/4] sched/fair: Remove sysctl_sched_migration_cost condition
Date:   Fri, 15 Oct 2021 14:46:54 +0200
Message-Id: <20211015124654.18093-5-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211015124654.18093-1-vincent.guittot@linaro.org>
References: <20211015124654.18093-1-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With a default value of 500us, sysctl_sched_migration_cost is
significanlty higher than the cost of load_balance. Remove the
condition and rely on the sd->max_newidle_lb_cost to abort
newidle_balance.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2967d13737b7..924a5f0a8145 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10877,8 +10877,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	rcu_read_lock();
 	sd = rcu_dereference_check_sched_domain(this_rq->sd);
 
-	if (this_rq->avg_idle < sysctl_sched_migration_cost ||
-	    !READ_ONCE(this_rq->rd->overload) ||
+	if (!READ_ONCE(this_rq->rd->overload) ||
 	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
 
 		if (sd)
-- 
2.17.1

