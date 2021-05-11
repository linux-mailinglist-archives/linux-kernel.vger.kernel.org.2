Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 997D537AFD8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 22:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbhEKUDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 16:03:14 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:51999 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbhEKUDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 16:03:10 -0400
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 0733122260;
        Tue, 11 May 2021 22:02:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1620763322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uFF3464Ov8Z2ChbvZV2eQ/PAASkGDOipVGOpBK/usRA=;
        b=jbD1ZW0QbIcCQJfMQ3C4R/nzr7yTNjStcdQ4WkdtYMo+ncOvGTTIHQMCLVUp/VDeqmOeOh
        K/1V3ufzM39ovv1+1ghTGqF/AiA44Ad7N09mVcOwwygxCB63+VnAf3keQis60XY6kI6drM
        vbuP5/rmRKbtenBe7IBxAeI7Eum3WmI=
From:   Michael Walle <michael@walle.cc>
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 2/8] serial: fsl_lpuart: use UARTDATA_MASK macro
Date:   Tue, 11 May 2021 22:01:42 +0200
Message-Id: <20210511200148.11934-3-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210511200148.11934-1-michael@walle.cc>
References: <20210511200148.11934-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the corresponding macro instead of the magic number. While at it,
drop the useless cast to "unsigned char".

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/tty/serial/fsl_lpuart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index fbf2e4d2d22b..b76ddc0d8edc 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -928,9 +928,9 @@ static void lpuart32_rxint(struct lpuart_port *sport)
 		 */
 		sr = lpuart32_read(&sport->port, UARTSTAT);
 		rx = lpuart32_read(&sport->port, UARTDATA);
-		rx &= 0x3ff;
+		rx &= UARTDATA_MASK;
 
-		if (uart_handle_sysrq_char(&sport->port, (unsigned char)rx))
+		if (uart_handle_sysrq_char(&sport->port, rx))
 			continue;
 
 		if (sr & (UARTSTAT_PE | UARTSTAT_OR | UARTSTAT_FE)) {
-- 
2.20.1

