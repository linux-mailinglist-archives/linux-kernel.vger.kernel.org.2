Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E676A39F354
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 12:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhFHKVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 06:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhFHKU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 06:20:59 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B675C061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 03:18:50 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id g4so2158248pjk.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 03:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KO1iSzE7R4d/DOTwHJLAwqhlQM2APRHKlgvxS8AEsZI=;
        b=sdRCPsqRQCSWYY2dnC8qVFmNYGj59GVqZKtkMSZ5E6R2Ne/83KLFsgLkxEPTugYTDv
         wCwLs+dfDHVRWiulby6YoaQ4sjGvvMGI6BGQKKSRwusEGIKUExVSNA1VaE2hLmEUYcqn
         IBOq6EO6xOIBgz8Z1FrmuRVPUBrUvXQdsSn+ygzBe1vVR98QzESf3QqBw7/4L8w593zk
         FSGBs8NKiG3rFmEHUHtdlzZRAjJLV9/7l4ADzkyFk+VQdjBOBy/bwUNEgnIj1sqgeQBt
         vzQzz0QxX5Fs5grZzp+NgQ3Bn5rggEdX1sTPOYbYpZpehr2JmQAA3lZ7l/X6pQIGyeyk
         Vj9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KO1iSzE7R4d/DOTwHJLAwqhlQM2APRHKlgvxS8AEsZI=;
        b=WnYW8bdaX0C2tslnj2romSlVUtLm30Pip+tywFwFvN0BKrDE5NEjHoMAP6DxjCXVwK
         2CJYS0TOs98mK1hlz3z34vP8pH0TDJcxjel1UjPn7rAVped5GVrxbTWD2weCyaKUqkWe
         URtHiPGJNZsgkvu5tRf3wE5/AD87KauD3D9b4Jg22mJF7Rjfl/hxaHFMPicyZWp8hyWA
         NTxOUFDx/xX1OWIDwVgHIfvURodlY8P2PxcE5CLYfefy1LCdtO75u8Zitc/4NMd45XYs
         Fyf2hhAW2GKQ0ySJRLygOtJYsFqvjMv8Fwm2KymnzLZgl53lrH2BssG3hVRCqAfo+IJj
         jpnA==
X-Gm-Message-State: AOAM530K8H/z3cmePIMMQYlOkeO2i7kPNK9ypv+jY45WYeijXc3iPBtF
        xhQ4CKVziqo4o01TmYucESQjVOlZuBcy7iS3
X-Google-Smtp-Source: ABdhPJxV+Gt/poG4fVsNN3UFU6kVuuWGCsqjm22J2k1qtVW9VAer7o/+F6kfzzz4A5JwOa7HuEsmPQ==
X-Received: by 2002:a17:90a:1b6b:: with SMTP id q98mr4202025pjq.53.1623147528225;
        Tue, 08 Jun 2021 03:18:48 -0700 (PDT)
Received: from sz-dl-056.autox.sz ([185.241.43.163])
        by smtp.gmail.com with ESMTPSA id r2sm2604767pfq.87.2021.06.08.03.18.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jun 2021 03:18:47 -0700 (PDT)
From:   Yejune Deng <yejune.deng@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yejune Deng <yejune.deng@gmail.com>
Subject: [PATCH] sched/fair: use inclusive language in fair sched
Date:   Tue,  8 Jun 2021 18:18:29 +0800
Message-Id: <1623147509-31073-1-git-send-email-yejune.deng@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces some non-inclusive terms based on the proposal
that accepted by Linus.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=49decddd39e5f6132ccd7d9fdc3d7c470b0061bb

Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
---
 kernel/sched/fair.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5d0d113..af438d0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5760,13 +5760,13 @@ static void record_wakee(struct task_struct *p)
  */
 static int wake_wide(struct task_struct *p)
 {
-	unsigned int master = current->wakee_flips;
-	unsigned int slave = p->wakee_flips;
+	unsigned int primary = current->wakee_flips;
+	unsigned int secondary = p->wakee_flips;
 	int factor = __this_cpu_read(sd_llc_size);
 
-	if (master < slave)
-		swap(master, slave);
-	if (slave < factor || master < slave * factor)
+	if (primary < secondary)
+		swap(primary, secondary);
+	if (secondary < factor || primary < secondary * factor)
 		return 0;
 	return 1;
 }
-- 
2.7.4

