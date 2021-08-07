Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF733E3609
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 17:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbhHGPMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 11:12:33 -0400
Received: from out28-73.mail.aliyun.com ([115.124.28.73]:40177 "EHLO
        out28-73.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbhHGPMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 11:12:31 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04446334|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.00458908-0.000204986-0.995206;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047202;MF=zhangzhengjun@aicrobo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.KwhFi0s_1628349131;
Received: from localhost(mailfrom:zhangzhengjun@aicrobo.com fp:SMTPD_---.KwhFi0s_1628349131)
          by smtp.aliyun-inc.com(10.147.42.241);
          Sat, 07 Aug 2021 23:12:12 +0800
From:   Zhengjun Zhang <zhangzhengjun@aicrobo.com>
To:     johan@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org,
        Zhengjun Zhang <zhangzhengjun@aicrobo.com>
Subject: [PATCH] Add new VID/PID to support Fibocom FG150 5G module
Date:   Sat,  7 Aug 2021 23:11:44 +0800
Message-Id: <20210807151144.11227-1-zhangzhengjun@aicrobo.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fibocom FG150 is a 5G module based on Qualcomm SDX55 platform,
support Sub-6G band.

Here is usb-devices and lsusb -v output of this device:

> T:  Bus=02 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=5000 MxCh= 0
> D:  Ver= 3.20 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 9 #Cfgs=  1
> P:  Vendor=2cb7 ProdID=010b Rev=04.14
> S:  Manufacturer=Fibocom
> S:  Product=Fibocom Modem_SN:XXXXXXXX
> S:  SerialNumber=XXXXXXXX
> C:  #Ifs= 5 Cfg#= 1 Atr=a0 MxPwr=896mA
> I:  If#=0x0 Alt= 0 #EPs= 1 Cls=ef(misc ) Sub=04 Prot=01 Driver=rndis_host
> I:  If#=0x1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=rndis_host
> I:  If#=0x2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
> I:  If#=0x3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=(none)
> I:  If#=0x4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)


> Bus 002 Device 002: ID 2cb7:010b Fibocom Fibocom Modem_SN:XXXXXXXX
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               3.20
>   bDeviceClass            0 
>   bDeviceSubClass         0 
>   bDeviceProtocol         0 
>   bMaxPacketSize0         9
>   idVendor           0x2cb7 Fibocom
>   idProduct          0x010b 
>   bcdDevice            4.14
>   iManufacturer           1 Fibocom
>   iProduct                2 Fibocom Modem_SN:XXXXXXXX
>   iSerial                 3 XXXXXXXX
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength       0x00e6
>     bNumInterfaces          5
>     bConfigurationValue     1
>     iConfiguration          4 RNDIS_DUN_DIAG_ADB
>     bmAttributes         0xa0
>       (Bus Powered)
>       Remote Wakeup
>     MaxPower              896mA
>     Interface Association:
>       bLength                 8
>       bDescriptorType        11
>       bFirstInterface         0
>       bInterfaceCount         2
>       bFunctionClass        239 Miscellaneous Device
>       bFunctionSubClass       4
>       bFunctionProtocol       1
>       iFunction               7 RNDIS
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           1
>       bInterfaceClass       239 Miscellaneous Device
>       bInterfaceSubClass      4
>       bInterfaceProtocol      1
>       iInterface              0
>       ** UNRECOGNIZED:  05 24 00 10 01
>       ** UNRECOGNIZED:  05 24 01 00 01
>       ** UNRECOGNIZED:  04 24 02 00
>       ** UNRECOGNIZED:  05 24 06 00 01
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x81  EP 1 IN
>         bmAttributes            3
>           Transfer Type            Interrupt
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0008  1x 8 bytes
>         bInterval               9
>         bMaxBurst               0
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       0
>       bNumEndpoints           2
>       bInterfaceClass        10 CDC Data
>       bInterfaceSubClass      0
>       bInterfaceProtocol      0
>       iInterface              0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x8e  EP 14 IN
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0400  1x 1024 bytes
>         bInterval               0
>         bMaxBurst               6
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x0f  EP 15 OUT
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0400  1x 1024 bytes
>         bInterval               0
>         bMaxBurst               6
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        2
>       bAlternateSetting       0
>       bNumEndpoints           3
>       bInterfaceClass       255 Vendor Specific Class
>       bInterfaceSubClass      0
>       bInterfaceProtocol      0
>       iInterface              0
>       ** UNRECOGNIZED:  05 24 00 10 01
>       ** UNRECOGNIZED:  05 24 01 00 00
>       ** UNRECOGNIZED:  04 24 02 02
>       ** UNRECOGNIZED:  05 24 06 00 00
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x83  EP 3 IN
>         bmAttributes            3
>           Transfer Type            Interrupt
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x000a  1x 10 bytes
>         bInterval               9
>         bMaxBurst               0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x82  EP 2 IN
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0400  1x 1024 bytes
>         bInterval               0
>         bMaxBurst               0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x01  EP 1 OUT
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0400  1x 1024 bytes
>         bInterval               0
>         bMaxBurst               0
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        3
>       bAlternateSetting       0
>       bNumEndpoints           2
>       bInterfaceClass       255 Vendor Specific Class
>       bInterfaceSubClass    255 Vendor Specific Subclass
>       bInterfaceProtocol     48
>       iInterface              0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x84  EP 4 IN
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0400  1x 1024 bytes
>         bInterval               0
>         bMaxBurst               0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x02  EP 2 OUT
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0400  1x 1024 bytes
>         bInterval               0
>         bMaxBurst               0
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        4
>       bAlternateSetting       0
>       bNumEndpoints           2
>       bInterfaceClass       255 Vendor Specific Class
>       bInterfaceSubClass     66
>       bInterfaceProtocol      1
>       iInterface              0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x03  EP 3 OUT
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0400  1x 1024 bytes
>         bInterval               0
>         bMaxBurst               0
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x85  EP 5 IN
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0400  1x 1024 bytes
>         bInterval               0
>         bMaxBurst               0
> Binary Object Store Descriptor:
>   bLength                 5
>   bDescriptorType        15
>   wTotalLength       0x0016
>   bNumDeviceCaps          2
>   USB 2.0 Extension Device Capability:
>     bLength                 7
>     bDescriptorType        16
>     bDevCapabilityType      2
>     bmAttributes   0x00000006
>       BESL Link Power Management (LPM) Supported
>   SuperSpeed USB Device Capability:
>     bLength                10
>     bDescriptorType        16
>     bDevCapabilityType      3
>     bmAttributes         0x00
>     wSpeedsSupported   0x000f
>       Device can operate at Low Speed (1Mbps)
>       Device can operate at Full Speed (12Mbps)
>       Device can operate at High Speed (480Mbps)
>       Device can operate at SuperSpeed (5Gbps)
>     bFunctionalitySupport   1
>       Lowest fully-functional device speed is Full Speed (12Mbps)
>     bU1DevExitLat           1 micro seconds
>     bU2DevExitLat         500 micro seconds
> Device Status:     0x0000
>   (Bus Powered)

It looks like this patch:
accf227de4d2 ("USB: serial: option: Add support for Quectel RM500Q"),
so I copied that patch and replaced VID/PID with FG150, rebuild kernel, 
and it works well.

PS:
In Fibocom's Windows driver, they hardcoded USB interface, which
looks like:

> I:  If#=0x0 --> Remote NDIS Compatible Device
> I:  If#=0x1 
> I:  If#=0x2 --> Fibocom USB Modem // Modem 
> I:  If#=0x3 --> Fibocom USB Diagnostics (COMx)
> I:  If#=0x4 --> Fibocom Modem_SN:XXXXXXXX //WinUSB, ADB

Signed-off-by: Zhengjun Zhang <zhangzhengjun@aicrobo.com>
---
 drivers/usb/serial/option.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 0fbe253dc..0e964cb13 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -563,6 +563,9 @@ static void option_instat_callback(struct urb *urb);
 #define WETELECOM_PRODUCT_6802			0x6802
 #define WETELECOM_PRODUCT_WMD300		0x6803
 
+/* Fibocom products */
+#define FIBOCOM_VENDOR_ID			0x2cb7
+#define FIBOCOM_PRODUCT_FG150			0x010b
 
 /* Device flags */
 
@@ -2077,6 +2080,8 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1404, 0xff) },			/* GosunCn GM500 RNDIS */
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1405, 0xff) },			/* GosunCn GM500 MBIM */
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1406, 0xff) },			/* GosunCn GM500 ECM/NCM */
+	{ USB_DEVICE_AND_INTERFACE_INFO(FIBOCOM_VENDOR_ID, FIBOCOM_PRODUCT_FG150, 0xff, 0xff, 0x30) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(FIBOCOM_VENDOR_ID, FIBOCOM_PRODUCT_FG150, 0xff, 0, 0) },
 	{ } /* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, option_ids);
-- 
2.32.0

