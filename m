Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A859C3FFEE5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 13:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349245AbhICLUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 07:20:08 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:48607 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349233AbhICLT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 07:19:58 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4H1FfW61qGz9sV4;
        Fri,  3 Sep 2021 13:18:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xgSwBYkb-MRG; Fri,  3 Sep 2021 13:18:43 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4H1FfV4jHcz9sT0;
        Fri,  3 Sep 2021 13:18:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8C06A8B8E3;
        Fri,  3 Sep 2021 13:18:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id W2yoF_YuYC2g; Fri,  3 Sep 2021 13:18:42 +0200 (CEST)
Received: from po18078vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5F3288B764;
        Fri,  3 Sep 2021 13:18:42 +0200 (CEST)
Received: by po18078vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 2D31463D74; Fri,  3 Sep 2021 11:18:42 +0000 (UTC)
Message-Id: <a47bb6a69c68156bc2d555152dab5a23733856b7.1630667612.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1630667612.git.christophe.leroy@csgroup.eu>
References: <cover.1630667612.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [RFC PATCH v1 07/11] powerpc/mpc86xx_hpcn: Remove obsolete statement
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri,  3 Sep 2021 11:18:42 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Comment says "Delete this in 2.6.27".

Do so now.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index b697918b727d..a6b8ffcbf01a 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -95,12 +95,6 @@ static int __init mpc86xx_hpcn_probe(void)
 	if (of_machine_is_compatible("fsl,mpc8641hpcn"))
 		return 1;	/* Looks good */
 
-	/* Be nice and don't give silent boot death.  Delete this in 2.6.27 */
-	if (of_machine_is_compatible("mpc86xx")) {
-		pr_warn("WARNING: your dts/dtb is old. You must update before the next kernel release.\n");
-		return 1;
-	}
-
 	return 0;
 }
 
-- 
2.25.0

