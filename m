Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C1A3AC5A3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 10:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbhFRIDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 04:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbhFRIDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 04:03:05 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EB3C061768
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 01:00:50 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id e20so7184945pgg.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 01:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UHRUoNKTXDhWOWWn3W311+njF5lywCh5AdKKO+L8q00=;
        b=iAsz0DdU4MEkawdRoyeBDUzcxfxX0FcKg+cjohP0ukmtUl/NtpwfLK8asbKSn89oUS
         +hJ7ZqKrfep0JINdjbD/C1GVT8E9+TGk47da+WrIuseRoV7naxAWLHUt3EL3B+B/5iEZ
         54xAoTfr21SYY21EYilsbqQxnMIktqM01WJiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UHRUoNKTXDhWOWWn3W311+njF5lywCh5AdKKO+L8q00=;
        b=opYidDuH0nyCdFlZxUSWR88dgCTc33fMOtQnpt0P7Qih9yRCmmhfozVvAtb6KVr8pI
         SayXGdw1C8rjzceFIdpE7RPJCttsAtva7NuBq5Hly0tVroCNac9rfCwTZ11PLbMrefyz
         Ul1IirrGuHeQqATcWSCuVtCJen+kD9DfdSNLSZFrUYkWLHKw6dJPVL2/r67QQfUxqmxA
         UdcrCjKs9EMTVITQMci9Q7dR/xTVAtWjPAVQ72tii29vOnH18u0rnQI0mV4bt01+0j/I
         5hXKfZgk5WojTpMcu9tGlWwWlM0XOjF/08uPjln9PtecOFiraSDt6Pe/q9g2kwpU9PHL
         7SuQ==
X-Gm-Message-State: AOAM533eKHTTvO1H6YSsX5UHWaTF3z7+oQOmKarpHu08swWBJ53paUqT
        WZMxUxuXa6pKFeYkKN+anWtldw==
X-Google-Smtp-Source: ABdhPJxwDdQM44hS+Ddhw7JWdEvTNdfDf51bw41GEHCOmZ1GRxVY5nBPak5SI2QbcEJ4zbiS3mD/KA==
X-Received: by 2002:a63:e14:: with SMTP id d20mr9056017pgl.35.1624003249994;
        Fri, 18 Jun 2021 01:00:49 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:6cbb:95eb:e2ae:8479])
        by smtp.gmail.com with ESMTPSA id v21sm7341671pfu.77.2021.06.18.01.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 01:00:49 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     josephsih@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        Joseph Hwang <josephsih@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] Bluetooth: set quality report callback for Intel
Date:   Fri, 18 Jun 2021 16:00:38 +0800
Message-Id: <20210618160016.v4.3.I50ffa4cd0b3ab11669ff2541fc719fee00b4e244@changeid>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
In-Reply-To: <20210618160016.v4.1.I41aec59e65ffd3226d368dabeb084af13cc133c8@changeid>
References: <20210618160016.v4.1.I41aec59e65ffd3226d368dabeb084af13cc133c8@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch sets up set_quality_report callback for Intel to
set and reset the debug features.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

(no changes since v1)

 drivers/bluetooth/btintel.c | 75 ++++++++++++++++++++++++++++++++++++-
 drivers/bluetooth/btintel.h | 13 +++++++
 drivers/bluetooth/btusb.c   | 16 ++++++++
 3 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index fd21ddb76928..7b32141b555f 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1213,6 +1213,7 @@ void btintel_reset_to_bootloader(struct hci_dev *hdev)
 }
 EXPORT_SYMBOL_GPL(btintel_reset_to_bootloader);
 
+#ifdef CONFIG_BT_FEATURE_QUALITY_REPORT
 int btintel_read_debug_features(struct hci_dev *hdev,
 				struct intel_debug_features *features)
 {
@@ -1254,8 +1255,10 @@ int btintel_set_debug_features(struct hci_dev *hdev,
 	u8 trace_enable = 0x02;
 	struct sk_buff *skb;
 
-	if (!features)
+	if (!features) {
+		bt_dev_warn(hdev, "Debug features not read");
 		return -EINVAL;
+	}
 
 	if (!(features->page1[0] & 0x3f)) {
 		bt_dev_info(hdev, "Telemetry exception format not supported");
@@ -1286,10 +1289,80 @@ int btintel_set_debug_features(struct hci_dev *hdev,
 	}
 	kfree_skb(skb);
 
+	bt_dev_info(hdev, "set debug features: trace_enable 0x%02x mask 0x%02x",
+		    trace_enable, mask[3]);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(btintel_set_debug_features);
 
+int btintel_reset_debug_features(struct hci_dev *hdev,
+				 const struct intel_debug_features *features)
+{
+	u8 mask[11] = { 0x0a, 0x92, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00 };
+	u8 trace_enable = 0x00;
+	struct sk_buff *skb;
+
+	if (!features) {
+		bt_dev_warn(hdev, "Debug features not read");
+		return -EINVAL;
+	}
+
+	if (!(features->page1[0] & 0x3f)) {
+		bt_dev_info(hdev, "Telemetry exception format not supported");
+		return 0;
+	}
+
+	/* Should stop the trace before writing ddc event mask. */
+	skb = __hci_cmd_sync(hdev, 0xfca1, 1, &trace_enable, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Stop tracing of link statistics events failed (%ld)",
+			   PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+	kfree_skb(skb);
+
+	skb = __hci_cmd_sync(hdev, 0xfc8b, 11, mask, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Setting Intel telemetry ddc write event mask failed (%ld)",
+			   PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+	kfree_skb(skb);
+
+	bt_dev_info(hdev, "reset debug features: trace_enable 0x%02x mask 0x%02x",
+		    trace_enable, mask[3]);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btintel_reset_debug_features);
+
+int btintel_set_quality_report(struct hci_dev *hdev, bool enable)
+{
+	struct intel_debug_features features;
+	int err;
+
+	bt_dev_dbg(hdev, "enable %d", enable);
+
+	/* Read the Intel supported features and if new exception formats
+	 * supported, need to load the additional DDC config to enable.
+	 */
+	err = btintel_read_debug_features(hdev, &features);
+	if (err)
+		return err;
+
+	/* Set or reset the debug features. */
+	if (enable)
+		err = btintel_set_debug_features(hdev, &features);
+	else
+		err = btintel_reset_debug_features(hdev, &features);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(btintel_set_quality_report);
+#endif
+
 MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);
 MODULE_VERSION(VERSION);
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index d184064a5e7c..618d3736599f 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -171,10 +171,15 @@ int btintel_download_firmware_newgen(struct hci_dev *hdev,
 				     u32 *boot_param, u8 hw_variant,
 				     u8 sbe_type);
 void btintel_reset_to_bootloader(struct hci_dev *hdev);
+#ifdef CONFIG_BT_FEATURE_QUALITY_REPORT
 int btintel_read_debug_features(struct hci_dev *hdev,
 				struct intel_debug_features *features);
 int btintel_set_debug_features(struct hci_dev *hdev,
 			       const struct intel_debug_features *features);
+int btintel_reset_debug_features(struct hci_dev *hdev,
+			       const struct intel_debug_features *features);
+int btintel_set_quality_report(struct hci_dev *hdev, bool enable);
+#endif
 #else
 
 static inline int btintel_check_bdaddr(struct hci_dev *hdev)
@@ -301,10 +306,18 @@ static inline int btintel_read_debug_features(struct hci_dev *hdev,
 	return -EOPNOTSUPP;
 }
 
+#ifdef CONFIG_BT_FEATURE_QUALITY_REPORT
 static inline int btintel_set_debug_features(struct hci_dev *hdev,
 					     const struct intel_debug_features *features)
 {
 	return -EOPNOTSUPP;
 }
 
+static inline int btintel_reset_debug_features(struct hci_dev *hdev,
+					       const struct intel_debug_features *features)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 #endif
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 4c3b26c5e507..a3d5c520b55e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2903,6 +2903,11 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 		btintel_load_ddc_config(hdev, ddcname);
 	}
 
+#ifdef CONFIG_BT_FEATURE_QUALITY_REPORT
+	hci_dev_clear_flag(hdev, HCI_QUALITY_REPORT);
+	bt_dev_dbg(hdev, "HCI_QUALITY_REPORT cleared");
+#endif
+
 	/* Read the Intel version information after loading the FW  */
 	err = btintel_read_version(hdev, &ver);
 	if (err)
@@ -2990,6 +2995,11 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
 	 */
 	btintel_load_ddc_config(hdev, ddcname);
 
+#ifdef CONFIG_BT_FEATURE_QUALITY_REPORT
+	hci_dev_clear_flag(hdev, HCI_QUALITY_REPORT);
+	bt_dev_dbg(hdev, "HCI_QUALITY_REPORT cleared");
+#endif
+
 	/* Read the Intel version information after loading the FW  */
 	err = btintel_read_version_tlv(hdev, &version);
 	if (err)
@@ -4637,6 +4647,9 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->set_diag = btintel_set_diag;
 		hdev->set_bdaddr = btintel_set_bdaddr;
 		hdev->cmd_timeout = btusb_intel_cmd_timeout;
+#ifdef CONFIG_BT_FEATURE_QUALITY_REPORT
+		hdev->set_quality_report = btintel_set_quality_report;
+#endif
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
@@ -4651,6 +4664,9 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->set_diag = btintel_set_diag;
 		hdev->set_bdaddr = btintel_set_bdaddr;
 		hdev->cmd_timeout = btusb_intel_cmd_timeout;
+#ifdef CONFIG_BT_FEATURE_QUALITY_REPORT
+		hdev->set_quality_report = btintel_set_quality_report;
+#endif
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
-- 
2.32.0.288.g62a8d224e6-goog

