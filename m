Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4970632A1F9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349352AbhCBHP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 02:15:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:39624 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1835863AbhCBGXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 01:23:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 750F0AF9E;
        Tue,  2 Mar 2021 06:22:17 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 12/44] tty: 8250, cleanup em485 timers
Date:   Tue,  2 Mar 2021 07:21:42 +0100
Message-Id: <20210302062214.29627-12-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302062214.29627-1-jslaby@suse.cz>
References: <20210302062214.29627-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize the variables directly by initializers in definitions. This
is expected/usual for these kind of callback.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/8250/8250_port.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 167c1e3e53bc..9019f8f626bb 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1466,13 +1466,11 @@ EXPORT_SYMBOL_GPL(serial8250_em485_stop_tx);
 
 static enum hrtimer_restart serial8250_em485_handle_stop_tx(struct hrtimer *t)
 {
-	struct uart_8250_em485 *em485;
-	struct uart_8250_port *p;
+	struct uart_8250_em485 *em485 = container_of(t, struct uart_8250_em485,
+			stop_tx_timer);
+	struct uart_8250_port *p = em485->port;
 	unsigned long flags;
 
-	em485 = container_of(t, struct uart_8250_em485, stop_tx_timer);
-	p = em485->port;
-
 	serial8250_rpm_get(p);
 	spin_lock_irqsave(&p->port.lock, flags);
 	if (em485->active_timer == &em485->stop_tx_timer) {
@@ -1482,6 +1480,7 @@ static enum hrtimer_restart serial8250_em485_handle_stop_tx(struct hrtimer *t)
 	}
 	spin_unlock_irqrestore(&p->port.lock, flags);
 	serial8250_rpm_put(p);
+
 	return HRTIMER_NORESTART;
 }
 
@@ -1629,19 +1628,18 @@ static inline void start_tx_rs485(struct uart_port *port)
 
 static enum hrtimer_restart serial8250_em485_handle_start_tx(struct hrtimer *t)
 {
-	struct uart_8250_em485 *em485;
-	struct uart_8250_port *p;
+	struct uart_8250_em485 *em485 = container_of(t, struct uart_8250_em485,
+			start_tx_timer);
+	struct uart_8250_port *p = em485->port;
 	unsigned long flags;
 
-	em485 = container_of(t, struct uart_8250_em485, start_tx_timer);
-	p = em485->port;
-
 	spin_lock_irqsave(&p->port.lock, flags);
 	if (em485->active_timer == &em485->start_tx_timer) {
 		__start_tx(&p->port);
 		em485->active_timer = NULL;
 	}
 	spin_unlock_irqrestore(&p->port.lock, flags);
+
 	return HRTIMER_NORESTART;
 }
 
-- 
2.30.1

