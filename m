Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A3A34342A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 19:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhCUSrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 14:47:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47862 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbhCUSrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 14:47:01 -0400
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lO36K-0001gl-4U
        for linux-kernel@vger.kernel.org; Sun, 21 Mar 2021 18:47:00 +0000
Received: by mail-wr1-f71.google.com with SMTP id p15so24602003wre.13
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 11:47:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4I8yK2cDgwuj6/ezSSWp7PkwtzVuHo2C60WhsEjnn0Q=;
        b=MuJXh2NrHyOK55elfJ4qRd1SHvly36XrbN5UNJzoNQzyl5bwSIe2VvVtOqVhzIkSUz
         rxI1GSc0pdSRJgJI5bwHW9vu/vqaiaZlgdSopvbSVWQ7dW45jfOS4guS30slcb8uYvew
         dMEnr6PQndgC5ORs8ZwJ9hIcNW2RxxSdlVIjZwySI8pRjcQeNBA6bY0uDK8GlLz+N/pG
         zgb/cccjzVE2Am2QSIjamvhAxAwcp9ir/6hrf705OHvWSJPK+uT3+u6hdHcpv+euAovX
         9lGnvqnM+6uwIYVF+JC6LfhL07UDXHzY+JE8cmB38nR+/KQBRL64N3J+zn27QPESZMxt
         cv3A==
X-Gm-Message-State: AOAM530QL3hmoJz6QYHN/SErdzN6DDucY2mxuAzZiwlrgi83TWlfkZTR
        +kS4kO2HYOIAvz1PJvh1GypIYupxDuqgNO7SglUCH+ItrSpHipPBxdn53HU3Yv2BHDxzyHC6y44
        E3obZltbK+CdfAI6//40BmpH3LjIIszYU5ir3GpUcBg==
X-Received: by 2002:adf:b609:: with SMTP id f9mr14123158wre.223.1616352419825;
        Sun, 21 Mar 2021 11:46:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJys/tSJrfBighAqJJLmohUMyzP1/biLzL19PwURXWzG1f629mWfUpClMD6wgqGpARV/cA0PiQ==
X-Received: by 2002:adf:b609:: with SMTP id f9mr14123150wre.223.1616352419712;
        Sun, 21 Mar 2021 11:46:59 -0700 (PDT)
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id m11sm10934111wri.44.2021.03.21.11.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 11:46:59 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Richard Gong <richard.gong@linux.intel.com>,
        linux-kernel@vger.kernel.org, dinguyen@kernel.org
Cc:     kbuild-all@lists.01.org, linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] firmware: stratix10-svc: build only on 64-bit ARM
Date:   Sun, 21 Mar 2021 19:46:50 +0100
Message-Id: <20210321184650.10926-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Stratix10 service layer and RCU drivers are useful only on
Stratix10, so on ARMv8.  Compile testing the RCU driver on 32-bit ARM
fails:

  drivers/firmware/stratix10-rsu.c: In function 'rsu_status_callback':
  include/linux/compiler_types.h:320:38: error: call to '__compiletime_assert_179'
    declared with attribute error: FIELD_GET: type of reg too small for mask
    _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
  ...
  drivers/firmware/stratix10-rsu.c:96:26: note: in expansion of macro 'FIELD_GET'
    priv->status.version = FIELD_GET(RSU_VERSION_MASK,

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reported-by: kernel test robot <lkp@intel.com>

---

Fix for commit in:
https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git
---
 drivers/firmware/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 6a4e882e448d..08bd4d01fb04 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -206,7 +206,7 @@ config FW_CFG_SYSFS_CMDLINE
 
 config INTEL_STRATIX10_SERVICE
 	tristate "Intel Stratix10 Service Layer"
-	depends on ARCH_INTEL_SOCFPGA && HAVE_ARM_SMCCC
+	depends on ARCH_INTEL_SOCFPGA && ARM64 && HAVE_ARM_SMCCC
 	default n
 	help
 	  Intel Stratix10 service layer runs at privileged exception level,
-- 
2.25.1

