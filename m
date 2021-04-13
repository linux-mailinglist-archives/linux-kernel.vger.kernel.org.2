Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6359635D937
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 09:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239037AbhDMHqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 03:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238143AbhDMHqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 03:46:02 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9EBC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 00:45:41 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso8541449pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 00:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BIsFlcxBEjrAiws3WPWoHPSSG5tDzZbLZDssyc8WUio=;
        b=lS8pjGmIkKaQsmlZ2W4hxjDZ7mN5vgbOyfnAkby8Ppaue95//xVilrdxJVESwIXhy5
         4Wf4FhR+I+qrJJiOjP5cSbXn/vbrGj/XoSmpTGrEJ7AOp1pJZRwNwqvElii2ISxV4kcj
         qkvxlwFAoQQ6k7NAvCwRX1rnybn1IQRmsGXOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BIsFlcxBEjrAiws3WPWoHPSSG5tDzZbLZDssyc8WUio=;
        b=XXHUcB3avNiI+3ClvPyUrRLJnm+MZ5zZJpH8wtvHlQxKXd66oRiEEfeVV5Ci2lwF3m
         worVUJ5iRc76tkITQIv0+e31yAeXOYZngZKDa1YB/T779drUiR0+sXaAQQ60LYxWBd1o
         JSnp+btCdyYN1/+bXzaPGDDdboM5gtIuL6ic0DWm8oIdThk8BqkrlFbg9UDsXDVEwews
         USim82aYagGBAuSNN1hmdcb6Jvvfv/cKrUwMbV2VwjHWF+uW0ELV9/H24MZX61tkISSb
         znve1D4y5fuA+ENbAYGE0bxwzDbGPJd6iqrcXYFiEHY16XmGyhGp4EGPNK9kb5QNS2nN
         MOhA==
X-Gm-Message-State: AOAM533CDjPL8FoDNtNSBWB8hKsMLzhL2KyXDXLd2ZOop74Nlhs4ZcxX
        ayqDIMYGXc4BZLY3xqkHGRx4oA==
X-Google-Smtp-Source: ABdhPJzS/dKShWMV/NaGsPiYHLqZYeORdK7Rha1Ax9t6NNJQ+9WARF7kFx/fWXdGUxYd73ltELGMhw==
X-Received: by 2002:a17:90a:c781:: with SMTP id gn1mr3520922pjb.205.1618299941280;
        Tue, 13 Apr 2021 00:45:41 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:b:99d4:3dd9:e3a7:45cf])
        by smtp.gmail.com with ESMTPSA id c2sm11566360pfo.53.2021.04.13.00.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 00:45:40 -0700 (PDT)
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
Subject: [PATCH v2 1/2] Bluetooth: btusb: support link statistics telemetry events
Date:   Tue, 13 Apr 2021 15:45:20 +0800
Message-Id: <20210413074521.264802-1-josephsih@chromium.org>
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

Changes in v2:
- take care of intel_newgen as well as intel_new
- fix the long-line issue

 drivers/bluetooth/btintel.c | 20 +++++++++++++++++++-
 drivers/bluetooth/btusb.c   | 18 ------------------
 2 files changed, 19 insertions(+), 19 deletions(-)

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
index 192cb8c191bc..f29946f15f59 100644
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
@@ -2911,7 +2902,6 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
 	u32 boot_param;
 	char ddcname[64];
 	int err;
-	struct intel_debug_features features;
 	struct intel_version_tlv version;
 
 	bt_dev_dbg(hdev, "");
@@ -2961,14 +2951,6 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
 	 */
 	btintel_load_ddc_config(hdev, ddcname);
 
-	/* Read the Intel supported features and if new exception formats
-	 * supported, need to load the additional DDC config to enable.
-	 */
-	btintel_read_debug_features(hdev, &features);
-
-	/* Set DDC mask for available debug features */
-	btintel_set_debug_features(hdev, &features);
-
 	/* Read the Intel version information after loading the FW  */
 	err = btintel_read_version_tlv(hdev, &version);
 	if (err)
-- 
2.31.1.295.g9ea45b61b8-goog

