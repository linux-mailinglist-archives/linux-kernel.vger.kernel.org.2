Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C810B3CBC2F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 21:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbhGPTHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 15:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhGPTHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 15:07:16 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C09C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 12:04:21 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id ca14so14333339edb.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 12:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bpaqLCRQET6T5TaDY9leI0r/qDkKuxDrrF5WeGz1Z9o=;
        b=QXY+Bw6t5DZMoK1csqZid3PuvujLfunkWvjLOF3qt1vRHfepxhrXW9zNMtFLOwT1zq
         ZOrEaSHzzEgSJUrrTVoXtfun4kF8ZBcZGTWv4pCLE1FXU1oyA5uwcBpTaB9bnGs8dUN3
         8gw+oxU/wtgZ3R7dklcNQNQt7Jprpn4J0twZv4XOSZ3q+zmGuzqJ2fhZA1m4tNrJp5Xt
         usv08AcyYl21v+UnSs5amvbtWXwZT1zkx/D866dQFtFlZG4XMb1lIwGXxj7iz9bZ7jTp
         pLHTD4hNJV/75n2XL5EMLOz2KAMw9xm3HJyKAz+nUC1wVb0vGR2LGWrkQkW7Ac/Q5lzb
         O3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bpaqLCRQET6T5TaDY9leI0r/qDkKuxDrrF5WeGz1Z9o=;
        b=gDNssWJ3ROj6daEAERwuiTCgpWiX7G0FYSM+Vel3xApKlAnbDWP8TBsu2owJ9Qbnrg
         tH+2JTG1wliW58JiQJgexhRWShwbBInUt5Sn80VlYvpy6E7y33VQ2RvlVretU3QmtFSE
         o9cCuDUy1jZLn2kXzXEPiibwWqYKD//tQ3t0f6lYyHRsJN0swLsCDMIFyixFibsfeyEy
         pD8ApmzJYUaPfJa0wayfms7pJO2B8h6S5uJv22CQs/OTlS/Q78A1Tw688ymSCUOBI3hJ
         ZrKJQRBOgNYiuBabPbwLE8pbGfUtmOchGg1P54IrXQggNuiu76yaAL9RnEDT5TjasP7H
         wqhg==
X-Gm-Message-State: AOAM531tUYukb4wY/iHeHelCAcGYtzxKJuUNT8UJkSeExVgkrCCjai/R
        uXVywoIOOBfgckojNIF49Exo6/5YVZ+Ti8LM
X-Google-Smtp-Source: ABdhPJyikCQHbaJv1sPwobipeDE27ztO2hCB2Z8eYRpuVuiUg+Si15roohee1fY1nbnZK7cid7yRIA==
X-Received: by 2002:aa7:cb9a:: with SMTP id r26mr16887001edt.78.1626462259601;
        Fri, 16 Jul 2021 12:04:19 -0700 (PDT)
Received: from localhost.localdomain ([5.176.51.215])
        by smtp.gmail.com with ESMTPSA id n16sm3173617ejc.121.2021.07.16.12.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 12:04:19 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     penguin-kernel@I-love.SAKURA.ne.jp, rostedt@goodmis.org,
        tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        syzbot+e68c89a9510c159d9684@syzkaller.appspotmail.com,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: [PATCH] profiling: fix shift-out-of-bounds in profile_setup
Date:   Fri, 16 Jul 2021 22:04:09 +0300
Message-Id: <20210716190409.25523-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzbot reported shift-out-of-bounds bug in profile_init().
The problem was in incorrect prof_shift. Since prof_shift value comes from
userspace we need to check this value to avoid too big shift.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-and-tested-by: syzbot+e68c89a9510c159d9684@syzkaller.appspotmail.com
Suggested-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 kernel/profile.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/profile.c b/kernel/profile.c
index c2ebddb5e974..c905931e3c3b 100644
--- a/kernel/profile.c
+++ b/kernel/profile.c
@@ -42,6 +42,7 @@ struct profile_hit {
 
 static atomic_t *prof_buffer;
 static unsigned long prof_len, prof_shift;
+#define MAX_PROF_SHIFT		(sizeof(prof_shift) * 8)
 
 int prof_on __read_mostly;
 EXPORT_SYMBOL_GPL(prof_on);
@@ -67,7 +68,7 @@ int profile_setup(char *str)
 		if (str[strlen(sleepstr)] == ',')
 			str += strlen(sleepstr) + 1;
 		if (get_option(&str, &par))
-			prof_shift = par;
+			prof_shift = clamp(par, 0, (int) MAX_PROF_SHIFT - 1);
 		pr_info("kernel sleep profiling enabled (shift: %ld)\n",
 			prof_shift);
 #else
@@ -78,7 +79,7 @@ int profile_setup(char *str)
 		if (str[strlen(schedstr)] == ',')
 			str += strlen(schedstr) + 1;
 		if (get_option(&str, &par))
-			prof_shift = par;
+			prof_shift = clamp(par, 0, (int) MAX_PROF_SHIFT - 1);
 		pr_info("kernel schedule profiling enabled (shift: %ld)\n",
 			prof_shift);
 	} else if (!strncmp(str, kvmstr, strlen(kvmstr))) {
@@ -86,11 +87,11 @@ int profile_setup(char *str)
 		if (str[strlen(kvmstr)] == ',')
 			str += strlen(kvmstr) + 1;
 		if (get_option(&str, &par))
-			prof_shift = par;
+			prof_shift = clamp(par, 0, (int) MAX_PROF_SHIFT - 1);
 		pr_info("kernel KVM profiling enabled (shift: %ld)\n",
 			prof_shift);
 	} else if (get_option(&str, &par)) {
-		prof_shift = par;
+		prof_shift = clamp(par, 0, (int) MAX_PROF_SHIFT - 1);
 		prof_on = CPU_PROFILING;
 		pr_info("kernel profiling enabled (shift: %ld)\n",
 			prof_shift);
-- 
2.32.0

