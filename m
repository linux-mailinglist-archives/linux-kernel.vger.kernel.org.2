Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1B332046B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 09:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbhBTIXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 03:23:25 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:39975 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229490AbhBTIXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 03:23:23 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UP0dKHK_1613809358;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UP0dKHK_1613809358)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 20 Feb 2021 16:22:38 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     hca@linux.ibm.com
Cc:     gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] KVM: s390: use ARRAY_SIZE instead of division operation
Date:   Sat, 20 Feb 2021 16:22:37 +0800
Message-Id: <1613809357-89354-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This eliminates the following coccicheck warning:
./arch/s390/tools/gen_facilities.c:154:37-38: WARNING: Use ARRAY_SIZE
./arch/s390/tools/gen_opcode_table.c:141:39-40: WARNING: Use ARRAY_SIZE

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/s390/tools/gen_facilities.c   | 2 +-
 arch/s390/tools/gen_opcode_table.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
index 61ce5b5..5366817 100644
--- a/arch/s390/tools/gen_facilities.c
+++ b/arch/s390/tools/gen_facilities.c
@@ -151,7 +151,7 @@ static void print_facility_lists(void)
 {
 	unsigned int i;
 
-	for (i = 0; i < sizeof(facility_defs) / sizeof(facility_defs[0]); i++)
+	for (i = 0; i < ARRAY_SIZE(facility_defs); i++)
 		print_facility_list(&facility_defs[i]);
 }
 
diff --git a/arch/s390/tools/gen_opcode_table.c b/arch/s390/tools/gen_opcode_table.c
index a1bc02b..468b70c 100644
--- a/arch/s390/tools/gen_opcode_table.c
+++ b/arch/s390/tools/gen_opcode_table.c
@@ -138,7 +138,7 @@ static struct insn_type *insn_format_to_type(char *format)
 	strcpy(tmp, format);
 	base_format = tmp;
 	base_format = strsep(&base_format, "_");
-	for (i = 0; i < sizeof(insn_type_table) / sizeof(insn_type_table[0]); i++) {
+	for (i = 0; i < ARRAY_SIZE(insn_type_table); i++) {
 		ptr = insn_type_table[i].format;
 		while (*ptr) {
 			if (!strcmp(base_format, *ptr))
-- 
1.8.3.1

