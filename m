Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56FA63DF024
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 16:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbhHCOVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 10:21:13 -0400
Received: from smtpbg128.qq.com ([106.55.201.39]:62996 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236448AbhHCOVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 10:21:11 -0400
X-QQ-mid: bizesmtp34t1628000425tnwr26nn
Received: from localhost.localdomain (unknown [125.69.40.136])
        by esmtp6.qq.com (ESMTP) with 
        id ; Tue, 03 Aug 2021 22:20:24 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000C00A0000000
X-QQ-FEAT: Ihi/kv336MhGpC490MUlfNCIANsaK7AjUzhmCiqESjV6QDDXNfdznTqZLQNBa
        JNb9SBltcgUJcZ2iBs2/4Cz0TOqMjZV8OMxztnjZGE+aMZwOJTGW04b+BO1soN3gPWQfrJp
        9ADIlCI1DNbA9/9idJUcj5ZHf7pRZ4rumIF290y2BmQP9jHng2IEdvztupIWh/tZ/ddhhLJ
        trq6H2nNoTMd/MyzNG61NvjWoGzl1nFtv2LJYoxvlH9lzTq+E0tNUH9PNqK5a4ym34ogggN
        695f9NX9pCYX+/tAmbccyYes9TxTKBXkt0JYDXd7NOWm3C8WlLMKtkz8wp2+xEqoVv2rkEX
        Oqr0tBZo6yIRn7X5u0=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     will@kernel.org
Cc:     catalin.marinas@arm.com, nathan@kernel.org,
        samitolvanen@google.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] arm64: fix typo in a comment
Date:   Tue,  3 Aug 2021 22:20:20 +0800
Message-Id: <20210803142020.124230-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double 'the' after 'If' in this comment "If the the TLB range ops
are supported..." is repeated. Consequently, one 'the' should be
removed from the comment.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/arm64/include/asm/tlbflush.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index cc3f5a33ff9c..118dabbda553 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -308,7 +308,7 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
 
 	/*
 	 * When the CPU does not support TLB range operations, flush the TLB
-	 * entries one by one at the granularity of 'stride'. If the the TLB
+	 * entries one by one at the granularity of 'stride'. If the TLB
 	 * range ops are supported, then:
 	 *
 	 * 1. If 'pages' is odd, flush the first page through non-range
-- 
2.32.0

