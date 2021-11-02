Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237A8442B38
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 11:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhKBKCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 06:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhKBKCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 06:02:35 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D114C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 03:00:01 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id r28so19770461pga.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 03:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=JpTyGYnff/5miun0g61C6IcTX8F0aNJvJj2eVkMxvhU=;
        b=OaZ87GejHK9lo+qBFKeYET1LmjJ2+z5pq2FkNimcTEj4hwzuGTrDqOr4cszXqebtS6
         NPnLD92dSg+E236N7oAmvOxDA9YLEAwDpRS9HcyanMOaOd60dJI+yzaJsr98B8kF2t0E
         nRDUxynghTgr18yWZA5grBqqlpnN4TxAO1aUvoZgGnAXHdhHFh2ZgtbMUG5dgfnwQNpq
         fGajTCWpxEjlhoWT6UpBZO2FrL07j/aLE692ioMebNMk5equZKzfd5NT6jBhMJaZrr0v
         VI0o67fhjdue2dhKNmDgwZf0fFqHWA6AeLzGL50W5Gl9KpGgv8M/hzses9uPMNsNoZOy
         Qc7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JpTyGYnff/5miun0g61C6IcTX8F0aNJvJj2eVkMxvhU=;
        b=V5BLNUH34ek4hJkhi5KIx/3iOyOU8ZXjV4Mw9uX4feUsBN2SFfI98dSXKEUk4S4Jsv
         /ZArMwSyvwhOljqp9kYn0tIwz4bMR01/TmxrjEfphModyxlD6Ieq/8wFC2JeHma6Qawt
         Ugs5jx2UkUAPfqu1rHv05x+8Puoqr+v/hyiFHNRr+ii2OTnyhxvV8WYrtBC6d0va18+I
         3OyLWo2bcePb4US9Y+So1nJEM+BNp/qzI1ELOn0joAwcTO/76yCNJ1N1mSSvjGYHcera
         vqWGboARprvqB/ktpYLPfRySijvcMxYC/AgcenSA71m9eJbT9xBGZe3axn++2xR+Yqvj
         a2wA==
X-Gm-Message-State: AOAM533lHMbYNTsr/tM0NnDv9zt1nsZf3oQGrf54ckzKWZ+lqm7MNb//
        RQ4lJKfV7XNNlvMK3ZjgFa8=
X-Google-Smtp-Source: ABdhPJwCWI/5Qq+20VTAWY790ex7XZTcC5l+HGCxwBioFFFqY8ChuQReqyQ+/YcIlL0BiC+ba2i8Ow==
X-Received: by 2002:aa7:8019:0:b0:44d:d761:6f79 with SMTP id j25-20020aa78019000000b0044dd7616f79mr35580155pfi.3.1635847200638;
        Tue, 02 Nov 2021 03:00:00 -0700 (PDT)
Received: from BJ-zhangqiang.qcraft.lan ([137.59.101.13])
        by smtp.gmail.com with ESMTPSA id ml24sm1921607pjb.16.2021.11.02.02.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 03:00:00 -0700 (PDT)
From:   Zqiang <qiang.zhang1211@gmail.com>
To:     tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH v2] ALSA: seq: Fix RCU stall in snd_seq_write()
Date:   Tue,  2 Nov 2021 17:59:55 +0800
Message-Id: <20211102095955.30060-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we have a lot of cell object, this cycle may take a long time, and
trigger RCU stall. insert a conditional reschedule point to fix it.

rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	1-....: (1 GPs behind) idle=9f5/1/0x4000000000000000
	softirq=16474/16475 fqs=4916
	(t=10500 jiffies g=19249 q=192515)
NMI backtrace for cpu 1
......
asm_sysvec_apic_timer_interrupt
RIP: 0010:_raw_spin_unlock_irqrestore+0x38/0x70
spin_unlock_irqrestore
snd_seq_prioq_cell_out+0x1dc/0x360
snd_seq_check_queue+0x1a6/0x3f0
snd_seq_enqueue_event+0x1ed/0x3e0
snd_seq_client_enqueue_event.constprop.0+0x19a/0x3c0
snd_seq_write+0x2db/0x510
vfs_write+0x1c4/0x900
ksys_write+0x171/0x1d0
do_syscall_64+0x35/0xb0

Reported-by: syzbot+bb950e68b400ab4f65f8@syzkaller.appspotmail.com
Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 v1->v2:
 Add atomic context detection.

 sound/core/seq/seq_queue.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/core/seq/seq_queue.c b/sound/core/seq/seq_queue.c
index d6c02dea976c..3a05b5e0d555 100644
--- a/sound/core/seq/seq_queue.c
+++ b/sound/core/seq/seq_queue.c
@@ -263,6 +263,8 @@ void snd_seq_check_queue(struct snd_seq_queue *q, int atomic, int hop)
 		if (!cell)
 			break;
 		snd_seq_dispatch_event(cell, atomic, hop);
+		if (!atomic)
+			cond_resched();
 	}
 
 	/* Process time queue... */
@@ -272,6 +274,8 @@ void snd_seq_check_queue(struct snd_seq_queue *q, int atomic, int hop)
 		if (!cell)
 			break;
 		snd_seq_dispatch_event(cell, atomic, hop);
+		if (!atomic)
+			cond_resched();
 	}
 
 	/* free lock */
-- 
2.17.1

