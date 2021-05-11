Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCC8379B79
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 02:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhEKA3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 20:29:48 -0400
Received: from mx1.opensynergy.com ([217.66.60.4]:12383 "EHLO
        mx1.opensynergy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbhEKA3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 20:29:44 -0400
X-Greylist: delayed 394 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 May 2021 20:29:43 EDT
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain [127.0.0.1])
        by mx1.opensynergy.com (Proxmox) with ESMTP id 4B3C3A1A12;
        Tue, 11 May 2021 02:22:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=srmailgate02; bh=OU+HtaTs8Fvo
        JVnDadVJ79nNHdyp+spOITIiOi6q/EY=; b=Q6e3d650yUpUKNqe1tItVEO+y1Of
        mkEptEEXBi3JmUTqq0hYd9Wl/L8iwt4cWn09CUoEQhd9oo//HYwNbmw8wDZFEP+F
        PST0J/epi8V0j545ALWeXD4UMPHnErPKW4cgYxlER8yYLbR1ZVaX+O75va+OWujO
        HvdNHIkHezDdZ7cFH8xzpJdbbcHclCVZPXvC1R79MKd7B31huAGQ2hMCQHFGOk7f
        3vEGl260cGGfZnKFMgNdQw3YcPLnmZ66VgpHESL7Am/MgLPaiwFIJhvAL7BY2EKc
        SKchiSGSYuMTzfrDbeBJIJoE1CkZkjxbpl9+gW6M0yp6ypxKDh1iMvHJ2A==
From:   Peter Hilber <peter.hilber@opensynergy.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
CC:     Cristian Marussi <cristian.marussi@arm.com>,
        Peter Hilber <peter.hilber@opensynergy.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <sudeep.holla@arm.com>,
        <souvik.chakravarty@arm.com>, <alex.bennee@linaro.org>,
        <jean-philippe@linaro.org>, <igor.skalkin@opensynergy.com>,
        <mikhail.golubev@opensynergy.com>,
        <anton.yakovlev@opensynergy.com>,
        Vasyl Vavrychuk <Vasyl.Vavrychuk@opensynergy.com>,
        Andriy Tryshnivskyy <Andriy.Tryshnivskyy@opensynergy.com>
Subject: [RFC PATCH v3 02/12] firmware: arm_scmi: Add transport init/deinit
Date:   Tue, 11 May 2021 02:20:30 +0200
Message-ID: <20210511002040.802226-3-peter.hilber@opensynergy.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210511002040.802226-1-peter.hilber@opensynergy.com>
References: <20210511002040.802226-1-peter.hilber@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SR-MAIL-01.open-synergy.com (10.26.10.21) To
 SR-MAIL-02.open-synergy.com (10.26.10.22)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cristian Marussi <cristian.marussi@arm.com>

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
[ Peter: Adapted RFC patch by Cristian for submission to upstream. ]
Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
---
 drivers/firmware/arm_scmi/common.h |  2 ++
 drivers/firmware/arm_scmi/driver.c | 45 ++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 94dcfb8c0176..961a3c63cc42 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -324,6 +324,8 @@ struct scmi_device *scmi_child_dev_find(struct device *parent,
  * @max_msg_size: Maximum size of data per message that can be handled.
  */
 struct scmi_desc {
+	int (*init)(void);
+	void (*exit)(void);
 	const struct scmi_transport_ops *ops;
 	int max_rx_timeout_ms;
 	int max_msg;
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 41d80bbaa9a2..471c5de827c1 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1588,10 +1588,53 @@ static struct platform_driver scmi_driver = {
 	.remove = scmi_remove,
 };
 
+static inline int __scmi_transports_setup(bool init)
+{
+	int ret = 0;
+	const struct of_device_id *trans;
+
+	for (trans = scmi_of_match; trans->data; trans++) {
+		const struct scmi_desc *tdesc = trans->data;
+
+		if ((init && !tdesc->init) || !tdesc->exit)
+			continue;
+		pr_info("SCMI %sInitializing %s transport\n", init ? "" : "De-",
+			trans->compatible);
+		if (init)
+			ret = tdesc->init();
+		else
+			tdesc->exit();
+
+		if (ret) {
+			pr_err("SCMI transport %s FAILED initialization!\n",
+			       trans->compatible);
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static int __init scmi_transports_init(void)
+{
+	return __scmi_transports_setup(true);
+}
+
+static void __exit scmi_transports_exit(void)
+{
+	__scmi_transports_setup(false);
+}
+
 static int __init scmi_driver_init(void)
 {
+	int ret;
+
 	scmi_bus_init();
 
+	ret = scmi_transports_init();
+	if (ret)
+		return ret;
+
 	scmi_base_register();
 
 	scmi_clock_register();
@@ -1618,6 +1661,8 @@ static void __exit scmi_driver_exit(void)
 	scmi_voltage_unregister();
 	scmi_system_unregister();
 
+	scmi_transports_exit();
+
 	scmi_bus_exit();
 
 	platform_driver_unregister(&scmi_driver);
-- 
2.25.1


