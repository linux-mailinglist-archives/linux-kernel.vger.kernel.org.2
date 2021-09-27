Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A5E4195C4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 16:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbhI0OCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 10:02:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234718AbhI0OBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 10:01:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A452561262;
        Mon, 27 Sep 2021 13:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632751197;
        bh=vzkglIlnrsU3phpeMtmJ3uYRb1oFLlWKkXKAwzdpsEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fSPSfvsN1J+dO4MJphnWB7Ir0YsFXD4pja1GgydDSA3ALq341adDwgUL61uJVPUSj
         xhmqvfSDyvk95BWpW3w91aMvipiStuoFt9pfRqq0x39DqXeNdWOCvcxnQP0kOVyI4E
         kvDSSRg8HftvI1zi8W9uEI/N4KUlv/zD4Fw6uGWYJvFCZ6C6WfVsvv0jhlDcei3kkf
         APttyRbnTzn8eyVAVHSeXCnT2AzTA2Da69MDGAepIR+IHGg/GGs77Do6SGriyUrKfp
         FkW4ZP9kdmCtsck+dRqM4Gvh+k9A+N8jI/R8b5mbltUCVeWXWUcEdVPIkdJouHbvWd
         C6euDVJzP+u+g==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mUrAh-000AuQ-Sq; Mon, 27 Sep 2021 15:59:55 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Rajat Jain <rajatja@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 14/17] ABI: sysfs-bus-usb: add missing sysfs fields
Date:   Mon, 27 Sep 2021 15:59:47 +0200
Message-Id: <7f6f7b955032836546f78a9041b22c10b6f4bc5b.1632750608.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632750608.git.mchehab+huawei@kernel.org>
References: <cover.1632750608.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are lots of interface, power and endpoint properties that are currently
missing any documentation.

Add a description for them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH 00/17] at: https://lore.kernel.org/all/cover.1632750608.git.mchehab+huawei@kernel.org/

 Documentation/ABI/testing/sysfs-bus-usb | 274 ++++++++++++++++++++++++
 1 file changed, 274 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-usb b/Documentation/ABI/testing/sysfs-bus-usb
index 7269077ce505..2ebe5708b4bc 100644
--- a/Documentation/ABI/testing/sysfs-bus-usb
+++ b/Documentation/ABI/testing/sysfs-bus-usb
@@ -288,3 +288,277 @@ Description:
 		USB 3.2 adds Dual-lane support, 2 rx and 2 tx -lanes over Type-C.
 		Inter-Chip SSIC devices support asymmetric lanes up to 4 lanes per
 		direction. Devices before USB 3.2 are single lane (tx_lanes = 1)
+
+What:		/sys/bus/usb/devices/usbX/bAlternateSetting
+Description:
+		The current interface alternate setting number, in decimal.
+
+		See USB specs for its meaning.
+
+What:		/sys/bus/usb/devices/usbX/bcdDevice
+Description:
+		The device's release number, in hexadecimal.
+
+		See USB specs for its meaning.
+
+What:		/sys/bus/usb/devices/usbX/bConfigurationValue
+Description:
+		While a USB device typically have just one configuration
+		setting, some devices support multiple configurations.
+
+		This value shows the current configuration, in decimal.
+
+		Changing its value will change the device's configuration
+		to another setting.
+
+		The number of configurations supported by a device is at:
+
+			/sys/bus/usb/devices/usbX/bNumConfigurations
+
+		See USB specs for its meaning.
+
+What:		/sys/bus/usb/devices/usbX/bDeviceClass
+Description:
+		Class code of the device, in hexadecimal.
+
+		See USB specs for its meaning.
+
+What:		/sys/bus/usb/devices/usbX/bDeviceProtocol
+Description:
+		Protocol code of the device, in hexadecimal.
+
+		See USB specs for its meaning.
+
+What:		/sys/bus/usb/devices/usbX/bDeviceSubClass
+Description:
+		Subclass code of the device, in hexadecimal.
+
+		See USB specs for its meaning.
+
+What:		/sys/bus/usb/devices/usbX/bInterfaceClass
+Description:
+		Class code of the interface, in hexadecimal.
+
+		See USB specs for its meaning.
+
+What:		/sys/bus/usb/devices/usbX/bInterfaceNumber
+Description:
+		Interface number, in hexadecimal.
+
+		See USB specs for its meaning.
+
+What:		/sys/bus/usb/devices/usbX/bInterfaceProtocol
+Description:
+		Protocol code of the interface, in hexadecimal.
+
+		See USB specs for its meaning.
+
+What:		/sys/bus/usb/devices/usbX/bInterfaceSubClass
+Description:
+		Subclass code of the interface, in hexadecimal.
+
+		See USB specs for its meaning.
+
+What:		/sys/bus/usb/devices/usbX/bmAttributes
+Description:
+		Attributes of the current configuration, in hexadecimal.
+
+		See USB specs for its meaning.
+
+What:		/sys/bus/usb/devices/usbX/bMaxPacketSize0
+Description:
+		Maximum endpoint 0 packet size, in decimal.
+
+		See USB specs for its meaning.
+
+What:		/sys/bus/usb/devices/usbX/bMaxPower
+Description:
+		Maximum power consumption of the active configuration of
+		the device, in miliamperes.
+
+What:		/sys/bus/usb/devices/usbX/bNumConfigurations
+Description:
+		Number of the possible configurations of the device, in
+		decimal. The current configuration is controlled via:
+
+			/sys/bus/usb/devices/usbX/bConfigurationValue
+
+		See USB specs for its meaning.
+
+What:		/sys/bus/usb/devices/usbX/bNumEndpoints
+Description:
+		Number of endpoints used on this interface, in hexadecimal.
+
+		See USB specs for its meaning.
+
+What:		/sys/bus/usb/devices/usbX/bNumInterfaces
+Description:
+		Number of interfaces on this device, in decimal.
+
+What:		/sys/bus/usb/devices/usbX/busnum
+Description:
+		Number of the bus.
+
+What:		/sys/bus/usb/devices/usbX/configuration
+Description:
+		Contents of the string descriptor associated with the
+		current configuration. It may include the firmware version
+		of a device and/or its serial number.
+
+What:		/sys/bus/usb/devices/usbX/descriptors
+Description:
+		Contains the interface descriptors, in binary.
+
+What:		/sys/bus/usb/devices/usbX/idProduct
+Description:
+		Product ID, in hexadecimal.
+
+What:		/sys/bus/usb/devices/usbX/idVendor
+Description:
+		Vendor ID, in hexadecimal.
+
+What:		/sys/bus/usb/devices/usbX/devspec
+Description:
+		Displays the Device Tree Open Firmware node of the interface.
+
+What:		/sys/bus/usb/devices/usbX/avoid_reset_quirk
+Description:
+		Most devices have this set to zero.
+
+		If the value is 1, enable a USB quirk that prevents this
+		device to use reset.
+
+		(read/write)
+
+What:		/sys/bus/usb/devices/usbX/devnum
+Description:
+		USB interface device number, in decimal.
+
+What:		/sys/bus/usb/devices/usbX/devpath
+Description:
+		String containing the USB interface device path.
+
+What:		/sys/bus/usb/devices/usbX/manufacturer
+Description:
+		Vendor specific string containing the name of the
+		manufacturer of the device.
+
+What:		/sys/bus/usb/devices/usbX/maxchild
+Description:
+		Number of ports of an USB hub
+
+What:		/sys/bus/usb/devices/usbX/persist
+Description:
+		Keeps the device even if it gets disconnected.
+
+What:		/sys/bus/usb/devices/usbX/product
+Description:
+		Vendor specific string containing the name of the
+		device's product.
+
+What:		/sys/bus/usb/devices/usbX/speed
+Description:
+		Shows the device's max speed, according to the USB version,
+		in Mbps.
+		Can be:
+
+			=======		====================
+			Unknown		speed unknown
+			1.5		Low speed
+			15		Full speed
+			480		High Speed
+			5000		Super Speed
+			10000		Super Speed+
+			20000		Super Speed+ Gen 2x2
+			=======		====================
+
+What:		/sys/bus/usb/devices/usbX/supports_autosuspend
+Description:
+		Returns 1 if the device doesn't support autosuspend.
+		Otherwise, returns 0.
+
+What:		/sys/bus/usb/devices/usbX/urbnum
+Description:
+		Number of URBs submitted for the whole device.
+
+What:		/sys/bus/usb/devices/usbX/version
+Description:
+		String containing the USB device version, as encoded
+		at the BCD descriptor.
+
+What:		/sys/bus/usb/devices/usbX/power/autosuspend
+Description:
+		Time in milliseconds for the device to autosuspend. If the
+		value is negative, then autosuspend is prevented.
+
+		(read/write)
+
+What:		/sys/bus/usb/devices/usbX/power/active_duration
+Description:
+		The total time the device has not been suspended.
+
+What:		/sys/bus/usb/devices/usbX/power/connected_duration
+Description:
+		The total time (in msec) that the device has been connected.
+
+What:		/sys/bus/usb/devices/usbX/power/level
+Description:
+
+What:		/sys/bus/usb/devices/usbX/ep_<N>/bEndpointAddress
+Description:
+		The address of the endpoint described by this descriptor,
+		in hexadecimal. The endpoint direction on this bitmapped field
+		is also shown at:
+
+			/sys/bus/usb/devices/usbX/ep_<N>/direction
+
+		See USB specs for its meaning.
+
+What:		/sys/bus/usb/devices/usbX/ep_<N>/bInterval
+Description:
+		The interval of the endpoint as described on its descriptor,
+		in hexadecimal. The actual interval depends on the version
+		of the USB. Also shown in time units at
+		/sys/bus/usb/devices/usbX/ep_<N>/interval.
+
+What:		/sys/bus/usb/devices/usbX/ep_<N>/bLength
+Description:
+		Number of bytes of the endpoint descriptor, in hexadecimal.
+
+What:		/sys/bus/usb/devices/usbX/ep_<N>/bmAttributes
+Description:
+		Attributes which apply to the endpoint as described on its
+		descriptor, in hexadecimal. The endpoint type on this
+		bitmapped field is also shown at:
+
+			/sys/bus/usb/devices/usbX/ep_<N>/type
+
+		See USB specs for its meaning.
+
+What:		/sys/bus/usb/devices/usbX/ep_<N>/direction
+Description:
+		Direction of the endpoint. Can be:
+
+		    - both (on control endpoints)
+		    - in
+		    - out
+
+What:		/sys/bus/usb/devices/usbX/ep_<N>/interval
+Description:
+		Interval for polling endpoint for data transfers, in
+		milisseconds or microseconds.
+
+What:		/sys/bus/usb/devices/usbX/ep_<N>/type
+Description:
+		Descriptor type. Can be:
+
+		    - Control
+		    - Isoc
+		    - Bulk
+		    - Interrupt
+		    - unknown
+
+What:		/sys/bus/usb/devices/usbX/ep_<N>/wMaxPacketSize
+Description:
+		Maximum packet size this endpoint is capable of
+		sending or receiving, in hexadecimal.
-- 
2.31.1

