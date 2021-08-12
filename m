Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9933EAB52
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 21:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236299AbhHLTvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 15:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235886AbhHLTvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 15:51:07 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA723C061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 12:50:41 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id s184so10076713ios.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 12:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RHMfXVA1Klg6sx1DUmOI8CqqOikuok40UfY0H4FVM/4=;
        b=CE3HBi5oEYA49LkpIZBXqvz6sTp4v9D+6JxJkIOv0lOJ2yxDP2DorP/xmRKBJ1U2XH
         15javSaI7EpnfD8cnn31fJDjgtXRP7jrSzTKPkGJp9m5BpEnaP2mtvNWHwgibqfG75FR
         GpC8ene/Y5L9qohcN4xHxSJmRfLktZKLpWjHLlwaxeePZMTRqSBOHZW7Nl0b8euv3v1D
         N0mOj/gGhH2hjqehN5vL0j0g0bBZBZ/6Yfvc3JdNevA38vBy6nM77spiF1KXvXJl05T3
         1St4T618Vj5fBHsKl4RPje4tQs82eiVdBSY4vKzw8l5N8dZyEbYWlg4EQ/a4KvncamVN
         SAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RHMfXVA1Klg6sx1DUmOI8CqqOikuok40UfY0H4FVM/4=;
        b=jVlE0gwYsmIbAyM3MYtmegJ79URE0EcmwLK60hxeXhLLBNj/dqcMZBIDindQJLQOPd
         LfvbKKcs8QFEt0guTY6D1T4EukFjp68S3zYkWt9I2N3SeUk7QfEQuqIU8VcQofwEEfhg
         FMU0/Y47biwIUUSJKMrWzoC/rlwkKXq2/pOdAkEyZFYuQp4XLjYSdy4AXx+ODdXJk+b2
         iw8vPTFJcaDiQdhqI9/2mN5bWxrw6rPjkrGzZsA80HJtgqexdj2LRWTq2PJPAJfDc/s/
         D3C7wCYL+YfF4ubYujX3vAVbL7n8UYiigyRCpCgYGXoxIWvD3jK8zx5oFimoIr3wRx65
         Em2Q==
X-Gm-Message-State: AOAM533QPI0w26+fK6ECb7pP/iBucKxZ2lznQ3LGP8sBpYHFZuioa/Fe
        A2VIIwQxWOH4AOGnS0+HuG7/xvBkSCFdDymD
X-Google-Smtp-Source: ABdhPJzSjFeD5UXbG2jYaJ7C5D1ko+1TiwAa69akqcXZFDJPe/mfW49jtx5SK37mrD9vAkXvAAJqZg==
X-Received: by 2002:a5d:93d3:: with SMTP id j19mr4242629ioo.184.1628797841156;
        Thu, 12 Aug 2021 12:50:41 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id s16sm2058821iln.5.2021.08.12.12.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 12:50:40 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/6] net: ipa: re-enable transmit in PM WQ context
Date:   Thu, 12 Aug 2021 14:50:32 -0500
Message-Id: <20210812195035.2816276-4-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210812195035.2816276-1-elder@linaro.org>
References: <20210812195035.2816276-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a new work structure in the modem private data, and use it to
re-enable the modem network device transmit queue when resuming.

This is needed by the next patch, which stops the TX queue if IPA
power isn't active when a transmit request arrives.  Packets will
start arriving the instant the TX queue is enabled, but resuming
isn't complete until ipa_modem_resume() returns.  This way we're
sure to be resumed before transmits are allowed again.

Cancel it before calling ipa_stop() in ipa_modem_stop() to ensure
the transmit queue restart completes before it gets stopped there.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_modem.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ipa/ipa_modem.c b/drivers/net/ipa/ipa_modem.c
index 06e44afd2cf66..0a3b034614b61 100644
--- a/drivers/net/ipa/ipa_modem.c
+++ b/drivers/net/ipa/ipa_modem.c
@@ -9,6 +9,7 @@
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
 #include <linux/if_rmnet.h>
+#include <linux/pm_runtime.h>
 #include <linux/remoteproc/qcom_rproc.h>
 
 #include "ipa.h"
@@ -33,9 +34,14 @@ enum ipa_modem_state {
 	IPA_MODEM_STATE_STOPPING,
 };
 
-/** struct ipa_priv - IPA network device private data */
+/**
+ * struct ipa_priv - IPA network device private data
+ * @ipa:	IPA pointer
+ * @work:	Work structure used to wake the modem netdev TX queue
+ */
 struct ipa_priv {
 	struct ipa *ipa;
+	struct work_struct work;
 };
 
 /** ipa_open() - Opens the modem network interface */
@@ -189,6 +195,21 @@ void ipa_modem_suspend(struct net_device *netdev)
 	ipa_endpoint_suspend_one(ipa->name_map[IPA_ENDPOINT_AP_MODEM_TX]);
 }
 
+/**
+ * ipa_modem_wake_queue_work() - enable modem netdev queue
+ * @work:	Work structure
+ *
+ * Re-enable transmit on the modem network device.  This is called
+ * in (power management) work queue context, scheduled when resuming
+ * the modem.
+ */
+static void ipa_modem_wake_queue_work(struct work_struct *work)
+{
+	struct ipa_priv *priv = container_of(work, struct ipa_priv, work);
+
+	netif_wake_queue(priv->ipa->modem_netdev);
+}
+
 /** ipa_modem_resume() - resume callback for runtime_pm
  * @dev: pointer to device
  *
@@ -205,7 +226,8 @@ void ipa_modem_resume(struct net_device *netdev)
 	ipa_endpoint_resume_one(ipa->name_map[IPA_ENDPOINT_AP_MODEM_TX]);
 	ipa_endpoint_resume_one(ipa->name_map[IPA_ENDPOINT_AP_MODEM_RX]);
 
-	netif_wake_queue(netdev);
+	/* Arrange for the TX queue to be restarted */
+	(void)queue_pm_work(&priv->work);
 }
 
 int ipa_modem_start(struct ipa *ipa)
@@ -233,6 +255,7 @@ int ipa_modem_start(struct ipa *ipa)
 	SET_NETDEV_DEV(netdev, &ipa->pdev->dev);
 	priv = netdev_priv(netdev);
 	priv->ipa = ipa;
+	INIT_WORK(&priv->work, ipa_modem_wake_queue_work);
 	ipa->name_map[IPA_ENDPOINT_AP_MODEM_TX]->netdev = netdev;
 	ipa->name_map[IPA_ENDPOINT_AP_MODEM_RX]->netdev = netdev;
 	ipa->modem_netdev = netdev;
@@ -277,6 +300,9 @@ int ipa_modem_stop(struct ipa *ipa)
 
 	/* Clean up the netdev and endpoints if it was started */
 	if (netdev) {
+		struct ipa_priv *priv = netdev_priv(netdev);
+
+		cancel_work_sync(&priv->work);
 		/* If it was opened, stop it first */
 		if (netdev->flags & IFF_UP)
 			(void)ipa_stop(netdev);
-- 
2.27.0

