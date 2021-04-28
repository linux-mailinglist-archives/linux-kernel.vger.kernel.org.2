Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2299636D327
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 09:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236846AbhD1Hbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 03:31:41 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:53075 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235862AbhD1Hbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 03:31:40 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d41 with ME
        id y7Wu2400A21Fzsu037Wur5; Wed, 28 Apr 2021 09:30:54 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 28 Apr 2021 09:30:54 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org, lukas@wunner.de,
        yangyingliang@huawei.com, andriy.shevchenko@linux.intel.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/2] serial: 8250: Add an empty line and remove some useless {}
Date:   Wed, 28 Apr 2021 09:30:52 +0200
Message-Id: <257ffd691b4a062ad017333c9430d69da6dbd29a.1619594713.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <14024ddeb2b3a8c5b0138b5ba5083f54d00164a9.1619594713.git.christophe.jaillet@wanadoo.fr>
References: <14024ddeb2b3a8c5b0138b5ba5083f54d00164a9.1619594713.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following checkpatch.pl warnings:
   WARNING: Missing a blank line after declarations
   WARNING: braces {} are not necessary for any arm of this statement

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/tty/serial/8250/8250_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 081b773a54c9..1082e76c4d37 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -321,9 +321,9 @@ static int univ8250_setup_irq(struct uart_8250_port *up)
 	 * hardware interrupt, we use a timer-based system.  The original
 	 * driver used to do this with IRQ0.
 	 */
-	if (!port->irq) {
+	if (!port->irq)
 		mod_timer(&up->timer, jiffies + uart_poll_timeout(port));
-	} else
+	else
 		retval = serial_link_irq_chain(up);
 
 	return retval;
@@ -752,6 +752,7 @@ void serial8250_suspend_port(int line)
 	if (!console_suspend_enabled && uart_console(port) &&
 	    port->type != PORT_8250) {
 		unsigned char canary = 0xa5;
+
 		serial_out(up, UART_SCR, canary);
 		if (serial_in(up, UART_SCR) == canary)
 			up->canary = canary;
-- 
2.30.2

