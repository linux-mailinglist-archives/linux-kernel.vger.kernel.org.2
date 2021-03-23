Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11F23455ED
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 04:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhCWDFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 23:05:22 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:35010 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhCWDFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 23:05:08 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id 0B6D398057D;
        Tue, 23 Mar 2021 11:05:05 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] arch: powerpc: Remove duplicate include of clock.h
Date:   Tue, 23 Mar 2021 11:04:54 +0800
Message-Id: <20210323030458.241602-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSB5MTkNKQh5JTEgZVkpNSk1PTUNMS05ITEtVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0JITlVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OSo6PSo*GD8OPDpOLEovHjYw
        NgowFB5VSlVKTUpNT01DTEtNSUxNVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFJT05LNwY+
X-HM-Tid: 0a785d0b0013d992kuws0b6d398057d
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linux/sched/clock.h has been included at line 33.
So we remove the duplicate one at line 56. For better 
understanding, we also move sched/cputime.h under the 
sched including segment.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 arch/powerpc/kernel/time.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

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

