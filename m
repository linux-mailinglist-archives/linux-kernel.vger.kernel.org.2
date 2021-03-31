Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49513502B5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 16:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236204AbhCaOuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 10:50:17 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:28191 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236023AbhCaOtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 10:49:47 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F9Tk10S5Sz9tyTX;
        Wed, 31 Mar 2021 16:49:45 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id KpGHWw4eXnlN; Wed, 31 Mar 2021 16:49:44 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F9Tk05Jtjz9tyTT;
        Wed, 31 Mar 2021 16:49:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C97D28B829;
        Wed, 31 Mar 2021 16:49:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 6yodf-RsKUjk; Wed, 31 Mar 2021 16:49:45 +0200 (CEST)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 86D828B828;
        Wed, 31 Mar 2021 16:49:45 +0200 (CEST)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 4A9A667647; Wed, 31 Mar 2021 14:49:45 +0000 (UTC)
Message-Id: <cover.1617202094.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 0/4] powerpc/vdso: Add support for time namespaces
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 31 Mar 2021 14:49:45 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for time namespaces on powerpc.

All timens selftests are successfull.

Christophe Leroy (3):
  lib/vdso: Mark do_hres_timens() and do_coarse_timens()
    __always_inline()
  lib/vdso: Add vdso_data pointer as input to
    __arch_get_timens_vdso_data()
  powerpc/vdso: Add support for time namespaces

Dmitry Safonov (1):
  powerpc/vdso: Separate vvar vma from vdso

 .../include/asm/vdso/compat_gettimeofday.h    |   3 +-
 arch/arm64/include/asm/vdso/gettimeofday.h    |   2 +-
 arch/powerpc/Kconfig                          |   3 +-
 arch/powerpc/include/asm/mmu_context.h        |   2 +-
 arch/powerpc/include/asm/vdso/gettimeofday.h  |  10 ++
 arch/powerpc/include/asm/vdso_datapage.h      |   2 -
 arch/powerpc/kernel/vdso.c                    | 138 ++++++++++++++++--
 arch/powerpc/kernel/vdso32/vdso32.lds.S       |   2 +-
 arch/powerpc/kernel/vdso64/vdso64.lds.S       |   2 +-
 arch/s390/include/asm/vdso/gettimeofday.h     |   3 +-
 arch/x86/include/asm/vdso/gettimeofday.h      |   3 +-
 lib/vdso/gettimeofday.c                       |  31 ++--
 12 files changed, 162 insertions(+), 39 deletions(-)

-- 
2.25.0

