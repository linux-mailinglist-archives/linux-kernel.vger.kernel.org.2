Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159613569FF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351323AbhDGKkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:40:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234868AbhDGKkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:40:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19B2C613B8;
        Wed,  7 Apr 2021 10:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617791990;
        bh=nEsXEXQJxRf/84Q7AHuwDjFlmGoeWC6cQeEgYeaswuk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EWyfL2CwR8MCQShWHCS0Ls+RpVAAlwlJyuaU/OHihgmErttfSEZfZ+V3XW+xX2Jyl
         Cuha0b1oMt4+/UM7Kn0LflyUNrcWjuK9rCoVEJ9xnKSq74glJ7rdSReV51P52gFxfN
         srlKvvrzi8yanO/uWope0K5YSFLt67FkcBcsfjktXrew2cdtpnLoqGV8Jcmlar8Moq
         iIDLTxGhJ+DRNDlavUDzpV09bT67P1iwt6Vk2KBi700ILYEZBO4ybE0aKDvS5MlXk9
         Gm0auu8c+NtoWsn2lsyaK+JapC/pe3n5P51Qf3uk7LwxMX3zp2mCV95ap338ntLwxx
         gF+xBibWyLmsQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lU5b4-0000Eu-Te; Wed, 07 Apr 2021 12:39:42 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/24] USB: serial: mos7840: fix TIOCGSERIAL implementation
Date:   Wed,  7 Apr 2021 12:39:09 +0200
Message-Id: <20210407103925.829-9-johan@kernel.org>
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
changing these, but let's report back the default values actually used
(0.5 and 30 seconds, respectively).

Fixes: 3f5429746d91 ("USB: Moschip 7840 USB-Serial Driver")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/mos7840.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
index 1bf0d066f55a..77cbe18a1629 100644
--- a/drivers/usb/serial/mos7840.c
+++ b/drivers/usb/serial/mos7840.c
@@ -1392,16 +1392,12 @@ static int mos7840_get_serial_info(struct tty_struct *tty,
 				   struct serial_struct *ss)
 {
 	struct usb_serial_port *port = tty->driver_data;
-	struct moschip_port *mos7840_port = usb_get_serial_port_data(port);
 
 	ss->type = PORT_16550A;
-	ss->line = mos7840_port->port->minor;
-	ss->port = mos7840_port->port->port_number;
-	ss->irq = 0;
-	ss->xmit_fifo_size = NUM_URBS * URB_TRANSFER_BUFFER_SIZE;
-	ss->baud_base = 9600;
-	ss->close_delay = 5 * HZ;
-	ss->closing_wait = 30 * HZ;
+	ss->line = port->minor;
+	ss->close_delay = 50;
+	ss->closing_wait = 3000;
+
 	return 0;
 }
 
-- 
2.26.3

