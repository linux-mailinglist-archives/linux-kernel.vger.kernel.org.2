Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC063CA0F5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 16:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238018AbhGOOzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 10:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbhGOOzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 10:55:00 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125E0C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 07:52:06 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 137-20020a63058f0000b02902285c45652dso4595501pgf.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 07:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=GWwy3oOZ69y07SN8q1XZNqakIUZ5F4N1GJmVMzPtwBU=;
        b=s4NEPQdJJL5YuliIFnV+uZ+/QBjEC++tMKYMRMDKb6scPXeoaKUJ5EyYRef+UWuymL
         ImYQepakOf2WRLqK6Ukg0pTchGatKUJRDP8GgyAeXmlQSr6BNAabcZFkDp+4NnJDJ12q
         AmwHLpsLF5brM4w0eGsvqOizS4V0KDL/3QZMfNUJhHyy+/zd0qtB5R1T1ywsHo6CpY8b
         BGWUiPoIQZTtMG5KkyL1DBTXch4Rnj9Q9Z4cK7w1RnwyGD7OEmqRP7rXvFLeX2rPQlIV
         t7F4ARRtHm0NIECeG+q5HZ/xjFJf1PBOPDF0d8fTEMz+0wYARjNbqRUsYtSpYgXhRgct
         CuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=GWwy3oOZ69y07SN8q1XZNqakIUZ5F4N1GJmVMzPtwBU=;
        b=LN+j7Wu06zX2GASwVlyWitWwqgC8+fLZexVe18GaxZuEEVUoX7IvMmx4HvYWLgCoE9
         IW/MCS1/aqzMQlRjYaVAn4YMvtnbcShSIwYJoSFRTHOagXZ12ME3ZXVr3LkJtx5zK6rt
         4EBZj9x5jNWWudTDvgqqr2rs2f6AMvabP1hnBCL3Qx4m2LSwQ39X5FWDkEVvWEkHVeWv
         MeFJMfZtR1C5DwAetxgmIc1B9kUFCNAa4CuEWMEgG/CXifjNc91QCz3OSytcqd1AyN45
         4rSGdw0jakqyv6cFMirllxE0gRW59u7zdH6OWIa52uu2oU34Y3jSra0zi8JNwmxEAaVw
         5fHw==
X-Gm-Message-State: AOAM533XKOeTHYhK+hKtohem9Bro815CuRsRqKIWoPpjmrMcN12WQT0C
        u9K0+lE9esGpsv7Ck0HfTZJkd3VSRsgA
X-Google-Smtp-Source: ABdhPJzQcTGTd61GeG75V03iAzEfQAhZCWzCCqnXnVQHqR0XeBdQtFRFBq+AxAG0hfF9nxz3VSh5+fRvriU6
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:d9e1:875d:57dd:2e32])
 (user=apusaka job=sendgmr) by 2002:a62:2942:0:b029:2f4:e012:fb23 with SMTP id
 p63-20020a6229420000b02902f4e012fb23mr5033740pfp.55.1626360725484; Thu, 15
 Jul 2021 07:52:05 -0700 (PDT)
Date:   Thu, 15 Jul 2021 22:51:58 +0800
Message-Id: <20210715225146.v2.1.I68649745bd11a83265f1e816bf34ecc82775e95a@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v2 1/3] Bluetooth: hci_h5: add WAKEUP_DISABLE flag
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

Changes in v2:
* Remove unnecessary variable

 drivers/bluetooth/hci_h5.c | 83 +++++++++++++++++++++++++++-----------
 1 file changed, 59 insertions(+), 24 deletions(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 7b985c7cd26d..fd672111a048 100644
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
@@ -791,6 +801,8 @@ static int h5_serdev_probe(struct serdev_device *serdev)
 {
 	struct device *dev = &serdev->dev;
 	struct h5 *h5;
+	const struct h5_device_data *data;
+	int err;
 
 	h5 = devm_kzalloc(dev, sizeof(*h5), GFP_KERNEL);
 	if (!h5)
@@ -807,20 +819,19 @@ static int h5_serdev_probe(struct serdev_device *serdev)
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
 
 
@@ -833,7 +844,14 @@ static int h5_serdev_probe(struct serdev_device *serdev)
 	if (IS_ERR(h5->device_wake_gpio))
 		return PTR_ERR(h5->device_wake_gpio);
 
-	return hci_uart_register_device(&h5->serdev_hu, &h5p);
+	err = hci_uart_register_device(&h5->serdev_hu, &h5p);
+	if (err)
+		return err;
+
+	if (data->driver_info & H5_INFO_WAKEUP_DISABLE)
+		set_bit(H5_WAKEUP_DISABLE, &h5->flags);
+
+	return 0;
 }
 
 static void h5_serdev_remove(struct serdev_device *serdev)
@@ -921,7 +939,8 @@ static void h5_btrtl_open(struct h5 *h5)
 	 * done by the hci_suspend_notifier is not necessary; it actually causes
 	 * delays and a bunch of errors to get logged, so disable it.
 	 */
-	set_bit(HCI_UART_NO_SUSPEND_NOTIFIER, &h5->hu->flags);
+	if (test_bit(H5_WAKEUP_DISABLE, &h5->flags))
+		set_bit(HCI_UART_NO_SUSPEND_NOTIFIER, &h5->hu->flags);
 
 	/* Devices always start with these fixed parameters */
 	serdev_device_set_flow_control(h5->hu->serdev, false);
@@ -942,15 +961,18 @@ static void h5_btrtl_close(struct h5 *h5)
 
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
 
@@ -976,17 +998,21 @@ static void h5_btrtl_reprobe_worker(struct work_struct *work)
 
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
 
@@ -1008,13 +1034,22 @@ static struct h5_vnd rtl_vnd = {
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
@@ -1028,11 +1063,11 @@ static const struct dev_pm_ops h5_serdev_pm_ops = {
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

