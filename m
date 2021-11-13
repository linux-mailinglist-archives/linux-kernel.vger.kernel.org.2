Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E528E44F2ED
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 12:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235851AbhKML5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 06:57:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:55876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234372AbhKML53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 06:57:29 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C9586113A;
        Sat, 13 Nov 2021 11:54:37 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mlrcB-005BG2-7K; Sat, 13 Nov 2021 11:54:35 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 2/8] dt-bindings: apple,aic: Add CPU PMU per-cpu pseudo-interrupts
Date:   Sat, 13 Nov 2021 11:54:23 +0000
Message-Id: <20211113115429.4027571-3-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211113115429.4027571-1-maz@kernel.org>
References: <20211113115429.4027571-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, will@kernel.org, marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io, robh+dt@kernel.org, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Advertise the two pseudo-interrupts that tied to the two PMU
flavours present in the Apple M1 SoC.

We choose the expose two different pseudo-interrupts to the OS
as the e-core PMU is obviously different from the p-core one,
effectively presenting two different devices.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 .../devicetree/bindings/interrupt-controller/apple,aic.yaml     | 2 ++
 include/dt-bindings/interrupt-controller/apple-aic.h            | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
index cf6c091a07b1..b95e41816953 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
@@ -56,6 +56,8 @@ properties:
           - 1: virtual HV timer
           - 2: physical guest timer
           - 3: virtual guest timer
+          - 4: 'efficient' CPU PMU
+          - 5: 'performance' CPU PMU
 
       The 3rd cell contains the interrupt flags. This is normally
       IRQ_TYPE_LEVEL_HIGH (4).
diff --git a/include/dt-bindings/interrupt-controller/apple-aic.h b/include/dt-bindings/interrupt-controller/apple-aic.h
index 604f2bb30ac0..bf3aac0e5491 100644
--- a/include/dt-bindings/interrupt-controller/apple-aic.h
+++ b/include/dt-bindings/interrupt-controller/apple-aic.h
@@ -11,5 +11,7 @@
 #define AIC_TMR_HV_VIRT		1
 #define AIC_TMR_GUEST_PHYS	2
 #define AIC_TMR_GUEST_VIRT	3
+#define AIC_CPU_PMU_E		4
+#define AIC_CPU_PMU_P		5
 
 #endif
-- 
2.30.2

