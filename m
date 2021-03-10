Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2640A333CCD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 13:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbhCJMnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 07:43:33 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:30392 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232088AbhCJMnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 07:43:14 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DwWvh0jCFz9ty2j;
        Wed, 10 Mar 2021 13:43:12 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ny2_IcOITQLa; Wed, 10 Mar 2021 13:43:12 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DwWvg3vRPz9twyk;
        Wed, 10 Mar 2021 13:43:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D519D8B78A;
        Wed, 10 Mar 2021 13:43:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id xnzGXWZ5-qOx; Wed, 10 Mar 2021 13:43:12 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A21CF8B77E;
        Wed, 10 Mar 2021 13:43:12 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id C63B867560; Wed, 10 Mar 2021 12:43:12 +0000 (UTC)
Message-Id: <a1e552006b8c51f23edd2f6cabdd9a986c631146.1615380184.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/Makefile: Remove workaround for gcc versions below
 4.9
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 10 Mar 2021 12:43:12 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6ec4476ac825 ("Raise gcc version requirement to 4.9")
made it impossible to build with gcc 4.8 and under.

Remove related workaround.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/Makefile | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 5f8544cf724a..32dd693b4e42 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -181,12 +181,6 @@ CC_FLAGS_FTRACE := -pg
 ifdef CONFIG_MPROFILE_KERNEL
 CC_FLAGS_FTRACE += -mprofile-kernel
 endif
-# Work around gcc code-gen bugs with -pg / -fno-omit-frame-pointer in gcc <= 4.8
-# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=44199
-# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=52828
-ifndef CONFIG_CC_IS_CLANG
-CC_FLAGS_FTRACE	+= $(call cc-ifversion, -lt, 0409, -mno-sched-epilog)
-endif
 endif
 
 CFLAGS-$(CONFIG_TARGET_CPU_BOOL) += $(call cc-option,-mcpu=$(CONFIG_TARGET_CPU))
-- 
2.25.0

