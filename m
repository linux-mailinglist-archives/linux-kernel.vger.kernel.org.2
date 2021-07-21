Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5333D1204
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 17:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239609AbhGUObF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 10:31:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239465AbhGUObD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 10:31:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E992E606A5;
        Wed, 21 Jul 2021 15:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626880300;
        bh=lT6LMjdaLVJA4cajik2AMwohdvMr2in2CFISEuJVul4=;
        h=From:To:Cc:Subject:Date:From;
        b=NfJA9lnPJBfw7hjUhimDXuxhhQsXpkTew6X3wErAq9Zc0CsjpIaENNKhzov86ANlK
         h7Gr/ff4aIGtoo4uKdXF2IXIUIrCz5Z96UBNC6LkHNn5ocKXFYCUvZ04BVwBnHCs53
         VVc2k7dkZe0mGDss3CHp5CwzjHvUfr2XPvjgxqkY3SeSAdQJCbEZrI/dymByU0Iro5
         UQwbNy9L7nL0W1PFDFQtckH7vG9AF8cn7qKW+YqQTILtbb8T9mFLCe/TKNcHQo4EF9
         RbQGIvlvBIMzoWIHpZEcxMENNqpRruD6+aF2dBlS1Qwp95iOzpZL8g9Ca3KkTuu84Y
         X/yUx5KYPo9VQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dongjiu Geng <gengdongjiu@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: hisilicon: hi3559A: select CONFIG_RESET_HISI
Date:   Wed, 21 Jul 2021 17:11:31 +0200
Message-Id: <20210721151136.2060107-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The reset functions are in a library that has to be selected
for each driver using them:

aarch64-linux-ld: drivers/clk/hisilicon/clk-hi3559a.o: in function `hi3559av100_crg_remove':
clk-hi3559a.c:(.text+0x1c8): undefined reference to `hisi_reset_exit'
clk-hi3559a.c:(.text+0x1c8): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `hisi_reset_exit'
aarch64-linux-ld: drivers/clk/hisilicon/clk-hi3559a.o: in function `hi3559av100_crg_probe':
clk-hi3559a.c:(.text+0x284): undefined reference to `hisi_reset_init'
clk-hi3559a.c:(.text+0x284): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `hisi_reset_init'
aarch64-linux-ld: clk-hi3559a.c:(.text+0x2e8): undefined reference to `hisi_reset_exit'
clk-hi3559a.c:(.text+0x2e8): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `hisi_reset_exit'

Add the select to 3559 as well.

Fixes: 6c81966107dc ("clk: hisilicon: Add clock driver for hi3559A SoC")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clk/hisilicon/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/hisilicon/Kconfig b/drivers/clk/hisilicon/Kconfig
index 5ecc37aaa118..c1ec75aa4ccd 100644
--- a/drivers/clk/hisilicon/Kconfig
+++ b/drivers/clk/hisilicon/Kconfig
@@ -18,6 +18,7 @@ config COMMON_CLK_HI3519
 config COMMON_CLK_HI3559A
 	bool "Hi3559A Clock Driver"
 	depends on ARCH_HISI || COMPILE_TEST
+	select RESET_HISI
 	default ARCH_HISI
 	help
 	  Build the clock driver for hi3559a.
-- 
2.29.2

