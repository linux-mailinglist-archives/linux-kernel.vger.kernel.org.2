Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48FD03DD2F1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 11:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbhHBJ26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 05:28:58 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:65136 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232699AbhHBJ25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 05:28:57 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
        by Forcepoint Email with ESMTPS id CFEBA59B1816667B0274;
        Mon,  2 Aug 2021 17:28:46 +0800 (CST)
Received: from zte.com.cn ([10.30.12.200])
        by mse-fl1.zte.com.cn with SMTP id 1729RBhG074249;
        Mon, 2 Aug 2021 17:27:39 +0800 (GMT-8)
        (envelope-from yang.yang29@zte.com.cn)
Date:   Mon, 2 Aug 2021 17:25:30 +0800 (CST)
X-Zmail-TransId: 2b0360f94f56dff0dc4f
X-Mailer: Zmail v1.0
Message-ID: <202107221858308514719@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <rth@twiddle.net>, <ink@jurassic.park.msu.ru>, <mattst88@gmail.com>
Cc:     <linux-alpha@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBhbHBoYTogcmVtb3ZlIHVubmVlZGVkIHZhcmlhYmxl?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 1729RBhG074249
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Yunkai <zhang.yunkai@zte.com.cn>

This is a warning in coccicheck. Unneeded variable "status".

Reported-by: Zeal Robot <zealci@zte.com.cn> 
Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
---
 arch/alpha/kernel/err_titan.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/alpha/kernel/err_titan.c b/arch/alpha/kernel/err_titan.c
index 0ffb2feea42a..85d91da86ec4 100644
--- a/arch/alpha/kernel/err_titan.c
+++ b/arch/alpha/kernel/err_titan.c
@@ -589,7 +589,6 @@ titan_register_error_handlers(void)
 static int
 privateer_process_680_frame(struct el_common *mchk_header, int print)
 {
-    int status = MCHK_DISPOSITION_UNKNOWN_ERROR;
 #ifdef CONFIG_VERBOSE_MCHECK
     struct el_PRIVATEER_envdata_mcheck *emchk =
         (struct el_PRIVATEER_envdata_mcheck *)
@@ -598,7 +597,7 @@ privateer_process_680_frame(struct el_common *mchk_header, int print)
     /* TODO - categorize errors, for now, no error */
 
     if (!print)
-        return status;
+        return MCHK_DISPOSITION_UNKNOWN_ERROR;
 
     /* TODO - decode instead of just dumping... */
     printk("%s  Summary Flags:         %016llx\n"
@@ -624,7 +623,7 @@ privateer_process_680_frame(struct el_common *mchk_header, int print)
            emchk->code);
 #endif /* CONFIG_VERBOSE_MCHECK */
 
-    return status;
+    return MCHK_DISPOSITION_UNKNOWN_ERROR;
 }
 
 int
-- 
2.25.1

