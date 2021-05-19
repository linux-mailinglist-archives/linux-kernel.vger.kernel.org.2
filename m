Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3CEA388A6A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 11:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345011AbhESJVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 05:21:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:44154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344956AbhESJVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 05:21:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35B3E611BF;
        Wed, 19 May 2021 09:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621416029;
        bh=H0hq/IYa/hEylOqWgyYg83ERvIBrUcwhFOkmavOFN1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V2xpx8cMuc9O3WQhiKxHvz/qItJ6r1cshhpIuAXk8weCb4groFbkvnH2EcUGtOBYK
         QtiI/St2FJKAvlQuO8CENai7PGJUiqrYUtsa6Ojl9FZcCCxAc8yp0H0lJQhZFo8Kls
         9A6Gce7+0QatcUZkoJwss8A/vrSqf3XSCSNp0AlsGVfSONcIuOG0Xnxi1NVRImZwgl
         t3h9JAB3BV07B2Zk0X7SFXXs0Ag14jaDjaPFDkemqONfLi6Ph2Tot1aFfEhhk+ySiv
         rZzV+9qQBTe7k0TiHrAcqYf9YlZWXlr45YXL2DpLM7U4sqCK46qwQC5W6rfIxkxXYu
         6jbFsRB5zJzAQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ljINQ-0002Ya-KB; Wed, 19 May 2021 11:20:28 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] USB: serial: digi_acceleport: add chars_in_buffer locking
Date:   Wed, 19 May 2021 11:20:02 +0200
Message-Id: <20210519092006.9775-3-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210519092006.9775-1-johan@kernel.org>
References: <20210519092006.9775-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both the dp_write_urb_in_use flag and dp_out_buf_len counter should be
accessed while holding the driver port lock. Add the missing locking to
chars_in_buffer and clean up the implementation somewhat by using a
common exit path.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/digi_acceleport.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/serial/digi_acceleport.c b/drivers/usb/serial/digi_acceleport.c
index a4194b70a6fe..754c66ff0fc1 100644
--- a/drivers/usb/serial/digi_acceleport.c
+++ b/drivers/usb/serial/digi_acceleport.c
@@ -1044,17 +1044,19 @@ static unsigned int digi_chars_in_buffer(struct tty_struct *tty)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct digi_port *priv = usb_get_serial_port_data(port);
+	unsigned long flags;
+	unsigned int chars;
 
-	if (priv->dp_write_urb_in_use) {
-		dev_dbg(&port->dev, "digi_chars_in_buffer: port=%d, chars=%d\n",
-			priv->dp_port_num, port->bulk_out_size - 2);
-		return port->bulk_out_size - 2;
-	} else {
-		dev_dbg(&port->dev, "digi_chars_in_buffer: port=%d, chars=%d\n",
-			priv->dp_port_num, priv->dp_out_buf_len);
-		return priv->dp_out_buf_len;
-	}
+	spin_lock_irqsave(&priv->dp_port_lock, flags);
+	if (priv->dp_write_urb_in_use)
+		chars = port->bulk_out_size - 2;
+	else
+		chars = priv->dp_out_buf_len;
+	spin_unlock_irqrestore(&priv->dp_port_lock, flags);
 
+	dev_dbg(&port->dev, "%s: port=%d, chars=%d\n", __func__,
+			priv->dp_port_num, chars);
+	return chars;
 }
 
 static void digi_dtr_rts(struct usb_serial_port *port, int on)
-- 
2.26.3

