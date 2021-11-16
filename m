Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD99452FC1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 12:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbhKPLGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 06:06:53 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:42448
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234700AbhKPLFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 06:05:50 -0500
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8B1813F1A9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 11:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637060571;
        bh=/fhj+bVJm076Wq/VhTriJ0yxdPwTog87+Zp8k+Dl/zY=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=g7PNkbHBpyz9f9f1XKeT3hOaBloAHxzPMJmoiF0Artb7vHWmDGZdWKqYO+5fi4gwT
         iOqO9TxjDT9p3n2EU2sABFhlzz8rrBOBaWPtro4FotNonEvX6ZEc/4SQGmMu/5iVfX
         lRnFWErhvvY9t8c62ZFpm7iA96ciCWYvKmoWKenWDWZ9s8AGKcltVpGjAIvt4+PyRI
         d9c7qRfgky1FX5Ta/I9jngCwn4GKuXryhQWvYO4Vs4uQPuxAH6Zk2wTvHpmQ3KS9LU
         mmodQq1hTCerWL/PPwGjTPLZU1aUu4RVZ+g95TegUMLBAmT0pcakHvHciwWuMyfO2I
         xEVPmXJ5LDxTQ==
Received: by mail-lf1-f72.google.com with SMTP id n18-20020a0565120ad200b004036c43a0ddso8020773lfu.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 03:02:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/fhj+bVJm076Wq/VhTriJ0yxdPwTog87+Zp8k+Dl/zY=;
        b=5EtCGfAsZMMngk5Kwxo6VN5k36U001KNe8teBAVSH6wAFuTS2pgbp89Tul29adqWYO
         EsUkqbZ4/KMNVt3R/rDpFQ16ivu7mbE5578CxAO5MDbNyL3YcWKkJaA5pWsZem2xIjwx
         rJLKQhUBFZjIKL3s1dxFhAmOL0FDIm970iH4fKu4s56X7Xs6QMP79mi8IzhTxirpWIeF
         BzXm7zxLfl0t15jpNnimIsotBbxfSu0Uf462Caua+Y5Dr7ozj03nCxCTIBC2QYMIGb1B
         /gu56eswGJy5/FwW0zj47D6TGZyNP3+zmud2v34p8mfPqiKZOrFxK7v6ftx8Ov4SxsaP
         51Xg==
X-Gm-Message-State: AOAM5339tE3qFPMwkGW3wt2/2QU/+ZqXr4SN1pmDtbxnN6W9R5L7Rone
        zQIytS5aprxO0toeTFTw4Fex+bJL+2gGA3PypGEnhgdQk85wJhvuJ9vq1ODb69a251yKbu6iNV0
        6Ze1iFc0Ivk0Ii4QGYeMMnGd9BJ7ZYzbF4qtuRaZgrQ==
X-Received: by 2002:a05:6512:604:: with SMTP id b4mr5696013lfe.198.1637060569538;
        Tue, 16 Nov 2021 03:02:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx7ajDYjXbeKcZbiXLfcr+dTx8ryW8atDeHVo7pyKw8Zx2SmbmhraxaC8+5fg6M9h4tJ5URtQ==
X-Received: by 2002:a05:6512:604:: with SMTP id b4mr5695972lfe.198.1637060569244;
        Tue, 16 Nov 2021 03:02:49 -0800 (PST)
Received: from localhost.localdomain (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id z8sm1420074ljj.86.2021.11.16.03.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 03:02:48 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Vincent Pelletier <plr.vincent@gmail.com>
Subject: [PATCH] dt-bindings: hwmon: add TI DC-DC converters
Date:   Tue, 16 Nov 2021 12:02:07 +0100
Message-Id: <20211116110207.68494-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Few Texas Instruments DC-DC converters on PMBus like TPS544B20 do not
have bindings and are used only as hardware monitoring sensor.  These
devices are actually not trivial and can receive basic configuration
(e.g. power up mode, CNTL pin polarity, expected input voltage), however
devicetree support for configuration was never added.

Therefore in current state the devices are used only in read-only mode
and have trivial bindings, so document them to have basic dtschema
tests.

Cc: Vincent Pelletier <plr.vincent@gmail.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 791079021f1b..3297a6480534 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -329,12 +329,19 @@ properties:
           - ti,tmp122
             # Digital Temperature Sensor
           - ti,tmp275
+            # TI DC-DC converter on PMBus
+          - ti,tps40400
             # TI Dual channel DCAP+ multiphase controller TPS53676 with AVSBus
           - ti,tps53676
             # TI Dual channel DCAP+ multiphase controller TPS53679
           - ti,tps53679
             # TI Dual channel DCAP+ multiphase controller TPS53688
           - ti,tps53688
+            # TI DC-DC converters on PMBus
+          - ti,tps544b20
+          - ti,tps544b25
+          - ti,tps544c20
+          - ti,tps544c25
             # Winbond/Nuvoton H/W Monitor
           - winbond,w83793
             # i2c trusted platform module (TPM)
-- 
2.32.0

