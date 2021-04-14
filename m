Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C514F35F967
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 19:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349412AbhDNRFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 13:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbhDNRFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 13:05:42 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE90C061756
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 10:05:21 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id d10so14855896pgf.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 10:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T4H2tIHlg4jiFPhmlYYkil4iY0gGzyR7q5s5AjrTimc=;
        b=szfw5MV/r3Whuvi5fsVBRbf/O1Cgb6cYOnHwW+G7/PcwfQBl8CKi40Clz5NTkHZN0u
         OiD0z0t7b1ZqXVTL/FeErrhtBn7H2p5wequAn10LASZyM5pZH61F1IBjdZikI41keLNx
         FlUVTYERYxoFtMI6MCHsLjiyO5OiRnG2Sjmqjp8080qnSAqZ/uJ4rWEg4fUbR+LcZbVu
         Gf6RRMBZKqIuJ8AEZxdzMcLhpxqleyljqUmTmp/AlewlG+w2twlL5dVljv1wqvatQMS5
         C3H0YelDX0EmK19veQPcPu9AujmLKa+4OQ/aMijvTo/pvm5ElBSRMlT50vd72aTDfes+
         9Tiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T4H2tIHlg4jiFPhmlYYkil4iY0gGzyR7q5s5AjrTimc=;
        b=Io5XGSnWRN/t4DCQJ5k3IIX8mBwcpEm4yjevNAyOmQQkeakAOo1wqH2YF+5/EmGSdz
         KuZJlkEqIcVV+LxDR0IHbhc1Wml3Wk60vEny2GObuwKmUY4mOxu2B8g+DGgo/zQpCDls
         dWCAob/iucO2zcgfuMgJETLGb2yJ+tUklQdsAgKcqENDeuKWjRQrYuu4pnlRqiTvC28M
         9b/x4k4XtYBYco6pzR+UDexSsQfjCKE3zyWWsibENJzyCW01NACbSZPThBg8OHs6pDQs
         8JyTQlm9uWIwqWwN5diMVptwbuBZCaOeekPUF3wHzoxTO9h9HRd4G6tF2clbZ9NvJd15
         Gl/w==
X-Gm-Message-State: AOAM532cAgaM1QsDAGmzEGoqNDvr8hjvauQXZE2OVcwe3bdpzP7Q7NzB
        dDgy4XhYJVRjHpId9z3oe/o=
X-Google-Smtp-Source: ABdhPJzZQInoQgmXFAu1l7Z6JAowWTPpQvg1uZnN5F2fg+79fawKHa4tfOmIrGITv+/vbbapXw3dOA==
X-Received: by 2002:a62:2a83:0:b029:21a:d3a4:80f2 with SMTP id q125-20020a622a830000b029021ad3a480f2mr35450309pfq.47.1618419920704;
        Wed, 14 Apr 2021 10:05:20 -0700 (PDT)
Received: from edumazet1.svl.corp.google.com ([2620:15c:2c4:201:a476:17ee:13ea:2981])
        by smtp.gmail.com with ESMTPSA id i9sm18416pji.41.2021.04.14.10.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 10:05:20 -0700 (PDT)
From:   Eric Dumazet <eric.dumazet@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Subject: [PATCH] sh: remove unused variable
Date:   Wed, 14 Apr 2021 10:05:17 -0700
Message-Id: <20210414170517.1205430-1-eric.dumazet@gmail.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

Removes this annoying warning:

arch/sh/kernel/traps.c: In function ‘nmi_trap_handler’:
arch/sh/kernel/traps.c:183:15: warning: unused variable ‘cpu’ [-Wunused-variable]
  183 |  unsigned int cpu = smp_processor_id();

Fixes: fe3f1d5d7cd3 ("sh: Get rid of nmi_count()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
---
 arch/sh/kernel/traps.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/kernel/traps.c b/arch/sh/kernel/traps.c
index f5beecdac69382f2d719fa33d50b9d58e22f6ff8..e76b221570999776e3bc9276d6b2fd60b9132e94 100644
--- a/arch/sh/kernel/traps.c
+++ b/arch/sh/kernel/traps.c
@@ -180,7 +180,6 @@ static inline void arch_ftrace_nmi_exit(void) { }
 
 BUILD_TRAP_HANDLER(nmi)
 {
-	unsigned int cpu = smp_processor_id();
 	TRAP_HANDLER_DECL;
 
 	arch_ftrace_nmi_enter();
-- 
2.31.1.295.g9ea45b61b8-goog

