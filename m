Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7C43263C7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 15:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhBZOII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 09:08:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:59936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230124AbhBZOFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 09:05:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7760564EF0;
        Fri, 26 Feb 2021 14:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614348266;
        bh=BLWeBOVF8W7renKagiVmUVTYjOP+aHJuqtrmyXlTh8U=;
        h=From:To:Cc:Subject:Date:From;
        b=ek7vXs+5VSbdLxV2e0+0bZQl7i7ZSgjFRndDVC6Y03eE+IjkKRMzeFH4oxuK9T8F1
         LW/fERlBz4Vn9aMBg4kAV5FOl795O04gJ5bx7ENRVhlIvscXhGojmisg9gzmZVyI0O
         vfUsL6msaEj0pfG268TePa0B06EM/g6yayoYh/I68Gm/8boIIwqhoNVYy5r6HEuhrT
         ZcNLmrDB67t70FawNvVSiEBAb8bJGemvBkvYv4ctr7ZBvwhJL8iyqi237erv7oK2J0
         VXSNmFyyUjw2zWBRVM9kgzOsPJEBPzoZDFl/E66OnzxJ+FdcjpQyVScNi8G9Oit16e
         jxk4TyQj6TU2w==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        David Brazdil <dbrazdil@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: vmlinux.lds.S: keep .entry.tramp.text section
Date:   Fri, 26 Feb 2021 15:03:39 +0100
Message-Id: <20210226140352.3477860-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When building with CONFIG_LD_DEAD_CODE_DATA_ELIMINATION,
I sometimes see an assertion

 ld.lld: error: Entry trampoline text too big

This happens when any reference to the trampoline is discarded at link
time. Marking the section as KEEP() avoids the assertion, but I have
not figured out whether this is the correct solution for the underlying
problem.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/kernel/vmlinux.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 926cdb597a45..c5ee9d5842db 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -96,7 +96,7 @@ jiffies = jiffies_64;
 #define TRAMP_TEXT					\
 	. = ALIGN(PAGE_SIZE);				\
 	__entry_tramp_text_start = .;			\
-	*(.entry.tramp.text)				\
+	KEEP(*(.entry.tramp.text))			\
 	. = ALIGN(PAGE_SIZE);				\
 	__entry_tramp_text_end = .;
 #else
-- 
2.29.2

