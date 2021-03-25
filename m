Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A8B349C6D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 23:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbhCYWjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 18:39:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231318AbhCYWid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 18:38:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F90961A38;
        Thu, 25 Mar 2021 22:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616711913;
        bh=4GybQa7x965w/lvJpnsuebjZBuJAklLkJS0kqW10SlI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AQI76ZNAc2kYisTlQkA41/g1kQ67/tVaO15bbvMmK88fkN0onr1G+Ko7wyP6xc0I+
         6rClyDTLwT4L5Z4Rhr2wrCcJUDP5BbVPFEK+ph5So7pksluRk4ySFgHiPvBfQjB1ol
         fMx3ZURFNR+HIl/jIaOGQIs38ZwQ8OupO3shL4zZnuWCRuvp/ts5HpaTXBtgee94rg
         QCkviWbbq4M2Y+gIWqb7JnakATMHN3G2ybTG1/Eh3IEkR0pHwO6SkKZBoK0/VNqPwf
         7sIWLJf0PAdRi+PTAgkl2koj6ruDAp9NEzK+ZkPLSjaTBEgBRScQJLQKpiZvHKitpR
         oxI3MhBoZE8MA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 3/3] riscv: Select HAVE_DYNAMIC_FTRACE when -fpatchable-function-entry is available
Date:   Thu, 25 Mar 2021 15:38:07 -0700
Message-Id: <20210325223807.2423265-4-nathan@kernel.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210325223807.2423265-1-nathan@kernel.org>
References: <20210325223807.2423265-1-nathan@kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang prior to 13.0.0 does not support -fpatchable-function-entry for
RISC-V.

clang: error: unsupported option '-fpatchable-function-entry=8' for target 'riscv64-unknown-linux-gnu'

To avoid this error, only select HAVE_DYNAMIC_FTRACE when this option is
not available.

Fixes: afc76b8b8011 ("riscv: Using PATCHABLE_FUNCTION_ENTRY instead of MCOUNT")
Link: https://github.com/ClangBuiltLinux/linux/issues/1268
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/riscv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 87d7b52f278f..ba1d07640b66 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -227,7 +227,7 @@ config ARCH_RV64I
 	bool "RV64I"
 	select 64BIT
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128 && GCC_VERSION >= 50000
-	select HAVE_DYNAMIC_FTRACE if MMU
+	select HAVE_DYNAMIC_FTRACE if MMU && $(cc-option,-fpatchable-function-entry=8)
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_GRAPH_TRACER
-- 
2.31.0

