Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913613DB946
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 15:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238945AbhG3NXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 09:23:53 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:49658 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbhG3NXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 09:23:52 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1627651428; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=g1LIqeq8dIBjRdXEj0V0n2bb4vQ4QikSF0Ljhxz7LBI=; b=XeCYTGYI5rxTWyiF2Qe8Wu3J1m5ON5RVkhNO8WN2BtDwi/3Kz8OrOhX8/e1B8O72b5+cs7jC
 toAp0FPI9P/7nddCZxWxaoJ0/oQqznzmEWGsxkR7jNNLI7oJgJfvKZ6rfw364jxXV6DmS7/N
 Afpw2HwCxCHLHDHNzNUI22b4pvQ=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 6103fd4b96a66e66b28b9b42 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 30 Jul 2021 13:23:23
 GMT
Sender: kamaagra=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E9875C4338A; Fri, 30 Jul 2021 13:23:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from kamaagra-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kamaagra)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8F917C433F1;
        Fri, 30 Jul 2021 13:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8F917C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kamaagra@codeaurora.org
From:   Kamal Agrawal <kamaagra@codeaurora.org>
To:     rostedt@goodmis.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org
Cc:     linux-arm-msm@vger.kernel.org
Subject: [PATCH] tracing: Fix NULL pointer dereference in start_creating
Date:   Fri, 30 Jul 2021 18:53:06 +0530
Message-Id: <1627651386-21315-1-git-send-email-kamaagra@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The event_trace_add_tracer() can fail. In this case, it leads to a crash
in start_creating with below call stack. Handle the error scenario
properly in trace_array_create_dir.

Call trace:
down_write+0x7c/0x204
start_creating.25017+0x6c/0x194
tracefs_create_file+0xc4/0x2b4
init_tracer_tracefs+0x5c/0x940
trace_array_create_dir+0x58/0xb4
trace_array_create+0x1bc/0x2b8
trace_array_get_by_name+0xdc/0x18c

Fixes: 4114fbfd
Signed-off-by: Kamal Agrawal <kamaagra@codeaurora.org>
---
 kernel/trace/trace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c59dd35..33899a7 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9135,8 +9135,10 @@ static int trace_array_create_dir(struct trace_array *tr)
 		return -EINVAL;
 
 	ret = event_trace_add_tracer(tr->dir, tr);
-	if (ret)
+	if (ret) {
 		tracefs_remove(tr->dir);
+		return ret;
+	}
 
 	init_tracer_tracefs(tr, tr->dir);
 	__update_tracer_options(tr);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

