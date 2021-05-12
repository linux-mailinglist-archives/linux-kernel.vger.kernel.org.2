Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A4137BF8C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 16:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhELOOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 10:14:48 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:43327 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbhELOOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 10:14:16 -0400
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 833BE22268;
        Wed, 12 May 2021 16:13:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1620828787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QxeVxBSNPd9X+FwB7w/uW8Ipt1KaSSCH/Y0I4/zPuaY=;
        b=fhp7HGPHKnK9gZ4PIM3+TNWwi70Qu3mg0W7BSJCbbjNRSuh8YCoA7YledPdHBX/iPhI5T5
        NiN3Eox1DdGdYsxLDDfBDZB+9Ve5yfuNISqacV8ce4og6YGpsd8kSlRjT1OKU5dJ3ka0Hm
        /V77A37kN/SD7AnEF+InRyZJbsUYBrs=
From:   Michael Walle <michael@walle.cc>
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        Johan Hovold <johan@kernel.org>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 5/9] serial: fsl_lpuart: handle break and make sysrq work
Date:   Wed, 12 May 2021 16:12:51 +0200
Message-Id: <20210512141255.18277-6-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210512141255.18277-1-michael@walle.cc>
References: <20210512141255.18277-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although there is already sysrq characters handling, a break condition
was never detected. Add support for it.

The LPUART can't distinguish between a framing error and a break
condition. We assume it is a break if the received data is all zero.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/tty/serial/fsl_lpuart.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 63a1dac7c3aa..c76bdb855ba9 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -910,6 +910,7 @@ static void lpuart32_rxint(struct lpuart_port *sport)
 	unsigned int flg, ignored = 0;
 	struct tty_port *port = &sport->port.state->port;
 	unsigned long rx, sr;
+	bool is_break;
 
 	spin_lock(&sport->port.lock);
 
@@ -924,14 +925,27 @@ static void lpuart32_rxint(struct lpuart_port *sport)
 		rx = lpuart32_read(&sport->port, UARTDATA);
 		rx &= UARTDATA_MASK;
 
+		/*
+		 * The LPUART can't distinguish between a break and a framing error,
+		 * thus we assume it is a break if the received data is zero.
+		 */
+		is_break = (sr & UARTSTAT_FE) && !rx;
+
+		if (is_break && uart_handle_break(&sport->port))
+			continue;
+
 		if (uart_prepare_sysrq_char(&sport->port, rx))
 			continue;
 
 		if (sr & (UARTSTAT_PE | UARTSTAT_OR | UARTSTAT_FE)) {
-			if (sr & UARTSTAT_PE)
-				sport->port.icount.parity++;
-			else if (sr & UARTSTAT_FE)
+			if (sr & UARTSTAT_PE) {
+				if (is_break)
+					sport->port.icount.brk++;
+				else
+					sport->port.icount.parity++;
+			} else if (sr & UARTSTAT_FE) {
 				sport->port.icount.frame++;
+			}
 
 			if (sr & UARTSTAT_OR)
 				sport->port.icount.overrun++;
@@ -944,15 +958,17 @@ static void lpuart32_rxint(struct lpuart_port *sport)
 
 			sr &= sport->port.read_status_mask;
 
-			if (sr & UARTSTAT_PE)
-				flg = TTY_PARITY;
-			else if (sr & UARTSTAT_FE)
+			if (sr & UARTSTAT_PE) {
+				if (is_break)
+					flg = TTY_BREAK;
+				else
+					flg = TTY_PARITY;
+			} else if (sr & UARTSTAT_FE) {
 				flg = TTY_FRAME;
+			}
 
 			if (sr & UARTSTAT_OR)
 				flg = TTY_OVERRUN;
-
-			sport->port.sysrq = 0;
 		}
 
 		tty_insert_flip_char(port, rx, flg);
-- 
2.20.1

