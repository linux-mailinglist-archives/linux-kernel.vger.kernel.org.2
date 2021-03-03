Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B805132BE95
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385873AbhCCRcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:32:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:51364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242292AbhCCNwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:52:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A97264EF6;
        Wed,  3 Mar 2021 13:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614779426;
        bh=tIrhVb/ofjnOXPTvsgUdD4zjBaJv0XaYt3PI0i9joPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SNtG6zwhsVKE9fAwlN9Xx+gXfzg0hm1YdEmzIRm4pzA6cDO0TNHnfNNggu+dCHfTR
         HM0j+JFTCmn73uyHaYIfFhLU9ERk1V+tu0rG9CohaEi/xlm8xHJlGAOt0P4BiS1gG1
         nDmTOOun1AsloFImmRmK0yDMnV41/ZUJCrQ4YXHk+v1qkJJvir6KtxIs0eDyxj0EnO
         nGmnY/TB4d0SpTV7WsuTawSOtQWuJ99Viai0v/MQn7vpGzsEVq9MPsmrqYKWSONis8
         ZIrFKVu9RH+HyGfCnjyvrAZ7/zi2SAEMUeK+rN6gonGKFuki6hj48hEBfPWhMS/u24
         a8xF5e16xw9CQ==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Max Uvarov <muvarov@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kernel-team@android.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 2/2] arm64: Drop support for CMDLINE_EXTEND
Date:   Wed,  3 Mar 2021 13:49:27 +0000
Message-Id: <20210303134927.18975-3-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210303134927.18975-1-will@kernel.org>
References: <20210303134927.18975-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documented behaviour for CMDLINE_EXTEND is that the arguments from
the bootloader are appended to the built-in kernel command line. This
also matches the option parsing behaviour for the EFI stub and early ID
register overrides.

Bizarrely, the fdt behaviour is the other way around: appending the
built-in command line to the bootloader arguments, resulting in a
command-line that doesn't necessarily line-up with the parsing order and
definitely doesn't line-up with the documented behaviour.

As it turns out, there is a proposal [1] to replace CMDLINE_EXTEND with
CMDLINE_PREPEND and CMDLINE_APPEND options which should hopefully make
the intended behaviour much clearer. While we wait for those to land,
drop CMDLINE_EXTEND for now as there appears to be little enthusiasm for
changing the current FDT behaviour.

[1] https://lore.kernel.org/lkml/20190319232448.45964-2-danielwa@cisco.com/

Cc: Max Uvarov <muvarov@gmail.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Tyler Hicks <tyhicks@linux.microsoft.com>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/CAL_JsqJX=TCCs7=gg486r9TN4NYscMTCLNfqJF9crskKPq-bTg@mail.gmail.com
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/Kconfig                 | 6 ------
 arch/arm64/kernel/idreg-override.c | 5 +----
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1f212b47a48a..f15418332d16 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1855,12 +1855,6 @@ config CMDLINE_FROM_BOOTLOADER
 	  the boot loader doesn't provide any, the default kernel command
 	  string provided in CMDLINE will be used.
 
-config CMDLINE_EXTEND
-	bool "Extend bootloader kernel arguments"
-	help
-	  The command-line arguments provided by the boot loader will be
-	  appended to the default kernel command string.
-
 config CMDLINE_FORCE
 	bool "Always use the default kernel command string"
 	help
diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
index cc071712c6f9..83f1c4b92095 100644
--- a/arch/arm64/kernel/idreg-override.c
+++ b/arch/arm64/kernel/idreg-override.c
@@ -188,11 +188,8 @@ static __init void parse_cmdline(void)
 {
 	const u8 *prop = get_bootargs_cmdline();
 
-	if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) ||
-	    IS_ENABLED(CONFIG_CMDLINE_FORCE) ||
-	    !prop) {
+	if (IS_ENABLED(CONFIG_CMDLINE_FORCE) || !prop)
 		__parse_cmdline(CONFIG_CMDLINE, true);
-	}
 
 	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE) && prop)
 		__parse_cmdline(prop, true);
-- 
2.30.1.766.gb4fecdf3b7-goog

