Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD393668A5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 11:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbhDUJ6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 05:58:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:52442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238663AbhDUJ4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 05:56:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B97161613;
        Wed, 21 Apr 2021 09:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618998937;
        bh=1jlF9+4H5/Lv5qATsCWA0lXWpY9nHr3MIYq7en1RpuQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oFks3IXPSQIidHyslveYyyzvfx5bu+7MVSo27S8ajayrr9lyGN09BzNp0A4iXrQDf
         /iA1YgUXUqwsPa22y6zOY9CdPyjsUokIxr+AiQLnNLZhyOUoDlUNJP4qEPUTzR59FR
         s7vvWYava9QeWANPJtWXYppiqHcb5FTdxBt9NxXcP/JCqBrG5clu+FtsGzEKy5Id0k
         jE3W+/aUurU8e//25CMCLCeLQzdBn4xvpHA8cuz2hVt5zG2buv4Kk7cQ4I9asIL2E/
         3IMQtQZdoWs8rYWFea3Lh8PEXiKQgC2ccpDlHAQbrrdaeyBMsv6L82aNVgruyKkfnq
         f0JSxkDH21JZg==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lZ9a8-0000pO-Hx; Wed, 21 Apr 2021 11:55:40 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH 22/26] serial: sifive: drop low-latency workaround
Date:   Wed, 21 Apr 2021 11:55:05 +0200
Message-Id: <20210421095509.3024-23-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210421095509.3024-1-johan@kernel.org>
References: <20210421095509.3024-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sifive driver has always carried an unnecessary workaround for the
infamous low_latency behaviour of tty_flip_buffer_push() which had been
removed years before the driver was added by commit 45c054d0815b ("tty:
serial: add driver for the SiFive UART").

Specifically, since commit a9c3f68f3cd8 ("tty: Fix low_latency BUG"),
tty_flip_buffer_push() always schedules a work item to push data to the
line discipline and there's no need to keep any low_latency hacks around.

Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/sifive.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index 328d5a78792f..0ac0371f943b 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -448,9 +448,7 @@ static void __ssp_receive_chars(struct sifive_serial_port *ssp)
 		uart_insert_char(&ssp->port, 0, 0, ch, TTY_NORMAL);
 	}
 
-	spin_unlock(&ssp->port.lock);
 	tty_flip_buffer_push(&ssp->port.state->port);
-	spin_lock(&ssp->port.lock);
 }
 
 /**
-- 
2.26.3

