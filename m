Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1CA3CA0F9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 16:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238156AbhGOOzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 10:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238076AbhGOOzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 10:55:11 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B51C061760
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 07:52:16 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id bm22-20020a05620a1996b02903b87dad5a1dso3918152qkb.23
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 07:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QKhwAp39hW3ocoCF4aqrDutBWf5OOZ3fiizl2xE7StM=;
        b=ou1UBuj08Z5EqeU3Hlm6zqcnhXaOCJzYPApeTlA42TdireB/FK0ykv2krZXzFyhn7+
         Rlh0rYNwzc+wlvdrFjtnDK7Gg1Uu0oIuxVaieECO4drELEvfB2+miH7/Bn+rJ+7TCqep
         RZuEMAsk+kN6Rd8za0fnyLe6IdVz594NrZJ8ZXtbQ/UF8wKct3aG/vv7jpntnQtjsSwq
         /jqH6pj1un97POXkh80co5DfUN/mNYg/UNV8KkrVMzS7KtN5+ruLVBX8b3VzMfUg07qk
         xADhBnLoK2liqXIIorDHve19cY+nxrtOAvulmA3scOdwVFKaJ1AErpVZGAyXT8s9ADgC
         T/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QKhwAp39hW3ocoCF4aqrDutBWf5OOZ3fiizl2xE7StM=;
        b=bIX139Gs9CSkOly2pDuQR0rW0+KcJf/JI4xjvzgWx+qh6NJyiITrPNhrw+WDKKQ2KI
         ovu6UmSsIfOhCexBdlqPZwWKEYC177j2wOoC2nBz03GEi08A4bjikar0fo1dRm/vgG1v
         e0SG6xbjjLAQG5DVvfO16pwNRv7APJaTVt+5ULfpWGDjMlU8mDUHxcwBbW75QsPnOIIv
         iDAgx06c31+oqZzENzTD/61rEkqo0P4VtgXnmSTFMSPudWVih1SiajNIYjDFWMCgKVGu
         qmF/uTWdgr8nTYfUO7Hue9+wLJlpwmg3VRj6s/CLaturYrNYRjfbyt2VeaICH/y3kw90
         nGhg==
X-Gm-Message-State: AOAM530tilKhoDBJgQvmACek9W2zVUfpwVth2oVajJOxYDSay6NLkUBv
        pq7JPIynUaUbBZM4JX9qXgBydemlEKG5
X-Google-Smtp-Source: ABdhPJxWOh0bGdoMKCzBaF7LVBpQ3LHdUwc4SOxL2qxRSI/KBLA/4pzMiqNeAqQi79/DaNr08KibnOHM9TiH
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:d9e1:875d:57dd:2e32])
 (user=apusaka job=sendgmr) by 2002:a05:6214:4e2:: with SMTP id
 cl2mr4671805qvb.55.1626360735981; Thu, 15 Jul 2021 07:52:15 -0700 (PDT)
Date:   Thu, 15 Jul 2021 22:52:00 +0800
In-Reply-To: <20210715225146.v2.1.I68649745bd11a83265f1e816bf34ecc82775e95a@changeid>
Message-Id: <20210715225146.v2.3.I4b323d2adf1dca62777c41de344a7d2f79b7f908@changeid>
Mime-Version: 1.0
References: <20210715225146.v2.1.I68649745bd11a83265f1e816bf34ecc82775e95a@changeid>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v2 3/3] Bluetooth: hci_h5: Add runtime suspend
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Hilda Wu <hildawu@realtek.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

This patch allows the controller to suspend after a short period of
inactivity.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Hilda Wu <hildawu@realtek.com>

---

(no changes since v1)

 drivers/bluetooth/hci_h5.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index cbc63b057f33..f95ec9991180 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -11,6 +11,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
+#include <linux/pm_runtime.h>
 #include <linux/of_device.h>
 #include <linux/serdev.h>
 #include <linux/skbuff.h>
@@ -21,6 +22,8 @@
 #include "btrtl.h"
 #include "hci_uart.h"
 
+#define SUSPEND_TIMEOUT_MS	6000
+
 #define HCI_3WIRE_ACK_PKT	0
 #define HCI_3WIRE_LINK_PKT	15
 
@@ -584,6 +587,10 @@ static int h5_recv(struct hci_uart *hu, const void *data, int count)
 		count -= processed;
 	}
 
+	pm_runtime_get(&hu->serdev->dev);
+	pm_runtime_mark_last_busy(&hu->serdev->dev);
+	pm_runtime_put_autosuspend(&hu->serdev->dev);
+
 	return 0;
 }
 
@@ -620,6 +627,10 @@ static int h5_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 		break;
 	}
 
+	pm_runtime_get_sync(&hu->serdev->dev);
+	pm_runtime_mark_last_busy(&hu->serdev->dev);
+	pm_runtime_put_autosuspend(&hu->serdev->dev);
+
 	return 0;
 }
 
@@ -951,6 +962,12 @@ static void h5_btrtl_open(struct h5 *h5)
 	serdev_device_set_parity(h5->hu->serdev, SERDEV_PARITY_EVEN);
 	serdev_device_set_baudrate(h5->hu->serdev, 115200);
 
+	pm_runtime_set_active(&h5->hu->serdev->dev);
+	pm_runtime_use_autosuspend(&h5->hu->serdev->dev);
+	pm_runtime_set_autosuspend_delay(&h5->hu->serdev->dev,
+					 SUSPEND_TIMEOUT_MS);
+	pm_runtime_enable(&h5->hu->serdev->dev);
+
 	/* The controller needs up to 500ms to wakeup */
 	gpiod_set_value_cansleep(h5->enable_gpio, 1);
 	gpiod_set_value_cansleep(h5->device_wake_gpio, 1);
@@ -959,6 +976,8 @@ static void h5_btrtl_open(struct h5 *h5)
 
 static void h5_btrtl_close(struct h5 *h5)
 {
+	pm_runtime_disable(&h5->hu->serdev->dev);
+
 	gpiod_set_value_cansleep(h5->device_wake_gpio, 0);
 	gpiod_set_value_cansleep(h5->enable_gpio, 0);
 }
@@ -1066,6 +1085,7 @@ MODULE_DEVICE_TABLE(acpi, h5_acpi_match);
 
 static const struct dev_pm_ops h5_serdev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(h5_serdev_suspend, h5_serdev_resume)
+	SET_RUNTIME_PM_OPS(h5_serdev_suspend, h5_serdev_resume, NULL)
 };
 
 static const struct of_device_id rtl_bluetooth_of_match[] = {
-- 
2.32.0.93.g670b81a890-goog

