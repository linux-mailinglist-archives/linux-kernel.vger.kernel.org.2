Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B062B42AA27
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 18:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbhJLQ7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 12:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbhJLQ6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 12:58:38 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF135C061765
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 09:56:30 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id t7-20020a258387000000b005b6d7220c79so27767491ybk.16
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 09:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3xtw1iMxGRszg4/MWrK+88efBFsz8++3DWzKTvJUJng=;
        b=Kb86Pw5g6WTdAD35oTK2NO5Hic+YuxBuMM0aW9IXoXTI++CBgcHjafzlpQ7RSQd4he
         wvZX/Z7FzGMidXcXSGUcplB7H6YfU8s5TcgllGqpYOtDswmmGI2uLy6hdCi3dfHWLqag
         bL4gd8NubtrdEEQ31D/PaE1kNZPwmziB8m6CLxRp3y+5XW/gBNHjHQi1XoMXttRJ299E
         AAomrZuLNuNI70Yxrza8HV9S1XsXqerEVZEp8yr/xknSYWCSdegHKMJDDE8HjSjDcudR
         OK/Haw+HU7BMcchgO94ciYl9N22WCb6EaZ9j2qhbtax136tdakTUoMvijoXpSOYLMU0U
         iRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3xtw1iMxGRszg4/MWrK+88efBFsz8++3DWzKTvJUJng=;
        b=xhafQV9eIU94TJrLThS+hn8OR0ilI/NSTAcCUCpQVJNzgwv3S77WPIFEr7mx40XCNb
         ysWq5ScwQIUL/t0mx6depJVK9CO8sN9/LvAAR9LtyH5wcVTZY2W4xZ4NrNNvLpSOV6mc
         fa4tmZ/sbjckgcDGWMaYcwOAq7E+ZBDRFFJrU3NdRyCWBgVEg669q/ty1aToOml45mab
         ZIWxSbhIrNJ5NLKsCtFsUwG1S1V9ZyObNur7nDfABROvXXNhq4eRktJ1KDsOLvZwieDV
         ihxnK8feUUJgBaObY9QiVZ+YqQy7U593aqggtce9pfAsJkAYR0cmmKXLxV2/NS8gHFhl
         Fkmw==
X-Gm-Message-State: AOAM532z40o+zXrl2yo+y3bNT5rRO7LPnbWSiWybwJHk+Ngwni1YM8vz
        kZuu4jMoPoZYbA+r68ObpM17yFtj0g==
X-Google-Smtp-Source: ABdhPJyAAnfHvBs1PAt/sI6i4I2kEnVcw1mxvGIek06BxW1z07rUGam6/qn2XXRBq2dZIn8qa0z4gvC6Xw==
X-Received: from ava-linux2.mtv.corp.google.com ([2620:15c:211:200:39c7:8168:c0b2:b46e])
 (user=tkjos job=sendgmr) by 2002:a25:378e:: with SMTP id e136mr27234657yba.272.1634057790106;
 Tue, 12 Oct 2021 09:56:30 -0700 (PDT)
Date:   Tue, 12 Oct 2021 09:56:14 -0700
In-Reply-To: <20211012165614.2873369-1-tkjos@google.com>
Message-Id: <20211012165614.2873369-4-tkjos@google.com>
Mime-Version: 1.0
References: <20211012165614.2873369-1-tkjos@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v5 3/3] binder: use cred instead of task for getsecid
From:   Todd Kjos <tkjos@google.com>
To:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, christian@brauner.io, jmorris@namei.org,
        serge@hallyn.com, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        keescook@chromium.org, jannh@google.com, jeffv@google.com,
        zohar@linux.ibm.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     joel@joelfernandes.org, kernel-team@android.com,
        Todd Kjos <tkjos@google.com>,
        kernel test robot <lkp@intel.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the 'struct cred' saved at binder_open() to lookup
the security ID via security_cred_getsecid(). This
ensures that the security context that opened binder
is the one used to generate the secctx.

Fixes: ec74136ded79 ("binder: create node flag to request sender's
security context")
Signed-off-by: Todd Kjos <tkjos@google.com>
Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Cc: stable@vger.kernel.org # 5.4+
---
v3: added this patch to series
v4: fix build-break for !CONFIG_SECURITY
v5: set *secid=0 for !CONFIG_SECURITY version of secuirty_cred_getsecid()

 drivers/android/binder.c | 11 +----------
 include/linux/security.h |  5 +++++
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index bc15325f0579..26382e982c5e 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2722,16 +2722,7 @@ static void binder_transaction(struct binder_proc *proc,
 		u32 secid;
 		size_t added_size;
 
-		/*
-		 * Arguably this should be the task's subjective LSM secid but
-		 * we can't reliably access the subjective creds of a task
-		 * other than our own so we must use the objective creds, which
-		 * are safe to access.  The downside is that if a task is
-		 * temporarily overriding it's creds it will not be reflected
-		 * here; however, it isn't clear that binder would handle that
-		 * case well anyway.
-		 */
-		security_task_getsecid_obj(proc->tsk, &secid);
+		security_cred_getsecid(proc->cred, &secid);
 		ret = security_secid_to_secctx(secid, &secctx, &secctx_sz);
 		if (ret) {
 			return_error = BR_FAILED_REPLY;
diff --git a/include/linux/security.h b/include/linux/security.h
index 6344d3362df7..46a02ce34d00 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1041,6 +1041,11 @@ static inline void security_transfer_creds(struct cred *new,
 {
 }
 
+static inline void security_cred_getsecid(const struct cred *c, u32 *secid)
+{
+	*secid = 0;
+}
+
 static inline int security_kernel_act_as(struct cred *cred, u32 secid)
 {
 	return 0;
-- 
2.33.0.882.g93a45727a2-goog

