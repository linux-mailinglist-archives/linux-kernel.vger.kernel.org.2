Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0132E380322
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 06:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbhENEzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 00:55:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55928 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbhENEza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 00:55:30 -0400
Received: from 111-240-128-202.dynamic-ip.hinet.net ([111.240.128.202] helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <chris.chiu@canonical.com>)
        id 1lhPq5-00073z-5J; Fri, 14 May 2021 04:54:17 +0000
From:   chris.chiu@canonical.com
To:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        m.v.b@runbox.com, hadess@hadess.net
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Chiu <chris.chiu@canonical.com>
Subject: [PATCH v4 1/2] USB: Verify the port status when timeout happens during port suspend
Date:   Fri, 14 May 2021 12:54:04 +0800
Message-Id: <20210514045405.5261-2-chris.chiu@canonical.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
In-Reply-To: <20210514045405.5261-1-chris.chiu@canonical.com>
References: <20210514045405.5261-1-chris.chiu@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Chiu <chris.chiu@canonical.com>

On the Realtek high-speed Hub(0bda:5487), the port which has wakeup
enabled_descendants will sometimes timeout when setting PORT_SUSPEND
feature. After checking the PORT_SUSPEND bit in wPortStatus, it is
already set which means the port has been suspended. We should treat
it suspended to make sure it will be resumed correctly.

Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
---

Changelog:
  v4:
    - add comment for the timeout handling
    - intialize the portstatus and portchange
    - revise the commit message to reflect the change
  v3:
    - create a new goto target for the timeout case instead of
      reset_resume
    - Revise the commit title/message because reset_resume is not
      required.
  v2:
    - create a new variable to keep the result of hub_port_status
      when suspend timeout.

 drivers/usb/core/hub.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index b2bc4b7c4289..e739f7b5991a 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -3385,6 +3385,26 @@ int usb_port_suspend(struct usb_device *udev, pm_message_t msg)
 		status = 0;
 	}
 	if (status) {
+		/* Check if the port has been suspended for the timeout case
+		 * to prevent the suspended port from incorrect handling.
+		 */
+		if (status == -ETIMEDOUT) {
+			int ret;
+			u16 portstatus, portchange;
+
+			portstatus = portchange = 0;
+			ret = hub_port_status(hub, port1, &portstatus,
+					&portchange);
+
+			dev_dbg(&port_dev->dev,
+				"suspend timeout, status %04x\n", portstatus);
+
+			if (ret == 0 && port_is_suspended(hub, portstatus)) {
+				status = 0;
+				goto suspend_done;
+			}
+		}
+
 		dev_dbg(&port_dev->dev, "can't suspend, status %d\n", status);
 
 		/* Try to enable USB3 LTM again */
@@ -3401,6 +3421,7 @@ int usb_port_suspend(struct usb_device *udev, pm_message_t msg)
 		if (!PMSG_IS_AUTO(msg))
 			status = 0;
 	} else {
+ suspend_done:
 		dev_dbg(&udev->dev, "usb %ssuspend, wakeup %d\n",
 				(PMSG_IS_AUTO(msg) ? "auto-" : ""),
 				udev->do_remote_wakeup);
-- 
2.20.1

