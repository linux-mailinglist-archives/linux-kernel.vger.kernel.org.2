Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C273AC59F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 10:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbhFRIER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 04:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbhFRIDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 04:03:07 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20D8C061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 01:00:45 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id m17so1097406plx.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 01:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PNadQEIR3cQzWjVHVl6U6Trj5czCwGU5K/9fEbS0IFU=;
        b=NU8H2cHGLU8WEZ5cFDQ1P4KyBmnlbSWQ3asS8zTU2HWSpaLBo1Qq1YgqMQRniXV215
         zsPaU4Lv+/GkMn8szM2Mww/8H9FOeSNPT5cYd6zx9YJLYb/JNUn67jGYBeRn/ydFG8/A
         8ZN88h6ngwT4VeZmiHLk+IpA8YnqvoW6VkLFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PNadQEIR3cQzWjVHVl6U6Trj5czCwGU5K/9fEbS0IFU=;
        b=jfFeYlPqwSN27xQeRR6ogbDGEnl8YApxc7PDS8q6dPTml7hnIJv4O357IiytStTC1z
         IMJCklOhw54XUy1E3q7Kf+Deq+D8ZHQ8pqXKQMgLVpm6TXfPxavQsgY4EqXfbHHxg8hb
         ggxdHwXLeNFaGDFACsSntIiRnH/LyDMmom6OcrgSODJu+okMV08zlNrBMwM2rQdSKq1W
         TSrlvkHmR6qXfL7COsIhFRwP9Ke8/RchIen4gdWVnAlzPGXt0oIZH9aScJs+UEQZ0i8o
         wXgIPGP6KE3M8DecDAx2C/r3FnXXx4Sn68tKtUszOYzKYYTXU9U9tBxAtjwDIUrfVrLw
         j/UA==
X-Gm-Message-State: AOAM531uu/W0rQOFxxWhkVsa7bvj1F7hRWmEHUNzKHZr4bwzhWtTnps6
        h3Pyzn5AtbSEQdC5w+clIdMGpg==
X-Google-Smtp-Source: ABdhPJxzdqGEUb0JVxCzggTlO/YE2Y915WsH0HOI45DOrpgw0nqBKotR038Ddo1QhF7u299lTMRg4Q==
X-Received: by 2002:a17:90a:4e02:: with SMTP id n2mr5852194pjh.80.1624003245264;
        Fri, 18 Jun 2021 01:00:45 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:6cbb:95eb:e2ae:8479])
        by smtp.gmail.com with ESMTPSA id v21sm7341671pfu.77.2021.06.18.01.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 01:00:44 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     josephsih@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        Joseph Hwang <josephsih@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Kiran K <kiran.k@intel.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/4] Bluetooth: btusb: disable Intel link statistics telemetry events
Date:   Fri, 18 Jun 2021 16:00:36 +0800
Message-Id: <20210618160016.v4.1.I41aec59e65ffd3226d368dabeb084af13cc133c8@changeid>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid the overhead on both the controller and the host, the
Intel link statistics telemetry events are disabled by default.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

Changes in v4:
- The original 2 patches in Series-version 3 are split into
  2 patches from each patch per reviewers' comments. There are
  A total of 4 patches in this series now.
- The callback function is renamed from hdev->set_vs_dbg_evt to
  hdev->set_quality_report. Note that there are two different
  specifications which will be integrated soon and enabled/disabled
  with the same callback. One is Android Bluetooth Quality Report
  (BQR), and the other Intel link statistics telemetry events here.
  While most Bluetooth controller vendors have supported or are
  supporting the Android specification in their controllers, it looks
  making sense to use set_quality_report as the callback name.
- Similarly, the config option BT_FEATURE_VS_DBG_EVT is renamed as
  BT_FEATURE_QUALITY_REPORT which depends on BT now.
- The BQR is controller specific. There needs to be a valid hdev in the
  first place. This is fixed in set_exp_feature().
- In set_exp_feature(), bluez will only set experimental feature to set
  BQR when the feature is supported. Please refer to bluez CLs.
- Also refer to bluez patches for the decoding support of btmon.

Changes in v3:
- fix the long line in the commit message

Changes in v2:
- take care of intel_newgen as well as intel_new
- fix the long lines in mgmt.c

 drivers/bluetooth/btusb.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a9855a2dd561..4c3b26c5e507 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2850,7 +2850,6 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	u32 boot_param;
 	char ddcname[64];
 	int err;
-	struct intel_debug_features features;
 
 	BT_DBG("%s", hdev->name);
 
@@ -2904,14 +2903,6 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
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
@@ -2950,7 +2941,6 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
 	u32 boot_param;
 	char ddcname[64];
 	int err;
-	struct intel_debug_features features;
 	struct intel_version_tlv version;
 
 	bt_dev_dbg(hdev, "");
@@ -3000,14 +2990,6 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
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
2.32.0.288.g62a8d224e6-goog

