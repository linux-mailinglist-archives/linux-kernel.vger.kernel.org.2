Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D3F35798E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 03:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhDHB30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 21:29:26 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15167 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhDHB3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 21:29:23 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FG3WP5kLKzpWN7;
        Thu,  8 Apr 2021 09:26:25 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Thu, 8 Apr 2021
 09:29:02 +0800
From:   Shixin Liu <liushixin2@huawei.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Shixin Liu" <liushixin2@huawei.com>
Subject: [PATCH -next] phy: ti: j721e-wiz: Add missing include linux/slab.h
Date:   Thu, 8 Apr 2021 09:28:29 +0800
Message-ID: <20210408012829.432938-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling with CONFIG_PHY_J721E_WIZ, Hulk Robot reported:

drivers/phy/ti/phy-j721e-wiz.c: In function ‘wiz_mux_clk_register’:
drivers/phy/ti/phy-j721e-wiz.c:659:17: error: implicit declaration of function ‘kzalloc’; did you mean ‘vzalloc’? [-Werror=implicit-function-declaration]
  659 |  parent_names = kzalloc((sizeof(char *) * num_parents), GFP_KERNEL);
      |                 ^~~~~~~
      |                 vzalloc
drivers/phy/ti/phy-j721e-wiz.c:659:15: warning: assignment to ‘const char **’ from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
  659 |  parent_names = kzalloc((sizeof(char *) * num_parents), GFP_KERNEL);
      |               ^
drivers/phy/ti/phy-j721e-wiz.c:697:2: error: implicit declaration of function ‘kfree’; did you mean ‘vfree’? [-Werror=implicit-function-declaration]
  697 |  kfree(parent_names);
      |  ^~~~~
      |  vfre

Fixes: 040cbe768731 ("phy: ti: j721e-wiz: Model the internal clocks without device tree input")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Shixin Liu <liushixin2@huawei.com>
---
 drivers/phy/ti/phy-j721e-wiz.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index 2b354680a272..ab28fb2e01db 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -8,6 +8,7 @@
 
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/phy/phy-ti.h>
+#include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/gpio.h>
-- 
2.25.1

