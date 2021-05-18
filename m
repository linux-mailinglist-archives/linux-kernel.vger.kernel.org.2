Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89AE43873AB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 09:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347373AbhERIAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 04:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241864AbhERIAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 04:00:01 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7642C061760
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 00:58:43 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id a4so9115289wrr.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 00:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5P13XdRJ5R/5Y8xqS3/eplu5G6R3raia4VI6wdvH9Ik=;
        b=nAIosDiI0M9zpMXy6SmYuUyikkN2Y5kzizB4+p6bL4/wXwW5XJNJDGPWDpFnp7wlLk
         JzsGYf5zr/W/7m17ExyVWK98IK9y/BbfFTN6yzvmFJyhlzvyUunbbHgTSAbs35DCFatV
         qn3Rw+ngZJJhZYN60GnE2L9Vfy9hAkKii/YFy1sXXtjB0aKaK7CMdBdLu8lVbuuzAh2z
         Z4MLKQrjbyYAP8eZzIXywV52v6jFL9EoWVNDNH+VL3Z8K/DEQwJ0FdckuCeTfhF+jYwU
         q7vnCZkpPeNAm/3LciIj/uce9L3JiNl28LwOAyD7tBOYVkjyvZJlk2SOOJpJx2pOrFeS
         cjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5P13XdRJ5R/5Y8xqS3/eplu5G6R3raia4VI6wdvH9Ik=;
        b=WmwjWgvYGWDu2WjczAQSee5xaSJstdC7Sc5Rw5q6+H4VCaeOQRjtgS2R86SRM/owB0
         kMVkENLM1ECDi/6nza7P3Sq8/DQExezWiI+1UJDkFMJ9SrfLxdVkBaTDLVhX/kYJHy7V
         kqddHCm//xGK9VGa89HdwLO0gOakszwB4zz0vXuBWmyjEuv4FoI9HCK+ojECFvMklpL/
         tfj3bVObxNWspf+fphgeXpz8jpkJuZ7NYSLmrnhYju2FxFqpv+02VAZ0EG9ezLp8BEX3
         Y3v3og7X47oJrq0QK1nBPQe6GuQmHSU9Wqs+y/KcR131dKaUSaMYX4OYeky38CWw4N8X
         hKrg==
X-Gm-Message-State: AOAM533WJzdeKiNJXa1xuqKYfpmmP6WL952AYKwjVb7zRbdHQT/qOncM
        mw8l8RW1p2B552Y6mc/lcmHtQ5VKTVgb4wNi
X-Google-Smtp-Source: ABdhPJyRndly5u8TalfalAaQOTRDWC6iTH+suIZiJ9ud2vBJ0tW6ZTaoSfgolwkhjrOWeedIvdsnJA==
X-Received: by 2002:a5d:53c4:: with SMTP id a4mr5156417wrw.195.1621324722285;
        Tue, 18 May 2021 00:58:42 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:842:2d82:a1ae:1a91])
        by smtp.gmail.com with ESMTPSA id v16sm735448wml.6.2021.05.18.00.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 00:58:41 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/3] dt-bindings: serial: amlogic,meson-uart: add fifo-size property
Date:   Tue, 18 May 2021 09:58:31 +0200
Message-Id: <20210518075833.3736038-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210518075833.3736038-1-narmstrong@baylibre.com>
References: <20210518075833.3736038-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On most of the Amlogic SoCs, the first UART controller in the "Everything-Else"
power domain has 128bytes of RX & TX FIFO, so add an optional property to describe
a different FIFO size from the other ports (64bytes).

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../devicetree/bindings/serial/amlogic,meson-uart.yaml       | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
index 75ebc9952a99..7487aa6ef849 100644
--- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
@@ -55,6 +55,11 @@ properties:
       - const: pclk
       - const: baud
 
+  fifo-size:
+    description: The fifo size supported by the UART channel.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [64, 128]
+
 required:
   - compatible
   - reg
-- 
2.25.1

