Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E927B399CD8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 10:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhFCIn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 04:43:59 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:31593 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229656AbhFCIn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 04:43:58 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4FwfWv3hs1zBC5j;
        Thu,  3 Jun 2021 10:41:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jq7SXitm_Ewg; Thu,  3 Jun 2021 10:41:47 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FwfWt2tl3zBC60;
        Thu,  3 Jun 2021 10:41:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 51B978B848;
        Thu,  3 Jun 2021 10:41:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id bwCD3RmmrU79; Thu,  3 Jun 2021 10:41:46 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1F5568B767;
        Thu,  3 Jun 2021 10:41:46 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id EFB9164BD2; Thu,  3 Jun 2021 08:41:45 +0000 (UTC)
Message-Id: <86c7c74a3ba5312daea7e9658b096e2bcc6f4b64.1622708530.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1622708530.git.christophe.leroy@csgroup.eu>
References: <cover.1622708530.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 10/12] powerpc/32s: Activate KUAP and KUEP by default
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  3 Jun 2021 08:41:45 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that KUAP and KUEP have been significantly optimised and can be
disabled at boot time using 'nosmap' and 'nosmep' kernel parameters,
them can be active by default like in other powerpc platforms.

It is still possible to disable them completely in the configuration.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/platforms/Kconfig.cputype | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 885140055b7a..52f533b19518 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -389,7 +389,7 @@ config PPC_HAVE_KUEP
 config PPC_KUEP
 	bool "Kernel Userspace Execution Prevention"
 	depends on PPC_HAVE_KUEP
-	default y if !PPC_BOOK3S_32
+	default y
 	help
 	  Enable support for Kernel Userspace Execution Prevention (KUEP)
 
@@ -401,7 +401,7 @@ config PPC_HAVE_KUAP
 config PPC_KUAP
 	bool "Kernel Userspace Access Protection"
 	depends on PPC_HAVE_KUAP
-	default y if !PPC_BOOK3S_32
+	default y
 	help
 	  Enable support for Kernel Userspace Access Protection (KUAP)
 
-- 
2.25.0

