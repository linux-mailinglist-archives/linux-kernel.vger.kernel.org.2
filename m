Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42EA6456C53
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 10:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbhKSJa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 04:30:26 -0500
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:58288
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234371AbhKSJaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 04:30:24 -0500
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 501193F1A4;
        Fri, 19 Nov 2021 09:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637314041;
        bh=xJ4iKt/4xnrMC9w7jpo6aWtfOyahyXvd5hutdfLyHJU=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=Lv7L8nBa3lv1E8sit7vmiheEP3wIzKbS+Kbc69g5y8Bp0RC77qIk3/1jDo+hCtAxo
         I/5kO3hzjEU6Fo11dY1Ynjx62GC4uudXeFfEnA4g4nLfRRA9BThnrT7aH+9fLesSW5
         9clj6WKXyXqvWXbK13LPSI85QtfKInNiCrkaKU9HCAiWAj47yDus82OIT9wRRS3OAM
         2Nj2mhVNHJ7E+EhlYVz944G0ADgpRA0ND5aE15sY7Nxp5QiDeYh29vBgMMLjNVOW9Z
         gh2zYlwiiNJNWCG5ea+0ELWWQlY8dM87UFDwyiKxHHNlZdmHYbFZFgJPm+uFqdT1Ci
         rN7qLIrAVIjog==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     mathias.nyman@intel.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org (open list:USB XHCI DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] xhci: Remove CONFIG_USB_DEFAULT_PERSIST to prevent xHCI from runtime suspending
Date:   Fri, 19 Nov 2021 17:26:28 +0800
Message-Id: <20211119092628.677935-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the xHCI is quirked with XHCI_RESET_ON_RESUME, runtime resume
routine also resets the controller.

This is bad for USB drivers without reset_resume callback, because
there's no subsequent call of usb_dev_complete() ->
usb_resume_complete() to force rebinding the driver to the device. For
instance, btusb device stops working after xHCI controller is runtime
resumed, if the controlled is quirked with XHCI_RESET_ON_RESUME.

So always take XHCI_RESET_ON_RESUME into account to solve the issue.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/usb/host/xhci.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 902f410874e8e..af92a9f8ed670 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -3934,7 +3934,6 @@ static void xhci_free_dev(struct usb_hcd *hcd, struct usb_device *udev)
 	struct xhci_slot_ctx *slot_ctx;
 	int i, ret;
 
-#ifndef CONFIG_USB_DEFAULT_PERSIST
 	/*
 	 * We called pm_runtime_get_noresume when the device was attached.
 	 * Decrement the counter here to allow controller to runtime suspend
@@ -3942,7 +3941,6 @@ static void xhci_free_dev(struct usb_hcd *hcd, struct usb_device *udev)
 	 */
 	if (xhci->quirks & XHCI_RESET_ON_RESUME)
 		pm_runtime_put_noidle(hcd->self.controller);
-#endif
 
 	ret = xhci_check_args(hcd, udev, NULL, 0, true, __func__);
 	/* If the host is halted due to driver unload, we still need to free the
@@ -4094,14 +4092,12 @@ int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_device *udev)
 
 	xhci_debugfs_create_slot(xhci, slot_id);
 
-#ifndef CONFIG_USB_DEFAULT_PERSIST
 	/*
 	 * If resetting upon resume, we can't put the controller into runtime
 	 * suspend if there is a device attached.
 	 */
 	if (xhci->quirks & XHCI_RESET_ON_RESUME)
 		pm_runtime_get_noresume(hcd->self.controller);
-#endif
 
 	/* Is this a LS or FS device under a HS hub? */
 	/* Hub or peripherial? */
-- 
2.32.0

