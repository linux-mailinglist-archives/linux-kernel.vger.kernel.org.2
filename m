Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8BC334BF8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 23:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbhCJWxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 17:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbhCJWwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 17:52:55 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870F6C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 14:52:55 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id s21so2456829pjq.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 14:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iTKo6HZiIiKMPWVYnqQ+StOirdxcAweuDP50gHSdDRk=;
        b=SxZMp6iHyZnLOyFo3Fik1VAtV8NLGHmEcwPu6nAt6UaLHzpYk6sDWcgkkZhkqKifI8
         tPdXwwpMalBM3LCaDT2FNoi1J6Ap+FKWOILbBbcV/5u6CBVhleifhrwAJk6fPyBZOezq
         z9gpBEIYFlYzcf+OHJ09L/qK5VZbyXqcg0HbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iTKo6HZiIiKMPWVYnqQ+StOirdxcAweuDP50gHSdDRk=;
        b=VHsTm5mZOvp4DWPn0ggoqTW+U5T+3iEyw/DrxpRvA717I5tQLtzQ9lFtpzfALGv3jI
         hFyaAD46bWN8b5a7HZfF3M/HQROq+ZmwJxfouogmvlWl/RUWZhMcJ5tWcwlFKMRS4O78
         +a2uQDe+h92LQ8h+pAk8vHQKYVKwwgI+ZOSvqsbDdgufE5HEeveKkNiwU4i4F2tPMHhU
         QcjqZ7+iOHa2F3RIT85W07c2Ff2412pSYcY8tcT4cVKuLV+OalMUM5F2k6Jfd/1KisZC
         hccbcrEuO7JwDD4odQiM1IA5Zd91DNbx1j6MYO+o/uJcDg1IQH9pbDY2Rt+0UFBR7Zo4
         IFKg==
X-Gm-Message-State: AOAM530CajJYUx9I0o7SA4/pMehjnDvamEOswXgl5x6Ys3anWg0Ju0AE
        RGQRDWrGE/y5MEFZVbE3uyuLCw==
X-Google-Smtp-Source: ABdhPJzJ0DKKTbp9c7zt2ypeiyBrwcYy6C8umgRUteONybNYH/bci+HwKOG151K3C55GxbUcCewVkg==
X-Received: by 2002:a17:902:7407:b029:e4:9b2c:528b with SMTP id g7-20020a1709027407b02900e49b2c528bmr5293132pll.6.1615416775168;
        Wed, 10 Mar 2021 14:52:55 -0800 (PST)
Received: from li-cloudtop.c.googlers.com.com (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id t22sm353384pjo.45.2021.03.10.14.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 14:52:54 -0800 (PST)
From:   Li Li <dualli@chromium.org>
To:     dualli@google.com, tkjos@google.com, gregkh@linuxfoundation.org,
        christian@brauner.io, arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com, hridya@google.com,
        surenb@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com
Subject: [PATCH v1 2/3] binder: use EINTR for interrupted wait for work
Date:   Wed, 10 Mar 2021 14:52:50 -0800
Message-Id: <20210310225251.2577580-3-dualli@chromium.org>
X-Mailer: git-send-email 2.31.0.rc1.246.gcd05c9c855-goog
In-Reply-To: <20210310225251.2577580-1-dualli@chromium.org>
References: <20210310225251.2577580-1-dualli@chromium.org>
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
index 9ec3ba038652..34c3e430a270 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3710,7 +3710,7 @@ static int binder_wait_for_work(struct binder_thread *thread,
 		binder_inner_proc_lock(proc);
 		list_del_init(&thread->waiting_thread_node);
 		if (signal_pending(current)) {
-			ret = -ERESTARTSYS;
+			ret = -EINTR;
 			break;
 		}
 	}
@@ -4851,7 +4851,7 @@ static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	if (thread)
 		thread->looper_need_return = false;
 	wait_event_interruptible(binder_user_error_wait, binder_stop_on_user_error < 2);
-	if (ret && ret != -ERESTARTSYS)
+	if (ret && ret != -EINTR)
 		pr_info("%d:%d ioctl %x %lx returned %d\n", proc->pid, current->pid, cmd, arg, ret);
 err_unlocked:
 	trace_binder_ioctl_done(ret);
-- 
2.31.0.rc1.246.gcd05c9c855-goog

