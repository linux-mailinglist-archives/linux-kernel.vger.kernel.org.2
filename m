Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA2C3E01BD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 15:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237981AbhHDNOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 09:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237972AbhHDNOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 09:14:07 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8031FC0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 06:13:54 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id i13so1597660ilm.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 06:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=16q7EqqyfEhwetWb0XYAPotm+XuJAb7KckeFFuyZn6k=;
        b=URaICnYo2fzFjMRGWMjcx7FktVrKjirxd33+rMnDvTa5e29Yg/KDItyfGl0UHCFwJh
         /8Vh0SrA2SXk46h4aix1i4Pm8GqdE4i9KC8V8xQo0VSoahukzJGk42RU+2XwGLOx2srk
         25ULQrAKKMTA89tgkVVUYFKRKpvNGzqqnz5R4HqeDzWjtt60+ENg5pcGS+tuqUt4rMpk
         3QE7N2bAimMjO3Bbg2BMMfbp+uUJxIwqZJ+ESRlbs0bLiwtdIomEu46BiYCzlAW6yKTg
         J5VmjAPy6rg5wDzBzQSI3+JEaJx6WnYfvNsYzyygO6B6J+lAJDC2oUFhyr2xMBAQHpw6
         X4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=16q7EqqyfEhwetWb0XYAPotm+XuJAb7KckeFFuyZn6k=;
        b=TqBevnABehPGubwFJofmkjZD+E60stXpKY+gdmpcvFLaDAZrKUZqFtm27NnZ8KU9Ei
         l4w/dpspy42X+LpmmambEBom/mnHjiC04YjeOJf2TwMIoNY/1nHVf0gttLw9JSO20sGO
         2UEqkaCf5g8bnEy9tBdVSjb5Bac8kWYQiaQ8geg5JoLtfahI7ytrKlXO+ZkrSilmSlXF
         +cPcXCiZWd5TWw5SgGOCcBAgxwE9+v2juqEtSlVqazzfXQd5f/y1Cu0p6mN0BaTPjwSs
         Hx7I/aH5WgGPnmDdM9O7xDBfYForTlsot10xVpjC1YUKO0zX40vZu04Ir41UEE8kxA0b
         xjkQ==
X-Gm-Message-State: AOAM530aazzcEpURfQqhozGOTKkhd4mTuGO6x8VnvUNaybpLdiGb7Qpe
        sJNu/TR95a6J7tLcc343SPooXA==
X-Google-Smtp-Source: ABdhPJwTrepWzQ7jGOdI0Mb9wms6UHeS7O+Km+3F27wf2nrd8WPKgG2Mn3DWoUXO0NGlImWihwW7vA==
X-Received: by 2002:a05:6e02:1561:: with SMTP id k1mr404140ilu.25.1628082833939;
        Wed, 04 Aug 2021 06:13:53 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id q11sm1073012ile.71.2021.08.04.06.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 06:13:53 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     robh+dt@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org
Cc:     elder@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: net: qcom,ipa: make imem interconnect optional
Date:   Wed,  4 Aug 2021 08:13:49 -0500
Message-Id: <20210804131349.1179832-1-elder@linaro.org>
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

