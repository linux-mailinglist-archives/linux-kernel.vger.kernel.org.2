Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A083080FA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 23:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhA1WNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 17:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhA1WNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 17:13:41 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6F6C06174A;
        Thu, 28 Jan 2021 14:13:00 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id e15so5747377wme.0;
        Thu, 28 Jan 2021 14:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1GYG0ZYJmnf+AfZO2I60aTtyqOHucRWb5HYQlscUsHI=;
        b=bOdZ4pdSKJ67iR7DiE5bY5U2f1eOEsBz4DjxhJiGtTw5yDK7cKdGf4QWOSFkid/jmK
         F3qnlE23wmH8TW0ptrTmmCwFuW12HA97KrypN6J8MwcatqZT8QtdFkqS2kvTWrpTDBNh
         EpPJHZqj0bKmWex2XurwFcXM5u/0MjWceJbZZIulr3i6JJX4xTfAjv7gWVx5L0AGh84F
         SB5m+Xotv9uain1IELrmlV8HeQl4O0Yqz6wwf8wF349lX1GDAQTKcOspry13Xadba9ch
         bAB0857kYpH5gnftdTp26H5w7MM+HmcajuwhV+U2QLnFurA6D1JOHy9O0in6gt6UJRX1
         qsng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1GYG0ZYJmnf+AfZO2I60aTtyqOHucRWb5HYQlscUsHI=;
        b=JRtpYDNqBaT5LqCdCTirjFby8v72kfn8qGMqd9l+VPESDEnCQo3xXk/rxkHQ6UIDfw
         rRPIM+DT9vJY6YaL5J66SPHc0/LzHEzw+wTZTVC+XvorxlYevKFXRs1QDFrtOSd1mZea
         Mb6JHaYRRJhBQTD/CQBgI0sT50szilugcLgAesziHVAP6cmXFme5lDNuFUPpXcY69Ezh
         /ebHwk4FOEnxTeX2swxf251TJ33fdnHFc6uqOnx9348FK6TGrGEHLCA0SMk3f/Py3CUg
         rGK23daUCkdfRc0VIcwJO1tgJJd7PXXPN7M6dB+Y7whGJXu8lacH/4L9iyCURbgVf7W2
         w41w==
X-Gm-Message-State: AOAM531gktGSPSxNrKTxPngUzZCpWlZ3oOosNr3GLPsCbjLhhwTJpQv5
        /VEfzKm2umlAUa+OHX8C9bk=
X-Google-Smtp-Source: ABdhPJzZW0c5Zagb8SpQvQDMA3Fo9Q+B93S034ohlzeink+cuOmOJiGpzsPl8XWqkTFWvd7M8tS8Og==
X-Received: by 2002:a05:600c:4e91:: with SMTP id f17mr1114553wmq.142.1611871979215;
        Thu, 28 Jan 2021 14:12:59 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd27002d89afd37b57a164.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:2d89:afd3:7b57:a164])
        by smtp.gmail.com with ESMTPSA id c9sm5284110wrw.76.2021.01.28.14.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 14:12:58 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, rikard.falkeborn@gmail.com,
        peter.chen@nxp.com, jun.li@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH 1/2] dt-bindings: phy-imx8mq-usb: add reset-gpios property
Date:   Thu, 28 Jan 2021 23:12:54 +0100
Message-Id: <20210128221255.2673992-1-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an optional GPIO in the dtb description that will
be used to reset the connected hub (if any).

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.txt b/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.txt
index 7c70f2ad9942..6ee2b42e0f22 100644
--- a/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.txt
+++ b/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.txt
@@ -9,6 +9,7 @@ Required properties:
 
 Optional properties:
 - vbus-supply: A phandle to the regulator for USB VBUS.
+- reset-gpios: A phandle to the reset signal of the connected hub (if any).
 
 Example:
 	usb3_phy0: phy@381f0040 {
-- 
2.25.1

