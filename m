Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D9B3EC8F3
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 14:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238382AbhHOMSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 08:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238355AbhHOMSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 08:18:06 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBD7C0612E7
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 05:17:33 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id oa17so22303589pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 05:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aSVr80IhjUOnJgPcnfWVdZLH2OKYCY5KF4ob71Yd0zo=;
        b=UBWDIFYJrUt4XpKnhamAGcsDI+1zS2pbLf0COlta8MNWwkTotUeYW4wIh9f+R2OlMD
         3k7D9b4kCyP/rq1Mq97xg70arfSShSmzaaC+cVyXvn+p/VDObF+NIkVNj/K8C0KARPix
         jbc7D4DFz9bxdgGyIdVTzH6NTct2vpmdUnlxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aSVr80IhjUOnJgPcnfWVdZLH2OKYCY5KF4ob71Yd0zo=;
        b=NswP0kbKqc/quhzjM2cdI52WJiy342Nqz81k16t75Eo2DWLQsClXSSqKeHqwFR/sgS
         D6gh3wZiRHVS6RTqg+k/enShqOahCpLeg/skPrFOHyYafiLDUVXPjHVp/6VsC5QNk2ts
         az8vb9xrqb+Q5tlEd5/taty+VRHDrfrO/0IUCW0FqROP7+1AxU9hDsXbHMP7WCe77a3E
         3QAg3a2x3fUzZN+v6g4noOTUzNjp25rQvd97CvIBBRp710WXsO0XMjdL2/CVYaFNxrog
         B4ksXkmKA0lfMLSCj94ATa7zbz5sQSqxQl/wzH3xl8V3O3TzWl/iKnj9i/9BcndFeiHG
         b1cQ==
X-Gm-Message-State: AOAM530kyG7Oe8yZsL5hR6Nks0LAYFnMiYI7l4h/eKMjkGN5asI3qyxx
        x8hwd8t9H7Tt8KiEE0bY8b+ibQ==
X-Google-Smtp-Source: ABdhPJyFGsyqTLVv3xCSsYVIpj7cjw86BIjP3qynOrQ1+qoReCzsuOIV+jlB/x7juBKjgLvV0UDxfg==
X-Received: by 2002:a17:90b:4b45:: with SMTP id mi5mr1647365pjb.43.1629029853403;
        Sun, 15 Aug 2021 05:17:33 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:9cee:5877:e805:fe2b])
        by smtp.gmail.com with ESMTPSA id v20sm9773170pgi.39.2021.08.15.05.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Aug 2021 05:17:33 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     josephsih@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        Joseph Hwang <josephsih@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 5/5] Bluetooth: set quality report callback for Intel
Date:   Sun, 15 Aug 2021 20:17:17 +0800
Message-Id: <20210815201611.v9.5.I50ffa4cd0b3ab11669ff2541fc719fee00b4e244@changeid>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
In-Reply-To: <20210815201611.v9.1.I41aec59e65ffd3226d368dabeb084af13cc133c8@changeid>
References: <20210815201611.v9.1.I41aec59e65ffd3226d368dabeb084af13cc133c8@changeid>
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

(no changes since v8)

Changes in v8:
- Removed the unsuitable debug messages.

Changes in v7:
- Rebase on Tedd's patches that moved functionality from btusb to
  btintel.

Changes in v5:
- Removed CONFIG_BT_FEATURE_QUALITY_REPORT since there was no
  large size impact.

 drivers/bluetooth/btintel.c | 79 ++++++++++++++++++++++++++++++++++++-
 drivers/bluetooth/btintel.h |  6 +++
 2 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 643e2194ca01..778d803159f3 100644
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
@@ -1951,6 +2021,8 @@ static int btintel_bootloader_setup(struct hci_dev *hdev,
 		btintel_load_ddc_config(hdev, ddcname);
 	}
 
+	hci_dev_clear_flag(hdev, HCI_QUALITY_REPORT);
+
 	/* Read the Intel version information after loading the FW  */
 	err = btintel_read_version(hdev, &new_ver);
 	if (err)
@@ -2132,6 +2204,8 @@ static int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 	 */
 	btintel_load_ddc_config(hdev, ddcname);
 
+	hci_dev_clear_flag(hdev, HCI_QUALITY_REPORT);
+
 	/* Read the Intel version information after loading the FW  */
 	err = btintel_read_version_tlv(hdev, &new_ver);
 	if (err)
@@ -2230,6 +2304,9 @@ static int btintel_setup_combined(struct hci_dev *hdev)
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
2.33.0.rc1.237.g0d66db33f3-goog

