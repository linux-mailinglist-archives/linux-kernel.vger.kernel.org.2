Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE6832AA39
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 20:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581684AbhCBTQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 14:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349626AbhCBQc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 11:32:26 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1768C0617A9
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 08:21:54 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:d15e:6060:f6a9:3ce5])
        by michel.telenet-ops.be with bizsmtp
        id bUMs240080v3pQi06UMsDp; Tue, 02 Mar 2021 17:21:53 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lH7mQ-004Cqp-92; Tue, 02 Mar 2021 17:21:50 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lH7mP-00FwaM-B5; Tue, 02 Mar 2021 17:21:49 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmer@dabbelt.com>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] sh: Use generic GCC library routines
Date:   Tue,  2 Mar 2021 17:21:48 +0100
Message-Id: <20210302162148.3800079-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The C implementations of __ashldi3(), __ashrdi3__(), and __lshrdi3() in
arch/sh/lib/ are identical to the generic C implementations in lib/.
Reduce duplication by switching SH to the generic versions.

Update the include path in arch/sh/boot/compressed accordingly.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Fix silly typo in subject.

Against sh/for-next, tested on landisk and qemu/rts7751r2d.

Note that it also works without the change to arch/sh/boot/compressed/,
as lib/ashldi3.c can be reached via both include/uapi/../../lib/ashldi3.c
and arch/sh/boot/compressed/../../../../lib/ashldi3.c.

Palmer tried a similar thing before:
https://lore.kernel.org/linux-arch/20170523220546.16758-1-palmer@dabbelt.com/
but initially it broke the SH build due to a missing change to
arch/sh/boot/compressed/, and the later update never got picked up.
In the mean time, arch/sh/boot/compressed/ was changed, so his patch no
longer applies.

Similar for the other architectures, I guess?
---
 arch/sh/Kconfig                   |  3 +++
 arch/sh/boot/compressed/ashldi3.c |  4 ++--
 arch/sh/lib/Makefile              |  4 +---
 arch/sh/lib/ashldi3.c             | 30 -----------------------------
 arch/sh/lib/ashrdi3.c             | 32 -------------------------------
 arch/sh/lib/lshrdi3.c             | 30 -----------------------------
 6 files changed, 6 insertions(+), 97 deletions(-)
 delete mode 100644 arch/sh/lib/ashldi3.c
 delete mode 100644 arch/sh/lib/ashrdi3.c
 delete mode 100644 arch/sh/lib/lshrdi3.c

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index e798e55915c2337f..468e475c02d184bd 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -19,6 +19,9 @@ config SUPERH
 	select GENERIC_CMOS_UPDATE if SH_SH03 || SH_DREAMCAST
 	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_IRQ_SHOW
+	select GENERIC_LIB_ASHLDI3
+	select GENERIC_LIB_ASHRDI3
+	select GENERIC_LIB_LSHRDI3
 	select GENERIC_PCI_IOMAP if PCI
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_STRNCPY_FROM_USER
diff --git a/arch/sh/boot/compressed/ashldi3.c b/arch/sh/boot/compressed/ashldi3.c
index 7cebd646df839b48..7c12121702309e8c 100644
--- a/arch/sh/boot/compressed/ashldi3.c
+++ b/arch/sh/boot/compressed/ashldi3.c
@@ -1,2 +1,2 @@
-// SPDX-License-Identifier: GPL-2.0-only
-#include "../../lib/ashldi3.c"
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include "../../../../lib/ashldi3.c"
diff --git a/arch/sh/lib/Makefile b/arch/sh/lib/Makefile
index eb473d373ca43a4b..d20a0768b31fa2b6 100644
--- a/arch/sh/lib/Makefile
+++ b/arch/sh/lib/Makefile
@@ -7,9 +7,7 @@ lib-y  = delay.o memmove.o memchr.o \
 	 checksum.o strlen.o div64.o div64-generic.o
 
 # Extracted from libgcc
-obj-y += movmem.o ashldi3.o ashrdi3.o lshrdi3.o \
-	 ashlsi3.o ashrsi3.o ashiftrt.o lshrsi3.o \
-	 udiv_qrnnd.o
+obj-y += movmem.o ashlsi3.o ashrsi3.o ashiftrt.o lshrsi3.o udiv_qrnnd.o
 
 udivsi3-y			:= udivsi3_i4i-Os.o
 
diff --git a/arch/sh/lib/ashldi3.c b/arch/sh/lib/ashldi3.c
deleted file mode 100644
index e5afe0935847427f..0000000000000000
--- a/arch/sh/lib/ashldi3.c
+++ /dev/null
@@ -1,30 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/module.h>
-
-#include "libgcc.h"
-
-long long __ashldi3(long long u, word_type b)
-{
-	DWunion uu, w;
-	word_type bm;
-
-	if (b == 0)
-		return u;
-
-	uu.ll = u;
-	bm = 32 - b;
-
-	if (bm <= 0) {
-		w.s.low = 0;
-		w.s.high = (unsigned int) uu.s.low << -bm;
-	} else {
-		const unsigned int carries = (unsigned int) uu.s.low >> bm;
-
-		w.s.low = (unsigned int) uu.s.low << b;
-		w.s.high = ((unsigned int) uu.s.high << b) | carries;
-	}
-
-	return w.ll;
-}
-
-EXPORT_SYMBOL(__ashldi3);
diff --git a/arch/sh/lib/ashrdi3.c b/arch/sh/lib/ashrdi3.c
deleted file mode 100644
index ae263fbf25383b70..0000000000000000
--- a/arch/sh/lib/ashrdi3.c
+++ /dev/null
@@ -1,32 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/module.h>
-
-#include "libgcc.h"
-
-long long __ashrdi3(long long u, word_type b)
-{
-	DWunion uu, w;
-	word_type bm;
-
-	if (b == 0)
-		return u;
-
-	uu.ll = u;
-	bm = 32 - b;
-
-	if (bm <= 0) {
-		/* w.s.high = 1..1 or 0..0 */
-		w.s.high =
-		    uu.s.high >> 31;
-		w.s.low = uu.s.high >> -bm;
-	} else {
-		const unsigned int carries = (unsigned int) uu.s.high << bm;
-
-		w.s.high = uu.s.high >> b;
-		w.s.low = ((unsigned int) uu.s.low >> b) | carries;
-	}
-
-	return w.ll;
-}
-
-EXPORT_SYMBOL(__ashrdi3);
diff --git a/arch/sh/lib/lshrdi3.c b/arch/sh/lib/lshrdi3.c
deleted file mode 100644
index 33eaa1edbc3c0656..0000000000000000
--- a/arch/sh/lib/lshrdi3.c
+++ /dev/null
@@ -1,30 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/module.h>
-
-#include "libgcc.h"
-
-long long __lshrdi3(long long u, word_type b)
-{
-	DWunion uu, w;
-	word_type bm;
-
-	if (b == 0)
-		return u;
-
-	uu.ll = u;
-	bm = 32 - b;
-
-	if (bm <= 0) {
-		w.s.high = 0;
-		w.s.low = (unsigned int) uu.s.high >> -bm;
-	} else {
-		const unsigned int carries = (unsigned int) uu.s.high << bm;
-
-		w.s.high = (unsigned int) uu.s.high >> b;
-		w.s.low = ((unsigned int) uu.s.low >> b) | carries;
-	}
-
-	return w.ll;
-}
-
-EXPORT_SYMBOL(__lshrdi3);
-- 
2.25.1

