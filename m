Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2706E441270
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 04:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhKADpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 23:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbhKADpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 23:45:07 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC515C061746
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 20:42:34 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id t11so10688249plq.11
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 20:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qJkJaIGphShFQXkRYHBKnvd7e3QDBTULp9qNkGUUZ1w=;
        b=k6qGHfdYxl7a8/J640Mxj1QM8KE2+KVfUHUsn66oEhwOIN8HQqsqAyVal4k5KG6JfF
         C3gMHEBeK3Dlg4Sx+g2KA1035IgoUErWh/sOtpWlhbaeJHHuuwHFwrnRe/lgG0FnSTVT
         a53c26FOhi3cOWusbtCVl3T8d1St/XrQm8a66Ukf5san9FNyOfSL4FxOZRBeZOii6W6Y
         uPV6fama2Afpp7sQAYD6yV2qLp4ZWAmhY/yrMRJfIYQCv5L4FwDW9JyowIu1oBkto+iN
         SnuEmZ/YDXZDoD0SUaK17wZxurJ6uZguiKWoSD2WnFQ9KiMkxkvf9eujD2ViYeaBo6zk
         q5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qJkJaIGphShFQXkRYHBKnvd7e3QDBTULp9qNkGUUZ1w=;
        b=DfT/+9D5/SIC0aoTo8P38gLzDwPUTxW7ntzbM2KZAtBtSsZrrlnp5oyIgZdO3QZ+SE
         4ok1pcQIZiraOlOpWPSfRaSRogS4jzZOgoz1QftGBJ9f+DxMa9ktupzf6TgeltJvSwru
         6cIJsHKR1ldGgFIuLRDxcocdP2hrjXQaeHOAI7AEx/XoCrVMJD/0xfilRUzo5OT1u2U1
         VwNMrDGOk88lU9WVc9dK3MB5yO0WLExsr1N1WP7xbFm6ECf1oDJ2bbHXop8SmSPfLDHK
         GrojGcuVKTURD3lwvIISIRQxXrkMY0tqfhqcNMdJoss4R7g3PbJ2sNSUW4JCIhcK5r5w
         GcRA==
X-Gm-Message-State: AOAM533u7jCuAiFcIDVNNFGUaRG6YPrCxXeyMqdnh8AXzGjyLYd2jVzX
        52sRcoOSnU4mCaKKVNS9D9gmNQ==
X-Google-Smtp-Source: ABdhPJyKEkt9Sue1UrRxxFHh2xKZN1JH5j4c75OXQW2QoxUr1qqR5nUurnb4qWusfdEZoM9AkjvPcQ==
X-Received: by 2002:a17:902:b7cb:b0:141:b33a:9589 with SMTP id v11-20020a170902b7cb00b00141b33a9589mr15538170plz.9.1635738154364;
        Sun, 31 Oct 2021 20:42:34 -0700 (PDT)
Received: from minbar.home.kylehuey.com (c-71-198-251-229.hsd1.ca.comcast.net. [71.198.251.229])
        by smtp.gmail.com with ESMTPSA id x9sm11270588pga.28.2021.10.31.20.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Oct 2021 20:42:33 -0700 (PDT)
From:   Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Alexey Gladkov <legion@kernel.org>
Cc:     Robert O'Callahan <rocallahan@gmail.com>,
        =?UTF-8?q?Marko=20M=C3=A4kel=C3=A4?= <marko.makela@mariadb.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] signal: factor out SIGKILL generation in get_signal
Date:   Sun, 31 Oct 2021 20:41:46 -0700
Message-Id: <20211101034147.6203-2-khuey@kylehuey.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211101034147.6203-1-khuey@kylehuey.com>
References: <20211101034147.6203-1-khuey@kylehuey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding a second case that will invoke the same code,
factor out this branch. Fix label formatting while we're nearby too.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
Reported-by: Marko Mäkelä <marko.makela@mariadb.com>
---
 kernel/signal.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 487bf4f5dadf..4d26ee5c662a 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2690,12 +2690,7 @@ bool get_signal(struct ksignal *ksig)
 
 	/* Has this task already been marked for death? */
 	if (signal_group_exit(signal)) {
-		ksig->info.si_signo = signr = SIGKILL;
-		sigdelset(&current->pending.signal, SIGKILL);
-		trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO,
-				&sighand->action[SIGKILL - 1]);
-		recalc_sigpending();
-		goto fatal;
+		goto kill;
 	}
 
 	for (;;) {
@@ -2816,7 +2811,16 @@ bool get_signal(struct ksignal *ksig)
 			continue;
 		}
 
-	fatal:
+		goto fatal;
+
+kill:
+		ksig->info.si_signo = signr = SIGKILL;
+		sigdelset(&current->pending.signal, SIGKILL);
+		trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO,
+				&sighand->action[SIGKILL - 1]);
+		recalc_sigpending();
+
+fatal:
 		spin_unlock_irq(&sighand->siglock);
 		if (unlikely(cgroup_task_frozen(current)))
 			cgroup_leave_frozen(true);
-- 
2.33.1

