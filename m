Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B25442613
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 04:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbhKBDfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 23:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbhKBDfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 23:35:02 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C86C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 20:32:28 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id x5so9143646pgk.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 20:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=EEtgEXOACUA3wKgJhhNtGNwsVVeGXT8yNYslnmQWcCk=;
        b=f9u5ZqQMRscLfivm6j2Nct+cObOy/UZGbS5T4Pi580A/n7atUi1PCx6+1G36J367uT
         /WW14bqFLXYyRJupCzQf26JBHnwguiXfPAK+UvpPQ5CSjwDCWI0DkYm85b/9di08A0h/
         5WiayzrfmhSkoi+FfFsqK3ZGFwL/46Iq0GLw7/HPzzIRqpma0dwOd2LOSMbIR17G0B70
         LXJGgTcl3WiEvQGsWrRcky50MzXCxzb+h/A8849SzrhGA7opPOs86KSKNlmwmo9rnntd
         j+99mD9rp8KLzE6c8CaARSB7dxZ8ty5O7o3MEw4Dz70uW0ryrzi2dy3LRHjDWeZXW2IV
         j2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EEtgEXOACUA3wKgJhhNtGNwsVVeGXT8yNYslnmQWcCk=;
        b=H4tHKTUGos6swZLeHu3ZHPohmmHMAAtHqNgRpV6RgW4TIJVw/vusPz/SISAW27E8sp
         kjknR3E1dnTtUuuRGa0VTlYk8czlitdLBXGvB+uBMRMQh88LC9Ueyw+OHKiRdoxkRvwv
         aAUXs66KqRctEI7jSKLYe4Q6EtZ+IhuTUbC7tAG+mW5hGO3pFXf61EluOwUnKJrqpisK
         YDgd34DFffSqq97rZ8vPA+Gtye/b840rF0BP08wkIVvyxLKySZ6VpVKOCOZ6118enMI7
         aT4up/3xNVYuJqmDc/AN+qnuuYj2l4MM/uJEpXwfu+0pQZr4GPzGvxDjAJhGxgheeOyV
         RNqw==
X-Gm-Message-State: AOAM531cwpFj69bbG+apOd3pquKF+VVAKKznMB/0FQGG1Dt5KxO749R8
        cKB3MQyqyRUL98+UN+xUrS4=
X-Google-Smtp-Source: ABdhPJx0rqGpL+96sH9guHKoU1KDdgjt8V/3RIX2d8+BiZ8N5riUsa5Fn6nlnDXVmEEwHg9D6CAXBQ==
X-Received: by 2002:a63:455f:: with SMTP id u31mr5567894pgk.206.1635823948233;
        Mon, 01 Nov 2021 20:32:28 -0700 (PDT)
Received: from BJ-zhangqiang.qcraft.lan ([137.59.101.13])
        by smtp.gmail.com with ESMTPSA id c21sm3937785pfv.119.2021.11.01.20.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 20:32:27 -0700 (PDT)
From:   Zqiang <qiang.zhang1211@gmail.com>
To:     tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH] ALSA: seq: Fix RCU stall in snd_seq_write()
Date:   Tue,  2 Nov 2021 11:32:22 +0800
Message-Id: <20211102033222.3849-1-qiang.zhang1211@gmail.com>
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
 sound/core/seq/seq_queue.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/core/seq/seq_queue.c b/sound/core/seq/seq_queue.c
index d6c02dea976c..f5b1e4562a64 100644
--- a/sound/core/seq/seq_queue.c
+++ b/sound/core/seq/seq_queue.c
@@ -263,6 +263,7 @@ void snd_seq_check_queue(struct snd_seq_queue *q, int atomic, int hop)
 		if (!cell)
 			break;
 		snd_seq_dispatch_event(cell, atomic, hop);
+		cond_resched();
 	}
 
 	/* Process time queue... */
@@ -272,6 +273,7 @@ void snd_seq_check_queue(struct snd_seq_queue *q, int atomic, int hop)
 		if (!cell)
 			break;
 		snd_seq_dispatch_event(cell, atomic, hop);
+		cond_resched();
 	}
 
 	/* free lock */
-- 
2.17.1

