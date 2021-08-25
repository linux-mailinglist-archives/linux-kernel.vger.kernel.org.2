Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54783F7026
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 09:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239198AbhHYHMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 03:12:21 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:34032 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239052AbhHYHMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 03:12:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629875487; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=NCqkmtmm5j+H1C/l7UvmVOpMSwLfWqn8gxg5rAKzY3A=; b=i58jnuC1+vMhFPQd9Z1RksbTMySkrtcAYk82Q8czBZbBSgS1ekkxh8jwtadRjIiyh4ZZ9qR/
 B9iaths0uhG2sIUN1yocgRpUhm93wBslQVZ021rL8xAnAfn3teA6szQnFi3cQ+yOLHqhrMp8
 W62GKolF2dTI5s0pnEww1sYi/Fk=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 6125ed1fe0fcecca19efe627 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 25 Aug 2021 07:11:27
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 98060C4361A; Wed, 25 Aug 2021 07:11:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from localhost (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DF59EC4338F;
        Wed, 25 Aug 2021 07:11:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org DF59EC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        urezki@gmail.com, frederic@kernel.org, boqun.feng@gmail.com,
        Neeraj Upadhyay <neeraju@codeaurora.org>
Subject: [PATCH v2 3/5] rcu-tasks: Correct check for no_hz_full cpu in show_stalled_task_trace
Date:   Wed, 25 Aug 2021 12:40:49 +0530
Message-Id: <1629875451-20628-4-git-send-email-neeraju@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1629875451-20628-1-git-send-email-neeraju@codeaurora.org>
References: <1629875451-20628-1-git-send-email-neeraju@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct the check for no_hz_full cpu in show_stalled_task_trace(),
to include cpu 0.

Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
---
 kernel/rcu/tasks.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 9db7293..244e06a 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1091,7 +1091,7 @@ static void show_stalled_task_trace(struct task_struct *t, bool *firstreport)
 		 t->pid,
 		 ".I"[READ_ONCE(t->trc_ipi_to_cpu) > 0],
 		 ".i"[is_idle_task(t)],
-		 ".N"[cpu > 0 && tick_nohz_full_cpu(cpu)],
+		 ".N"[cpu >= 0 && tick_nohz_full_cpu(cpu)],
 		 READ_ONCE(t->trc_reader_nesting),
 		 " N"[!!READ_ONCE(t->trc_reader_special.b.need_qs)],
 		 cpu);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
hosted by The Linux Foundation

