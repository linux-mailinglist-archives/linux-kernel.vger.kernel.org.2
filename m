Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F938356A0E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351328AbhDGKlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:41:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:49168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351166AbhDGKkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:40:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18AEE613AF;
        Wed,  7 Apr 2021 10:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617791991;
        bh=SnKb6OzBjTC6SRw+aBNHZE6syiOlb1cZ4KvRGmbCCOY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CgJSDBaPERDS+6yVi2LpqPHuZm9lsQuuVbJ5Ajph0ZaZdsz5SDVuYG6uucJhVxg54
         OLDdOx0g7zWCGr5IhDwA/Ch+8KEpoGAcgQ7V/PVZ9QfFVDfBB+Udq1KmfU0VRkXzGS
         Q31O4TXsRLxNKRHp3FE9a93mRSU3GmO7U7/tdux5QYov3z9ULzHxKn7Db5fQQYVpHI
         irY2rrjIpaGFBFz51twfyBPT+pqGL6d9K6DX2FnzkGNM6NSrNQJkseIvagqL+S440i
         4sKfUnRvw/nRrQ2zGSw6MOS5GQdcEsPSJhSxHT3PpvIjQJy2SsIVTYqUIecC6zCb8Z
         Fx3ECc+LxKEpw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lU5b5-0000FR-UE; Wed, 07 Apr 2021 12:39:43 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 19/24] USB: serial: fix return value for unsupported ioctls
Date:   Wed,  7 Apr 2021 12:39:20 +0200
Message-Id: <20210407103925.829-20-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210407103925.829-1-johan@kernel.org>
References: <20210407103925.829-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers should return -ENOTTY ("Inappropriate I/O control operation")
when an ioctl isn't supported, while -EINVAL is used for invalid
arguments.

Fix up the TIOCMGET, TIOCMSET and TIOCGICOUNT helpers which returned
-EINVAL when a USB serial driver did not implement the corresponding
methods.

Note that the TIOCMGET and TIOCMSET helpers predate git and do not get a
corresponding Fixes tag below.

Fixes: d281da7ff6f7 ("tty: Make tiocgicount a handler")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/usb-serial.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index 27e3bb58c872..c311cc4fabee 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -502,7 +502,7 @@ static int serial_tiocmget(struct tty_struct *tty)
 
 	if (port->serial->type->tiocmget)
 		return port->serial->type->tiocmget(tty);
-	return -EINVAL;
+	return -ENOTTY;
 }
 
 static int serial_tiocmset(struct tty_struct *tty,
@@ -514,7 +514,7 @@ static int serial_tiocmset(struct tty_struct *tty,
 
 	if (port->serial->type->tiocmset)
 		return port->serial->type->tiocmset(tty, set, clear);
-	return -EINVAL;
+	return -ENOTTY;
 }
 
 static int serial_get_icount(struct tty_struct *tty,
@@ -526,7 +526,7 @@ static int serial_get_icount(struct tty_struct *tty,
 
 	if (port->serial->type->get_icount)
 		return port->serial->type->get_icount(tty, icount);
-	return -EINVAL;
+	return -ENOTTY;
 }
 
 /*
-- 
2.26.3

