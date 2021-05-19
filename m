Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A45388A6D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 11:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345124AbhESJVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 05:21:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:44166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344959AbhESJVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 05:21:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 37EB1610E9;
        Wed, 19 May 2021 09:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621416029;
        bh=q0Dh0cBtH9BLd36ldaoGyBeuh4K7+V/VNafNnRQ28L8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uvPR7HMufU1No/FkWpSf+tDV6eM8bItTdyWIroES8lYku/QLcW8U60U+V0TZUFoZY
         wFUgM8HkVil8anqT4aU3aiLSoCRZz6XGU61OOPohuQabpc+aIER8+7m28whv4/cFnI
         Z7ZRL7WcXddiO1Njdb8OJW8SVczctb9Kdy2vTXtgs3wIqteplHTJ27gQRrGJ8WLQjN
         w1uIa9mhqP5EAjICg/GRxJqXeq5TkjQNy89r4h60pqeIG2lmosujcnlMKXOTxW0oZ6
         fVMeIvlSG2alkQdSFpf73rtNtcLWYlp2QbdCh/Q++aTFlyu7/1UpQ9Q9XFllyDbd3P
         VXzHxphc4RdTg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ljINQ-0002Yd-Mn; Wed, 19 May 2021 11:20:28 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] USB: serial: io_edgeport: drop buffer-callback sanity checks
Date:   Wed, 19 May 2021 11:20:03 +0200
Message-Id: <20210519092006.9775-4-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210519092006.9775-1-johan@kernel.org>
References: <20210519092006.9775-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver write_room and chars_in_buffer callbacks used to incorrectly
return a negative errno in case they were called while or after the port
had been closed. The return value was later changed to zero by commit
d76f2f4462bb ("io_edgeport: Fix various bogus returns to the tty
layer") but the bogus sanity checks were left in place as were the
outdated function-header comments.

These callbacks will never be called for an uninitialised port so drop
the unnecessary sanity checks and the outdated comments.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/io_edgeport.c | 27 +--------------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
index 1f8dff4390c7..ea4edf5eed27 100644
--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -1351,9 +1351,7 @@ static void send_more_port_data(struct edgeport_serial *edge_serial,
 /*****************************************************************************
  * edge_write_room
  *	this function is called by the tty driver when it wants to know how
- *	many bytes of data we can accept for a specific port. If successful,
- *	we return the amount of room that we have for this port	(the txCredits)
- *	otherwise we return a negative error number.
+ *	many bytes of data we can accept for a specific port.
  *****************************************************************************/
 static unsigned int edge_write_room(struct tty_struct *tty)
 {
@@ -1362,16 +1360,6 @@ static unsigned int edge_write_room(struct tty_struct *tty)
 	unsigned int room;
 	unsigned long flags;
 
-	if (edge_port == NULL)
-		return 0;
-	if (edge_port->closePending)
-		return 0;
-
-	if (!edge_port->open) {
-		dev_dbg(&port->dev, "%s - port not opened\n", __func__);
-		return 0;
-	}
-
 	/* total of both buffers is still txCredit */
 	spin_lock_irqsave(&edge_port->ep_lock, flags);
 	room = edge_port->txCredits - edge_port->txfifo.count;
@@ -1387,9 +1375,6 @@ static unsigned int edge_write_room(struct tty_struct *tty)
  *	this function is called by the tty driver when it wants to know how
  *	many bytes of data we currently have outstanding in the port (data that
  *	has been written, but hasn't made it out the port yet)
- *	If successful, we return the number of bytes left to be written in the
- *	system,
- *	Otherwise we return a negative error number.
  *****************************************************************************/
 static unsigned int edge_chars_in_buffer(struct tty_struct *tty)
 {
@@ -1398,16 +1383,6 @@ static unsigned int edge_chars_in_buffer(struct tty_struct *tty)
 	unsigned int num_chars;
 	unsigned long flags;
 
-	if (edge_port == NULL)
-		return 0;
-	if (edge_port->closePending)
-		return 0;
-
-	if (!edge_port->open) {
-		dev_dbg(&port->dev, "%s - port not opened\n", __func__);
-		return 0;
-	}
-
 	spin_lock_irqsave(&edge_port->ep_lock, flags);
 	num_chars = edge_port->maxTxCredits - edge_port->txCredits +
 						edge_port->txfifo.count;
-- 
2.26.3

