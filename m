Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27FCD35941C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 06:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbhDIElK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 00:41:10 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:52569 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233234AbhDIElJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 00:41:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1617943257; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=iCTtN8iyq6nzRdGmRlTCQ07XXrbR9HCHiASV/6UyLgA=; b=I8nzE78228NOJFi7RjcNaMkeG5X0KwE7S0nXJ5bxBIsQeSw/3n+iBUwKPj6qA9P2lulAX6Bt
 oLSL/mUYc57l9tK/PEKNXkKDk0B+uaHloGgmBK33ikuv3Kd2CC6exVbF/3n+S4PsF8iPZgsS
 aAVdGTek+O+6q9e6Ru6SSAskbS8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 606fdad48807bcde1d83ba00 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 09 Apr 2021 04:40:52
 GMT
Sender: deesin=qti.qualcomm.com@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4BA97C43461; Fri,  9 Apr 2021 04:40:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from deesin-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: deesin)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A1CC1C433C6;
        Fri,  9 Apr 2021 04:40:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A1CC1C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=qti.qualcomm.com
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=deesin@qti.qualcomm.com
From:   Deepak Kumar Singh <deesin@qti.qualcomm.com>
To:     bjorn.andersson@linaro.org, clew@codeaurora.org,
        sibis@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Deepak Kumar Singh <deesin@qti.qualcomm.com>,
        Deepak Kumar Singh <deesin@codeaurora.org>,
        Andy Gross <agross@kernel.org>
Subject: [PATCH V2 2/2] soc: qcom: aoss: Add debugfs entry
Date:   Fri,  9 Apr 2021 10:09:48 +0530
Message-Id: <1617943188-23278-3-git-send-email-deesin@qti.qualcomm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617943188-23278-1-git-send-email-deesin@qti.qualcomm.com>
References: <1617943188-23278-1-git-send-email-deesin@qti.qualcomm.com>
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
index 0e397a7..6057bbe 100644
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
@@ -88,6 +89,9 @@ struct qmp {
 	struct clk_hw qdss_clk;
 	struct genpd_onecell_data pd_data;
 	struct qmp_cooling_device *cooling_devs;
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+	struct dentry *debugfs_file;
+#endif /* CONFIG_DEBUG_FS */
 };
 
 struct qmp_pd {
@@ -560,6 +564,34 @@ void qmp_put(struct platform_device *pdev)
 }
 EXPORT_SYMBOL(qmp_put);
 
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+static ssize_t aoss_dbg_write(struct file *file, const char __user *userstr,
+			      size_t len, loff_t *pos)
+{
+	struct qmp *qmp = file->private_data;
+	char buf[QMP_MSG_LEN] = {};
+	int ret;
+
+	if (!len || len >= QMP_MSG_LEN)
+		return -EINVAL;
+
+	ret  = copy_from_user(buf, userstr, len);
+	if (ret) {
+		dev_err(qmp->dev, "copy from user failed, ret:%d\n", ret);
+		return -EFAULT;
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
@@ -616,6 +648,11 @@ static int qmp_probe(struct platform_device *pdev)
 
 	atomic_set(&qmp->orphan, 0);
 
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+	qmp->debugfs_file = debugfs_create_file("aoss_send_message", 0220, NULL,
+						qmp, &aoss_dbg_fops);
+#endif /* CONFIG_DEBUG_FS */
+
 	return 0;
 
 err_remove_qdss_clk:
@@ -632,6 +669,10 @@ static int qmp_remove(struct platform_device *pdev)
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

