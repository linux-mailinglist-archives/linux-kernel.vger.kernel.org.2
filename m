Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 585ED32732A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 16:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhB1Ppj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 10:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbhB1PpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 10:45:06 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963AFC061794
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 07:43:59 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id r5so9730156pfh.13
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 07:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kd0YghoHnRn1mBUwhGTbwacmxzju25Ib/4IpfEdWlpA=;
        b=KvkvtAkNI0QKvsovqYsGVX2uMWtYl3mduRmTnCgqZJR7iN2nDYJ8qaNwMZxiGKAbop
         sF9X3S5eZjSs6EKRv19d8JnOivfcFAIAMZQWO6NPG5XTB0tPaf2elzXIiRtBbV4ZsHll
         Dc8kZDfEI8mZj5iTlKBV37btYp4bpqnZC7Mik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kd0YghoHnRn1mBUwhGTbwacmxzju25Ib/4IpfEdWlpA=;
        b=X4niIO6gw4mzPDr1sRrK3KUiaasxWXSewwrMW6P3wQxPoOPtJo5H3F+nFoLGD9CIJI
         bCo5/5GA/Zww0HbZaOyqVirX5+e8az/lSkgLpur2aY8cE9KT2rqM1x81cqimbv/qo2Ko
         TOBFJFSrHCiclVAST2ATiumaE0FXXhfldac91cq+Frsemy87t6DvyQIy9AKsAObZhPSz
         VGiIWdORkyidgIGg9NgibndPqi3oHBROHK6eooVPMtZH8wggRQm9xVYi0Sa60sP5T141
         K4Xnj7qh+yVVuU0hhJYFbwdZhv6cUkZ2t8E0qZukj6OhrXdoVpcQHeQTbM2owLBMCwFP
         Uiqw==
X-Gm-Message-State: AOAM532JEYA7SXZShJJ80tSSD04r8KtJM6b87goFTqeyRgLxmE4+L1od
        efM3ED2Pfu1YJPZc1e8+xUzvFg==
X-Google-Smtp-Source: ABdhPJzda2cb80p0BH45zcK4anFLVV7cVoO6nYlRZR16HAIEGs/07fILqqKVlGE3EEPhkcN9SEeitA==
X-Received: by 2002:aa7:8b59:0:b029:1e9:8229:c100 with SMTP id i25-20020aa78b590000b02901e98229c100mr11558659pfd.19.1614527039214;
        Sun, 28 Feb 2021 07:43:59 -0800 (PST)
Received: from ub-XPS-13-9350.domain.name ([103.161.30.225])
        by smtp.gmail.com with ESMTPSA id j3sm13522133pgk.24.2021.02.28.07.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 07:43:58 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 04/10] dt-bindings: arm: stm32: Add Engicam MicroGEA STM32MP1 MicroDev 2.0 7" OF
Date:   Sun, 28 Feb 2021 21:13:17 +0530
Message-Id: <20210228154323.76911-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210228154323.76911-1-jagan@amarulasolutions.com>
References: <20210228154323.76911-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MicroGEA STM32MP1 is a STM32MP157A based Micro SoM.

MicroDev 2.0 is a general purpose miniature carrier board with CAN,
LTE and LVDS panel interfaces.

7" OF is a capacitive touch 7" Open Frame panel solutions.

MicroGEA STM32MP1 needs to mount on top of MicroDev 2.0 board with
pluged 7" OF for creating complete MicroGEA STM32MP1 MicroDev 2.0
7" Open Frame Solution board.

Add bindings for it.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- updated commit message
Changes for v2:
- collect a-b

 Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
index 56b7e0b800b3..255d3ba50c63 100644
--- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
@@ -67,7 +67,9 @@ properties:
 
       - description: Engicam MicroGEA STM32MP1 SoM based Boards
         items:
-          - const: engicam,microgea-stm32mp1-microdev2.0
+          - enum:
+              - engicam,microgea-stm32mp1-microdev2.0
+              - engicam,microgea-stm32mp1-microdev2.0-of7
           - const: engicam,microgea-stm32mp1
           - const: st,stm32mp157
 
-- 
2.25.1

