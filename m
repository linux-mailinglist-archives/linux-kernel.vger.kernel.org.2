Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5D33C7F29
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 09:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238225AbhGNHQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 03:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238139AbhGNHQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 03:16:37 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B46FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 00:13:46 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x15-20020a25ce0f0000b029055bb0981111so1490184ybe.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 00:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=KFBkxoUD/o9yz/RhAxI9E4kJa7uKniUZjvzDQA7KYYU=;
        b=t7wtKX75VmH4wKkWF0q6RWqb06RptYVYNLaMFxEhrC/Vh4PHV07j8rtYDcGu6MMeZU
         jk4qVVM0eXc/fnTa5wt2NKnEhOH2zzGGwr6jmPSWoLGToBDQynQxadRyU+xL23CETgIr
         hM1pu1epk/R3iRcZJupsH2dcamXuHr4nHnSU8MoxSMrkpkHa9wSDF2cAwKVCbhrJk4zn
         IXhfupNyMO0ZbpHpxYoH3TQ9Ya5FBNdZtwE/46pNyITVpLTlFFaxaYjy1zl6FxR6GYz7
         aD9jfwLO/+1aE/ItSWaxeK9bOT9iwRtAcrBds6VzLXCh6QE9EDTbmZ1ylhjG/sHuIsX7
         bvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=KFBkxoUD/o9yz/RhAxI9E4kJa7uKniUZjvzDQA7KYYU=;
        b=XeSSyOJ8y9JJ+WzOhmHHzAHikzvR/uN2EnWFtWLikYPX+DtNW3ALtU4PrIu7JiUJsz
         7C9LzVeDHNHM/bvbNeFl2s3kb0GPc0lkQDoHDTi4bze3C7b3RPcJDWNfviLbGPYCI3jQ
         Ptxxjfg0JM48sTLvaFO+rH4Hfgu4xyIYmlORHAdp4E0EdC/0Gx7tD4kB2GH1KVI4XFnO
         YfYC53DvE9tYyUWeQh02dV6/i1LT5UnFofeCGNnBs4hTvM4fV182yvjVIEoknRbEF00T
         mCT+cAtlqCVXZ00GgTZRDCx8xk+qnaXbbPJuCWLOXze0BraaXrrbRLG1XFK4xy7rYnSo
         Bd/Q==
X-Gm-Message-State: AOAM530/1d5Gl9U2hANN9vpAd0kTWdRvZ9xmWZ/3cteeoFLZxH2r8+dH
        lTAgTqpSBBlOC40nLJYnSWlNdmuAmqm4
X-Google-Smtp-Source: ABdhPJxz1iphW0s/Q7YNoQROAdpOxnpVY07NTD1R0PR3fTbbt5D5k+jQDCGoVPhQav/tKETNK0izq7JFYWdU
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:ecf5:ef03:eb15:e989])
 (user=apusaka job=sendgmr) by 2002:a25:ac04:: with SMTP id
 w4mr11729125ybi.431.1626246825570; Wed, 14 Jul 2021 00:13:45 -0700 (PDT)
Date:   Wed, 14 Jul 2021 15:13:38 +0800
Message-Id: <20210714151332.1.I68649745bd11a83265f1e816bf34ecc82775e95a@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH 1/3] Bluetooth: hci_h5: add WAKEUP_DISABLE flag
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

Some RTL chips resets the FW on suspend, so wakeup is disabled on
those chips. This patch introduces this WAKEUP_DISABLE flag so that
chips that doesn't reset FW on suspend can leave the flag unset and
is allowed to wake the host.

This patch also left RTL8822 WAKEUP_DISABLE flag unset, therefore
allowing it to wake the host, and preventing reprobing on resume.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Hilda Wu <hildawu@realtek.com>

---

 drivers/bluetooth/hci_h5.c | 86 +++++++++++++++++++++++++++-----------
 1 file changed, 62 insertions(+), 24 deletions(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 7b985c7cd26d..947246569434 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -51,8 +51,9 @@
 
 /* H5 state flags */
 enum {
-	H5_RX_ESC,	/* SLIP escape mode */
-	H5_TX_ACK_REQ,	/* Pending ack to send */
+	H5_RX_ESC,		/* SLIP escape mode */
+	H5_TX_ACK_REQ,		/* Pending ack to send */
+	H5_WAKEUP_DISABLE,	/* Device cannot wake host */
 };
 
 struct h5 {
@@ -97,6 +98,10 @@ struct h5 {
 	struct gpio_desc *device_wake_gpio;
 };
 
+enum h5_driver_info {
+	H5_INFO_WAKEUP_DISABLE = BIT(0),
+};
+
 struct h5_vnd {
 	int (*setup)(struct h5 *h5);
 	void (*open)(struct h5 *h5);
@@ -106,6 +111,11 @@ struct h5_vnd {
 	const struct acpi_gpio_mapping *acpi_gpio_map;
 };
 
+struct h5_device_data {
+	uint32_t driver_info;
+	struct h5_vnd *vnd;
+};
+
 static void h5_reset_rx(struct h5 *h5);
 
 static void h5_link_control(struct hci_uart *hu, const void *data, size_t len)
@@ -791,6 +801,9 @@ static int h5_serdev_probe(struct serdev_device *serdev)
 {
 	struct device *dev = &serdev->dev;
 	struct h5 *h5;
+	struct hci_dev *hdev;
+	const struct h5_device_data *data;
+	int err;
 
 	h5 = devm_kzalloc(dev, sizeof(*h5), GFP_KERNEL);
 	if (!h5)
@@ -807,20 +820,19 @@ static int h5_serdev_probe(struct serdev_device *serdev)
 		if (!match)
 			return -ENODEV;
 
-		h5->vnd = (const struct h5_vnd *)match->driver_data;
+		data = (const struct h5_device_data *)match->driver_data;
+		h5->vnd = data->vnd;
 		h5->id  = (char *)match->id;
 
 		if (h5->vnd->acpi_gpio_map)
 			devm_acpi_dev_add_driver_gpios(dev,
 						       h5->vnd->acpi_gpio_map);
 	} else {
-		const void *data;
-
 		data = of_device_get_match_data(dev);
 		if (!data)
 			return -ENODEV;
 
-		h5->vnd = (const struct h5_vnd *)data;
+		h5->vnd = data->vnd;
 	}
 
 
@@ -833,7 +845,16 @@ static int h5_serdev_probe(struct serdev_device *serdev)
 	if (IS_ERR(h5->device_wake_gpio))
 		return PTR_ERR(h5->device_wake_gpio);
 
-	return hci_uart_register_device(&h5->serdev_hu, &h5p);
+	err = hci_uart_register_device(&h5->serdev_hu, &h5p);
+	if (err)
+		return err;
+
+	hdev = h5->serdev_hu.hdev;
+
+	if (data->driver_info & H5_INFO_WAKEUP_DISABLE)
+		set_bit(H5_WAKEUP_DISABLE, &h5->flags);
+
+	return 0;
 }
 
 static void h5_serdev_remove(struct serdev_device *serdev)
@@ -921,7 +942,8 @@ static void h5_btrtl_open(struct h5 *h5)
 	 * done by the hci_suspend_notifier is not necessary; it actually causes
 	 * delays and a bunch of errors to get logged, so disable it.
 	 */
-	set_bit(HCI_UART_NO_SUSPEND_NOTIFIER, &h5->hu->flags);
+	if (test_bit(H5_WAKEUP_DISABLE, &h5->flags))
+		set_bit(HCI_UART_NO_SUSPEND_NOTIFIER, &h5->hu->flags);
 
 	/* Devices always start with these fixed parameters */
 	serdev_device_set_flow_control(h5->hu->serdev, false);
@@ -942,15 +964,18 @@ static void h5_btrtl_close(struct h5 *h5)
 
 /* Suspend/resume support. On many devices the RTL BT device loses power during
  * suspend/resume, causing it to lose its firmware and all state. So we simply
- * turn it off on suspend and reprobe on resume.  This mirrors how RTL devices
- * are handled in the USB driver, where the USB_QUIRK_RESET_RESUME is used which
+ * turn it off on suspend and reprobe on resume. This mirrors how RTL devices
+ * are handled in the USB driver, where the BTUSB_WAKEUP_DISABLE is used which
  * also causes a reprobe on resume.
  */
 static int h5_btrtl_suspend(struct h5 *h5)
 {
 	serdev_device_set_flow_control(h5->hu->serdev, false);
 	gpiod_set_value_cansleep(h5->device_wake_gpio, 0);
-	gpiod_set_value_cansleep(h5->enable_gpio, 0);
+
+	if (test_bit(H5_WAKEUP_DISABLE, &h5->flags))
+		gpiod_set_value_cansleep(h5->enable_gpio, 0);
+
 	return 0;
 }
 
@@ -976,17 +1001,21 @@ static void h5_btrtl_reprobe_worker(struct work_struct *work)
 
 static int h5_btrtl_resume(struct h5 *h5)
 {
-	struct h5_btrtl_reprobe *reprobe;
+	if (test_bit(H5_WAKEUP_DISABLE, &h5->flags)) {
+		struct h5_btrtl_reprobe *reprobe;
 
-	reprobe = kzalloc(sizeof(*reprobe), GFP_KERNEL);
-	if (!reprobe)
-		return -ENOMEM;
+		reprobe = kzalloc(sizeof(*reprobe), GFP_KERNEL);
+		if (!reprobe)
+			return -ENOMEM;
 
-	__module_get(THIS_MODULE);
+		__module_get(THIS_MODULE);
 
-	INIT_WORK(&reprobe->work, h5_btrtl_reprobe_worker);
-	reprobe->dev = get_device(&h5->hu->serdev->dev);
-	queue_work(system_long_wq, &reprobe->work);
+		INIT_WORK(&reprobe->work, h5_btrtl_reprobe_worker);
+		reprobe->dev = get_device(&h5->hu->serdev->dev);
+		queue_work(system_long_wq, &reprobe->work);
+	} else {
+		gpiod_set_value_cansleep(h5->device_wake_gpio, 1);
+	}
 	return 0;
 }
 
@@ -1008,13 +1037,22 @@ static struct h5_vnd rtl_vnd = {
 	.resume		= h5_btrtl_resume,
 	.acpi_gpio_map	= acpi_btrtl_gpios,
 };
+
+static const struct h5_device_data h5_data_rtl8822cs = {
+	.vnd = &rtl_vnd,
+};
+
+static const struct h5_device_data h5_data_rtl8723bs = {
+	.driver_info = H5_INFO_WAKEUP_DISABLE,
+	.vnd = &rtl_vnd,
+};
 #endif
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id h5_acpi_match[] = {
 #ifdef CONFIG_BT_HCIUART_RTL
-	{ "OBDA0623", (kernel_ulong_t)&rtl_vnd },
-	{ "OBDA8723", (kernel_ulong_t)&rtl_vnd },
+	{ "OBDA0623", (kernel_ulong_t)&h5_data_rtl8723bs },
+	{ "OBDA8723", (kernel_ulong_t)&h5_data_rtl8723bs },
 #endif
 	{ },
 };
@@ -1028,11 +1066,11 @@ static const struct dev_pm_ops h5_serdev_pm_ops = {
 static const struct of_device_id rtl_bluetooth_of_match[] = {
 #ifdef CONFIG_BT_HCIUART_RTL
 	{ .compatible = "realtek,rtl8822cs-bt",
-	  .data = (const void *)&rtl_vnd },
+	  .data = (const void *)&h5_data_rtl8822cs },
 	{ .compatible = "realtek,rtl8723bs-bt",
-	  .data = (const void *)&rtl_vnd },
+	  .data = (const void *)&h5_data_rtl8723bs },
 	{ .compatible = "realtek,rtl8723ds-bt",
-	  .data = (const void *)&rtl_vnd },
+	  .data = (const void *)&h5_data_rtl8723bs },
 #endif
 	{ },
 };
-- 
2.32.0.93.g670b81a890-goog

