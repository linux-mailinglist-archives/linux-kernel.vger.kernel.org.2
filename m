Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC45E3B594F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 08:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbhF1G6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 02:58:44 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:1690 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229998AbhF1G6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 02:58:40 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4GCz0Z1XbBzBD43;
        Mon, 28 Jun 2021 08:56:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id poyzRmXiZb1n; Mon, 28 Jun 2021 08:56:14 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4GCz0X74MZzBD3c;
        Mon, 28 Jun 2021 08:56:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DABB68B77A;
        Mon, 28 Jun 2021 08:56:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id mHCaIC5uIEYQ; Mon, 28 Jun 2021 08:56:11 +0200 (CEST)
Received: from po9473vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.102])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9FC598B77F;
        Mon, 28 Jun 2021 08:56:11 +0200 (CEST)
Received: by po9473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 8264864BE3; Mon, 28 Jun 2021 06:56:11 +0000 (UTC)
Message-Id: <42f4bd12b476942e4d5dc81c0e839d8871b20b1c.1624863319.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/32s: Fix setup_{kuap/kuep}() on SMP
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 28 Jun 2021 06:56:11 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On SMP, setup_kup() is also called from start_secondary().

start_secondary() is not an __init function.

Remove the __init marker from setup_kuep() and and setup_kuap().

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 86f46f343272 ("powerpc/32s: Initialise KUAP and KUEP in C").
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/book3s32/kuap.c | 2 +-
 arch/powerpc/mm/book3s32/kuep.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/book3s32/kuap.c b/arch/powerpc/mm/book3s32/kuap.c
index 9df6911b8fde..0f920f09af57 100644
--- a/arch/powerpc/mm/book3s32/kuap.c
+++ b/arch/powerpc/mm/book3s32/kuap.c
@@ -18,7 +18,7 @@ void kuap_unlock_all_ool(void)
 }
 EXPORT_SYMBOL(kuap_unlock_all_ool);
 
-void __init setup_kuap(bool disabled)
+void setup_kuap(bool disabled)
 {
 	if (!disabled)
 		kuap_lock_all_ool();
diff --git a/arch/powerpc/mm/book3s32/kuep.c b/arch/powerpc/mm/book3s32/kuep.c
index 3f6eb6e23fca..c20733d6e02c 100644
--- a/arch/powerpc/mm/book3s32/kuep.c
+++ b/arch/powerpc/mm/book3s32/kuep.c
@@ -5,7 +5,7 @@
 
 struct static_key_false disable_kuep_key;
 
-void __init setup_kuep(bool disabled)
+void setup_kuep(bool disabled)
 {
 	if (!disabled)
 		kuep_lock();
-- 
2.25.0

