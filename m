Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75FCC3F1F62
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 19:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbhHSRv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 13:51:26 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38752 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbhHSRvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 13:51:18 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3D6CA20111;
        Thu, 19 Aug 2021 17:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629395441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KuvQiu5LKZQFu+8mD8swgYmQInz949y0M7/GFw+osLg=;
        b=dma+7MyN4z6DRiIxoB66+aFeXmgcdL0yYQO3X+JaKUQFZmEVI8HEDeOLtvzbwQ+0nlRz04
        tbz6vxbV0Hq+3jZu+MIguZD9q46VbcxDT1kzozKC3HnO90ZMQ5cMw1GsUiz+1yQ+WAWzoy
        WfAAqUvmvlboFtlfqzLnuP3SrqzARNA=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1473213AB1;
        Thu, 19 Aug 2021 17:50:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id aGSJBPGZHmHnOQAAGKfGzw
        (envelope-from <mkoutny@suse.com>); Thu, 19 Aug 2021 17:50:41 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     linux-kernel@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Phil Auld <pauld@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Odin Ugedal <odin@uged.al>, Rik van Riel <riel@surriel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [RFC PATCH v2 1/5] sched/fair: Add ancestors of unthrottled undecayed cfs_rq
Date:   Thu, 19 Aug 2021 19:50:30 +0200
Message-Id: <20210819175034.4577-2-mkoutny@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210819175034.4577-1-mkoutny@suse.com>
References: <20210819175034.4577-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit a7b359fc6a37 ("sched/fair: Correctly insert cfs_rq's to
list on unthrottle") we add cfs_rqs with no runnable tasks but not fully
decayed into the load (leaf) list. We may ignore adding some ancestors
and therefore breaking tmp_alone_branch invariant. This broke LTP test
cfs_bandwidth01 and it was partially fixed in commit fdaba61ef8a2
("sched/fair: Ensure that the CFS parent is added after unthrottling").

I noticed the named test still fails even with the fix (but with low
probability, 1 in ~1000 executions of the test). The reason is when
bailing out of unthrottle_cfs_rq early, we may miss adding ancestors of
the unthrottled cfs_rq, thus, not joining tmp_alone_branch properly.

Fix this by adding ancestors if we notice the unthrottled cfs_rq was
added to the load list.

Fixes: a7b359fc6a37 ("sched/fair: Correctly insert cfs_rq's to list on unthrottle")
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/sched/fair.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 44c452072a1b..2c41a9007928 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4898,8 +4898,16 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	/* update hierarchical throttle state */
 	walk_tg_tree_from(cfs_rq->tg, tg_nop, tg_unthrottle_up, (void *)rq);
 
-	if (!cfs_rq->load.weight)
+	if (!cfs_rq->load.weight) {
+		/* Nothing to run but something to decay? Complete the branch */
+		if (cfs_rq->on_list)
+			for_each_sched_entity(se) {
+				if (list_add_leaf_cfs_rq(group_cfs_rq(se)))
+					break;
+			}
+		assert_list_leaf_cfs_rq(rq);
 		return;
+	}
 
 	task_delta = cfs_rq->h_nr_running;
 	idle_task_delta = cfs_rq->idle_h_nr_running;
-- 
2.32.0

