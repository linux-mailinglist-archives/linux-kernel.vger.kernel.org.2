Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2A53E936B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 16:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbhHKOSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 10:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbhHKOS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 10:18:29 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D944C061798
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 07:18:05 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id k3so3021849ilu.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 07:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LDWP9qisBxFdueMqiOTeG0NsmbdU+x+l/xp0sQwGHd4=;
        b=WO/JfNQFytTyy9YMRuVLi7YfkL9EWNVf3vMlugzUjYyHGImqe/zrP0msZjp+R5UMaI
         Z6txHSWra1O3C49h3bR+/FF0q5h1BqlUHJch1M3gsDr89UR+QTGYsp7zLSe1dGyOQl8T
         IJHiaVDTmiWd5W39HhEIkGc9sv1houRJnCGLBDtxQ2fJO2Me0u2hhGg8h4bJC1+D/ytZ
         evCDTbYjpWTP/Vbn+yc/ZFcOKtKOq+uBsKFOion6GeNbXcAnL+hr7sRPpC37ClE00aD6
         DGZxWwWLRKv9/1FFAUbTts0ae9JVwnqgrG9rrX2Rcl1uexKhpBlKQ6HGzAdVuWny1+lp
         3+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LDWP9qisBxFdueMqiOTeG0NsmbdU+x+l/xp0sQwGHd4=;
        b=pVij1IrU6lbi68fNDb0xLtF4/RZIF3EoBkA4gdDlMOCCzmlbA8OJmeNV7uLpQUkYUi
         2n7thfAxHURaNTDqALZ2Ntznnwiki+5yUPDLwmGFDNagAXFmYnwgT2e7UtSP75pO7rj6
         vhUc9B09kMSjBdPlPygAteib3H+nfekXL1BS/BHLs7TRogqWLvp9BUuoQGevUgRpj0rV
         K0RhkaRclkenJiPFnD8NCKAKlnH8dgOvUrNbJaf/vo/MR0RIeqqWRJ+2mvuY9zZIN6jx
         2HZbNFQWh/gPePPHHo4hhQODkQAY9tRJjJT+mz0Ob2BFPsTj+FYkCYWpWaFd6JrU1tvb
         f5GQ==
X-Gm-Message-State: AOAM533bB1rNiV0JFwqMQZRzBu8trImdAAi2XeVP8/sKJqKCE3UlhR98
        qUlBtP9DcKnQsgRFRnk4swQGUw==
X-Google-Smtp-Source: ABdhPJzce3iTAAaoGtIR+QNCm0uokAhIEHbadQJi8RMqBWXFTFRUmUPU3BgJvyPd+jOeEnePjMAmww==
X-Received: by 2002:a92:c601:: with SMTP id p1mr73562ilm.284.1628691484831;
        Wed, 11 Aug 2021 07:18:04 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id m184sm14287014ioa.17.2021.08.11.07.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 07:18:04 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     robh+dt@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org,
        evgreen@chromium.org, cpratapa@codeaurora.org,
        subashab@codeaurora.org, elder@kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4] dt-bindings: net: qcom,ipa: make imem interconnect optional
Date:   Wed, 11 Aug 2021 09:18:02 -0500
Message-Id: <20210811141802.2635424-1-elder@linaro.org>
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
v4: Hopefully I included all the right addressees this time.
v3: Based on net-next/master; sending for inclusion in net-next.
v2: Based on linux-next/master.

An earlier version was sent with some DTS updates and was accepted
into the net-next/master branch, but later reverted.  Bjorn accepted
the re-sent DTS patches into the Qualcomm repository; this patch
should go (by itself) via the net-next repository.

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

