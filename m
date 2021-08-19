Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2CB83F1FDC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 20:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234546AbhHSS0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 14:26:35 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:33852
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232468AbhHSS03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 14:26:29 -0400
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 32F4F3F0A1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 18:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629397552;
        bh=18gxinZ2DJ3ZX3sOmqcOCSJNbRAwMTizB8l2gxtZoPE=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=SZk6KOD5V9YTN0Cw/Thp0y2Q0l1GUMflznCj0lSG51CTcN3jyyCl8C1Yst5CPiJoD
         zFgOD3iZAp5AMgz7X1XMfeVCIlriK05eoS4l7VNNqaoPLhGHYeUJhAFfL67HspGP0T
         jWJWYbdgQBJgBZZCaM4abW3a2otkIBFBWXriudvk5RcAobPsL0sfG/b8JktevavCzW
         psRD0JHPev9muFlTxsarqdjdu2xW1larPXcCoHCXa2mJ8HopO5DbSp2AY8w1qiFY55
         38ciRvA5fUP28LGF/aHVUjCmNqXEBjqQYUZYm1uKX3haVyUX2K2sUiafCzRwfcExlD
         n1iVT2LM8Efrg==
Received: by mail-ej1-f71.google.com with SMTP id ke4-20020a17090798e4b02905b869727055so2597434ejc.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 11:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=18gxinZ2DJ3ZX3sOmqcOCSJNbRAwMTizB8l2gxtZoPE=;
        b=pUr9KB/1rNJ7idblu6coMQC4pMzKzIyqfItocOygaH1CFTNedtuesukX+lC+UjXxE3
         HBpHBV1y+CwPZKF5bp4fqXPJ9u7vm2BnsWU4MKlC5E/3HxDHFfLRYKQrP4xYn0UX4b/J
         R1ZU3VVo5dQgdjaNosmm7qJFW8QLAl7OQWzj02U36C7ogXpv2U77mgIgoBm1Jlp8KpuZ
         GpSnjfjPtpKn0F+fKm36PQoljqzd9mWs+Vij6aTf9yx0j/SgpM1C6pmexwH1zAaUd/zK
         VZdQEn/suzWg7MTLa39bcXYxXAuyzrceVHT2vPlk+azQ5dDWSFQLMZ3SpnkU5HVGH6uL
         zzqA==
X-Gm-Message-State: AOAM533//2ktPa374ffbcsC4nFKzOdeB5HMDez7MwJZGCKMdWl8y53C5
        o7h6dMngjvrSIvtQ2I+zXJmv6m0xzvcIxRsZJNwSbmB0EzjUXpM8IXv2S1HC+O/FhmOX7vOpx0S
        Xhvuy4nYLLfvRAKrRp+FsZWs8+BvH0w6JdihE6o3Nrg==
X-Received: by 2002:a17:907:b09:: with SMTP id h9mr17380458ejl.278.1629397551899;
        Thu, 19 Aug 2021 11:25:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7N24ysDGZlQgoW7Q3735rlAtsbuXMRGfEm8M+0rgtPEoc9ckI8wE0kjehikBR8CWot0sT5Q==
X-Received: by 2002:a17:907:b09:: with SMTP id h9mr17380445ejl.278.1629397551791;
        Thu, 19 Aug 2021 11:25:51 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id n2sm2212108edi.32.2021.08.19.11.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 11:25:51 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Jiri Kosina <trivial@kernel.org>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 1/2] dt-bindings: hwmon: merge max1619 into trivial devices
Date:   Thu, 19 Aug 2021 20:25:43 +0200
Message-Id: <20210819182544.224121-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ther Maxim max1619 bindings are trivial, so simply merge it into
trivial-devices.yaml.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 Documentation/devicetree/bindings/hwmon/max1619.txt  | 12 ------------
 .../devicetree/bindings/trivial-devices.yaml         |  2 ++
 2 files changed, 2 insertions(+), 12 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/hwmon/max1619.txt

diff --git a/Documentation/devicetree/bindings/hwmon/max1619.txt b/Documentation/devicetree/bindings/hwmon/max1619.txt
deleted file mode 100644
index c70dbbe1e56f..000000000000
--- a/Documentation/devicetree/bindings/hwmon/max1619.txt
+++ /dev/null
@@ -1,12 +0,0 @@
-Bindings for MAX1619 Temperature Sensor
-
-Required properties:
-- compatible : "maxim,max1619"
-- reg        : I2C address, one of 0x18, 0x19, 0x1a, 0x29, 0x2a, 0x2b, 0x4c, or
-               0x4d, 0x4e
-
-Example:
-	temp@4c {
-		compatible = "maxim,max1619";
-		reg = <0x4c>;
-	};
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index fb03febc6616..1e4b3464d734 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -147,6 +147,8 @@ properties:
           - maxim,ds1803-100
             # Low-Power, 4-/12-Channel, 2-Wire Serial, 12-Bit ADCs
           - maxim,max1237
+            # Temperature Sensor, I2C interface
+          - maxim,max1619
             # 10-bit 10 kOhm linear programable voltage divider
           - maxim,max5481
             # 10-bit 50 kOhm linear programable voltage divider
-- 
2.30.2

