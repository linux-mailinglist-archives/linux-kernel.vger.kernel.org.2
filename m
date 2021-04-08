Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5CD3588EF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbhDHPyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:54:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:24858 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231975AbhDHPyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:54:38 -0400
IronPort-SDR: 4oiOsb+RNvdnDjFF71Y7M05M2M4DGsRvJxJgiE34ylZqwl3FSQSQjQgBU6aqAviBjxYMTbtCS6
 2tuRjOzJvG1g==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="191418385"
X-IronPort-AV: E=Sophos;i="5.82,206,1613462400"; 
   d="scan'208";a="191418385"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 08:54:27 -0700
IronPort-SDR: 4TwNbLTi4m/1xXlw0dCzgegGM4q58DCL1rmCsgeP6Dyj+bcaEPzPkcyPGAVXAnmJvoyySXCiW8
 CeQPmVlLo5uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,206,1613462400"; 
   d="scan'208";a="441802225"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 08 Apr 2021 08:54:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D6491D7; Thu,  8 Apr 2021 18:54:41 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v1 1/1] defconfig: enable GPIO_SIM
Date:   Thu,  8 Apr 2021 18:54:41 +0300
Message-Id: <20210408155441.12297-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/configs/i386_defconfig   | 1 +
 arch/x86/configs/x86_64_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index d696336674b0..e36dc940a83c 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -309,6 +309,7 @@ CONFIG_GPIO_PCA953X=y
 CONFIG_GPIO_PCA953X_IRQ=y
 CONFIG_GPIO_PCH=m
 CONFIG_GPIO_SCH=m
+CONFIG_GPIO_SIM=m
 CONFIG_GPIO_XILINX=m
 CONFIG_X86_EXTENDED_PLATFORM=y
 CONFIG_X86_INTEL_MID=y
diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
index 20a955acf775..97d42dd67c8a 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -305,6 +305,7 @@ CONFIG_GPIO_PCA953X=y
 CONFIG_GPIO_PCA953X_IRQ=y
 CONFIG_GPIO_PCH=m
 CONFIG_GPIO_SCH=m
+CONFIG_GPIO_SIM=m
 CONFIG_GPIO_XILINX=m
 CONFIG_X86_EXTENDED_PLATFORM=y
 CONFIG_X86_INTEL_MID=y
-- 
2.30.2

