Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3184F42BCB7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 12:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239351AbhJMK0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 06:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239259AbhJMK0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 06:26:01 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D77C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 03:23:58 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so1868728pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 03:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=62koRudqWjPa+m03K1wbJbIYHG/dmXgg8brtixS11/M=;
        b=H3NfAjSzIFM0P3H1aWToJhFhDjuQ5NuXSy4dN4qMq9uH6COmVVdaQePfW1HYhfCkVs
         tO6Nnjg7WVVwoaZMY+/efc93Ur/zfXiQcslsqBR/2fLL2ubquzpLsJ3abU0DfVHdBXQu
         izoT26lwOKVKc7868f80MuswJ3v+zvVam02nm+DBuEv09OeCB7DC3SZJ1X29KfOsAmq1
         MKocK74z0o3byMC7jcPkAmxP0diFRT2bktru0KJum3B+tVbOByNYEg/Ct2lyplTP7SDq
         fqClnYPh6fghCStuAPdgomdsHH7A01GGpky6VWhDGxJoziCZF0kyNhMftdpFx+TxTJSt
         k23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=62koRudqWjPa+m03K1wbJbIYHG/dmXgg8brtixS11/M=;
        b=7cQaEb88HSnfV3PqqsLWSGp4fQxVwRTIDmTmxQNsJeF2r9h6ndbeppaola03dEwGrW
         ArTBM1Ng7GcDf4qt7oViWaZ7TtXA74BKkuRV4MA2h91Vx0gBLlu40+gs/NahOl1KydnA
         k+0SGFoHyFDjmQFaHMnlgkvAOKdYJaZq+9BoMT+04E04hIMD+gNAhSQCgbEFqwAsx8NI
         izmY/kQrMlohUFr/4jxIYSZkRlmb2FCa8mj8jMN/yhRpvGOVk2rYLyAxVeGbkaNo970V
         uWGsNKfFa0aszX1ks1YoI6IdeOQNIqMgKl/x946N1As52wTNM4ZEygRQ6X6qEddqJco6
         qscg==
X-Gm-Message-State: AOAM533vtWkrHrWXyJUgHl0q0NFYRYVTwxlxnpLS8X1EaxUlqsQ/d5KH
        nWJSBs6T/le9a07kO67pLDw=
X-Google-Smtp-Source: ABdhPJyuhvxNZ/vFbSnjujiW++PlTq/QXBGZ6TlMOMltdSMhUvDnLjbrV7xznWZC1cnkM66P43loTg==
X-Received: by 2002:a17:90b:1101:: with SMTP id gi1mr12296100pjb.11.1634120638367;
        Wed, 13 Oct 2021 03:23:58 -0700 (PDT)
Received: from vultr.guest ([144.202.123.152])
        by smtp.gmail.com with ESMTPSA id 184sm13900994pfw.49.2021.10.13.03.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 03:23:58 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     keescook@chromium.org, rostedt@goodmis.org, peterz@infradead.org,
        pmladek@suse.com, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, valentin.schneider@arm.com,
        mathieu.desnoyers@efficios.com, qiang.zhang@windriver.com,
        robdclark@chromium.org, christian@brauner.io,
        dietmar.eggemann@arm.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>,
        Vladimir Zapolskiy <vzapolskiy@gmail.com>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH v4 2/5] connector: use __get_task_comm in proc_comm_connector
Date:   Wed, 13 Oct 2021 10:23:43 +0000
Message-Id: <20211013102346.179642-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211013102346.179642-1-laoar.shao@gmail.com>
References: <20211013102346.179642-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

connector comm was introduced in commit
f786ecba4158 ("connector: add comm change event report to proc connector").
struct comm_proc_event was defined in include/linux/cn_proc.h first and
then been moved into file include/uapi/linux/cn_proc.h in commit
607ca46e97a1 ("UAPI: (Scripted) Disintegrate include/linux").

As this is the UAPI code, we can't change it without potentially breaking
things (i.e. userspace binaries have this size built in, so we can't just
change the size). To prepare for the followup change - extending task
comm, we have to use __get_task_comm() to avoid the BUILD_BUG_ON() in
proc_comm_connector().

Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Vladimir Zapolskiy <vzapolskiy@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Petr Mladek <pmladek@suse.com>
---
 drivers/connector/cn_proc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
index 646ad385e490..c88ba2dc1eae 100644
--- a/drivers/connector/cn_proc.c
+++ b/drivers/connector/cn_proc.c
@@ -230,7 +230,10 @@ void proc_comm_connector(struct task_struct *task)
 	ev->what = PROC_EVENT_COMM;
 	ev->event_data.comm.process_pid  = task->pid;
 	ev->event_data.comm.process_tgid = task->tgid;
-	get_task_comm(ev->event_data.comm.comm, task);
+
+	/* This may get truncated. */
+	__get_task_comm(ev->event_data.comm.comm,
+			sizeof(ev->event_data.comm.comm), task);
 
 	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
 	msg->ack = 0; /* not used */
-- 
2.17.1

