Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E74424B5A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 02:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240148AbhJGAsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 20:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240143AbhJGAsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 20:48:33 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05AEC061767
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 17:46:40 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b197-20020a2534ce000000b005b71a4e189eso5798397yba.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 17:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zPCs1rEpKuQz4LUSoTxaJ0G3vwf7KAFSlUITLwZs6tU=;
        b=p7C8NObDL/qgsnHg5/TYMe/e2qJ6I/Lq4YqPZ2gUnySyfykd5F/A2vU/1m3ceyFytV
         I/7OeC1DNhDBO/Sg1SZmblT8zSDOS20AEaXhLm2H/qlJpIU+UkrwJgwQR6ZhajMJlwdg
         H0AQ8c2Ji4cC5UGLPFyjbyHiVLS1+KBXJaeDkVYrBsKAL2mDeRIuBNWlxuMFkZA9ZGV8
         A7qky4OO4I/PaZtI6fTe4+d1q4NwNuqcs2UJX5Gqm7isuGeOruusB375wUngfU0n4dV1
         v6iAo7zDuAInyEyLRn9Rt/0nvTXYRScq+aeug+gsRlashaZxAnGdEcAqgBxeJf60frPU
         Y76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zPCs1rEpKuQz4LUSoTxaJ0G3vwf7KAFSlUITLwZs6tU=;
        b=sfsE/aK/sn6d6yjWUymP7ATRUySYQcFzPu7ZxsgfUjVtV3xWCxWqfEj7i/lTvwV1yA
         GAjWGuOneiFgePIc/4loK0Sgu7OziMrKJfZanyVdeSIxIGc7h8+vh5soVXFel9SZZCao
         wOpkCVEFJ6VVv8zRMhgiG9zNTbEqx8rk+LGpLYEAz7uOkdccBkk+GApjZr7GqHvfTrZR
         8gqA0PwJytNx3GcLI0m0525CyLdjhKDYkBGxF+/vLP9NHofbKY7kMZH8YdXS4VxPK5RQ
         d+lvTmHKtU0+dMK9EO9ndjPF7zGbXmgUdbjyOc1E9Y+5CRjHPS+Gnvt170saUdp+slRX
         zXAw==
X-Gm-Message-State: AOAM531jCIAj3p1mANe9NY7vxu3JeLyDGsAW++csDpr2fBCbkJAJwYcL
        kEHCr9ucqYMS+hO6lHXQeMXiX0Z/Zw==
X-Google-Smtp-Source: ABdhPJyjO6u79sIe1Ctn1/EYwfXuBQtVGMw40kM5yChFcDVNsb4RU39eXJBDBGttGXiLTmWRzysZNXQWxg==
X-Received: from ava-linux2.mtv.corp.google.com ([2620:15c:211:200:6ff2:347f:ac4a:8a04])
 (user=tkjos job=sendgmr) by 2002:a5b:501:: with SMTP id o1mr1359354ybp.402.1633567600035;
 Wed, 06 Oct 2021 17:46:40 -0700 (PDT)
Date:   Wed,  6 Oct 2021 17:46:29 -0700
In-Reply-To: <20211007004629.1113572-1-tkjos@google.com>
Message-Id: <20211007004629.1113572-4-tkjos@google.com>
Mime-Version: 1.0
References: <20211007004629.1113572-1-tkjos@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v4 3/3] binder: use euid from cred instead of using task
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
        Todd Kjos <tkjos@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set a transaction's sender_euid from the 'struct cred'
saved at binder_open() instead of looking up the euid
from the binder proc's 'struct task'. This ensures
the euid is associated with the security context that
of the task that opened binder.

Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
Signed-off-by: Todd Kjos <tkjos@google.com>
Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: stable@vger.kernel.org # 4.4+
---
v3: added this patch to series

 drivers/android/binder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 989afd0804ca..26382e982c5e 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2711,7 +2711,7 @@ static void binder_transaction(struct binder_proc *proc,
 		t->from = thread;
 	else
 		t->from = NULL;
-	t->sender_euid = task_euid(proc->tsk);
+	t->sender_euid = proc->cred->euid;
 	t->to_proc = target_proc;
 	t->to_thread = target_thread;
 	t->code = tr->code;
-- 
2.33.0.800.g4c38ced690-goog

