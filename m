Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC77B327321
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 16:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhB1Pog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 10:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbhB1Pob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 10:44:31 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F305C061788
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 07:43:45 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id e9so9862537pjj.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 07:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OhHoaAc908YGCrOivRRjATckooWceYbaO17T4MROb8E=;
        b=hWTIya6fV8QafabjWHwFKCFrder2AqZhaL9y3XRoT8m+KYpxrofvTyQMW5xMC9D/jf
         +LFWmV4wh2UQGc5e8FGTUV3uR1GJ2tsZSi/doqlp8YJxks69FeV3hGx13N8+/G12nT0S
         laBlSYeBJj82znYZoxhH0vhLyOrVAOf/cdjLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OhHoaAc908YGCrOivRRjATckooWceYbaO17T4MROb8E=;
        b=I4OsNIWM7cvbzbc66rQ9FAzfiJx7jx0Uh1rZ04YwWmx/IabQ+2jqKYUkHjaQkywT2S
         xjbyvny813+IBak9429avhuc4v0TDnK3bKAdJM89esdfIdgl8wLTT+Tp1yvXMmU262Dm
         GYvHWnI21E5DE1/oqdVprtJx0j6BllVKFU8Y43K/8ilM4a/Qf/vX5k1gIK7Z7N789Thi
         6pLPU6Fwu8Q7qKpJPXuXt8tiSE7JyiTaXTbIa7IRFrhswUFmdJchETa9jNMOuRq6Mcjf
         HvlcD3iPfVg0/FkhxvDoUGrM7oBa2toVL1zFyVYnJHN7wXAq62Iz7XoOI/4X49En25lG
         zQ/A==
X-Gm-Message-State: AOAM5315o33bXmuRTPnL5SzarGXAtj7hIQ+7C3Ak3nWMF6JbUBZGfP7S
        CAhDu16OCyEqUUVB+jYbnYpWEQ==
X-Google-Smtp-Source: ABdhPJxYnlP3oakIHukHfbf/OdhxGzvpAbg0ms/Mom97T/YMvB+mEJrLmVG4JMawtHjQkNc2rhtvQg==
X-Received: by 2002:a17:902:7286:b029:e3:cec5:f0cb with SMTP id d6-20020a1709027286b02900e3cec5f0cbmr11608677pll.70.1614527024617;
        Sun, 28 Feb 2021 07:43:44 -0800 (PST)
Received: from ub-XPS-13-9350.domain.name ([103.161.30.225])
        by smtp.gmail.com with ESMTPSA id j3sm13522133pgk.24.2021.02.28.07.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 07:43:44 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 01/10] dt-bindings: arm: stm32: Add Engicam MicroGEA STM32MP1 MicroDev 2.0
Date:   Sun, 28 Feb 2021 21:13:14 +0530
Message-Id: <20210228154323.76911-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210228154323.76911-1-jagan@amarulasolutions.com>
References: <20210228154323.76911-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MicroGEA STM32MP1 is a STM32MP157A based Micro SOM.

MicroDev 2.0 is a general purpose miniature carrier board with CAN,
LTE and LVDS panel interfaces.

MicroGEA STM32MP1 needs to mount on top of this MicroDev 2.0 board
for creating complete MicroGEA STM32MP1 MicroDev 2.0 Carrier board.

Add bindings for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- updated commit message
Changes for v2:
- none

 Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
index e7525a3395e5..56b7e0b800b3 100644
--- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
@@ -64,6 +64,13 @@ properties:
           - const: st,stm32mp157c-ev1
           - const: st,stm32mp157c-ed1
           - const: st,stm32mp157
+
+      - description: Engicam MicroGEA STM32MP1 SoM based Boards
+        items:
+          - const: engicam,microgea-stm32mp1-microdev2.0
+          - const: engicam,microgea-stm32mp1
+          - const: st,stm32mp157
+
       - description: Octavo OSD32MP15x System-in-Package based boards
         items:
           - enum:
-- 
2.25.1

