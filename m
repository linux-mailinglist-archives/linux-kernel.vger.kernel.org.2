Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B059362370
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 17:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245671AbhDPPDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 11:03:13 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:20508 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245644AbhDPPC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 11:02:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618585353; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=NemeUPxarwBZrK5YRV8xc8LveSrkoj7XYSFMg3yRccE=; b=ABpey0zFEAsbIjdIdpYsa5561g+YujFIRs8iSheStH+kCyI6CJ8jjTgomTNGt7DUqquec8nC
 MUWAxwKe15E/u+ZREjhCQho/rVFzq4z2KCSq/Mnf1WY1ITIRnikgjG/OSmpmWaMpCgmNOYcl
 hWJzhWcBEMyygjEOWKxnYo2SzGQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 6079a709215b831afb0a2827 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 16 Apr 2021 15:02:33
 GMT
Sender: charante=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BCACEC43463; Fri, 16 Apr 2021 15:02:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from hydlnxeng14.qualcomm.com (unknown [202.46.23.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B1C0CC43468;
        Fri, 16 Apr 2021 15:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B1C0CC43468
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=charante@codeaurora.org
From:   Charan Teja Reddy <charante@codeaurora.org>
To:     hannes@cmpxchg.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Charan Teja Reddy <charante@codeaurora.org>
Subject: [PATCH V2] sched,psi: fix the 'int' underflow for psi
Date:   Fri, 16 Apr 2021 20:32:16 +0530
Message-Id: <1618585336-37219-1-git-send-email-charante@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

psi_group_cpu->tasks, represented by the unsigned int, stores the number
of tasks that could be stalled on a psi resource(io/mem/cpu).
Decrementing these counters at zero leads to wrapping which further
leads to the psi_group_cpu->state_mask is being set with the respective
pressure state. This could result into the unnecessary time sampling for
the pressure state thus cause the spurious psi events. This can further
lead to wrong actions being taken at the user land based on these psi
events.
Though psi_bug is set under these conditions but that just for debug
purpose. Fix it by decrementing the ->tasks count only when it is
non-zero.

Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
---
 
Changes in V1: https://lore.kernel.org/patchwork/patch/1413894/

 kernel/sched/psi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 967732c..651218d 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -711,14 +711,15 @@ static void psi_group_change(struct psi_group *group, int cpu,
 	for (t = 0, m = clear; m; m &= ~(1 << t), t++) {
 		if (!(m & (1 << t)))
 			continue;
-		if (groupc->tasks[t] == 0 && !psi_bug) {
+		if (groupc->tasks[t]) {
+			groupc->tasks[t]--;
+		} else if (!psi_bug) {
 			printk_deferred(KERN_ERR "psi: task underflow! cpu=%d t=%d tasks=[%u %u %u %u] clear=%x set=%x\n",
 					cpu, t, groupc->tasks[0],
 					groupc->tasks[1], groupc->tasks[2],
 					groupc->tasks[3], clear, set);
 			psi_bug = 1;
 		}
-		groupc->tasks[t]--;
 	}
 
 	for (t = 0; set; set &= ~(1 << t), t++)
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation

