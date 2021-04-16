Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBC036208E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 15:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243437AbhDPNJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 09:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243400AbhDPNJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 09:09:19 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F09C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 06:08:54 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id a11so25515465ioo.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 06:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uzuVeA7UOjLvARkWMLDj1PjrCLOzAsZxspZjd3hjcw0=;
        b=IEmy8LPfhkY9f321KC+qGy9HWYXwqu2p1dnJum84JDQGmtwwm19qZHs7SQe/z+AsBu
         tfpDRF4K4v/W/9bXrMHa5dy3JM3YdOMUreZ9pb4VqOi47s64hhbVKFVw4Goh51rJjCGB
         aY6C8unsrYklxGZhdk0BVWFfzZJKbLqnMTnL5f1GRFsyUr5QKCP09JVGRFZeI+ykjr76
         ST0pBz7JOJlafBWuipSLvYd+4FcB8HHyvCNwaBp6R2iP40d1AmT7yzxd4wxquf5OWcjc
         507gikiI4MFmuU2q8T62awNIA/DG+WUMJpSp47n1Y0r04ZeUpM0SSrCi6+yMoRxlyVAs
         Igkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uzuVeA7UOjLvARkWMLDj1PjrCLOzAsZxspZjd3hjcw0=;
        b=IKBdXhY1AckvjTH/cNJ/bKWwIDHbNhwpUzaXhIIG9au+QjAriqu3JytjxA8fn/596G
         FmhqfFpJbw9TZRc6T3pUzed4WWpslNiAXOJlS54YVKnT6rFqPlxkv9wMcI/CEJvVDg/2
         Ox2mxi7MT6TkgqfU8FRBlvteDMzwEsftpqf5+aRib5ajZ2OLk3UsDx4w1uYdlPQyidAO
         nPmC74EbeJwz3LgqHO0oQ15F9HiwQ1Lj5OYXL75++JQpfaMtL86myvFlhWTxCBq9KBwq
         FbNaCr4fdPX5Ov2bVpjjOToqcGiASEJcJi3GXe89txXKhgD5zLOhGgewWIAvVA2/fHad
         ptLQ==
X-Gm-Message-State: AOAM531NWPoazeiX0i1OvIkNZWBKrv5u43jVd+OLyLlQNaeuX5gJq1RE
        dnIx19YE4/OpaWXvBDk9uV8xNg==
X-Google-Smtp-Source: ABdhPJztOrBhclUHweIstqEJUhDKuOIXMk19psn/0/YqaPioQbdKqTsy7V6RiHxWudnXn+bE6dsezA==
X-Received: by 2002:a02:9389:: with SMTP id z9mr3896926jah.60.1618578534295;
        Fri, 16 Apr 2021 06:08:54 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id e6sm2713535ilr.81.2021.04.16.06.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 06:08:53 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     robh+dt@kernel.org, davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, elder@kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] dt-bindings: net: qcom,ipa: add firmware-name property
Date:   Fri, 16 Apr 2021 08:08:49 -0500
Message-Id: <20210416130850.1970247-2-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210416130850.1970247-1-elder@linaro.org>
References: <20210416130850.1970247-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new optional firmware-name property to the IPA DT node.  It
is used only if the modem is not doing early initialization (i.e.,
if the modem-init property is not present).  Its value is the name
of the firmware file to use; if it's not specified, a default name
("ipa_fws.mdt") is used.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 .../devicetree/bindings/net/qcom,ipa.yaml     | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/qcom,ipa.yaml b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
index da5212e693e91..7443490d4cc6d 100644
--- a/Documentation/devicetree/bindings/net/qcom,ipa.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
@@ -125,6 +125,14 @@ properties:
       the firmware passed to Trust Zone for authentication.  Required
       when Trust Zone (not the modem) performs early initialization.
 
+  firmware-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      If present, name (or relative path) of the file within the
+      firmware search path containing the firmware image used when
+      initializing IPA hardware.  Optional, and only used when
+      Trust Zone performs early initialization.
+
 required:
   - compatible
   - iommus
@@ -134,12 +142,23 @@ required:
   - interconnects
   - qcom,smem-states
 
+# Either modem-init is present, or memory-region must be present.
 oneOf:
   - required:
       - modem-init
   - required:
       - memory-region
 
+# If memory-region is present, firmware-name may optionally be present.
+# But if modem-init is present, firmware-name must not be present.
+if:
+  required:
+    - modem-init
+then:
+  not:
+    required:
+      - firmware-name
+
 additionalProperties: false
 
 examples:
-- 
2.27.0

