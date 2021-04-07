Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48DD356A07
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351330AbhDGKlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:41:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351165AbhDGKkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:40:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE78D613A9;
        Wed,  7 Apr 2021 10:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617791991;
        bh=lX3F9lxiWnA0PUBwgaH8gncJVnX0qeQaXfJ4Wsy4tIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ooIJ4wp+Eg08Jal4oFXiv6Vm8gWIi6pICfx+QOs4Wqci35HW50fIbG+hrfEscLEpt
         8mTYAK+z3WzqlPVkRvQ3gjthaf/sgeJupSCuQYAIQVNPlUVFRjz9+wxsY5RtvpQ6lF
         WxyWctykOjqo5CHc4eg68UuCM9X04EoyKLcooXxJnfTcHQw/qoYfvlA1WKtjj6kkop
         3mZPeA0fRvi/hwtzRMIADAuUumOkYT8iUIE0HivfeWuJ6/ZPIkMWreozzgPB+wUj4L
         J+S/NsCY1+kVLQkB4+zvflAkVwVXaWKH8J4tVxfuKyiW8BDu/x9aqapKT0doce24lx
         3Yf4wrrQhD8Mw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lU5b5-0000FO-RH; Wed, 07 Apr 2021 12:39:43 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 18/24] USB: serial: whiteheat: fix TIOCGSERIAL implementation
Date:   Wed,  7 Apr 2021 12:39:19 +0200
Message-Id: <20210407103925.829-19-johan@kernel.org>
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

The close_delay and closing_wait parameters returned by TIOCGSERIAL are
specified in centiseconds (not jiffies). The driver does not yet support
changing these, but let's report back the default values actually used
(0.5 and 30 seconds, respectively).

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/whiteheat.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/serial/whiteheat.c b/drivers/usb/serial/whiteheat.c
index ccfd5ed652cd..c8b10faa2ff8 100644
--- a/drivers/usb/serial/whiteheat.c
+++ b/drivers/usb/serial/whiteheat.c
@@ -170,7 +170,6 @@ static int firm_report_tx_done(struct usb_serial_port *port);
 #define COMMAND_PORT		4
 #define COMMAND_TIMEOUT		(2*HZ)	/* 2 second timeout for a command */
 #define	COMMAND_TIMEOUT_MS	2000
-#define CLOSING_DELAY		(30 * HZ)
 
 
 /*****************************************************************************
@@ -447,12 +446,9 @@ static int whiteheat_get_serial(struct tty_struct *tty,
 
 	ss->type = PORT_16654;
 	ss->line = port->minor;
-	ss->port = port->port_number;
-	ss->xmit_fifo_size = kfifo_size(&port->write_fifo);
-	ss->custom_divisor = 0;
 	ss->baud_base = 460800;
-	ss->close_delay = CLOSING_DELAY;
-	ss->closing_wait = CLOSING_DELAY;
+	ss->close_delay = 50;
+	ss->closing_wait = 3000;
 
 	return 0;
 }
-- 
2.26.3

