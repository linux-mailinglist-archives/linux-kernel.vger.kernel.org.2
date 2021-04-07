Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28743569FC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbhDGKkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:40:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:49064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234796AbhDGKkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:40:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0CE17613A7;
        Wed,  7 Apr 2021 10:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617791990;
        bh=qRySowkWF1fElisa29iZUwlmVS6RoK37fkbnaScIWAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A48JKwTOiGeqSEIrCHamPBiNqNByhN4MfidV4sHB0ShbdXIvUihX9AM7alUujPz3r
         93BQZtNJLobHGWm8GEj4gAO5AoUwrKJ5fkrisxO9i99MLI25id8zjkZorVzRRU7C/r
         6bnfm8dAFOVNYEp9lYFKrQoISmMFjHOEODgmywrHlmPyR8S7S1LlDbM2QLkQvamV+F
         fR8L5ZsmX9MS9H/MfUAhX/xv4UvqPoGoYQ5ZmT4l4oqEpal1OPET0fmLRWfI2GLLjP
         twe+enoRkFOcPvlzL7ZsX1m8g8uFJtuuz8qC+5QtgWjzZe6dUtPSF8EiyEG95fiwNA
         bi9DKRIJyDAZg==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lU5b4-0000Eh-Ij; Wed, 07 Apr 2021 12:39:42 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/24] USB: serial: ftdi_sio: fix TIOCGSERIAL implementation
Date:   Wed,  7 Apr 2021 12:39:05 +0200
Message-Id: <20210407103925.829-5-johan@kernel.org>
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

The FTDI driver is the only USB serial driver supporting the deprecated
ASYNC_SPD flags, which are reported back as they should by TIOCGSERIAL,
but the returned parameters did not include the line number.

The close_delay and closing_wait parameters returned by TIOCGSERIAL are
specified in centiseconds. The driver does not yet support changing
these, but let's report back the default values actually used (0.5 and
30 seconds, respectively).

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/ftdi_sio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index c867592477c9..f8a0911f90ea 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1483,9 +1483,13 @@ static int get_serial_info(struct tty_struct *tty,
 	struct usb_serial_port *port = tty->driver_data;
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
 
+	ss->line = port->minor;
 	ss->flags = priv->flags;
 	ss->baud_base = priv->baud_base;
 	ss->custom_divisor = priv->custom_divisor;
+	ss->close_delay = 50;
+	ss->closing_wait = 3000;
+
 	return 0;
 }
 
-- 
2.26.3

