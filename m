Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24C13FFFAF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 14:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236060AbhICMXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 08:23:51 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:15383 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235264AbhICMXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 08:23:50 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H1Gzp6SJqzbh1N;
        Fri,  3 Sep 2021 20:18:46 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 3 Sep 2021 20:22:40 +0800
Received: from thunder-town.china.huawei.com (10.174.178.242) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 3 Sep 2021 20:22:39 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] arm64: entry: Improve the performance of system calls
Date:   Fri, 3 Sep 2021 20:19:50 +0800
Message-ID: <20210903121950.2284-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.242]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 582f95835a8f ("arm64: entry: convert el0_sync to C") converted lots
of functions from assembly to C, this greatly improves readability. But
el0_svc()/el0_svc_compat() is in response to system call requests from
user mode and may be in the hot path.

Although the SVC is in the first case of the switch statement in C, the
compiler optimizes the switch statement as a whole, and does not give SVC
a small boost.

Use "likely()" to help SVC directly invoke its handler after a simple
judgment to avoid entering the switch table lookup process.

After:
0000000000000ff0 <el0t_64_sync_handler>:
     ff0:       d503245f        bti     c
     ff4:       d503233f        paciasp
     ff8:       a9bf7bfd        stp     x29, x30, [sp, #-16]!
     ffc:       910003fd        mov     x29, sp
    1000:       d5385201        mrs     x1, esr_el1
    1004:       531a7c22        lsr     w2, w1, #26
    1008:       f100545f        cmp     x2, #0x15
    100c:       540000a1        b.ne    1020 <el0t_64_sync_handler+0x30>
    1010:       97fffe14        bl      860 <el0_svc>
    1014:       a8c17bfd        ldp     x29, x30, [sp], #16
    1018:       d50323bf        autiasp
    101c:       d65f03c0        ret
    1020:       f100705f        cmp     x2, #0x1c

Execute "./lat_syscall null" on my board (BogoMIPS : 200.00), it can save
about 10ns.

Before:
Simple syscall: 0.2365 microseconds
Simple syscall: 0.2354 microseconds
Simple syscall: 0.2339 microseconds

After:
Simple syscall: 0.2255 microseconds
Simple syscall: 0.2254 microseconds
Simple syscall: 0.2256 microseconds

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm64/kernel/entry-common.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 32f9796c4ffe77b..062eb5a895ec6f3 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -607,11 +607,14 @@ static void noinstr el0_fpac(struct pt_regs *regs, unsigned long esr)
 asmlinkage void noinstr el0t_64_sync_handler(struct pt_regs *regs)
 {
 	unsigned long esr = read_sysreg(esr_el1);
+	unsigned long ec = ESR_ELx_EC(esr);
 
-	switch (ESR_ELx_EC(esr)) {
-	case ESR_ELx_EC_SVC64:
+	if (likely(ec == ESR_ELx_EC_SVC64)) {
 		el0_svc(regs);
-		break;
+		return;
+	}
+
+	switch (ec) {
 	case ESR_ELx_EC_DABT_LOW:
 		el0_da(regs, esr);
 		break;
@@ -730,11 +733,14 @@ static void noinstr el0_svc_compat(struct pt_regs *regs)
 asmlinkage void noinstr el0t_32_sync_handler(struct pt_regs *regs)
 {
 	unsigned long esr = read_sysreg(esr_el1);
+	unsigned long ec = ESR_ELx_EC(esr);
 
-	switch (ESR_ELx_EC(esr)) {
-	case ESR_ELx_EC_SVC32:
+	if (likely(ec == ESR_ELx_EC_SVC32)) {
 		el0_svc_compat(regs);
-		break;
+		return;
+	}
+
+	switch (ec) {
 	case ESR_ELx_EC_DABT_LOW:
 		el0_da(regs, esr);
 		break;
-- 
2.25.1

