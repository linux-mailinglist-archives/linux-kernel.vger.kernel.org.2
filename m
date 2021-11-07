Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3194473B9
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 17:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235750AbhKGQXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 11:23:11 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:47007 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234949AbhKGQXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 11:23:10 -0500
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 1A7GJ3t0006971;
        Mon, 8 Nov 2021 01:19:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 1A7GJ3t0006971
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1636301944;
        bh=5RXmLl5bCtAukQN97+d2QAYSEJ6auZ6akf2R3WZ4+JM=;
        h=From:To:Cc:Subject:Date:From;
        b=KEFQ5bWVkFpjPorZjMi7DSvrAYeTQ6GMuqkx3ousylTarq6E8lMym35/95j20Fhvj
         c5u+ZzUZJXRhKr61kk3PcqWK66wrPIzSVOqz1jR4PFbtWJSbwN1MHHfd6uDhbsQibN
         EcW34voj4X/A7XQO7MNqjx406Ez26anOAK5fixruq+GOEJOwPmPPr75rQnoi6vMH5o
         KVCqJhf3z6jbSUvdzuknFXPsAmqd3MDtccbdgTkNctHmKOX/+PDmfgCSn3I5sQD0+l
         yO63gyMHzIzKYhFK03408dAQ5ERMYvjoAuSJ/voVfeG3ILTLEpQqPTYFMmG2lIWCwO
         El31kaW0s5wOg==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Russell King <rmk+kernel@armlinux.org.uk>
Cc:     clang-built-linux@googlegroups.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: vdso: remove -nostdlib compiler flag
Date:   Mon,  8 Nov 2021 01:18:55 +0900
Message-Id: <20211107161855.323312-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The -nostdlib option requests the compiler to not use the standard
system startup files or libraries when linking. It is effective only
when $(CC) is used as a linker driver.

Since commit fe00e50b2db8 ("ARM: 8858/1: vdso: use $(LD) instead of
$(CC) to link VDSO"), $(LD) is directly used, hence -nostdlib is
unneeded.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/arm/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
index 7c9e395b77f7..ec52b776f926 100644
--- a/arch/arm/vdso/Makefile
+++ b/arch/arm/vdso/Makefile
@@ -18,7 +18,7 @@ ccflags-y += -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO32
 
 ldflags-$(CONFIG_CPU_ENDIAN_BE8) := --be8
 ldflags-y := -Bsymbolic --no-undefined -soname=linux-vdso.so.1 \
-	    -z max-page-size=4096 -nostdlib -shared $(ldflags-y) \
+	    -z max-page-size=4096 -shared $(ldflags-y) \
 	    --hash-style=sysv --build-id=sha1 \
 	    -T
 
-- 
2.30.2

