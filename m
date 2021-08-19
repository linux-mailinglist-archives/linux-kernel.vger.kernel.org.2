Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475613F1FDD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 20:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbhHSS0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 14:26:39 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:33870
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234477AbhHSS0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 14:26:31 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id D4D7F411C7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 18:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629397553;
        bh=VaNdDMIExHpifgg1f/piu7EYnB4gbMsCpL1KpPnqU+E=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=PQzFN6fLVFcqtgrOUZP/wlM0DXZYNMlvWKBW7rO+ZpGh6b4MXgNvuoPKIpXES8b36
         bhemVPMdteQjg8KAoC5ZTXcWUdljdXTFMAUoXVmnLUal2WJ5dpSJ/vm3R3jYSU7ccf
         3Mq334q+ApqlAAJzmV7+/wxnRxbEe5gj+ek/0FCX5OJW2BSVDe67zHh7SBfmwt9gRY
         kbOc3f/7DgS9ZlSjOwzScFmsWMp390TcBQFbC5k4sdbLC1d5yQoEepqj2O9BIt1rkJ
         XWVl7VJq8XtDLPB24Ot3GYPZbXfoB8z9zaFcmFOAAEI3oVcJH9sQJwSjlP6JfmaqV2
         11pzz05J5CwXw==
Received: by mail-ed1-f69.google.com with SMTP id v20-20020aa7d9d40000b02903be68450bf3so3260005eds.23
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 11:25:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VaNdDMIExHpifgg1f/piu7EYnB4gbMsCpL1KpPnqU+E=;
        b=gflbovh4h0pvGj3M5ubU6zgV6ozqX5gG7J4lHyPW4CtnTcpve2A1HhSNLDk5fVnkPF
         cb3PWr6cVrBEh1D0wk3b0sAv8W8Qc1IlHa04NnzsJEMFhoCpZOxzeEyO6VsV/S+jMHKY
         hMAcll04U/T3KYtBKQEC9giT2tiu1jl1D0bGpWW1GbpUwwbAhG4kPoqnEhkB3RX1VYEl
         kuj9hOAA9epTDgF06aLnRFBt1n7mSL3yKrD20T1HknLz+V/JgtRWZ4uR6rxQfLyuRyVD
         fPqBOdVt8Uy5nJ2Mo0W/6nqCYhiqM39Hj+6/jPDXzm90ExV/VDlc6GZAOeMw516wothA
         SQiQ==
X-Gm-Message-State: AOAM533Zt8MUeKXUCkAuaGHmjO47TlLd91DnS4ZsAB0CUHoowuUUGULZ
        QNGG0lokiSdwGEKWW+3b2qudcfhi2sKamFc9OoiUTKyVzSRXd5uox+XoiqwV2MVOoHWHzkT8ySu
        ID7+CXKNMW9TuLGvmuufQTRZQATOV/sY51Cmsu//dvg==
X-Received: by 2002:a17:906:31cf:: with SMTP id f15mr17345644ejf.272.1629397553317;
        Thu, 19 Aug 2021 11:25:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDCbkHj9coklC1cYVbTAv3iL7SLo9+rGR1X7tS5lUe0qPu3NrXS8RPnZn8fFzFy8dJyBNwHQ==
X-Received: by 2002:a17:906:31cf:: with SMTP id f15mr17345631ejf.272.1629397553110;
        Thu, 19 Aug 2021 11:25:53 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id n2sm2212108edi.32.2021.08.19.11.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 11:25:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Jiri Kosina <trivial@kernel.org>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 2/2] dt-bindings: hwmon: merge max31785 into trivial devices
Date:   Thu, 19 Aug 2021 20:25:44 +0200
Message-Id: <20210819182544.224121-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210819182544.224121-1-krzysztof.kozlowski@canonical.com>
References: <20210819182544.224121-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ther Maxim max31785 bindings are trivial, so simply merge it into
trivial-devices.yaml.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../devicetree/bindings/hwmon/max31785.txt    | 22 -------------------
 .../devicetree/bindings/trivial-devices.yaml  |  4 ++++
 MAINTAINERS                                   |  1 -
 3 files changed, 4 insertions(+), 23 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/hwmon/max31785.txt

diff --git a/Documentation/devicetree/bindings/hwmon/max31785.txt b/Documentation/devicetree/bindings/hwmon/max31785.txt
deleted file mode 100644
index 106e08c56aaa..000000000000
--- a/Documentation/devicetree/bindings/hwmon/max31785.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-Bindings for the Maxim MAX31785 Intelligent Fan Controller
-==========================================================
-
-Reference:
-
-https://datasheets.maximintegrated.com/en/ds/MAX31785.pdf
-
-The Maxim MAX31785 is a PMBus device providing closed-loop, multi-channel fan
-management with temperature and remote voltage sensing. Various fan control
-features are provided, including PWM frequency control, temperature hysteresis,
-dual tachometer measurements, and fan health monitoring.
-
-Required properties:
-- compatible     : One of "maxim,max31785" or "maxim,max31785a"
-- reg            : I2C address, one of 0x52, 0x53, 0x54, 0x55.
-
-Example:
-
-        fans@52 {
-                compatible = "maxim,max31785";
-                reg = <0x52>;
-        };
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 1e4b3464d734..646ab3a82387 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -163,6 +163,10 @@ properties:
           - maxim,max6625
             # 3-Channel Remote Temperature Sensor
           - maxim,max31730
+            # Intelligent Fan Controller with temperature and remote voltage sensing
+            # Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX31785.pdf
+          - maxim,max31785
+          - maxim,max31785a
             # mCube 3-axis 8-bit digital accelerometer
           - mcube,mc3230
             # Measurement Specialities I2C temperature and humidity sensor
diff --git a/MAINTAINERS b/MAINTAINERS
index fda9f438cc27..c8935b455dd2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14869,7 +14869,6 @@ W:	http://www.roeck-us.net/linux/drivers/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
 F:	Documentation/devicetree/bindings/hwmon/ibm,cffps1.txt
 F:	Documentation/devicetree/bindings/hwmon/ltc2978.txt
-F:	Documentation/devicetree/bindings/hwmon/max31785.txt
 F:	Documentation/hwmon/adm1275.rst
 F:	Documentation/hwmon/ibm-cffps.rst
 F:	Documentation/hwmon/ir35221.rst
-- 
2.30.2

