Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF833569EC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351211AbhDGKkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:40:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234626AbhDGKj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:39:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11C1C613AF;
        Wed,  7 Apr 2021 10:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617791990;
        bh=1gxuIGHqLZXdadEccAwc22dsHq4OxU9DCMYgb+3Pl3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gn+y7Z2sPLklkZrEUNqZCeoTkjJQP96hJaZ3qMQD8YYpwp/tfWOqDpdOubW2145ke
         VUMALoVSq+YAHanvCA0ix+WlzctePmGjIqglVpWNo6wL9VmTL+F27YYuU5h/F2vQfX
         cV2jLoTOascxBxYN2lS6gYVUwKHIqkybEDMmxiYZcoVZ2ozSXGpw7cTB0ICfN4eeHQ
         NuoXU7uOKBgOqy8wy5c4Y4ufdoG2PPkwhBwN5t4vdz3RsA8S6z06tB3u/E93pNpZwM
         cB1drGqzX3z0K78uFdJl6uOe7rSoQtQAvnn16b/92zg+smTi+7r7BxxCfwEBCsZ3X2
         +6AnQ8FuDow8g==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lU5b4-0000Eo-OV; Wed, 07 Apr 2021 12:39:42 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/24] USB: serial: io_ti: fix TIOCGSERIAL implementation
Date:   Wed,  7 Apr 2021 12:39:07 +0200
Message-Id: <20210407103925.829-7-johan@kernel.org>
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

The xmit_fifo_size parameter could be used to set the hardware transmit
fifo size of a legacy UART when it could not be detected, but the
interface is limited to eight bits and should be left unset when not
used.

Similarly, baud_base could be used to set the UART base clock when it
could not be detected but might as well be left unset when it is not
known.

The close_delay and closing_wait parameters returned by TIOCGSERIAL are
specified in centiseconds (not jiffies). The driver does not yet support
changing close_delay, but let's report back the default value actually
used (0.5 seconds).

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/io_ti.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/serial/io_ti.c b/drivers/usb/serial/io_ti.c
index e800547be9e0..f5aab570fd05 100644
--- a/drivers/usb/serial/io_ti.c
+++ b/drivers/usb/serial/io_ti.c
@@ -2437,21 +2437,17 @@ static int get_serial_info(struct tty_struct *tty,
 				struct serial_struct *ss)
 {
 	struct usb_serial_port *port = tty->driver_data;
-	struct edgeport_port *edge_port = usb_get_serial_port_data(port);
 	unsigned cwait;
 
-	cwait = edge_port->port->port.closing_wait;
+	cwait = port->port.closing_wait;
 	if (cwait != ASYNC_CLOSING_WAIT_NONE)
 		cwait = jiffies_to_msecs(cwait) / 10;
 
 	ss->type		= PORT_16550A;
-	ss->line		= edge_port->port->minor;
-	ss->port		= edge_port->port->port_number;
-	ss->irq			= 0;
-	ss->xmit_fifo_size	= edge_port->port->bulk_out_size;
-	ss->baud_base		= 9600;
-	ss->close_delay		= 5*HZ;
+	ss->line		= port->minor;
+	ss->close_delay		= 50;
 	ss->closing_wait	= cwait;
+
 	return 0;
 }
 
-- 
2.26.3

