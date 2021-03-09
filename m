Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B61A332276
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 11:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhCIJ7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 04:59:46 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:53478 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230033AbhCIJ7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 04:59:33 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UR6tfTj_1615283966;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UR6tfTj_1615283966)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 09 Mar 2021 17:59:31 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] x86/kaslr: Assign boolean values to a bool variable
Date:   Tue,  9 Mar 2021 17:59:23 +0800
Message-Id: <1615283963-67277-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:

./arch/x86/boot/compressed/kaslr.c:642:10-11: WARNING: return of 0/1 in
function 'process_mem_region' with return type bool.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 arch/x86/boot/compressed/kaslr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index b92fffb..e366907 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -639,9 +639,9 @@ static bool process_mem_region(struct mem_vector *region,
 
 		if (slot_area_index == MAX_SLOT_AREA) {
 			debug_putstr("Aborted e820/efi memmap scan (slot_areas full)!\n");
-			return 1;
+			return true;
 		}
-		return 0;
+		return false;
 	}
 
 #if defined(CONFIG_MEMORY_HOTREMOVE) && defined(CONFIG_ACPI)
-- 
1.8.3.1

