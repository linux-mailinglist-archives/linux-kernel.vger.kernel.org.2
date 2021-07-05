Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE5A73BB8F7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 10:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhGEIXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 04:23:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:40908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230324AbhGEIXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 04:23:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB84C613FB;
        Mon,  5 Jul 2021 08:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625473240;
        bh=gU2KIV1UToXi8NzfHed8Zsat9LVm5rq/ChFXgWWM3KY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VWCo7i5Kdcp82XIMMYSQQNWHO/Icju/46v9HxOEtMOcaBnxwQorD+JocvT0ORdSaL
         PAm39MkBP1VtmJHthoBp6t24GOHUQ90zLXsR6mgrTLjSZnZNHq3edNhCwhaAUYD57S
         30K7+vW82sBiLO3VebayG9nKTxd02sbMH5/UmkmEjsfL1olMt9vwQxqsh9GbA0Knlu
         QMRvk9XQh+ccF1uScsyubeyEfqMf8AwcddDDYlPwDb2FMQnt8qMjEQDnALWUBfHhW0
         ZLXvUwS2QEAdGJ3APCqSzo9hJzyALzZ6kL7+lzuSTqVkV1f3DSE1jd14FmvQzW5XD2
         FLeBLxpJ2tKcg==
Received: from johan by xi with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1m0JqF-0004lx-Cj; Mon, 05 Jul 2021 10:20:35 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] USB: serial: cp210x: clean up set-chars request
Date:   Mon,  5 Jul 2021 10:20:13 +0200
Message-Id: <20210705082015.18286-5-johan@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210705082015.18286-1-johan@kernel.org>
References: <20210705082015.18286-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the generic control request helper to implement the SET_CHARS
request.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/cp210x.c | 28 ++--------------------------
 1 file changed, 2 insertions(+), 26 deletions(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index e560608afb1e..6e027e2a02ad 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -1144,31 +1144,6 @@ static void cp210x_disable_event_mode(struct usb_serial_port *port)
 	port_priv->event_mode = false;
 }
 
-static int cp210x_set_chars(struct usb_serial_port *port,
-		struct cp210x_special_chars *chars)
-{
-	struct cp210x_port_private *port_priv = usb_get_serial_port_data(port);
-	struct usb_serial *serial = port->serial;
-	void *dmabuf;
-	int result;
-
-	dmabuf = kmemdup(chars, sizeof(*chars), GFP_KERNEL);
-	if (!dmabuf)
-		return -ENOMEM;
-
-	result = usb_control_msg(serial->dev, usb_sndctrlpipe(serial->dev, 0),
-				CP210X_SET_CHARS, REQTYPE_HOST_TO_INTERFACE, 0,
-				port_priv->bInterfaceNumber,
-				dmabuf, sizeof(*chars), USB_CTRL_SET_TIMEOUT);
-
-	kfree(dmabuf);
-
-	if (result < 0)
-		return result;
-
-	return 0;
-}
-
 static bool cp210x_termios_change(const struct ktermios *a, const struct ktermios *b)
 {
 	bool iflag_change, cc_change;
@@ -1216,7 +1191,8 @@ static void cp210x_set_flow_control(struct tty_struct *tty,
 		chars.bXonChar = START_CHAR(tty);
 		chars.bXoffChar = STOP_CHAR(tty);
 
-		ret = cp210x_set_chars(port, &chars);
+		ret = cp210x_write_reg_block(port, CP210X_SET_CHARS, &chars,
+				sizeof(chars));
 		if (ret) {
 			dev_err(&port->dev, "failed to set special chars: %d\n",
 					ret);
-- 
2.31.1

