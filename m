Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2781313585
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 15:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbhBHOrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 09:47:10 -0500
Received: from antares.kleine-koenig.org ([94.130.110.236]:37346 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbhBHOcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 09:32:39 -0500
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id A686AAF3D8F; Mon,  8 Feb 2021 15:31:56 +0100 (CET)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] USB: serial: Drop if with an always false condition
Date:   Mon,  8 Feb 2021 15:31:48 +0100
Message-Id: <20210208143149.963644-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a bus remove function the passed device is always valid, so there is
no need to check for it being NULL.

(Side note: The check for port being non-NULL is broken anyhow, because
to_usb_serial_port() is a wrapper around container_of() for a member that is
not the first one. So port can hardly become NULL.)

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 drivers/usb/serial/bus.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/usb/serial/bus.c b/drivers/usb/serial/bus.c
index eb0195cf37dd..d862ed656414 100644
--- a/drivers/usb/serial/bus.c
+++ b/drivers/usb/serial/bus.c
@@ -87,15 +87,11 @@ static int usb_serial_device_probe(struct device *dev)
 static int usb_serial_device_remove(struct device *dev)
 {
 	struct usb_serial_driver *driver;
-	struct usb_serial_port *port;
+	struct usb_serial_port *port = to_usb_serial_port(dev);
 	int retval = 0;
 	int minor;
 	int autopm_err;
 
-	port = to_usb_serial_port(dev);
-	if (!port)
-		return -ENODEV;
-
 	/*
 	 * Make sure suspend/resume doesn't race against port_remove.
 	 *

base-commit: 5c8fe583cce542aa0b84adc939ce85293de36e5e
-- 
2.29.2

