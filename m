Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB6F37F66B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 13:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbhEMLJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 07:09:07 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:47800 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232434AbhEMLIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 07:08:42 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UYkXXXR_1620904044;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UYkXXXR_1620904044)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 13 May 2021 19:07:30 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     chris@zankel.net
Cc:     jcmvbkbc@gmail.com, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] xtensa: Fix duplicate included linux/unaligned/generic.h
Date:   Thu, 13 May 2021 19:07:23 +0800
Message-Id: <1620904043-71858-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the following includecheck warning:

./arch/xtensa/include/asm/unaligned.h: linux/unaligned/generic.h is
included more than once.

No functional change.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 arch/xtensa/include/asm/unaligned.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/xtensa/include/asm/unaligned.h b/arch/xtensa/include/asm/unaligned.h
index 8e7ed04..c8838d9 100644
--- a/arch/xtensa/include/asm/unaligned.h
+++ b/arch/xtensa/include/asm/unaligned.h
@@ -15,15 +15,15 @@
 #ifdef __LITTLE_ENDIAN
 # include <linux/unaligned/le_struct.h>
 # include <linux/unaligned/be_byteshift.h>
-# include <linux/unaligned/generic.h>
 # define get_unaligned	__get_unaligned_le
 # define put_unaligned	__put_unaligned_le
 #else
 # include <linux/unaligned/be_struct.h>
 # include <linux/unaligned/le_byteshift.h>
-# include <linux/unaligned/generic.h>
 # define get_unaligned	__get_unaligned_be
 # define put_unaligned	__put_unaligned_be
 #endif
 
+# include <linux/unaligned/generic.h>
+
 #endif	/* _ASM_XTENSA_UNALIGNED_H */
-- 
1.8.3.1

