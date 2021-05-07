Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A00A3762EB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 11:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236733AbhEGJes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 05:34:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39436 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236292AbhEGJeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 05:34:44 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <chris.chiu@canonical.com>)
        id 1lewrd-0002Vw-VH; Fri, 07 May 2021 09:33:42 +0000
From:   chris.chiu@canonical.com
To:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        m.v.b@runbox.com, hadess@hadess.net
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Chiu <chris.chiu@canonical.com>
Subject: [PATCH 1/2] USB: reset-resume the device when PORT_SUSPEND is set but timeout
Date:   Fri,  7 May 2021 17:33:28 +0800
Message-Id: <20210507093329.895-2-chris.chiu@canonical.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
In-Reply-To: <20210507093329.895-1-chris.chiu@canonical.com>
References: <20210507093329.895-1-chris.chiu@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Chiu <chris.chiu@canonical.com>

On the Realtek hub of Dell Dock WD19, the port which has wakeup
enabled descendants will sometimes timeout when setting PORT_SUSPEND
feature. After checking the PORT_SUSPEND bit in wPortStatus, it is
already set. However, the hub will fail to activate because the
PORT_SUSPEND feature of that port is not cleared during resume. All
devices connecting via the port are lost after resume.

This commit force reset-resume the device connected to the timeout
but suspended port so that the hub will have chance to clear the
PORT_SUSPEND feature during resume.

Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
---
 drivers/usb/core/hub.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index b2bc4b7c4289..18603949a8de 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -3385,6 +3385,21 @@ int usb_port_suspend(struct usb_device *udev, pm_message_t msg)
 		status = 0;
 	}
 	if (status) {
+		if (status == -ETIMEDOUT) {
+			u16 portstatus, portchange;
+
+			status = hub_port_status(hub, port1, &portstatus,
+					&portchange);
+
+			dev_dbg(&port_dev->dev,
+				"suspend timeout, status %04x\n", portstatus);
+
+			if (status == 0 && port_is_suspended(hub, portstatus)) {
+				udev->reset_resume = 1;
+				goto err_wakeup;
+			}
+		}
+
 		dev_dbg(&port_dev->dev, "can't suspend, status %d\n", status);
 
 		/* Try to enable USB3 LTM again */
-- 
2.20.1

