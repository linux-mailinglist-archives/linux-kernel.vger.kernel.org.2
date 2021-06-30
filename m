Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6205A3B7B04
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 02:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbhF3Agw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 20:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235641AbhF3Agt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 20:36:49 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1507C061766
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 17:34:21 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id y17-20020ad445b10000b029027389e9530fso213803qvu.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 17:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2XuTKmc5MiUcD3IttpZN1adwmf1E7UnKBnnfEh9asIE=;
        b=S4++qrlNREHISaDmUEHXPnvjr5JNiG3QxU1bd+U22BonKWasfFWISE4WFqMwbiGsro
         6FV0Vigj6cEo/YqiKaKGHFuTi5/GP3dFtgMn8pensTVybHIYMx5SCT98p5ax0lbpG6Lv
         NLmuLCLzBfMKL7t9zvocmdamq68VheY3xHWzI21GwZdQb99+LfuVabJayksQua8TW3Cd
         14UhcfOX2pvTuJ3r3FkM1pLZhRd6msii8QkXPNiy6ONLo0oq9zoDuChUl1OwHfr6QVgY
         mHG2dkeQUKtw6xd8Vd1/hGT5WHOVtb5J89HVi2MDGVsZJw4iByvzvejICUUp+Gki6hg/
         FX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2XuTKmc5MiUcD3IttpZN1adwmf1E7UnKBnnfEh9asIE=;
        b=c0Nkl7j3Nbc4h9QEKiGiN7CM5+dIIP7Ji69rbNgR9m2ILFvVi+OMAq7l1hZ0yz5H4E
         Lavz/zIb+7OXgolEs89p805GjPp4ss0rYphIoHY137m6Pp3EZ5TibjBenLvn32ljXw26
         CDhxJ1Xi/v6IFlmQ2VJa29blzALCeK9SzIFNdeOtg7yb3cEMT33ECinSKsK7zXBLITcs
         BULa1g7VWzkmEPmq8RbmhqUhzkK/Za8xW5KqFsI6i300F9EsXeHbTpIK6PP+E0LSXceg
         qRNMvBGTwFFkFKX1pl/f1oZ2B6OeKTUkDTfhFHq2Yo++oG1f6BAoDIN5xXEVt+nKHPn2
         0spg==
X-Gm-Message-State: AOAM5335OAPz0gUpDHJd4H8qay3l6/mpSo09MB1XDx1RbmZSh/KUn+vk
        rrBgWOgAnU72STZxecDnqpTf6xQ550HzIYBmXCd7P2yO0Jpi/MetnIvDENYoDWeK6m3KeBGb2L8
        7X1HFmA4PvDW4klLQdSxyv5F1lu+jq9oSKfrkQA0RDxghakITOz1JJUK2RbQD5JEK5RHKkONaqQ
        mBN4/P
X-Google-Smtp-Source: ABdhPJxYfIl/RsKi8Q1Y3mmzLWSHsPkK3ATLJmVUt286PIPfoCoSEuWaEF6ttquZPkAXgO/wXL2J9ADhN52OnMoR
X-Received: from paulburton.mtv.corp.google.com ([2620:15c:280:201:1517:9bca:ad4d:3b49])
 (user=paulburton job=sendgmr) by 2002:a0c:f885:: with SMTP id
 u5mr34153484qvn.28.1625013260689; Tue, 29 Jun 2021 17:34:20 -0700 (PDT)
Date:   Tue, 29 Jun 2021 17:34:06 -0700
In-Reply-To: <20210630003406.4013668-1-paulburton@google.com>
Message-Id: <20210630003406.4013668-2-paulburton@google.com>
Mime-Version: 1.0
References: <20210630003406.4013668-1-paulburton@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH 2/2] tracing: Resize tgid_map to PID_MAX_LIMIT, not PID_MAX_DEFAULT
From:   Paul Burton <paulburton@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Paul Burton <paulburton@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Joel Fernandes <joelaf@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently tgid_map is sized at PID_MAX_DEFAULT entries, which means that
on systems where pid_max is configured higher than PID_MAX_DEFAULT the
ftrace record-tgid option doesn't work so well. Any tasks with PIDs
higher than PID_MAX_DEFAULT are simply not recorded in tgid_map, and
don't show up in the saved_tgids file.

In particular since systemd v243 & above configure pid_max to its
highest possible 1<<22 value by default on 64 bit systems this renders
the record-tgids option of little use.

Increase the size of tgid_map to PID_MAX_LIMIT instead, allowing it to
cover the full range of PIDs up to the maximum value of pid_max.

On 64 bit systems this will increase the size of tgid_map from 256KiB to
16MiB. Whilst this 64x increase in memory overhead sounds significant 64
bit systems are presumably best placed to accommodate it, and since
tgid_map is only allocated when the record-tgid option is actually used
presumably the user would rather it spends sufficient memory to actually
record the tgids they expect.

The size of tgid_map will also increase for CONFIG_BASE_SMALL=y
configurations, but these seem unlikely to be systems upon which people
are running ftrace with record-tgid anyway.

Signed-off-by: Paul Burton <paulburton@google.com>
Fixes: d914ba37d714 ("tracing: Add support for recording tgid of tasks")
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: <stable@vger.kernel.org>
---
 kernel/trace/trace.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 9570667310bcc..c893c0c2754f8 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2460,7 +2460,7 @@ void trace_find_cmdline(int pid, char comm[])
 
 int trace_find_tgid(int pid)
 {
-	if (unlikely(!tgid_map || !pid || pid > PID_MAX_DEFAULT))
+	if (unlikely(!tgid_map || !pid || pid > PID_MAX_LIMIT))
 		return 0;
 
 	return tgid_map[pid];
@@ -2472,7 +2472,7 @@ static int trace_save_tgid(struct task_struct *tsk)
 	if (!tsk->pid)
 		return 1;
 
-	if (unlikely(!tgid_map || tsk->pid > PID_MAX_DEFAULT))
+	if (unlikely(!tgid_map || tsk->pid > PID_MAX_LIMIT))
 		return 0;
 
 	tgid_map[tsk->pid] = tsk->tgid;
@@ -5194,7 +5194,7 @@ int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled)
 
 	if (mask == TRACE_ITER_RECORD_TGID) {
 		if (!tgid_map)
-			tgid_map = kvcalloc(PID_MAX_DEFAULT + 1,
+			tgid_map = kvcalloc(PID_MAX_LIMIT + 1,
 					   sizeof(*tgid_map),
 					   GFP_KERNEL);
 		if (!tgid_map) {
@@ -5610,7 +5610,7 @@ static void *saved_tgids_next(struct seq_file *m, void *v, loff_t *pos)
 {
 	int pid = ++(*pos);
 
-	if (pid > PID_MAX_DEFAULT)
+	if (pid > PID_MAX_LIMIT)
 		return NULL;
 
 	return &tgid_map[pid];
@@ -5618,7 +5618,7 @@ static void *saved_tgids_next(struct seq_file *m, void *v, loff_t *pos)
 
 static void *saved_tgids_start(struct seq_file *m, loff_t *pos)
 {
-	if (!tgid_map || *pos > PID_MAX_DEFAULT)
+	if (!tgid_map || *pos > PID_MAX_LIMIT)
 		return NULL;
 
 	return &tgid_map[*pos];
-- 
2.32.0.93.g670b81a890-goog

