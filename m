Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01830443EC7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 09:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbhKCI70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 04:59:26 -0400
Received: from smtpbg128.qq.com ([106.55.201.39]:38377 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231979AbhKCI7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 04:59:18 -0400
X-QQ-mid: bizesmtp41t1635929693tbvakmm4
Received: from localhost.localdomain (unknown [125.70.163.9])
        by esmtp6.qq.com (ESMTP) with 
        id ; Wed, 03 Nov 2021 16:54:39 +0800 (CST)
X-QQ-SSF: 0100000000200050B000B00A0000000
X-QQ-FEAT: a4niRxydalHUoIDzp4wZcetK6yCNEivE+y+BoSP/43EZHsmGONz+CjZPv3JUQ
        bQ+YwuMQkPgdUEf1hJr+KoCDXy5tQMLZIJ4RN5maSpI+SCoWrv05M+PjfXVhVgTpIlxdKHt
        Rmd5dgh5VtOP6HQY+cl2GIJjh17WHyVFnmI+zZDfCT2+/aUENP0M5oUIGPlUbFgp22SHwQ7
        k+1rVUnYHmVZja3bEc9ZtPduP/ivyG9oJKwN7+x5fWLVWjLVCSoufPS5iauTrr6syn4B6kD
        UFB9ljae8ljmewDeE2AWNB7wnvFHqlGMSnZmGwZpUtz20cId9oQCb+319pYfsbIxF/3RCB7
        IMuZJSm5n7iDoUDrxvtOIWvRbDdYw==
X-QQ-GoodBg: 0
From:   Jingjing Liu <liujingjing@cdjrlc.com>
To:     linux@armlinux.org.uk
Cc:     ira.weiny@intel.com, akpm@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jingjing Liu <liujingjing@cdjrlc.com>
Subject: [PATCH] mm: change 0 to false in boolean function
Date:   Wed,  3 Nov 2021 16:54:32 +0800
Message-Id: <20211103085432.49305-1-liujingjing@cdjrlc.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

return of 0/1 in function 'security_extensions_enabled' with return type
bool

Signed-off-by: Jingjing Liu <liujingjing@cdjrlc.com>
---
 arch/arm/mm/nommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index 2658f52903da..7256ac159acb 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -56,7 +56,7 @@ static inline bool security_extensions_enabled(void)
 	if ((read_cpuid_id() & 0x000f0000) == 0x000f0000)
 		return cpuid_feature_extract(CPUID_EXT_PFR1, 4) ||
 			cpuid_feature_extract(CPUID_EXT_PFR1, 20);
-	return 0;
+	return false;
 }
 
 unsigned long setup_vectors_base(void)
-- 
2.33.1

