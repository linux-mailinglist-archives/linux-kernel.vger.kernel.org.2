Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAFB3EA1BB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 11:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbhHLJQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 05:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235873AbhHLJQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 05:16:42 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEBBC0613D5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 02:16:17 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id bo18so8467311pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 02:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qxXfxfhTQ8I1FWAL9cuRyu2qW+TXm5vD2p6VKDoHTMY=;
        b=fd3udbcS9E++cnTTFtndHAjez3IaOz1i+neRHFvp1oHgUghV1Qwc0h2r44beuB0VJo
         U5VJBzdzbWN9ktpEW71t7ewnLzymUc4UPvOJ2g/aVFLxf+HTw9YF++xcv8zG7wQ3Vcpn
         8/cNd42clr7ZGJ7naBwIleIH16zCSjyjRks18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qxXfxfhTQ8I1FWAL9cuRyu2qW+TXm5vD2p6VKDoHTMY=;
        b=Mic3KHreAzfTEXtqVeLGcksj/k0pNkFz2VoA+xk106UyjhvW1Zr1d3owjZFm37tCLt
         rjOyA2sxB4AcT/r5yj85PmRPBauF0g7PMivK/1+uwn/wdO8XnGlI14A0Vja5sLYMBu4r
         9Coy3L/Qi+gssqH0whLUHjmguKjX8A/J0Ax11tRCf/xk7xQvViNbboGT8cWoi73CzTHQ
         dNgCZULAMj4tLjurVAwQvrT2m/5us4pU3U+kMXxuZpNZts6m2TXkGG+AltMFNn+bD7yt
         dHdsVDpLKtGQpOUyZkITbz8FwduaqH+EqsBOxXmLYbalDj/jyfbcxSNJSl5lM3e9W4CZ
         WWzw==
X-Gm-Message-State: AOAM532wCzPrbOngkpgcl94sGfVJlDwnaffvPNSMDEIlbhkf4ekje9wU
        k/mYjfKPzdWBPNsqwwjT12QdYg==
X-Google-Smtp-Source: ABdhPJwCY1LvTFueH3bIUk8UPnLpJ0x1YtfTGQxKKijljHsE9nHr7jPxCayDJ4h1sKDNVYwE4SZ54Q==
X-Received: by 2002:a17:90b:3144:: with SMTP id ip4mr15550715pjb.22.1628759777378;
        Thu, 12 Aug 2021 02:16:17 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:8f67:7d0e:97df:b4b4])
        by smtp.gmail.com with ESMTPSA id n32sm2563966pgl.69.2021.08.12.02.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 02:16:17 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     josephsih@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        Joseph Hwang <josephsih@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/4] Bluetooth: set quality report callback for Intel
Date:   Thu, 12 Aug 2021 17:16:00 +0800
Message-Id: <20210812171533.v7.3.I50ffa4cd0b3ab11669ff2541fc719fee00b4e244@changeid>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
In-Reply-To: <20210812171533.v7.1.I41aec59e65ffd3226d368dabeb084af13cc133c8@changeid>
References: <20210812171533.v7.1.I41aec59e65ffd3226d368dabeb084af13cc133c8@changeid>
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

Changes in v7:
- Rebase on Tedd's patches that moved functionality from btusb to
  btintel.

Changes in v5:
- Removed CONFIG_BT_FEATURE_QUALITY_REPORT since there was no
  large size impact.

 drivers/bluetooth/btintel.c | 81 ++++++++++++++++++++++++++++++++++++-
 drivers/bluetooth/btintel.h |  6 +++
 2 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 643e2194ca01..611c3ea5425f 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1291,8 +1291,10 @@ static int btintel_set_debug_features(struct hci_dev *hdev,
 	u8 trace_enable = 0x02;
 	struct sk_buff *skb;
 
-	if (!features)
+	if (!features) {
+		bt_dev_warn(hdev, "Debug features not read");
 		return -EINVAL;
+	}
 
 	if (!(features->page1[0] & 0x3f)) {
 		bt_dev_info(hdev, "Telemetry exception format not supported");
@@ -1323,9 +1325,77 @@ static int btintel_set_debug_features(struct hci_dev *hdev,
 	}
 	kfree_skb(skb);
 
+	bt_dev_info(hdev, "set debug features: trace_enable 0x%02x mask 0x%02x",
+		    trace_enable, mask[3]);
+
 	return 0;
 }
 
+static int btintel_reset_debug_features(struct hci_dev *hdev,
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
+
 static const struct firmware *btintel_legacy_rom_get_fw(struct hci_dev *hdev,
 					       struct intel_version *ver)
 {
@@ -1951,6 +2021,9 @@ static int btintel_bootloader_setup(struct hci_dev *hdev,
 		btintel_load_ddc_config(hdev, ddcname);
 	}
 
+	hci_dev_clear_flag(hdev, HCI_QUALITY_REPORT);
+	bt_dev_dbg(hdev, "HCI_QUALITY_REPORT cleared");
+
 	/* Read the Intel version information after loading the FW  */
 	err = btintel_read_version(hdev, &new_ver);
 	if (err)
@@ -2132,6 +2205,9 @@ static int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 	 */
 	btintel_load_ddc_config(hdev, ddcname);
 
+	hci_dev_clear_flag(hdev, HCI_QUALITY_REPORT);
+	bt_dev_dbg(hdev, "HCI_QUALITY_REPORT cleared");
+
 	/* Read the Intel version information after loading the FW  */
 	err = btintel_read_version_tlv(hdev, &new_ver);
 	if (err)
@@ -2230,6 +2306,9 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 	set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 	set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
 
+	/* Set up the quality report callback for Intel devices */
+	hdev->set_quality_report = btintel_set_quality_report;
+
 	/* For Legacy device, check the HW platform value and size */
 	if (skb->len == sizeof(ver) && skb->data[1] == 0x37) {
 		bt_dev_dbg(hdev, "Read the legacy Intel version information");
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index aa64072bbe68..fe02cb9ac96c 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -204,6 +204,7 @@ int btintel_configure_setup(struct hci_dev *hdev);
 void btintel_bootup(struct hci_dev *hdev, const void *ptr, unsigned int len);
 void btintel_secure_send_result(struct hci_dev *hdev,
 				const void *ptr, unsigned int len);
+int btintel_set_quality_report(struct hci_dev *hdev, bool enable);
 #else
 
 static inline int btintel_check_bdaddr(struct hci_dev *hdev)
@@ -294,4 +295,9 @@ static inline void btintel_secure_send_result(struct hci_dev *hdev,
 				const void *ptr, unsigned int len)
 {
 }
+
+static inline int btintel_set_quality_report(struct hci_dev *hdev, bool enable)
+{
+	return -ENODEV;
+}
 #endif
-- 
2.32.0.605.g8dce9f2422-goog

