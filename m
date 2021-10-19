Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 244D1433612
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 14:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235693AbhJSMiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 08:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235675AbhJSMiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 08:38:00 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC76C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 05:35:47 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r10so47429958wra.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 05:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vPYYr4pBVMPRz0sH/CFJMsTMh+sCd0pG6JGHIgm2CnE=;
        b=BU6jS2CFgNe2tVS9DHn4hURdraVplVhTF5ENa+SNzZGYCi9hnduO37uDV0vxwiHLvy
         Z5nJvvw8rZPokd7J4/m91Cd59CnM4ruzB09N2+vcif4ksWrG4CjwQY8H2EOy2bwOZG+S
         AY6DkNa6p/SIKPW2GRYorAot0hrwzj+T96T2xuFuW3RdWxgLgSpdAAB7vkZyPz2enT/C
         VcNEYMns7uCOQvVxhQFJEtxGheP/omEJ8eYUySVhDeAFL86fncNhFKi41EgeMc5t+0Jd
         S+9AAHrumTWftgy7KU0CEyqhjT7/cMTkgpMKUNvOyARCZKRd1X5qSsB3FWINRwoqt96j
         9jdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vPYYr4pBVMPRz0sH/CFJMsTMh+sCd0pG6JGHIgm2CnE=;
        b=TjPVgAcX6ez1TDjEDK8N2XMM8yDPBU2l6pFI6b+o6Xk2MRY88ld48ws43KC4qQ0gTO
         TNnhW3zJCRq4nQc+PU2VwiLeKwVNZzYrLLn/mlZnv9eIaQQl+f/jVvX9X5Lu0VVAhJfs
         +qAsFOkoQDvUOIJTLQqmbfQm4drIZEfiHIsvU1ByPegNlOle0N1M1BM5zmrbNcmrxqun
         KahKlYyZEEtfd7OJ2+tBK+M0tbHlyjVtb2ySdmCqLCLU138p3QLSQLgspHHO+SfXVA7Y
         cAVZ6gec9maDOCnVQxSTgAfnUtsptt1Bb7oAgXdxqr8DdE1744wQRDHweotZdQFB+v4/
         ZPoA==
X-Gm-Message-State: AOAM533CAoQtuJ3klQU4DvfhJQ+4sG4IjWZuzZ18KS5XGDiX+4K7SO7W
        VbR8TbR4htgg1g9bfrFFru5Xupg9x6pT+A==
X-Google-Smtp-Source: ABdhPJzfju6T2SJlhhj6AC1MjA8qgin7H2pL7AP7YSXjCF7hTmEMIbOu3lssecNLmVTHUnOQ++NsSA==
X-Received: by 2002:a5d:6d51:: with SMTP id k17mr43102683wri.233.1634646946042;
        Tue, 19 Oct 2021 05:35:46 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:6dc7:9883:a79c:5be9])
        by smtp.gmail.com with ESMTPSA id p18sm15263683wrn.41.2021.10.19.05.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 05:35:45 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3 2/5] sched/fair: Skip update_blocked_averages if we are defering load balance
Date:   Tue, 19 Oct 2021 14:35:34 +0200
Message-Id: <20211019123537.17146-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211019123537.17146-1-vincent.guittot@linaro.org>
References: <20211019123537.17146-1-vincent.guittot@linaro.org>
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
index c0145677ee99..c4c36865321b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10873,17 +10873,20 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
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

