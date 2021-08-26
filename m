Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0AD53F877B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 14:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241188AbhHZMbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 08:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234495AbhHZMbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 08:31:31 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82AAC061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 05:30:43 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id j12so4756351ljg.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 05:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iDycTN9yyDhhTwc3Srtfw/Rl+6JzgcjoQzGWlzOIGrY=;
        b=nlXC4jk7imssziF4BZGKjdqHB/e4Rwx+jmB/xJpnO+gQjFcrnSB9voLWQJ4SVgBZsR
         yStK/gYOR1npSKgWdsOLRVqHr9SjxNrqB3oV+U9xtDrB5Y69puy0TGH2igM3RzqPkfx5
         AkuZR9phcFzVh5FDfJcC3HwtYUz4P7F+AEMVM7tlp3yyWiQjEzSSp+lsQdxB5SUd+HBM
         kCXOpRjX5V3ViBIl91HhYKoLJU+m+uUpq3Vsep8K1JY9rAINAZn2Fyxy/qX5Cc1TbPXa
         dSnKDyB1WRM5n0GLEJUcUBOqReTT4RksS3qMFHyjpkLzl9QUUUu1upn81OhRMba8/8JM
         W17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iDycTN9yyDhhTwc3Srtfw/Rl+6JzgcjoQzGWlzOIGrY=;
        b=ClLYmdrSImrSForU9RK+7rtOLQ8mK48ZY2KhtopxK49UZwmv1SR0IAA+EcHZokCZuG
         MVnfUhaAO+mG4SbGhroFTYmI1nyCEPTszuqGPL6bB/90xJoPEZelLj3x8FQqzaKwov9x
         VZhxQsgi0m5ulBYBIHbBp+yKp/Br8mtmoVHx2q+gvDp2gmoLRfTyd8DiImIT8Rn/MAnW
         axWN4do58juK4ZnrSNRFBdrKVQX2Qn3IhuEhqMJXEtcToI2spnUIJXlq0b83qLrNjd5T
         c7v0Gy1algC9/zPOpazHq4ZVDbuB+0Aj59EMm5U5ZzGxjADFVnI/tvF13Bby5Up9dwD8
         n8rQ==
X-Gm-Message-State: AOAM530papFWsObYjR4n+QeS4o2Wx20GmT2G1pU4Qh4BHOtrBnZJR6zz
        sk9QRw5w7qZWbJLlTtwo9yGwigMauA0khA==
X-Google-Smtp-Source: ABdhPJwQarP4Db9P6Gby/P9D9O3LQjajC9XAwpMTb5ACajA13QjU8NsTAlw1UOTlR0tnGBNT0NFpHA==
X-Received: by 2002:a2e:91d0:: with SMTP id u16mr2862869ljg.324.1629981041954;
        Thu, 26 Aug 2021 05:30:41 -0700 (PDT)
Received: from jade.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id j21sm332283ljh.87.2021.08.26.05.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 05:30:41 -0700 (PDT)
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
        Marc Zyngier <maz@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 2/6] dt-bindings: arm: optee: add interrupt property
Date:   Thu, 26 Aug 2021 14:30:28 +0200
Message-Id: <20210826123032.1732926-3-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210826123032.1732926-1-jens.wiklander@linaro.org>
References: <20210826123032.1732926-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds an optional interrupt property to the optee binding.

Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 .../devicetree/bindings/arm/firmware/linaro,optee-tz.yaml  | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
index c24047c1fdd5..40c9f1901e3f 100644
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
@@ -46,6 +52,7 @@ examples:
         optee  {
             compatible = "linaro,optee-tz";
             method = "smc";
+            interrupts = <0 187 1>;
         };
     };
 
-- 
2.31.1

