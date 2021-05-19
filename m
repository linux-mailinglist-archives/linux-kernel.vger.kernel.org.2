Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0DAF388A70
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 11:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345211AbhESJV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 05:21:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:44152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344940AbhESJVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 05:21:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 329186135F;
        Wed, 19 May 2021 09:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621416029;
        bh=in4Ts4+KP0t8HEnjNhpwCgfKTJQ6jDj/qQsiRcQqM3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IOQ5k3SIEWWilVBVYDjYbxy5fXG2iezkXvfebeIxIdF8UzsILfiXCtfcloNlEt1Cp
         iOLJMUJASiUywRmVzSRF/H7pPoYGRSbU6dKVfCCo2FOMS44T6dhIKcfPKbpalc5qW6
         1z4lKJMt0yZE0XHlaLbJwLXA1EE/0q0bngpXEJts+RR1W/vbFz654jFlMLah7NTJs/
         20p7v8m5nUDkDJRwc6sJtDBF0Uivzp+uUz8gml3jjCGSn68b29l+E30IefBKjW0TIo
         fYxQkfVY1sCP8p37Mhy9goQdFHXD+T/tgwKOxsRNSrSrb8FmyLBs3vVNraf3vHoazT
         dIJTg2nr8WA1g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ljINQ-0002Yg-Q1; Wed, 19 May 2021 11:20:28 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] USB: serial: mos7720: drop buffer-callback sanity checks
Date:   Wed, 19 May 2021 11:20:04 +0200
Message-Id: <20210519092006.9775-5-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210519092006.9775-1-johan@kernel.org>
References: <20210519092006.9775-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver write_room and chars_in_buffer callbacks used to incorrectly
return a negative errno in case they were ever called with a NULL port
driver-data pointer. The return value was later changed to zero by
commit 23198fda7182 ("tty: fix chars_in_buffers") but the bogus sanity
checks were left in place as were the outdated function-header comments.

The port driver data isn't cleared until after the port has been
deregistered and all open ttys have been hung up so drop the unnecessary
sanity checks and the outdated comments.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/mos7720.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/serial/mos7720.c b/drivers/usb/serial/mos7720.c
index ce41009756f3..227f43d2bd56 100644
--- a/drivers/usb/serial/mos7720.c
+++ b/drivers/usb/serial/mos7720.c
@@ -945,20 +945,13 @@ static int mos7720_open(struct tty_struct *tty, struct usb_serial_port *port)
  *	this function is called by the tty driver when it wants to know how many
  *	bytes of data we currently have outstanding in the port (data that has
  *	been written, but hasn't made it out the port yet)
- *	If successful, we return the number of bytes left to be written in the
- *	system,
- *	Otherwise we return a negative error number.
  */
 static unsigned int mos7720_chars_in_buffer(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
+	struct moschip_port *mos7720_port = usb_get_serial_port_data(port);
 	int i;
 	unsigned int chars = 0;
-	struct moschip_port *mos7720_port;
-
-	mos7720_port = usb_get_serial_port_data(port);
-	if (mos7720_port == NULL)
-		return 0;
 
 	for (i = 0; i < NUM_URBS; ++i) {
 		if (mos7720_port->write_urb_pool[i] &&
@@ -1030,20 +1023,14 @@ static void mos7720_break(struct tty_struct *tty, int break_state)
  * mos7720_write_room
  *	this function is called by the tty driver when it wants to know how many
  *	bytes of data we can accept for a specific port.
- *	If successful, we return the amount of room that we have for this port
- *	Otherwise we return a negative error number.
  */
 static unsigned int mos7720_write_room(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
-	struct moschip_port *mos7720_port;
+	struct moschip_port *mos7720_port = usb_get_serial_port_data(port);
 	unsigned int room = 0;
 	int i;
 
-	mos7720_port = usb_get_serial_port_data(port);
-	if (mos7720_port == NULL)
-		return 0;
-
 	/* FIXME: Locking */
 	for (i = 0; i < NUM_URBS; ++i) {
 		if (mos7720_port->write_urb_pool[i] &&
-- 
2.26.3

