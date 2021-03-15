Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73FB33ADA7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 09:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhCOIfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 04:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbhCOIfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 04:35:02 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EF4C061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 01:35:02 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so15958320wmj.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 01:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h/Gkz5RJgx9sQ9b5NmpdOjRc9DJkyI918kN+6MDqa88=;
        b=pjzaBNJa/Cp5phiQwo5PRMNYoWo6/wuEFJl1pKg6/K5/G0qyxPc1TflAYa2B4876Aa
         9W6uiziwIiAXf6WueesYR99qLSwPGeXltfm5YPSNtVQj+mTrFUfRWuJWF6Fsfwo0HeaZ
         ZjStNW543/Qg6svtOW8WV/o8CiHpsZp3lh/jAdmUJ2+98KDNiSfmWT0gVlqzbF5gxWE3
         OC/n0slCAHgSC4T8SWBNcDHavvcoDLgH0RRx1+QaknM8ApANZw5SM0b5DOHMkXe1yGQD
         0zCWQNarmtMLf+yfToY8IYbF84u13FaE+vKOVpJAJNHUeImSNoSmBr9GB48qzqDG/7M0
         8R7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h/Gkz5RJgx9sQ9b5NmpdOjRc9DJkyI918kN+6MDqa88=;
        b=mn3THbe8g1+Koqennu6ZAORgyyWNpbJe/mZ43ijSCE0e0j4skE+0hsGDHwWK+xdrro
         bEjjjXJWNc+kjRUKulTbvX/FhWVK/HI8I9Fk1UeNBAszfE2AVhNYzUT/XtUft7rvP0zH
         Zk+NulvE9dDlAVqBRohXMGsbvQADC43V6rALX9vJjUoLQYgkQS/S+mlAkoS4jdbtyuy4
         8lr118+XJwq0Wkt9L9gwNN/62Aulv6hzsTmngKGkCmIEMDFLgiUaLTrm6enPY7YJ/UiP
         8YymwRfnd0fxQZAh2QK9cAs1tKprtS0UAkEI/7zT+U/GYJpnv5NxkqkqFt2dJktL6wNR
         AuRQ==
X-Gm-Message-State: AOAM530q+eDostQvf5Rr4yVFJcluuRa/rQmcG/Pqn/P/8UFRccZqlI7I
        64oFX3WJ8JpqHFPShck/TYIUhg==
X-Google-Smtp-Source: ABdhPJxkvfTQ4A0oqVxQTXvK6iCVYYqj/CHlIUOzPNQx4tTvdjm1Iu18EVe2v3EEEUNlrUPdl0x/hA==
X-Received: by 2002:a7b:cdf7:: with SMTP id p23mr25061709wmj.26.1615797301209;
        Mon, 15 Mar 2021 01:35:01 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:708f:15aa:638c:22b7])
        by smtp.gmail.com with ESMTPSA id o2sm8372028wmc.23.2021.03.15.01.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 01:35:00 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 1/3] dt-bindings: serial: amlogic,meson-uart: add amlogic,uart-fifosize property
Date:   Mon, 15 Mar 2021 09:34:57 +0100
Message-Id: <20210315083459.359773-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210315083459.359773-1-narmstrong@baylibre.com>
References: <20210315083459.359773-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On most of the Amlogic SoCs, the first UART controller in the "Everything-Else"
power domain has 128bytes of RX & TX FIFO, so add an optional property to describe
a different FIFO size from the other ports (64bytes).

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../devicetree/bindings/serial/amlogic,meson-uart.yaml      | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
index 75ebc9952a99..e0a742112783 100644
--- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
@@ -55,6 +55,12 @@ properties:
       - const: pclk
       - const: baud
 
+
+  amlogic,uart-fifosize:
+    description: The fifo size supported by the UART channel.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [64, 128]
+
 required:
   - compatible
   - reg
-- 
2.25.1

