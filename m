Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F123DF7C1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 00:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbhHCWWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 18:22:50 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:48859 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229663AbhHCWWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 18:22:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628029358; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=xzpg5pA0ExfM1REjxgNV+oHxyk1EtEF9kRHLopdOfbk=; b=I++EZ8Fkw+R0MQ6QTXnpbs1SF+oAtUUln4dbUbVmlDnqWoPa/7ktf2WrNwUj2R5qokcslwpG
 JoFxdafrjQq8z7Bi055uQ7r/92N/ajNVhcuTKstZBP8j8lAVUVg+nGqL1sX7hWEFM1iCoMmI
 xMYBTuF6L4DtDEE1wnnBhsTLVPg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 6109c1a8dc54451a537a3d70 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 03 Aug 2021 22:22:32
 GMT
Sender: rishabhb=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3D372C433D3; Tue,  3 Aug 2021 22:22:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from rishabhb-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1A520C433F1;
        Tue,  3 Aug 2021 22:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1A520C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rishabhb@codeaurora.org
From:   Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     sudeep.holla@arm.com, cristian.marussi@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        avajid@codeaurora.org, adharmap@codeaurora.org,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH] firmware: arm_scmi: Free mailbox channels if probe fails
Date:   Tue,  3 Aug 2021 15:22:22 -0700
Message-Id: <1628029342-3638-1-git-send-email-rishabhb@codeaurora.org>
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

Change-Id: I1214ec2c4c92c4a3ca5fa73de11e0e403b13b46a
Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
---
 drivers/firmware/arm_scmi/driver.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 9b2e8d4..518c7b9 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1430,7 +1430,7 @@ static int scmi_probe(struct platform_device *pdev)
 
 	ret = scmi_xfer_info_init(info);
 	if (ret)
-		return ret;
+		goto clear_txrx_setup;
 
 	if (scmi_notification_init(handle))
 		dev_err(dev, "SCMI Notifications NOT available.\n");
@@ -1443,7 +1443,7 @@ static int scmi_probe(struct platform_device *pdev)
 	ret = scmi_protocol_acquire(handle, SCMI_PROTOCOL_BASE);
 	if (ret) {
 		dev_err(dev, "unable to communicate with SCMI\n");
-		return ret;
+		goto notification_exit;
 	}
 
 	mutex_lock(&scmi_list_mutex);
@@ -1482,6 +1482,13 @@ static int scmi_probe(struct platform_device *pdev)
 	}
 
 	return 0;
+
+notification_exit:
+	scmi_notification_exit(&info->handle);
+clear_txrx_setup:
+	idr_for_each(&info->tx_idr, info->desc->ops->chan_free, &info->tx_idr);
+	idr_for_each(&info->rx_idr, info->desc->ops->chan_free, &info->rx_idr);
+	return ret;
 }
 
 void scmi_free_channel(struct scmi_chan_info *cinfo, struct idr *idr, int id)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

