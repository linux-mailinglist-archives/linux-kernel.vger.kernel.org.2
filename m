Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899BE423CAD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 13:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238498AbhJFLZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 07:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238408AbhJFLZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 07:25:03 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407B4C061755;
        Wed,  6 Oct 2021 04:23:11 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r7so7711745wrc.10;
        Wed, 06 Oct 2021 04:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nNzJU9Y0TN+qNE5qJcuFSRHdr3qJUmf5dCSvTeevenI=;
        b=DvkR5dgnWDdBS+0qZqDLqptsMrO48mZFBOoVfrhVp1wxj0c0lqbipUlch7OZ2zz6Ju
         FJ808jczCkC64MPyLQ3ZaKyj+N60OlK4MlMcS+EKYeBqdXvtsec4ES4LUhDg+Cb9igbp
         P2qfaBhC4M3KEmlyTrfH6d7CZObxFLz7co3AJM8bwypCl6XkaeiexgM2xkaNWqQ6Zqok
         56RiOXUbl/GGEhcaCu/ffI6h9/qneYg71jDglCCaVPNfTXtWBPutm9YYGaEGR7Vs+Id1
         54sA9MQelc5oQvRlUJ3chptIlSUGFO4LaM/DhnzsUQLB29hbkyQoQahqA3qBJruBF7O7
         JtGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nNzJU9Y0TN+qNE5qJcuFSRHdr3qJUmf5dCSvTeevenI=;
        b=6mJMlM7amgCLkdyWaqibr2soI1dFaHkXtX1d57Ahg5YawItzfK+83E0SiSKIn3Lk+r
         820abfz+LkQrnXKFrmvMEl01+vxv5zw2uxZIujEqBkVUuYNIaJ5GdbASOjaDn6zFzJHa
         eqZShLEgHhK39okNxASKkcEZ0opx7nXfH82ORBAcFYyZQpRugMWTwRxRnk2VLjefXxIL
         dSbr7fvcRreIwZ+gOcrW63+jjON6LgbzBgE3QRMYywbJVLNxHOeFDFwBeePzuf9aV90z
         PVamCHnXbwdYrwGZ8Ld/nBzOQ3tmBo8eXzKllQdSlMoMmbIYA/zCnBKJ63RZD6++eQQf
         npRA==
X-Gm-Message-State: AOAM530kdEBIK9Tb8VQlENUUKLiQ632/yVhVAvWCbeF8Rne4mvDg5NSC
        ZpjNOPyiubC4eLhk4sFrOLU=
X-Google-Smtp-Source: ABdhPJxnXLZqC6UG7sG5RazrmyOBoNZVOuzAPL7APxcEs7FsSvkkn735SXc27MC7cXQ47Hksg6RmUg==
X-Received: by 2002:adf:e74b:: with SMTP id c11mr26414202wrn.362.1633519389838;
        Wed, 06 Oct 2021 04:23:09 -0700 (PDT)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id e14sm10801985wrw.33.2021.10.06.04.23.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Oct 2021 04:23:09 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-staging@lists.linux.dev, neil@brown.name,
        linux-kernel@vger.kernel.org, john@phrozen.org
Subject: [PATCH v2 2/4] dt-bindings: clock: mediatek,mt7621-sysc: add '#reset-cells' property
Date:   Wed,  6 Oct 2021 13:23:04 +0200
Message-Id: <20211006112306.4691-3-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211006112306.4691-1-sergio.paracuellos@gmail.com>
References: <20211006112306.4691-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make system controller a reset provider for all the peripherals in the
MT7621 SoC adding '#reset-cells' property.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 .../bindings/clock/mediatek,mt7621-sysc.yaml         | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt7621-sysc.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt7621-sysc.yaml
index 915f84efd763..0c0b0ae5e2ac 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,mt7621-sysc.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt7621-sysc.yaml
@@ -22,6 +22,11 @@ description: |
 
   The clocks are provided inside a system controller node.
 
+  This node is also a reset provider for all the peripherals.
+
+  Reset related bits are defined in:
+  [2]: <include/dt-bindings/reset/mt7621-reset.h>.
+
 properties:
   compatible:
     items:
@@ -37,6 +42,12 @@ properties:
       clocks.
     const: 1
 
+  "#reset-cells":
+    description:
+      The first cell indicates the reset bit within the register, see
+      [2] for available resets.
+    const: 1
+
   ralink,memctl:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
@@ -61,6 +72,7 @@ examples:
       compatible = "mediatek,mt7621-sysc", "syscon";
       reg = <0x0 0x100>;
       #clock-cells = <1>;
+      #reset-cells = <1>;
       ralink,memctl = <&memc>;
       clock-output-names = "xtal", "cpu", "bus",
                            "50m", "125m", "150m",
-- 
2.33.0

