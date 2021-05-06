Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25763752E3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 13:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbhEFLQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 07:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbhEFLQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 07:16:35 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620DAC061574;
        Thu,  6 May 2021 04:15:37 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id l2so5167746wrm.9;
        Thu, 06 May 2021 04:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bcj0pWWA8nFHZcaEeJrGAFY0Y2i6kRxQp4Wf+dRkrMc=;
        b=nx33U0MdKytL2LeL/A3OBCQcElimwWw/4yEPpHFwZbFDqisrnuREQLuAZyx6jvlrj5
         58b3UFV9rfe94VikNAaI3ueEPEzBPPI+LdGlhP6ZOrbhn0oDAzn2XS6uyOGvYA+2NUb4
         5/wGOKqulsUeNdvxzpb+ULOH/m6a1ggvUUwRszekCdlmOPSxOU8HFgjoNrL8JRhlJ1Wz
         MBgWZ4VCPS70SSWsFZVNMqkVCE1i50s7huEVZEx40X2N5gG7VzNMJO0FJfVyfTpLvAt3
         6JrDRkA4VXw94kiB2n0LHLUE7Gywwcn/rSLvDehqTiOqtguPnMQ80xFnsF+znBHRqW6Y
         DybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bcj0pWWA8nFHZcaEeJrGAFY0Y2i6kRxQp4Wf+dRkrMc=;
        b=EBs+HqQkbIC5Lawhv9rI7bDbT2AilmI3omSVE1MSIGOqTpNeF3Bw+JGaa4tzlbiTB+
         KeazuXT6sNZtpvD0G+VzZSGVvbnTXbDcvTBEOvgZ1EiMNAttr/hPP7uFjbZTiHiZmfRB
         w6eygCNW7JvZYty+DXwmj8WT0Moqmg5PvWjjbDwqizAVnA2k8A/cp4RyqKRPfAHTQzkt
         LdAHkcVg62g2HJipX5VCBU3Pgi4qkCXXJep3Cge25pmbmVoGK24rxSXMJKRkS2k09Qq8
         /GVHDTS9Oadxxt7IbWnKeh3QGZiPLQUOBf8iYNH471VoqrJuQqd3vE31/WP0SFolHIke
         tOAg==
X-Gm-Message-State: AOAM5330KYFNRNcvVetRQc99pqhZo3hXEuq5Q9Dv4TC+WufmrTlmu3yC
        7xeAyXqROh6pq3Or7Wst64s=
X-Google-Smtp-Source: ABdhPJxJ9grl1B/XxF/8opkBocpLHYlo2dk8HqNadhlsu7dvjNCfyEqecrxPRlVTxJXSiMy/6ZpGiQ==
X-Received: by 2002:a05:6000:1541:: with SMTP id 1mr4539384wry.364.1620299736213;
        Thu, 06 May 2021 04:15:36 -0700 (PDT)
Received: from localhost.localdomain (231.red-83-51-243.dynamicip.rima-tde.net. [83.51.243.231])
        by smtp.gmail.com with ESMTPSA id u5sm3642433wrt.38.2021.05.06.04.15.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 May 2021 04:15:35 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     vkoul@kernel.org
Cc:     linux-phy@lists.infradead.org, kishon@ti.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
        neil@brown.name, ilya.lipnitskiy@gmail.com
Subject: [PATCH 2/5] dt-bindings: phy: mediatek,mt7621-pci-phy: add clock entries
Date:   Thu,  6 May 2021 13:15:28 +0200
Message-Id: <20210506111531.21978-3-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210506111531.21978-1-sergio.paracuellos@gmail.com>
References: <20210506111531.21978-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT7621 SoC clock driver has already mainlined in
'commit 48df7a26f470 ("clk: ralink: add clock driver for mt7621 SoC")'
Hence update schema with the add of the entries related to
clock.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 .../bindings/phy/mediatek,mt7621-pci-phy.yaml        | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.yaml b/Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.yaml
index 0ccaded3f245..d8614ef8995c 100644
--- a/Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.yaml
@@ -16,6 +16,14 @@ properties:
   reg:
     maxItems: 1
 
+  clocks:
+    maxItems: 1
+    description:
+      PHY reference clock. Must contain an entry in clock-names.
+
+  clock-names:
+    const: sys_clk
+
   "#phy-cells":
     const: 1
     description: selects if the phy is dual-ported
@@ -23,6 +31,8 @@ properties:
 required:
   - compatible
   - reg
+  - clocks
+  - clock-names
   - "#phy-cells"
 
 additionalProperties: false
@@ -32,5 +42,7 @@ examples:
     pcie0_phy: pcie-phy@1e149000 {
       compatible = "mediatek,mt7621-pci-phy";
       reg = <0x1e149000 0x0700>;
+      clocks = <&sysc 0>;
+      clock-names = "sys_clk";
       #phy-cells = <1>;
     };
-- 
2.25.1

