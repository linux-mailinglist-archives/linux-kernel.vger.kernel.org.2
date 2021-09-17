Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F5B40F877
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 14:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238205AbhIQM7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 08:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244858AbhIQM7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 08:59:19 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540FCC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 05:57:57 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id u19-20020a7bc053000000b002f8d045b2caso6839568wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 05:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iFUWw1a7QUKqKqitz2aLpXkNS/Ii3+Zh8E8PhFDc+ws=;
        b=0aPjARok8/bfyOykh5nmswrCWnnajZ9Af1BN4K/pxHOLzmexwy5ZSttA5vuhF+CteC
         jK/VKVic+QznbXHckMZV+vyrkKEAOQV7FSpYqgsPyImc+0nDdIL+qapHkvFD9hfn9HFw
         c/8hYl7aD9GYrpTdiOGoleERAwIz4yRWaXhAqFXEQIjTEGeDm+TB2s2hoa4RiHeDXozX
         pzaSQup9ftlw3Sx/54iPCDZsQgq2EZOGF+jmVIoVQGpaxuo//v/vIH52vpw7CcX59/Bj
         LK5trF/UjX8E5Z4bjl9Je4k96vrzzjCw6+zQWuNfbaMWusngmJzUb40pYixCah6EoQ6p
         uGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iFUWw1a7QUKqKqitz2aLpXkNS/Ii3+Zh8E8PhFDc+ws=;
        b=MF6xBgPolwyEllGEGMiG8oQcAw2sk0oxZ9yYcAq7POIFmV6RXApJxIgG9qZ2k7mnsG
         I7gokp1a4gMe9Qb6iRHsNt0ppWPb3+4d1yc6CibJ5Q6S3s5oYVRQDRAg6+e23+Qa2vOG
         I7bz50Gml+mNOqIO9Gb1/fq1e/9NSkEft7MyOALB5bDgOwTmPU2yr4sDx7ojiNxKsBYx
         UWgppOo4CqGC+VfT47vOTW3B68HBdXb36a4A0lMuqsEYSj/+1H/0A6TSWI0OAEy6E3Pl
         PzraxE9JEEqeBVlFv+bGUkmGb07YZleMIV3vQSYzKK13+J5bsyt33zzKXDtqR0vl/kdl
         Hm6g==
X-Gm-Message-State: AOAM532Z21BKtFXG5F8JPmPSX/VeRvAQHK7VDJXt/GuTqKaHcdBgrdz0
        LYXe/66J4752WzF/KqeSYFev1A==
X-Google-Smtp-Source: ABdhPJxWy0XCmee8O9AAHX/X1X4XNYljnsvUJuOMbUQaDzoewnSPgl2VT0nmiywxBLNmsxTlY3hzgQ==
X-Received: by 2002:a05:600c:3ba3:: with SMTP id n35mr10075940wms.166.1631883475858;
        Fri, 17 Sep 2021 05:57:55 -0700 (PDT)
Received: from localhost.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f3sm6358636wmj.28.2021.09.17.05.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 05:57:55 -0700 (PDT)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        matthias.bgg@gmail.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, ohad@wizery.com,
        bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        sumit.semwal@linaro.org
Cc:     christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, khilman@baylibre.com,
        gpain@baylibre.com, Alexandre Bailon <abailon@baylibre.com>
Subject: [RFC PATCH 1/4] dt-bindings: Add bidings for mtk,apu-drm
Date:   Fri, 17 Sep 2021 14:59:42 +0200
Message-Id: <20210917125945.620097-2-abailon@baylibre.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210917125945.620097-1-abailon@baylibre.com>
References: <20210917125945.620097-1-abailon@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the device tree bindings for the APU DRM driver.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 .../devicetree/bindings/gpu/mtk,apu-drm.yaml  | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpu/mtk,apu-drm.yaml

diff --git a/Documentation/devicetree/bindings/gpu/mtk,apu-drm.yaml b/Documentation/devicetree/bindings/gpu/mtk,apu-drm.yaml
new file mode 100644
index 0000000000000..6f432d3ea478c
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/mtk,apu-drm.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpu/mediatek,apu-drm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AI Processor Unit DRM
+
+properties:
+  compatible:
+    const: mediatek,apu-drm
+
+  remoteproc:
+    maxItems: 2
+    description:
+      Handle to remoteproc devices controlling the APU
+
+  iova:
+    maxItems: 1
+    description:
+      Address and size of virtual memory that could used by the APU
+
+required:
+  - compatible
+  - remoteproc
+  - iova
+
+additionalProperties: false
+
+examples:
+  - |
+    apu@0 {
+      compatible = "mediatek,apu-drm";
+      remoteproc = <&vpu0>, <&vpu1>;
+      iova = <0 0x60000000 0 0x10000000>;
+    };
+
+...
-- 
2.31.1

