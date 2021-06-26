Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939C83B4C62
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 06:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhFZENo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 00:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbhFZENn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 00:13:43 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F1871C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 21:11:21 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 3E9EA9200BC; Sat, 26 Jun 2021 06:11:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 3B85C9200BB;
        Sat, 26 Jun 2021 06:11:21 +0200 (CEST)
Date:   Sat, 26 Jun 2021 06:11:21 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] serial: core: Report magic multiplier extra baud rates
Message-ID: <alpine.DEB.2.21.2106260334170.37803@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Report extra baud rates supported above the base rate for ports with the 
UPF_MAGIC_MULTIPLIER property, so that people have a way to find out 
that they can be used with their system, e.g.:

Serial: 8250/16550 driver, 5 ports, IRQ sharing enabled
printk: console [ttyS0] disabled
serial8250.0: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
serial8250.0: ttyS0 extra baud rates supported: 230400, 460800
printk: console [ttyS0] enabled
printk: bootconsole [uart8250] disabled
serial8250.0: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
serial8250.0: ttyS1 extra baud rates supported: 230400, 460800
serial8250.0: ttyS2 at MMIO 0x1f000900 (irq = 20, base_baud = 230400) is a 16550A

Otherwise there is no clear way to figure this out, as the feature is 
only reported as an obscure TTY flag in bit 16:

$ cat /sys/class/tty/ttyS[0-2]/flags
0x10010040
0x10010040
0x90000040
$ 

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 drivers/tty/serial/serial_core.c |    8 ++++++++
 1 file changed, 8 insertions(+)

linux-serial-core-magic-multiplier.diff
Index: linux-macro-ide-tty/drivers/tty/serial/serial_core.c
===================================================================
--- linux-macro-ide-tty.orig/drivers/tty/serial/serial_core.c
+++ linux-macro-ide-tty/drivers/tty/serial/serial_core.c
@@ -2314,6 +2314,14 @@ uart_report_port(struct uart_driver *drv
 	       port->dev ? ": " : "",
 	       port->name,
 	       address, port->irq, port->uartclk / 16, uart_type(port));
+
+	/* The magic multiplier feature is a bit obscure, so report it too.  */
+	if (port->flags & UPF_MAGIC_MULTIPLIER)
+		pr_info("%s%s%s extra baud rates supported: %d, %d",
+			port->dev ? dev_name(port->dev) : "",
+			port->dev ? ": " : "",
+			port->name,
+			port->uartclk / 8, port->uartclk / 4);
 }
 
 static void
