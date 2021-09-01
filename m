Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A08B3FD120
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 04:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241433AbhIACRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 22:17:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:59670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238102AbhIACRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 22:17:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C283600D4;
        Wed,  1 Sep 2021 02:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630462597;
        bh=VzoHYT5ynay43A3nf9TYYGLysTHVJLI9WO7AGzL+NNA=;
        h=From:To:Cc:Subject:Date:From;
        b=Gmn5yiKnQkacA7aIIXRZJmzMhbdbSKRIOaKmBlrpy3cG2EcpcsU2HsFUfjpLA1v/n
         x1SvAblgjGAyNvpdtNfr2Y7AjIYROLBQV4x1XIlJdSo9LV2AZiwsfYb72Sfz9gMabA
         kz2KPYFR7BwpcaXlImtm48qzpWHkReGFLCjINHdAcQ0bBr72wiUXDov8R95pCuywPb
         vAo07qFRD/SNgyeifv8uDQa5DGHp5gQiwLRnk87LsMHjkcaqR9Elg0uGo9qzfqjJ9b
         t87TbLRlNU+OGHnJqAGT8Oy8AlVnQ3dX4DhfQG9xnxQeALQv6DOZJqfeGURohbC657
         FTk726HEgMEqA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Maurizio Lombardi <mlombard@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Konrad Rzeszutek Wilk <konrad@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] x86/setup: Explicitly include acpi.h
Date:   Tue, 31 Aug 2021 19:15:11 -0700
Message-Id: <20210901021510.1561219-1-nathan@kernel.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 342f43af70db ("iscsi_ibft: fix crash due to KASLR physical
memory remapping"), certain configurations show the following errors:

arch/x86/kernel/setup.c: In function ‘setup_arch’:
arch/x86/kernel/setup.c:916:13: error: implicit declaration of function ‘acpi_mps_check’ [-Werror=implicit-function-declaration]
  916 |         if (acpi_mps_check()) {
      |             ^~~~~~~~~~~~~~
arch/x86/kernel/setup.c:1110:9: error: implicit declaration of function ‘acpi_table_upgrade’ [-Werror=implicit-function-declaration]
 1110 |         acpi_table_upgrade();
      |         ^~~~~~~~~~~~~~~~~~
arch/x86/kernel/setup.c:1112:9: error: implicit declaration of function ‘acpi_boot_table_init’ [-Werror=implicit-function-declaration]
 1112 |         acpi_boot_table_init();
      |         ^~~~~~~~~~~~~~~~~~~~
arch/x86/kernel/setup.c:1120:9: error: implicit declaration of function ‘early_acpi_boot_init’; did you mean ‘early_cpu_init’? [-Werror=implicit-function-declaration]
 1120 |         early_acpi_boot_init();
      |         ^~~~~~~~~~~~~~~~~~~~
      |         early_cpu_init
arch/x86/kernel/setup.c:1162:9: error: implicit declaration of function ‘acpi_boot_init’ [-Werror=implicit-function-declaration]
 1162 |         acpi_boot_init();
      |         ^~~~~~~~~~~~~~
cc1: some warnings being treated as errors

acpi.h was being implicitly included from iscsi_ibft.h in these
configurations so the removal of that means these functions have no
definition or declaration. Add acpi.h explicitly so there is no more
error.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---

* No fixes tag as I doubt the mentioned commit is the root cause.

* The configuration was WSL2's, I did not drill down exactly which set
  of configs triggers this but it is pretty obvious what is going on
  here.

 arch/x86/kernel/setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 63b20536c8d2..79f164141116 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -5,6 +5,7 @@
  * This file contains the setup_arch() code, which handles the architecture-dependent
  * parts of early kernel initialization.
  */
+#include <linux/acpi.h>
 #include <linux/console.h>
 #include <linux/crash_dump.h>
 #include <linux/dma-map-ops.h>

base-commit: 9e9fb7655ed585da8f468e29221f0ba194a5f613
-- 
2.33.0

