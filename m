Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3DDE35697A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351049AbhDGKYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:24:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:44724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350933AbhDGKYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:24:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C07F613B3;
        Wed,  7 Apr 2021 10:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617791030;
        bh=ojeNQlDbeBe4P3HSW70P9xJ2J0gkKfJbFvASDGXxSOY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HjNgfRvSZS0FOP2GHLQMNZkvl/s0chXhgkcu9aAB0f9KWxNPYuPNCnk88kevGXWuU
         zgDAmAJ2PwujQIDoWkhn2ce59mxVR+tqUJl9cI7d8PJr30fNKy9OR4JSHVjzxIQlR8
         mFGUTaAkJkvlVgyUiY6jzJxCO5RfmbhO6lzRYP2CEWrV14da66bpt5TYpaWqlLYjHT
         YSXQbAJjeTesA96nDuYc1sdWf+oFvO0U0LthpW5XbIEYuBqxAEBgQfz1UPwFnuummk
         ttIf6N8ImZCFQ/SrDb1B6WytTK+6q4qgzbIP6O437lMbdxTL4JJIN2IWQvXDy4kIN0
         0njOOT571RrEg==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lU5Lb-0008RK-6e; Wed, 07 Apr 2021 12:23:43 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-staging@lists.linux.dev,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 07/16] staging: greybus: uart: clean up TIOCGSERIAL
Date:   Wed,  7 Apr 2021 12:23:25 +0200
Message-Id: <20210407102334.32361-8-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210407102334.32361-1-johan@kernel.org>
References: <20210407102334.32361-1-johan@kernel.org>
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

The type parameter could be used to set the UART type, but is
better left unspecified (type unknown) when it isn't used.

Note that some applications have historically expected TIOCGSERIAL to be
implemented, but judging from the Debian sources, the port type not
being PORT_UNKNOWN is only used to check for the existence of legacy
serial ports (ttySn). Notably USB serial drivers like ftdi_sio have been
using PORT_UNKNOWN for twenty years without any problems.

Drop the bogus values provided by the greybus implementation.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/staging/greybus/uart.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
index a520f7f213db..b1e63f7798b0 100644
--- a/drivers/staging/greybus/uart.c
+++ b/drivers/staging/greybus/uart.c
@@ -610,10 +610,7 @@ static int get_serial_info(struct tty_struct *tty,
 {
 	struct gb_tty *gb_tty = tty->driver_data;
 
-	ss->type = PORT_16550A;
 	ss->line = gb_tty->minor;
-	ss->xmit_fifo_size = 16;
-	ss->baud_base = 9600;
 	ss->close_delay = jiffies_to_msecs(gb_tty->port.close_delay) / 10;
 	ss->closing_wait =
 		gb_tty->port.closing_wait == ASYNC_CLOSING_WAIT_NONE ?
-- 
2.26.3

