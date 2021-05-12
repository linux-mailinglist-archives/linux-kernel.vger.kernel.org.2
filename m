Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28E237BF8F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 16:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhELOPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 10:15:19 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:59523 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbhELOOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 10:14:17 -0400
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id D17C42226D;
        Wed, 12 May 2021 16:13:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1620828788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aD8CNHQQPQk+RYYnZax5l7oYjvuKmQC8FcB0mIvAWQs=;
        b=umKFCDCCuRwm4ZZiCCZeQjq6Plr263a9/5eQLPJYCRNWVlKq5ikC6YHouIXK74Fssx5AIH
        7HbiN9Ry/ZDwMB5sKvqHH0tkKqe5indIrik1aHhtE4Yzdmd9dLMeYmhH7D/Rvwxc810jmw
        ZkpXxuQmRR6JgY+To8HNNgETTrz7m40=
From:   Michael Walle <michael@walle.cc>
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        Johan Hovold <johan@kernel.org>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 6/9] serial: fsl_lpuart: remove RTSCTS handling from get_mctrl()
Date:   Wed, 12 May 2021 16:12:52 +0200
Message-Id: <20210512141255.18277-7-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210512141255.18277-1-michael@walle.cc>
References: <20210512141255.18277-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wrong code in set_mctrl() was already removed in commit 2b30efe2e88a
("tty: serial: lpuart: Remove unnecessary code from set_mctrl"), but the
code in get_mctrl() wasn't removed. It will not return the state of the
RTS or CTS line but whether automatic flow control is enabled, which is
wrong for the get_mctrl(). Thus remove it.

Fixes: 2b30efe2e88a ("tty: serial: lpuart: Remove unnecessary code from set_mctrl")
Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/tty/serial/fsl_lpuart.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index c76bdb855ba9..5b32d48bee56 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1418,17 +1418,7 @@ static unsigned int lpuart_get_mctrl(struct uart_port *port)
 
 static unsigned int lpuart32_get_mctrl(struct uart_port *port)
 {
-	unsigned int temp = 0;
-	unsigned long reg;
-
-	reg = lpuart32_read(port, UARTMODIR);
-	if (reg & UARTMODIR_TXCTSE)
-		temp |= TIOCM_CTS;
-
-	if (reg & UARTMODIR_RXRTSE)
-		temp |= TIOCM_RTS;
-
-	return temp;
+	return 0;
 }
 
 static void lpuart_set_mctrl(struct uart_port *port, unsigned int mctrl)
-- 
2.20.1

