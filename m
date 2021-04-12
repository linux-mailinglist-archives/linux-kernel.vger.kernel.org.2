Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A57F35BAD3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 09:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236838AbhDLH2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 03:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhDLH2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 03:28:13 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6A3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 00:27:55 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d8so5880595plh.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 00:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3FoyXfOs0EAMm+L6VANFkfyGIjeLelcG4mg6WHLK1bs=;
        b=Bmo+aLUxz2jNaSyDMfhd46H1dnGvtY81DpT6gQUwvGCROEjnhcZzYrQ+ktOwj9jZgU
         jzlWTArB9uANnN/5lTXqyZh0TWPkCp5Vg8fzk86tqQlvXEihlh+YixyeQwb65cagP8JJ
         xbCp4U1/LZo5ZFo7C/uYJvlLIhdssm0vD+PHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3FoyXfOs0EAMm+L6VANFkfyGIjeLelcG4mg6WHLK1bs=;
        b=MSmlxMB9vidO90SqK9YAMra3ngmkXs13/Iy/WmUXr6SwndhtR95JyhEqXI0vsgU81v
         /6VNzvKWK9WLFfyYvHIrWtmETFUE29WXhASj9abLvOMo3p36R8kQ9Q9RPjPagQuH6EAY
         20PJsPl+AcSgp9Vej7kZUVVFYcWLwRAwr31M5EjxclyeQ/eygO9XqiXyTj48/DlEG1hb
         2XqTM3AET0u5rWeXesbXUzeBIlYP1tFt1BvUC3e8ANps14GHaZokgIE9RrZcJDAHB48W
         2jAI9orlDxk2slOrKBczBlbADtrvI9ELpjYMCl+KvDHMVydm79Mh2FOWB5QGZeE8OviT
         GS2Q==
X-Gm-Message-State: AOAM530fNKS3fIpcxNE1zDYq/e6y8r4Lx+SXRaPg30bMmstf2QbH8Cyu
        B0tfuUSX1NL1ob0yRgcgzn8j/w==
X-Google-Smtp-Source: ABdhPJwSSMM46vCK4fDClHou2a8vOfTWQL6exxar0BwpRZPagKCX66lRPPdG/UQsdpmXcdu5gRGK0w==
X-Received: by 2002:a17:902:ec87:b029:e9:8772:6668 with SMTP id x7-20020a170902ec87b02900e987726668mr21710466plg.15.1618212475430;
        Mon, 12 Apr 2021 00:27:55 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:b:99d4:3dd9:e3a7:45cf])
        by smtp.gmail.com with ESMTPSA id s22sm8797161pfe.150.2021.04.12.00.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 00:27:54 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        Kiran K <kiran.k@intel.com>,
        Joseph Hwang <josephsih@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] Bluetooth: btusb: support link statistics telemetry events
Date:   Mon, 12 Apr 2021 15:27:33 +0800
Message-Id: <20210412072734.2567956-1-josephsih@chromium.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chethan T N <chethan.tumkur.narayan@intel.com>

This patch supports the link statistics telemetry events for
Intel controllers

To avoid the overhead, this debug feature is disabled by default.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

 drivers/bluetooth/btintel.c | 20 +++++++++++++++++++-
 drivers/bluetooth/btusb.c   |  9 ---------
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index e44b6993cf91..de1dbdc01e5a 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1248,8 +1248,10 @@ EXPORT_SYMBOL_GPL(btintel_read_debug_features);
 int btintel_set_debug_features(struct hci_dev *hdev,
 			       const struct intel_debug_features *features)
 {
-	u8 mask[11] = { 0x0a, 0x92, 0x02, 0x07, 0x00, 0x00, 0x00, 0x00,
+	u8 mask[11] = { 0x0a, 0x92, 0x02, 0x7f, 0x00, 0x00, 0x00, 0x00,
 			0x00, 0x00, 0x00 };
+	u8 period[5] = { 0x04, 0x91, 0x02, 0x01, 0x00 };
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
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 192cb8c191bc..096b743977a7 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2811,7 +2811,6 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	u32 boot_param;
 	char ddcname[64];
 	int err;
-	struct intel_debug_features features;
 
 	BT_DBG("%s", hdev->name);
 
@@ -2865,14 +2864,6 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 		btintel_load_ddc_config(hdev, ddcname);
 	}
 
-	/* Read the Intel supported features and if new exception formats
-	 * supported, need to load the additional DDC config to enable.
-	 */
-	btintel_read_debug_features(hdev, &features);
-
-	/* Set DDC mask for available debug features */
-	btintel_set_debug_features(hdev, &features);
-
 	/* Read the Intel version information after loading the FW  */
 	err = btintel_read_version(hdev, &ver);
 	if (err)
-- 
2.31.1.295.g9ea45b61b8-goog

