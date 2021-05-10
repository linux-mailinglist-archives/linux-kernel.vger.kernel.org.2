Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52D3379432
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 18:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhEJQic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 12:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbhEJQib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 12:38:31 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9201C061761;
        Mon, 10 May 2021 09:37:24 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id y124-20020a1c32820000b029010c93864955so11529124wmy.5;
        Mon, 10 May 2021 09:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=azFO5ST2Nn2MQauTLMiqCfhjldm/wHJbC2Icruyek7s=;
        b=qUbwdwHV8iU3Hs2PvJt0bUxjTD+9Pp6RQaIz8ON4YBbuEaaQQi4Ea21kIlbRV2HFJ1
         GX0zf57HtFNYCGCY/hiYDhf81TgdJLATSOUSO2gG65d1gais6S3ScJU2VAaRZs5zp1GJ
         dYO2DWD/8xbH9MT2GPOYd1FK5C2hACQDFwYwTU3LfesuL93O05g5y9rLV3HSC4kej3Z5
         DtAAwreS5RIzSRSQ4foePi+u8i1DFzRRiT8yPX96WjVR5COv0DnCYQIfNSWJoqj4GI7h
         BCSpR7covmbavfN1nCeDc0vpWJezob0AxIKFmH7ymwBCOjwsAJyOQM3TREGXGi+ri8BV
         JKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=azFO5ST2Nn2MQauTLMiqCfhjldm/wHJbC2Icruyek7s=;
        b=uJj44jk3QTo22C5DoBDjCWmrLgyWf7xBmDpH/t6nMfUo2Eov3PxO04gbXvELc84SYi
         +4oCn5Is1QbpmETT/kFJZ2AC6ncbM0OFj48995W/Gqexo+gu3WukV+eUdDsksx54JneA
         HFclHXpzKXJXlXTjY6fP/JMjQuowvH1u/0mk/o7FBB29DGk72FoEtEJSEQEztoxJAIz5
         d8aZfJNNmRL8JyzAwEGNXYngtoMFYn3RlNQjFglpkyH9U3DhB89fpZk2VziEFGVRPil1
         ukFzPHahTdn7DvlFZA7wpHIJSgtOYrm2VL5Rj8chbQXR3/2uz0DDtjG4P6rDl2xE8wsA
         3jVQ==
X-Gm-Message-State: AOAM533UPnFTRHmn+lNeHZ+8ZG1KcKxUDi/GbC6w/07O5x89SgjfyvB0
        w1GPZZbmuHgyS32J3zGWNWk=
X-Google-Smtp-Source: ABdhPJwMv8QoW5gXAbJ+zle4pP74S96CpwWQk5lyg9rQS1WkUZe5HzIxh1SY2zcBknhRWJo0kgtfcg==
X-Received: by 2002:a1c:e345:: with SMTP id a66mr37904184wmh.109.1620664643727;
        Mon, 10 May 2021 09:37:23 -0700 (PDT)
Received: from kista.localdomain (cpe-86-58-17-133.cable.triera.net. [86.58.17.133])
        by smtp.gmail.com with ESMTPSA id s10sm22775253wru.55.2021.05.10.09.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 09:37:23 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, jernej.skrabec@gmail.com
Subject: [PATCH] ARM: dts: sun8i: r40: Add timer node
Date:   Mon, 10 May 2021 18:36:47 +0200
Message-Id: <20210510163647.2731675-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner R40 has a timer.

Add a node for it.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 arch/arm/boot/dts/sun8i-r40.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index 03e054c0bac4..291f4784e86c 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -691,6 +691,18 @@ uart7_pi_pins: uart7-pi-pins {
 			};
 		};
 
+		timer@1c20c00 {
+			compatible = "allwinner,sun4i-a10-timer";
+			reg = <0x01c20c00 0x90>;
+			interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc24M>;
+		};
+
 		wdt: watchdog@1c20c90 {
 			compatible = "allwinner,sun4i-a10-wdt";
 			reg = <0x01c20c90 0x10>;
-- 
2.31.1

