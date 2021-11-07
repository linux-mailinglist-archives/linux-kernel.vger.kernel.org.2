Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E77BA4473C9
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 17:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235775AbhKGQbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 11:31:06 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:53259 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbhKGQbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 11:31:03 -0500
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 1A7GQh1D020834;
        Mon, 8 Nov 2021 01:26:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 1A7GQh1D020834
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1636302404;
        bh=gx9ybrrvRFYll7zA4wYrhSeUk/K5DRQcs+620maBVto=;
        h=From:To:Cc:Subject:Date:From;
        b=oaI7cv1GfXD3xrckUTc8WsWhVfffizfI9fE8/98l1pJoE8bxOHIqLJwoh57lqJWby
         4c/a3wf/ii7UPjmnKmRcpDFk71U0q4CGrcQNAqtK8cnno2u67a6ZpEzXa1O3vB/mjf
         0aqvE+w/6fgSoSUCy4o5AmMdcxsbnNLHH4rViztPPiRoANZy7jL56LJjs/51/Ob3t6
         sDHawCIfh8ikVbp66stHOzsOqy7Osbkf5u7X8ywVQesbFNE3TdumMP7dVbSUYvbK9y
         WygAYj+nhaeiuij6RLpAP9nmbd+y/OathC8lcqlAcVcJoP/+/95Oic6pbkLs7Ob1xW
         90z+xtbWbugBw==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        clang-built-linux@googlegroups.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] x86/vdso: remove -nostdlib compiler flag
Date:   Mon,  8 Nov 2021 01:26:40 +0900
Message-Id: <20211107162641.324688-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The -nostdlib option requests the compiler to not use the standard
system startup files or libraries when linking. It is effective only
when $(CC) is used as a linker driver.

Since

  379d98ddf413 ("x86: vdso: Use $LD instead of $CC to link")

$(LD) is directly used, hence -nostdlib is unneeded.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/x86/entry/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index a2dddcc189f6..693f8b9031fb 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -172,7 +172,7 @@ $(obj)/vdso32.so.dbg: $(obj)/vdso32/vdso32.lds $(vobjs32) FORCE
 # The DSO images are built using a special linker script.
 #
 quiet_cmd_vdso = VDSO    $@
-      cmd_vdso = $(LD) -nostdlib -o $@ \
+      cmd_vdso = $(LD) -o $@ \
 		       $(VDSO_LDFLAGS) $(VDSO_LDFLAGS_$(filter %.lds,$(^F))) \
 		       -T $(filter %.lds,$^) $(filter %.o,$^) && \
 		 sh $(srctree)/$(src)/checkundef.sh '$(NM)' '$@'
-- 
2.30.2

