Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39CD33225C1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 07:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhBWGUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 01:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbhBWGT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 01:19:56 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36747C06178A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 22:19:16 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id s23so1193198pji.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 22:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OhVat5LrE1fhESIUjnpbwIUbs1+uHdZHHpdx8ggYgCw=;
        b=jjuchHLCWGF1ErNoEErzLFpwqBimzUP/Th11yILb0nPHSuvnP8OMSacbRaJ7LcuyMd
         uRdAZQZT4Sa2ZlaMZCbiyXINMezClHcLza61IqCWH0t6QXJ+rxQc5rvgjfEp9blQrG6Q
         PPq5+dXItdUiZKqUniyqJABdhNqTf6cAr/Oc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OhVat5LrE1fhESIUjnpbwIUbs1+uHdZHHpdx8ggYgCw=;
        b=TrKUtPPsKf9Tf0PcinZGu1dpOh1ylAkwf4PqMWF6cH3gU066sx5vOvS6edxNx6x0MD
         wSg7J7YfLCaujWYaEYuzz+dhxHX2zJH9RYqeJwvA8TugkvBoW8dKEuUOyp9By0HEXGy+
         bhf4k0wNQr2nQZHpto2k4lYRzKQtVzGe2TwlyVfhx/CiGdFmTAfUtfLJStf6G8we8Mqc
         CisAMQhFiGC9lMUWCn/wcrk0Hokc9xnwc2zkOLABW2cwY+CXAH//51pBkOPSk+fXOGh6
         Eg7Xbh8Hs0TQc4Zk9OebFBOOBGnDysjsCxEg8tnYu+Cv5WWfkznKm/GOcKF/mljfwxzw
         dbrw==
X-Gm-Message-State: AOAM532z3NmNd9tpUaFJRTd3BEm4NynkiMpzCDZxP7lqT5iEMOw8zACA
        fQS4+uRcEszDmBtCp9yoBQIqow==
X-Google-Smtp-Source: ABdhPJyXXR+t7UNc7M5JbvOoe9YC9FsdP2ZLpFwkfCS9cnni/x9cZLknpqKBKyk/9ba9udsHt8d96g==
X-Received: by 2002:a17:90a:ca11:: with SMTP id x17mr26126122pjt.201.1614061155775;
        Mon, 22 Feb 2021 22:19:15 -0800 (PST)
Received: from shiro.work (p345188-ipngn200408sizuokaden.shizuoka.ocn.ne.jp. [124.98.97.188])
        by smtp.googlemail.com with ESMTPSA id n10sm20135169pgk.91.2021.02.22.22.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 22:19:15 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        soc@kernel.org, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        w@1wt.eu, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 1/8] dt-bindings: clk: mstar msc313 cpupll binding description
Date:   Tue, 23 Feb 2021 15:18:23 +0900
Message-Id: <20210223061830.1913700-2-daniel@0x0f.com>
X-Mailer: git-send-email 2.30.0.rc2
In-Reply-To: <20210223061830.1913700-1-daniel@0x0f.com>
References: <20210223061830.1913700-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a binding description for the MStar/SigmaStar CPU PLL block.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 .../bindings/clock/mstar,msc313-cpupll.yaml   | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/mstar,msc313-cpupll.yaml

diff --git a/Documentation/devicetree/bindings/clock/mstar,msc313-cpupll.yaml b/Documentation/devicetree/bindings/clock/mstar,msc313-cpupll.yaml
new file mode 100644
index 000000000000..a9ad7ab5230c
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/mstar,msc313-cpupll.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/mstar,msc313-cpupll.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MStar/Sigmastar MSC313 CPU PLL
+
+maintainers:
+  - Daniel Palmer <daniel@thingy.jp>
+
+description: |
+  The MStar/SigmaStar MSC313 and later ARMv7 chips have a scalable
+  PLL that can be used as the clock source for the CPU(s).
+
+properties:
+  compatible:
+    const: mstar,msc313-cpupll
+
+  "#clock-cells":
+    const: 1
+
+  clocks:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - "#clock-cells"
+  - clocks
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mstar-msc313-mpll.h>
+    cpupll: cpupll@206400 {
+        compatible = "mstar,msc313-cpupll";
+        reg = <0x206400 0x200>;
+        #clock-cells = <1>;
+        clocks = <&mpll MSTAR_MSC313_MPLL_DIV2>;
+    };
-- 
2.30.0.rc2

