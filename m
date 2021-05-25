Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE7E390067
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 13:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbhEYL5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 07:57:46 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:39237 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbhEYL5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 07:57:41 -0400
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 14PBsOwI021380;
        Tue, 25 May 2021 20:54:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 14PBsOwI021380
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1621943665;
        bh=V+gm1MoogimFfSAAfmNf6D6xHKs8r0D00kjReKhDXG0=;
        h=From:To:Cc:Subject:Date:From;
        b=n4rH5ypkPPhMhcKjpZWiQX9AIkW6jt8yzL8niiag9si0G+5hkR+AYYohZWW+53djx
         UYoPuWi39ddfUECJWpRiKOH3UJJhCh+gATpKWIuQUMGgzpbA7S0huyEECx6ID1bu80
         3ItLw3kTIHCaif0tU/y2w3UYv2dJzlFa9RdABZn7nteF3KIg5GVnEfhG3Vl+DKCpq+
         GAVGSHHU4bchRl47Kx3WuOWzEuc8mNQiZjiRIu/3Mv44HBpPCYgEW+QqGO5daur8Kn
         M1q0UNuVzEwN+VriHeJzn/36F06iY16szRRrPJhmD0dDcJnwW18qCPvbntpBc9F/F+
         RglaiAbIYSgTg==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/syscalls: clear 'offset' and 'prefix' in case they are set in env
Date:   Tue, 25 May 2021 20:54:20 +0900
Message-Id: <20210525115420.679416-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the environment variable 'prefix' is set on the build host,
it is wrongly used as syscall macro prefixes.

  $ export prefix=/usr
  $ make -s defconfig all
  In file included from ./arch/x86/include/asm/unistd.h:20,
                   from <stdin>:2:
  ./arch/x86/include/generated/uapi/asm/unistd_64.h:4:9: warning: missing whitespace after the macro name
      4 | #define __NR_/usrread 0
        |         ^~~~~

arch/x86/entry/syscalls/Makefile should clear 'offset' and 'prefix'.

Link: https://lore.kernel.org/lkml/CA+G9fYvFXTHPKwasdVidF7qEHdqwRht8Xg6qm6CCLL0HGaU1ew@mail.gmail.com/
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Fixes: 3cba325b358f ("x86/syscalls: Switch to generic syscallhdr.sh")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/x86/entry/syscalls/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/entry/syscalls/Makefile b/arch/x86/entry/syscalls/Makefile
index 8eb014bca8c9..5b3efed0e4e8 100644
--- a/arch/x86/entry/syscalls/Makefile
+++ b/arch/x86/entry/syscalls/Makefile
@@ -11,6 +11,8 @@ syscall64 := $(src)/syscall_64.tbl
 
 syshdr := $(srctree)/scripts/syscallhdr.sh
 systbl := $(srctree)/scripts/syscalltbl.sh
+offset :=
+prefix :=
 
 quiet_cmd_syshdr = SYSHDR  $@
       cmd_syshdr = $(CONFIG_SHELL) $(syshdr) --abis $(abis) --emit-nr \
-- 
2.27.0

