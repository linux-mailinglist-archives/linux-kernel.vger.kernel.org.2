Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05DB43DF166
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 17:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236716AbhHCP1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 11:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236729AbhHCP1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 11:27:43 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C186C061798
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 08:27:28 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id j18-20020a17090aeb12b029017737e6c349so3153692pjz.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 08:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CbJpw/V4OPiAZHTSQ45FsW7F9yTlFc0tteK+tjxoFf0=;
        b=fff0IR+Nb/HujyLFvnTO1wNhj5aw1Bs7U90IwECsrFuj7sffG0jV1YreBDw/IaPtEu
         +MFW/Cqv8Z0Y6TTxm9w7aIk+2f0ExmAIFbFAu/+pixG1Nk+jMIuz4cOirorGHBvKJLyV
         wSx2KdaUGFaedgHfwV9jcw39KSQHVNNmwl3As=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CbJpw/V4OPiAZHTSQ45FsW7F9yTlFc0tteK+tjxoFf0=;
        b=Yb3OoIvSQ29PG769jGcfSuHv8mAmz9OI+hIvieWOXaf8r85yxZewYTt8lcDqw3Bbi3
         SI2ycuTBGA5AXmqRqZiT+tHLwp4KassJWW82qaQeBnQ9BL+4H4G1X4qaHvaBpBo0gbJI
         t/lYC0jJZzoQJxF88UKlrnFoSCCf+GoqyASK1kIUT8xr2sK/M+Emn9yrm2z2isKFhu64
         4/R//fu0VwnGbYbZntNS4FLGf+boeY1ZunWEnVloka4WlKvmV/UrdK3dqUkBp38vdDSI
         SbQcJH6XFgRdjaexfMcxFrycXHE3XW2dDoyGbYyfYOZNDmPpdT4uOgrUIdwNZoz/fJwG
         2GWw==
X-Gm-Message-State: AOAM532MH/O7EWjBdfy7Vix4K6rqMp96FrC5Lrfo1S3yim/mi0aW73fH
        Kk9XWRdQ2qjpOJ6CBBTeWJmY7w==
X-Google-Smtp-Source: ABdhPJyvl5m5aSbxqpFMrNWiXHDpZmYxVI98R+Gqlc3QavK/tb5TXV4yjcSQ/j4/ABSDOSjHEibtrQ==
X-Received: by 2002:a63:b4d:: with SMTP id a13mr110359pgl.404.1628004448345;
        Tue, 03 Aug 2021 08:27:28 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:7cf5:7e9:5266:c8ba])
        by smtp.gmail.com with ESMTPSA id v30sm14922493pgk.25.2021.08.03.08.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 08:27:27 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Kiran K <kiran.k@intel.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/4] Bluetooth: btusb: disable Intel link statistics telemetry events
Date:   Tue,  3 Aug 2021 23:27:16 +0800
Message-Id: <20210803232539.v5.1.I41aec59e65ffd3226d368dabeb084af13cc133c8@changeid>
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
index b1a05bb9f4bf..97414746c029 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2865,7 +2865,6 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	u32 boot_param;
 	char ddcname[64];
 	int err;
-	struct intel_debug_features features;
 
 	BT_DBG("%s", hdev->name);
 
@@ -2919,15 +2918,6 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
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
@@ -2966,7 +2956,6 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
 	u32 boot_param;
 	char ddcname[64];
 	int err;
-	struct intel_debug_features features;
 	struct intel_version_tlv version;
 
 	bt_dev_dbg(hdev, "");
@@ -3016,15 +3005,6 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
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

