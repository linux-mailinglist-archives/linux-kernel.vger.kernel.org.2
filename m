Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42023714DA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 14:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233989AbhECMBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 08:01:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233870AbhECMBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 08:01:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B41C061363;
        Mon,  3 May 2021 12:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620043208;
        bh=MT2AvRavQJ/I4HrFXTLKARGXGKgehxLNJtxtTCaBlG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P/ITEiLTSVn3bcq6B6gSvdS6UBT8vKHOQHqpyY5oK4pBILciMPbHi2iTBtkq9JyvU
         vlKWJaFzqkOraoiC8QszJnT2I7E7XK3VfCE4cfUb6zuDOg13qprC8vzVnxyCWuEtWh
         d5kGMFANXCgZ6gSS9/AlbNDF5XrxEbyIWoDcJGkY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Atul Gopinathan <atulgopinathan@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 11/69] serial: max310x: unregister uart driver in case of failure and abort
Date:   Mon,  3 May 2021 13:56:38 +0200
Message-Id: <20210503115736.2104747-12-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
References: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Atul Gopinathan <atulgopinathan@gmail.com>

The macro "spi_register_driver" invokes the function
"__spi_register_driver()" which has a return type of int and can fail,
returning a negative value in such a case. This is currently ignored and
the init() function yields success even if the spi driver failed to
register.

Fix this by collecting the return value of "__spi_register_driver()" and
also unregister the uart driver in case of failure.

Cc: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Atul Gopinathan <atulgopinathan@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/max310x.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index a3ba0e6520a1..3cbc757d7be7 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1518,10 +1518,12 @@ static int __init max310x_uart_init(void)
 		return ret;
 
 #ifdef CONFIG_SPI_MASTER
-	spi_register_driver(&max310x_spi_driver);
+	ret = spi_register_driver(&max310x_spi_driver);
+	if (ret)
+		uart_unregister_driver(&max310x_uart);
 #endif
 
-	return 0;
+	return ret;
 }
 module_init(max310x_uart_init);
 
-- 
2.31.1

