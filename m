Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888B930B5C1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 04:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbhBBDSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 22:18:22 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:49330 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231356AbhBBDSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 22:18:18 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UNdkwIN_1612235852;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UNdkwIN_1612235852)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 02 Feb 2021 11:17:32 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     herbert@gondor.apana.org.au
Cc:     davem@davemloft.net, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, linux-crypto@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] crypto: powerpc: remove unneeded semicolon
Date:   Tue,  2 Feb 2021 11:17:30 +0800
Message-Id: <1612235850-87446-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the following coccicheck warning:
./arch/powerpc/crypto/sha256-spe-glue.c:132:2-3: Unneeded
semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/powerpc/crypto/sha256-spe-glue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/crypto/sha256-spe-glue.c b/arch/powerpc/crypto/sha256-spe-glue.c
index a6e650a..ffedea7 100644
--- a/arch/powerpc/crypto/sha256-spe-glue.c
+++ b/arch/powerpc/crypto/sha256-spe-glue.c
@@ -129,7 +129,7 @@ static int ppc_spe_sha256_update(struct shash_desc *desc, const u8 *data,
 
 		src += bytes;
 		len -= bytes;
-	};
+	}
 
 	memcpy((char *)sctx->buf, src, len);
 	return 0;
-- 
1.8.3.1

