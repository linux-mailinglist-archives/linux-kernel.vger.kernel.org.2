Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C6538D2A2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 02:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbhEVAqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 20:46:04 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:42303 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230190AbhEVApz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 20:45:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1621644271; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=v70XeN85MmH6JrlfKKi2igLz2OW8mPpsFWoQ9lHM85k=; b=o688NxTrCglCD/Sp8OtT/vu6ste81mA2br10GRJYP0kp2gUA9kedRv1zDHAdaCScLHi3gVJb
 Jw7+hGVhWmXEHs2ZUHYUhmF38BC5sT55zWR9RXHS1+CuXnDcPlWgM/2SJEjgbTQWZh15q6yF
 QEyeH3spoNg5ia31xzQd3v1ICOY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 60a853eab15734c8f966ad1e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 22 May 2021 00:44:26
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3F757C433D3; Sat, 22 May 2021 00:44:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from wcheng-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2F96BC433D3;
        Sat, 22 May 2021 00:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2F96BC433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
From:   Wesley Cheng <wcheng@codeaurora.org>
To:     balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        jackp@codeaurora.org, Wesley Cheng <wcheng@codeaurora.org>
Subject: [PATCH] usb: gadget: f_fs: Ensure io_completion_wq is idle during unbind
Date:   Fri, 21 May 2021 17:44:21 -0700
Message-Id: <1621644261-1236-1-git-send-email-wcheng@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During unbind, ffs_func_eps_disable() will be executed, resulting in
completion callbacks for any pending USB requests.  When using AIO,
irrespective of the completion status, io_data work is queued to
io_completion_wq to evaluate and handle the completed requests.  Since
work runs asynchronously to the unbind() routine, there can be a
scenario where the work runs after the USB gadget has been fully
removed, resulting in accessing of a resource which has been already
freed. (i.e. usb_ep_free_request() accessing the USB ep structure)

Explicitly drain the io_completion_wq, instead of relying on the
destroy_workqueue() (in ffs_data_put()) to make sure no pending
completion work items are running.

Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
---
 drivers/usb/gadget/function/f_fs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index bf10919..d4844af 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -3567,6 +3567,9 @@ static void ffs_func_unbind(struct usb_configuration *c,
 		ffs->func = NULL;
 	}
 
+	/* Drain any pending AIO completions */
+	drain_workqueue(ffs->io_completion_wq);
+
 	if (!--opts->refcnt)
 		functionfs_unbind(ffs);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

