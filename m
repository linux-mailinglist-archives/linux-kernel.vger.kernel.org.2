Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1F63D4D97
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 15:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhGYMUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 08:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbhGYMUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 08:20:38 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B8EC061764
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 06:01:08 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:fcbf:bbc7:105a:68c4])
        by albert.telenet-ops.be with bizsmtp
        id ZR14250031nuCSN06R14sA; Sun, 25 Jul 2021 15:01:05 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m7dkd-000iIZ-Co; Sun, 25 Jul 2021 15:01:03 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m7beF-001XHi-MS; Sun, 25 Jul 2021 12:46:19 +0200
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
Subject: [PATCH] m68k: Fix asm register constraints for atomic ops
Date:   Sun, 25 Jul 2021 12:46:18 +0200
Message-Id: <20210725104618.365790-1-geert@linux-m68k.org>
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

Indeed, the first operand must not be an address register.  Fix this by
adjusting the register constraint from "g" (general purpose register) to
"d" (data register).

Fixes: e39d88ea3ce4a471 ("locking/atomic, arch/m68k: Implement atomic_fetch_{add,sub,and,or,xor}()")
Fixes: d839bae4269aea46 ("locking,arch,m68k: Fold atomic_ops")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Arnd Bergmann <arnd@arndb.de>
Reported-by: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Personally, I have never seen this failure in an 68020+ build, but I can
reproduce it on Coldfire with the config provided by lkp (with bogus
CONFIG_RMW_INSNS=y).

Technically, the issue was present before, but I doubt adding pre-v3.18
Fixes tags would make any difference for stable...
---
 arch/m68k/include/asm/atomic.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/include/asm/atomic.h b/arch/m68k/include/asm/atomic.h
index 8637bf8a2f652009..2d5a6e556754290b 100644
--- a/arch/m68k/include/asm/atomic.h
+++ b/arch/m68k/include/asm/atomic.h
@@ -48,7 +48,7 @@ static inline int arch_atomic_##op##_return(int i, atomic_t *v)		\
 			"	casl %2,%1,%0\n"			\
 			"	jne 1b"					\
 			: "+m" (*v), "=&d" (t), "=&d" (tmp)		\
-			: "g" (i), "2" (arch_atomic_read(v)));		\
+			: "d" (i), "2" (arch_atomic_read(v)));		\
 	return t;							\
 }
 
@@ -63,7 +63,7 @@ static inline int arch_atomic_fetch_##op(int i, atomic_t *v)		\
 			"	casl %2,%1,%0\n"			\
 			"	jne 1b"					\
 			: "+m" (*v), "=&d" (t), "=&d" (tmp)		\
-			: "g" (i), "2" (arch_atomic_read(v)));		\
+			: "d" (i), "2" (arch_atomic_read(v)));		\
 	return tmp;							\
 }
 
-- 
2.25.1

