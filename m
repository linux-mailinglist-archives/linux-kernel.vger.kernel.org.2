Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 108EB40B243
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbhINO5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:57:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234454AbhINO4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:56:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 970A661164;
        Tue, 14 Sep 2021 14:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631631328;
        bh=laUcrWNgh4sG9e8n2SaYowFQBM6aMmNMsCLr0FPYj3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KEBKJieVDosQ9sJ4TKYF8/YwlKu8dW7KOEwnlp2uneZbregU8bpAc47xMlFd890se
         4XV0rJvjsqbSF+Be0p7kb+5dFKpTK1b7ZXyxO3E3Uyw8l9FoTP1fj7YInt8jGV4wN5
         6JZSswTFxFrpGCT1zGZ9BHnYjhO083/+wBtB9NBtzTmKFQe+hjq3A5TyV+5TxKF3oH
         bmnSvYUcCFyYQhWIdgKLKrC8TIsa9NjiUfzSJyTpUBXIHVp/6TDSgWq3zWatsus4jY
         Cjb49aLIS0+3qdfHVFPLoJ3F9t6VMRWWvlVjMnqoUssc03butRGBP1QX5sfokVBRoE
         xjphNK1zY7zKQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQ9qI-000L7D-U6; Tue, 14 Sep 2021 16:55:26 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Rajat Jain <rajatja@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/8] ABI: sysfs-bus-usb: add some missing definitions
Date:   Tue, 14 Sep 2021 16:55:21 +0200
Message-Id: <cecbb8be48a83da0cfb97b5ac328ebd9904ed5d6.1631630792.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631630792.git.mchehab+huawei@kernel.org>
References: <cover.1631630792.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are lots of interface and endpoint properties that
are currently missing any documentation. Add a basic one
for them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/testing/sysfs-bus-usb | 43 +++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-usb b/Documentation/ABI/testing/sysfs-bus-usb
index 42103f0f54d6..197698ad22af 100644
--- a/Documentation/ABI/testing/sysfs-bus-usb
+++ b/Documentation/ABI/testing/sysfs-bus-usb
@@ -1,4 +1,4 @@
-What:		/sys/bus/usb/devices/INTERFACE/authorized
+What:		/sys/bus/usb/devices/<INTERFACE>/authorized
 Date:		August 2015
 Description:
 		This allows to authorize (1) or deauthorize (0)
@@ -12,7 +12,46 @@ Description:
 
 		A deauthorized interface cannot be probed or claimed.
 
-What:		/sys/bus/usb/devices/usbX/interface_authorized_default
+What:		/sys/bus/usb/devices/<INTERFACE>/bAlternateSetting
+What:		/sys/bus/usb/devices/<INTERFACE>/bcdDevice
+What:		/sys/bus/usb/devices/<INTERFACE>/bConfigurationValue
+What:		/sys/bus/usb/devices/<INTERFACE>/bDeviceClass
+What:		/sys/bus/usb/devices/<INTERFACE>/bDeviceProtocol
+What:		/sys/bus/usb/devices/<INTERFACE>/bDeviceSubClass
+What:		/sys/bus/usb/devices/<INTERFACE>/bAlternateSetting
+What:		/sys/bus/usb/devices/<INTERFACE>/bInterfaceClass
+What:		/sys/bus/usb/devices/<INTERFACE>/bInterfaceNumber
+What:		/sys/bus/usb/devices/<INTERFACE>/bInterfaceProtocol
+What:		/sys/bus/usb/devices/<INTERFACE>/bInterfaceSubClass
+What:		/sys/bus/usb/devices/<INTERFACE>/bmAttributes
+What:		/sys/bus/usb/devices/<INTERFACE>/bMaxPacketSize0
+What:		/sys/bus/usb/devices/<INTERFACE>/bMaxPower
+What:		/sys/bus/usb/devices/<INTERFACE>/bNumConfigurations
+What:		/sys/bus/usb/devices/<INTERFACE>/bNumEndpoints
+What:		/sys/bus/usb/devices/<INTERFACE>/bNumInterfaces
+What:		/sys/bus/usb/devices/<INTERFACE>/busnum
+What:		/sys/bus/usb/devices/<INTERFACE>/configuration
+What:		/sys/bus/usb/devices/<INTERFACE>/descriptors
+What:		/sys/bus/usb/devices/<INTERFACE>/bNumEndpoints
+What:		/sys/bus/usb/devices/<INTERFACE>/idProduct
+What:		/sys/bus/usb/devices/<INTERFACE>/idVendor
+
+Description:
+		Contain the corresponding USB descriptors for <INTERFACE>.
+
+What:		/sys/bus/usb/devices/<INTERFACE>/ep_<N>/bEndpointAddress
+What:		/sys/bus/usb/devices/<INTERFACE>/ep_<N>/bInterval
+What:		/sys/bus/usb/devices/<INTERFACE>/ep_<N>/bLength
+What:		/sys/bus/usb/devices/<INTERFACE>/ep_<N>/bmAttributes
+What:		/sys/bus/usb/devices/<INTERFACE>/ep_<N>/direction
+What:		/sys/bus/usb/devices/<INTERFACE>/ep_<N>/interval
+What:		/sys/bus/usb/devices/<INTERFACE>/ep_<N>/type
+What:		/sys/bus/usb/devices/<INTERFACE>/ep_<N>/wMaxPacketSize
+Description:
+		Contain the corresponding USB descriptors for the USB
+		endpoint ep_<N>.
+
+What:		/sys/bus/usb/devices/usb<X>/interface_authorized_default
 Date:		August 2015
 Description:
 		This is used as value that determines if interfaces
-- 
2.31.1

