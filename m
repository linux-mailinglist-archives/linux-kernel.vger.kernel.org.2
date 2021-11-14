Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2328844F7B6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 12:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235884AbhKNMAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 07:00:19 -0500
Received: from smtpbg127.qq.com ([109.244.180.96]:42869 "EHLO smtpbg.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235171AbhKNMAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 07:00:03 -0500
X-QQ-mid: bizesmtp32t1636890979tkys33yj
Received: from localhost.localdomain (unknown [125.69.41.88])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sun, 14 Nov 2021 19:56:18 +0800 (CST)
X-QQ-SSF: 01000000002000C0F000B00A0000000
X-QQ-FEAT: pqOtrSRu7rhj+T4F55rzH6VfybqVBt8tt8daMQz9+Hpq1RJ0+Py0JX5El+rFn
        GIWCaeb+x8+Wc4n7bOgXAPVbZbtH59jkWSftn+CZVFIP0DYSWoOD2n3U+pH57K2B7s1WDms
        6fLshoSSlQCvUxwPmw7sfoLB30tR+r+D8ZD65FRmoIAkyY5Nwgar97OftRb9qRxTI0w/AUn
        H4+zYTUyauebGhsQU/n5hIvGR0r7HvrUhZScSQBwV+YhcErfcOeRUTfTZBtoKWRb2R9uLkH
        3uhwKNE9oBSwEoT0Mj0tp8owdTa3cOZMDoT2I4XJ/gQOkwr+yYRYAh7LEzuMuCOhDU5bUnK
        6lEPi0znQDaNg2s2BA6YidAxsqJ0tNa0ebxwA98
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org, andrew@lunn.ch,
        michael@walle.cc, wangborong@cdjrlc.com, davem@davemloft.net,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: tsi108: make EXPORT_SYMBOL follow its function immediately
Date:   Sun, 14 Nov 2021 19:56:16 +0800
Message-Id: <20211114115616.493815-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EXPORT_SYMBOL(foo); should immediately follow its function/variable.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/powerpc/sysdev/tsi108_dev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/tsi108_dev.c b/arch/powerpc/sysdev/tsi108_dev.c
index 4c4a6efd5e5f..9e13fb35ed5c 100644
--- a/arch/powerpc/sysdev/tsi108_dev.c
+++ b/arch/powerpc/sysdev/tsi108_dev.c
@@ -51,13 +51,12 @@ phys_addr_t get_csrbase(void)
 	}
 	return tsi108_csr_base;
 }
+EXPORT_SYMBOL(get_csrbase);
 
 u32 get_vir_csrbase(void)
 {
 	return (u32) (ioremap(get_csrbase(), 0x10000));
 }
-
-EXPORT_SYMBOL(get_csrbase);
 EXPORT_SYMBOL(get_vir_csrbase);
 
 static int __init tsi108_eth_of_init(void)
-- 
2.33.0


