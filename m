Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A2739C063
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 21:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhFDTZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 15:25:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:60144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229501AbhFDTZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 15:25:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1ABC1613F9;
        Fri,  4 Jun 2021 19:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622834602;
        bh=HRfrRBBjvQ0q3EsQR7+VV5+hU7WWE2FJdKqENhq9jtM=;
        h=From:To:Cc:Subject:Date:From;
        b=uQBpLqdw5MIVXsn5bqjOKR5KLH4r3vAZSBUHFk5tmeOn7tMmgfvc8YBLyWIONl3SZ
         judGyFZGjwwBEmzLzS6+OZ8FxWfm9rW0QX3Mbz4yeY7WDVx0TCUy0ofScUfVtGbeLl
         AB6sbezN816fZSOrfCuapSGNmb4PpBoFplO4RgECioOlx9U/wRnZpQ8c8sS/TRitbS
         lkdf25EsL7HnpEyJcTJPKaW49cYUDyVQegBtTD+F8RlnOO8bRW+GhyNopJUL+YpoD5
         NlpoY3u+MMfsPGZ/Cj3V5AealHWuir8eVpwMxcsY5m5tnLEzxKxP5Pe3yol+o3Fuaz
         YrLzew7ifOarQ==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] clk: versatile: Depend on HAS_IOMEM
Date:   Fri,  4 Jun 2021 12:23:21 -0700
Message-Id: <20210604192321.2594519-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kbuild robot reports that s390 fails to build this driver with
COMPILE_TEST. Let's depend on HAS_IOMEM so that s390 doesn't try to
build it.

Cc: Lee Jones <lee.jones@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reported-by: kernel test robot <lkp@intel.com>
Fixes: 419b3ab6987f ("clk: versatile: remove dependency on ARCH_*")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/versatile/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/versatile/Kconfig b/drivers/clk/versatile/Kconfig
index 792315d893db..481de5657d85 100644
--- a/drivers/clk/versatile/Kconfig
+++ b/drivers/clk/versatile/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 menu "Clock driver for ARM Reference designs"
+	depends on HAS_IOMEM
 
 config ICST
 	bool "Clock driver for ARM Reference designs ICST"
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

