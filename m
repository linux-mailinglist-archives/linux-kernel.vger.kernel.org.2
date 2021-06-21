Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9FE3AED4D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 18:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbhFUQTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 12:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbhFUQTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 12:19:08 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088E3C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 09:16:54 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id v12so8843235plo.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 09:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Uhb6Dl104+SVeWfUYIDljsfUA96kt40BSvW1m9j8Pw=;
        b=piGZuAP13MpYkgXbR6nandmXTXTWQbPNRx6IGwKYsJgLYfWPGM7X+s3qV/Dje6VUaf
         RvB1UulfCMbyLzonrjzITTlASjM4ru3CAs8Uf10leKSHYtK/9LzMd51GmReX9RJZl3gD
         ScgOW59/W8JRHzCZfjdgFK65qKpy1X2dD0hpoel0v+ohviSavMzJz8Dp1cq5lHPOt5r+
         0Bgn+Bi6hyXSpao9jJKWonjEM3RDVUW56Nq6NnEtV+1v/p6sF2101hizL8zq7NDFC47a
         xiaSIUm5cgNeJduSrbVITdC8OS7QQmu85aJmLXaoJrDdB9rTjP3aGfHSkRUkr2wzAN79
         41jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Uhb6Dl104+SVeWfUYIDljsfUA96kt40BSvW1m9j8Pw=;
        b=PfJSAH5Xr1JaoHDrUYR/c/ywMQ+zfNXaeXIyO9jXSbFe6RIzQ4rW2b98dgPVwCJm3M
         aVFhBJLEURwssezsTlFKg4QWhbZmDj+jJYuodHOdw0NUwU3DT3ugLIQMrxIbCpmpor+P
         aRKhcQ7ZmH6od82PCu2qPRpeqdkDEOTSblAZR6AR4eMaK8E8IPN4XMSsHtWldsE0fx78
         VFs6m1IFGyYf5v4CwPQyiHoOzSSSmm49e7XSpp0ei/NZHnL7zZcrVLhYzSrVs2UpIx13
         McQH3GQ/bwrK9IwSqLGqEzTw3GdOMXAO5w+ORPkkUHvfrG73av6GjfmkggLxMn8WhkWz
         IdMQ==
X-Gm-Message-State: AOAM531CWbLfLueyzXsnZZLuvtYua+p1sJ+WZghtux0LQpDJLeZW5u1A
        4Ghq3EbOkKO362miHnWGwkBa
X-Google-Smtp-Source: ABdhPJzEnWthCZ+/PmZhgsT1X90GBk4eilA7dgJLX6AQkTKuCiyWdGWkN0kLEbgc3A9A6Cp7IFB6lQ==
X-Received: by 2002:a17:90a:de16:: with SMTP id m22mr37819350pjv.60.1624292213503;
        Mon, 21 Jun 2021 09:16:53 -0700 (PDT)
Received: from localhost.localdomain ([120.138.13.116])
        by smtp.gmail.com with ESMTPSA id k88sm10734730pjk.15.2021.06.21.09.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 09:16:52 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 6/8] bus: mhi: core: Add support for processing priority of event ring
Date:   Mon, 21 Jun 2021 21:46:14 +0530
Message-Id: <20210621161616.77524-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210621161616.77524-1-manivannan.sadhasivam@linaro.org>
References: <20210621161616.77524-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
high.

Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/1624053903-24653-2-git-send-email-bbhatt@codeaurora.org
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/init.c | 3 +--
 drivers/bus/mhi/core/main.c | 9 +++++++--
 include/linux/mhi.h         | 2 +-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index c81b377fca8f..444676034bf0 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -673,8 +673,7 @@ static int parse_ev_cfg(struct mhi_controller *mhi_cntrl,
 				&mhi_cntrl->mhi_chan[mhi_event->chan];
 		}
 
-		/* Priority is fixed to 1 for now */
-		mhi_event->priority = 1;
+		mhi_event->priority = event_cfg->priority;
 
 		mhi_event->db_cfg.brstmode = event_cfg->mode;
 		if (MHI_INVALID_BRSTMODE(mhi_event->db_cfg.brstmode))
diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
index 8ac73f9e92a6..3775c77dec63 100644
--- a/drivers/bus/mhi/core/main.c
+++ b/drivers/bus/mhi/core/main.c
@@ -454,10 +454,15 @@ irqreturn_t mhi_irq_handler(int irq_number, void *dev)
 
 		if (mhi_dev)
 			mhi_notify(mhi_dev, MHI_CB_PENDING_DATA);
-	} else {
-		tasklet_schedule(&mhi_event->task);
+
+		return IRQ_HANDLED;
 	}
 
+	if (!mhi_event->priority)
+		tasklet_hi_schedule(&mhi_event->task);
+	else
+		tasklet_schedule(&mhi_event->task);
+
 	return IRQ_HANDLED;
 }
 
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index 86cea5256e3c..bf23c213429c 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -250,7 +250,7 @@ struct mhi_channel_config {
  * @irq_moderation_ms: Delay irq for additional events to be aggregated
  * @irq: IRQ associated with this ring
  * @channel: Dedicated channel number. U32_MAX indicates a non-dedicated ring
- * @priority: Priority of this ring. Use 1 for now
+ * @priority: Processing priority of this ring. 0 is high and 1 is regular
  * @mode: Doorbell mode
  * @data_type: Type of data this ring will process
  * @hardware_event: This ring is associated with hardware channels
-- 
2.25.1

