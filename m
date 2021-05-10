Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2912378DAB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 15:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349610AbhEJMtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 08:49:47 -0400
Received: from mga02.intel.com ([134.134.136.20]:64694 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233217AbhEJLn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 07:43:56 -0400
IronPort-SDR: TI46JgMRnKzO1EFHhKW9QYGgnKp9bEM3iY47DGv3NJ7JWzdFnx/kYjN1jF6RQL9NugfWx5Cgr2
 FbhUlpjZQgXA==
X-IronPort-AV: E=McAfee;i="6200,9189,9979"; a="186309872"
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="186309872"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 04:40:51 -0700
IronPort-SDR: 5cY6nnDtlOM81E2kNDU+m7wGvSGo55yX/pjK4b1v2kRXoMK2NGG/fqJFSSKmR2QE0PDMYZ3oPr
 RT5Exx9whljA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="433774712"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 10 May 2021 04:40:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E7008D7; Mon, 10 May 2021 14:41:09 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 1/1] ARM: Drop ARCH_NR_GPIOS definition
Date:   Mon, 10 May 2021 14:41:07 +0300
Message-Id: <20210510114107.43006-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The conditional by the generic header is the same,
hence drop unnecessary duplication.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: rebased on top of v5.13-rc1
 arch/arm/include/asm/gpio.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/include/asm/gpio.h b/arch/arm/include/asm/gpio.h
index c50e383358c4..f3bb8a2bf788 100644
--- a/arch/arm/include/asm/gpio.h
+++ b/arch/arm/include/asm/gpio.h
@@ -2,10 +2,6 @@
 #ifndef _ARCH_ARM_GPIO_H
 #define _ARCH_ARM_GPIO_H
 
-#if CONFIG_ARCH_NR_GPIO > 0
-#define ARCH_NR_GPIOS CONFIG_ARCH_NR_GPIO
-#endif
-
 /* Note: this may rely upon the value of ARCH_NR_GPIOS set in mach/gpio.h */
 #include <asm-generic/gpio.h>
 
-- 
2.30.2

