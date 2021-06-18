Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC913AC59D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 10:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbhFRID2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 04:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbhFRIDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 04:03:03 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A608C061760
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 01:00:48 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id f10so2149510plg.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 01:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=InZhYqpv8m1+7VVhTH77wgZ+W95Cha0AWCB0EvIdTXY=;
        b=l83ZIor3bdYFAsNOHzp84GWE6gE7BJQCkA7D5v97xxbKaYtL51nEoYZuwqMhSSCqlK
         aiSeOv4a+G+Mi1fDk+3zeb7eTOvgofYzoGznWAMxMuhgKCftUdRBBIfLexFg/cCvys9x
         YYIonzEqgaQulejtTIB8L2qrcffRlL8NRrIps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=InZhYqpv8m1+7VVhTH77wgZ+W95Cha0AWCB0EvIdTXY=;
        b=KdqUdCA9ateqpdMoIV0MuKowbBMXf1lAjNd+C0Xa0PW50w7eT9bNAmNYqevtf3rQb2
         Pa7+sCbo+H3XyriDt1HhLCkkIyAOI3ymcEQ3cmVDB0x+yu6yGbIvwYKq7kZmMWZpQi94
         E57s1AZaqPKrIGUdwRPaS5Kk10zBQkWxWjsOmRly53ZXBwJ3WbSc9NVZcE9ju8iee4gV
         DAxTozvX7KKe7NIe5IIvMi8xJ8Ih4PBF1wn7R4gCc6BASs3kdt2V1jziBqWomBmrBARu
         VP9z2IFMmqHT+GKph3fXTGPUg7KNYB1caLjbl9JGNpV0QAIqZrHU2fudXhUUazjILyNU
         XbMw==
X-Gm-Message-State: AOAM530Rsc/ypIgHej9wqvChH5YXZJw1Fj645MjiSHq1qxUAz5IvV7jj
        5MX+VNFCKEYEoB38+MnNgX9TEQ==
X-Google-Smtp-Source: ABdhPJwEOwojVPfMDqPw6N+jQgIklXCslZ1wyeDFGuamDh2i+cfIgN6tDoZqI6KRL6tWX1uBfViXAw==
X-Received: by 2002:a17:90a:4e4a:: with SMTP id t10mr9845003pjl.173.1624003247772;
        Fri, 18 Jun 2021 01:00:47 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:6cbb:95eb:e2ae:8479])
        by smtp.gmail.com with ESMTPSA id v21sm7341671pfu.77.2021.06.18.01.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 01:00:47 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     josephsih@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        Kiran K <kiran.k@intel.com>,
        Joseph Hwang <josephsih@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/4] Bluetooth: btintel: support link statistics telemetry events
Date:   Fri, 18 Jun 2021 16:00:37 +0800
Message-Id: <20210618160016.v4.2.Ifb35feb49ec588106b256c508259500583582125@changeid>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
In-Reply-To: <20210618160016.v4.1.I41aec59e65ffd3226d368dabeb084af13cc133c8@changeid>
References: <20210618160016.v4.1.I41aec59e65ffd3226d368dabeb084af13cc133c8@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chethan T N <chethan.tumkur.narayan@intel.com>

This patch supports the link statistics telemetry events for
intel controllers

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

(no changes since v1)

 drivers/bluetooth/btintel.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index e44b6993cf91..fd21ddb76928 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1248,8 +1248,10 @@ EXPORT_SYMBOL_GPL(btintel_read_debug_features);
 int btintel_set_debug_features(struct hci_dev *hdev,
 			       const struct intel_debug_features *features)
 {
-	u8 mask[11] = { 0x0a, 0x92, 0x02, 0x07, 0x00, 0x00, 0x00, 0x00,
+	u8 mask[11] = { 0x0a, 0x92, 0x02, 0x7f, 0x00, 0x00, 0x00, 0x00,
 			0x00, 0x00, 0x00 };
+	u8 period[5] = { 0x04, 0x91, 0x02, 0x05, 0x00 };
+	u8 trace_enable = 0x02;
 	struct sk_buff *skb;
 
 	if (!features)
@@ -1266,8 +1268,24 @@ int btintel_set_debug_features(struct hci_dev *hdev,
 			   PTR_ERR(skb));
 		return PTR_ERR(skb);
 	}
+	kfree_skb(skb);
+
+	skb = __hci_cmd_sync(hdev, 0xfc8b, 5, period, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Setting periodicity for link statistics traces failed (%ld)",
+			   PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+	kfree_skb(skb);
 
+	skb = __hci_cmd_sync(hdev, 0xfca1, 1, &trace_enable, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Enable tracing of link statistics events failed (%ld)",
+			   PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
 	kfree_skb(skb);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(btintel_set_debug_features);
-- 
2.32.0.288.g62a8d224e6-goog

