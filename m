Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A3743077A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 11:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241613AbhJQJZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 05:25:14 -0400
Received: from smtpbg604.qq.com ([59.36.128.82]:40715 "EHLO smtpbg604.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234497AbhJQJZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 05:25:12 -0400
X-QQ-mid: bizesmtp32t1634462564tui7xol3
Received: from localhost.localdomain (unknown [125.70.163.155])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sun, 17 Oct 2021 17:22:41 +0800 (CST)
X-QQ-SSF: 01000000008000B0C000B00A0000000
X-QQ-FEAT: T/61Y8rdSIt52eg7r8cqHyQeKX3p2zlCHbe6P13ackZUpEmCcQ46obSVBkpSh
        CzqUCSCvbqIdQHI46E/PBViyWJ8F8HPeukSRD66tq+YfbpXktUUM53/TZN+ZPXY2DPxMdbK
        mU8S6ckgQvYzhjWqsWstikCl9Wz8foxn9Z6JoC5lYO3dNYHw8JaidwybJMtaKmmWNPwpttD
        jbjkPgKo//u0gVhlJyvYnTLEarQg9EgPzD5Q8GIOReizZHGGDIL0KoRIoxfDF9tZFTT3eyK
        UNJWVaKdO+LDjNgzKoW1pFvW7gO8wnvWhYbrmrnnViop87IcktchHNV3TH8TKHvYdC4Q==
X-QQ-GoodBg: 0
From:   Huilong Deng <denghuilong@cdjrlc.com>
To:     hca@linux.ibm.com, borntraeger@de.ibm.com
Cc:     yury.norov@gmail.com, geert@linux-m68k.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Huilong Deng <denghuilong@cdjrlc.com>
Subject: [PATCH] s390/bitops: Return true/false (not 1/0) from bool functions
Date:   Sun, 17 Oct 2021 17:20:57 +0800
Message-Id: <20211017092057.24179-1-denghuilong@cdjrlc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Huilong Deng <denghuilong@cdjrlc.com>
---
 arch/s390/include/asm/bitops.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/bitops.h b/arch/s390/include/asm/bitops.h
index f7cefdde7c24..1d40630128a5 100644
--- a/arch/s390/include/asm/bitops.h
+++ b/arch/s390/include/asm/bitops.h
@@ -188,7 +188,7 @@ static inline bool arch_test_and_set_bit_lock(unsigned long nr,
 					      volatile unsigned long *ptr)
 {
 	if (arch_test_bit(nr, ptr))
-		return 1;
+		return true;
 	return arch_test_and_set_bit(nr, ptr);
 }
 
-- 
2.32.0

