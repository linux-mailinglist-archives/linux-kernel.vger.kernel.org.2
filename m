Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6043D5CE8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 17:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbhGZOos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 10:44:48 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:58785 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234823AbhGZOor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 10:44:47 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1627313116; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=ET5F1XL2+Z48sov9edgoyvRRPDF/nZF66ADfByPMBt4=; b=JOJn/ZyXnGDsHBMTdV5LV8RqS2BMLw0KPPcdkiZ4S8g+smag4GSEo0mftIILR5koSo494As9
 78/88r7oXL1KIUG/Zapt9RPwDG2+0kYQuPFhGi/rj9RFHYnDfz5PkNVYH6M0Wp4rXbElFWHg
 AdJzk3MXHlbm7cL9pwhdapHlr0o=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 60fed3c2b653fbdadd1b1eb5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 26 Jul 2021 15:24:50
 GMT
Sender: psodagud=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 35D7BC433D3; Mon, 26 Jul 2021 15:24:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from th-lint-038.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: psodagud)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D5E34C433F1;
        Mon, 26 Jul 2021 15:24:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D5E34C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=psodagud@codeaurora.org
From:   Prasad Sodagudi <psodagud@codeaurora.org>
To:     rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz,
        gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prasad Sodagudi <psodagud@codeaurora.org>
Subject: [PATCH] PM: sleep: core: Avoid setting power.must_resume to false
Date:   Mon, 26 Jul 2021 08:24:34 -0700
Message-Id: <1627313074-436260-1-git-send-email-psodagud@codeaurora.org>
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
dev->power.usage_count variables. This is leading to failure to call
resume handler for some of the devices suspended in early suspend phase.
So check device's DPM_FLAG_MAY_SKIP_RESUME flag before
setting power.must_resume variable.

Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
---
 drivers/base/power/main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index d568772..8eebc4d 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1642,7 +1642,11 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
 	}
 
 	dev->power.may_skip_resume = true;
-	dev->power.must_resume = false;
+	if ((atomic_read(&dev->power.usage_count) <= 1) &&
+			(dev_pm_test_driver_flags(dev, DPM_FLAG_MAY_SKIP_RESUME)))
+		dev->power.must_resume = false;
+	else
+		dev->power.must_resume = true;
 
 	dpm_watchdog_set(&wd, dev);
 	device_lock(dev);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

