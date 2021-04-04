Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B718353819
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 14:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhDDMqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 08:46:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229674AbhDDMqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 08:46:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9A2C610E8;
        Sun,  4 Apr 2021 12:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617540376;
        bh=q448AuEp1JNUHeDll70qP/eJnd5QYL4ea4HWE95+bHg=;
        h=From:To:Cc:Subject:Date:From;
        b=F78agv0Cm09F2CZ9TgLpdsgw6wcqXptidj84I5G+inl5Nb87Tq+rLf4JkKWD16Y3E
         a/VXWtmp9MlT3vuwLTu0s3IlF6nZ52xFrDOkUkHT8ES+hnjrC6hPW48YPAqDG7kn5h
         ee3d5Gd8c5967qIw+/W37Rmd7qRHTp5k3nmFM3PqwcsIaA+zjTisJDeyvzZM+7hNOx
         YprG7NhxponBa9hM2DfTxlgVn+KLH4E2CR+qLasEWXa5D+ixpfrLFEasDScUG7hmA1
         rZE2lwsozeJwMNRs8izNMIi4v4upoqKLicb3kdkQJEXSYTWfHEJQaXiFerakqWsnga
         52DNdLpLuxIJQ==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        kernel test robot <lkp@intel.com>,
        Richard Gong <richard.gong@linux.intel.com>
Subject: [PATCHv2 RESEND] firmware: stratix10-svc: build only on 64-bit ARM
Date:   Sun,  4 Apr 2021 07:46:09 -0500
Message-Id: <20210404124609.122377-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

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

Fixes: 4483397b0353 ("ARM: socfpga: drop ARCH_SOCFPGA")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reported-by: kernel test robot <lkp@intel.com>
Acked-by: Richard Gong <richard.gong@linux.intel.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v2: add Fixes tag
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

