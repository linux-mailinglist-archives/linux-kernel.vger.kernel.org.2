Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90CA13C7F2E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 09:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238291AbhGNHQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 03:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238270AbhGNHQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 03:16:49 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D0AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 00:13:57 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id k3-20020a6568c30000b029022887377adeso845142pgt.15
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 00:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4VkQ1Iiul9IdyOdh2D5ZbpYEPyiXApvR1eCAJNvVrsM=;
        b=dxNkLIPensbh7CpTTLhNxTKlMxa+tVRgW2IpfGuC2M0ke9N83F29aMXYvdgT++ZeKf
         lPupsD+yhcXH83PTMl4NaZTdABK6AVCx2vXKVL0+2ZgfKsHQZiwYXLwx7Oik0k6QEj8T
         QV8hDr8qAXLW0XQRgBl2/G606qPuLXe8B6cjBtpo1DzEu2RmMxFgJ3UsvMwTFd7gutlv
         0lalDf1wwfId21Pqcka2HuExBj6t0RpqFNRSLn9cVikoPQrhdID8PPPXgFKpggfGwOK4
         TQ4xQ1Zzdu4jpj4SfHkybrYW51juhWWRtgm4R7k5dW1zghvnKg0GDMrbN3D8EWMsWgsr
         6jJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4VkQ1Iiul9IdyOdh2D5ZbpYEPyiXApvR1eCAJNvVrsM=;
        b=mesWgBk5sWFEvMfcHXBsi57qHvf055ovzQmrdO2rsIDhoYgFoFWzDTh/M9kzNi2ygC
         KvJtpGd0Q6Du02dBoKAEvfkC0DGOW9+ZqTfvuaZPppYZpnL59DdnGbm3ty4/c5f/QLFW
         NHR2ZgiEgZezWVif3YpMDsNdfNYjIQJnxIz5TTXyb14rXMkus1WknvR7mx+/8TYITdsO
         /dBh9Wl5ma6pggcTwvPqbbTzLPYI5qgTI/q+/qQlSMTMZdAYZltopGBFSH6sSsYbLlUG
         iqiE+5KDYbJ3M4MQg4S2GKlep3QPU5swVIU1MFOZu6cQjlIxar/qLukmPHsw7aWvarr6
         3KUw==
X-Gm-Message-State: AOAM5336Qf8tvOJ57WqNXnaaVrGGCz7qz6l9ksMf627PoYpfa0PMoIEV
        YEnpaNXFN7uYg5pc5gy0SzihyVYDoZuT
X-Google-Smtp-Source: ABdhPJx4joST/q+l0Tth0jRspoxkgMhbzuHImZ6dAlxfN1Ug6/UIMqXCbd5quC1pkIjexHXeIAe2JqP0C20E
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:ecf5:ef03:eb15:e989])
 (user=apusaka job=sendgmr) by 2002:a17:90a:a393:: with SMTP id
 x19mr289600pjp.1.1626246836513; Wed, 14 Jul 2021 00:13:56 -0700 (PDT)
Date:   Wed, 14 Jul 2021 15:13:40 +0800
In-Reply-To: <20210714151332.1.I68649745bd11a83265f1e816bf34ecc82775e95a@changeid>
Message-Id: <20210714151332.3.I4b323d2adf1dca62777c41de344a7d2f79b7f908@changeid>
Mime-Version: 1.0
References: <20210714151332.1.I68649745bd11a83265f1e816bf34ecc82775e95a@changeid>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH 3/3] Bluetooth: hci_h5: Add runtime suspend
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

 drivers/bluetooth/hci_h5.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 67fcf192d5c5..41039cadd6f8 100644
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
 
@@ -954,6 +965,12 @@ static void h5_btrtl_open(struct h5 *h5)
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
@@ -962,6 +979,8 @@ static void h5_btrtl_open(struct h5 *h5)
 
 static void h5_btrtl_close(struct h5 *h5)
 {
+	pm_runtime_disable(&h5->hu->serdev->dev);
+
 	gpiod_set_value_cansleep(h5->device_wake_gpio, 0);
 	gpiod_set_value_cansleep(h5->enable_gpio, 0);
 }
@@ -1069,6 +1088,7 @@ MODULE_DEVICE_TABLE(acpi, h5_acpi_match);
 
 static const struct dev_pm_ops h5_serdev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(h5_serdev_suspend, h5_serdev_resume)
+	SET_RUNTIME_PM_OPS(h5_serdev_suspend, h5_serdev_resume, NULL)
 };
 
 static const struct of_device_id rtl_bluetooth_of_match[] = {
-- 
2.32.0.93.g670b81a890-goog

