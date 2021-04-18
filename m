Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7903637F6
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 23:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbhDRV7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 17:59:32 -0400
Received: from mail5.windriver.com ([192.103.53.11]:53728 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230258AbhDRV7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 17:59:30 -0400
X-Greylist: delayed 1477 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Apr 2021 17:59:30 EDT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com [147.11.82.252])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 13ILYLgF003225
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 14:34:21 -0700
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Sun, 18 Apr 2021 14:34:21 -0700
Received: from yow-cube1.wrs.com (128.224.56.98) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2242.4 via Frontend Transport; Sun, 18 Apr 2021 14:34:20 -0700
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] sched/isolation: don't do unbounded chomp on bootarg string
Date:   Sun, 18 Apr 2021 17:34:20 -0400
Message-ID: <20210418213420.1086500-1-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 3662daf023500dc084fa3b96f68a6f46179ddc73
("sched/isolation: Allow "isolcpus=" to skip unknown sub-parameters")
the isolcpus= string is walked to skip over what might be future flag
comma separated additions.

However, there is a logic error, and so as can clearly be seen below, it
will ignore its own arg len and search to the end of the bootarg string.

 $ dmesg|grep isol
 Command line: BOOT_IMAGE=/boot/bzImage isolcpus=xyz pleasedontparseme=1 root=/dev/sda1 ro
 Kernel command line: BOOT_IMAGE=/boot/bzImage isolcpus=xyz pleasedontparseme=1 root=/dev/sda1 ro
 isolcpus: Skipped unknown flag xyz
 isolcpus: Invalid flag pleasedontparseme=1 root=/dev/sda1 ro

This happens because the flag "skip" code does an unconditional
increment, which skips over the '\0' check the loop body looks for. If
the isolcpus= happens to be the last bootarg, then you'd never notice?

So we only increment if the skipped flag is followed by a comma, as per
what the existing "continue" flag matching code does.

Note that isolcpus= was declared deprecated as of v4.15 (b0d40d2b22fe),
so we might want to revisit that if we are trying to future-proof it
as recently as a year ago for as yet unseen new flags.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Fixes: 3662daf02350 ("sched/isolation: Allow "isolcpus=" to skip unknown sub-parameters")
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 5a6ea03f9882..9652dba7e938 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -188,7 +188,8 @@ static int __init housekeeping_isolcpus_setup(char *str)
 		}
 
 		pr_info("isolcpus: Skipped unknown flag %.*s\n", len, par);
-		str++;
+		if (str[1] == ',')	/* above continue; match on "flag," */
+			str++;
 	}
 
 	/* Default behaviour for isolcpus without flags */
-- 
2.25.1

