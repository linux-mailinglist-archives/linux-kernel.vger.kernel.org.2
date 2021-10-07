Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916B3425290
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 14:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241207AbhJGMKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 08:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241147AbhJGMJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 08:09:54 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DCBC061760
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 05:08:00 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id kk10so4711528pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 05:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a+ydO2SzbIiVcsAIQt4WKiIGrttqFeAK4tlG0XDRU9k=;
        b=OcYVVN9MoWHYHnNmFH3io0RQNbObIDWhPkwMSg5WHzHZjXe2D3zyBKP1yYv3z9RNVr
         d8HWruZl1BD0tDAmaLf2fwiWbLEbG4qIUXadeXQ8VQkfXh0t8QCuMbpt0M/5jbCd/Xw5
         oWNJIafmwC0RaT9aQzP1zcwcBjGtnAi9osO27R1swITUQxHjNyjayhmbqKARp7u9j46x
         +9AJWftD4MqOqNLk4x2Thbqyx83D7eMqUb8t/0oExRFO/QCiD34/LcuRzgiiqtGJB+3T
         oD2NCLR+bZ+knfgkRd6rNpN6Gqy5kafu6xBiuLix4kWF+8Eq+uCAdnDrpbkccHzgp3k6
         l6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a+ydO2SzbIiVcsAIQt4WKiIGrttqFeAK4tlG0XDRU9k=;
        b=vVtzAivm05pgWCB7oz8WHDMKXp6rAiBXWddMTwgWwfOrc+GdZRwVzB+hoHpUJYX66H
         Opk8T72RYnV2RLireXazT4Lk2sToNGkGcjYM8rtkiayJVZpFt6uzYyXpl0tE1k1ZdfTs
         EcrIfQ3ePWSDD7EYo/nxhyqGLIcxV/etJ9WuCPhZSmPgypLnC4sZHz4XDi+M8+viJqN4
         dzUJmxNKA1B8QjqDNaCLDMbhqgjvHdB7/el/6vAVqBDXJIyAt2Oqvk4X74JZpgFE/KAZ
         mrmpK4S75P7YQ43wFkQOgdT+3aQqLKiEIiLOHpmAAwjuSL7zWcmW/utB/bdd0oCf7VSb
         Rz3g==
X-Gm-Message-State: AOAM532wiLD5AnlEfWROK2wCrCjhCxynvdsRODDSKv1qnS2PGm7ykFcY
        gW6rgTyEyHIUOMKOr6ZF4jg=
X-Google-Smtp-Source: ABdhPJwTOZY1jJv87RD9WNrWKIBLInU/3VoVjK0z7UwW1Y3RnWedTM2tspxRQODl6pyYNJZ0+SWd0Q==
X-Received: by 2002:a17:90b:30c:: with SMTP id ay12mr5052588pjb.234.1633608480040;
        Thu, 07 Oct 2021 05:08:00 -0700 (PDT)
Received: from localhost.localdomain ([144.202.123.152])
        by smtp.gmail.com with ESMTPSA id c8sm23915582pfj.204.2021.10.07.05.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 05:07:59 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     pmladek@suse.com, keescook@chromium.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, peterz@infradead.org,
        valentin.schneider@arm.com, mathieu.desnoyers@efficios.com,
        qiang.zhang@windriver.com, robdclark@chromium.org,
        christian@brauner.io, dietmar.eggemann@arm.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 2/4] fs/exec: use strscpy instead of strlcpy in __set_task_comm
Date:   Thu,  7 Oct 2021 12:07:50 +0000
Message-Id: <20211007120752.5195-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211007120752.5195-1-laoar.shao@gmail.com>
References: <20211007120752.5195-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a warning by checkpatch -
WARNING: Prefer strscpy over strlcpy - see: https://lore.kernel.org/r/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw@mail.gmail.com/

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Kees Cook <keescook@chromium.org>
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

