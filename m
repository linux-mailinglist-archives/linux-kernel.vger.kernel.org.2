Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B79325DFF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 08:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbhBZHF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 02:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbhBZHEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 02:04:49 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7F8C06121F
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 23:04:01 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id l7so1440981pfd.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 23:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H5ONZrvpdGLBeEhP6dKpELUCZIs/O1Jms+ZGZ6m8aRE=;
        b=aL/RX4iF+lAsGmuu8/h3m/g6zn1OpiBbgiaRvlCad1bFGvJGUfoe+2ycg26HaBalse
         Gsw8WzGl6pnGuUhjoej7BTef7XuPuOdeNL9tW2fax1WFBEgHAdL/WoOubQEh5nzpe4CM
         O7TwCMvb2lZtHO2MjqFDrKL3itgVTCz5XA5G4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H5ONZrvpdGLBeEhP6dKpELUCZIs/O1Jms+ZGZ6m8aRE=;
        b=inqOYb/aqsxTAgVW6rbzZpV/VVLLWxJiCYqzd0xZiK3gK+iIdi42lBMoQMcB/+ONXK
         DffrjUD6WFbjARPF8MfraTP1jRH1YTOSeg4A+XA8Z3c8e3PrAr46fwl9R65itsn2Agvb
         2DsKbJMoxq8qTOJi71ki3ltRfIuC/Cb+5/0vMQa57ffPdfWWOSyaCyWJmhv43ih+qka+
         BkyHs/zvuDjgND3gH+C2y3BMDUj+51NSdI5WmAssqcUOxGO54MPPSdenk1cmGk8k/tmZ
         NU7rKxfhcZAW4lEp8/qU3Ld3riQSvoc27T2siZK1Db/y71nCLuSdHHU/3fKntAoutk4g
         VsOQ==
X-Gm-Message-State: AOAM533bWMUZyZwdqZu0iQ1DtJbcuOlibaWqzL3f0Z8jAYxGZZFk+Mix
        dpK7u/ZXNWj4fBsRZ5Q85MT9X+bqM+rPcA==
X-Google-Smtp-Source: ABdhPJxx8z91KvufB3lW59XRA6jNw4jec5ae8E8yWQhj2M5jtLWHmpJmAUE3uraSNBQrsOBUJiGnxg==
X-Received: by 2002:a63:708:: with SMTP id 8mr1692787pgh.277.1614323040857;
        Thu, 25 Feb 2021 23:04:00 -0800 (PST)
Received: from ub-XPS-13-9350.domain.name ([103.161.30.220])
        by smtp.gmail.com with ESMTPSA id f7sm7592156pjh.45.2021.02.25.23.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 23:04:00 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 09/10] dt-bindings: arm: stm32: Add Engicam i.Core STM32MP1 EDIMM2.2 Starter Kit
Date:   Fri, 26 Feb 2021 12:33:03 +0530
Message-Id: <20210226070304.8028-10-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210226070304.8028-1-jagan@amarulasolutions.com>
References: <20210226070304.8028-1-jagan@amarulasolutions.com>
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
Changes for v2:
- new patch

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

