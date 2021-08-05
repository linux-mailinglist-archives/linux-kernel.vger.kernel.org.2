Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F733E11D7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 12:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240147AbhHEKDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 06:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239998AbhHEKDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 06:03:22 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D45C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 03:03:07 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id q17-20020a17090a2e11b02901757deaf2c8so8099712pjd.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 03:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HinnzQs+V+jlpiaHdzAVaf4tg7IFpH4tXsZwcgOSnzM=;
        b=gEotc+qo98CQ3Sm4nZHM9JTaYRfNGwOwG6Beq9BXXg6GhMXhdsZUNIOjHtWNDS3zem
         v4QcdN6PgDDffsxDkAk962JQn67LcVHhyC5yuBQKQbOrgCRJX7DKHZfMBS2NVdY3yCCE
         SAVk4W5UuL8+Jk5nuX0aw3dvxDLadK6f9ZmWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HinnzQs+V+jlpiaHdzAVaf4tg7IFpH4tXsZwcgOSnzM=;
        b=MA3+0+j3UYMXaLXij+VcMs2FG172FcnV+UqX8LGsSeK/rPMhZjclGZUl48RC3st7ER
         YDCvcwUO8S7u3ACvOjKUY0JYG4xzjM3wejfddexMKu3mgZJHrj2aSA0E7UxytCaRKbSR
         VX4qQbzxin2E+GCSMDIVl0kavZLQUo3eOa9lJ7whpiAjEyeAPStqohi0nE6GCF1sqBFt
         TJtPzvw8PRJMVOxgQyh7Y8qaz7JRMsMSTD3XZ5VvSwHgNhcQJXxtw8d8xJewqxEKIUxV
         d6i7I9SR6bHmWgTQkvZZl1ze3PQNb7AutPEWuSyM9Otgq8Dx9L5x7gvSErg0+D2z6kiP
         bwzA==
X-Gm-Message-State: AOAM532GHBp97QmMQtYdFZJOM5Bh6IglNsdZX0xkGwBGyC3U426cUP3/
        gMrvhJuHVfKrPx+Wyqe87aMyxw==
X-Google-Smtp-Source: ABdhPJzb0GLZ5STr5wX2eHmHTMVBrFYi+kWu4rYVsMeXl+CrEp7OxUlcmDiXyO4mbDvkZyyO0MhULg==
X-Received: by 2002:a65:5288:: with SMTP id y8mr108678pgp.275.1628157786630;
        Thu, 05 Aug 2021 03:03:06 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:2c18:41ac:c6a8:ddfe])
        by smtp.gmail.com with ESMTPSA id jz24sm5436194pjb.9.2021.08.05.03.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 03:03:05 -0700 (PDT)
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
Subject: [PATCH v6 1/4] Bluetooth: btusb: disable Intel link statistics telemetry events
Date:   Thu,  5 Aug 2021 18:02:57 +0800
Message-Id: <20210805180227.v6.1.I41aec59e65ffd3226d368dabeb084af13cc133c8@changeid>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
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

Changes in v6:
- Rebase on the latest commit.

Changes in v5:
- Rebase this patch 1/4 to resolve conflicts.
- There are changes in patches 3/4 and 4/4.

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

 drivers/bluetooth/btusb.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 8c4e3977cce2..30462de288c7 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2870,7 +2870,6 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	u32 boot_param;
 	char ddcname[64];
 	int err;
-	struct intel_debug_features features;
 
 	BT_DBG("%s", hdev->name);
 
@@ -2924,15 +2923,6 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 		btintel_load_ddc_config(hdev, ddcname);
 	}
 
-	/* Read the Intel supported features and if new exception formats
-	 * supported, need to load the additional DDC config to enable.
-	 */
-	err = btintel_read_debug_features(hdev, &features);
-	if (!err) {
-		/* Set DDC mask for available debug features */
-		btintel_set_debug_features(hdev, &features);
-	}
-
 	/* Read the Intel version information after loading the FW  */
 	err = btintel_read_version(hdev, &ver);
 	if (err)
@@ -2971,7 +2961,6 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
 	u32 boot_param;
 	char ddcname[64];
 	int err;
-	struct intel_debug_features features;
 	struct intel_version_tlv version;
 
 	bt_dev_dbg(hdev, "");
@@ -3021,15 +3010,6 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
 	 */
 	btintel_load_ddc_config(hdev, ddcname);
 
-	/* Read the Intel supported features and if new exception formats
-	 * supported, need to load the additional DDC config to enable.
-	 */
-	err = btintel_read_debug_features(hdev, &features);
-	if (!err) {
-		/* Set DDC mask for available debug features */
-		btintel_set_debug_features(hdev, &features);
-	}
-
 	/* Read the Intel version information after loading the FW  */
 	err = btintel_read_version_tlv(hdev, &version);
 	if (err)
-- 
2.32.0.554.ge1b32706d8-goog

