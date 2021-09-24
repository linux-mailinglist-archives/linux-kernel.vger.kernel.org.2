Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D0F4175F2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 15:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345841AbhIXNgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 09:36:25 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:59860
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346713AbhIXNgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 09:36:14 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 02CD540784
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 13:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632490481;
        bh=5+nyS+8H1EI+4wuDtZ6/wTKJyuB2Y7OoOebqtWuTbI8=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=IebxzWtCbYD9OV0JtniqRiMJ5vH8eO8N5EkndichL0k6iHXT3vdJE0jYzwrwboth/
         mzByZsJaFiegDqte4QlF56GHl3oADqQ9bFnJs3F7U+fh8JnXbJIGms35lZaXQxj7hp
         V1L8Se0wNKvGLZptrNQAifxgc2Nyqyn1ekPl2a18F91gkpUXsALxd+Ece3vEK+zGX/
         hX1z3CIJn9vYEUA9tRmsUQWLPzuo+6bHZCdGxALV8jdg1BpDaMk28+8FkvfxkIf2rU
         9g5y2gZ9dffRiow4UyeMj3QKpirNIdrWu1LSfIOuwjhddTdtD/+FohX/lN7gSH++zT
         ynEc87LAS2deA==
Received: by mail-wr1-f69.google.com with SMTP id j16-20020adfa550000000b0016012acc443so8090038wrb.14
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 06:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5+nyS+8H1EI+4wuDtZ6/wTKJyuB2Y7OoOebqtWuTbI8=;
        b=Wb9hpK850OWPWz+jznrARdwFnPjjQwcYsxOh74KylM53Yq/GWoT1WWwvqmZMn06nlB
         RChjQiMnXnD9uDv5iXyPHBUmhdPpRDmSEJh9NW8EJEU6FKn8Z9Rf4sAP+u5rQ6xhcLMg
         0xh11ob3XE+121X49CG1cNzrRp0XA2tVBDkczr0zfX40dsUcRkM/pll0bQpoxmo79INS
         50JfLWSK5CpYIlozwMDIkc78/DZqPeQpz8PN2obyl4tFOUu8VzqZi8w3mLrHXFPrPI5y
         /t7rxrgg4RjYIW9/Bw5mXqIvltTVPCyMgMoga2SG9RRAbMfbj2rS6ucHNXUK4pNVeZWE
         o7xg==
X-Gm-Message-State: AOAM531GC1MxT+UiQj5kXWfC8UmhI0IXa5VD5GklIhl3/froavaxrBGh
        6XzJApFL4YyfwVz4cV98WCGuZR1OpC0RKk0FSVnxKG0GKOkf6i2trBcmgoLzJ6GJLNc9U5Pydb2
        iZUujI7gOfiEi+KuJHH+uuZ7Q1a1cTtPLZIVQGinTOA==
X-Received: by 2002:a1c:21c3:: with SMTP id h186mr2196076wmh.18.1632490480726;
        Fri, 24 Sep 2021 06:34:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwD8TiymTUOSk80Xbr11Auvywd8mj3T7jXFVBsXWifcr1B2/E9Cd30auAL2+T5fNBUS3S8NQ==
X-Received: by 2002:a1c:21c3:: with SMTP id h186mr2196062wmh.18.1632490480577;
        Fri, 24 Sep 2021 06:34:40 -0700 (PDT)
Received: from localhost.localdomain (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id q7sm8297225wru.56.2021.09.24.06.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 06:34:40 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH] memory: samsung: describe drivers in KConfig
Date:   Fri, 24 Sep 2021 15:34:06 +0200
Message-Id: <20210924133406.112174-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rephrase the Kconfig option and make it clear it applies only to Samsung
SoC.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/memory/samsung/Kconfig | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/memory/samsung/Kconfig b/drivers/memory/samsung/Kconfig
index 8e240f078afc..7fb70f573031 100644
--- a/drivers/memory/samsung/Kconfig
+++ b/drivers/memory/samsung/Kconfig
@@ -14,11 +14,12 @@ config EXYNOS5422_DMC
 	depends on DEVFREQ_GOV_SIMPLE_ONDEMAND
 	depends on (PM_DEVFREQ && PM_DEVFREQ_EVENT)
 	help
-	  This adds driver for Exynos5422 DMC (Dynamic Memory Controller).
-	  The driver provides support for Dynamic Voltage and Frequency Scaling in
-	  DMC and DRAM. It also supports changing timings of DRAM running with
-	  different frequency. The timings are calculated based on DT memory
-	  information.
+	  This adds driver for Samsung Exynos5422 SoC DMC (Dynamic Memory
+	  Controller).  The driver provides support for Dynamic Voltage and
+	  Frequency Scaling in DMC and DRAM. It also supports changing timings
+	  of DRAM running with different frequency. The timings are calculated
+	  based on DT memory information.
+	  If unsure, say Y on devices with Samsung Exynos SoCs.
 
 config EXYNOS_SROM
 	bool "Exynos SROM controller driver" if COMPILE_TEST
@@ -29,6 +30,6 @@ config EXYNOS_SROM
 	  during suspend.  If however appropriate device tree configuration
 	  is provided, the driver enables support for external memory
 	  or external devices.
-	  If unsure, say Y on devices with Samsung Exynos SocS.
+	  If unsure, say Y on devices with Samsung Exynos SoCs.
 
 endif
-- 
2.30.2

