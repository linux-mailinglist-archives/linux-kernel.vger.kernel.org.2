Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3E83EEB43
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 12:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236704AbhHQKyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 06:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbhHQKyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 06:54:41 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C28C061764;
        Tue, 17 Aug 2021 03:54:08 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id q11so27916442wrr.9;
        Tue, 17 Aug 2021 03:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r6aKZ3mStglJ8KXopXqTnAueM8I8iIX9uDZNRcE4ZkQ=;
        b=XvkhlW57JehYDlkQR+aFLFe55cOvPWo7ekebsd6AoR54n43kZXdV104IKDDsNzEAlX
         FGJwTHbKr6v4BiFe0TGkhf/AMlY5bnRCO62vCb5kyIVy6f5qbJxnDvH5H1YnZfvw26xc
         TWBAwlyuNtuEqJb5WvaV5zb7SXpiqjGQq2yhU8HFQpNLwXNE8KB+Yskjl+G0fH2ZJr4Q
         nGQYlAYZmqS1axjGpUAMvab6XF5DXHB5aavBsmsyuyA0dJVldGOYVeDdxZ2AGgWJqpHd
         N93nOi9YM569vvIRirqN+xZczOk2S65eGO8oc9++07+389++n31xWtE7bQdpaXFFLIig
         5y+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r6aKZ3mStglJ8KXopXqTnAueM8I8iIX9uDZNRcE4ZkQ=;
        b=I7l9yP8gwI5yvIitcJ207VnwkEqonXij26DDHZJT8KN5pcIRwHbPrXv4say6rziC0q
         dwXykj0Kv58jXsvIjihOU0UlFWDddYPywuYxiHNxK7WbGQLdL47AMlsXAqjfwmxKac6D
         pNV9IQi9K2rn/lNk9AfqwjIoyDhzKcv0+zdI7duTR2ysNwfxGf660Tz8vfkbY1mWWGSc
         hIKWu8omBBx6RjMTdAj4IzylcjYcMHlhdmO/R0m56QGMDWBgGABpXykUE5sbKVBtThZa
         sJ7Gb2eonUP7vxFvJ3Nu4byLZ5eUZ6FiIoBab4d07MLpknwREofY3BOgGP+HFsClYEB7
         6v7Q==
X-Gm-Message-State: AOAM5330VwEUeUkgSinOX03Y1eZr2cNHKwvxkUrZEhJTsrE9MgUCYZOi
        uZu0OpjFXOp+525M3dNR3MY=
X-Google-Smtp-Source: ABdhPJxt71/S0VMg7VpAnRd1AlHxkO+lFHesTMJDu0H/ALoSAr0RfvRLaVxRttmPZ6sz0oDM4aZMJw==
X-Received: by 2002:adf:ab0e:: with SMTP id q14mr3270642wrc.171.1629197646878;
        Tue, 17 Aug 2021 03:54:06 -0700 (PDT)
Received: from localhost.localdomain (arl-84-90-178-246.netvisao.pt. [84.90.178.246])
        by smtp.gmail.com with ESMTPSA id i21sm2029840wrb.62.2021.08.17.03.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 03:54:06 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Gow <davidgow@google.com>, linux-staging@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] clk: staging: correct reference to config IOMEM to config HAS_IOMEM
Date:   Tue, 17 Aug 2021 12:54:04 +0200
Message-Id: <20210817105404.13146-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 0a0a66c984b3 ("clk: staging: Specify IOMEM dependency for Xilinx
Clocking Wizard driver") introduces a dependency on the non-existing config
IOMEM, which basically makes it impossible to include this driver into any
build. Fortunately, ./scripts/checkkconfigsymbols.py warns:

IOMEM
Referencing files: drivers/staging/clocking-wizard/Kconfig

The config for IOMEM support is called HAS_IOMEM. Correct this reference to
the intended config.

Fixes: 0a0a66c984b3 ("clk: staging: Specify IOMEM dependency for Xilinx Clocking Wizard driver")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/staging/clocking-wizard/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/clocking-wizard/Kconfig b/drivers/staging/clocking-wizard/Kconfig
index 69cf51445f08..2324b5d73788 100644
--- a/drivers/staging/clocking-wizard/Kconfig
+++ b/drivers/staging/clocking-wizard/Kconfig
@@ -5,6 +5,6 @@
 
 config COMMON_CLK_XLNX_CLKWZRD
 	tristate "Xilinx Clocking Wizard"
-	depends on COMMON_CLK && OF && IOMEM
+	depends on COMMON_CLK && OF && HAS_IOMEM
 	help
 	  Support for the Xilinx Clocking Wizard IP core clock generator.
-- 
2.26.2

