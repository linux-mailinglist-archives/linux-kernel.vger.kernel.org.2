Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C5E33C54E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 19:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhCOSNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 14:13:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46117 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhCOSMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 14:12:41 -0400
Received: from mail-ed1-f72.google.com ([209.85.208.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lLrho-0006Wk-68
        for linux-kernel@vger.kernel.org; Mon, 15 Mar 2021 18:12:40 +0000
Received: by mail-ed1-f72.google.com with SMTP id m8so10666935edv.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 11:12:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c8ribixbYX8SKmA0or3fkXjW13OP+Yed566mFRzrUVg=;
        b=LIMUCmLQgr+8p9ap03vOy+b6w+qvh1cfEBKiWDsV3h+jjkcobcdIS70s3E/2bA8QZR
         iMpaKIQxUHVZCpfKDSenQ2FFwLBw5anGGihTbHvnMqtu1pi7cPnB2M5KR9sz7i8nskG5
         1uQp3oE9io+mWRMK0dYN0UlURn3tgWn6zHrDgw+cM/wnN3Sboq+EzYGQ9a+vcBMAPAHD
         Pqzthx6YFqli9Qb/I3CFoa6iUnY89mq6jMzJLzS7gRbJQvCYupZpatkuoPGl+q6/muOe
         p4Xgq6VGFEiexY0NdDV0Fd/xX1yL/pVnFnsFPOozzit/jtOAEHi3uYkP8t42b0OjwEoG
         BxgA==
X-Gm-Message-State: AOAM5321DIQanZHntUyGwQH7t4hiJupNTNBoAydAr2z6PePdLEKx2HMu
        iTjI/aRvHzfhkUL6L6BQP8mwGk08sj9m6f27VnkGhxSURQNlDK3iR19eN2hr+gH05Y6hf6Rf14e
        2/nTpoieSSrXIQFaa0fgatAfagu1WdGDeUelCqU6i7g==
X-Received: by 2002:a17:906:151a:: with SMTP id b26mr5342973ejd.492.1615831959910;
        Mon, 15 Mar 2021 11:12:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLNjczp4bktcKOOXDHSL62TIadcqezY+3FpRHHLlaOEd82iwOk0aGnz/RtbQcwfWXJ/Okoww==
X-Received: by 2002:a17:906:151a:: with SMTP id b26mr5342963ejd.492.1615831959799;
        Mon, 15 Mar 2021 11:12:39 -0700 (PDT)
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id v25sm8523926edr.18.2021.03.15.11.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 11:12:39 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     marcan@marcan.st, arnd@kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH] tty: serial: samsung_tty: remove spinlock flags in interrupt handlers
Date:   Mon, 15 Mar 2021 19:12:12 +0100
Message-Id: <20210315181212.113217-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since interrupt handler is called with disabled local interrupts, there
is no need to use the spinlock primitives disabling interrupts as well.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/tty/serial/samsung_tty.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 80df842bf4c7..d9e4b67a12a0 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -715,13 +715,12 @@ static irqreturn_t s3c24xx_serial_rx_chars_dma(void *dev_id)
 	struct s3c24xx_uart_dma *dma = ourport->dma;
 	struct tty_struct *tty = tty_port_tty_get(&ourport->port.state->port);
 	struct tty_port *t = &port->state->port;
-	unsigned long flags;
 	struct dma_tx_state state;
 
 	utrstat = rd_regl(port, S3C2410_UTRSTAT);
 	rd_regl(port, S3C2410_UFSTAT);
 
-	spin_lock_irqsave(&port->lock, flags);
+	spin_lock(&port->lock);
 
 	if (!(utrstat & S3C2410_UTRSTAT_TIMEOUT)) {
 		s3c64xx_start_rx_dma(ourport);
@@ -750,7 +749,7 @@ static irqreturn_t s3c24xx_serial_rx_chars_dma(void *dev_id)
 	wr_regl(port, S3C2410_UTRSTAT, S3C2410_UTRSTAT_TIMEOUT);
 
 finish:
-	spin_unlock_irqrestore(&port->lock, flags);
+	spin_unlock(&port->lock);
 
 	return IRQ_HANDLED;
 }
@@ -846,11 +845,10 @@ static irqreturn_t s3c24xx_serial_rx_chars_pio(void *dev_id)
 {
 	struct s3c24xx_uart_port *ourport = dev_id;
 	struct uart_port *port = &ourport->port;
-	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	spin_lock(&port->lock);
 	s3c24xx_serial_rx_drain_fifo(ourport);
-	spin_unlock_irqrestore(&port->lock, flags);
+	spin_unlock(&port->lock);
 
 	return IRQ_HANDLED;
 }
@@ -934,13 +932,12 @@ static irqreturn_t s3c24xx_serial_tx_irq(int irq, void *id)
 {
 	struct s3c24xx_uart_port *ourport = id;
 	struct uart_port *port = &ourport->port;
-	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	spin_lock(&port->lock);
 
 	s3c24xx_serial_tx_chars(ourport);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	spin_unlock(&port->lock);
 	return IRQ_HANDLED;
 }
 
-- 
2.25.1

