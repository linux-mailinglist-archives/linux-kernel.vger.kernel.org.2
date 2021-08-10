Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08EE93E8413
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 22:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbhHJUGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 16:06:25 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:18999 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbhHJUGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 16:06:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628625962; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=6bfmi8AzrJv9+nPqsBRGQGrcOB34hjItme5M0oX8YAo=; b=mfpge3EmRo854xjRloit3VLT9WpnPvqsAIUq7okXYVulE/dr7FOaAaeOM55cIZxCtdy9BiXm
 FOJHF8Icz0ftIfH9mppxns6RzdmruMBuBmIW0Es89Zl+wVeBI8tBXN5V2yxiHqXQB3mZ8ucn
 uvIiUy4734M73EUqfmPrsT0NDIM=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 6112dc1db14e7e2ecb3c966c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 10 Aug 2021 20:05:49
 GMT
Sender: psodagud=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 76167C4323A; Tue, 10 Aug 2021 20:05:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from th-lint-038.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: psodagud)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 386FEC433F1;
        Tue, 10 Aug 2021 20:05:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 386FEC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=psodagud@codeaurora.org
From:   Prasad Sodagudi <psodagud@codeaurora.org>
To:     gregkh@linuxfoundation.org, rjw@rjwysocki.net
Cc:     len.brown@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, pavel@ucw.cz, psodagud@codeaurora.org
Subject: [PATCH v3] PM: sleep: core: Avoid setting power.must_resume to false
Date:   Tue, 10 Aug 2021 13:05:38 -0700
Message-Id: <1628625938-149376-1-git-send-email-psodagud@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are variables(power.may_skip_resume and dev->power.must_resume)
and DPM_FLAG_MAY_SKIP_RESUME flags to control the resume of devices after
a system wide suspend transition.

Setting the DPM_FLAG_MAY_SKIP_RESUME flag means that the driver allows
its "noirq" and "early" resume callbacks to be skipped if the device
can be left in suspend after a system-wide transition into the working
state. PM core determines that the driver's "noirq" and "early" resume
callbacks should be skipped or not with dev_pm_skip_resume() function by
checking power.may_skip_resume variable.

power.must_resume variable is getting set to false in __device_suspend()
function without checking device's DPM_FLAG_MAY_SKIP_RESUME and
dev->power.usage_count variables. In problematic scenario, where
all the devices in the suspend_late stage are successful and some
device can fail to suspend in suspend_noirq phase. So some devices
successfully suspended in suspend_late stage are not getting chance
to execute __device_suspend_noirq() to set dev->power.must_resume
variable to true and not getting resumed in early_resume phase.

Add a check for device's DPM_FLAG_MAY_SKIP_RESUME flag before
setting power.must_resume variable in __device_suspend function.

Fixes: 6e176bf8d461 ("PM: sleep: core: Do not skip callbacks in the resume phase")
Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
---
 V2 -> V3: Format issues patch posting
 V1 -> V2: Fixed indentation and commit text to include scenario
 drivers/base/power/main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index d568772..9ee6987 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1642,7 +1642,11 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
 	}
 
 	dev->power.may_skip_resume = true;
-	dev->power.must_resume = false;
+	if ((atomic_read(&dev->power.usage_count) <= 1) &&
+	     (dev_pm_test_driver_flags(dev, DPM_FLAG_MAY_SKIP_RESUME)))
+		dev->power.must_resume = false;
+	else
+		dev->power.must_resume = true;
 
 	dpm_watchdog_set(&wd, dev);
 	device_lock(dev);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

