Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632D6401CBF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 16:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243058AbhIFOFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 10:05:54 -0400
Received: from smtpbg604.qq.com ([59.36.128.82]:60894 "EHLO smtpbg604.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242874AbhIFOFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 10:05:52 -0400
X-QQ-mid: bizesmtp50t1630936990tdgng7xo
Received: from localhost.localdomain (unknown [171.223.98.107])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 06 Sep 2021 22:03:09 +0800 (CST)
X-QQ-SSF: 01000000004000C0D000B00A0000000
X-QQ-FEAT: deLojOMtIBLqzXeiVb/ciH++gWyHZ9lr4/JL/zvWaofWU9uJKo3sVlzkMiUZQ
        oIvoVfAETnEfVNkwdGp4tFtKUQPLg9DfVmwB4P9KHI3JQalmdGl+wRIaq9/7s1F3iA3ZfNo
        kGySc40Vb0Ly/ET/UJElQ2CG4LokcvGg3HhoE3ygL8Mi9X66DOKwcj4p1Xl/jLspCaKzuGH
        6cPV69iztf+AEMTcBY0t+QJ6IF732eYGQi179DNTDa7NV3ZSOuOd0SZvPDW1Oqdo3ijiYqU
        kN5GQK51LTyApl4iJHDPIKhYsa2SAa/rst7x4dYPXyNGYjvKzD1Nfkib6GJMJzJ7KMBnfUL
        84OeI94d8TizzXC1Vq2tsTAt/J0xQ==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     linux@armlinux.org.uk
Cc:     linus.walleij@linaro.org, rmk+kernel@armlinux.org.uk,
        yanfei.xu@windriver.com, ardb@kernel.org, rppt@kernel.org,
        carver4lio@163.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] ARM: Fix typo in a comment
Date:   Mon,  6 Sep 2021 22:02:56 +0800
Message-Id: <20210906140256.113860-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/there there/there/

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/arm/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index a4e006005107..74a940f7b5f8 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1266,7 +1266,7 @@ static __init void prepare_page_table(void)
 	/*
 	 * Skip over the KASan shadow area. KASAN_SHADOW_END is sometimes
 	 * equal to MODULES_VADDR and then we exit the pmd clearing. If we
-	 * are using a thumb-compiled kernel, there there will be 8MB more
+	 * are using a thumb-compiled kernel, there will be 8MB more
 	 * to clear as KASan always offset to 16 MB below MODULES_VADDR.
 	 */
 	for (addr = KASAN_SHADOW_END; addr < MODULES_VADDR; addr += PMD_SIZE)
-- 
2.33.0

