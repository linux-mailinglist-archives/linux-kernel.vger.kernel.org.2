Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C426B3D0EA8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 14:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbhGULdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 07:33:09 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:36155 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbhGULdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 07:33:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626869624; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=9ORgIVwVR1hRA3DPeFL9fUMvBLk6pAhPJpSd8Q2TU54=; b=AJiAptwRrO3et1YquBNRj/RFjGX/Ie9bb8oqhyGae2xpkfboqHG+GE7sP8/RgqhLsuhkTEOZ
 MGhBj2fE5/XYHV30m4way19NTOwKsEhAeU3Cemcicup47TX3RdKu+kUoE3GVmNx2vxDYiVjL
 DF/HE6ruotaMfAdcIZ3UuBKATHc=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 60f80f6cb653fbdaddc41e9c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 21 Jul 2021 12:13:32
 GMT
Sender: charante=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6CBD6C43460; Wed, 21 Jul 2021 12:13:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from hu-charante-hyd.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ED701C433D3;
        Wed, 21 Jul 2021 12:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ED701C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=charante@codeaurora.org
From:   Charan Teja Reddy <charante@codeaurora.org>
To:     akpm@linux-foundation.org, vbabka@suse.cz, rientjes@google.com,
        nigupta@nvidia.com, khalid.aziz@oracle.com
Cc:     vinmenon@codeaurora.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Charan Teja Reddy <charante@codeaurora.org>
Subject: [PATCH resend] mm: compaction: optimize proactive compaction deferrals
Date:   Wed, 21 Jul 2021 17:43:19 +0530
Message-Id: <1626869599-25412-1-git-send-email-charante@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vlastimil Babka figured out that when fragmentation score didn't go down
across the proactive compaction i.e. when no progress is made, next wake
up for proactive compaction is deferred for 1 <<
COMPACT_MAX_DEFER_SHIFT, i.e. 64 times, with each wakeup interval of
HPAGE_FRAG_CHECK_INTERVAL_MSEC(=500). In each of this wakeup, it just
decrement 'proactive_defer' counter and goes sleep i.e. it is getting
woken to just decrement a counter. The same deferral time can also
achieved by simply doing the HPAGE_FRAG_CHECK_INTERVAL_MSEC <<
COMPACT_MAX_DEFER_SHIFT thus unnecessary wakeup of kcompact thread is
avoided thus also removes the need of 'proactive_defer' thread counter.

Link: https://lore.kernel.org/linux-fsdevel/88abfdb6-2c13-b5a6-5b46-742d12d1c910@suse.cz/
Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
---
 Changes in V1:
    o Removed the 'proactive_defer' thread counter by optimizing proactive
    o This is a resend as earlier it was clubbed with other changes posted
      at https://lore.kernel.org/patchwork/patch/1448789/	

 mm/compaction.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 621508e..db00dbf 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2885,7 +2885,8 @@ static int kcompactd(void *p)
 {
 	pg_data_t *pgdat = (pg_data_t *)p;
 	struct task_struct *tsk = current;
-	unsigned int proactive_defer = 0;
+	long default_timeout = msecs_to_jiffies(HPAGE_FRAG_CHECK_INTERVAL_MSEC);
+	long timeout = default_timeout;
 
 	const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
 
@@ -2902,23 +2903,30 @@ static int kcompactd(void *p)
 
 		trace_mm_compaction_kcompactd_sleep(pgdat->node_id);
 		if (wait_event_freezable_timeout(pgdat->kcompactd_wait,
-			kcompactd_work_requested(pgdat),
-			msecs_to_jiffies(HPAGE_FRAG_CHECK_INTERVAL_MSEC))) {
+			kcompactd_work_requested(pgdat), timeout)) {
 
 			psi_memstall_enter(&pflags);
 			kcompactd_do_work(pgdat);
 			psi_memstall_leave(&pflags);
+			/*
+			 * Reset the timeout value. The defer timeout by
+			 * proactive compaction can effectively lost
+			 * here but that is fine as the condition of the
+			 * zone changed substantionally and carrying on
+			 * with the previous defer is not useful.
+			 */
+			timeout = default_timeout;
 			continue;
 		}
 
-		/* kcompactd wait timeout */
+		/*
+		 * Start the proactive work with default timeout. Based
+		 * on the fragmentation score, this timeout is updated.
+		 */
+		timeout = default_timeout;
 		if (should_proactive_compact_node(pgdat)) {
 			unsigned int prev_score, score;
 
-			if (proactive_defer) {
-				proactive_defer--;
-				continue;
-			}
 			prev_score = fragmentation_score_node(pgdat);
 			proactive_compact_node(pgdat);
 			score = fragmentation_score_node(pgdat);
@@ -2926,8 +2934,9 @@ static int kcompactd(void *p)
 			 * Defer proactive compaction if the fragmentation
 			 * score did not go down i.e. no progress made.
 			 */
-			proactive_defer = score < prev_score ?
-					0 : 1 << COMPACT_MAX_DEFER_SHIFT;
+			if (unlikely(score >= prev_score))
+				timeout =
+				   default_timeout << COMPACT_MAX_DEFER_SHIFT;
 		}
 	}
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation

