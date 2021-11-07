Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540584473BF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 17:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbhKGQZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 11:25:34 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:65134 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbhKGQZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 11:25:33 -0500
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 1A7GM2eN016622;
        Mon, 8 Nov 2021 01:22:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 1A7GM2eN016622
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1636302122;
        bh=LPT7fqng908AUrpkMha16op10BGK0GQAuZ1ffUrIu30=;
        h=From:To:Cc:Subject:Date:From;
        b=Jl0tjuc2C7TBVyeyAH11BKg5tAn5Ts9seFjsKGCAl3tkCxKZQkI1d8oM5OVXPYn/f
         eEIn5c36x3lSLdxZNUSMHZcCEd0ElEvQu+nNK4P1VlCJu9ceUy/irL9gQRKwX1x3wz
         TtqFVNF2U5BdAKemtHY7VY+ijtbJzNqXTSUDdJZKSJUh+QU/hsWPYW9gZwETRE2b/6
         GbNYXyY9A37hRhFZZLIzy8hS+qoirmSNqK9UtledIVXTzKW8qxm+Ag2tnlx8E6I8Ba
         RVpzQijMM18pDeX19IHaxoR7De015+zWl/+B0ePCKE3fRPzxNQ/kvcBw1CUboU7WXD
         QybmtNm66c4bA==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     sparclinux@vger.kernel.org
Cc:     clang-built-linux@googlegroups.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sparc: vdso: remove -nostdlib compiler flag
Date:   Mon,  8 Nov 2021 01:21:57 +0900
Message-Id: <20211107162157.323873-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The -nostdlib option requests the compiler to not use the standard
system startup files or libraries when linking. It is effective only
when $(CC) is used as a linker driver.

Since commit 3c2b2d9408b1 ("sparc: Really use linker with LDFLAGS."),
$(LD) is directly used, hence -nostdlib is unneeded.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/sparc/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
index c5e1545bc5cf..18be71250a0a 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -108,7 +108,7 @@ $(obj)/vdso32.so.dbg: FORCE \
 # The DSO images are built using a special linker script.
 #
 quiet_cmd_vdso = VDSO    $@
-      cmd_vdso = $(LD) -nostdlib -o $@ \
+      cmd_vdso = $(LD) -o $@ \
 		       $(VDSO_LDFLAGS) $(VDSO_LDFLAGS_$(filter %.lds,$(^F))) \
 		       -T $(filter %.lds,$^) $(filter %.o,$^) && \
 		sh $(srctree)/$(src)/checkundef.sh '$(OBJDUMP)' '$@'
-- 
2.30.2

