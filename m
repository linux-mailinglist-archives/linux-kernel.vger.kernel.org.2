Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38464123FC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 20:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348810AbhITS3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 14:29:07 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:51064
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378103AbhITSWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 14:22:51 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C054E40192
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 18:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632162083;
        bh=+yYpY0bTQCprkzpDe095FfeHits+DFt9BKBgw/pr/fI=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=onyEwh1fxRTW6x18akBYBr2Dm+kVidRIsThrD1tfkwmK3TTjBtGUrcDyBUrBq9Nno
         qeYwMqEN7H5NkqxHbwAEEqWLmXDUk5qBEKrY1Hfq5WanMeJ/5KjQUhMmhDHyO0sVIO
         vg9mhbmgAR4BV4i6VPwWP8fqtQpeBZIk3HsxIW2eDCfl5X3mEyDVqUBk7UwbsuiJsl
         XSqJVfZSb+UX7xUlVgqZ4bPywvm4mPgP9F3BZejVH37cVkLmabEIcpTkKubGBnwNgI
         quEEYUMI+r710pVmiGKCVt0/rxZ3FH4+sXswZ+JFFLysbVz/KCKf948m13oGY9rWRl
         ZpVktQmEc1Etw==
Received: by mail-wr1-f70.google.com with SMTP id r5-20020adfb1c5000000b0015cddb7216fso6805113wra.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 11:21:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+yYpY0bTQCprkzpDe095FfeHits+DFt9BKBgw/pr/fI=;
        b=RKHH7qyqjSSKIQiJliB79XgiR6gt2x7a5a6HhNPVxYMyt5yL9Ap2Nc3rz0xJWuEKkS
         C24pmfbw4xjvBtP8ehTri5Rdz3PV7O7H6EtUv140WLjkhi2Z4+fIsH4vf94SB43uTQba
         bvd8Vkisst5BMl10EkfeML4rCNQajLBeFLe2a6S1YtYvj4VCFYruijGqfhFGGssd67jE
         rKuFniYrxhx7ys72L2hGe5LjBhBynC2SbEOTavDOvXJVo1kRSrPcFyD4wgiwl6FFChIF
         lqM5baZc6MrIB9nbjTsfoDYK00F9ZdR3Z4Yvcbbde4M9oU4KSg73rXtTJudDzT5LbW1V
         m0Pg==
X-Gm-Message-State: AOAM531AX/QyUPM74kFdsk5Z1HOqC2ZzhE72Z7arA00THD9My/6Uhb0r
        7qcuc9xytYsdXY4n5KwBjQIgf2tZkM+r1ADVPbSd4Md0AOH7mv0zhNj+l3tH8F7ojF2ZVpVA0t6
        +MGRzptrYyaTjo63vhwJ5kvblYykVRQBBWLoAgRdFhA==
X-Received: by 2002:adf:f884:: with SMTP id u4mr29322854wrp.411.1632162083540;
        Mon, 20 Sep 2021 11:21:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3hZvPR1xLQRHEbFwJFMfji+eLy88hIeF1v2xPgZqajAjlE0iGWvbL2fqHTmYlXmC+sI2PjQ==
X-Received: by 2002:adf:f884:: with SMTP id u4mr29322840wrp.411.1632162083396;
        Mon, 20 Sep 2021 11:21:23 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id e5sm10515285wrd.1.2021.09.20.11.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 11:21:22 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] dt-bindings: hwmon: dps650ab: move to trivial devices
Date:   Mon, 20 Sep 2021 20:21:11 +0200
Message-Id: <20210920182114.339419-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920182114.339419-1-krzysztof.kozlowski@canonical.com>
References: <20210920182114.339419-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dps650ab bindings are trivial, so it can be integrated into trivial
devices bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 Documentation/devicetree/bindings/hwmon/dps650ab.txt  | 11 -----------
 .../devicetree/bindings/trivial-devices.yaml          |  2 ++
 2 files changed, 2 insertions(+), 11 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/hwmon/dps650ab.txt

diff --git a/Documentation/devicetree/bindings/hwmon/dps650ab.txt b/Documentation/devicetree/bindings/hwmon/dps650ab.txt
deleted file mode 100644
index 76780e795899..000000000000
--- a/Documentation/devicetree/bindings/hwmon/dps650ab.txt
+++ /dev/null
@@ -1,11 +0,0 @@
-Bindings for Delta Electronics DPS-650-AB power supply
-
-Required properties:
-- compatible : "delta,dps650ab"
-- reg        : I2C address, one of 0x58, 0x59.
-
-Example:
-	dps650ab@58 {
-		    compatible = "delta,dps650ab";
-		    reg = <0x58>;
-	};
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 1bbfa98a85d8..b1bad299ec66 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -73,6 +73,8 @@ properties:
           - dallas,ds4510
             # Digital Thermometer and Thermostat
           - dallas,ds75
+            # Delta Electronics DPS-650-AB power supply
+          - delta,dps650ab
           # Delta Electronics DPS920AB 920W 54V Power Supply
           - delta,dps920ab
             # 1/4 Brick DC/DC Regulated Power Module
-- 
2.30.2

