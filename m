Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8615457CDD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 11:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237322AbhKTKXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 05:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbhKTKXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 05:23:34 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1545AC061574;
        Sat, 20 Nov 2021 02:20:31 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d27so22638182wrb.6;
        Sat, 20 Nov 2021 02:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LEaW6sQllQeiUAlR7VXlAWH45Q9pIWU2d/TfbfgcPXY=;
        b=i6Z4Z1lM7/46HyWl8T7vlO0nFHyyAHpd9jl5OpLIUO8B01KVgIXrLeSUA7wQm4Hbem
         ebKHl/xU8pj1ugoTomhhh+DBk4oU1ID1iU0JrSdgJj1/vOMRseOy+CVHAt2WUr3g376C
         wo34jNKOwtwGnIp7hLW5Z+0Cw9KCE4M8/u0Q/LpNlc9TJsNSjCi3O66qdqqBd6sdlRF6
         Xxekc+NhqT7xzJdnSVKKcfLOrYVPzJ1awBDHNAA/5KHdZlZAFs3lIPpeK5oMUN2cs8cD
         A457k7+6fXv1W61dffoQ4PjWTV3Ab7j21BeYUtb512FqrK/F0ekK+A/tVdi/dZ6i+V5J
         ks6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LEaW6sQllQeiUAlR7VXlAWH45Q9pIWU2d/TfbfgcPXY=;
        b=xfcOhKMymHYxtADrF8uLkshDPdSkpkshO8OAbjiMYcR+mgaD2B8z3I0tCIr7fNNSU5
         Wg8TWVzlBjjWunhsdHk1qeLwGa80th79uLmhSKfPD7xb4+z+JDgwRVRp/tAixjqy7O/Q
         708PpmY7LmzIh75QCekN3nIs/i+kHAGImWt7chLB8FrJCD7PHZYVLDuPRs0zTF20Dp57
         /DfehDbuuwuIreGo5TPiUFG4fYaN+g/VhQI/8+HqP//rgAurl5CHQKUaXPfrO93HVmME
         EQgt4nwkoz3S2EbiexE+m41OqMOFagw+2BNUE444sDkAdArDoLo8PhRtraBgUtFLL2w9
         y/Dg==
X-Gm-Message-State: AOAM531MIm3vLh5AyHtTduWwB4sJUPaOb3PIekBDXnYcygyapXg74PXp
        v/4D4YWNI5WtcNpKBYqyXFbXYrm4okniaA==
X-Google-Smtp-Source: ABdhPJwHPV8MS0HMq4lqynVHggq/3i0b79h2bOQmtKTpYRNvjsHuJcaimdZUtJQCO2MEHdWtpPSMDw==
X-Received: by 2002:a5d:668f:: with SMTP id l15mr16656879wru.182.1637403629609;
        Sat, 20 Nov 2021 02:20:29 -0800 (PST)
Received: from kista.localdomain (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id j134sm2543534wmj.3.2021.11.20.02.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 02:20:29 -0800 (PST)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH] ARM: dts: sun8i: h3: beelink-x2: Add GPIO CEC node
Date:   Sat, 20 Nov 2021 11:20:24 +0100
Message-Id: <20211120102024.439456-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Beelink X2 doesn't use HW CEC controller found in DW HDMI core. It has
dedicated GPIO pin for that purpose.

Add a node for it.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
index f0e591e1c771..4ab4bbf001ba 100644
--- a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
@@ -57,6 +57,12 @@ aliases {
 		ethernet1 = &sdiowifi;
 	};
 
+	cec-gpio {
+		compatible = "cec-gpio";
+		cec-gpios = <&pio 0 14 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>; /* PA14 */
+		hdmi-phandle = <&hdmi>;
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
-- 
2.34.0

