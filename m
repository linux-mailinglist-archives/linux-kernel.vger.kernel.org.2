Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC61433F01
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 21:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbhJSTK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 15:10:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47584 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbhJSTK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 15:10:27 -0400
Date:   Tue, 19 Oct 2021 21:08:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634670492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C8ColJKHoH+Yv5W5/AqrBFjrh4Kywtp5uxBkpUzYiy4=;
        b=1Vb4Mfh/LYR+wo4LldMpubI032U0pbAlkqPtK3VKJL0q9oPTVYe6AgxtxEiFoeTNyJdPpD
        icMFJDjTvLf2FjKHu1P8LA+MDG+Ye1wL6mxyWk4aaVEP9W9WWDAan8DXLnDEV5YL0CnqGp
        TVef2YWA0fTDn/S5gjklAgIG/Stuan/NH0GgdQXPvYyIaE34A6RpBG+ube0AQ7U3wWkCFN
        ENs8bArvjAwlQJBmH8nhpX+Pl9m3Qy2z5lM6iCMAOuZVJmxHRTjrpA/5RUrMRBLbI8Zg1B
        /sSpv1lIRQukU7vhkcigZIpFXXGQquaVFwWDzaAKFWLTpFSGDtEJOKkwsfvnxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634670492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C8ColJKHoH+Yv5W5/AqrBFjrh4Kywtp5uxBkpUzYiy4=;
        b=BqDey9nnfD5VLaaJijO59ydfW3kch+qR/dnydDa/N2xaOgTLSh6ZpmC4re6efSOpqFa7Ep
        7h+401e6/IET/6CA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     syzbot <syzbot+d5b23b18d2f4feae8a67@syzkaller.appspotmail.com>
Cc:     bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
        gor@linux.ibm.com, jgross@suse.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@kernel.org,
        mingo@redhat.com, namit@vmware.com, peterz@infradead.org,
        rdunlap@infradead.org, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com, vincent.guittot@linaro.org
Subject: Re: [syzbot] possible deadlock in wake_up_all_idle_cpus
Message-ID: <20211019190811.ubam63tfv33c7lmx@linutronix.de>
References: <000000000000cf252605ce67014a@google.com>
 <00000000000041567305ce80b8af@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00000000000041567305ce80b8af@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Does this do anything useful?

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index ad0b68a3a3d36..b3bf528fa14d3 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -1170,14 +1170,14 @@ void wake_up_all_idle_cpus(void)
 {
 	int cpu;
 
-	cpus_read_lock();
+	migrate_disable();
 	for_each_online_cpu(cpu) {
 		if (cpu == raw_smp_processor_id())
 			continue;
 
 		wake_up_if_idle(cpu);
 	}
-	cpus_read_unlock();
+	migrate_enable();
 }
 EXPORT_SYMBOL_GPL(wake_up_all_idle_cpus);
 
-- 
2.33.0

