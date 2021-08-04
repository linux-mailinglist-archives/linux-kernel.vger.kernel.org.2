Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3DA03E06F6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 19:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239971AbhHDRwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 13:52:08 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:21834 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbhHDRwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 13:52:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628099514; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=lPc0mCqa9JMqaOZK2NgzpKEcvbQpfvM5irA/LJHPa3Y=; b=l1rA+D5ytWJ2UBL8TJ94K7mvZ4HhXDhNJuQs1mvM6vmkprIt6jEh0Bsj4UvinvYvp2p12a1V
 72kRrn/32dOHL9/LMheDeL+EWQCAadoP8nTwxPWqx/9hjxAbZE+YwWWLnsFGKBTeQXM35Cjh
 6HLZRRKLYzTySgtKIc/V6RrnhqQ=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 610ad3b5041a739c46a0f97a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 04 Aug 2021 17:51:49
 GMT
Sender: rishabhb=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A4847C4338A; Wed,  4 Aug 2021 17:51:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from rishabhb-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4578EC433F1;
        Wed,  4 Aug 2021 17:51:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4578EC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rishabhb@codeaurora.org
From:   Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     sudeep.holla@arm.com, cristian.marussi@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        avajid@codeaurora.org, adharmap@codeaurora.org,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH v2] firmware: arm_scmi: Free mailbox channels if probe fails
Date:   Wed,  4 Aug 2021 10:51:39 -0700
Message-Id: <1628099499-27394-1-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mailbox channels for the base protocol are setup during probe.
There can be a scenario where probe fails to acquire the base
protocol due to a timeout leading to cleaning up of all device
managed memory including the scmi_mailbox structure setup during
mailbox_chan_setup function.
[   12.735104]arm-scmi soc:qcom,scmi: timed out in resp(caller: version_get+0x84/0x140)
[   12.735224]arm-scmi soc:qcom,scmi: unable to communicate with SCMI
[   12.735947]arm-scmi: probe of soc:qcom,scmi failed with error -110

Now when a message arrives at cpu slightly after the timeout, the mailbox
controller will try to call the rx_callback of the client and might end
up accessing freed memory.
[   12.758363][    C0] Call trace:
[   12.758367][    C0]  rx_callback+0x24/0x160
[   12.758372][    C0]  mbox_chan_received_data+0x44/0x94
[   12.758386][    C0]  __handle_irq_event_percpu+0xd4/0x240
This patch frees the mailbox channels setup during probe and adds some more
error handling in case the probe fails.

Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
---
 drivers/firmware/arm_scmi/driver.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 9b2e8d4..aab2ac1 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1390,6 +1390,21 @@ void scmi_protocol_device_unrequest(const struct scmi_device_id *id_table)
 	mutex_unlock(&scmi_requested_devices_mtx);
 }
 
+static int cleanup_txrx_channels(struct scmi_info *info)
+{
+	int ret;
+	struct idr *idr = &info->tx_idr;
+
+	ret = idr_for_each(idr, info->desc->ops->chan_free, idr);
+	idr_destroy(&info->tx_idr);
+
+	idr = &info->rx_idr;
+	ret = idr_for_each(idr, info->desc->ops->chan_free, idr);
+	idr_destroy(&info->rx_idr);
+
+	return ret;
+}
+
 static int scmi_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -1430,7 +1445,7 @@ static int scmi_probe(struct platform_device *pdev)
 
 	ret = scmi_xfer_info_init(info);
 	if (ret)
-		return ret;
+		goto clear_txrx_setup;
 
 	if (scmi_notification_init(handle))
 		dev_err(dev, "SCMI Notifications NOT available.\n");
@@ -1443,7 +1458,7 @@ static int scmi_probe(struct platform_device *pdev)
 	ret = scmi_protocol_acquire(handle, SCMI_PROTOCOL_BASE);
 	if (ret) {
 		dev_err(dev, "unable to communicate with SCMI\n");
-		return ret;
+		goto notification_exit;
 	}
 
 	mutex_lock(&scmi_list_mutex);
@@ -1482,6 +1497,12 @@ static int scmi_probe(struct platform_device *pdev)
 	}
 
 	return 0;
+
+notification_exit:
+	scmi_notification_exit(&info->handle);
+clear_txrx_setup:
+	cleanup_txrx_channels(info);
+	return ret;
 }
 
 void scmi_free_channel(struct scmi_chan_info *cinfo, struct idr *idr, int id)
@@ -1493,7 +1514,6 @@ static int scmi_remove(struct platform_device *pdev)
 {
 	int ret = 0, id;
 	struct scmi_info *info = platform_get_drvdata(pdev);
-	struct idr *idr = &info->tx_idr;
 	struct device_node *child;
 
 	mutex_lock(&scmi_list_mutex);
@@ -1517,14 +1537,7 @@ static int scmi_remove(struct platform_device *pdev)
 	idr_destroy(&info->active_protocols);
 
 	/* Safe to free channels since no more users */
-	ret = idr_for_each(idr, info->desc->ops->chan_free, idr);
-	idr_destroy(&info->tx_idr);
-
-	idr = &info->rx_idr;
-	ret = idr_for_each(idr, info->desc->ops->chan_free, idr);
-	idr_destroy(&info->rx_idr);
-
-	return ret;
+	return cleanup_txrx_channels(info);
 }
 
 static ssize_t protocol_version_show(struct device *dev,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

