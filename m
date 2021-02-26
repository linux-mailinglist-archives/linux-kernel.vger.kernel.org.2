Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7851C325E07
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 08:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhBZHHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 02:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhBZHEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 02:04:55 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F53C0617AA
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 23:03:49 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id l7so1440624pfd.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 23:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D/d2tckrMVKCx/WifVyWum2XtWgDvcfG6jZTIiFStpk=;
        b=HPQRuoGEIWqGl2DIghlM8yyibdziQxu2W9nXbjkJT/Toxlh5BHol8NZchUBIrY3mI7
         zpMlnOtwGXZkVul94RZ/qnEFIpUMTZGvLsp+60760e1XaB2mx2W4ZZQM6A2y0eQwNZVC
         8zUlsMOnAC+ADZBsWhpBTN6QQv355mYhVTmCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D/d2tckrMVKCx/WifVyWum2XtWgDvcfG6jZTIiFStpk=;
        b=nLNv6YOeRuE3QZYWdXZ+aH6G82SXGBRbItWIVoIgBDGTeNZwOeg/n8yI+7bXK7n1Dx
         E5W+lL67iPbIZfhEso7nNVhrSPd8mMWR8aBO8OI8LD8Qndti9PN425KDYUvx8XWTbbU9
         nmzTzXmoeShEk/UTKvlQNRjCOiRVfp2i57QbUge7NvNL2/yjzFYsZ21yIw+fNZxNApea
         JcO/TwBUWhOrQaaXvn3o+4oe9zpeau4v4E4+Z64BbGMj/EJBkNVg8PjjPZq58Ma6oCnr
         H11+8Ch/ivoXS16Nz71QBreEB2QV4DZqN4I32A0/Xt+M/QPptu77FCNeowTYaOEbaSe9
         AA2Q==
X-Gm-Message-State: AOAM531sXI3TDE5ucZdYNw36VZjlD/6xP0fmay3YOE4zS1h8JSyy8yUQ
        W6x/q8LScDfdrffqZikzziiPYw==
X-Google-Smtp-Source: ABdhPJzpzKTJP4NydabR1Y9PJh1zQsv+pWAx6CRm8aJv29M8B6kKBN6CG5AIai0EiZbYVbE4K1rpdQ==
X-Received: by 2002:a05:6a00:851:b029:1b3:fbb3:faed with SMTP id q17-20020a056a000851b02901b3fbb3faedmr1816039pfk.18.1614323029166;
        Thu, 25 Feb 2021 23:03:49 -0800 (PST)
Received: from ub-XPS-13-9350.domain.name ([103.161.30.220])
        by smtp.gmail.com with ESMTPSA id f7sm7592156pjh.45.2021.02.25.23.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 23:03:48 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 06/10] dt-bindings: arm: stm32: Add Engicam i.Core STM32MP1 C.TOUCH 2.0
Date:   Fri, 26 Feb 2021 12:33:00 +0530
Message-Id: <20210226070304.8028-7-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210226070304.8028-1-jagan@amarulasolutions.com>
References: <20210226070304.8028-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.Core STM32MP1 is an EDIMM SoM based on STM32MP157A from Engicam.

C.TOUCH 2.0 is a general purpose carrier board with capacitive
touch interface support.

i.Core STM32MP1 needs to mount on top of this Carrier board for
creating complete i.Core STM32MP1 C.TOUCH 2.0 board.

Add bindings for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- new patch

 Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
index 255d3ba50c63..3e45516403ce 100644
--- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
@@ -65,6 +65,12 @@ properties:
           - const: st,stm32mp157c-ed1
           - const: st,stm32mp157
 
+      - description: Engicam i.Core STM32MP1 SoM based Boards
+        items:
+          - const: engicam,icore-stm32mp1-ctouch2    # STM32MP1 Engicam i.Core STM32MP1 C.TOUCH 2.0
+          - const: engicam,icore-stm32mp1            # STM32MP1 Engicam i.Core STM32MP1 SoM
+          - const: st,stm32mp157
+
       - description: Engicam MicroGEA STM32MP1 SoM based Boards
         items:
           - enum:
-- 
2.25.1

