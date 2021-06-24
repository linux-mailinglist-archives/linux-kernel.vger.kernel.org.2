Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD6A3B398A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 00:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbhFXWwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 18:52:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:54632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232898AbhFXWwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 18:52:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 900E96135C;
        Thu, 24 Jun 2021 22:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624574997;
        bh=USEKYSV3MF6RLrnklNByiy9FC4QXCrBJGILk/V/whW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ibY3PNADxmcGPae9zhziFcWeTm6M6h4wpoRFHkCNviC3UiEYjIIrDeiq5vVg7LJES
         o3tDfbIWnfvTiSwtFb5BI5buWadAuu3mdBBuDgIq7PFQbfYjn1SRRCA76fVDCBnZQX
         VAIh08rDYnuvJQwSaRj3KJbxT6kDRGEbfRkrfJujEwim55vExQxokoxImPodIzc7YA
         y5Y7E2K38NL1LNvW6+XXLfp7BwHWj6c5BSF/K7/X3A5UVvYW7xoMY9GnYEFKdrev3P
         sm2zCaVvscnn6JSuQ8rUXN0T/IutkQVMoyvGNQhTuWyc3YoihK4tbG1w+K5V3EReda
         ghELCaf8DkwUg==
Received: by pali.im (Postfix)
        id 4BA498A3; Fri, 25 Jun 2021 00:49:57 +0200 (CEST)
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
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 06/10] serial: mvebu-uart: remove unused member nb from struct mvebu_uart
Date:   Fri, 25 Jun 2021 00:49:05 +0200
Message-Id: <20210624224909.6350-7-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210624224909.6350-1-pali@kernel.org>
References: <20210624224909.6350-1-pali@kernel.org>
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

