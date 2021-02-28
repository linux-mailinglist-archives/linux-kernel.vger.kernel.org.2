Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C2E32732F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 16:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhB1Pqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 10:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbhB1PpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 10:45:23 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D543DC061222
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 07:44:20 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id o6so9840209pjf.5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 07:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y2r44D+mlU63eqpONY6ZtCXEHeBmJVOHShi6Vj77Qp8=;
        b=qjeVCLpcLxJNtoRnvg6VpGo4yd0Vik283yhpWyslsc2Ex2IdXmNSO943vDnxW671LS
         pmtLU5aZPG9blMVAzgC2T3MvB2Vmw3Y1CV7CkdYqpR70JTyqoFGz6cYFkXNxFc4oMLzh
         6mMyJ818t4rgNp3gzCPFL0YjxyLREZL7CUV6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y2r44D+mlU63eqpONY6ZtCXEHeBmJVOHShi6Vj77Qp8=;
        b=CTW9JwrYhZfBm36UeJT9NUmLQdjyfPrp8jweAjSiQuTNy/PP4RCfec3i9C5tpM/mM5
         1pLIvHa+0GDCe9AfvGnx9CxtFxhUv0kmHWzDb2ycUorNyI61v7kiklCmpueZ9i9DqrUg
         fKC6cXIOsXI+LVdhvJQBIWp79I9WceeZGnkZaUmfR3sOVmMdT3shBF2WIvm1tRV7h85u
         1Nie1AZfF6MdppKMqNql/9CbbIpV/wqNTWf8LlB527fiwFQcXU5XI+V2ugJQ+oUNYoht
         ZkL1Wp8ZNM+ZHFsp4yJg2+IbE4A614FwwEfToo8sGI+V+4OpWORkscmRV9UiHZH9n8gO
         i8lw==
X-Gm-Message-State: AOAM532zvwYHNvdWk4MN3RhkyI7VHvf923W3PQ9mV/PVXWapY1zOe1Ee
        Xtf2lZumsQwBVQTUeOmKn7LoqA==
X-Google-Smtp-Source: ABdhPJwEv08iKd05ZoMnHpQK7jYmGuWwDlfrl9dfUX2nAm4FpZn5eTTV7ys/X6Ma2DX/KuQKAs/+1g==
X-Received: by 2002:a17:903:230b:b029:dd:7cf1:8c33 with SMTP id d11-20020a170903230bb02900dd7cf18c33mr11415224plh.31.1614527060455;
        Sun, 28 Feb 2021 07:44:20 -0800 (PST)
Received: from ub-XPS-13-9350.domain.name ([103.161.30.225])
        by smtp.gmail.com with ESMTPSA id j3sm13522133pgk.24.2021.02.28.07.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 07:44:20 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 09/10] dt-bindings: arm: stm32: Add Engicam i.Core STM32MP1 EDIMM2.2 Starter Kit
Date:   Sun, 28 Feb 2021 21:13:22 +0530
Message-Id: <20210228154323.76911-10-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210228154323.76911-1-jagan@amarulasolutions.com>
References: <20210228154323.76911-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.Core STM32MP1 is an EDIMM SoM based on STM32MP157A from Engicam.

EDIMM2.2 Starter Kit is an EDIMM 2.2 Form Factor Capacitive Evaluation
Board from Engicam.

i.Core STM32MP1 needs to mount on top of this Evaluation board for
creating complete i.Core STM32MP1 EDIMM2.2 Starter Kit.

Add bindings for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- none 

 Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
index 3e45516403ce..01f595b8ae1b 100644
--- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
@@ -67,7 +67,9 @@ properties:
 
       - description: Engicam i.Core STM32MP1 SoM based Boards
         items:
-          - const: engicam,icore-stm32mp1-ctouch2    # STM32MP1 Engicam i.Core STM32MP1 C.TOUCH 2.0
+          - enum:
+              - engicam,icore-stm32mp1-ctouch2       # STM32MP1 Engicam i.Core STM32MP1 C.TOUCH 2.0
+              - engicam,icore-stm32mp1-edimm2.2      # STM32MP1 Engicam i.Core STM32MP1 EDIMM2.2 Starter Kit
           - const: engicam,icore-stm32mp1            # STM32MP1 Engicam i.Core STM32MP1 SoM
           - const: st,stm32mp157
 
-- 
2.25.1

