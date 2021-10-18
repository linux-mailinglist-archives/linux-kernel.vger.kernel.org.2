Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35A7430FB7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 07:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhJRFZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 01:25:07 -0400
Received: from smtpbguseast3.qq.com ([54.243.244.52]:52403 "EHLO
        smtpbguseast3.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhJRFZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 01:25:06 -0400
X-QQ-mid: bizesmtp33t1634534565twpnz1q1
Received: from pcl66.. (unknown [218.17.115.194])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 18 Oct 2021 13:22:39 +0800 (CST)
X-QQ-SSF: 01400000002000F0O000000B0000000
X-QQ-FEAT: sAyD0HLl0PAPF9h2XXao3xBCuwKIX1GvyL9/k10otrZOpvTx2dLnas1dTvxks
        AcbIRiF+Nwn4z4tU9GRsmFEbA0VyRqZzJZYXHPGLhvclumq0XNEDIxCZmNJV2yelYObLymb
        zzHmmpuZRU9okNwO4uUy1ZCpH3Y5lBAYjoNkRcUy8ZGeW4PhhnZHn33NZfiGVRT44Rnamj2
        +wLyV0mHD5AylhTMIKMAPoh/OwKUgD6pVHJ1lvf1z71Bhyul0Qk2I248psCInFC+SMQtP2v
        8y086yFfAQ5mKLdzl341uNliAZrSzTM0KxC2a8loHFu9v5RVbYHPeMsDWm3swdaAU7kck8v
        iEjizGLo4fK0ruS9mOKcrXmRG2DrKwTCqdDkba+
X-QQ-GoodBg: 1
From:   Chen Lu <181250012@smail.nju.edu.cn>
To:     palmer@dabbelt.com
Cc:     paul.walmsley@sifive.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
        vitaly.wool@konsulko.com, anup@brainfault.org, seanga2@gmail.com,
        wangkefeng.wang@huawei.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, yuzihao@ict.ac.cn,
        Chen Lu <181250012@smail.nju.edu.cn>
Subject: [PATCH] riscv: fix misalgned trap vector base address
Date:   Mon, 18 Oct 2021 13:22:38 +0800
Message-Id: <20211018052238.522905-1-181250012@smail.nju.edu.cn>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:smail.nju.edu.cn:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* The trap vector marked by label .Lsecondary_park should align on a
  4-byte boundary. If not, CSR_TVEC may be set to an incorrect address.
* This bug is introduced at commit e011995e826f8 ("RISC-V: Move relocate
  and few other functions out of __init").
* This bug is exposed with an educational emualtor.

Signed-off-by: Chen Lu <181250012@smail.nju.edu.cn>
---
 arch/riscv/kernel/head.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index fce5184b22c3..52c5ff9804c5 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -193,6 +193,7 @@ setup_trap_vector:
 	csrw CSR_SCRATCH, zero
 	ret
 
+.align 2
 .Lsecondary_park:
 	/* We lack SMP support or have too many harts, so park this hart */
 	wfi
-- 
2.30.2



