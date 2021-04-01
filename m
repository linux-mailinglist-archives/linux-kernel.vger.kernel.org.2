Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B050A351A51
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236962AbhDAR7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 13:59:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:42950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235595AbhDARnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:43:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6EA2661277;
        Thu,  1 Apr 2021 15:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617290020;
        bh=oIMd6/IwnzXM2f7FHdSrACNcFz9T7GzoNQqDjQwcJt0=;
        h=From:To:Cc:Subject:Date:From;
        b=nYHZIaVXuxXEECURowpvtvUXv4m1MGCoTU3o66nAvmBdtNlkIYDKs+8f21Bv7Fsl4
         uYPblfAQ5NKS0hH0OcqVAzqQx6l3d1Wxgpnm7dfmRTVIxWfpBfoCjs0MJhBJJsLNnM
         UJKbxcZvfo3M7UzVLZfEwCKVQAHiH0I1Gh7+/jbUA53lS7T+qQK/o7ExYkZf0LYAs6
         /PRkIw6vE+AeTwF9c4NcN1CT1iCtuLKZqzFxx2q89i86te9sKBYrr7fosBAfEVku/e
         OGs+/+4b5iR8H+I+8zHQ9pcqSJpP7xpviIjyLAgUzBS3SRGviJAtOJm9eUCa2JfQJP
         ekOKa6UAjNQtA==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        kernel test robot <lkp@intel.com>,
        Richard Gong <richard.gong@linux.intel.com>
Subject: [PATCH] firmware: stratix10-svc: build only on 64-bit ARM
Date:   Thu,  1 Apr 2021 10:13:29 -0500
Message-Id: <20210401151329.606004-1-dinguyen@kernel.org>
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

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reported-by: kernel test robot <lkp@intel.com>
Acked-by: Richard Gong <richard.gong@linux.intel.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
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

