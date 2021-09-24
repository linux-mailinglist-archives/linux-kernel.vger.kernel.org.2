Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690D9417980
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 19:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344017AbhIXRPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 13:15:44 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:51679 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244773AbhIXRPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 13:15:43 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HGJXw46ttz9sW1;
        Fri, 24 Sep 2021 19:14:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WieYpIoaJD3j; Fri, 24 Sep 2021 19:14:08 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HGJXw3234z9sW0;
        Fri, 24 Sep 2021 19:14:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3D8BF8B77E;
        Fri, 24 Sep 2021 19:14:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id jVw6Wv7Xqqrs; Fri, 24 Sep 2021 19:14:08 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.215])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EE74D8B763;
        Fri, 24 Sep 2021 19:14:07 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 18OHDuKh1302144
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 24 Sep 2021 19:13:57 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 18OHDt7W1302143;
        Fri, 24 Sep 2021 19:13:55 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] powerpc: Activate CONFIG_STRICT_KERNEL_RWX by default
Date:   Fri, 24 Sep 2021 19:13:53 +0200
Message-Id: <057c40164084bfc7d77c0b2ff78d95dbf6a2a21b.1632503622.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_STRICT_KERNEL_RWX should be set by default on every
architectures (See https://github.com/KSPP/linux/issues/4)

On PPC32 we have to find a compromise between performance and/or
memory wasting and selection of strict_kernel_rwx, because it implies
either smaller memory chunks or larger alignment between RO memory
and RW memory.

For instance the 8xx maps memory with 8M pages. So either the limit
between RO and RW must be 8M aligned or it falls back or 512k pages
which implies more pressure on the TLB.

book3s/32 maps memory with BATs as much as possible. BATS can have
any power-of-two size between 128k and 256M but we have only 4 to 8
BATs so the alignment must be good enough to allow efficient use of
the BATs and avoid falling back on standard page mapping which would
kill performance.

So let's go one step forward and make it the default but still allow
users to unset it when wanted.

Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index ba5b66189358..79332f51185d 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -148,6 +148,7 @@ config PPC
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select ARCH_OPTIONAL_KERNEL_RWX		if ARCH_HAS_STRICT_KERNEL_RWX
+	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
 	select ARCH_STACKWALK
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_DEBUG_PAGEALLOC	if PPC32 || PPC_BOOK3S_64
-- 
2.31.1

