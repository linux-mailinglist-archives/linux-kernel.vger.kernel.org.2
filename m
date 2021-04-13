Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0214135E040
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 15:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbhDMNiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 09:38:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55470 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344639AbhDMNim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 09:38:42 -0400
Received: from 111-240-117-68.dynamic-ip.hinet.net ([111.240.117.68] helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <chris.chiu@canonical.com>)
        id 1lWJFB-00083c-IW; Tue, 13 Apr 2021 13:38:18 +0000
From:   chris.chiu@canonical.com
To:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        m.v.b@runbox.com, hadess@hadess.net
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Chiu <chris.chiu@canonical.com>
Subject: [PATCH v2] USB: Don't set USB_PORT_FEAT_SUSPEND on WD19's Realtek Hub
Date:   Tue, 13 Apr 2021 21:38:08 +0800
Message-Id: <20210413133808.54287-1-chris.chiu@canonical.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Chiu <chris.chiu@canonical.com>

Realtek Hub (0bda:5487) in Dell Dock WD19 sometimes fails to work
after the system resumes from suspend with remote wakeup enabled
device connected:
[ 1947.640907] hub 5-2.3:1.0: hub_ext_port_status failed (err = -71)
[ 1947.641208] usb 5-2.3-port5: cannot disable (err = -71)
[ 1947.641401] hub 5-2.3:1.0: hub_ext_port_status failed (err = -71)
[ 1947.641450] usb 5-2.3-port4: cannot reset (err = -71)

Information of this hub:
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 10 Spd=480  MxCh= 5
D:  Ver= 2.10 Cls=09(hub  ) Sub=00 Prot=02 MxPS=64 #Cfgs=  1
P:  Vendor=0bda ProdID=5487 Rev= 1.47
S:  Manufacturer=Dell Inc.
S:  Product=Dell dock
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=01 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=256ms
I:* If#= 0 Alt= 1 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=02 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=256ms

The failure results from the ETIMEDOUT by chance when turning on
the suspend feature of the hub. The usb_resume_device will not be
invoked since the device state is not set to suspended, then the
hub fails to activate subsequently.

The USB_PORT_FEAT_SUSPEND is not really necessary due to the
"global suspend" in USB 2.0 spec. It's only for many hub devices
which don't relay wakeup requests from the devices connected to
downstream ports. For this realtek hub, there's no problem waking
up the system from connected keyboard.

This commit bypasses the USB_PORT_FEAT_SUSPEND for the quirky hub.

Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
---

Changelog:
  v2: 
    Since the 0bda:5413 is the hub device connects to upstream hub
    0bda:5487, the upstream hub which fails the USB_PORT_FEAT_SUSPEND
    is the target this patch really wants to quirk.
    - Fix the quirk target from the connected hub device to the
      upstream hub
    - Correct the usb info of the target hub in the commit message
    - Revise the description of the quirk

 Documentation/admin-guide/kernel-parameters.txt | 3 +++
 drivers/usb/core/hub.c                          | 7 +++++--
 drivers/usb/core/quirks.c                       | 5 +++++
 include/linux/usb/quirks.h                      | 3 +++
 4 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 04545725f187..1bb22a9ea5ba 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5682,6 +5682,9 @@
 					pause after every control message);
 				o = USB_QUIRK_HUB_SLOW_RESET (Hub needs extra
 					delay after resetting its port);
+				p = USB_QUIRK_NO_SET_FEAT_SUSPEND (Hub can't
+					handle set-port-feature-suspend request
+					correctly);
 			Example: quirks=0781:5580:bk,0a5c:5834:gij
 
 	usbhid.mousepoll=
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 7f71218cc1e5..36b38af46a41 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -3329,8 +3329,11 @@ int usb_port_suspend(struct usb_device *udev, pm_message_t msg)
 	 * descendants is enabled for remote wakeup.
 	 */
 	else if (PMSG_IS_AUTO(msg) || usb_wakeup_enabled_descendants(udev) > 0)
-		status = set_port_feature(hub->hdev, port1,
-				USB_PORT_FEAT_SUSPEND);
+		if (hub->hdev->quirks & USB_QUIRK_NO_SET_FEAT_SUSPEND)
+			status = 0;
+		else
+			status = set_port_feature(hub->hdev, port1,
+					USB_PORT_FEAT_SUSPEND);
 	else {
 		really_suspend = false;
 		status = 0;
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 76ac5d6555ae..9f373579bf9e 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -138,6 +138,9 @@ static int quirks_param_set(const char *value, const struct kernel_param *kp)
 			case 'o':
 				flags |= USB_QUIRK_HUB_SLOW_RESET;
 				break;
+			case 'p':
+				flags |= USB_QUIRK_NO_SET_FEAT_SUSPEND;
+				break;
 			/* Ignore unrecognized flag characters */
 			}
 		}
@@ -406,6 +409,8 @@ static const struct usb_device_id usb_quirk_list[] = {
 
 	/* Realtek hub in Dell WD19 (Type-C) */
 	{ USB_DEVICE(0x0bda, 0x0487), .driver_info = USB_QUIRK_NO_LPM },
+	{ USB_DEVICE(0x0bda, 0x5487), .driver_info =
+			USB_QUIRK_NO_SET_FEAT_SUSPEND },
 
 	/* Generic RTL8153 based ethernet adapters */
 	{ USB_DEVICE(0x0bda, 0x8153), .driver_info = USB_QUIRK_NO_LPM },
diff --git a/include/linux/usb/quirks.h b/include/linux/usb/quirks.h
index 5e4c497f54d6..ac469d446c78 100644
--- a/include/linux/usb/quirks.h
+++ b/include/linux/usb/quirks.h
@@ -72,4 +72,7 @@
 /* device has endpoints that should be ignored */
 #define USB_QUIRK_ENDPOINT_IGNORE		BIT(15)
 
+/* Hub can't handle set-port-feature-suspend request correctly */
+#define USB_QUIRK_NO_SET_FEAT_SUSPEND		BIT(16)
+
 #endif /* __LINUX_USB_QUIRKS_H */
-- 
2.20.1

