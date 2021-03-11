Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63AD7337CE0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 19:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhCKSqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 13:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhCKSqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 13:46:35 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31810C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 10:46:35 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id g4so14244311pgj.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 10:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jsb6E0FK8MRIhs7lJ7D4eERwE7vUrhoh8LogP70fZt4=;
        b=M2eO061lK/r+Wprxytw5m1AqfRReogSNsgcZMLc5wcHCDT+xRXZ6eg4P4wXyWb+zNU
         Yw8A7pyi619WeytrvNrXC5RE8cfIsq39+KTkqX5o2jhiUubEHySgJzUDhH1DswG7BR1O
         yVAb8b20uwjiL3motL+4kSsMJ+GDAvNCUr7mU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jsb6E0FK8MRIhs7lJ7D4eERwE7vUrhoh8LogP70fZt4=;
        b=bL5BiCKytxP4tMijue5GmJHKzy/bxgwYrj32W4r8uQymytWhUuu5/sglRxOkKKwMty
         19/fxvKUEyo8zrhBv3pyNLwor+uzH6CNHZCZh6bIzhOC/WvstFeIuTFc54S6TIH+iTo6
         JnKrke8O/FQSWWzA+o5I3e50ozszVKsSw7PJ/gD0dWvW98UkDWzlHeemPKkNtRrO4hAw
         Io+toga9meHsZL5/RnVsCUFUCFdxIUx4r4itST6l3+PUfVGeJc4Lgq5YRnZA5/svpFn0
         dPe/kS6upiwN3ufvjX6jUPBdbr3gY49SHduhIV4RVOWqTEsooJhEux2UMCC+X0TtBgCc
         f4iQ==
X-Gm-Message-State: AOAM532CEWjrf9EQ5TcBW89VMNEMDGwFlN4wmGb4mbwgsjfV5VSyzU1k
        q8EsAEUfltvOTSmfbgKmEtQM/g==
X-Google-Smtp-Source: ABdhPJw8Kn5XC+uVS/X25xneC62+nmr9A/S66pErwyPEkvxxDuPvVOSdORxBHW7dZ3xkYf26Hhl3Og==
X-Received: by 2002:a63:161c:: with SMTP id w28mr8473860pgl.341.1615488394733;
        Thu, 11 Mar 2021 10:46:34 -0800 (PST)
Received: from li-cloudtop.c.googlers.com.com (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id z2sm3108398pfq.198.2021.03.11.10.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 10:46:34 -0800 (PST)
From:   Li Li <dualli@chromium.org>
To:     dualli@google.com, tkjos@google.com, gregkh@linuxfoundation.org,
        christian@brauner.io, arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com, hridya@google.com,
        surenb@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com
Subject: [PATCH v2 2/3] binder: use EINTR for interrupted wait for work
Date:   Thu, 11 Mar 2021 10:46:28 -0800
Message-Id: <20210311184629.589725-3-dualli@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210311184629.589725-1-dualli@chromium.org>
References: <20210311184629.589725-1-dualli@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Ballesio <balejs@google.com>

when interrupted by a signal, binder_wait_for_work currently returns
-ERESTARTSYS. This error code isn't propagated to user space, but a way
to handle interruption due to signals must be provided to code using
this API.

Replace this instance of -ERESTARTSYS with -EINTR, which is propagated
to user space.

Test: built, booted, interrupted a worker thread within
binder_wait_for_work
Signed-off-by: Marco Ballesio <balejs@google.com>
Signed-off-by: Li Li <dualli@google.com>
---
 drivers/android/binder.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 76ea558df03e..38bbf9a4ce99 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3712,7 +3712,7 @@ static int binder_wait_for_work(struct binder_thread *thread,
 		binder_inner_proc_lock(proc);
 		list_del_init(&thread->waiting_thread_node);
 		if (signal_pending(current)) {
-			ret = -ERESTARTSYS;
+			ret = -EINTR;
 			break;
 		}
 	}
@@ -4855,7 +4855,7 @@ static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	if (thread)
 		thread->looper_need_return = false;
 	wait_event_interruptible(binder_user_error_wait, binder_stop_on_user_error < 2);
-	if (ret && ret != -ERESTARTSYS)
+	if (ret && ret != -EINTR)
 		pr_info("%d:%d ioctl %x %lx returned %d\n", proc->pid, current->pid, cmd, arg, ret);
 err_unlocked:
 	trace_binder_ioctl_done(ret);
-- 
2.31.0.rc2.261.g7f71774620-goog

