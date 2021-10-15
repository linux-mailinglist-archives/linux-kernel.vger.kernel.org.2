Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54EC042EDA1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 11:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237356AbhJOJ3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 05:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237338AbhJOJ3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 05:29:32 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF12C061753
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 02:27:26 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id g10so35648178edj.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 02:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20210112.gappssmtp.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jqcUpdGkPlLCSTn8tOP34V+Kz/Zhk4bMhTOT82uEivE=;
        b=godJCkEv5ZKTN1Jch1qRe/oy1BiwOSYOzQHeO11hViPuOEngpPKz1doHT3Y04ZB5HL
         su0SiD83VAUMOpPDr77PzRMYXGMiybbUPkKtKIFTAM00PjKXkJ7Ch16xLqO6XOqO57BN
         d8N1Ys7uBHVwu5LEOLM4jh8BPCxmf0vKGK/CaDjNUiGO2XsOil4AVBjWjuy070SVfKkC
         +c2wK7TkwUEAQNAlIodpU+sKtXT0i84L4u80gxN75JPRbWYArVIGY2DL5/M2iO4ukqhs
         Z0G63GMMYebE+ALYDapILXxXZ5tWDgc+QIQZDc2nbBaPZ/4eonoIJyVzWsgnyQgr4RZT
         mIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=jqcUpdGkPlLCSTn8tOP34V+Kz/Zhk4bMhTOT82uEivE=;
        b=iqN1uVf/tmSVhlCjFbxXWvzeJdNY3TNhLi8IE59cVU15xbZESFD5nkO80rgmDxLx13
         C92KropqSC508ewndqI2Xm4aVHfv+TgnwuqRVKeZvLjdkAvEuXRlN+qV9a0R0gsWH2u2
         pVflzJkGvazbh6Qi921qbMdG51Dv0Y2XznLpeQ+nxIX3wPUoqfUdp/gUbmCt4W266U5U
         R+s8q1Z8EixKrlPPNQekRRuYdiucdJLSUvrT5veQlA0/mbiLVTJMEPirvW569CdTz9z9
         8/+zzLL6ngO6zCs21NUyVfZ/nFt5Jsi9SPg+I8fjdO1vPE5DwqKYQm5nohw8JVnNY+S5
         OAPw==
X-Gm-Message-State: AOAM530kUInCbQzFl7htaZpp4ZxAvjnBy0oOjLWeay+5eLyIeOosoAoE
        yJRrO/i/7y5ZVTm1xbo2u3igMsccKvc7iQ==
X-Google-Smtp-Source: ABdhPJwdmDklhD3pxxbqu9f2G/CNKriBF1c71usHNKjHgYAwNh5+pG2jeLZotWlI7WoAnEtp8a6PCg==
X-Received: by 2002:a05:6402:268f:: with SMTP id w15mr16920947edd.13.1634290044445;
        Fri, 15 Oct 2021 02:27:24 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6:f666:9af6:3fed:e53b])
        by smtp.gmail.com with ESMTPSA id a1sm4195840edu.43.2021.10.15.02.27.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Oct 2021 02:27:24 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH] dt-bindings: gpio: zynq: Describe gpio-line-names
Date:   Fri, 15 Oct 2021 11:27:23 +0200
Message-Id: <4b9db94cdd8ca106feee53f76fab2a23721f7d2a.1634290039.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Number of lines depends on compatible string from 58 to 174.
That's why it is checked based on it.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 .../devicetree/bindings/gpio/gpio-zynq.yaml   | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-zynq.yaml b/Documentation/devicetree/bindings/gpio/gpio-zynq.yaml
index da95b951c23e..29c27eadbac8 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-zynq.yaml
+++ b/Documentation/devicetree/bindings/gpio/gpio-zynq.yaml
@@ -28,6 +28,11 @@ properties:
 
   gpio-controller: true
 
+  gpio-line-names:
+    description: strings describing the names of each gpio line
+    minItems: 58
+    maxItems: 174
+
   interrupt-controller: true
 
   "#interrupt-cells":
@@ -39,6 +44,51 @@ properties:
   power-domains:
     maxItems: 1
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - xlnx,zynqmp-gpio-1.0
+    then:
+      properties:
+        gpio-line-names:
+          minItems: 174
+          maxItems: 174
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - xlnx,zynq-gpio-1.0
+    then:
+      properties:
+        gpio-line-names:
+          minItems: 118
+          maxItems: 118
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - xlnx,versal-gpio-1.0
+    then:
+      properties:
+        gpio-line-names:
+          minItems: 58
+          maxItems: 58
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - xlnx,pmc-gpio-1.0
+    then:
+      properties:
+        gpio-line-names:
+          minItems: 116
+          maxItems: 116
+
 required:
   - compatible
   - reg
-- 
2.33.1

