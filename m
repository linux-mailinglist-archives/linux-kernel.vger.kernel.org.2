Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F09833ADA8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 09:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhCOIfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 04:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbhCOIfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 04:35:04 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D314C061762
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 01:35:03 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so15958354wmj.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 01:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4O/Pa9QoYF77T5Q9QdbcadRQvPAdN3INVfdUHWaUtt8=;
        b=X+QUFVzKkQbG1ViUEZ3ss5XSu9heNtdx5TJHJrU1CiqtByufNS4VrOXAvqk+I5bdR2
         em6RSTaKU9idqiQITHDzc/DtiLlLvKYg/uBLAmPPmR/IkaXePdP9iIX9HdsWNYFpEaVv
         5dGrwHCoVJMiWt0PpoSUZH8sU4eNdWw2W/IqmLN96S4abciDPztuzn4k/buBj7xHJpRS
         cSvv4WbCBojzRz3STHiTyDwHgO6NrShwOGryzZ7HaEkv8mxpKJToLcx5avhbZcla8VTD
         uSmZAaVVomd281PQ00gMbDzr9ndev8s4cn7DzY+yfjMmDHs7ZLMKm0UC6kBDHSsefrtu
         Ea0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4O/Pa9QoYF77T5Q9QdbcadRQvPAdN3INVfdUHWaUtt8=;
        b=Jpnx25F7+LHgPt94hvWclTa/aBeX4pkf6gSfjxdIC9q9QA2q7FzXf6vM/DDnM4Rz1B
         7Pxd6/Xrt74t16TRxzY1dvx3cv1dvJd304v7YPIQP8fqHSikjE3SnjOiLvUa/9Wm/6CG
         +43uTTLQNw95x/Xf/KASFpngRlkPukEb84PPwRassbA5aprZLpWj0OCf6E9ocOMfkIHH
         YsHNWFIMN3oTYJWtO/UGfXQE9u4J2f7u9XmqRSU0E7BD8O4G7v4252bq82KszR7iG9Od
         be9pGG3MTv0y3BS/iICT9kjY4a/wMovTqhSyJJlnQ3eFfU/GJvTqDv85P8i6VEJe4y0F
         rTVQ==
X-Gm-Message-State: AOAM531hTrxgnQEG2BA28RYIXaen4WwxQbWI3Wxv8nnjMjij8eq+rTaV
        vMYk+sSK9Z/15MbSFB+/bYv7Hg==
X-Google-Smtp-Source: ABdhPJy3UE503fgAhTS0RzBbZfuwhb5FPKRFm4Jpd51LGdchtrvmRVxO/iaQkDxynO+Xstf/56XjoQ==
X-Received: by 2002:a05:600c:210a:: with SMTP id u10mr25166362wml.147.1615797302244;
        Mon, 15 Mar 2021 01:35:02 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:708f:15aa:638c:22b7])
        by smtp.gmail.com with ESMTPSA id o2sm8372028wmc.23.2021.03.15.01.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 01:35:01 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/3] tty: serial: meson: retrieve port FIFO size from DT
Date:   Mon, 15 Mar 2021 09:34:58 +0100
Message-Id: <20210315083459.359773-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210315083459.359773-1-narmstrong@baylibre.com>
References: <20210315083459.359773-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the DT bindings has a property to get the FIFO size for a particular port,
retrieve it and use to setup the FIFO interrupts threshold.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/tty/serial/meson_uart.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 69eeef9edfa5..7244b12aefab 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -717,6 +717,7 @@ static int meson_uart_probe(struct platform_device *pdev)
 {
 	struct resource *res_mem, *res_irq;
 	struct uart_port *port;
+	u32 fifosize = 64; /* Default is 64, 128 for EE UART_0 */
 	int ret = 0;
 	int id = -1;
 
@@ -743,6 +744,8 @@ static int meson_uart_probe(struct platform_device *pdev)
 	if (!res_irq)
 		return -ENODEV;
 
+	of_property_read_u32(pdev->dev.of_node, "amlogic,uart-fifosize", &fifosize);
+
 	if (meson_ports[pdev->id]) {
 		dev_err(&pdev->dev, "port %d already allocated\n", pdev->id);
 		return -EBUSY;
@@ -772,7 +775,7 @@ static int meson_uart_probe(struct platform_device *pdev)
 	port->type = PORT_MESON;
 	port->x_char = 0;
 	port->ops = &meson_uart_ops;
-	port->fifosize = 64;
+	port->fifosize = fifosize;
 
 	meson_ports[pdev->id] = port;
 	platform_set_drvdata(pdev, port);
-- 
2.25.1

