Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4E94245C1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 20:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbhJFSNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 14:13:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:43136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232060AbhJFSNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 14:13:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 459716103B;
        Wed,  6 Oct 2021 18:11:22 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Barret Rhoden <brho@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] elfcore: um: Fix CONFIG_UM typo in linux/elfcore.h
Date:   Wed,  6 Oct 2021 19:11:19 +0100
Message-Id: <20211006181119.2851441-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no CONFIG_UM, only UML. In addition, the arch/x86/um/elfcore.c
file is only compiled if CONFIG_X86_32. Fix the #if conditions in the
linux/elfcore.h header accordingly.

Fixes: 6e7b64b9dd6d ("elfcore: fix building with clang")
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---

I'm doing some arm64 changes to allow MTE tags to be dumped in the core
file and I came across this. In a subsequent patch I'll change the #if
check with a dedicated Kconfig option but I thought I'd send the fix
first in case anyone deems it important to backport.

 include/linux/elfcore.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/elfcore.h b/include/linux/elfcore.h
index 2aaa15779d50..957ebec35aad 100644
--- a/include/linux/elfcore.h
+++ b/include/linux/elfcore.h
@@ -109,7 +109,7 @@ static inline int elf_core_copy_task_fpregs(struct task_struct *t, struct pt_reg
 #endif
 }
 
-#if defined(CONFIG_UM) || defined(CONFIG_IA64)
+#if (defined(CONFIG_UML) && defined(CONFIG_X86_32)) || defined(CONFIG_IA64)
 /*
  * These functions parameterize elf_core_dump in fs/binfmt_elf.c to write out
  * extra segments containing the gate DSO contents.  Dumping its
