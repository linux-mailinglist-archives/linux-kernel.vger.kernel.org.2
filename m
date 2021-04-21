Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298D23668A4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 11:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbhDUJ6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 05:58:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:52428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238650AbhDUJ4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 05:56:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2FA486145D;
        Wed, 21 Apr 2021 09:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618998937;
        bh=0Q1FSWChHoIk65q7u9cztH7Ba1e7MUq1Gmq6C+qJeQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gslRcaUTlMXXSXBT67LcwgbOYA3e3JeucmhBE7LKEJ43J5nHoFWCsVHgk1mdYv1/P
         Cbx1IQA2wTPhdKxh6aXHAn899Jy7h0v11n8lnlbqS9AB/bBQWLhY8r/TLYqyiWq8UT
         WPZd2GmjfukEODldBORvNOz+C4ZJC1fhl2uBXUYeXCk/SMjbopC3bsU5ilHcKoEqKd
         nYvdYg1AohvvSSs3kqcXq+PXArCvGA5Cv/gLqCyf9wtS0fc+AsSjm6v173c/tO3k/7
         w8PnVS2P0WzfLY6fgfWTRzM+EpInK4ElZZ3VbehXl2WeKMHpt59EZIVpvdN0guGf76
         LWIPosk/bsQUQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lZ9a8-0000pL-FX; Wed, 21 Apr 2021 11:55:40 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 21/26] serial: txx9: drop low-latency workaround
Date:   Wed, 21 Apr 2021 11:55:04 +0200
Message-Id: <20210421095509.3024-22-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210421095509.3024-1-johan@kernel.org>
References: <20210421095509.3024-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f5ee56cc184e ("[PATCH] txx9 serial update") worked around the
infamous low_latency behaviour of tty_flip_buffer_push() by simply
dropping and reacquiring the port lock in the interrupt handler.

Since commit a9c3f68f3cd8 ("tty: Fix low_latency BUG"),
tty_flip_buffer_push() always schedules a work item to push data to the
line discipline and there's no need to keep any low_latency hacks around.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/serial_txx9.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/serial_txx9.c
index 7a07e7272de1..0a7e5b74bc1d 100644
--- a/drivers/tty/serial/serial_txx9.c
+++ b/drivers/tty/serial/serial_txx9.c
@@ -330,9 +330,9 @@ receive_chars(struct uart_txx9_port *up, unsigned int *status)
 		up->port.ignore_status_mask = next_ignore_status_mask;
 		disr = sio_in(up, TXX9_SIDISR);
 	} while (!(disr & TXX9_SIDISR_UVALID) && (max_count-- > 0));
-	spin_unlock(&up->port.lock);
+
 	tty_flip_buffer_push(&up->port.state->port);
-	spin_lock(&up->port.lock);
+
 	*status = disr;
 }
 
-- 
2.26.3

