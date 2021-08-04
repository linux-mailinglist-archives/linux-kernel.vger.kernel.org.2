Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611003E0924
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 22:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240807AbhHDUFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 16:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239458AbhHDUFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 16:05:12 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D920C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 13:04:59 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id h18so2780641ilc.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 13:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WpJTczWcMa/wlQB3c8ZVvUWtfwUJzoex9JrRy9qZMaU=;
        b=V2EDbbaFFgv/yFfhmUf9155JJ/wIPornZXPN5AzHMdPUVi9oaTtJHHA3yLPuRQMgqy
         zbJtaSsDaAy7JzbAIYII7nU0nm0OBeVxtXYt1k1K9NX0kzAQy8s15auhXOTIIAMAgmdB
         asCu7p8zDWaWpxHnXDklH9PVT0bW6J2749f7WmmtsT5m+zt9IZ0cy7QwSbCNxVa4FzMp
         EkftrmLD1ielcb7qYdXN2h202l07Z/vYeS1zutrclwZrikfMvFpQgy4DI2stqWPPh98m
         Yk0xOk9+3dXTvCmwZ+HiDYSAViWN2YO/VPV7HPyZP5gecmsaIgoXo1qz5s9kD1kPjHHP
         lu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WpJTczWcMa/wlQB3c8ZVvUWtfwUJzoex9JrRy9qZMaU=;
        b=cxEXfYLEgkDtQUoN2I6BIIz5XKBt8M/ZNj7K6iRxM/Bucnjz3nukjVrIMNyhDN8AuW
         mEHUluc+aOfxOX4DoQHujxbvR8CUDqALHB2mm4WbDZ8gkdi8l3XFluWVdIKu9vN1zCmt
         EDvPrCADXoASU5kVZOwy9NMb+Y6px3Q/ry5o9YvLQvfvMNXh8YgKz1JenTmJqWjOfEoy
         afBOrw33wCYqHD40nWE19TjbdFnwfthqjfF9iWIunp3Ga0gkJVTIIvyBePdmJJwQV/lY
         StyhuRe4QkQ1dQdmxHCyNtffb/VR5imYoKEXy34ROr0e26ZR+6WvEh6qlp/F/swfxslp
         vNYQ==
X-Gm-Message-State: AOAM531sky4bO3DP7/Lc8HJH0Fk7PwOrIQ+AjHawk+zKgMxKO8+BkUaR
        ULZTiidjsJWQcyT0+fyYQE85Xw==
X-Google-Smtp-Source: ABdhPJzJIABp7xpm/81s+uXVZS7zz3xFasgjCDYFrHACNOujmuT8N5qBYNf/d3dOd4DZdir1dr7VqA==
X-Received: by 2002:a92:c8c1:: with SMTP id c1mr999791ilq.106.1628107498554;
        Wed, 04 Aug 2021 13:04:58 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id f7sm1681097ils.42.2021.08.04.13.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 13:04:58 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     robh+dt@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org
Cc:     elder@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: net: qcom,ipa: make imem interconnect optional
Date:   Wed,  4 Aug 2021 15:04:55 -0500
Message-Id: <20210804200455.1878582-1-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some newer SoCs, the interconnect between IPA and SoC internal
memory (imem) is not used.  Update the binding to indicate that
having just the memory and config interconnects is another allowed
configuration.

Signed-off-by: Alex Elder <elder@linaro.org>
---
v2:  Now based on linux-next/master (not net-next/master)

Rob, Bjorn, Andy:

This was posted as part of a small series once before, and accepted
into the net-next/master branch by David Miller:
  https://lore.kernel.org/netdev/20210719212456.3176086-1-elder@linaro.org/

That series got reverted yesterday:
  https://lore.kernel.org/netdev/20210802233019.800250-1-elder@linaro.org/

Now I'm posting this patch again (by itself, and a little different
this time based on input from Rob) so that this patch can be taken
through the Qualcomm repository.  I will be posting other updates to
DTS files in a separate series shortly.

I didn't copy networking addressees this time...

					-Alex

 .../devicetree/bindings/net/qcom,ipa.yaml     | 24 ++++++++++++-------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/qcom,ipa.yaml b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
index ed88ba4b94df5..b8a0b392b24ea 100644
--- a/Documentation/devicetree/bindings/net/qcom,ipa.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
@@ -87,16 +87,24 @@ properties:
       - const: ipa-setup-ready
 
   interconnects:
-    items:
-      - description: Interconnect path between IPA and main memory
-      - description: Interconnect path between IPA and internal memory
-      - description: Interconnect path between IPA and the AP subsystem
+    oneOf:
+      - items:
+          - description: Path leading to system memory
+          - description: Path between the AP and IPA config space
+      - items:
+          - description: Path leading to system memory
+          - description: Path leading to internal memory
+          - description: Path between the AP and IPA config space
 
   interconnect-names:
-    items:
-      - const: memory
-      - const: imem
-      - const: config
+    oneOf:
+      - items:
+          - const: memory
+          - const: config
+      - items:
+          - const: memory
+          - const: imem
+          - const: config
 
   qcom,smem-states:
     $ref: /schemas/types.yaml#/definitions/phandle-array
-- 
2.27.0

