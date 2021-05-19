Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E5E388813
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 09:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239660AbhESHXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 03:23:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:39318 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237293AbhESHXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 03:23:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 822D9AD4B;
        Wed, 19 May 2021 07:21:54 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 1/4] tty/serial: clean up uart_match_port
Date:   Wed, 19 May 2021 09:21:50 +0200
Message-Id: <20210519072153.3859-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* make parameters const (as they are only read)
* return bool (as comparison results are returned)
* add \n before final return

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/serial_core.c | 16 +++++++++-------
 include/linux/serial_core.h      |  3 ++-
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 33a817c57494..e379fa2e32af 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3005,26 +3005,28 @@ int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
 /*
  *	Are the two ports equivalent?
  */
-int uart_match_port(struct uart_port *port1, struct uart_port *port2)
+bool uart_match_port(const struct uart_port *port1,
+		const struct uart_port *port2)
 {
 	if (port1->iotype != port2->iotype)
-		return 0;
+		return false;
 
 	switch (port1->iotype) {
 	case UPIO_PORT:
-		return (port1->iobase == port2->iobase);
+		return port1->iobase == port2->iobase;
 	case UPIO_HUB6:
-		return (port1->iobase == port2->iobase) &&
-		       (port1->hub6   == port2->hub6);
+		return port1->iobase == port2->iobase &&
+		       port1->hub6   == port2->hub6;
 	case UPIO_MEM:
 	case UPIO_MEM16:
 	case UPIO_MEM32:
 	case UPIO_MEM32BE:
 	case UPIO_AU:
 	case UPIO_TSI:
-		return (port1->mapbase == port2->mapbase);
+		return port1->mapbase == port2->mapbase;
 	}
-	return 0;
+
+	return false;
 }
 EXPORT_SYMBOL(uart_match_port);
 
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 7445c8fd88c0..52d7fb92a69d 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -408,7 +408,8 @@ int uart_register_driver(struct uart_driver *uart);
 void uart_unregister_driver(struct uart_driver *uart);
 int uart_add_one_port(struct uart_driver *reg, struct uart_port *port);
 int uart_remove_one_port(struct uart_driver *reg, struct uart_port *port);
-int uart_match_port(struct uart_port *port1, struct uart_port *port2);
+bool uart_match_port(const struct uart_port *port1,
+		const struct uart_port *port2);
 
 /*
  * Power Management
-- 
2.31.1

