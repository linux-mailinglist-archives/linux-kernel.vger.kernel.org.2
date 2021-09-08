Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704C34038A3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 13:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbhIHLVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 07:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235044AbhIHLVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 07:21:07 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FFAC061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 04:19:59 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id k17so1127447pls.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 04:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IDGj9HWyjNNo4qWirZssrlehTTw1UTlg3WK+Ed0rG1k=;
        b=bHm8R8kVRgth4LRfbqYfL6RvAyFHZyEURXhEp6go5NHmS3qq0/jtYWjTfHOR91Cvxr
         fN0xuLysatIZ8mR8gdYjEC0H0P4soOxHYylOrCo2Yno/WWic0Pb0l+PGnXi9EOVM8hkF
         5LrnaxZ8CThtUN+dyPBYHOn4kZXT6cKwtsF1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IDGj9HWyjNNo4qWirZssrlehTTw1UTlg3WK+Ed0rG1k=;
        b=5qepAlgmgPzOagG0Bsk2YaLpnvuTraoE1kuQodzO3Y6uU4Qc2cM6BPzUAj4N1T7FGW
         u7cE/pO+w80CjmhYrcmlBblyllWbW/M6duXJQxsOACc9KZQa1176a3Hjnr90LOQY+h6A
         oSH0q2c0i/cLBi5z6emykq/r8ALSoXFP/bdCqn72/D0xvjGow02FG4yjWCRsxkep/qvg
         YICo66xRiX7VWgqi5om+a2O0m//F5steqwcxcLSrBVtuRFeOF0kqwlczlObS6z3L70yp
         lMRnuC9nM03vGfCjusllDNagdm5vB4D7ZeGSlpgmmKCNpHZ7XzujfnzMcmbYoD2SBJR9
         1fyg==
X-Gm-Message-State: AOAM533vKv6UXsb3z27AJyNTGxZOxgWu3K+9Rb01CMJHRh72wuHzooqb
        dNS1zLbJ41y05u0gA2cPAlPigA==
X-Google-Smtp-Source: ABdhPJwk/40wHHl6IFamfFFRBr21kLVM6fZBELFkMSse00XW1leETGNDMV07SidwAVMaA08MqolEzw==
X-Received: by 2002:a17:90a:708c:: with SMTP id g12mr3602337pjk.13.1631099998976;
        Wed, 08 Sep 2021 04:19:58 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:6939:f2f4:4be:bf22])
        by smtp.gmail.com with ESMTPSA id v6sm2160881pjr.41.2021.09.08.04.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 04:19:58 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] Bluetooth: btandroid: Support Android Bluetooth Quality Report
Date:   Wed,  8 Sep 2021 19:19:49 +0800
Message-Id: <20210908191915.v2.1.I17f57656757b83a1c0fb4b78525d8aca581725db@changeid>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the btandroid.c file to support Android BQR commands.

This module may be referenced by btusb, btrtl, and hci_qca when a
Bluetooth controller supports the Android Bluetooth Quality Report.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

Changes in v2:
- Fix the titles of patches 2/3 and 3/3 and reduce their lengths.

 drivers/bluetooth/Makefile    |   1 +
 drivers/bluetooth/btandroid.c | 106 ++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btandroid.h |  10 ++++
 3 files changed, 117 insertions(+)
 create mode 100644 drivers/bluetooth/btandroid.c
 create mode 100644 drivers/bluetooth/btandroid.h

diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index 16286ea2655d..4d5d010bb947 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_BT_HCIBT3C)	+= bt3c_cs.o
 obj-$(CONFIG_BT_HCIBLUECARD)	+= bluecard_cs.o
 
 obj-$(CONFIG_BT_HCIBTUSB)	+= btusb.o
+obj-$(CONFIG_BT_HCIBTUSB)	+= btandroid.o
 obj-$(CONFIG_BT_HCIBTSDIO)	+= btsdio.o
 
 obj-$(CONFIG_BT_INTEL)		+= btintel.o
diff --git a/drivers/bluetooth/btandroid.c b/drivers/bluetooth/btandroid.c
new file mode 100644
index 000000000000..fffacc8d67cc
--- /dev/null
+++ b/drivers/bluetooth/btandroid.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  Support for Android Bluetooth Quality Report (BQR) specifications
+ *      https://source.android.com/devices/bluetooth/hci_requirements
+ *
+ *  Copyright (C) 2021 Google Corporation
+ */
+
+#include <linux/module.h>
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci.h>
+
+#include "btandroid.h"
+
+#define VERSION "0.1"
+
+/*
+ * Reference for the command op codes and parameters below:
+ *   https://source.android.com/devices/bluetooth/hci_requirements#bluetooth-quality-report-command
+ */
+#define BQR_COMMAND_OCF			0x015e
+#define BQR_OPCODE			hci_opcode_pack(0x3f, BQR_COMMAND_OCF)
+
+/* report action */
+#define REPORT_ACTION_ADD		0x00
+#define REPORT_ACTION_DELETE		0x01
+#define REPORT_ACTION_CLEAR		0x02
+
+/* BQR event masks */
+#define QUALITY_MONITORING		(1 << 0)
+#define APPRAOCHING_LSTO		(1 << 1)
+#define A2DP_AUDIO_CHOPPY		(1 << 2)
+#define SCO_VOICE_CHOPPY		(1 << 3)
+
+#define DEFAULT_BQR_EVENT_MASK	(QUALITY_MONITORING | APPRAOCHING_LSTO | \
+				 A2DP_AUDIO_CHOPPY | SCO_VOICE_CHOPPY)
+
+/*
+ * Reporting at seconds so as not to stress the controller too much.
+ * Range: 0 ~ 65535 ms
+ */
+#define DEFALUT_REPORT_INTERVAL_MS	5000
+
+struct android_bqr_cp {
+	__u8	report_action;
+	__u32	event_mask;
+	__u16	min_report_interval;
+} __packed;
+
+static int enable_quality_report(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+	struct android_bqr_cp cp;
+
+	cp.report_action = REPORT_ACTION_ADD;
+	cp.event_mask = DEFAULT_BQR_EVENT_MASK;
+	cp.min_report_interval = DEFALUT_REPORT_INTERVAL_MS;
+
+	skb = __hci_cmd_sync(hdev, BQR_OPCODE, sizeof(cp), &cp,
+							HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Enabling Android BQR failed (%ld)",
+			   PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+
+	kfree_skb(skb);
+	return 0;
+}
+
+static int disable_quality_report(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+	struct android_bqr_cp cp = { 0 };
+
+	cp.report_action = REPORT_ACTION_CLEAR;
+
+	skb = __hci_cmd_sync(hdev, BQR_OPCODE, sizeof(cp), &cp,
+							HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Disabling Android BQR failed (%ld)",
+			   PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+
+	kfree_skb(skb);
+	return 0;
+}
+
+int btandroid_set_quality_report(struct hci_dev *hdev, bool enable)
+{
+	bt_dev_info(hdev, "quality report enable %d", enable);
+
+	/* Enable or disable the quality report feature. */
+	if (enable)
+		return enable_quality_report(hdev);
+	else
+		return disable_quality_report(hdev);
+}
+EXPORT_SYMBOL_GPL(btandroid_set_quality_report);
+
+MODULE_AUTHOR("Google");
+MODULE_DESCRIPTION("Support for Android Bluetooth Specification " VERSION);
+MODULE_VERSION(VERSION);
+MODULE_LICENSE("GPL");
diff --git a/drivers/bluetooth/btandroid.h b/drivers/bluetooth/btandroid.h
new file mode 100644
index 000000000000..6abc9e8e0838
--- /dev/null
+++ b/drivers/bluetooth/btandroid.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *  Bluetooth support for Android specifications
+ *
+ *  Copyright (C) 2021 Google Corporation
+ */
+
+#include <net/bluetooth/hci_core.h>
+
+int btandroid_set_quality_report(struct hci_dev *hdev, bool enable);
-- 
2.33.0.153.gba50c8fa24-goog

