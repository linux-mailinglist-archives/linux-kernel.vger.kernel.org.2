Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863B830B618
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 04:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbhBBDxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 22:53:14 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:47051 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231532AbhBBDxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 22:53:12 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UNe7CRv_1612237884;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UNe7CRv_1612237884)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 02 Feb 2021 11:51:24 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] powerpc/book3s64: remove unneeded semicolon
Date:   Tue,  2 Feb 2021 11:51:22 +0800
Message-Id: <1612237882-122475-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the following coccicheck warning:
./arch/powerpc/platforms/pseries/lpar.c:1632:2-3: Unneeded semicolon
./arch/powerpc/platforms/pseries/lpar.c:1663:2-3: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/powerpc/platforms/pseries/lpar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 764170f..24889b8 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -1629,7 +1629,7 @@ static int pseries_lpar_resize_hpt(unsigned long shift)
 		}
 		msleep(delay);
 		rc = plpar_resize_hpt_prepare(0, shift);
-	};
+	}
 
 	switch (rc) {
 	case H_SUCCESS:
@@ -1663,7 +1663,7 @@ static int pseries_lpar_resize_hpt(unsigned long shift)
 			pr_warn("Unexpected error %d from H_RESIZE_HPT_COMMIT\n",
 				state.commit_rc);
 			return -EIO;
-		};
+		}
 	}
 
 	pr_info("HPT resize to shift %lu complete (%lld ms / %lld ms)\n",
-- 
1.8.3.1

