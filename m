Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10956413191
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 12:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbhIUKbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 06:31:10 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:38570
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231857AbhIUKan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 06:30:43 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 61CCF40292
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 10:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632220154;
        bh=1DUxWd5JqgocBkdimT7Y/A3y/8+TydWfjcWcCjG/nZs=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=PEBL8Fn1GpogFpKbTMJtaiI3scJ2udPV7Y4Cy6AuOHTs23QthrjztqkJ0Q51b/oy1
         W6RbFrYtoiqdkzO+DrTpruKzdMSU0P99VmuDAB1N+EJGI/kwn40uE4/d7JWhbW9wFL
         GH0a83QuWSHN2TPdCD9G2ZXBjiZtxTYr/LLA1uEYEY+qvpW9qB1V/jwr3kad8Z78RV
         8kqhjZ+bUO5mvGMNlNICYvY2y0J1fkhNDbp/XX71WWQs7wEQa8bNIIED1JvwTKcP+J
         7wkLKyWXoX+s0JZe0V7Y425Av1QgFkeh3n1N73mJsMWFg7SvPO2Eoy9GcLUuMG0/zu
         N1Hg4LKx1FeKg==
Received: by mail-wr1-f72.google.com with SMTP id k2-20020adfc702000000b0016006b2da9bso3366814wrg.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 03:29:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1DUxWd5JqgocBkdimT7Y/A3y/8+TydWfjcWcCjG/nZs=;
        b=pukIYhwIAO77YpjK9+Vudum1nD41gbvY57GNUn+2Te42HNw68SmwuxZZIwtBPhvUWw
         Q/YZ4bdF1kaV9+4Sg9N6YDuWKQ1ILNLaHYGDWONxgWSMSILiwAUgR6G9vscviFMKKCYX
         Q6yF3onj4LKfxXk5r/e+7OK5haw30IPcrTQTrguBqezONMXiXUgOmcH6UILB0z+/W3vp
         1J/x+qQUj5imUoMhZBxBeGghoxXlbe4tr8HshwyyIE+mMO+LHKseLibCwXBsGdk7qxMc
         cuEx/x/AUd8HhWVtIBDwTusF2pI45lDUHiv8/tJ2TzbIPIxOSbytAXRf1+SEOibbuyx0
         3ZLA==
X-Gm-Message-State: AOAM530FcJiAp5dqVFUZerlQPWP0uD8FclGH1ekzmMyj0NeUVyPRFpf3
        Bjp+eTnAHnA38eeUknUivzu09O7fZOsVFssGxKtnqYfIyiyNVKJ/NNOF0Avj81uIDRdeiqr1M/1
        fUnNe6xJXECvRerzHyx3C0yztXqz6mNGKM5+aB74r/g==
X-Received: by 2002:a5d:4f02:: with SMTP id c2mr34491883wru.10.1632220154081;
        Tue, 21 Sep 2021 03:29:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwRjy7wJN4+BNr8/OvaTDhceg6Yn0DsLx0lA30HZaclAHguEcpzI6IcaZ/1l4k9U+WOgBlPw==
X-Received: by 2002:a5d:4f02:: with SMTP id c2mr34491860wru.10.1632220153891;
        Tue, 21 Sep 2021 03:29:13 -0700 (PDT)
Received: from localhost.localdomain (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id m29sm20072380wrb.89.2021.09.21.03.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 03:29:13 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] dt-bindings: hwmon: ibm,cffps: move to trivial devices
Date:   Tue, 21 Sep 2021 12:28:29 +0200
Message-Id: <20210921102832.143352-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210921102832.143352-1-krzysztof.kozlowski@canonical.com>
References: <20210921102832.143352-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IBM Common Form Factor Power Supply Versions 1 and 2 bindings are
trivial, so they can be integrated into trivial devices bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../devicetree/bindings/hwmon/ibm,cffps1.txt  | 26 -------------------
 .../devicetree/bindings/trivial-devices.yaml  |  6 +++++
 MAINTAINERS                                   |  1 -
 3 files changed, 6 insertions(+), 27 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/hwmon/ibm,cffps1.txt

diff --git a/Documentation/devicetree/bindings/hwmon/ibm,cffps1.txt b/Documentation/devicetree/bindings/hwmon/ibm,cffps1.txt
deleted file mode 100644
index d9a2719f9243..000000000000
--- a/Documentation/devicetree/bindings/hwmon/ibm,cffps1.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-Device-tree bindings for IBM Common Form Factor Power Supply Versions 1 and 2
------------------------------------------------------------------------------
-
-Required properties:
- - compatible				: Must be one of the following:
-						"ibm,cffps1"
-						"ibm,cffps2"
-						or "ibm,cffps" if the system
-						must support any version of the
-						power supply
- - reg = < I2C bus address >;		: Address of the power supply on the
-					  I2C bus.
-
-Example:
-
-    i2c-bus@100 {
-        #address-cells = <1>;
-        #size-cells = <0>;
-        #interrupt-cells = <1>;
-        < more properties >
-
-        power-supply@68 {
-            compatible = "ibm,cffps1";
-            reg = <0x68>;
-        };
-    };
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 6ad0628741cf..791079021f1b 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -113,6 +113,12 @@ properties:
           - mps,mp2975
             # Honeywell Humidicon HIH-6130 humidity/temperature sensor
           - honeywell,hi6130
+            # IBM Common Form Factor Power Supply Versions (all versions)
+          - ibm,cffps
+            # IBM Common Form Factor Power Supply Versions 1
+          - ibm,cffps1
+            # IBM Common Form Factor Power Supply Versions 2
+          - ibm,cffps2
             # Infineon IR36021 digital POL buck controller
           - infineon,ir36021
             # Infineon IR38064 Voltage Regulator
diff --git a/MAINTAINERS b/MAINTAINERS
index 15c4d3c809e8..cc5df54bdc51 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14956,7 +14956,6 @@ S:	Maintained
 W:	http://hwmon.wiki.kernel.org/
 W:	http://www.roeck-us.net/linux/drivers/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
-F:	Documentation/devicetree/bindings/hwmon/ibm,cffps1.txt
 F:	Documentation/devicetree/bindings/hwmon/ltc2978.txt
 F:	Documentation/devicetree/bindings/hwmon/max31785.txt
 F:	Documentation/hwmon/adm1275.rst
-- 
2.30.2

