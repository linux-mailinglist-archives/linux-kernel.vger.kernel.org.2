Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C97360BCE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 16:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbhDOObI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 10:31:08 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:55317 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230056AbhDOObG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 10:31:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618497043; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=0Ah5ryHnTWmb/aziyAyTop0bFjbjJbdTwgbBd55EmSw=; b=vl5UUJ6oMkQtDIdT0Ty1FE3vTOuTkAp7fomDpOwKCY1rftJnwJQu5yk0bf7v9yfhqqIJ9hLC
 3Ys+Uu4LM8JuUaRlbirtNzLJlewFNH9NxA96ryRCOHFNuuIApFkyQH2RT25ql86cIn6loLK5
 TqbDA1gbFdQW0OS3TkecmfKAbIY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 60784df774f773a66492b4ea (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 15 Apr 2021 14:30:15
 GMT
Sender: charante=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E7CBEC43461; Thu, 15 Apr 2021 14:30:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from hydlnxeng14.qualcomm.com (unknown [202.46.23.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B7F8EC433CA;
        Thu, 15 Apr 2021 14:30:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B7F8EC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=charante@codeaurora.org
From:   Charan Teja Reddy <charante@codeaurora.org>
To:     hannes@cmpxchg.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Charan Teja Reddy <charante@codeaurora.org>
Subject: [PATCH] sched,psi: fix the 'int' underflow for psi
Date:   Thu, 15 Apr 2021 19:59:41 +0530
Message-Id: <1618496981-6148-1-git-send-email-charante@codeaurora.org>
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
 kernel/sched/psi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 967732c..f925468 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -718,7 +718,8 @@ static void psi_group_change(struct psi_group *group, int cpu,
 					groupc->tasks[3], clear, set);
 			psi_bug = 1;
 		}
-		groupc->tasks[t]--;
+		if (groupc->tasks[t])
+			groupc->tasks[t]--;
 	}
 
 	for (t = 0; set; set &= ~(1 << t), t++)
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation

