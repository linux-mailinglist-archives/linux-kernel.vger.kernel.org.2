Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3277833214A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 09:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbhCIIqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 03:46:45 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:26800 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231519AbhCIIqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 03:46:36 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UR4a9FV_1615279578;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UR4a9FV_1615279578)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 09 Mar 2021 16:46:23 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     jpoimboe@redhat.com
Cc:     peterz@infradead.org, nathan@kernel.org, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] objtool: Fix a memory leak bug
Date:   Tue,  9 Mar 2021 16:46:16 +0800
Message-Id: <1615279576-100603-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following cppcheck warnings:

tools/objtool/check.c(1102): error: Memory leak: orig_alt_group.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 tools/objtool/check.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 068cdb4..bfa7c31 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1099,6 +1099,7 @@ static int handle_group_alt(struct objtool_file *file,
 				     sizeof(struct cfi_state *));
 	if (!orig_alt_group->cfi) {
 		WARN("calloc failed");
+		free(orig_alt_group);
 		return -1;
 	}
 
-- 
1.8.3.1

