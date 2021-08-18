Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F653EFDC8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 09:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239223AbhHRHaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 03:30:46 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:26013 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239181AbhHRHaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 03:30:08 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629271774; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=ecbXpM7Xv2s+HA8vQcSNr4fgNRxFBHCCZBRsDf2Sjgc=; b=OqAlqp9bscLIeVBzsp9B/TcJPFzeWRhO5gGM5NtWhj/WPsOW/SdBSQoBGMtVVnbXQfnV3a+s
 a5cNQnu+bXtWOJKvf7Gl5yFEzplZ2LOxmfxmXgbWDGO4yEApY0kILY0zVpy+FpXpf0M4cHha
 FF61Hby7uazyGvDbvFefOCN27A8=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 611cb6ca2892f803bc23b1d3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 18 Aug 2021 07:29:14
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 29771C43616; Wed, 18 Aug 2021 07:29:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from localhost (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8236EC4338F;
        Wed, 18 Aug 2021 07:29:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 8236EC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        urezki@gmail.com, frederic@kernel.org, boqun.feng@gmail.com,
        Neeraj Upadhyay <neeraju@codeaurora.org>
Subject: [PATCH 4/5] rcu-tasks: Fix read-side primitives comment for call_rcu_tasks_trace
Date:   Wed, 18 Aug 2021 12:58:42 +0530
Message-Id: <1629271723-3816-5-git-send-email-neeraju@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1629271723-3816-1-git-send-email-neeraju@codeaurora.org>
References: <1629271723-3816-1-git-send-email-neeraju@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

call_rcu_tasks_trace() does have read-side primitives - rcu_read_lock_trace()
and rcu_read_unlock_trace(). Fix this information in the comments.

Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
---
 kernel/rcu/tasks.h | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 244e06a..5f9c14c 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1214,13 +1214,9 @@ static void exit_tasks_rcu_finish_trace(struct task_struct *t)
  *
  * The callback function will be invoked some time after a full grace
  * period elapses, in other words after all currently executing RCU
- * read-side critical sections have completed. call_rcu_tasks_trace()
- * assumes that the read-side critical sections end at context switch,
- * cond_resched_rcu_qs(), or transition to usermode execution.  As such,
- * there are no read-side primitives analogous to rcu_read_lock() and
- * rcu_read_unlock() because this primitive is intended to determine
- * that all tasks have passed through a safe state, not so much for
- * data-structure synchronization.
+ * read-side critical sections have completed. These read-side
+ * critical sections are delimited by calls to rcu_read_lock_trace()
+ * and rcu_read_unlock_trace().
  *
  * See the description of call_rcu() for more detailed information on
  * memory ordering guarantees.
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
hosted by The Linux Foundation

