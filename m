Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA0D388814
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 09:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239871AbhESHXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 03:23:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:39348 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237490AbhESHXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 03:23:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B7B22AFEF;
        Wed, 19 May 2021 07:21:54 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 2/4] tty/serial: make port of serial8250_register_8250_port const
Date:   Wed, 19 May 2021 09:21:51 +0200
Message-Id: <20210519072153.3859-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519072153.3859-1-jslaby@suse.cz>
References: <20210519072153.3859-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the previous patch, we can make port passed to
serial8250_find_match_or_unused const. And then we can make const also
port of serial8250_register_8250_port.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/8250/8250_core.c | 4 ++--
 include/linux/serial_8250.h         | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 1082e76c4d37..1ce193daea7f 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -906,7 +906,7 @@ static struct platform_device *serial8250_isa_devs;
  */
 static DEFINE_MUTEX(serial_mutex);
 
-static struct uart_8250_port *serial8250_find_match_or_unused(struct uart_port *port)
+static struct uart_8250_port *serial8250_find_match_or_unused(const struct uart_port *port)
 {
 	int i;
 
@@ -971,7 +971,7 @@ static void serial_8250_overrun_backoff_work(struct work_struct *work)
  *
  *	On success the port is ready to use and the line number is returned.
  */
-int serial8250_register_8250_port(struct uart_8250_port *up)
+int serial8250_register_8250_port(const struct uart_8250_port *up)
 {
 	struct uart_8250_port *uart;
 	int ret = -ENOSPC;
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 9e655055112d..5db211f43b29 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -146,7 +146,7 @@ static inline struct uart_8250_port *up_to_u8250p(struct uart_port *up)
 	return container_of(up, struct uart_8250_port, port);
 }
 
-int serial8250_register_8250_port(struct uart_8250_port *);
+int serial8250_register_8250_port(const struct uart_8250_port *);
 void serial8250_unregister_port(int line);
 void serial8250_suspend_port(int line);
 void serial8250_resume_port(int line);
-- 
2.31.1

