Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2E83B45CA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 16:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbhFYOj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 10:39:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231738AbhFYOjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 10:39:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D6156197D;
        Fri, 25 Jun 2021 14:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624631818;
        bh=TY3iBQKER6Z5ph8zWEWZU/pK1GZsZOyt08z1Cvndgwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tFH2krxAUdnVo2o1eH28xZYBc+sPvoHTPUDNA/jnWE6HQ3sGHzClSguGJVlf4gFnh
         7cT6uTLphBArfn1ryGI2KxEyFbTTvtmSAp04YCzckbv0oxSeawYzYq9GWWx3Ku9RY2
         NitMEtgrlzzP3mLKe2RGhgy5+x10fMLInO6J8i4NFY+aWcS9SnvbBbu+UxSHAtVDU4
         jGtsVy3ZWf+2VX9TCAFJL7vzw54U/rHXou84km2DrwGygTCtDQgO6p+DrWfA9v07Ln
         GZrpJTnnsmWFrHQ3hOjhcEKQGDMPe5bOk638elEkePEHtUO06NCnRKXMxfNNcGl4ho
         Rc5G3vV5XmFOA==
Received: by pali.im (Postfix)
        id 64A02A89; Fri, 25 Jun 2021 16:36:56 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 02/11] serial: mvebu-uart: do not allow changing baudrate when uartclk is not available
Date:   Fri, 25 Jun 2021 16:36:08 +0200
Message-Id: <20210625143617.12826-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210625143617.12826-1-pali@kernel.org>
References: <20210624224909.6350-1-pali@kernel.org>
 <20210625143617.12826-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Testing mvuart->clk for non-error is not enough as mvuart->clk may contain
valid clk pointer but when clk_prepare_enable(mvuart->clk) failed then
port->uartclk is zero.

When mvuart->clk is not available then port->uartclk is zero too.

Parent clock rate port->uartclk is needed to calculate UART clock divisor
and without it is not possible to change baudrate.

So fix test condition when it is possible to change baudrate.

Signed-off-by: Pali Rohár <pali@kernel.org>
Fixes: 68a0db1d7da2 ("serial: mvebu-uart: add function to change baudrate")
---
 drivers/tty/serial/mvebu-uart.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index f81bfdaa608c..dc0c26824ddb 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -445,12 +445,11 @@ static void mvebu_uart_shutdown(struct uart_port *port)
 
 static int mvebu_uart_baud_rate_set(struct uart_port *port, unsigned int baud)
 {
-	struct mvebu_uart *mvuart = to_mvuart(port);
 	unsigned int d_divisor, m_divisor;
 	u32 brdv, osamp;
 
-	if (IS_ERR(mvuart->clk))
-		return -PTR_ERR(mvuart->clk);
+	if (!port->uartclk)
+		return -EOPNOTSUPP;
 
 	/*
 	 * The baudrate is derived from the UART clock thanks to two divisors:
-- 
2.20.1

