Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C913254D4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 18:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbhBYRwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 12:52:43 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:32838 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232549AbhBYRvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 12:51:19 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DmgLD4QBbz9v1B0;
        Thu, 25 Feb 2021 18:50:28 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 4bSuDRE5h1vb; Thu, 25 Feb 2021 18:50:28 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DmgLD3FF7z9v19y;
        Thu, 25 Feb 2021 18:50:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 493D78B895;
        Thu, 25 Feb 2021 18:50:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id C4JgywURdKTZ; Thu, 25 Feb 2021 18:50:30 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 161A18B88B;
        Thu, 25 Feb 2021 18:50:30 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id D011367442; Thu, 25 Feb 2021 17:50:29 +0000 (UTC)
Message-Id: <cover.1614275314.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 00/15] powerpc: Cleanup of uaccess.h
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 25 Feb 2021 17:50:29 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series cleans up uaccess.h

Christophe Leroy (15):
  powerpc/uaccess: Remove __get_user_allowed() and unsafe_op_wrap()
  powerpc/uaccess: Define ___get_user_instr() for ppc32
  powerpc/uaccess: Remove __get/put_user_inatomic()
  powerpc/uaccess: Move get_user_instr helpers in asm/inst.h
  powerpc/align: Don't use __get_user_instr() on kernel addresses
  powerpc/uaccess: Call might_fault() inconditionaly
  powerpc/uaccess: Remove __unsafe_put_user_goto()
  powerpc/uaccess: Remove __chk_user_ptr() in __get/put_user
  powerpc/uaccess: Remove calls to __get_user_bad() and __put_user_bad()
  powerpc/uaccess: Split out __get_user_nocheck()
  powerpc/uaccess: Rename __get/put_user_check/nocheck
  powerpc/uaccess: Refactor get/put_user() and __get/put_user()
  powerpc/uaccess: Swap clear_user() and __clear_user()
  powerpc/uaccess: Also perform 64 bits copies in unsafe_copy_to_user()
    on ppc32
  powerpc/uaccess: Move copy_mc_xxx() functions down

 arch/powerpc/include/asm/inst.h               |  34 ++
 arch/powerpc/include/asm/uaccess.h            | 303 ++++++------------
 arch/powerpc/kernel/align.c                   |  38 ++-
 .../kernel/hw_breakpoint_constraints.c        |   2 +-
 arch/powerpc/kernel/traps.c                   |   2 +-
 5 files changed, 147 insertions(+), 232 deletions(-)

-- 
2.25.0

