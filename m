Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E10E320465
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 09:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhBTIPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 03:15:05 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:46802 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229803AbhBTIO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 03:14:58 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UP0452E_1613808854;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UP0452E_1613808854)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 20 Feb 2021 16:14:14 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] powerpc: use ARRAY_SIZE instead of division operation
Date:   Sat, 20 Feb 2021 16:14:13 +0800
Message-Id: <1613808853-78381-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This eliminates the following coccicheck warning:
./arch/powerpc/boot/mktree.c:130:31-32: WARNING: Use ARRAY_SIZE

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/powerpc/boot/mktree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/mktree.c b/arch/powerpc/boot/mktree.c
index dc603f3..0b2def5 100644
--- a/arch/powerpc/boot/mktree.c
+++ b/arch/powerpc/boot/mktree.c
@@ -127,7 +127,7 @@ int main(int argc, char *argv[])
 			exit(5);
 		}
 		cp = tmpbuf;
-		for (i = 0; i < sizeof(tmpbuf) / sizeof(unsigned int); i++)
+		for (i = 0; i < ARRAY_SIZE(tmpbuf); i++)
 			cksum += *cp++;
 		if (write(out_fd, tmpbuf, sizeof(tmpbuf)) != sizeof(tmpbuf)) {
 			perror("boot-image write");
-- 
1.8.3.1

