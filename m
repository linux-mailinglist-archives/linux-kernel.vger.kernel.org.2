Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68CB34EA89
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbhC3OiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:38:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:50564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232048AbhC3OiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:38:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E30FF619D2;
        Tue, 30 Mar 2021 14:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617115086;
        bh=GN8fY8Jum7Dt0SbQa2ViCGAY7wabDr5buqA9U8aqLNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BWLhWEv7xjQpeJn+cGpEFUYGvZ1q3efXCaafTZoDjT7fu87JxTpncXY22W9xGdY1t
         f+j+FjFcq3t4AdM9Kh1eXm5udAKfZ2Rmx8wOQ9eKfaYJmAj7mTKfT1ILLVHeOafyDK
         lLLTXjEnKy5a7Eah0PZJndYVJEXORdmjDpV57m17KFjEBWo+SE4spySElt6WwHhp5s
         TUYTfJOFozrVjd+Gdg7c2+qtJG03S47Av2VZHTl9SzLQiZpZLeEp6yR8wLgwFvcgAU
         I/2RTZHl76qeZ5bdvsC+953XqeWzCLMVY9ijAuSX8ZvXktxuoM4DuLFo/Qkyy8MSD7
         jWRns1EdP3a4g==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lRFVj-0002Nk-Bm; Tue, 30 Mar 2021 16:38:27 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] USB: serial: drop unused suspending flag
Date:   Tue, 30 Mar 2021 16:38:17 +0200
Message-Id: <20210330143820.9103-2-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210330143820.9103-1-johan@kernel.org>
References: <20210330143820.9103-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The suspending flag was added back in 2009 but no users ever followed.
Remove it.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/usb-serial.c | 8 +-------
 include/linux/usb/serial.h      | 1 -
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index 27e3bb58c872..2a38810a3979 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -1114,8 +1114,6 @@ int usb_serial_suspend(struct usb_interface *intf, pm_message_t message)
 	struct usb_serial *serial = usb_get_intfdata(intf);
 	int i, r = 0;
 
-	serial->suspending = 1;
-
 	/*
 	 * serial->type->suspend() MUST return 0 in system sleep context,
 	 * otherwise, the resume callback has to recover device from
@@ -1123,10 +1121,8 @@ int usb_serial_suspend(struct usb_interface *intf, pm_message_t message)
 	 */
 	if (serial->type->suspend) {
 		r = serial->type->suspend(serial, message);
-		if (r < 0) {
-			serial->suspending = 0;
+		if (r < 0)
 			goto err_out;
-		}
 	}
 
 	for (i = 0; i < serial->num_ports; ++i)
@@ -1151,7 +1147,6 @@ int usb_serial_resume(struct usb_interface *intf)
 
 	usb_serial_unpoison_port_urbs(serial);
 
-	serial->suspending = 0;
 	if (serial->type->resume)
 		rv = serial->type->resume(serial);
 	else
@@ -1168,7 +1163,6 @@ static int usb_serial_reset_resume(struct usb_interface *intf)
 
 	usb_serial_unpoison_port_urbs(serial);
 
-	serial->suspending = 0;
 	if (serial->type->reset_resume) {
 		rv = serial->type->reset_resume(serial);
 	} else {
diff --git a/include/linux/usb/serial.h b/include/linux/usb/serial.h
index 952272002e48..7efba6caaadc 100644
--- a/include/linux/usb/serial.h
+++ b/include/linux/usb/serial.h
@@ -146,7 +146,6 @@ struct usb_serial {
 	struct usb_serial_driver	*type;
 	struct usb_interface		*interface;
 	unsigned char			disconnected:1;
-	unsigned char			suspending:1;
 	unsigned char			attached:1;
 	unsigned char			minors_reserved:1;
 	unsigned char			num_ports;
-- 
2.26.3

