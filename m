Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911F943D20D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 22:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243775AbhJ0UFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 16:05:38 -0400
Received: from mail-qt1-f171.google.com ([209.85.160.171]:46939 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbhJ0UFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 16:05:37 -0400
Received: by mail-qt1-f171.google.com with SMTP id s1so2261161qta.13;
        Wed, 27 Oct 2021 13:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/SWvUdWh7RB6nbUdLFqXl01g3YGeIacnxrMCZVf1wSk=;
        b=DM5e14cJFfe4S5iVykSY2crn1Hq/Tfkj8I+Mx7qsoMURNQYMNRqaCtmHd3bbSON2Xy
         smEu0YpReeN7M9IZK+8mzWHT0Ke+aKohOCrkqNqnl02ew93L2Zs2wbbm4LxGxBcckKRa
         9t3e1nZwq1z1IcXJdEylmN15MN+gMKM00jmG9gXRzk85YDw480yFevSlF/CSIxgHa7Fn
         WopPZhlXNo2De4TB+JFaC5zV+qYAEpO8513KurnNgSOcKhE3UvxtShrtyhtBHyPfvDhx
         Zc+l2AJGMBejhz8T4svsI/LF3tEEG6Vhw+ww21dPns+N9lyxHs5xSZ5pJHna3w+RGq+i
         OcDQ==
X-Gm-Message-State: AOAM532FxZN9L+oEaVLdBr9QoaO4xycKtlhYTp+NVcsbPeatnR0zMvc9
        i/6ki6eWClnyFVmt16dwepw=
X-Google-Smtp-Source: ABdhPJxGl9mc+4PqRC619Jvlz0sLBMnd3PTIaiwhtiXp8zS/c0mq5LBMH8L1aHbMOApHVxyi24vr8w==
X-Received: by 2002:ac8:58d6:: with SMTP id u22mr33720707qta.7.1635364991315;
        Wed, 27 Oct 2021 13:03:11 -0700 (PDT)
Received: from mfe-desktop.dimonoffinc.intra (ipagstaticip-ad9375f2-382c-b511-8ac1-9541f69fe50f.sdsl.bell.ca. [142.116.33.166])
        by smtp.googlemail.com with ESMTPSA id f3sm638540qko.32.2021.10.27.13.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 13:03:10 -0700 (PDT)
From:   ferlandm@amotus.ca
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marc Ferland <ferlandm@amotus.ca>
Subject: [PATCH] USB: serial: simple: add sierra wireless xm1210 gnss receiver
Date:   Wed, 27 Oct 2021 16:02:23 -0400
Message-Id: <20211027200223.72701-1-ferlandm@amotus.ca>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Ferland <ferlandm@amotus.ca>

Add device id for the Sierra Wireless XM1210 Multi-GNSS module.

https://www.sierrawireless.com/iot-solutions/products/xm1210/

$ lsusb -vd 1199:b000

Bus 002 Device 003: ID 1199:b000 Sierra Wireless, Inc. Sierra Wireless_GNSS
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.00
  bDeviceClass            0
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x1199 Sierra Wireless, Inc.
  idProduct          0xb000
  bcdDevice            0.01
  iManufacturer           1 Sierra-wireless
  iProduct                2 Sierra Wireless_GNSS
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x0020
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xc0
      Self Powered
    MaxPower               50mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass         0
      bInterfaceSubClass      0
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval             255
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval             255
can't get debug descriptor: Resource temporarily unavailable
Device Status:     0x0001
  Self Powered

Device is also working correctly with:

$ echo 0x1199 0xb000 > /sys/bus/usb-serial/drivers/generic/new_id

Signed-off-by: Marc Ferland <ferlandm@amotus.ca>
---
 drivers/usb/serial/Kconfig             | 1 +
 drivers/usb/serial/usb-serial-simple.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/usb/serial/Kconfig b/drivers/usb/serial/Kconfig
index de5c01257060..8008c8cbaaa0 100644
--- a/drivers/usb/serial/Kconfig
+++ b/drivers/usb/serial/Kconfig
@@ -68,6 +68,7 @@ config USB_SERIAL_SIMPLE
 		- Motorola Tetra devices
 		- Novatel Wireless GPS receivers
 		- Siemens USB/MPI adapter.
+		- Sierra Wireless GPS receiver.
 		- ViVOtech ViVOpay USB device.
 		- Infineon Modem Flashloader USB interface
 		- ZIO Motherboard USB serial interface
diff --git a/drivers/usb/serial/usb-serial-simple.c b/drivers/usb/serial/usb-serial-simple.c
index bd23a7cb1be2..9ffd24c7fb33 100644
--- a/drivers/usb/serial/usb-serial-simple.c
+++ b/drivers/usb/serial/usb-serial-simple.c
@@ -112,6 +112,11 @@ DEVICE(suunto, SUUNTO_IDS);
 	{ USB_DEVICE(0x908, 0x0004) }
 DEVICE(siemens_mpi, SIEMENS_IDS);
 
+/* Sierra Wireless_GNSS driver */
+#define SIERRA_IDS()		\
+	{ USB_DEVICE(0x1199, 0xb000) }
+DEVICE(sierra, SIERRA_IDS);
+
 /* All of the above structures mushed into two lists */
 static struct usb_serial_driver * const serial_drivers[] = {
 	&carelink_device,
@@ -127,6 +132,7 @@ static struct usb_serial_driver * const serial_drivers[] = {
 	&hp4x_device,
 	&suunto_device,
 	&siemens_mpi_device,
+	&sierra_device,
 	NULL
 };
 
@@ -144,6 +150,7 @@ static const struct usb_device_id id_table[] = {
 	HP4X_IDS(),
 	SUUNTO_IDS(),
 	SIEMENS_IDS(),
+	SIERRA_IDS(),
 	{ },
 };
 MODULE_DEVICE_TABLE(usb, id_table);
-- 
2.30.2

