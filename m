Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE243FFBE7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 10:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348287AbhICIYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 04:24:54 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:49597 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348265AbhICIYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 04:24:53 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4H19mm5Rvzz9sT9;
        Fri,  3 Sep 2021 10:23:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZBvMU4xRnA_L; Fri,  3 Sep 2021 10:23:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4H19mm4Vpxz9sSn;
        Fri,  3 Sep 2021 10:23:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7FF878B764;
        Fri,  3 Sep 2021 10:23:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id csxmlrTjs1x2; Fri,  3 Sep 2021 10:23:52 +0200 (CEST)
Received: from po18078vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 495848B8CD;
        Fri,  3 Sep 2021 10:23:52 +0200 (CEST)
Received: by po18078vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 137916BCC3; Fri,  3 Sep 2021 08:23:52 +0000 (UTC)
Message-Id: <b2e52934e5a500f149e6d94db3cfa0569bc35081.1630657402.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/powermac: Remove stale declaration of pmac_md
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri,  3 Sep 2021 08:23:52 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pmac_md doesn't exist anymore, remove stall declaration.

Fixes: e8222502ee61 ("[PATCH] powerpc: Kill _machine and hard-coded platform numbers")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/platforms/powermac/setup.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index 86aee3f2483f..13e8a8a9841c 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -79,8 +79,6 @@ int pmac_newworld;
 
 static int current_root_goodness = -1;
 
-extern struct machdep_calls pmac_md;
-
 #define DEFAULT_ROOT_DEVICE Root_SDA1	/* sda1 - slightly silly choice */
 
 #ifdef CONFIG_PPC64
-- 
2.25.0

