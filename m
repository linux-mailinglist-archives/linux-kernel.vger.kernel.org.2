Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061CB428076
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 12:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbhJJK1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 06:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbhJJK1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 06:27:11 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1CAC061570
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 03:25:12 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id d13-20020a17090ad3cd00b0019e746f7bd4so12573637pjw.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 03:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kA2EwLBNslfvLXzwvv6riahnuFRUNL4Ji93TNaMdqWw=;
        b=kEFDgKkEq/zxSZYac6l6ZjjVgkY1czV8YOB0tYSIMB0QL2X6aHOppTpZfYB/tnSbTc
         JDU9Ojqv0frjBk06/Rxl7IB5gFgBBmrCldmIVd+S/v9/8ZJtANxmWFzd3Q0jKtcF0sim
         vFkNAnHU21icNgJhdpyS1CcSFBY+vp6BbPrNunulil3Dg57dxGzPfMd/gbYxP77UIu1p
         XrghXnl+/X7degOKakCtIKaXDF8oT3Ll5esaOpYnyJAzsBOPCIXJR0+oe/ZIywGqEkdf
         h+izI2/oJZmTfyaf+N4BqfUS31UkjuzbNeMAJ+Fj1P4R+btJTlyMMlcBRsDFdmfH74Ka
         9jYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kA2EwLBNslfvLXzwvv6riahnuFRUNL4Ji93TNaMdqWw=;
        b=LvwoDIYaU3KU/PK7GSe7hBOjzRBX34Qoojkh641lFglTUyckLA5DicAzJAU441jmml
         m6Epw+LQboimE7JvJy83tWxdcHW+z6eVwi+Vkm/25OPVCbfdj9urry64ReNaHwJFBuTL
         0dmuas4CknIDeVzvGPaZsXcPEQtg1BR57G1zt6zJVfQX+G+mF4bhEM29uptl240RI66l
         k0ceeJAy4PsXlboryfjpT3pM/ScNDP8ckkQQ5pzfgL91w/0C4fAnPL/tL/Euizo192Dq
         SpOC5DHF3jh8BL/ZE6bHIwqRv9U1DaciudaTZyolUpKMJ89S7tYyUKyimKla7xG3EGgK
         xFSw==
X-Gm-Message-State: AOAM5321T1yQX9hA0bUoqiACtNl9GpCatiQ0I35dZuo31ULJKO473GsJ
        TB1bCZw+DmP2Y6K5ScAikjY=
X-Google-Smtp-Source: ABdhPJwPqrMTwqJV7XGuSl4axhz3iL7t4tPpTrW/GBk0FNRrAWsL/sE65ZKOMVf/MqZ7IIMFqretvA==
X-Received: by 2002:a17:90a:9317:: with SMTP id p23mr23314201pjo.151.1633861512295;
        Sun, 10 Oct 2021 03:25:12 -0700 (PDT)
Received: from vultr.guest ([144.202.123.152])
        by smtp.gmail.com with ESMTPSA id w4sm4347494pfb.3.2021.10.10.03.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 03:25:11 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     keescook@chromium.org, rostedt@goodmis.org, peterz@infradead.org,
        pmladek@suse.com, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, valentin.schneider@arm.com,
        mathieu.desnoyers@efficios.com, qiang.zhang@windriver.com,
        robdclark@chromium.org, christian@brauner.io,
        dietmar.eggemann@arm.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>,
        Vladimir Zapolskiy <vzapolskiy@gmail.com>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH v3 1/4] connector: use __get_task_comm in proc_comm_connector
Date:   Sun, 10 Oct 2021 10:24:26 +0000
Message-Id: <20211010102429.99577-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211010102429.99577-1-laoar.shao@gmail.com>
References: <20211010102429.99577-1-laoar.shao@gmail.com>
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
2.18.2

