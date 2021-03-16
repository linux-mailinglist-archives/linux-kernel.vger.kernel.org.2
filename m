Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D21133CACE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 02:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbhCPBRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 21:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbhCPBQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 21:16:35 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70E6C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 18:16:34 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id lr1-20020a17090b4b81b02900ea0a3f38c1so2798005pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 18:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bhHWi0W+kgMuBFyHAFWOLLlF9YZIpVMkVfttAql0YwA=;
        b=nA8Ngu/c1mcCJm4YPMIVJna2yX4BpiIi6bGwb0rnabI0TXQ5f6gXN+bbW205dyV95R
         8qzI18FvYemqgXrKV55oQJKSt9kVUHZfD7qulTQjyAZn92HD494f0FcSIO9e5JOsF1Sv
         D3vyiUlRLZK2waVcNf24JawUkfKsHTqLxT0SE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bhHWi0W+kgMuBFyHAFWOLLlF9YZIpVMkVfttAql0YwA=;
        b=o9NxCwKyYOnHv4JqTevc20o5nCuB40KaYjYz51dNqDufJwnhOyt7TgNuoYJAQoxAv+
         uiBxKdtuVN2g87AcwDbenj3vlgjWAWObSotAFmp2xEHHO74sfl2CaKDO5jWN5w2/gVj+
         7ynWCruo1mNAHZXEpaR5bcle6J8mwg57zhCE3zjUn1mEm0scHRq87usxss+rchotypda
         EHW+Lsx+0lJLAAVZapSUfqW9FWvODyn1M8GgwJGVxBa2vdDIrGp+skt722uUWDmsVdgx
         g0twQbklNMVIxnqFHDh4B2lzh3bEvMnS6PJqXF4471YHeqhfh0EjN6Z+t7Z1O65rBaY9
         Fg3w==
X-Gm-Message-State: AOAM530qFzmk3cVd43T1noVvV8spkPPb1RVxaoBB3YSlHU/waSVDvftS
        APWwaJ4GtX+wLnffbranGoN3Eg==
X-Google-Smtp-Source: ABdhPJxt4DxjF0zu+JN7eBy057OuUI5MOVCFOD60RyC8UZHbkuRFiBfI8l6Jex+q3ydXUVTbiCuBCQ==
X-Received: by 2002:a17:90a:ce0c:: with SMTP id f12mr1993327pju.11.1615857394598;
        Mon, 15 Mar 2021 18:16:34 -0700 (PDT)
Received: from li-cloudtop.c.googlers.com.com (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id 186sm15773381pfb.143.2021.03.15.18.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 18:16:34 -0700 (PDT)
From:   Li Li <dualli@chromium.org>
To:     dualli@google.com, tkjos@google.com, gregkh@linuxfoundation.org,
        christian@brauner.io, arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com, hridya@google.com,
        surenb@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com
Subject: [PATCH v3 2/3] binder: use EINTR for interrupted wait for work
Date:   Mon, 15 Mar 2021 18:16:29 -0700
Message-Id: <20210316011630.1121213-3-dualli@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210316011630.1121213-1-dualli@chromium.org>
References: <20210316011630.1121213-1-dualli@chromium.org>
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
index b93ca53bb90f..fe16c455a76e 100644
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
@@ -4853,7 +4853,7 @@ static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
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

