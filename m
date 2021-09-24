Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F95B4175AD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 15:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345576AbhIXN34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 09:29:56 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:37406
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345948AbhIXN3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 09:29:13 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0E1AC4081C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 13:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632490060;
        bh=Yduh3EuPKF8pEjpWRTy33G3o5bhDuVyJYzIS4FssiFw=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=ceck0YRo9yrTB1m86Phc3zWHRXquEMKT5qXI7OckV7hOJ+wf2n71K7xtm5PTzT914
         oRmuSx1Jyu2rTkp9Od8+8/VR3lMQML5bKoMD8423nfnmFMh82spjyegc2neqBvQku5
         iHjeCTckh6uxgCOFHJFPtnPHiKk7FSqJRiqd/OQSoukI3Rojj+DhTq+sP+N1RZN1Hq
         oI609QlNdocvCl265+/7fnU4MzCrwqcksiWlQUgv/4c5Ibrk1cmlBrH2bqKfTstWC4
         0UQH4VlnPVXwxf0mAtAUMWQbd/KYHkwLemW6gvTfE3MreJch0c6dXiOssgTgB/HlfR
         j8s3xmfF/07mA==
Received: by mail-wr1-f69.google.com with SMTP id h5-20020a5d6885000000b0015e21e37523so8063692wru.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 06:27:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yduh3EuPKF8pEjpWRTy33G3o5bhDuVyJYzIS4FssiFw=;
        b=SuaajjE/XVViRgwHn19O1s6FHJNKZpt1AH1iJXbaBGsIwKV85qlCHyYXARjWiKtm3u
         3HVE23OZaY5kPeCwb8EYTQOQoAQzRNotcDNnJOsOOvaI0Th1vbWUI0BiRJH0LMT1Zn1M
         4LUEHuvf951rVodh5sQYjkt7IQk5yVHqKXGKFJqTeQlHjimDOLLtb6muhMc7KOQpSU48
         eZAexqCp0Q4B/KAvqgZ/+JElgOb6SausrM0jA1Q9YjdnCHZ9cziztk1hRaL/mFqHHek9
         iUu5p3XUPofrVMrovJApZyL+bZj3SXlp/ai+oNqiizXSdKJMCoNcZ31B8OKeN/Kmbe7F
         n6HA==
X-Gm-Message-State: AOAM533aH7A68IdP23ty+3+FrYy2bWQF2mUuIFLrDDZtwrgUMk0pLO+S
        otEnapvIKJGbJYh/pgriW8bdwH/iO31gSVkVIWn7PkP0JmgmHBhuUprm0J81o+LbPgy038wRmpb
        2Mk9zy5JlOkFCghzsYCJrzcVO2S/cXTnukvjDYNkKQw==
X-Received: by 2002:a5d:6545:: with SMTP id z5mr11455580wrv.51.1632490059711;
        Fri, 24 Sep 2021 06:27:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5S/UeS56vFgo1ZCJhSJ4phgoKPfDX2Y+OA8xv8ibUzmyYGx+lfLXUHLOGyC+XxWzMQL4icA==
X-Received: by 2002:a5d:6545:: with SMTP id z5mr11455561wrv.51.1632490059558;
        Fri, 24 Sep 2021 06:27:39 -0700 (PDT)
Received: from localhost.localdomain (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id s2sm30386wru.3.2021.09.24.06.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 06:27:39 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 2/2] scsi: ufs: exynos: unify naming
Date:   Fri, 24 Sep 2021 15:26:58 +0200
Message-Id: <20210924132658.109814-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210924132658.109814-1-krzysztof.kozlowski@canonical.com>
References: <20210924132658.109814-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We use everywhere "Samsung" and "Exynos", not the uppercase versions.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/scsi/ufs/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/ufs/Kconfig b/drivers/scsi/ufs/Kconfig
index 565e8aa6319d..af66cb3634a8 100644
--- a/drivers/scsi/ufs/Kconfig
+++ b/drivers/scsi/ufs/Kconfig
@@ -165,14 +165,14 @@ config SCSI_UFS_BSG
 	  If unsure, say N.
 
 config SCSI_UFS_EXYNOS
-	tristate "EXYNOS specific hooks to UFS controller platform driver"
+	tristate "Exynos specific hooks to UFS controller platform driver"
 	depends on SCSI_UFSHCD_PLATFORM && (ARCH_EXYNOS || COMPILE_TEST)
 	help
-	  This selects the EXYNOS specific additions to UFSHCD platform driver.
-	  UFS host on EXYNOS includes HCI and UNIPRO layer, and associates with
-	  UFS-PHY driver.
+	  This selects the Samsung Exynos SoC specific additions to UFSHCD
+	  platform driver.  UFS host on Samsung Exynos SoC includes HCI and
+	  UNIPRO layer, and associates with UFS-PHY driver.
 
-	  Select this if you have UFS host controller on EXYNOS chipset.
+	  Select this if you have UFS host controller on Samsung Exynos SoC.
 	  If unsure, say N.
 
 config SCSI_UFS_CRYPTO
-- 
2.30.2

