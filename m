Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 564E0356A08
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240584AbhDGKlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:41:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:49098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234986AbhDGKkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:40:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5ACE46139C;
        Wed,  7 Apr 2021 10:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617791990;
        bh=Ff1Ti9CXje+qOhhjNTI7wIhBjGyNTvDcual0tNsok7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TUFKP2pTnqkHFd2xD78eejka9SkrgatNp0DyJU0JU1elMmJ1HMRbyKr0M9tP67pQO
         chAKookY7QMtKvIb+66Tk5gTJjR3HFJSiSfC6HYsJoAUl7HGY5IEwgenC8irE2iPRz
         Nl55Xt3T4QOYvFU6jr+BuAJLHi93K4e9Yn3uASS+z6L1K2JLh+PU3J98UTqN2ICF6S
         qmEP0cHBrrjSygESnRLIyapo5IzExTFc7AoGBA3eZQ5TIKirK0XuQydN1W0kGLtafq
         qLxSz6bg6EIkaB7XMCVsP+PtmflmzLlVg9raMm4XNksPiIZPTp2ZZ/zeTPydyLtvvJ
         jU/JnUfxyKmUQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lU5b5-0000F3-6N; Wed, 07 Apr 2021 12:39:43 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/24] USB: serial: quatech2: fix TIOCGSERIAL implementation
Date:   Wed,  7 Apr 2021 12:39:12 +0200
Message-Id: <20210407103925.829-12-johan@kernel.org>
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

Fixes: f7a33e608d9a ("USB: serial: add quatech2 usb to serial driver")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/quatech2.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/serial/quatech2.c b/drivers/usb/serial/quatech2.c
index 599dcb2e374d..0d23e565e0d2 100644
--- a/drivers/usb/serial/quatech2.c
+++ b/drivers/usb/serial/quatech2.c
@@ -459,12 +459,9 @@ static int get_serial_info(struct tty_struct *tty,
 	struct usb_serial_port *port = tty->driver_data;
 
 	ss->line		= port->minor;
-	ss->port		= 0;
-	ss->irq			= 0;
-	ss->xmit_fifo_size	= port->bulk_out_size;
-	ss->baud_base		= 9600;
-	ss->close_delay		= 5*HZ;
-	ss->closing_wait	= 30*HZ;
+	ss->close_delay		= 50;
+	ss->closing_wait	= 3000;
+
 	return 0;
 }
 
-- 
2.26.3

