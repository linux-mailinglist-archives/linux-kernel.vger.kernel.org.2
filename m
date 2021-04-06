Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E84D355217
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 13:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245567AbhDFL2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 07:28:21 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16359 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245516AbhDFL1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 07:27:45 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FF4vQ1750z948m;
        Tue,  6 Apr 2021 19:25:22 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Tue, 6 Apr 2021 19:27:24 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH v2 02/10] tty/sysrq: Fix issues of code indent should use tabs
Date:   Tue, 6 Apr 2021 19:24:40 +0800
Message-ID: <1617708288-14847-3-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617708288-14847-1-git-send-email-tanxiaofei@huawei.com>
References: <1617708288-14847-1-git-send-email-tanxiaofei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix issues of code indent should use tabs, reported by checkpatch.pl.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/tty/sysrq.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 0372ed7..6628792 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -548,22 +548,22 @@ static int sysrq_key_table_key2index(int key)
  */
 static const struct sysrq_key_op *__sysrq_get_key_op(int key)
 {
-        const struct sysrq_key_op *op_p = NULL;
-        int i;
+	const struct sysrq_key_op *op_p = NULL;
+	int i;
 
 	i = sysrq_key_table_key2index(key);
 	if (i != -1)
-	        op_p = sysrq_key_table[i];
+		op_p = sysrq_key_table[i];
 
-        return op_p;
+	return op_p;
 }
 
 static void __sysrq_put_key_op(int key, const struct sysrq_key_op *op_p)
 {
-        int i = sysrq_key_table_key2index(key);
+	int i = sysrq_key_table_key2index(key);
 
-        if (i != -1)
-                sysrq_key_table[i] = op_p;
+	if (i != -1)
+		sysrq_key_table[i] = op_p;
 }
 
 void __handle_sysrq(int key, bool check_mask)
@@ -587,8 +587,8 @@ void __handle_sysrq(int key, bool check_mask)
 	orig_log_level = console_loglevel;
 	console_loglevel = CONSOLE_LOGLEVEL_DEFAULT;
 
-        op_p = __sysrq_get_key_op(key);
-        if (op_p) {
+	op_p = __sysrq_get_key_op(key);
+	if (op_p) {
 		/*
 		 * Should we check for enabled operations (/proc/sysrq-trigger
 		 * should not) and is the invoked operation enabled?
@@ -637,13 +637,13 @@ static int sysrq_reset_downtime_ms;
 
 /* Simple translation table for the SysRq keys */
 static const unsigned char sysrq_xlate[KEY_CNT] =
-        "\000\0331234567890-=\177\t"                    /* 0x00 - 0x0f */
-        "qwertyuiop[]\r\000as"                          /* 0x10 - 0x1f */
-        "dfghjkl;'`\000\\zxcv"                          /* 0x20 - 0x2f */
-        "bnm,./\000*\000 \000\201\202\203\204\205"      /* 0x30 - 0x3f */
-        "\206\207\210\211\212\000\000789-456+1"         /* 0x40 - 0x4f */
-        "230\177\000\000\213\214\000\000\000\000\000\000\000\000\000\000" /* 0x50 - 0x5f */
-        "\r\000/";                                      /* 0x60 - 0x6f */
+	"\000\0331234567890-=\177\t"                    /* 0x00 - 0x0f */
+	"qwertyuiop[]\r\000as"                          /* 0x10 - 0x1f */
+	"dfghjkl;'`\000\\zxcv"                          /* 0x20 - 0x2f */
+	"bnm,./\000*\000 \000\201\202\203\204\205"      /* 0x30 - 0x3f */
+	"\206\207\210\211\212\000\000789-456+1"         /* 0x40 - 0x4f */
+	"230\177\000\000\213\214\000\000\000\000\000\000\000\000\000\000" /* 0x50 - 0x5f */
+	"\r\000/";                                      /* 0x60 - 0x6f */
 
 struct sysrq_state {
 	struct input_handle handle;
@@ -1108,7 +1108,7 @@ int sysrq_toggle_support(int enable_mask)
 EXPORT_SYMBOL_GPL(sysrq_toggle_support);
 
 static int __sysrq_swap_key_ops(int key, const struct sysrq_key_op *insert_op_p,
-                                const struct sysrq_key_op *remove_op_p)
+				const struct sysrq_key_op *remove_op_p)
 {
 	int retval;
 
-- 
2.8.1

