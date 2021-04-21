Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D5F3668A3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 11:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239061AbhDUJ5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 05:57:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:52444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238651AbhDUJ4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 05:56:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5DD9A61461;
        Wed, 21 Apr 2021 09:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618998937;
        bh=SK9ZenkpY1lkk5Kanf0WI01JeFJUJ3TcM9Wfil0ofYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xsig+VeM6WlC47I1hWI9BUuIoJI0/zMnvSTvn90rMOi8Lrqry1pPJa/5oGcc+buC0
         jzZIbQYo0fPHksIZYB/jxDKjXb0rfpKWZ7tFSvFV5+Bax+qk50R29dyZnYBarhV1Jo
         EYWzcEscQxe79WlL/rXOqHKT1FWnnP85vg2jDOLMekz9fWE380FrAgZLZkqIXfyWNp
         xvdvZXL7g4zhQuW1cWA0w8Aqw02FOcBDzmz8buMF52JDWgfJeKYAbXrsrzq2I7lML5
         407YLQkkGbZ6N7XpnW6TBRczYJ+CJWY2CYJZ4CHhZMZb7T9nxv4jjEOcHAivs8riiR
         oYOxm5HursiuQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lZ9a8-0000pR-KF; Wed, 21 Apr 2021 11:55:40 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 23/26] serial: sunsu: drop low-latency workaround
Date:   Wed, 21 Apr 2021 11:55:06 +0200
Message-Id: <20210421095509.3024-24-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210421095509.3024-1-johan@kernel.org>
References: <20210421095509.3024-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sunsu driver has been carrying a workaround for the infamous
low_latency behaviour of tty_flip_buffer_push() by dropping and
reacquiring the port lock in the interrupt handler since 2004.

Since commit a9c3f68f3cd8 ("tty: Fix low_latency BUG"),
tty_flip_buffer_push() always schedules a work item to push data to the
line discipline and there's no need to keep any low_latency hacks around.

Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/sunsu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
index 319e5ceb6130..12c2468f2b0e 100644
--- a/drivers/tty/serial/sunsu.c
+++ b/drivers/tty/serial/sunsu.c
@@ -466,12 +466,8 @@ static irqreturn_t sunsu_serial_interrupt(int irq, void *dev_id)
 		if (status & UART_LSR_THRE)
 			transmit_chars(up);
 
-		spin_unlock_irqrestore(&up->port.lock, flags);
-
 		tty_flip_buffer_push(&up->port.state->port);
 
-		spin_lock_irqsave(&up->port.lock, flags);
-
 	} while (!(serial_in(up, UART_IIR) & UART_IIR_NO_INT));
 
 	spin_unlock_irqrestore(&up->port.lock, flags);
-- 
2.26.3

