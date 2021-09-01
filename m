Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC133FDF67
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 18:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242816AbhIAQKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 12:10:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:32856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234050AbhIAQKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 12:10:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE74961059;
        Wed,  1 Sep 2021 16:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630512546;
        bh=Va1LqmOC5Xdls9LpZUrOpdFVjaB5y3DUbafpY3HgesY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ulnOWgGtxoU31zStD+punJrXNcxrkmpqJ8wtvKKFAVmONqi+4eiLALlKOCCaVn+OW
         rgO5E2y1EJDUvW0ikfXyt8gfhk4f1S+uvtCFO1OHBKNeuMpKFbZlu/Oefzh3DbCLm8
         6mjvlRhiolz6VbUfux7BO4Eu6EspUmcYVXklXuPm91VGU3kMBkMPu/WIVPZ47jp8Ln
         WTHg48/ebyQnv26C4AeaRHGmSWVS6/4m/JOp+hwzwb7sXnbcI5M+uirHEJvHWAfgeP
         HKLfCJq1kpoCzDdcKMNOJDzbTC45t6g+SNvP1O8yd8ysvRXDoa6XsPQHvjFUxGeYlq
         jlgyqwH7IXxUA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        Maurizio Lombardi <mlombard@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Konrad Rzeszutek Wilk <konrad@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH v2] x86/setup: Explicitly include acpi.h
Date:   Wed,  1 Sep 2021 09:07:01 -0700
Message-Id: <20210901160700.2941506-1-nathan@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210901021510.1561219-1-nathan@kernel.org>
References: <20210901021510.1561219-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 342f43af70db ("iscsi_ibft: fix crash due to KASLR physical
memory remapping") x86_64_defconfig shows the following errors:

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

acpi.h was being implicitly included from iscsi_ibft.h in this
configuration so the removal of that header means these functions have
no definition or declaration. Add acpi.h explicitly so there is no more
error.

Tested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---

Linus, would you mind taking this directly? Boris indicated here he was
okay with that:

https://lore.kernel.org/r/YS8stOCBCdfZ+J0Y@zn.tnic/

v1 -> v2:

* "certain configurations" -> "x86_64_defconfig", be definitive.

* Add Matthieu's tested-by.

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

