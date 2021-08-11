Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7FFE3E8BAB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 10:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbhHKIWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 04:22:15 -0400
Received: from smtpbg604.qq.com ([59.36.128.82]:33346 "EHLO smtpbg604.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229679AbhHKIWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 04:22:14 -0400
X-QQ-mid: bizesmtp50t1628670066t6rfpyvv
Received: from localhost.localdomain (unknown [182.148.13.10])
        by esmtp6.qq.com (ESMTP) with 
        id ; Wed, 11 Aug 2021 16:21:03 +0800 (CST)
X-QQ-SSF: 0100000000200070B000B00A0000000
X-QQ-FEAT: q17Yoz/cMVq2gH0+F2rCxzWGJoeQtCYxUimkufFsISons3IuGxfHtb3EnEbtc
        en1SLSR28CRwPsw6Rp4gDri2yVhcB5V+Sxn5YiUGeJMgU+DiVQIzH7E01XIRSfNhLZ7zEZn
        rMWPBbcN9LcwCJKWxmnHyiXgmE3TvHvfONKIulxNBogPuU8WXIXmxaqasyif+CTcnlDoRRi
        Nxg9ipnEUPfiZHlxyPjaHjr5ALESGY9xhtrjXNZbgAkBS+MShj8OFLqwqSxy3x0Z5EFz1Es
        P40K+PRI4fpKf5aLX7IPydGfsvM1quDQVNaXGbgC5SvIk+K+KsiXPDsqW++mxe7h41gw==
X-QQ-GoodBg: 0
From:   Huilong Deng <denghuilong@cdjrlc.com>
To:     linux@armlinux.org.uk, ira.weiny@intel.com, sfr@canb.auug.org.au,
        akpm@linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Huilong Deng <denghuilong@cdjrlc.com>
Subject: [PATCH] ARM: NOMMU: Return true/false (not 1/0) from bool functions
Date:   Wed, 11 Aug 2021 16:20:41 +0800
Message-Id: <20210811082041.32309-1-denghuilong@cdjrlc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

./arch/arm/mm/nommu.c:59:8-9: WARNING: return of 0/1 in function
'security_extensions_enabled' with return type bool

Signed-off-by: Huilong Deng <denghuilong@cdjrlc.com>
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
2.32.0

