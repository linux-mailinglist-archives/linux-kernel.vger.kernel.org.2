Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742F03D5A12
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 15:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbhGZM2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 08:28:50 -0400
Received: from smtpbg604.qq.com ([59.36.128.82]:39803 "EHLO smtpbg604.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233451AbhGZM2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 08:28:47 -0400
X-QQ-mid: bizesmtp50t1627304912td4fiflc
Received: from ficus.lan (unknown [171.223.99.141])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 26 Jul 2021 21:08:31 +0800 (CST)
X-QQ-SSF: 0100000000200090B000B00A0000000
X-QQ-FEAT: xmzaef4TE3cVRb65WjfMQVhCwJomBGy4tSSxu6xpzOizAslHiaolJZzC7pMIq
        Sp/04xAaWOccIP+F4sWJFIhMcsgzqXebPiS9j0ZE+GBG4SHUZoOZ2FOih9Vx4+9TW79AeE0
        YejL5fKsXCNbnvlKZJERr1BujW2M4Tf6ZN7Iu8STdiPohyE0Wl/iXdNXSre7Y6F82x5AKHE
        gcGO9lTbxjrNoS1ccTZWwYBunDpwpfSRuktdsxQKCQRcUtPmgCi+fCb2LSnT4BcLqSF0sgw
        beVv1C5gSXxVKUe1O7Tw4iQ2x04G+IA6j1pEOd0lfePSfkq1534qD+lFiljEQCJGmLCicWt
        Ks5sms7bMaRn5vPz5SBeSbvagejvA==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     luto@kernel.org
Cc:     dave.hansen@linux.intel.com, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] x86/mm: use WARN_ONCE
Date:   Mon, 26 Jul 2021 21:08:29 +0800
Message-Id: <20210726130829.93874-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

printk + WARN_ON_ONCE can be just WARN_ONCE.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/x86/mm/ioremap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 60ade7dd71bd..3e57035ef9e3 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -195,9 +195,8 @@ __ioremap_caller(resource_size_t phys_addr, unsigned long size,
 		return NULL;
 
 	if (!phys_addr_valid(phys_addr)) {
-		printk(KERN_WARNING "ioremap: invalid physical address %llx\n",
-		       (unsigned long long)phys_addr);
-		WARN_ON_ONCE(1);
+		WARN_ONCE(1, "ioremap: invalid physical address %llx\n",
+			  (unsigned long long)phys_addr);
 		return NULL;
 	}
 
-- 
2.32.0

