Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB8045DC39
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 15:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355630AbhKYOXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 09:23:14 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:36504 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355652AbhKYOVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 09:21:13 -0500
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 25 Nov 2021 06:16:03 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 25 Nov 2021 06:16:02 -0800
X-QCInternal: smtphost
Received: from ekangupt-linux.qualcomm.com ([10.204.67.11])
  by ironmsg02-blr.qualcomm.com with ESMTP; 25 Nov 2021 19:45:52 +0530
Received: by ekangupt-linux.qualcomm.com (Postfix, from userid 2319895)
        id 2673C44FB; Thu, 25 Nov 2021 19:45:51 +0530 (IST)
From:   Jeya R <jeyr@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org, srinivas.kandagatla@linaro.org
Cc:     Jeya R <jeyr@codeaurora.org>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, fastrpc.upstream@qti.qualcomm.com
Subject: [PATCH 3/5] misc: fastrpc: Set channel as secure
Date:   Thu, 25 Nov 2021 19:45:42 +0530
Message-Id: <1637849744-24844-4-git-send-email-jeyr@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1637849744-24844-1-git-send-email-jeyr@codeaurora.org>
References: <1637849744-24844-1-git-send-email-jeyr@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set all DSP channel as secure for which non-secure DT property is not added.

Signed-off-by: Jeya R <jeyr@codeaurora.org>
---
 drivers/misc/fastrpc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 0775554e..a4e2e86 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -216,6 +216,7 @@ struct fastrpc_channel_ctx {
 	struct miscdevice miscdev;
 	struct miscdevice securedev;
 	struct kref refcount;
+	bool secure;
 };
 
 struct fastrpc_user {
@@ -1650,6 +1651,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	if (!data)
 		return -ENOMEM;
 
+	data->secure = !(of_property_read_bool(rdev->of_node, "qcom,non-secure-domain"));
 	data->miscdev.minor = MISC_DYNAMIC_MINOR;
 	data->miscdev.name = devm_kasprintf(rdev, GFP_KERNEL, "fastrpc-%s",
 					    domains[domain_id]);
-- 
2.7.4

