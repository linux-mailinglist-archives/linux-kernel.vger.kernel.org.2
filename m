Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665CA32BB66
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446270AbhCCMXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 07:23:49 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:13844 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378763AbhCCHMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 02:12:01 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Dr4qx4bHcz7rgP;
        Wed,  3 Mar 2021 15:09:33 +0800 (CST)
Received: from DESKTOP-E0KHRBE.china.huawei.com (10.67.103.82) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Wed, 3 Mar 2021 15:11:06 +0800
From:   ShaoBo Huang <huangshaobo6@huawei.com>
To:     <linux@armlinux.org.uk>, <tixy@linaro.org>, <mhiramat@kernel.org>,
        <huangshaobo6@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>
CC:     <young.liuyang@huawei.com>, <zengweilin@huawei.com>,
        <nixiaoming@huawei.com>, <chenzefeng2@huawei.com>,
        <liucheng32@huawei.com>, <kepler.chenxin@huawei.com>,
        <xiaoqian9@huawei.com>
Subject: [PATCH 4.9.y] arm: kprobes: Allow to handle reentered kprobe on single-stepping
Date:   Wed, 3 Mar 2021 15:10:52 +0800
Message-ID: <20210303071052.33740-1-huangshaobo6@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.103.82]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

commit f3fbd7ec62dec1528fb8044034e2885f2b257941 upstream

This is arm port of commit 6a5022a56ac3 ("kprobes/x86: Allow to
handle reentered kprobe on single-stepping")

Since the FIQ handlers can interrupt in the single stepping
(or preparing the single stepping, do_debug etc.), we should
consider a kprobe is hit in the NMI handler. Even in that
case, the kprobe is allowed to be reentered as same as the
kprobes hit in kprobe handlers
(KPROBE_HIT_ACTIVE or KPROBE_HIT_SSDONE).

The real issue will happen when a kprobe hit while another
reentered kprobe is processing (KPROBE_REENTER), because
we already consumed a saved-area for the previous kprobe.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Jon Medhurst <tixy@linaro.org>
Fixes: 24ba613c9d6c ("ARM kprobes: core code")
Cc: stable@vger.kernel.org #v2.6.25~v4.11
Signed-off-by: huangshaobo <huangshaobo6@huawei.com>
---
 arch/arm/probes/kprobes/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
index 3eb018fa1a1f..c3362ddd6c4c 100644
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -270,6 +270,7 @@ void __kprobes kprobe_handler(struct pt_regs *regs)
 			switch (kcb->kprobe_status) {
 			case KPROBE_HIT_ACTIVE:
 			case KPROBE_HIT_SSDONE:
+			case KPROBE_HIT_SS:
 				/* A pre- or post-handler probe got us here. */
 				kprobes_inc_nmissed_count(p);
 				save_previous_kprobe(kcb);
@@ -278,6 +279,11 @@ void __kprobes kprobe_handler(struct pt_regs *regs)
 				singlestep(p, regs, kcb);
 				restore_previous_kprobe(kcb);
 				break;
+			case KPROBE_REENTER:
+				/* A nested probe was hit in FIQ, it is a BUG */
+				pr_warn("Unrecoverable kprobe detected at %p.\n",
+					p->addr);
+				/* fall through */
 			default:
 				/* impossible cases */
 				BUG();
-- 
2.12.3

