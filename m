Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21DBB33ADEB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 09:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbhCOIva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 04:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhCOIu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 04:50:59 -0400
Received: from smtp.gentoo.org (dev.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DB5C061574;
        Mon, 15 Mar 2021 01:50:59 -0700 (PDT)
Received: by sf.home (Postfix, from userid 1000)
        id 53E365A22061; Mon, 15 Mar 2021 08:50:51 +0000 (GMT)
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Sergei Trofimovich <slyfox@gentoo.org>, linux-ia64@vger.kernel.org
Subject: [PATCH] ia64: mca: allocate early mca with GFP_ATOMIC
Date:   Mon, 15 Mar 2021 08:50:45 +0000
Message-Id: <20210315085045.204414-1-slyfox@gentoo.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sleep warning happens at early boot right at
secondary CPU activation bootup:

    smp: Bringing up secondary CPUs ...
    BUG: sleeping function called from invalid context at mm/page_alloc.c:4942
    in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/1
    CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.12.0-rc2-00007-g79e228d0b611-dirty #99

    Call Trace:
     [<a000000100014d10>] show_stack+0x90/0xc0
     [<a000000101111d90>] dump_stack+0x150/0x1c0
     [<a0000001000cbec0>] ___might_sleep+0x1c0/0x2a0
     [<a0000001000cc040>] __might_sleep+0xa0/0x160
     [<a000000100399960>] __alloc_pages_nodemask+0x1a0/0x600
     [<a0000001003b71b0>] alloc_page_interleave+0x30/0x1c0
     [<a0000001003b9b60>] alloc_pages_current+0x2c0/0x340
     [<a00000010038c270>] __get_free_pages+0x30/0xa0
     [<a000000100044730>] ia64_mca_cpu_init+0x2d0/0x3a0
     [<a000000100023430>] cpu_init+0x8b0/0x1440
     [<a000000100054680>] start_secondary+0x60/0x700
     [<a00000010111e1d0>] start_ap+0x750/0x780
    Fixed BSP b0 value from CPU 1

As I understand interrupts are not enabled yet and system has a lot
of memory. There is little chance to sleep and switch to GFP_ATOMIC
should be a no-op.

CC: Andrew Morton <akpm@linux-foundation.org>
CC: linux-ia64@vger.kernel.org
Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
---
 arch/ia64/kernel/mca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/ia64/kernel/mca.c b/arch/ia64/kernel/mca.c
index d4cae2fc69ca..adf6521525f4 100644
--- a/arch/ia64/kernel/mca.c
+++ b/arch/ia64/kernel/mca.c
@@ -1824,7 +1824,7 @@ ia64_mca_cpu_init(void *cpu_data)
 			data = mca_bootmem();
 			first_time = 0;
 		} else
-			data = (void *)__get_free_pages(GFP_KERNEL,
+			data = (void *)__get_free_pages(GFP_ATOMIC,
 							get_order(sz));
 		if (!data)
 			panic("Could not allocate MCA memory for cpu %d\n",
-- 
2.30.2

