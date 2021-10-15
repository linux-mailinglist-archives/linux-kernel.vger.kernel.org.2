Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF90742F165
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 14:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239147AbhJOMws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 08:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239108AbhJOMwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 08:52:41 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7E0C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 05:50:35 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id a140-20020a1c7f92000000b0030d8315b593so2877054wmd.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 05:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4hPxRFSewx0vrQrXVagzhgzCPrSg32067Y/9VaQerDM=;
        b=rRMfjgRDVNxju5wCC1DGscBZgr7lBeiZVOiGdrUAWaGaXIE/b9n08I/7Gp5lZupv/0
         XlGenpkYyYepZk9PhEMQ5pDN3tEYsJdTXoCKonIfAknWhT1ErZVozje0cujHWzgr/ddQ
         pGwqsyNar9AmmH7y71Fju0U0UY+ZHXofh0jWrjInO8YQ8IvRiScUihGwfWCRc73Ka6sH
         4ANthZf7Y6FNWCE1l1avw8yq2GFvVVJg0gnTEzeQ3zeRsnMdKxLMNbuQohUhEZeBu0A9
         I3eOHu5BV1maFkenfN+G7UK00SL72QOevOI+RTqu5UOuIsOTBs6p739YVF8Eh9XIrBRt
         yJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4hPxRFSewx0vrQrXVagzhgzCPrSg32067Y/9VaQerDM=;
        b=mrCvRFruixC6Hv8w+KJcgzbbmhZJWV8OsMLW/iEZgKx3mGVZcV4BysL/g2/2HOc/jj
         hFtqCAY+ynD6Otmq403PTMMDkC4UFxi4GXkBOhZWQIQf5olOTQGpO3u1I4Ys6jxRJ2wM
         OflVdVZo6Qzy1rE3KeYKxz69Zii6Na2MF+XCFbVWCoertGg2ydoz1+p506/BKNWFVkE4
         g1YCIilJIwCvbmAhHFWes1khdTgPPVK6geLIXGJFD1rvluBdY+R3Y/fHkfimc/gr8yup
         dm24BSNLBJ9sGjIGRXf6ABuHxsN3uG6AcD/ozGxDdWMKO07427uw6DeJH/Q+Q6xkcm83
         YJQA==
X-Gm-Message-State: AOAM531qQ4TlPaOm0L2mlbo6+hwge/XgOVterdg+hF46EupsXlBZvsyK
        pYEoWeHd2Miu6gAHsTzKHyrDKw==
X-Google-Smtp-Source: ABdhPJwdi1GhXw4sG68jkRbahDa/JrmEYJ2V+W1Rl1kxmCR7PgpCU2XfntfNA8PXXiw+0RGA/+ME1w==
X-Received: by 2002:a05:600c:35d0:: with SMTP id r16mr23133391wmq.97.1634302233790;
        Fri, 15 Oct 2021 05:50:33 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:7ce7:a27f:aba7:bb9d])
        by smtp.gmail.com with ESMTPSA id a2sm5468403wrq.9.2021.10.15.05.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 05:50:33 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 2/4] sched/fair: Skip update_blocked_averages if we are defering load balance
Date:   Fri, 15 Oct 2021 14:46:52 +0200
Message-Id: <20211015124654.18093-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211015124654.18093-1-vincent.guittot@linaro.org>
References: <20211015124654.18093-1-vincent.guittot@linaro.org>
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
index a7429dec8e2f..6b8065b72847 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10874,17 +10874,20 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	 */
 	rq_unpin_lock(this_rq, rf);
 
+	rcu_read_lock();
+	sd = rcu_dereference_check_sched_domain(this_rq->sd);
+
 	if (this_rq->avg_idle < sysctl_sched_migration_cost ||
-	    !READ_ONCE(this_rq->rd->overload)) {
+	    !READ_ONCE(this_rq->rd->overload) ||
+	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
 
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

