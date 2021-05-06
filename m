Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF69375634
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 17:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbhEFPHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 11:07:43 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40916 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234918AbhEFPHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 11:07:42 -0400
Received: from mail-qt1-f197.google.com ([209.85.160.197])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lefaM-0001UY-Ia
        for linux-kernel@vger.kernel.org; Thu, 06 May 2021 15:06:42 +0000
Received: by mail-qt1-f197.google.com with SMTP id j3-20020ac874c30000b02901bab5879d6aso3744679qtr.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 08:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zSTA6cfN/qaK4lBFMa4RvAaYG+jH1EwyfhL01aLLFFI=;
        b=turh/oOUnNQPupXBwz2I6pf/wQIR/w/aw/OhvpgjY70JTa7SzRnhRCPdKyVFD5Q+a4
         nrZjK4l0n9dDIcVmDspOhfIbT1sgHhh/1SitY/T10KZHjhoJXDA0+hqJWnbYvVCVdko/
         RLiS/4Qym43Y1Gmi/0rDyY5T+dfV2/biEMm0JwDUwQWdKKqXyDEqEWNtQI/z5c9awivv
         u45AP+QFrea+pZ7NvaPAibetzKic583G64itdaoUyP/2v+S91p4Po34lLD+CSTbKe8qk
         kZg7NymOFKN4pkrg0MlneEyhelq+joMvdX2qW71iJvefk3L1AQWAD3zmDuFXkgJxlw2V
         9+YQ==
X-Gm-Message-State: AOAM533WQ5FIcitJHAxNJNJ8cpJYfNV6bQGkMUtXZpLFXzjxxGOqPhaC
        2tIyVPijgGVdHrl29UujPCzGrlF4MpgMhIr+nS/tn4WvIkwjLhkQTY2nAGphO/Nt7O1HyM/iXPQ
        5w43PitWSAZPN2lnHPwUUsZf1tbKScF4z/uxyK6fL5g==
X-Received: by 2002:ac8:4756:: with SMTP id k22mr4683313qtp.193.1620313601722;
        Thu, 06 May 2021 08:06:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXHibdcno/SU3vySZ0SKbY5rMtER8hN0dvVyva6Yz9XHsYNpregf/rzBekPqY22OhXzN+zzA==
X-Received: by 2002:ac8:4756:: with SMTP id k22mr4683294qtp.193.1620313601524;
        Thu, 06 May 2021 08:06:41 -0700 (PDT)
Received: from localhost.localdomain ([45.237.49.1])
        by smtp.gmail.com with ESMTPSA id 189sm2236192qkh.99.2021.05.06.08.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 08:06:41 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH] dt-bindings: iio: afe: current-sense-shunt: add io-channel-cells
Date:   Thu,  6 May 2021 11:06:37 -0400
Message-Id: <20210506150637.35288-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current-sense-shunt is an IIO provider thus can be referenced by IIO
consumers (via "io-channels" property in consumer device node).
Such provider is required to describe number of cells used in phandle
lookup with "io-channel-cells" property.  This also fixes dtbs_check
warnings like:

  arch/arm/boot/dts/s5pv210-fascinate4g.dt.yaml: current-sense-shunt:
    '#io-channel-cells' does not match any of the regexes: 'pinctrl-[0-9]+'

Fixes: ce66e52b6c16 ("dt-bindings:iio:afe:current-sense-shunt: txt to yaml conversion.")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../devicetree/bindings/iio/afe/current-sense-shunt.yaml     | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml b/Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml
index 90439a8dc785..05166d8a3124 100644
--- a/Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml
+++ b/Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml
@@ -24,12 +24,16 @@ properties:
     description: |
       Channel node of a voltage io-channel.
 
+  "#io-channel-cells":
+    const: 0
+
   shunt-resistor-micro-ohms:
     description: The shunt resistance.
 
 required:
   - compatible
   - io-channels
+  - "#io-channel-cells"
   - shunt-resistor-micro-ohms
 
 additionalProperties: false
@@ -57,6 +61,7 @@ examples:
     sysi {
         compatible = "current-sense-shunt";
         io-channels = <&tiadc 0>;
+        #io-channel-cells = <0>;
 
         /* Divide the voltage by 3300000/1000000 (or 3.3) for the current. */
         shunt-resistor-micro-ohms = <3300000>;
-- 
2.25.1

