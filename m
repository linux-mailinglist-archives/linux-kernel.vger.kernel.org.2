Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B78366D2B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242845AbhDUNuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:50:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:57642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234768AbhDUNug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:50:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 625BF60C3E;
        Wed, 21 Apr 2021 13:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619013003;
        bh=ZwbuGMgJnP2yBgKidTmrVn0kPEoHr/JE1RzsucEKyeI=;
        h=From:To:Cc:Subject:Date:From;
        b=MIAvkSDuHDrtEVoAhbo/IF74URwCzMMj/BHa1C2rvgy4+pGBYrVzUrpkhaEize+D1
         i6VJwhh6UNLdxfrgc7jux8MP46qlg1dd9VaGJfKXPygVO+ZZFOa89min0dZtAbHOnd
         SOkehsdL1ODmvnfLLeSh/TYZ7U5MRKldCejbOpes8EQV/eSy6/4UapbDdQ3pfKN2wk
         nKJ1+i2lRWh0iRQNXxcIez/69UYSaYVsK6l++r05ieGUYOfqXOkLxXwSWZGdojMJsA
         EUZa6jRMmk/Od+0Dnj+zLVqdSWZfhrN8FZAyGkeFkYgbMF+gjzYLWoM/xBbYOU+hsx
         3EKQKzpTzRqSQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: intel_pmc_core: add ACPI dependency
Date:   Wed, 21 Apr 2021 15:49:39 +0200
Message-Id: <20210421134957.3329062-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The driver now fails to build without ACPI:

drivers/platform/x86/intel_pmc_core.c: In function 'pmc_core_get_tgl_lpm_reqs':
drivers/platform/x86/intel_pmc_core.c:617:41: error: invalid use of undefined type 'struct acpi_device'
  617 |         out_obj = acpi_evaluate_dsm(adev->handle, &s0ix_dsm_guid, 0,

This could probably be made optional, but it won't be used without
ACPI in practice, so just add a Kconfig dependency.

Fixes: 428131364f00 ("platform/x86: intel_pmc_core: Get LPM requirements for Tiger Lake")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/platform/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 697fc446ac41..2714f7c3843e 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1194,6 +1194,7 @@ config INTEL_MRFLD_PWRBTN
 config INTEL_PMC_CORE
 	tristate "Intel PMC Core driver"
 	depends on PCI
+	depends on ACPI
 	help
 	  The Intel Platform Controller Hub for Intel Core SoCs provides access
 	  to Power Management Controller registers via various interfaces. This
-- 
2.29.2

