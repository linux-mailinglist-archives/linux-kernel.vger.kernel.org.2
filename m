Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6707D458C39
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 11:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239177AbhKVK11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 05:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238979AbhKVK1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 05:27:24 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52D9C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 02:24:17 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id c32so78435121lfv.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 02:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NlnKYCaiVTlC+mtrTi+BnSPdg787Fabhf2grE4cGhVg=;
        b=OgWmfhNGtb6Qto7L7mtREOBGCa6VfSMb9t1XoyWeYqarLppiFO0jj/77NYgfG6aSbC
         OFwphu7ZYT1AnxN/a3aIXUWHAxsh7HkAaXfEE1EFNczPFqnm0n5ht1b6DY7sBM2QJFuZ
         cP2mW7nrJzXdpOuUFuM/4peLmLgwSTIDDJG7T2nO3YdxGfARvKEACVjJP2xcuQhmTQ1D
         a2oLoRLKJiho8CDTFVWBXOJ8Xg8Lc6YTCXCqHSFAV/TnRDJ8+PYooQv8j9N3VPyPKdhI
         EtHD/MKRDu9XIX6WQFiAi5BuV5uXEQjRAXQtJXsxox0jzfi/uyK8xG8K7LZ+YwXyzbN3
         L6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NlnKYCaiVTlC+mtrTi+BnSPdg787Fabhf2grE4cGhVg=;
        b=1+EuzOG3Nok4i2TmtAupyZv/fmygvMfqMJ7YZZBj6dWDzG0FIUtLfeV8mofv5XU+8S
         OxLKhXlUALFqqHPjmkVotDjr/Q2qxhKEXz3BWyfim9hwZVdnXnq6bzIwI93W9IJ7GjdX
         EPaOSWg3K+zgUPguzlC6AsENG4NEizyB010JLCbVzqg0PjLz7xIhGL20Kma3B/vCWvCB
         Aom7g3u7anXOJvAVX3hq79sfcfvEffWteMMU8kEJHBy2caPaauU87isigsHDe+sLvgyp
         sjrRvtBkPV/BpTmcgEe3Wnf7v3/JBTGiMGChso/o/9p+epDc1Ra+d3+iuNGWsZUG6Vzs
         Jsxw==
X-Gm-Message-State: AOAM531DOOB72r/kcixlIu/Mj+bCn8mcuE4mvvul+3Yys+3J0YnDUJ3e
        pyFLrBtB5jgI0TCx8/eaC2cABg==
X-Google-Smtp-Source: ABdhPJxAxet09sS6Z7UrpaJdUHYGz6eXBH4R5AcTQwwKI7Jew0AneRXrW7gCxxyXMS/BfN+lSNQWwg==
X-Received: by 2002:a05:6512:3083:: with SMTP id z3mr54909586lfd.626.1637576656153;
        Mon, 22 Nov 2021 02:24:16 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id y20sm913223lfk.231.2021.11.22.02.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 02:24:15 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: mfd: Add Freecom system controller
Date:   Mon, 22 Nov 2021 11:22:10 +0100
Message-Id: <20211122102210.3137559-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a DT binding for the Freecom FSG3 system controller
found at CS2 in the Freecom FSG3 Intel IXP42x-based router.

Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 5de16388a089..b62e1e299d31 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -39,6 +39,7 @@ properties:
               - allwinner,sun8i-v3s-system-controller
               - allwinner,sun50i-a64-system-controller
               - brcm,cru-clkset
+              - freecom,fsg-cs2-system-controller
               - hisilicon,dsa-subctrl
               - hisilicon,hi6220-sramctrl
               - hisilicon,pcie-sas-subctrl
-- 
2.31.1

