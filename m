Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3973E32732E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 16:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhB1PqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 10:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbhB1PpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 10:45:12 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F97C0617AA
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 07:44:08 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id m6so9771284pfk.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 07:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rm+iWIkQsOJXa+GFU3e3XMxFTQJDqaymZnY4YDsrYw8=;
        b=QCiiXcBMZPgqhQE6cp1APbZ7+JeRtahxDRaJ+GgOzOmsPECn+MNgO7CWxM4eKtd3ZR
         j3KlLyNNs8KO15EElx7Gk+oB3rxldX7MLuVy4OClIWa2Zp175eOSeJF+p5ZSBPoEPCOu
         PzRELASivO76sq3POy4laLzy1077DgxR4uTHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rm+iWIkQsOJXa+GFU3e3XMxFTQJDqaymZnY4YDsrYw8=;
        b=V07nTK0dMEp59aDlYN7T6ROj0KV7VFraEg9Ms2LAX6Tr2qzsziOeDIB/QXbIa6Ll9R
         6EPJm0NcCYPU99NrQcox6CyafevLmYQRE9FVRBs0wkUqedtdGoi5Av0rW1LTaTEzE7lK
         VAhEoP4TwuWuwjE6Yr6H7fNXr4dYtVYAYazK6iouQ15iVcQ+oyG7NTTd7CznT5Oxbfaa
         NpPSj+mPE9QCW8ozqMoFX3B7W3ILad5b2BYVF+8dZVNmrxEEeIryxzflh8bguJjpxzgE
         +MrJyK4g09HiWgff+1NiG2t3QQoUOSDB/xKEWSuD+FAL5thR3T0j1GvRmM/euZJmn84e
         Erog==
X-Gm-Message-State: AOAM530ThD+KdQey0KIr/IuuF4cvcSevb1JPfWDoS3ZexeHSw5VD/jvU
        JhOeK//xp6r88j2R4Bs8uYx1F2vmJTf1OZUQ
X-Google-Smtp-Source: ABdhPJxGafeYO4tUzo5x+Qi+nANpC3U6auTbK1GTueLh4C1TM/nibUaetvyyjsesUnCYDBYjNPjMGg==
X-Received: by 2002:a62:b416:0:b029:1e4:fb5a:55bb with SMTP id h22-20020a62b4160000b02901e4fb5a55bbmr11076393pfn.80.1614527048358;
        Sun, 28 Feb 2021 07:44:08 -0800 (PST)
Received: from ub-XPS-13-9350.domain.name ([103.161.30.225])
        by smtp.gmail.com with ESMTPSA id j3sm13522133pgk.24.2021.02.28.07.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 07:44:08 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 06/10] dt-bindings: arm: stm32: Add Engicam i.Core STM32MP1 C.TOUCH 2.0
Date:   Sun, 28 Feb 2021 21:13:19 +0530
Message-Id: <20210228154323.76911-7-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210228154323.76911-1-jagan@amarulasolutions.com>
References: <20210228154323.76911-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.Core STM32MP1 is an EDIMM SoM based on STM32MP157A from Engicam.

C.TOUCH 2.0 is a general purpose carrier board with capacitive
touch interface support.

i.Core STM32MP1 needs to mount on top of this Carrier board for
creating complete i.Core STM32MP1 C.TOUCH 2.0 board.

Add bindings for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- none 

 Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
index 255d3ba50c63..3e45516403ce 100644
--- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
@@ -65,6 +65,12 @@ properties:
           - const: st,stm32mp157c-ed1
           - const: st,stm32mp157
 
+      - description: Engicam i.Core STM32MP1 SoM based Boards
+        items:
+          - const: engicam,icore-stm32mp1-ctouch2    # STM32MP1 Engicam i.Core STM32MP1 C.TOUCH 2.0
+          - const: engicam,icore-stm32mp1            # STM32MP1 Engicam i.Core STM32MP1 SoM
+          - const: st,stm32mp157
+
       - description: Engicam MicroGEA STM32MP1 SoM based Boards
         items:
           - enum:
-- 
2.25.1

