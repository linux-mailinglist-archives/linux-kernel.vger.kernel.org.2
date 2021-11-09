Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D2444B2E1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 19:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242763AbhKISy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 13:54:59 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:50527 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242715AbhKISy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 13:54:57 -0500
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 1A9IoUZc023095;
        Wed, 10 Nov 2021 03:50:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 1A9IoUZc023095
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1636483831;
        bh=BvQkRW9CNz6/jlg9D16+/K4NnL23b6i8ZHcso55PIA4=;
        h=From:To:Cc:Subject:Date:From;
        b=xv/I0xmifZEuwnRH9M9gh9+b4PL0Mf3zb3gt5htmu9nV6vPictomt92iU2OvoTsj/
         +u7+owpxirwELB+a8p5vmpCNW0HpREese7rMMBMyh5VfpgmwgnSvqNXDuFXt9Wv1Al
         vmR036vx/Fb/c5Qxl8HCItkgS1MqcJ/Sfldo35LlCnNtp6sdFkJwIv7a2B3o/BTvB/
         hrYZInYUx40syVmb8YFkyocIYOvuzqfcumgDgpfPWALNCrofd432/BbRG01r7gGZQq
         gDZrBeaLWCqGTc+QeaLI5zwv7v5OBNS8LB7erxogUXzeW1noiGGHKya5vCm0jne47t
         Az5RfAs8xb+tw==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: clean vdso32 and vdso64 directories
Date:   Wed, 10 Nov 2021 03:50:15 +0900
Message-Id: <20211109185015.615517-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit bce74491c300 ("powerpc/vdso: fix unnecessary rebuilds of
vgettimeofday.o"), "make ARCH=powerpc clean" does not clean up the
arch/powerpc/kernel/{vdso32,vdso64} directories.

Use the subdir- trick to let "make clean" descend into them.

Fixes: bce74491c300 ("powerpc/vdso: fix unnecessary rebuilds of vgettimeofday.o")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/powerpc/kernel/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 0e3640e14eb1..5fa68c2ef1f8 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -196,3 +196,6 @@ clean-files := vmlinux.lds
 # Force dependency (incbin is bad)
 $(obj)/vdso32_wrapper.o : $(obj)/vdso32/vdso32.so.dbg
 $(obj)/vdso64_wrapper.o : $(obj)/vdso64/vdso64.so.dbg
+
+# for cleaning
+subdir- += vdso32 vdso64
-- 
2.30.2

