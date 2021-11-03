Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA19A443EE4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 10:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbhKCJFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 05:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbhKCJFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 05:05:41 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BF5C06120A
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 02:03:04 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id f3so3711891lfu.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 02:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l1pD+W54nOd1j1DXeZbD9xPUudJRVhA/hpogE5bgZ98=;
        b=W5gPWqqL/vTOCl0ikB/He/Iy6BoWQ0Gn8ugg0PNm8wupYGpo3e3eYLEgb8FY7ldvGX
         SRZwUJZfVue7mJEnOViHYc5X47Nq4voUBE0a6OKSX1+9QfkYFN4uQqrdLMkZVNR3F9N7
         TOuMBzYeHww3ZNADfeU5FhHlGZTqIJ1qt0w+qIfIQW7lQVvoR9DqcvAbS1kP72xCyigx
         xwgokiBrHPHXFukSLrcvKyzI7ZOyyvV4IkmOvR7UbiTLAX31A0jLsCpEmT5P0amhTJog
         0z5ls78qhhdpnV23dt541mOYqsEvNuF93jRuriu0cjnGHxp1yw6kSnLz2yf0Lt0cO3Y5
         J6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l1pD+W54nOd1j1DXeZbD9xPUudJRVhA/hpogE5bgZ98=;
        b=kwDSGhxrKCBh6yBw4PDMMWZ9RKj2LwSDLGPejByAWoKT9pPxqSIFLnS9ra4BKfwFCA
         sBNfLVSbWf7TamGY48AS9o4oohBrjFmC8gqrGVMMPos14A6TrUNraQE2tgLUFtr+EmlW
         ESaBCDw0KIiGOY0T+MIUXlJRN9xDTVrXbdEf+aCPyEfCXKGKsvXKb2cGjA62CTowcQcN
         24ej6gvft+6yNEfVAwiri9zPZ42MDqWFAzjnFvky2MIpbgZhtIYSC9GkK21J4PIbVZuk
         bdbrSxYl8L1su5PwNC7Q3RBlP6fbPWQ6KokwGXcrUCpWmPDzkr/bSpi70Cc2yAlnGjLH
         wckQ==
X-Gm-Message-State: AOAM532MjS8gKUZ3VDNJIafEqiGzHHccgsz0iBMle3Dxm/9mw3Ynyetw
        4Wpozf0JwZDtd4rXD6yI23IA8RKNpL/90fE2aoo=
X-Google-Smtp-Source: ABdhPJwnUcDDLnd9SouT4svV7Vbgm80iZWY9qCLuCd/a2zGcE97Tfy89TXyAetWh/lcgVSZCknb11A==
X-Received: by 2002:a05:6512:310c:: with SMTP id n12mr25109316lfb.688.1635930182929;
        Wed, 03 Nov 2021 02:03:02 -0700 (PDT)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id w16sm124373lfr.233.2021.11.03.02.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 02:03:02 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Jerome Forissier <jerome@forissier.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, jens.vankeirsbilck@kuleuven.be,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v8 2/6] dt-bindings: arm: optee: add interrupt property
Date:   Wed,  3 Nov 2021 10:02:51 +0100
Message-Id: <20211103090255.998070-3-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211103090255.998070-1-jens.wiklander@linaro.org>
References: <20211103090255.998070-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds an optional interrupt property to the optee binding.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 .../devicetree/bindings/arm/firmware/linaro,optee-tz.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
index c24047c1fdd5..9a426110a14a 100644
--- a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
+++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
@@ -24,6 +24,12 @@ properties:
   compatible:
     const: linaro,optee-tz
 
+  interrupts:
+    maxItems: 1
+    description: |
+      This interrupt which is used to signal an event by the secure world
+      software is expected to be edge-triggered.
+
   method:
     enum: [smc, hvc]
     description: |
@@ -42,10 +48,12 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
     firmware  {
         optee  {
             compatible = "linaro,optee-tz";
             method = "smc";
+            interrupts = <GIC_SPI 187 IRQ_TYPE_EDGE_RISING>;
         };
     };
 
-- 
2.31.1

