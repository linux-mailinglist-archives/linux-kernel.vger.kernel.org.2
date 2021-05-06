Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC00375225
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 12:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbhEFKTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 06:19:37 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:50885 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234210AbhEFKTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 06:19:24 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UXyJDp1_1620296302;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UXyJDp1_1620296302)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 06 May 2021 18:18:23 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     nathan@kernel.org
Cc:     ndesaulniers@google.com, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] lib/asn1_encoder: Remove redundant assignment to ret
Date:   Thu,  6 May 2021 18:18:19 +0800
Message-Id: <1620296299-125105-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable 'ret' is set to zero but this value is never read as it is
overwritten with a new value later on, hence it is a redundant
assignment and can be removed.

Clean up the following clang-analyzer warning:

lib/asn1_encoder.c:167:2: warning: Value stored to 'ret' is never read
[clang-analyzer-deadcode.DeadStores]

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 lib/asn1_encoder.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/asn1_encoder.c b/lib/asn1_encoder.c
index 41e71aa..0d287ea 100644
--- a/lib/asn1_encoder.c
+++ b/lib/asn1_encoder.c
@@ -164,8 +164,6 @@ static int asn1_encode_oid_digit(unsigned char **_data, int *data_len, u32 oid)
 
 	data_len -= 3;
 
-	ret = 0;
-
 	for (i = 2; i < oid_len; i++) {
 		ret = asn1_encode_oid_digit(&d, &data_len, oid[i]);
 		if (ret < 0)
-- 
1.8.3.1

