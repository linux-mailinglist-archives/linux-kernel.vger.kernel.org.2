Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F89744BB7E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 06:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhKJF6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 00:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhKJF6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 00:58:53 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6FDC061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 21:56:06 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id y7so2224855plp.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 21:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c9xw6yStoEfjNF/k/c5MSuaBqDAKe3MzsJwqL/ZdYgc=;
        b=XlQVpXP5KFDNPVOZeglwkgCyknPZBl3oT7RZ1fVhOkxWg5a3gb+QtthfUsGOrkkxVj
         zRlNlZd7mCGzlmrZT+TulVMkBx/3iuHdvvWvfBHnlLk4EbZmgPH+oFgtBivGlpO981x2
         ytw7RyD8PAuzcfuKkG6t9zobJgBGh4e4PQVyE4pmAU+heGqcZhlDEr+gNPXssCEsbUow
         eZV8NzHXGrHpXruAS48J8qQRfhgISkQvZtR89q3cUrAjv3+xiQmkOYvtSqfEPAzMrLWn
         g9VTlS8d0u1NwobesDguiBSCrO9a66syJypi+UYDZQjgQ8sCVAu6lSIOSxjPQzSVb98B
         UUUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c9xw6yStoEfjNF/k/c5MSuaBqDAKe3MzsJwqL/ZdYgc=;
        b=R+oKqiiAs1ld2miWuzfxOnfyPC//dNjhw4H+L1AoIPgPsSvuNH1DAUe9aaKyJHhVvN
         XdZjaYr+Lu3NdvGgpuXrbfl950feqK44M8ya2zLJqQE0Gz2QJOf+o8nNJRFGek0StB8S
         joyVf+47I9YfKAkmmI0L7HwxEr84c80z2Tr1GBKA68hPDQHniYkSuL/X2bqmygZtJaxT
         8FYE5VFlfOb2RurdMLGM+K5mFS2kXonvEWzttr9xFOrkz+My+W7aey+uZ8vVgfuPX6pf
         jIVkfjSzF26Lj5fiYgIeDmeFAe6O/Lw4UmoX4HsmJBs/IyWQe3z5SWSGPFP6bQbjzq4r
         jnag==
X-Gm-Message-State: AOAM5333J923iXkRFa4LLBWStXe0XvY95s1iNx0pMQLlztiM3M+VACS2
        dLXOkzkUJsSoc4CLrgmfMgTyODh7W6I=
X-Google-Smtp-Source: ABdhPJz0c2CtPUQNTmZOFwIt15jaN5bVclSWRFjEanbxNjbhmANpafrdj1T9Z4DwTQZv0PvVl5TCQA==
X-Received: by 2002:a17:90b:4a83:: with SMTP id lp3mr14134601pjb.242.1636523766394;
        Tue, 09 Nov 2021 21:56:06 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id b1sm17504691pff.89.2021.11.09.21.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 21:56:06 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.guojin@zte.com.cn
To:     vgupta@kernel.org
Cc:     ye.guojin@zte.com.cn, yangdianqing@yulong.com, wjc@cdjrlc.com,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] ARC: dw2 unwind: use swap() to make code cleaner
Date:   Wed, 10 Nov 2021 05:56:02 +0000
Message-Id: <20211110055602.136926-1-ye.guojin@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Guojin <ye.guojin@zte.com.cn>

This was found by coccicheck:
./arch/arc/kernel/unwind.c, 251, 22-23, WARNING opportunity for swap()
./arch/arc/kernel/unwind.c, 254, 18-19, WARNING opportunity for swap()

Addtionally, adjust the sequence of header files to be arranged in
alphabetical order.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Ye Guojin <ye.guojin@zte.com.cn>
---
 arch/arc/kernel/unwind.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/arch/arc/kernel/unwind.c b/arch/arc/kernel/unwind.c
index 9e28058cdba8..ea795304982a 100644
--- a/arch/arc/kernel/unwind.c
+++ b/arch/arc/kernel/unwind.c
@@ -10,17 +10,18 @@
  * is not much point in implementing the full Dwarf2 unwind API.
  */
 
-#include <linux/sched.h>
-#include <linux/module.h>
+#include <asm/sections.h>
+#include <asm/unaligned.h>
+#include <asm/unwind.h>
 #include <linux/memblock.h>
-#include <linux/sort.h>
+#include <linux/minmax.h>
+#include <linux/module.h>
+#include <linux/ptrace.h>
+#include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/sort.h>
 #include <linux/stop_machine.h>
 #include <linux/uaccess.h>
-#include <linux/ptrace.h>
-#include <asm/sections.h>
-#include <asm/unaligned.h>
-#include <asm/unwind.h>
 
 extern char __start_unwind[], __end_unwind[];
 /* extern const u8 __start_unwind_hdr[], __end_unwind_hdr[];*/
@@ -245,14 +246,9 @@ static void swap_eh_frame_hdr_table_entries(void *p1, void *p2, int size)
 {
 	struct eh_frame_hdr_table_entry *e1 = p1;
 	struct eh_frame_hdr_table_entry *e2 = p2;
-	unsigned long v;
-
-	v = e1->start;
-	e1->start = e2->start;
-	e2->start = v;
-	v = e1->fde;
-	e1->fde = e2->fde;
-	e2->fde = v;
+
+	swap(e1->start, e2->start);
+	swap(e1->fde, e2->fde);
 }
 
 static void init_unwind_hdr(struct unwind_table *table,
-- 
2.25.1

