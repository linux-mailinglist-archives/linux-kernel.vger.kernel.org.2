Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A88703E46C2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 15:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbhHINga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 09:36:30 -0400
Received: from out28-149.mail.aliyun.com ([115.124.28.149]:33335 "EHLO
        out28-149.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhHINg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 09:36:29 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04440762|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0255528-0.000321112-0.974126;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047207;MF=zhangzhengjun@aicrobo.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.KxW4EHK_1628516166;
Received: from localhost(mailfrom:zhangzhengjun@aicrobo.com fp:SMTPD_---.KxW4EHK_1628516166)
          by smtp.aliyun-inc.com(10.147.40.200);
          Mon, 09 Aug 2021 21:36:07 +0800
From:   Zhengjun Zhang <zhangzhengjun@aicrobo.com>
To:     larsm17@gmail.com, johan@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org,
        Zhengjun Zhang <zhangzhengjun@aicrobo.com>
Subject: [PATCH v2] USB: serial: option: add new VID/PID to support Fibocom FG150
Date:   Mon,  9 Aug 2021 21:35:53 +0800
Message-Id: <20210809133553.71158-1-zhangzhengjun@aicrobo.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <b3285ae0-8b1f-fc9c-3662-634264d704d5@gmail.com>
References: <b3285ae0-8b1f-fc9c-3662-634264d704d5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fibocom FG150 is a 5G module based on Qualcomm SDX55 platform,
support Sub-6G band.

Compared with the first patch, I removed the defines of Fibocom 
VID and PID by following Lars' suggestion.

Here are the outputs of lsusb -v and usb-devices:

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

Signed-off-by: Zhengjun Zhang <zhangzhengjun@aicrobo.com>
---
V1 -> V2: Remove the defines of Fibocom VID and PID

 drivers/usb/serial/option.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 0fbe253dc..4fcf859e9 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2073,6 +2073,8 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0105, 0xff),			/* Fibocom NL678 series */
 	  .driver_info = RSVD(6) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a0, 0xff) },			/* Fibocom NL668-AM/NL652-EU (laptop MBIM) */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x010b, 0xff, 0xff, 0x30) },	/* Fibocom FG150 Diag */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x010b, 0xff, 0, 0) },	/* Fibocom FG150 AT */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2df3, 0x9d03, 0xff) },			/* LongSung M5710 */
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1404, 0xff) },			/* GosunCn GM500 RNDIS */
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1405, 0xff) },			/* GosunCn GM500 MBIM */
-- 
2.32.0

