Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C983668A6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 11:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239106AbhDUJ6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 05:58:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:52668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238665AbhDUJ4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 05:56:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6AFEB6161C;
        Wed, 21 Apr 2021 09:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618998937;
        bh=VTQug4KonkCW3AtuCnbEYUMWwraNNce3xB7n0+oAyhY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=udsJI+UgqYUfPS3I+ydvP3wM+AqHKo7F+Th1saDcsH30IVwi4fCWmtss0SJfj/tV+
         LYtpsU35Y8Mve6d1+kLI7nYZm20xTSK2qXFb2kL/WDf1xLn1xyWDL2VjKFTMTJAF4i
         400buwGelYIjQP1cSVASbqJhCFBNiwAAk6d7wrQsmBeUCar6ZsETh/tWLHF9oqOWPA
         xNB0jneS6TkWws+g/HAq6P0H7494dm/4GV3RqHsWY7q+U89SpZlZ0ILwjGMfdIq0X4
         KwNNPAfWu3UknHONaO+wVgy24bIjaZABB3jaGdizwKth/BlxZQEmYlRN0aaN9uyUjS
         j1n+oex+fPCfQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lZ9a8-0000pV-NK; Wed, 21 Apr 2021 11:55:40 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 24/26] serial: timbuart: drop low-latency workaround
Date:   Wed, 21 Apr 2021 11:55:07 +0200
Message-Id: <20210421095509.3024-25-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210421095509.3024-1-johan@kernel.org>
References: <20210421095509.3024-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The timbuart driver has always carried a workaround for the infamous
low_latency behaviour of tty_flip_buffer_push() which required not
holding the port lock when the low_latency flag was set.

Since commit a9c3f68f3cd8 ("tty: Fix low_latency BUG"),
tty_flip_buffer_push() always schedules a work item to push data to the
line discipline and there's no need to keep any low_latency hacks
around.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/timbuart.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/timbuart.c b/drivers/tty/serial/timbuart.c
index 2126e6e6dfd1..08941eabe7b1 100644
--- a/drivers/tty/serial/timbuart.c
+++ b/drivers/tty/serial/timbuart.c
@@ -87,9 +87,7 @@ static void timbuart_rx_chars(struct uart_port *port)
 		tty_insert_flip_char(tport, ch, TTY_NORMAL);
 	}
 
-	spin_unlock(&port->lock);
 	tty_flip_buffer_push(tport);
-	spin_lock(&port->lock);
 
 	dev_dbg(port->dev, "%s - total read %d bytes\n",
 		__func__, port->icount.rx);
-- 
2.26.3

