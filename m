Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D756B35C6FC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 15:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241656AbhDLNGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 09:06:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41313 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239263AbhDLNF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 09:05:59 -0400
Received: from 1-171-231-81.dynamic-ip.hinet.net ([1.171.231.81] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lVwFp-0001is-Pd; Mon, 12 Apr 2021 13:05:26 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     gregkh@linuxfoundation.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        penghao <penghao@uniontech.com>,
        Oliver Neukum <oneukum@suse.com>,
        Johan Hovold <johan@kernel.org>,
        Jonathan Cox <jonathan@jdcox.net>,
        Kars Mulder <kerneldev@karsmulder.nl>,
        =?UTF-8?q?Tomasz=20Meresi=C5=84ski?= <tomasz@meresinski.eu>,
        linux-usb@vger.kernel.org (open list:USB SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] USB: Add LPM quirk for Lenovo ThinkPad USB-C Dock Gen2 Ethernet
Date:   Mon, 12 Apr 2021 21:05:20 +0800
Message-Id: <20210412130521.782373-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is another branded 8153 device that doesn't work well with LPM
enabled:
[ 400.597506] r8152 5-1.1:1.0 enx482ae3a2a6f0: Tx status -71

So disable LPM to resolve the issue.

BugLink: https://bugs.launchpad.net/bugs/1922651
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
 - Put the quirk in the right order.

 drivers/usb/core/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 76ac5d6555ae..dfedb51cf832 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -434,6 +434,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x1532, 0x0116), .driver_info =
 			USB_QUIRK_LINEAR_UFRAME_INTR_BINTERVAL },
 
+	/* Lenovo ThinkPad USB-C Dock Gen2 Ethernet (RTL8153 GigE) */
+	{ USB_DEVICE(0x17ef, 0xa387), .driver_info = USB_QUIRK_NO_LPM },
+
 	/* Lenovo ThinkCenter A630Z TI024Gen3 usb-audio */
 	{ USB_DEVICE(0x17ef, 0xa012), .driver_info =
 			USB_QUIRK_DISCONNECT_SUSPEND },
-- 
2.30.2

