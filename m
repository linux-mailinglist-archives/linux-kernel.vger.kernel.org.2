Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88CAF356A06
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351333AbhDGKlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:41:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:49080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351164AbhDGKkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:40:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA63D613A0;
        Wed,  7 Apr 2021 10:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617791991;
        bh=klW909RSaBy28McI30W9mgK1Oz5co4ynjfnGwGK8d0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uLsKYBfwz4vuRlSxiTKJDYhx8adfX+hij9cNteg3eozCB0Kb7g8ac7ucsjacyACdf
         kYLjxFrH6j9ss+nYA9ZCUODapfKyfnHyAr1OyRhA3hydRoTOBwZa5cn6PqN5VNRTmK
         AFw6nM8huz6IBO5v0km7Um8Kh42slNtZArk8jkMhVZNaESVw84UAJ8I2Azq0DN2KLF
         5UADB2ag+vgWGpAe2QF3hFn5AXZ9TcenW5DFC5DvpJ6g1f+KvpcqqI/+9y19HuJ1kS
         GVS+EMDNGm57tvS4zx5gp08/4bwXDWSdCrBp5Zc913mUsw2VSv6TNKzb4Kn2lKOhmh
         2SZiQyW7SIG7g==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lU5b5-0000FL-OS; Wed, 07 Apr 2021 12:39:43 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 17/24] USB: serial: usb_wwan: fix TIOCGSERIAL implementation
Date:   Wed,  7 Apr 2021 12:39:18 +0200
Message-Id: <20210407103925.829-18-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210407103925.829-1-johan@kernel.org>
References: <20210407103925.829-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TIOCSSERIAL is a horrid, underspecified, legacy interface which for most
serial devices is only useful for setting the close_delay and
closing_wait parameters.

The port parameter is used to set the I/O port and does not make any
sense to use for USB serial devices.

The baud_base parameter could be used to set the UART base clock when it
could not be detected but might as well be left unset when it is not
known.

Fix the usb_wwan TIOCGSERIAL implementation by dropping its custom
interpretation of the unused port and baud_base fields, which were set
to the port index and current line speed, respectively.

Fixes: 02303f73373a ("usb-wwan: implement TIOCGSERIAL and TIOCSSERIAL to avoid blocking close(2)")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/usb_wwan.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/serial/usb_wwan.c b/drivers/usb/serial/usb_wwan.c
index e71c828682f5..4ea315e5e69b 100644
--- a/drivers/usb/serial/usb_wwan.c
+++ b/drivers/usb/serial/usb_wwan.c
@@ -138,8 +138,6 @@ int usb_wwan_get_serial_info(struct tty_struct *tty,
 	struct usb_serial_port *port = tty->driver_data;
 
 	ss->line            = port->minor;
-	ss->port            = port->port_number;
-	ss->baud_base       = tty_get_baud_rate(port->port.tty);
 	ss->close_delay	    = jiffies_to_msecs(port->port.close_delay) / 10;
 	ss->closing_wait    = port->port.closing_wait == ASYNC_CLOSING_WAIT_NONE ?
 				 ASYNC_CLOSING_WAIT_NONE :
-- 
2.26.3

