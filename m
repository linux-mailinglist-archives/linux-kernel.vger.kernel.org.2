Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B578042C0E8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 15:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbhJMNHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 09:07:08 -0400
Received: from smtp181.sjtu.edu.cn ([202.120.2.181]:46540 "EHLO
        smtp181.sjtu.edu.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbhJMNHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 09:07:07 -0400
Received: from proxy02.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
        by smtp181.sjtu.edu.cn (Postfix) with ESMTPS id D4CB21008CBC0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 21:05:01 +0800 (CST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by proxy02.sjtu.edu.cn (Postfix) with ESMTP id ADAF1200B574F;
        Wed, 13 Oct 2021 21:05:00 +0800 (CST)
X-Virus-Scanned: amavisd-new at 
Received: from proxy02.sjtu.edu.cn ([127.0.0.1])
        by localhost (proxy02.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ckdCJM8oQ-5q; Wed, 13 Oct 2021 21:04:59 +0800 (CST)
Received: from guozhi-ipads.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
        (Authenticated sender: qtxuning1999@sjtu.edu.cn)
        by proxy02.sjtu.edu.cn (Postfix) with ESMTPSA id 7CA72200B5750;
        Wed, 13 Oct 2021 21:04:56 +0800 (CST)
From:   Guo Zhi <qtxuning1999@sjtu.edu.cn>
Cc:     Guo Zhi <qtxuning1999@sjtu.edu.cn>, linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/kallsym.c: Fix kernel pointer leak
Date:   Wed, 13 Oct 2021 21:04:46 +0800
Message-Id: <20211013130446.237421-1-qtxuning1999@sjtu.edu.cn>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointers should be printed with %p rather than %px
which printed kernel pointer directly.
Change %px to %p to print the secured pointer.

Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>
---
 kernel/kallsyms.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 0ba87982d017..5a8ea50ce812 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -760,10 +760,10 @@ static int s_show(struct seq_file *m, void *p)
 		 */
 		type = iter->exported ? toupper(iter->type) :
 					tolower(iter->type);
-		seq_printf(m, "%px %c %s\t[%s]\n", value,
+		seq_printf(m, "%p %c %s\t[%s]\n", value,
 			   type, iter->name, iter->module_name);
 	} else
-		seq_printf(m, "%px %c %s\n", value,
+		seq_printf(m, "%p %c %s\n", value,
 			   iter->type, iter->name);
 	return 0;
 }
-- 
2.33.0

