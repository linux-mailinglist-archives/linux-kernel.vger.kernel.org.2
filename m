Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316A43256B7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 20:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbhBYTbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 14:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbhBYT0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 14:26:04 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58ADBC0617A9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 11:25:24 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id d2so4155883pjs.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 11:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WkeyDiUKGdiVN72dvbdcS3OxsMAMD2K9XdTBr4I/WcQ=;
        b=LFdhWnIFu+zCPQmZ10bRaq4zQh/v1ICR0IP8PpSlAM38X/zNPVnjh68EEIuoew3qHz
         27wOeTB3iWXWyW9t1lzV5szCWyMmAyOvcYhPJv4pgSq4Lgk/14bdgDEik7oTBqHUtbGj
         8XJTF6eRJpWQZew3uyCUGYmGbNcGOozA1qkgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WkeyDiUKGdiVN72dvbdcS3OxsMAMD2K9XdTBr4I/WcQ=;
        b=N2jIvUEQpqgF1eyqXL4x37ag5VV/vXpMraJOfhQ9Lm4FHohccF1seIIuvmIlyPEXQk
         09NOlDNKsfsBabND7oF6KZ5g+wXgz61wjZViAfk/+aQnfQdkLgXS9m4mejSJUeWJfHzP
         HN968vGM7AWulp6SOjt5U1JVZXypGeFATMQsfve3/0BzUIBRtlb5D1BG+DeV5WAJR2wx
         DxL8gnuuaURUGnUllfVy3CjeM/ffVkN9JsXQfsV3+M1HKRVxwmfCa8+nXWetIY6M/mz/
         JBF5lH6NZNK5wu0RccffSOJgrpV+sG823dafYg0vPJDIMGv3pVvMKyjpHRu0+thj5Upd
         RCBg==
X-Gm-Message-State: AOAM530kFI0RsIQr3KFzixP32cAAta+DiiNYelxhrqI97+6B0624HpIw
        D4jCCFyvyTVHuWPeOnZlIv86Mg==
X-Google-Smtp-Source: ABdhPJwQiKEnStPSbgbTXnExcMBeAL2J6ZWpT29U2MixkW3MxhL1xOS0BhKGlBWcsXBQraS9zFhsFA==
X-Received: by 2002:a17:90b:30cf:: with SMTP id hi15mr4521908pjb.131.1614281123919;
        Thu, 25 Feb 2021 11:25:23 -0800 (PST)
Received: from ub-XPS-13-9350.domain.name ([103.161.30.220])
        by smtp.gmail.com with ESMTPSA id c78sm7025787pfc.212.2021.02.25.11.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 11:25:23 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>
Subject: [PATCH v4 4/5] dt-bindings: arm: fsl: Add Engicam i.Core MX8M Mini EDIMM2.2 Starter Kit
Date:   Fri, 26 Feb 2021 00:54:03 +0530
Message-Id: <20210225192404.262453-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210225192404.262453-1-jagan@amarulasolutions.com>
References: <20210225192404.262453-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.Core MX8M Mini is an EDIMM SoM based on NXP i.MX8M Mini from Engicam.

EDIMM2.2 Starter Kit is an EDIMM 2.2 Form Factor Capacitive Evaluation
Board from Engicam.

i.Core MX8M Mini needs to mount on top of this Evaluation board for
creating complete i.Core MX8M Mini EDIMM2.2 Starter Kit.

Add bindings for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes for v4:
- collect ack's
Changes for v3:
- fix dt-bindings
Changes for v2:
- update commit message

 Documentation/devicetree/bindings/arm/fsl.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 949442d4f385..6d86a3a24983 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -690,7 +690,9 @@ properties:
 
       - description: Engicam i.Core MX8M Mini SoM based boards
         items:
-          - const: engicam,icore-mx8mm-ctouch2     # i.MX8MM Engicam i.Core MX8M Mini C.TOUCH 2.0
+          - enum:
+              - engicam,icore-mx8mm-ctouch2        # i.MX8MM Engicam i.Core MX8M Mini C.TOUCH 2.0
+              - engicam,icore-mx8mm-edimm2.2       # i.MX8MM Engicam i.Core MX8M Mini EDIMM2.2 Starter Kit
           - const: engicam,icore-mx8mm             # i.MX8MM Engicam i.Core MX8M Mini SoM
           - const: fsl,imx8mm
 
-- 
2.25.1

