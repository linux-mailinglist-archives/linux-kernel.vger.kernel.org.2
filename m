Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8363F792B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 17:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239284AbhHYPhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 11:37:15 -0400
Received: from m15114.mail.126.com ([220.181.15.114]:39474 "EHLO
        m15114.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbhHYPhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 11:37:10 -0400
X-Greylist: delayed 1821 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Aug 2021 11:37:09 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=gS1i5
        Oc3fp61Gg5IOivBK6NRVPqsZmhSEBxdgUV/2Pg=; b=U0PCG5gia7ZR3g9YLaM3O
        tekw5aZTwH4S5ZHj3Nmea/P0cFogiaZM95IPVDopEU7c79ZWse/NutgcLa/1iGHP
        MuHIQ46oVO/N5jpN3KH4ZYQXqdiFOdifFP8eAJwZOfmYK6ixvC35VoLcqdRPoCdi
        p1AY5FWqz0WA67MrJ1flLU=
Received: from localhost.localdomain (unknown [113.118.224.89])
        by smtp7 (Coremail) with SMTP id DsmowABXBNY+XCZh8GDlTw--.7865S2;
        Wed, 25 Aug 2021 23:05:36 +0800 (CST)
From:   Xujun Leng <lengxujun2007@126.com>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     lengxujun2007@126.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: mm: fix comment typo of pud_offset_phys()
Date:   Wed, 25 Aug 2021 23:05:26 +0800
Message-Id: <20210825150526.12582-1-lengxujun2007@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsmowABXBNY+XCZh8GDlTw--.7865S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKry8CryfurWkZFyDWry3Arb_yoWfJwc_Za
        12gw4kJ3y8trZ7XrW3J3ZxJr42gw1rX3yUZryfAws3XFykCr1UW3s7XF1xCr45uanrGrWk
        WFykGrW3Gw13AjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRi75r7UUUUU==
X-Originating-IP: [113.118.224.89]
X-CM-SenderInfo: pohqw5hxmx0jqqqxqiyswou0bp/1tbikgD5d1pEEBppaQAAsI
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a typo in the comment of macro pud_offset_phys().

Signed-off-by: Xujun Leng <lengxujun2007@126.com>
---
 arch/arm64/include/asm/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index f09bf5c02891..dfa76afa0ccf 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -715,7 +715,7 @@ static inline pud_t *p4d_pgtable(p4d_t p4d)
 	return (pud_t *)__va(p4d_page_paddr(p4d));
 }
 
-/* Find an entry in the frst-level page table. */
+/* Find an entry in the first-level page table. */
 #define pud_offset_phys(dir, addr)	(p4d_page_paddr(READ_ONCE(*(dir))) + pud_index(addr) * sizeof(pud_t))
 
 #define pud_set_fixmap(addr)		((pud_t *)set_fixmap_offset(FIX_PUD, addr))
-- 
2.25.1

