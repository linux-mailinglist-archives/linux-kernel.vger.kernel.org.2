Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5593F3EFE95
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 10:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239611AbhHRIFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 04:05:42 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:58337 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239410AbhHRIEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 04:04:52 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629273858; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=GEfvAY1wCaI/JfDZv+ZAirCByjz3+BoAhqBViHwLftw=; b=E9nDPhSX1NuqqRldARdb6feEV0nU7rLIRjRNb9maVqlxFk20yO/bAZhShHiw8AbtiHwUiwmv
 Ggk5n80IB4jIu/KlJpznaDVVF1SP1O7OuoJIkNr1HBW1O7FIKsBpZxDmZPpAH+BnY4HXea26
 YCrqP+S5zPxwdtybMkQfMgWvzAo=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 611cbef82892f803bc357027 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 18 Aug 2021 08:04:08
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7235CC43618; Wed, 18 Aug 2021 08:04:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from localhost (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 78F16C4338F;
        Wed, 18 Aug 2021 08:04:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 78F16C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        urezki@gmail.com, frederic@kernel.org, boqun.feng@gmail.com,
        Neeraj Upadhyay <neeraju@codeaurora.org>
Subject: [PATCH] rcu: Fix existing exp request check in sync_sched_exp_online_cleanup()
Date:   Wed, 18 Aug 2021 13:34:00 +0530
Message-Id: <1629273840-729-1-git-send-email-neeraju@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sync_sched_exp_online_cleanup() checks to see if RCU needs
an expedited quiescent state from the incoming CPU, sending it
an IPI if so. Before sending IPI, it checks whether expedited
qs need has been already requested for the incoming CPU, by
checking rcu_data.cpu_no_qs.b.exp for the current cpu, on which
sync_sched_exp_online_cleanup() is running. This works for the
case where incoming CPU is same as self. However, for the case
where incoming CPU is different from self, expedited request
won't get marked, which can potentially delay reporting of
expedited quiescent state for the incoming CPU.

Fixes: e015a3411220 ("rcu: Avoid self-IPI in sync_sched_exp_online_cleanup()")
Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
---
 kernel/rcu/tree_exp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index d9e4f8e..f3947c4 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -759,7 +759,7 @@ static void sync_sched_exp_online_cleanup(int cpu)
 	my_cpu = get_cpu();
 	/* Quiescent state either not needed or already requested, leave. */
 	if (!(READ_ONCE(rnp->expmask) & rdp->grpmask) ||
-	    __this_cpu_read(rcu_data.cpu_no_qs.b.exp)) {
+	    rdp->cpu_no_qs.b.exp) {
 		put_cpu();
 		return;
 	}
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
hosted by The Linux Foundation

