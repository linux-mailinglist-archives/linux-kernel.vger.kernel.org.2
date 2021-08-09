Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60293E44DA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 13:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbhHIL3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 07:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235181AbhHIL3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 07:29:32 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642BAC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 04:29:11 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:85c3:1250:92e5:c526])
        by baptiste.telenet-ops.be with bizsmtp
        id fPV52500N4aJ70U01PV5bB; Mon, 09 Aug 2021 13:29:09 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mD3Sr-000xEo-EE; Mon, 09 Aug 2021 13:29:05 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mD3Sq-00GMEO-LG; Mon, 09 Aug 2021 13:29:04 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Greg Ungerer <gerg@uclinux.org>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     Brendan Jackman <jackmanb@google.com>,
        kernel test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2] m68k: Fix asm register constraints for atomic ops
Date:   Mon,  9 Aug 2021 13:29:03 +0200
Message-Id: <20210809112903.3898660-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on register assignment by the compiler:

    {standard input}:3084: Error: operands mismatch -- statement `andl %a1,%d1' ignored
    {standard input}:3145: Error: operands mismatch -- statement `orl %a1,%d1' ignored
    {standard input}:3195: Error: operands mismatch -- statement `eorl %a1,%d1' ignored

Indeed, the first operand must not be an address register.  However, it
can be an immediate value.  Fix this by adjusting the register
constraint from "g" (general purpose register) to "di" (data register or
immediate).

Fixes: e39d88ea3ce4a471 ("locking/atomic, arch/m68k: Implement atomic_fetch_{add,sub,and,or,xor}()")
Fixes: d839bae4269aea46 ("locking,arch,m68k: Fold atomic_ops")
Fixes: 1da177e4c3f41524 ("Linux-2.6.12-rc2")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Arnd Bergmann <arnd@arndb.de>
Reported-by: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Tested-by: Arnd Bergmann <arnd@arndb.de>
---
v2:
  - Add Tested-by,
  - Use "di" instead of "d".

Personally, I have never seen this failure in an 68020+ build, but I can
reproduce it on Coldfire with the config provided by lkp (with bogus
CONFIG_RMW_INSNS=y).
---
 arch/m68k/include/asm/atomic.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/include/asm/atomic.h b/arch/m68k/include/asm/atomic.h
index 8637bf8a2f652009..cfba83d230fdec37 100644
--- a/arch/m68k/include/asm/atomic.h
+++ b/arch/m68k/include/asm/atomic.h
@@ -48,7 +48,7 @@ static inline int arch_atomic_##op##_return(int i, atomic_t *v)		\
 			"	casl %2,%1,%0\n"			\
 			"	jne 1b"					\
 			: "+m" (*v), "=&d" (t), "=&d" (tmp)		\
-			: "g" (i), "2" (arch_atomic_read(v)));		\
+			: "di" (i), "2" (arch_atomic_read(v)));		\
 	return t;							\
 }
 
@@ -63,7 +63,7 @@ static inline int arch_atomic_fetch_##op(int i, atomic_t *v)		\
 			"	casl %2,%1,%0\n"			\
 			"	jne 1b"					\
 			: "+m" (*v), "=&d" (t), "=&d" (tmp)		\
-			: "g" (i), "2" (arch_atomic_read(v)));		\
+			: "di" (i), "2" (arch_atomic_read(v)));		\
 	return tmp;							\
 }
 
-- 
2.25.1

