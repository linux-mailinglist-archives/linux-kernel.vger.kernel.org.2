Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3911B37AFD4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 22:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhEKUDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 16:03:12 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:50069 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhEKUDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 16:03:09 -0400
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 50CD22225B;
        Tue, 11 May 2021 22:02:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1620763321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JAJPgRblRiNhiOC7XlWvYpG23ZdxlO3ho2zd+PjduLM=;
        b=JKiczDa1zrIa+tzPoTxkHRQeIltH5Ct328qsK49+judAXRkwtMI0yPynV972ig6lrL5GUz
        HQbp9Skh24peAUHLSOGKyshWaqqmV9/hUOGizxHuIZUvJTji03njgYfepkgablk1Lm7RJw
        bJYlJE1n1fVzmbqaAIvKm1YmwKLbh5M=
From:   Michael Walle <michael@walle.cc>
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 1/8] serial: fsl_lpuart: don't modify arbitrary data on lpuart32
Date:   Tue, 11 May 2021 22:01:41 +0200
Message-Id: <20210511200148.11934-2-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210511200148.11934-1-michael@walle.cc>
References: <20210511200148.11934-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lpuart_rx_dma_startup() is used for both the 8 bit and the 32 bit
version of the LPUART. Modify the UARTCR only for the 8 bit version.

Fixes: f4eef224a09f ("serial: fsl_lpuart: add sysrq support when using dma")
Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/tty/serial/fsl_lpuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 794035041744..fbf2e4d2d22b 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1625,7 +1625,7 @@ static void lpuart_rx_dma_startup(struct lpuart_port *sport)
 	sport->lpuart_dma_rx_use = true;
 	rx_dma_timer_init(sport);
 
-	if (sport->port.has_sysrq) {
+	if (sport->port.has_sysrq && !lpuart_is_32(sport)) {
 		cr3 = readb(sport->port.membase + UARTCR3);
 		cr3 |= UARTCR3_FEIE;
 		writeb(cr3, sport->port.membase + UARTCR3);
-- 
2.20.1

