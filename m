Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A393D398A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 13:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbhGWKvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 06:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234549AbhGWKvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 06:51:43 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4A8C061760
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 04:32:16 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id 10-20020a0562140d0ab02902ea7953f97fso1508849qvh.22
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 04:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wopAMfAFodufVPIjdUMCKKzBY2Yv7x4TcVUiniEv4ds=;
        b=nJFm0U+LLxx1CSpdg2n2/hM1YuQ1BSQx3wRINnedjPgDNlptDEDPIoBFU/mzv9LR4v
         Jgj36Mvy4Ec7Cbec8uam/ygQfPWXrwnGM+6cp42x0AP17UE6e45ScX1D++SSsQPv43p3
         E7mcIwgeUB5elAXvfzfG8KfuQxL5+qG5yjY3KGRhpmZEW3JkYGjkH/aKohTX0vGXE21X
         ZPoNLqEqkNgz9qccmvc2h+ldkMEairCnBg9Bw9ARVvC/NHhLZAHuIt8biurg3Hvv+fUN
         nrVTUUCKyezRSHdOeAvalsGXbKCMOHdYqnl9N0Qte7M7a2ZlE74TxYn21kx+SxtiYxDf
         V2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wopAMfAFodufVPIjdUMCKKzBY2Yv7x4TcVUiniEv4ds=;
        b=WBGvKLCzNqGRpQH8pvoIYeZuwYBhFeEiiYf4P7HsbWWUxIhSYkmIxLIlNxbIJ16Au7
         yy9SyDqLqtc9l3n0vFk84sjASygCNDcAgQhSMehfIx5Y7YwtdSHUYIaRc/OnntNkuOBa
         V1xHTVW8f3tNqObK8WwEEUFMwRUVyM90A95T6x5FBwz1Hap+dj8TNp/nBYxQYQYDJlCK
         kcImhqrsZ0YBFIhBySqEHljNFNHLYXA8avOt+6UoB9OQTPn7CI45ugqOd6NsS7LxJRpM
         lrt8l33xqQUvbivB1mj1gxJN6jG01oKq7/ce4HRSunuyp/LJMSfbMYpZZ/jLqIxXVw1M
         X7AQ==
X-Gm-Message-State: AOAM533e+FFfxEpOpUxSOIVvx6d/Vse/2JsDKAfJ+7yoQUMiApIvx1hW
        bZQzL+SRaRtr8vzL+mZkzPi7nwG0nYNR
X-Google-Smtp-Source: ABdhPJzzciscGeoQb/3TDTQkKv1iVFzZNg+dYYKjG3X4UaiQH6HE1XMRjwR0xZTJLi8Qf8xKe1ZjgwW1LDMy
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:ddde:33b:f989:cd76])
 (user=apusaka job=sendgmr) by 2002:a05:6214:10c8:: with SMTP id
 r8mr4346292qvs.28.1627039935616; Fri, 23 Jul 2021 04:32:15 -0700 (PDT)
Date:   Fri, 23 Jul 2021 19:31:57 +0800
In-Reply-To: <20210723193137.v3.1.I68649745bd11a83265f1e816bf34ecc82775e95a@changeid>
Message-Id: <20210723193137.v3.3.I4b323d2adf1dca62777c41de344a7d2f79b7f908@changeid>
Mime-Version: 1.0
References: <20210723193137.v3.1.I68649745bd11a83265f1e816bf34ecc82775e95a@changeid>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v3 3/3] Bluetooth: hci_h5: Add runtime suspend
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

Changes in v3:
* Reordering #include

 drivers/bluetooth/hci_h5.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index cbc63b057f33..0c0dedece59c 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
 #include <linux/of_device.h>
+#include <linux/pm_runtime.h>
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
2.32.0.432.gabb21c7263-goog

