Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52DF7325E03
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 08:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhBZHGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 02:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhBZHEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 02:04:51 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4AFC061794
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 23:03:40 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id g20so4827437plo.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 23:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aGJzdazEBAezDI/x/kli8lfPFd2whfsSNnz3lbP2G6Q=;
        b=SkvveucUnpwE1M1hka/l+cUi84iB++hyRkY7GhDNwqjas/U7pPVuPX1pv/PJNTv5oi
         P8Vri/a8t9fyVCnw+E8sO5Avo6wOrXlJgcMEgs+gwXPKjTt6SCnP98MRMQ+0eh8PmhCk
         R102uFGs1EHJBkFkkVsr5pr52tR+gi31gbJtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aGJzdazEBAezDI/x/kli8lfPFd2whfsSNnz3lbP2G6Q=;
        b=Y1+2rMe3XTHoPvbSLsLqXfCbDYTB7/0d/yeAG6gGezvpSp6boBrLb/QK9k/KBaJIKl
         uxo5lB0j2nQVCnqPEmxULMhW4mPohzcQe2oHyv6YymClLp33rnEWy+OoBeSkyeyPSANs
         o962kNgMINJ1MFfpFQNEanAwUHkjpwqMP/Ev5vwE3fuqmAGQ/1Gf1RiAH6C590jJveFb
         5RAPhKDjLRdYgfExI9Q8UDPD5BlrwSKR47fgmbLk12A+qClomuJFxkDvc9oACMJlYgBR
         /s5bLBFe7FgInR1cy1NF6JdoajwJMiZqQQCpvVE9+3CAlCgvSnvWdJYYQznC3DldpsMp
         45Qw==
X-Gm-Message-State: AOAM530iu29mrN/hhG+ERl8uRW3VuC0kRVg5iEZgcwZsnHWJczE1FMOR
        qUwLaJviT9HTVhGWgt3jgb7I6g==
X-Google-Smtp-Source: ABdhPJyGhov9zAa2nevNnKEke0RgyaXb5GJd1RqtnKVBRO2Q2cBgHJ78UHhcn2etB4Nk3CGbS0yKbw==
X-Received: by 2002:a17:902:9304:b029:e4:12f4:bdb0 with SMTP id bc4-20020a1709029304b02900e412f4bdb0mr1969411plb.55.1614323020492;
        Thu, 25 Feb 2021 23:03:40 -0800 (PST)
Received: from ub-XPS-13-9350.domain.name ([103.161.30.220])
        by smtp.gmail.com with ESMTPSA id f7sm7592156pjh.45.2021.02.25.23.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 23:03:40 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 04/10] dt-bindings: arm: stm32: Add Engicam MicroGEA STM32MP1 MicroDev 2.0 7" OF
Date:   Fri, 26 Feb 2021 12:32:58 +0530
Message-Id: <20210226070304.8028-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210226070304.8028-1-jagan@amarulasolutions.com>
References: <20210226070304.8028-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MicroGEA STM32MP1 is an EDIMM SoM based on STM32MP157A from Engicam.

MicroDev 2.0 is a general purpose miniature carrier board with CAN,
LTE and LVDS panel interfaces.

7" OF is a capacitive touch 7" Open Frame panel solutions.

MicroGEA STM32MP1 needs to mount on top of MicroDev 2.0 board with
pluged 7" OF for creating complete MicroGEA STM32MP1 MicroDev 2.0
7" Open Frame Solution board.

Add bindings for it.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- collect a-b 

 Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
index 56b7e0b800b3..255d3ba50c63 100644
--- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
@@ -67,7 +67,9 @@ properties:
 
       - description: Engicam MicroGEA STM32MP1 SoM based Boards
         items:
-          - const: engicam,microgea-stm32mp1-microdev2.0
+          - enum:
+              - engicam,microgea-stm32mp1-microdev2.0
+              - engicam,microgea-stm32mp1-microdev2.0-of7
           - const: engicam,microgea-stm32mp1
           - const: st,stm32mp157
 
-- 
2.25.1

