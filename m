Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC6436EE65
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 18:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240831AbhD2QxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 12:53:09 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:57062 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231238AbhD2QxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 12:53:04 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4FWM3z3zVcz9vss;
        Thu, 29 Apr 2021 18:52:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id t-dqF61kQ6FV; Thu, 29 Apr 2021 18:52:15 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FWM3t59Zsz9vt4;
        Thu, 29 Apr 2021 18:52:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8A49A8B869;
        Thu, 29 Apr 2021 18:52:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 3kkl2hDpF35n; Thu, 29 Apr 2021 18:52:10 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2D0908B866;
        Thu, 29 Apr 2021 18:52:10 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 0105E6429D; Thu, 29 Apr 2021 16:52:09 +0000 (UTC)
Message-Id: <b688fe82927b330349d9e44553363fa451ea4d95.1619715114.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/32: Fix boot failure with CONFIG_STACKPROTECTOR
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, j.neuschaefer@gmx.net,
        jniethe5@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 29 Apr 2021 16:52:09 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7c95d8893fb5 ("powerpc: Change calling convention for
create_branch() et. al.") complexified the frame of function
do_feature_fixups(), leading to GCC setting up a stack
guard when CONFIG_STACKPROTECTOR is selected.

The problem is that do_feature_fixups() is called very early
while 'current' in r2 is not set up yet and the code is still
not at the final address used at link time.

So, like other instrumentation, stack protection needs to be
deactivated for feature-fixups.c and code-patching.c

Reported-by: Jonathan Neuschaefer <j.neuschaefer@gmx.net>
Fixes: 7c95d8893fb5 ("powerpc: Change calling convention for create_branch() et. al.")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/lib/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index f2c690ee75d1..cc1a8a0f311e 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -5,6 +5,9 @@
 
 ccflags-$(CONFIG_PPC64)	:= $(NO_MINIMAL_TOC)
 
+CFLAGS_code-patching.o += -fno-stack-protector
+CFLAGS_feature-fixups.o += -fno-stack-protector
+
 CFLAGS_REMOVE_code-patching.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_feature-fixups.o = $(CC_FLAGS_FTRACE)
 
-- 
2.25.0

