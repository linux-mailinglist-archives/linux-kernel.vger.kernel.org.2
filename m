Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D4B3457CE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 07:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhCWG3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 02:29:44 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:60342 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbhCWG33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 02:29:29 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id EB8429804E9;
        Tue, 23 Mar 2021 14:29:26 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Ganesh Goudar <ganeshgr@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michal Suchanek <msuchanek@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pingfan Liu <kernelfans@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Subject: [PATCH] [v2] arch: powerpc: Remove duplicate includes
Date:   Tue, 23 Mar 2021 14:29:05 +0800
Message-Id: <20210323062916.295346-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGRkYTxlNQh8dQ0tCVkpNSk1PQ0tCTUxIQ0tVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKSkNITVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OU06ASo4FT8RNDpNCCs2DyI*
        EVYaCzVVSlVKTUpNT0NLQk1MTEhKVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFIQkJDNwY+
X-HM-Tid: 0a785dc61a84d992kuwseb8429804e9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mmu-hash.h: asm/bug.h has been included at line 12, so remove 
the duplicate one at line 21.
interrupt.c: asm/interrupt.h has been included at line 12, so 
remove the duplicate one at line 10. 
time.c: linux/sched/clock.h has been included at line 33,so 
remove the duplicate one at line 56 and move sched/cputime.h 
under sched including segament.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h | 1 -
 arch/powerpc/kernel/interrupt.c               | 1 -
 arch/powerpc/kernel/time.c                    | 3 +--
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index f911bdb68d8b..3004f3323144 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -18,7 +18,6 @@
  * complete pgtable.h but only a portion of it.
  */
 #include <asm/book3s/64/pgtable.h>
-#include <asm/bug.h>
 #include <asm/task_size_64.h>
 #include <asm/cpu_has_feature.h>
 
diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index c475a229a42a..11d456896772 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -7,7 +7,6 @@
 #include <asm/asm-prototypes.h>
 #include <asm/kup.h>
 #include <asm/cputime.h>
-#include <asm/interrupt.h>
 #include <asm/hw_irq.h>
 #include <asm/interrupt.h>
 #include <asm/kprobes.h>
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index b67d93a609a2..e2766e0e2a3a 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -31,6 +31,7 @@
 #include <linux/export.h>
 #include <linux/sched.h>
 #include <linux/sched/clock.h>
+#include <linux/sched/cputime.h>
 #include <linux/kernel.h>
 #include <linux/param.h>
 #include <linux/string.h>
@@ -52,8 +53,6 @@
 #include <linux/irq_work.h>
 #include <linux/of_clk.h>
 #include <linux/suspend.h>
-#include <linux/sched/cputime.h>
-#include <linux/sched/clock.h>
 #include <linux/processor.h>
 #include <asm/trace.h>
 
-- 
2.25.1

