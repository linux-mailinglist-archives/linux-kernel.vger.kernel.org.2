Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6624A380965
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 14:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbhENMW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 08:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbhENMWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 08:22:55 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE9FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 05:21:44 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id h16so11744060pfk.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 05:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eDsBcMn1LjQ/hDt4A5VW4rjJ3axqBAgkESJwxk85dos=;
        b=SW5DJIHQpxkxWhkboLIm5KcifPgzvhRktiH30n6bS+X4SKEPha2DWC3KR5gyqr83hB
         YQPLn3bgk3aUNnuGPtDGve2THPWaS26HYtEvXb7Dr1y0ewiZLuhKY8KViKhfrhDk62QM
         K6LMvy3EL5Djw/52hUfs3ULA0sFQAiWklQQSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eDsBcMn1LjQ/hDt4A5VW4rjJ3axqBAgkESJwxk85dos=;
        b=PZEYuZolRxM8iAullsLA5rnFyaiWcjwhbLtUvoM43QunOmnc4Y8/v4VhGE/iba81Fq
         6Cvs60zvgXNc6TRRNtWljf/XLdWcu21d5izxBLRsP1esQfEnhJGP4D6qyFK0VnOnRbmd
         mkC+XJGqpFKwengNvH2GQa95uF1cnRSyjVKESJi8BT8ZDiNO9rTyTwGUyOchchWS5CXi
         /qbsIrUXGPctM8M0iKTvhx0xu4DMBdgB8bvTHMRXS6DrSJXtdbF0XHOfWhe2pvF2el7o
         1psf9QnCM0tF+fw1gk32X6ljOVbae2mbLFetlswG43DzFz8SgbSarYC3SfsubajEu63l
         ZrKw==
X-Gm-Message-State: AOAM533MTTpg7noMzcp+g+fXIa+TVSY3MGtsFnPsKT+xW7zhszx/6L/g
        w49pwCBNkclcsJcRnWce0zTloQ==
X-Google-Smtp-Source: ABdhPJx6jr5fCAdWz8NJtqocenE0PKs3M5FF1QRbK4QlEM50P2vcTu20RWzMWUzaKu1vMlPRqVRlZg==
X-Received: by 2002:a62:80d2:0:b029:2b3:fca1:8829 with SMTP id j201-20020a6280d20000b02902b3fca18829mr31868512pfd.2.1620994904194;
        Fri, 14 May 2021 05:21:44 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:b:7641:4b1d:694e:6ea2])
        by smtp.gmail.com with ESMTPSA id u17sm4010117pfm.113.2021.05.14.05.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 05:21:43 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     devicetree@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Guenter Roeck <groeck@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        linux-input@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        Jiri Kosina <jikos@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Ikjoon Jang <ikjn@chromium.org>, Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [RESEND PATCH v7 1/2] mfd: google,cros-ec: add DT bindings for a baseboard's switch device
Date:   Fri, 14 May 2021 20:20:49 +0800
Message-Id: <20210514122051.266169-2-ikjn@chromium.org>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
In-Reply-To: <20210514122051.266169-1-ikjn@chromium.org>
References: <20210514122051.266169-1-ikjn@chromium.org>
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

Changes in v7:
 - no changes from v6

Changes in v6:
 - Remove a label for cbas node in a example

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
2.31.1.751.gd2f1c929bd-goog

