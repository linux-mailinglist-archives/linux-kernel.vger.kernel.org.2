Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 500DA34955F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 16:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhCYPYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 11:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhCYPYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 11:24:20 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE328C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 08:24:19 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id o16so2750247wrn.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 08:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1E9sF10HVEC86a98PFuWKJ9Mp74ZD46Q6KDRkjpEZM4=;
        b=aEGht26bWiYnI/bWudlTQ+gOMbnqlc8w4EQYhzEYVrx5udt6E6ps2sXMD48X2qbsuN
         y92CKzFQ9Lfb8SpbMUm3rcp2ThcEH0FaGHeaxY3COdRc4qxVYh2Bm3XOPeNiqikr5qkc
         uEgrrkIW+YBt/eVRSDBIg3Y/89i1G3WhHly8noKVLeJlcIdUBJ8GVIOE554/CSvgCgLp
         Wo+iyNx8hQ/b3ZRUsfpWOvuxp4K49Cw/wYZdUP1KbYDm7dWS6ArLmmlvY72HE0kXdMOG
         xKFKIuv4I1jXPPoNKtLE+0EmWepzGjCa/YkCJ3QCbDNX1Jpp5u1avM3aFMiR9PYO6yO3
         gdJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1E9sF10HVEC86a98PFuWKJ9Mp74ZD46Q6KDRkjpEZM4=;
        b=sPA9XlEavqdH5Yk9XpZ6gWUf4YP0MZj/YLxELiAMgsNVOOZ/ZLDCI9QZ6i6xfWcWaA
         xi/2Y2LxG+rPxz+ihIGA3McUdb2YjvTmyflrlB4j7U4/+9uW0f0QR3+bYOH7XtOaIn6f
         LgVa7+uz7sI3ji5g/61CYkj+paIuYtInl8UPaxoo8US55ZRwu+8K6OQ6gttq437rPxZB
         QzUwTY+a4yq6doBrjxPGEIJ+2DOyTYLDNW3PtpClxn6AiXdUrEFE3bd9gTt2LLqYXrFc
         7XaZIrnX9vr0YNZPYX0dv3JpsLgXon+ld+NlnDxMti25YdWExE3h88PI6BOGYxai4V8o
         y5PQ==
X-Gm-Message-State: AOAM531tG/Q8ZgkdQegnNALJWQZwaWt6bo9KDW0AlO/U63YXqx+luuPZ
        KrfGCjfqVR9UFfIUbXFC8HaWBQ==
X-Google-Smtp-Source: ABdhPJzqTDL4lVT0INpPHTS+dzfkxTVO9rRKAg7IxpMLVWIsTbtXmKcT+OazzGEAYTUZL1Wj1b51hA==
X-Received: by 2002:a5d:4d8d:: with SMTP id b13mr9433139wru.259.1616685858371;
        Thu, 25 Mar 2021 08:24:18 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:b105:9672:b0a:5820])
        by smtp.gmail.com with ESMTPSA id p18sm7395260wrs.68.2021.03.25.08.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:24:17 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 1/3] dt-bindings: serial: amlogic,meson-uart: add fifo-size property
Date:   Thu, 25 Mar 2021 16:24:08 +0100
Message-Id: <20210325152410.1795557-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210325152410.1795557-1-narmstrong@baylibre.com>
References: <20210325152410.1795557-1-narmstrong@baylibre.com>
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
 .../devicetree/bindings/serial/amlogic,meson-uart.yaml      | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
index 75ebc9952a99..8ece7f420c19 100644
--- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
@@ -55,6 +55,12 @@ properties:
       - const: pclk
       - const: baud
 
+
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

