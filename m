Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD2C428077
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 12:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbhJJK1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 06:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbhJJK1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 06:27:12 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246FFC061570
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 03:25:14 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so11274204pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 03:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=50AI/2RIdxgM/cChrsyKhe/+8tNS9PoDTTXEOtoGSS4=;
        b=n0aHPqJ+abrMPhqHKgjGff+tDyvHXfJTzEn7QM7X6NySZvTkmCT/wb3GAUETnkvCTt
         RHL+jYp/lISdxM7jk35zudb/HS5HeiQd35VheuSTJTtSTZyDAGrfVkZfdi9/zSCQLeTO
         eQStCYA4LCYYpFvhS7O93inAI+DkNSniCFZkFuCbjANhWgrT6eAUtN/qLZazf9VKSPdb
         2+vibqlH7/s4Lpy/wZJs5HqLtFtcYM+rPOPPB3K+C2hm0ncn/9XuHWakAVpRJwIvDNR2
         G+uxuiUzXcmZhyWpSG70dzZEmBRxn0gnhUmUm5wf2k4KUXioMxEALjc4yaV1dfakXy/L
         SN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=50AI/2RIdxgM/cChrsyKhe/+8tNS9PoDTTXEOtoGSS4=;
        b=FBY5j2owCX4lYF0x9GJjUjLu3LONiBmRcktg30rzR6Ab3+nwwcvV0ty7gel4Nh1WK5
         9t+kQ7uK/IwMUf2aSvpiqXiqs9ZA7laF0cuc/t3jboiFUyLNvI+Nr6NSamshRXBWJJ7B
         Fsi650NLWBrv+UqXKwfbKNposJb/id6yQLprbdN57+/Gpn6okGDn2ct2ryfiv8sm8Sz0
         nXRsk78ZAeniAI82VgzQP7TuUtqjLuYJ/erps8bt5ReLSnmpdPSkyDoFopozrLx8NftO
         a10v7n3r4ELCYce9JCVrAemhbiF4PxVbph+xr0D13zZVCoPQxrMjA9AXzfFPRzGCrfOe
         s0Cw==
X-Gm-Message-State: AOAM533qnEmEP9PYpubrc+KY4iUvOLQHA3vvTG6kdxl9F9n21o5a6Pqj
        LX+IiYy0xw5F0QqfApExAGU=
X-Google-Smtp-Source: ABdhPJxft8QyYo0JAfq5fRiC662/l5NvG9Eq2m/bVM7LWGwJMvtBp1nN6LpJIYHu/WU0meA1H9Wecw==
X-Received: by 2002:a17:90b:3588:: with SMTP id mm8mr23591494pjb.238.1633861513700;
        Sun, 10 Oct 2021 03:25:13 -0700 (PDT)
Received: from vultr.guest ([144.202.123.152])
        by smtp.gmail.com with ESMTPSA id w4sm4347494pfb.3.2021.10.10.03.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 03:25:13 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     keescook@chromium.org, rostedt@goodmis.org, peterz@infradead.org,
        pmladek@suse.com, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, valentin.schneider@arm.com,
        mathieu.desnoyers@efficios.com, qiang.zhang@windriver.com,
        robdclark@chromium.org, christian@brauner.io,
        dietmar.eggemann@arm.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 2/4] fs/exec: use strscpy instead of strlcpy in __set_task_comm
Date:   Sun, 10 Oct 2021 10:24:27 +0000
Message-Id: <20211010102429.99577-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211010102429.99577-1-laoar.shao@gmail.com>
References: <20211010102429.99577-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a warning by checkpatch -
WARNING: Prefer strscpy over strlcpy - see: https://lore.kernel.org/r/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw@mail.gmail.com/

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Petr Mladek <pmladek@suse.com>
---
 fs/exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index a098c133d8d7..de804c566200 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1224,7 +1224,7 @@ void __set_task_comm(struct task_struct *tsk, const char *buf, bool exec)
 {
 	task_lock(tsk);
 	trace_task_rename(tsk, buf);
-	strlcpy(tsk->comm, buf, sizeof(tsk->comm));
+	strscpy(tsk->comm, buf, sizeof(tsk->comm));
 	task_unlock(tsk);
 	perf_event_comm(tsk, exec);
 }
-- 
2.18.2

