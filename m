Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D3B3B45D1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 16:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbhFYOjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 10:39:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:60806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231792AbhFYOjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 10:39:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D1C4361963;
        Fri, 25 Jun 2021 14:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624631821;
        bh=USEKYSV3MF6RLrnklNByiy9FC4QXCrBJGILk/V/whW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dZ9SxczMeMxo3LnNMVk3zFGWezNK0KVoo2dVRteE4nTQ9UwIogSiiOxp3BvlaOJIo
         obAuIS/KwI2t1mmG7QB45GbaG97Jc43kELdhLw+X+wPLHDVcYwg2ZiIkfZqy+tIbEm
         TlUZgzW4V/MYYT8gPBE43Bdiz2e+l0tMN/+EsqKV3XrBFgPSZMOGWHfK7CZ2CI/jpB
         1ezA50IQuToW/X5jbiQ53wdlo2T5DSwSS1yRoceMyI84Bvm6NmpAsZwi1ZcWRzVdnU
         fgQgLut5BrUSaqBDYZSg584TriSUzKsrqozKhXeNhma8DIyLVEygAWBkyL8OccEOaZ
         o8ZK3mFR9yMKQ==
Received: by pali.im (Postfix)
        id 910DD60E; Fri, 25 Jun 2021 16:37:00 +0200 (CEST)
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
Subject: [PATCH v2 06/11] serial: mvebu-uart: remove unused member nb from struct mvebu_uart
Date:   Fri, 25 Jun 2021 16:36:12 +0200
Message-Id: <20210625143617.12826-7-pali@kernel.org>
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

Member nb in struct mvebu_uart is not set nor read. So remove it completely.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/tty/serial/mvebu-uart.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index f8b0016db847..414e92064ac6 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -128,7 +128,6 @@ struct mvebu_uart {
 	struct uart_port *port;
 	struct clk *clk;
 	int irq[UART_IRQ_COUNT];
-	unsigned char __iomem *nb;
 	struct mvebu_uart_driver_data *data;
 #if defined(CONFIG_PM)
 	struct mvebu_uart_pm_regs pm_regs;
-- 
2.20.1

