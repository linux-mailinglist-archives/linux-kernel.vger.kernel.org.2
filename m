Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6D2370E32
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 19:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbhEBR1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 13:27:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:54560 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230110AbhEBR1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 13:27:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 65CBFB001;
        Sun,  2 May 2021 17:26:19 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: Don't opencode HAVE_EFFICIENT_UNALIGNED_ACCESS
Date:   Sun,  2 May 2021 19:26:08 +0200
Message-Id: <20210502172608.6309-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is some disconnect between commit 8a18cc0c2c36 ("powerpc: Only
disable HAVE_EFFICIENT_UNALIGNED_ACCESS on POWER7 little endian") and
commit a75c380c7129 ("powerpc: Enable DCACHE_WORD_ACCESS on ppc64le").

The first defines HAVE_EFFICIENT_UNALIGNED_ACCESS for the purpose of
enabling DCACHE_WORD_ACCESS and the second opencodes it, and differently
at that.

Fixes: a75c380c7129 ("powerpc: Enable DCACHE_WORD_ACCESS on ppc64le")
Fixes: 8a18cc0c2c36 ("powerpc: Only disable HAVE_EFFICIENT_UNALIGNED_ACCESS on POWER7 little endian")
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 75b3afbfc378..b00c37097ca2 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -162,7 +162,7 @@ config PPC
 	select BUILDTIME_TABLE_SORT
 	select BUILD_ELF_V2			if PPC64 && CPU_LITTLE_ENDIAN
 	select CLONE_BACKWARDS
-	select DCACHE_WORD_ACCESS		if PPC64 && CPU_LITTLE_ENDIAN
+	select DCACHE_WORD_ACCESS		if HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select DMA_OPS				if PPC64
 	select DMA_OPS_BYPASS			if PPC64
 	select ARCH_HAS_DMA_MAP_DIRECT 		if PPC64 && PPC_PSERIES
-- 
2.26.2

