Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 875713545F9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 19:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237640AbhDERVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 13:21:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60042 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237464AbhDERVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 13:21:46 -0400
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lTSuw-00017C-WE
        for linux-kernel@vger.kernel.org; Mon, 05 Apr 2021 17:21:39 +0000
Received: by mail-wr1-f72.google.com with SMTP id z7so484407wrs.17
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 10:21:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GEgD6nCwrnCCmMRnVlbIatB9AZXLMVXM2qwTWAsOSRQ=;
        b=aoiYeR7OBa/9jLoGA7OV5CeFoGXbR3wD0ja4Ma8TQpMaSnsJvHCShOhFl+9+OQZXwL
         YemTkxvg5RWsB/U2ofGT18pkblK0INV/BPyo2Lhyjk9DSCh5YW4jLQ4PogfjGtsF7TKg
         JwgWchvuboAtUQ4fUT2fsWp7IxQA7b+k7We/kQoqVjy8C6XtdDK6BWPfbghYZGf7AcUB
         jP542aHefbuiMk/5vSQw7gRkXQgQuVEf74WPsrBNxGeWTehOhJFaa8LSiaKTBtMtycK/
         ZkGS2oj2Y1uGC9yZ+H2bahlaty9qOriY2wimvAccMYj/bRkiaHBj89f8UmsH6kNugvz+
         SNZg==
X-Gm-Message-State: AOAM532SSuB9MAemJEfhTl0MtVOEw6TF3YdxcZ9XjWX3EWIihY5b/Vok
        IZDw+qe+YwTg4FD5dl754lbkLhHX3JEz4RYBxvPYR3gMWvZM/BsYkIj8Y4uWZx6G2dm4kJQ6bi9
        F9SJZk1mpIcugmzm+1Z52qzmSDwnxS9v4O0AdDExvpg==
X-Received: by 2002:a5d:63ca:: with SMTP id c10mr3368786wrw.268.1617643298795;
        Mon, 05 Apr 2021 10:21:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvw10z2SwG+zNEBknvFxeH/NAxYDl38hx+ODzviZ5wkQmgU4UelCf00bTWOqUL6fJHSWVN9g==
X-Received: by 2002:a5d:63ca:: with SMTP id c10mr3368767wrw.268.1617643298632;
        Mon, 05 Apr 2021 10:21:38 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id y12sm3736935wrs.65.2021.04.05.10.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 10:21:38 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: serial: samsung: include generic dtschema to match bluetooth child
Date:   Mon,  5 Apr 2021 19:21:19 +0200
Message-Id: <20210405172119.7484-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>

Include the generic serial.yaml dtschema so the child node like
"bluetooh" will be properly matched:

  arch/arm/boot/dts/exynos4210-universal_c210.dt.yaml:
    serial@13800000: 'bluetooth' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Drop the new example, as Rob suggested.
---
 Documentation/devicetree/bindings/serial/samsung_uart.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
index 4f98a3896b3a..97ec8a093bf3 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -79,9 +79,11 @@ required:
   - interrupts
   - reg
 
-additionalProperties: false
+unevaluatedProperties: false
 
 allOf:
+  - $ref: /schemas/serial.yaml#
+
   - if:
       properties:
         compatible:
-- 
2.25.1

