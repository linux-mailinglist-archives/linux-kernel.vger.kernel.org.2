Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1759342F90
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 21:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhCTUnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 16:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhCTUnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 16:43:16 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69131C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 13:43:16 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id v70so6667651qkb.8
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 13:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ql03IpdIhB49vJW3BSH4UPHi0TkroDQSYmZmv4ZgvoU=;
        b=DUWg5tDD7Q5e9mkKjlxuzT+88kmzcycqMvn3TGvV6Vg+kGReYD88HNDnrdVH3DbWQB
         9CY/YkgmedkoTPaX+xrcYPJN9+hDuHXzZJCLRiE8bkHRj+bp8kAHrC2GXQEZuxK2dw+l
         8Z/ItL0K9hMBj3BbIF8a4XAe+RGJaxkQUihAIKmF0TJ3Ub2z/N+lVZhcm0+flqfYfVQj
         Hl3o8YxxoSudVwdKF3O+ZblHSrjaIPmxneCgO6ipxowRebhDDRqQITDszj5hyUk00hhZ
         G6dcHePyPj4UvibKofRP/hSxFtWVPIqX7FXffiiqKNXJCM1dE8dg7DbVazygIC7VrejV
         qAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ql03IpdIhB49vJW3BSH4UPHi0TkroDQSYmZmv4ZgvoU=;
        b=IRw9qdvM1kNepHdh5nCfF+LmyfztQir4QM47g+C4bXmisOQyEvGwEvLCoQgpCKhYw3
         pPfbESI0axq3cHjN1HqjWNEMk+pOq+RYSCkZ8sm+tZmQontC0sEluzUAHZ4QeInATzi4
         ZfX9KpzfafzIj9lYTg6ylybZTWYxSb2o6cMeH3T4WPeALtpHvgeKyXwd1waXvoU/Y2x+
         JcGqVpjoVEQHB1pMwU3ey+vBjN42/1UZ9LiHt34gzgTe0Xk2Y60MC9Q1/BVO3xij5voC
         k7dgzMoYwA+YH69WaR/80J4kiVa33oSKROEGyNZIIkuoh0ffPUM7AtlpA0plAtUmVbCq
         JljQ==
X-Gm-Message-State: AOAM533Q/I8fsJnp4fTyR5yNPoNczR848+zfbiDJoOxWdTAqKEA6cgXW
        O2NNtDdxCgEdGCuEsUtcqIo=
X-Google-Smtp-Source: ABdhPJzo4mjDP2kPYr+g1EjhGiLmGJJorkvuhb2r2/AmlWJwic3GwivDMYOa68X/hxLrFXMpnuzkzg==
X-Received: by 2002:a05:620a:906:: with SMTP id v6mr4422201qkv.28.1616272995719;
        Sat, 20 Mar 2021 13:43:15 -0700 (PDT)
Received: from localhost.localdomain ([138.199.13.205])
        by smtp.gmail.com with ESMTPSA id v11sm2470820qtx.79.2021.03.20.13.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 13:43:15 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     kishon@ti.com, vkoul@kernel.org, p.zabel@pengutronix.de,
        eswara.kota@linux.intel.com,
        vadivel.muruganx.ramuthevar@linux.intel.com, unixbhaskar@gmail.com,
        nathan@kernel.org, arnd@arndb.de,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] phy: intel: Fix a typo
Date:   Sun, 21 Mar 2021 02:10:55 +0530
Message-Id: <20210320204055.26107-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/subsytem/subsystem/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/phy/intel/phy-intel-lgm-combo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/intel/phy-intel-lgm-combo.c b/drivers/phy/intel/phy-intel-lgm-combo.c
index 360b1eb2ebd6..157683d10367 100644
--- a/drivers/phy/intel/phy-intel-lgm-combo.c
+++ b/drivers/phy/intel/phy-intel-lgm-combo.c
@@ -462,7 +462,7 @@ static int intel_cbphy_fwnode_parse(struct intel_combo_phy *cbphy)

 	/*
 	 * syscfg and hsiocfg variables stores the handle of the registers set
-	 * in which ComboPhy subsytem specific registers are subset. Using
+	 * in which ComboPhy subsystem specific registers are subset. Using
 	 * Register map framework to access the registers set.
 	 */
 	ret = fwnode_property_get_reference_args(fwnode, "intel,syscfg", NULL,
--
2.26.2

