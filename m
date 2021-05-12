Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71BF337BA0C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 12:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhELKJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 06:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbhELKJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 06:09:46 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30F5C061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 03:08:37 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id h127so18141330pfe.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 03:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kZgjstHOYROHTT7vT6IiQEY3IT65wMZE5r7tRuaAKfk=;
        b=oIjOZtMNkRnY/ZbSuRC1GuQVbWrSsC8CR9YJWVkrafcQiuM6f36qbzdrYp5Qsog/S+
         LuFcXwmdiXHxqQ32iQSNo+FFu4KyoaFcuBSnMo5f7GoQmgowVYLQHtd/HFWTLiA1sovK
         eD4NUMeax/ib7ahf6XVp++kRKX1j+AeoArlx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kZgjstHOYROHTT7vT6IiQEY3IT65wMZE5r7tRuaAKfk=;
        b=eGn8x3NsN/n9v1D118oa/Z06nA66rEFtjbU+n2zEkzQ7OtkT/orrGe912if/syjeGT
         kLBr9Ow17sPk/pY4/+Y1VhA6qDR69A3K+VP9iBQGsDUo1grxNBHh3IiAgcSSaBjCz8lW
         +hKRv5yKvBtbfyzwImbp/D280rvcyfi4EZGrq489PkpiFlRuMU1A/pfuRK8Uxb6RarTD
         g5HdrLBIapjAdb7qyaFy3Us5bSeI9wasvvTthIcZKOAJzGpw75pmfg/Ht0sdZqhoy8cV
         6icR0tYkjT0/WyE1CnV8diXJKu3tgbhR1ULRefXv3HvaHsF+HyA4mukVVaORvf5JS2W0
         qQgw==
X-Gm-Message-State: AOAM531WlrKOVCvlNlhGYeTj/7ARCEWAygcE5SJ1gciww7OhCFPsqGH9
        duPAfO5ATGXdMvgPYMd7NXmG2Q==
X-Google-Smtp-Source: ABdhPJyHBs4vGbem7nSqycxt02ZAcG6NKtziRpLT4qcqxjo4mtcGAGrO250A304B4NkZPuRmRaZtWQ==
X-Received: by 2002:a65:60da:: with SMTP id r26mr16206280pgv.133.1620814117422;
        Wed, 12 May 2021 03:08:37 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:b:2e82:bfc3:6037:8e16])
        by smtp.gmail.com with ESMTPSA id o12sm15619919pjr.43.2021.05.12.03.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 03:08:37 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     devicetree@vger.kernel.org, linux-input@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>, Ikjoon Jang <ikjn@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v6] mfd: google,cros-ec: add DT bindings for a baseboard's switch device
Date:   Wed, 12 May 2021 18:08:31 +0800
Message-Id: <20210512100832.3878138-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
In-Reply-To: <20210415032958.740233-2-ikjn@chromium.org>
References: <20210415032958.740233-2-ikjn@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is for ChromeOS tablets which have a 'cros_cbas' switch device
in the "Whiskers" base board. This device can be instantiated only by
device tree on ARM platforms. ChromeOS EC doesn't provide a way to
probe the device.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

---

Changes in v6:
 - Remove a label from cbas node in an example

Changes in v5:
 - Add missing blank lines and change the description property's position.
 - Add a note to description: "this device cannot be detected at runtime."

Changes in v4:
Define cros-cbase bindings inside google,cros-ec.yaml instead of
a separated binding document.

 .../bindings/mfd/google,cros-ec.yaml          | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
index 76bf16ee27ec..929c17552d8b 100644
--- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
+++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
@@ -114,6 +114,22 @@ properties:
       - "#address-cells"
       - "#size-cells"
 
+  cbas:
+    type: object
+
+    description:
+      This device is used to signal when a detachable base is attached
+      to a Chrome OS tablet. This device cannot be detected at runtime.
+
+    properties:
+      compatible:
+        const: google,cros-cbas
+
+    required:
+      - compatible
+
+    additionalProperties: false
+
 patternProperties:
   "^i2c-tunnel[0-9]*$":
     type: object
@@ -180,6 +196,10 @@ examples:
             interrupts = <99 0>;
             interrupt-parent = <&gpio7>;
             spi-max-frequency = <5000000>;
+
+            cbas {
+                compatible = "google,cros-cbas";
+            };
         };
     };
 
-- 
2.31.1.607.g51e8a6a459-goog

