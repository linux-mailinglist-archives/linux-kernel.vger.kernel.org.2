Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1403C352689
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 08:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbhDBGS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 02:18:28 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:34924 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233841AbhDBGSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 02:18:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1617344304; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=+fGTIpJoMrZer2FW4wtM/kmw4106dhSKX2a1plXyCSI=; b=rDb6cGq6wl9XsueUfRqXqGtoswfvxzZtqHHR61kRAR6rGSo4ERCUJBk6BKrAhZ6ooEHn3jvW
 VjNvIdOuoQe9x3pxsI8cb2szSoyzdnb8Hu8EjeVkRmbpYDbGAYobXYy4Z0hjklRTvZkBb3Sd
 7i445LRWUWRryhDSGlx7PeXRo+w=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 6066b7308807bcde1d04b4ff (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 02 Apr 2021 06:18:24
 GMT
Sender: deesin=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D88C6C43463; Fri,  2 Apr 2021 06:18:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from deesin-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: deesin)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7CF98C43462;
        Fri,  2 Apr 2021 06:18:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7CF98C43462
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=deesin@codeaurora.org
From:   Deepak Kumar Singh <deesin@codeaurora.org>
To:     bjorn.andersson@linaro.org, clew@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Deepak Kumar Singh <deesin@codeaurora.org>,
        Andy Gross <agross@kernel.org>
Subject: [PATCH V1 2/2] soc: qcom: aoss: Add debugfs entry
Date:   Fri,  2 Apr 2021 11:47:18 +0530
Message-Id: <1617344238-12137-3-git-send-email-deesin@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617344238-12137-1-git-send-email-deesin@codeaurora.org>
References: <1617344238-12137-1-git-send-email-deesin@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It can be useful to control the different power states of various
parts of hardware for device testing. Add a debugfs node for qmp so
messages can be sent to aoss for debugging and testing purposes.

Signed-off-by: Chris Lew <clew@codeaurora.org>
Signed-off-by: Deepak Kumar Singh <deesin@codeaurora.org>
---
 drivers/soc/qcom/qcom_aoss.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
index 5c643f0..1789880 100644
--- a/drivers/soc/qcom/qcom_aoss.c
+++ b/drivers/soc/qcom/qcom_aoss.c
@@ -4,6 +4,7 @@
  */
 #include <dt-bindings/power/qcom-aoss-qmp.h>
 #include <linux/clk-provider.h>
+#include <linux/debugfs.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/mailbox_client.h>
@@ -86,6 +87,9 @@ struct qmp {
 	struct clk_hw qdss_clk;
 	struct genpd_onecell_data pd_data;
 	struct qmp_cooling_device *cooling_devs;
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+	struct dentry *debugfs_file;
+#endif /* CONFIG_DEBUG_FS */
 };
 
 struct qmp_pd {
@@ -549,6 +553,34 @@ struct qmp *qmp_get(struct device *dev)
 }
 EXPORT_SYMBOL(qmp_get);
 
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+static ssize_t aoss_dbg_write(struct file *file, const char __user *userstr,
+			      size_t len, loff_t *pos)
+{
+	struct qmp *qmp = file->private_data;
+	char buf[QMP_MSG_LEN] = {};
+	int ret;
+
+	if (!len || len >= QMP_MSG_LEN)
+		return len;
+
+	ret  = copy_from_user(buf, userstr, len);
+	if (ret) {
+		dev_err(qmp->dev, "copy from user failed, ret:%d\n", ret);
+		return len;
+	}
+
+	ret = qmp_send(qmp, buf, QMP_MSG_LEN);
+
+	return ret ? ret : len;
+}
+
+static const struct file_operations aoss_dbg_fops = {
+	.open = simple_open,
+	.write = aoss_dbg_write,
+};
+#endif /* CONFIG_DEBUG_FS */
+
 static int qmp_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -603,6 +635,11 @@ static int qmp_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, qmp);
 
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+	qmp->debugfs_file = debugfs_create_file("aoss_send_message", 0220, NULL,
+						qmp, &aoss_dbg_fops);
+#endif /* CONFIG_DEBUG_FS */
+
 	return 0;
 
 err_remove_qdss_clk:
@@ -619,6 +656,10 @@ static int qmp_remove(struct platform_device *pdev)
 {
 	struct qmp *qmp = platform_get_drvdata(pdev);
 
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+	debugfs_remove(qmp->debugfs_file);
+#endif /* CONFIG_DEBUG_FS */
+
 	qmp_qdss_clk_remove(qmp);
 	qmp_pd_remove(qmp);
 	qmp_cooling_devices_remove(qmp);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

