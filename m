Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA7F63B2839
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 09:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbhFXHJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 03:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbhFXHJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 03:09:33 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16054C061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 00:06:51 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m3so3189107wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 00:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=viRPAsNP7Rd7d9L2Z0QK25s7MR3CwIQCAzrWD9QFcVk=;
        b=M7zq+Qj+3Dnl63YIISq3AUpLw2T8mAG7KCom1oq8DyISRdjbE1g2HjkIvuZLZ9B9z1
         P3ycGwf7DRV/zsq/cmHMEqofTj2C9Ei+kiv+vDcpOah/qUS9wF8SkuAsJ7RQu2NrQDuN
         gg7P/Uyq/wMHG9BdhIFyoTGBeWh+sNIf9Hs0M8rQVP0aqPL/o2q8Ul23/4BQ++oXKH2A
         atmxVBZD+CPato2L29MqtglTId9W8xo0Lmy0CxWdPCRfMIKVyUWDrK4BPoSDjxP6xuZZ
         zuXEtRtCEeL8K6ZAWc3UeqL9QZTu3TsoBljlzMEBsUTZV+VOknEjI/eq02a9WgsUalDk
         yHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=viRPAsNP7Rd7d9L2Z0QK25s7MR3CwIQCAzrWD9QFcVk=;
        b=rvOnYtaDIRUoH6Vth3F6SkY/V7CJwkCBSJtbZB4DWcrxlLthXqOcLgN1+dB1jxjPf+
         cE4MQq5ai57eprzCqVBN2V2juyjAL99mtxseG6PyLn1uv9ii2FxbHeYnInjSGjFTBIci
         WdBMArUGGuFjipK1PBEjQ1RdN3Ib+NldKTm7TWcWkZA2eAaxMeGCrLHZ/mD9de4ugsiW
         gICBi0fR7AAO4a51mZwCczI8Alq0pGlKOpeOtmfr5/uGLJZodDFFfer2JOG6k+B5nlb7
         5LaUMOwbtKeOJ4HSXakZNg4ZIE9eHbgLd7lnp2bL6ZKVxrk3gqYEpDZX9sKcUbYh6QQz
         +f1w==
X-Gm-Message-State: AOAM5333ywBoJ1ja+cCLQf3QfAYAbvXk7z7th7l3eKbzY3qCsKwIa2kM
        816/MLd4qkgBC+hHHq3JqZyTNaiB3Lc=
X-Google-Smtp-Source: ABdhPJzCo8guzg62ZU08iJDtcGnB7yY0ixiImTiOSPnHHWC6mGKT+hMJbQeetUGOBSvaV2TkZG17Tw==
X-Received: by 2002:a1c:a101:: with SMTP id k1mr2454091wme.17.1624518409756;
        Thu, 24 Jun 2021 00:06:49 -0700 (PDT)
Received: from gmail.com (0526E2ED.dsl.pool.telekom.hu. [5.38.226.237])
        by smtp.gmail.com with ESMTPSA id h6sm8149933wmc.40.2021.06.24.00.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 00:06:49 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 24 Jun 2021 09:06:47 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] scheduler fix
Message-ID: <YNQvB82UKfDV57eE@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2021-06-24

   # HEAD: fdaba61ef8a268d4136d0a113d153f7a89eb9984 sched/fair: Ensure that the CFS parent is added after unthrottling

A last minute cgroup bandwidth scheduling fix for a recently
introduced logic fail which triggered a kernel warning by
LTP's cfs_bandwidth01.

 Thanks,

	Ingo

------------------>
Rik van Riel (1):
      sched/fair: Ensure that the CFS parent is added after unthrottling


 kernel/sched/fair.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bfaa6e1f6067..23663318fb81 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3298,6 +3298,31 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
 
 #ifdef CONFIG_SMP
 #ifdef CONFIG_FAIR_GROUP_SCHED
+/*
+ * Because list_add_leaf_cfs_rq always places a child cfs_rq on the list
+ * immediately before a parent cfs_rq, and cfs_rqs are removed from the list
+ * bottom-up, we only have to test whether the cfs_rq before us on the list
+ * is our child.
+ * If cfs_rq is not on the list, test whether a child needs its to be added to
+ * connect a branch to the tree  * (see list_add_leaf_cfs_rq() for details).
+ */
+static inline bool child_cfs_rq_on_list(struct cfs_rq *cfs_rq)
+{
+	struct cfs_rq *prev_cfs_rq;
+	struct list_head *prev;
+
+	if (cfs_rq->on_list) {
+		prev = cfs_rq->leaf_cfs_rq_list.prev;
+	} else {
+		struct rq *rq = rq_of(cfs_rq);
+
+		prev = rq->tmp_alone_branch;
+	}
+
+	prev_cfs_rq = container_of(prev, struct cfs_rq, leaf_cfs_rq_list);
+
+	return (prev_cfs_rq->tg->parent == cfs_rq->tg);
+}
 
 static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 {
@@ -3313,6 +3338,9 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 	if (cfs_rq->avg.runnable_sum)
 		return false;
 
+	if (child_cfs_rq_on_list(cfs_rq))
+		return false;
+
 	return true;
 }
 
