Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C47C4214FF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 19:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238270AbhJDRQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 13:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbhJDRQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 13:16:51 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBA4C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 10:15:01 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id j10-20020a1c230a000000b0030d523b6693so9766158wmj.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 10:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aWNgdEQ5NXz8/X3gCLTaSqlLeaCuTU3P623+R5va664=;
        b=W7ij8q9sI+ezViXcO5udMlsRgIVZpBczZVaWQwIpy4cCnNrWuOQ7hCc/GOuN6myvjZ
         tHGI7KvKEMLmqAWf8i/kb2L/CthzRbsO9DTvKGtbHxBC97IbRGc7jwfd2c6Rsf+clg3Z
         daYFBBENvrwgPGufPz5kPbB4rnVTOv3ciLiGsmsM5pUUAUrGPdVCRpWd59c+H+vOLe5d
         ygwHi7E5ZmhHCi61Xkzzl1+BEl5zAOqH2K3Mf+19UIUuFOuzSahiPAbJ2YUMIlDUzzB/
         tGSLsXUaphqI0I7NWW2ThMwXMAKVg9Hc3yx2QkhUYqdqNED5k7g5L0qk7XBkBqaDaIYJ
         mjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aWNgdEQ5NXz8/X3gCLTaSqlLeaCuTU3P623+R5va664=;
        b=T+KziwJJSD/2hm1W2Aj+8FOQwM1y6DmYvw4P0XthSKEMpEmZ4PjIIQp/ITHkEkbj5Q
         gtjdRhJ8m0bwLegqRpAcnZC41xALUftz/tPCvsdX9IDDv6L0Bf+A06ZkMX9ptMOPYv6I
         ldrRMs2DBuQh3yr5HvEzX8uzfDNU+L9HcPgvORZZPkM9DeHKYtWy3A4ibSqbWO6QSanc
         U2vyvxQ+Hr5W+Sv/xO54vrZ6bvb079Ac66/mrqStn5r5Os9wif9sNFQUvQWVFse24MMP
         Q8Y9b7m6QsDaQuwKE2eYIF6hCkFkZZ1QJt1cM1JUkNQnwhncSzpmU40MZ7o+YvkSqCVZ
         r+dw==
X-Gm-Message-State: AOAM531fxr7hsrjfK8e7VjZdXfgmpAigP05q/WYoc/4vz7V7kBAYSzV4
        ZGpBazBVxn8LHbgvSKKpnfA4tg==
X-Google-Smtp-Source: ABdhPJztY2P7NWgOb7tY2LNh75DKmgZQxuKOlfxB1x/tM6KZlozDDDOnOrcq3ESp9ziZhGptw2cz0w==
X-Received: by 2002:a7b:c4c2:: with SMTP id g2mr20264374wmk.134.1633367700397;
        Mon, 04 Oct 2021 10:15:00 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:9c40:6a4a:bd46:e324])
        by smtp.gmail.com with ESMTPSA id g25sm14833116wrc.88.2021.10.04.10.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 10:15:00 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 2/2] sched/fair: Skip update_blocked_averages if we are defering load balance
Date:   Mon,  4 Oct 2021 19:14:51 +0200
Message-Id: <20211004171451.24090-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211004171451.24090-1-vincent.guittot@linaro.org>
References: <20211004171451.24090-1-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In newidle_balance(), the scheduler skips load balance to the new idle cpu
when the 1st sd of this_rq is:

   this_rq->avg_idle < sd->max_newidle_lb_cost

Doing a costly call to update_blocked_averages() will not be useful and
simply adds overhead when this condition is true.

Check the condition early in newidle_balance() to skip
update_blocked_averages() when possible.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1f78b2e3b71c..1294b78503d9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10841,17 +10841,20 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	 */
 	rq_unpin_lock(this_rq, rf);
 
+	rcu_read_lock();
+	sd = rcu_dereference_check_sched_domain(this_rq->sd);
+
 	if (this_rq->avg_idle < sysctl_sched_migration_cost ||
-	    !READ_ONCE(this_rq->rd->overload)) {
+		!READ_ONCE(this_rq->rd->overload) ||
+		(sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
 
-		rcu_read_lock();
-		sd = rcu_dereference_check_sched_domain(this_rq->sd);
 		if (sd)
 			update_next_balance(sd, &next_balance);
 		rcu_read_unlock();
 
 		goto out;
 	}
+	rcu_read_unlock();
 
 	raw_spin_rq_unlock(this_rq);
 
-- 
2.17.1

