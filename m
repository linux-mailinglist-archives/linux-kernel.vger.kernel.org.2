Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87FBC40FC68
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 17:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240317AbhIQPdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 11:33:35 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60776 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240032AbhIQPdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 11:33:33 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C08A62216C;
        Fri, 17 Sep 2021 15:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631892730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3aQt1NizGpK2GW0zdpJh8dkgyJAPuWomew7Rj90QvRI=;
        b=XLml275+eRGdEmg22mcGTOWpusEPiJfJlmEN8ofkm6hMrcLOMtuCtH5oddnnNrbPCCBUVq
        TW5oLM8xohyGgT0hAZFJUcwR1cA+ZEFw5Y4zmuBpnbxFNPEFRF4Ef9q9IYGfW8e0k9taLA
        MedhkH3m8GUaVzziD6FZJW1TShjYHuk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8C1E813C3D;
        Fri, 17 Sep 2021 15:32:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id K4JJIfq0RGF5OAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 17 Sep 2021 15:32:10 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Phil Auld <pauld@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Odin Ugedal <odin@uged.al>, Rik van Riel <riel@surriel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [PATCH v3] sched/fair: Add ancestors of unthrottled undecayed cfs_rq
Date:   Fri, 17 Sep 2021 17:30:37 +0200
Message-Id: <20210917153037.11176-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.32.0
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

Changes since v2 [1]:
- jump to completion for loop, don't duplicate it
- singled out of the series (to handle a fix separately from the rest)

[1] https://lore.kernel.org/r/20210819175034.4577-2-mkoutny@suse.com/

 kernel/sched/fair.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ff69f245b939..f6a05d9b5443 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4936,8 +4936,12 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	/* update hierarchical throttle state */
 	walk_tg_tree_from(cfs_rq->tg, tg_nop, tg_unthrottle_up, (void *)rq);
 
-	if (!cfs_rq->load.weight)
+	/* Nothing to run but something to decay (on_list)? Complete the branch */
+	if (!cfs_rq->load.weight) {
+		if (cfs_rq->on_list)
+			goto unthrottle_throttle;
 		return;
+	}
 
 	task_delta = cfs_rq->h_nr_running;
 	idle_task_delta = cfs_rq->idle_h_nr_running;
-- 
2.32.0

