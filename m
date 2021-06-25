Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 837093B3B09
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 05:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbhFYDI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 23:08:56 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:11483 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbhFYDIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 23:08:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624590395; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=xfGgurIpwSu27EL1saU4CIi4CGBgN5thvMAw704wMaA=; b=fDqDtMJ4d+fuONC27HxZlHnDqL1vY3UDvTTbvqclMc2oAs0SawbQQAg0rd/7e6xL0/7yGVja
 Hgl/7OjU1SO0sOix+6DXgqj+60pHgRCHZAsQQtPnWDx0z6rUAftK1Y1YqE6VcO83Uhz+PF2Q
 A4JDgHaQW7xyJ6xINPYDYLHYync=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 60d548351938941955d1f851 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 25 Jun 2021 03:06:29
 GMT
Sender: bbhatt=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B9628C43460; Fri, 25 Jun 2021 03:06:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from malabar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 67A46C433F1;
        Fri, 25 Jun 2021 03:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 67A46C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        linux-kernel@vger.kernel.org, Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [PATCH v4] bus: mhi: core: Add support for processing priority of event ring
Date:   Thu, 24 Jun 2021 20:06:19 -0700
Message-Id: <1624590379-12319-1-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hemant Kumar <hemantk@codeaurora.org>

Event ring priorities are currently set to 1 and are unused.
Default processing priority for event rings is set to regular
tasklet. Controllers can choose to use high priority tasklet
scheduling for certain event rings critical for processing such
as ones transporting control information if they wish to avoid
system scheduling delays for those packets. In order to support
these use cases, allow controllers to set event ring priority to
high. This patch only adds support and does not enable usage of
these priorities.

Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
---
v4:
-Update fixed priority for all events to default to fix bug in v3
-Supply changelog

v3:
-Revert to enum approach
-Use 0 as default and 1 as high in enum
-Do not use config values for event rings

v2:
-Use boolean approach for easy maintenance as controllers do not need updates

 drivers/bus/mhi/core/init.c     |  4 ++--
 drivers/bus/mhi/core/internal.h |  2 +-
 drivers/bus/mhi/core/main.c     | 19 ++++++++++++++++---
 include/linux/mhi.h             | 14 ++++++++++++--
 4 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index c81b377..23386b8 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -673,8 +673,8 @@ static int parse_ev_cfg(struct mhi_controller *mhi_cntrl,
 				&mhi_cntrl->mhi_chan[mhi_event->chan];
 		}
 
-		/* Priority is fixed to 1 for now */
-		mhi_event->priority = 1;
+		/* Priority is fixed to deafult for now */
+		mhi_event->priority = MHI_ER_PRIORITY_DEFAULT;
 
 		mhi_event->db_cfg.brstmode = event_cfg->mode;
 		if (MHI_INVALID_BRSTMODE(mhi_event->db_cfg.brstmode))
diff --git a/drivers/bus/mhi/core/internal.h b/drivers/bus/mhi/core/internal.h
index 672052f..666e102 100644
--- a/drivers/bus/mhi/core/internal.h
+++ b/drivers/bus/mhi/core/internal.h
@@ -535,7 +535,7 @@ struct mhi_event {
 	u32 intmod;
 	u32 irq;
 	int chan; /* this event ring is dedicated to a channel (optional) */
-	u32 priority;
+	enum mhi_er_priority priority;
 	enum mhi_er_data_type data_type;
 	struct mhi_ring ring;
 	struct db_cfg db_cfg;
diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
index 8ac73f9..bfc9776 100644
--- a/drivers/bus/mhi/core/main.c
+++ b/drivers/bus/mhi/core/main.c
@@ -425,10 +425,11 @@ void mhi_create_devices(struct mhi_controller *mhi_cntrl)
 	}
 }
 
-irqreturn_t mhi_irq_handler(int irq_number, void *dev)
+irqreturn_t mhi_irq_handler(int irq_number, void *priv)
 {
-	struct mhi_event *mhi_event = dev;
+	struct mhi_event *mhi_event = priv;
 	struct mhi_controller *mhi_cntrl = mhi_event->mhi_cntrl;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
 	struct mhi_event_ctxt *er_ctxt =
 		&mhi_cntrl->mhi_ctxt->er_ctxt[mhi_event->er_index];
 	struct mhi_ring *ev_ring = &mhi_event->ring;
@@ -454,8 +455,20 @@ irqreturn_t mhi_irq_handler(int irq_number, void *dev)
 
 		if (mhi_dev)
 			mhi_notify(mhi_dev, MHI_CB_PENDING_DATA);
-	} else {
+
+		return IRQ_HANDLED;
+	}
+
+	switch (mhi_event->priority) {
+	case MHI_ER_PRIORITY_HI:
+		tasklet_hi_schedule(&mhi_event->task);
+		break;
+	case MHI_ER_PRIORITY_DEFAULT:
 		tasklet_schedule(&mhi_event->task);
+		break;
+	default:
+		dev_err(dev, "Skip event of unknown priority\n");
+		break;
 	}
 
 	return IRQ_HANDLED;
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index 86cea52..62ddead 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -198,6 +198,16 @@ enum mhi_er_data_type {
 };
 
 /**
+ * enum mhi_er_priority - Event ring processing priority
+ * @MHI_ER_PRIORITY_DEFAULT: processed by regular tasklet
+ * @MHI_ER_PRIORITY_HI: processed by hi-priority tasklet
+ */
+enum mhi_er_priority {
+	MHI_ER_PRIORITY_DEFAULT,
+	MHI_ER_PRIORITY_HI,
+};
+
+/**
  * enum mhi_db_brst_mode - Doorbell mode
  * @MHI_DB_BRST_DISABLE: Burst mode disable
  * @MHI_DB_BRST_ENABLE: Burst mode enable
@@ -250,7 +260,7 @@ struct mhi_channel_config {
  * @irq_moderation_ms: Delay irq for additional events to be aggregated
  * @irq: IRQ associated with this ring
  * @channel: Dedicated channel number. U32_MAX indicates a non-dedicated ring
- * @priority: Priority of this ring. Use 1 for now
+ * @priority: Processing priority of this ring.
  * @mode: Doorbell mode
  * @data_type: Type of data this ring will process
  * @hardware_event: This ring is associated with hardware channels
@@ -262,7 +272,7 @@ struct mhi_event_config {
 	u32 irq_moderation_ms;
 	u32 irq;
 	u32 channel;
-	u32 priority;
+	enum mhi_er_priority priority;
 	enum mhi_db_brst_mode mode;
 	enum mhi_er_data_type data_type;
 	bool hardware_event;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

