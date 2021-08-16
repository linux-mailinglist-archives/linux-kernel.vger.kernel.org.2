Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34D03ED929
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 16:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbhHPOsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 10:48:24 -0400
Received: from mga05.intel.com ([192.55.52.43]:29641 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229586AbhHPOsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 10:48:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10078"; a="301456795"
X-IronPort-AV: E=Sophos;i="5.84,326,1620716400"; 
   d="scan'208";a="301456795"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2021 07:47:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,326,1620716400"; 
   d="scan'208";a="592771174"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 16 Aug 2021 07:47:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5AE59FF; Mon, 16 Aug 2021 17:47:48 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 1/1] x86/platform: Increase maximum GPIO number for X86_64
Date:   Mon, 16 Aug 2021 17:47:46 +0300
Message-Id: <20210816144746.33763-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default the 512 GPIOs is the maximum on any x86 platform.
With, for example, Intel Tiger Lake-H the SoC based controller
occupies up to 480 pins. This leaves only 32 available for
GPIO expanders or other drivers, like PMIC. Hence, bump the
maximum GPIO number to 1024 for X86_64 and leave 512 for X86_32.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
v2: dropped confusing comment and help, simplified defaults (Rafael)
    added Rb tag (Linus)
 arch/x86/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1146b85d708b..98501aeb356d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -338,6 +338,11 @@ config NEED_PER_CPU_PAGE_FIRST_CHUNK
 config ARCH_HIBERNATION_POSSIBLE
 	def_bool y
 
+config ARCH_NR_GPIO
+	int
+	default 1024 if X86_64
+	default 512
+
 config ARCH_SUSPEND_POSSIBLE
 	def_bool y
 
-- 
2.30.2

