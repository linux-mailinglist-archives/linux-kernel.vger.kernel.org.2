Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F09541242C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 20:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379912AbhITSbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 14:31:15 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:46982
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378526AbhITSYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 14:24:51 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6B35E40293
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 18:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632162086;
        bh=aMSiOms6prdZ099C0szw2vjYvnbIcB4EP4lQR9/7bd4=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=k5QQTo2Xo9hyK5S/q+DbzguKRbEqVKuHv8FOGAN5BPin7ocZf7VdWlh38QX3A5QPp
         0x4N5m/K+y72WfgJEx5Oci/TaB0kxqNF3uHiZR7pRXPcdCdwdZrS2RtjRMfVElGxOQ
         EY3sXmH8mnt720Qak+3++ErhpK855yCVSrapuHIrH+ogaC5NYaFN1zdDjmxPm9NRoR
         ATWVbeV3qElXXcOA9cAf0h1C6Kt3oYZd8Q7U0gQsxCxxw6d5pDCqekQIep5anbHjrh
         zFYTnDy91TIUHsoQPOPFOSmeVnMKi5q/7wK4kT5so5THdFaVavXlCiueApMWoHDvLD
         FAbHkqy+aM0iA==
Received: by mail-wr1-f69.google.com with SMTP id q14-20020a5d574e000000b00157b0978ddeso6788455wrw.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 11:21:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aMSiOms6prdZ099C0szw2vjYvnbIcB4EP4lQR9/7bd4=;
        b=2yuZ0Yy/bP0nNeXyDtPV2UtJgovhptn3nSQWPWAKpXgD5fQYp75VAhBXZXEW66zwzC
         bJZ5iZ4grx9WQUzTIJhqPZMCMoq+SZMP/ZLZZWPTOY6l8V++H+AjzWmigOt6doRdFirl
         abxmK+B+O/cKPyMQsp4vL5GPX4drAJgjUOyuNEgLGkxXfru/HK0zT9bp8XLcy3Jmzy/L
         rKL3LQPuntD9w5e+CRmrRUhdQlqeXAYC5FtFCbDXb01MGSufQPpwDZrefA2VWY3IXIcV
         hxoeJ1UCCj//H9Gf09YfwNwSO/+IcLzumqAgutRKSiCDfFFyYjCo57tWFQ3urley4rAo
         Htjg==
X-Gm-Message-State: AOAM532o/0vcVipNSMtc0bFHzD0xLA08r9PEl5pl4Z7icSJTA5MwMGd6
        3hsl4ESEmUjK6qzbgftFzWrYoSfB8jyhIEdF8ceK76TevcAupHrHOtmyza8y0dxSb6SRPxBmsh2
        SuF2/tDZ3hGphe07ZIyo2vcNM07MdJ7ro43gxMNs2Aw==
X-Received: by 2002:adf:d1cf:: with SMTP id b15mr4098027wrd.181.1632162085200;
        Mon, 20 Sep 2021 11:21:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw774b/B1NbEVUkHVEbXU9WEty43J69NGTEEI3VR3a+6pwFjffJn/aWJcn7R38bDYtguu4aNA==
X-Received: by 2002:adf:d1cf:: with SMTP id b15mr4098013wrd.181.1632162085016;
        Mon, 20 Sep 2021 11:21:25 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id e5sm10515285wrd.1.2021.09.20.11.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 11:21:24 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] dt-bindings: hwmon: hih6130: move to trivial devices
Date:   Mon, 20 Sep 2021 20:21:12 +0200
Message-Id: <20210920182114.339419-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920182114.339419-1-krzysztof.kozlowski@canonical.com>
References: <20210920182114.339419-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hih6130 bindings are trivial, so it can be integrated into trivial
devices bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 Documentation/devicetree/bindings/hwmon/hih6130.txt  | 12 ------------
 .../devicetree/bindings/trivial-devices.yaml         |  2 ++
 2 files changed, 2 insertions(+), 12 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/hwmon/hih6130.txt

diff --git a/Documentation/devicetree/bindings/hwmon/hih6130.txt b/Documentation/devicetree/bindings/hwmon/hih6130.txt
deleted file mode 100644
index 2c43837af4c2..000000000000
--- a/Documentation/devicetree/bindings/hwmon/hih6130.txt
+++ /dev/null
@@ -1,12 +0,0 @@
-Honeywell Humidicon HIH-6130 humidity/temperature sensor
---------------------------------------------------------
-
-Requires node properties:
-- compatible : "honeywell,hi6130"
-- reg : the I2C address of the device. This is 0x27.
-
-Example:
-	hih6130@27 {
-		compatible = "honeywell,hih6130";
-		reg = <0x27>;
-	};
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index b1bad299ec66..c9333fb81fdf 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -111,6 +111,8 @@ properties:
           - mps,mp2888
             # Monolithic Power Systems Inc. multi-phase controller mp2975
           - mps,mp2975
+            # Honeywell Humidicon HIH-6130 humidity/temperature sensor
+          - honeywell,hi6130
             # Infineon IR36021 digital POL buck controller
           - infineon,ir36021
             # Infineon IR38064 Voltage Regulator
-- 
2.30.2

