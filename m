Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11AB37F477
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 10:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbhEMIzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 04:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbhEMIzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 04:55:20 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD5FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 01:54:09 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id n142-20020a3727940000b02902fa8eadfa9eso5363761qkn.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 01:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=exBbpaDlUpab0D055arGk9FYXRsgj+RI0+CrJHgPipI=;
        b=ijOhI9Zq9tHZ97q5Q5n/zLDIgucTNQB/AW7kSW8Rl/i7uCfV+s9hgcs39fnRmr3xWA
         fIFGDq70p+JB1cjA0JQBxMFvt6gBzS1RVOOc4ASMsdOXINXxwPdwf4pajDU/Kt4ESqcx
         W27VpWeUiBXEBhNmKznQqw1OsmDMqix5WVjVLDvP03mFHHZvli0eDFrLN0sf3LXkTLMM
         iXanU8AAPFARRJJNeC33rTrDkcD3j9O8PQNB2Ef6GzvEgmVcWNQ6aHx5IqJvPMa23GeZ
         R9MAx0KFLl4rk8Ct33M57HXAFbcVMybe26du+WA93EA+Yci1uLryoDoD9yeLjfyyB5Yt
         DIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=exBbpaDlUpab0D055arGk9FYXRsgj+RI0+CrJHgPipI=;
        b=BAadrmoDcbnwkOlNPazkn1pEmG8crPFmmH4iXs3wMgUMzyL3xJUela7pzPOE/dVGDe
         INwon0bKHlFUhNQMJvSSgibpByotylqQkcmqdudsJcQsUpIfz8+B3uaQhRRLT5Osqefi
         YtDcCvjxQsIDXkCVM+dq/RHHwlIHLusyyZAY7Qx5VrhTa+G5je+C/6fhCK5qKmPE4O71
         fzjwN1fRGg3D+9ELEqURGHkNkaPs4xMpvYCdTAYJfMo8vVOdys4NNr3P4h8+n1iO8RIS
         49aGEJyuxLIMP+TDc6HIuUnt2/NIqt9B5pcORXL8DohGh+SPwX3GeBJdMLApIzHH1Fia
         0hkQ==
X-Gm-Message-State: AOAM531v7/A5GYNb0+U28H9DiGUgoQt7spv4w9DE6bpEc//TgpumjTC8
        crGBsNEqTsY4Xwl6+CBlFSBpr9fbSNcY
X-Google-Smtp-Source: ABdhPJwgZaQU3CgxYWMeH0hQkZG0oixaJRhZD+pcwpZQ3nu3OZvwz+DGAhmlKQeCfNtMPZBnnYo4/GpflTHJ
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:c41f:36bc:1f32:2f69])
 (user=apusaka job=sendgmr) by 2002:a05:6214:4d:: with SMTP id
 c13mr30150217qvr.15.1620896048894; Thu, 13 May 2021 01:54:08 -0700 (PDT)
Date:   Thu, 13 May 2021 16:54:00 +0800
Message-Id: <20210513165327.1.I4d214bb82746fb2ed94eb1c2100dda0f63cf9a25@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH] Bluetooth: hci_h5: Add RTL8822CS capabilities
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

RTL8822 chipset supports WBS, and this information is conveyed in
btusb.c. However, the UART driver doesn't have this information just
yet.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

 drivers/bluetooth/btrtl.c  | 26 ++++++++++++++++----------
 drivers/bluetooth/btrtl.h  |  2 ++
 drivers/bluetooth/hci_h5.c |  5 +----
 3 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index e7fe5fb22753..988a09860c6b 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -719,17 +719,8 @@ int btrtl_download_firmware(struct hci_dev *hdev,
 }
 EXPORT_SYMBOL_GPL(btrtl_download_firmware);
 
-int btrtl_setup_realtek(struct hci_dev *hdev)
+void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
 {
-	struct btrtl_device_info *btrtl_dev;
-	int ret;
-
-	btrtl_dev = btrtl_initialize(hdev, NULL);
-	if (IS_ERR(btrtl_dev))
-		return PTR_ERR(btrtl_dev);
-
-	ret = btrtl_download_firmware(hdev, btrtl_dev);
-
 	/* Enable controller to do both LE scan and BR/EDR inquiry
 	 * simultaneously.
 	 */
@@ -750,6 +741,21 @@ int btrtl_setup_realtek(struct hci_dev *hdev)
 		rtl_dev_dbg(hdev, "WBS supported not enabled.");
 		break;
 	}
+}
+EXPORT_SYMBOL_GPL(btrtl_set_quirks);
+
+int btrtl_setup_realtek(struct hci_dev *hdev)
+{
+	struct btrtl_device_info *btrtl_dev;
+	int ret;
+
+	btrtl_dev = btrtl_initialize(hdev, NULL);
+	if (IS_ERR(btrtl_dev))
+		return PTR_ERR(btrtl_dev);
+
+	ret = btrtl_download_firmware(hdev, btrtl_dev);
+
+	btrtl_set_quirks(hdev, btrtl_dev);
 
 	btrtl_free(btrtl_dev);
 	return ret;
diff --git a/drivers/bluetooth/btrtl.h b/drivers/bluetooth/btrtl.h
index 2a582682136d..260167f01b08 100644
--- a/drivers/bluetooth/btrtl.h
+++ b/drivers/bluetooth/btrtl.h
@@ -54,6 +54,8 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 void btrtl_free(struct btrtl_device_info *btrtl_dev);
 int btrtl_download_firmware(struct hci_dev *hdev,
 			    struct btrtl_device_info *btrtl_dev);
+void btrtl_set_quirks(struct hci_dev *hdev,
+		      struct btrtl_device_info *btrtl_dev);
 int btrtl_setup_realtek(struct hci_dev *hdev);
 int btrtl_shutdown_realtek(struct hci_dev *hdev);
 int btrtl_get_uart_settings(struct hci_dev *hdev,
diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 27e96681d583..e0520639f4ba 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -906,10 +906,7 @@ static int h5_btrtl_setup(struct h5 *h5)
 	/* Give the device some time before the hci-core sends it a reset */
 	usleep_range(10000, 20000);
 
-	/* Enable controller to do both LE scan and BR/EDR inquiry
-	 * simultaneously.
-	 */
-	set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &h5->hu->hdev->quirks);
+	btrtl_set_quirks(h5->hu->hdev, btrtl_dev);
 
 out_free:
 	btrtl_free(btrtl_dev);
-- 
2.31.1.751.gd2f1c929bd-goog

