Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE5A31EAD6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 15:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhBROSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 09:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbhBRMeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 07:34:12 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A46CC061756;
        Thu, 18 Feb 2021 04:33:50 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id l12so2812471wry.2;
        Thu, 18 Feb 2021 04:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q7hTaTjEktQayBeJF7D7v5YrqX7t2OleIFqQLeW+OGs=;
        b=GOrP51z0N9eEMg0M5CuALDagXCUp9qDdh/4ybAkOXr4QhzbCZm0hXFzbTDtGTXp5AH
         htyNDlQimTAlTF4HZ/eML6XU1aig6Em/Ojoqsv6I7o4d1PpbNfXP0GhGfaw6wkn6ahJ9
         LPugBPK551hSD+cmTTQR3xIYicx/nHCeCVwatWfEtUvAqAgM5FY1//tTB7NWH8Hz7WpA
         7Rfcn5soHV+DUz7swuJ+ItWUUDmEBPLrEp+CSFvfJhnRQIHvbEGUl8Uqp01hR32KEyQe
         Vd03n9G604PXbrZ1XTiXHpKNbDeuJee9Camis1Ln/9Ae2jD9/8Cf3pmeYAXCmtANEBgH
         ywgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q7hTaTjEktQayBeJF7D7v5YrqX7t2OleIFqQLeW+OGs=;
        b=cNFu7VAKwkHKWWUeXjuNAsePhWM/PpQjNumnZ8qDfKW6k4DS3Vw1HxGuMr698vDUJi
         bfsOLZkCF1w5vmc534V7dtEYIktCIFfm0wT1mYCiFVjohZscsYRs6yLEH4ohp70Qtc2D
         bQJdQix2TBZ8oi6H6T6eKSIpmuMzhBILOmhMO5Rnu1PH23rnA/Cb03AI9wMysCwKlrR3
         KWeif98J6y98a9rqpqQdkC0VdA6Ms1Qy7Xnerilx1HrNVCSIdnXNe560NLz3jRe2Shal
         ksFdU9Y/rAJSHkooHqc7JubCvcGtgbL2V64aWqD+/0Z+zlyI5tdbq+lO6F6HlkZqjwLt
         RFiA==
X-Gm-Message-State: AOAM530eFqY061AWydwAHVx1frUz75A07mjXf3UVZJ1UzLa82oC6l/zX
        lFC00Iym7gI4NJ9UBCdCmMM=
X-Google-Smtp-Source: ABdhPJyliMeiPPJHGqZSkuysSI9KT61vEcAfjffNkJgfMrgjmCBylVql/moODfHg3nZsJpAtCg2EZg==
X-Received: by 2002:adf:f80f:: with SMTP id s15mr2763486wrp.1.1613651629107;
        Thu, 18 Feb 2021 04:33:49 -0800 (PST)
Received: from hthiery.fritz.box (ip1f1322f8.dynamic.kabel-deutschland.de. [31.19.34.248])
        by smtp.gmail.com with ESMTPSA id z2sm7110818wmf.46.2021.02.18.04.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 04:33:48 -0800 (PST)
From:   Heiko Thiery <heiko.thiery@gmail.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Michael Walle <michael@walle.cc>,
        Heiko Thiery <heiko.thiery@gmail.com>
Subject: [PATCH 1/2] dt-bindings: arm: fsl: add Kontron pITX-imx8m board
Date:   Thu, 18 Feb 2021 13:33:27 +0100
Message-Id: <20210218123327.25486-2-heiko.thiery@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210218123327.25486-1-heiko.thiery@gmail.com>
References: <20210218123327.25486-1-heiko.thiery@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Kontron pITX-imx8m board compatibles binding.

Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 297c87f45db8..0a0d03dd5e31 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -734,6 +734,7 @@ properties:
               - fsl,imx8mq-evk            # i.MX8MQ EVK Board
               - google,imx8mq-phanbell    # Google Coral Edge TPU
               - purism,librem5-devkit     # Purism Librem5 devkit
+              - kontron,pitx-imx8m        # Kontron pITX-imx8m Board
               - solidrun,hummingboard-pulse # SolidRun Hummingboard Pulse
               - technexion,pico-pi-imx8m  # TechNexion PICO-PI-8M evk
           - const: fsl,imx8mq
-- 
2.30.0

