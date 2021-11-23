Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF449459FCC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 11:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235337AbhKWKOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 05:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbhKWKOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 05:14:15 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2059DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 02:11:08 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id z6so15452515plk.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 02:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=BYTCB0J2pYZOOT9xnTXHPIjDed48AnjZ+6z/s4awgP8=;
        b=BgwpP+KrwARr7qkbPpgwQgwZhLHt2ZtYSS/Mic73FvftvEELDRzyGfJZUnoEGKvSp6
         IJUgg7VS0bvKeTz3QesNLB0zNm/sIrNf17GXJuNSj1Mk4meFmV3HO2HU4z6TYD8a04MQ
         b+AHi77FyCpBa7kRdQRDZCKsDz7FTeqpxACMjAYbxrs0bDW51AUf8q0zkJ9OzYaOuVIc
         r5Xfr+xNPDa0VmwiqxB0w3m2BAmOSFvuwjsDzNuP4bg1OobAyZB30GqaXCj0NfSgb0Fd
         P69eJbEafoiB7fYGIzFpu6xoz0JA2u/DR3l59Ka9Cja02xYODpW/FwJM+1UDspmSoEu6
         07GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BYTCB0J2pYZOOT9xnTXHPIjDed48AnjZ+6z/s4awgP8=;
        b=aUioNJOz+3EBTZdKczV6pYnsCab/psJgILPx5ECHu0HD9VvxT6iDrhUXoasA0yd9q0
         MuZrNwbipeeed1PeCnCihFVSEVtX8sMWHhu71fX2mvdWtDs2Ssynkj8872HeSj9ttc3D
         5CHaYNy7wfDJNcDzQBgA4RpeRngOYcSp74hoGpajn/xTp77LL3c8unzkDMZHjyAh3SNh
         ssxgoonHDkOSDMD6Or7P3o8XTobuZBm4hN7SQqEQiyRiZlK/GOqrMsolxQpYSnHanXkE
         BB/7bHhLfBgmj3PQinp/6sM2fepuY5Om1AK6y2laBRXfu7/6ZYDQ5Tiqb1b74XP65Wxl
         zQkw==
X-Gm-Message-State: AOAM530KJx5iL9PfVDmzrSHJc281qShaEos4az/Ddl2KOlYXKZ2s5EWA
        eCZt4ZNS+1BYOXdy/DL+VheXs7mQ81M=
X-Google-Smtp-Source: ABdhPJzFA79YwV1GqinsiCdLvuyo87KVVX79ald5kbunDzF8QV2MobJ4xPv76Rzk9uUez/yvvBeffQ==
X-Received: by 2002:a17:90a:6a82:: with SMTP id u2mr1385918pjj.105.1637662267485;
        Tue, 23 Nov 2021 02:11:07 -0800 (PST)
Received: from localhost.localdomain ([117.254.32.196])
        by smtp.googlemail.com with ESMTPSA id y8sm12421689pfi.56.2021.11.23.02.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 02:11:07 -0800 (PST)
From:   Ajith P V <ajithpv.linux@gmail.com>
To:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, christian@brauner.io,
        hridya@google.com, surenb@google.com
Cc:     linux-kernel@vger.kernel.org, Ajith P V <ajithpv.linux@gmail.com>
Subject: [PATCH] binder: remove all warning messages
Date:   Tue, 23 Nov 2021 15:39:34 +0530
Message-Id: <20211123100934.13189-1-ajithpv.linux@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all warning messages found by checkpatch.pl script

Signed-off-by: Ajith P V <ajithpv.linux@gmail.com>
---
 drivers/android/binder.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 49fb74196d02..a58cfd39f3ea 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -1933,7 +1933,7 @@ static void binder_transaction_buffer_release(struct binder_proc *proc,
 		case BINDER_TYPE_FD: {
 			/*
 			 * No need to close the file here since user-space
-			 * closes it for for successfully delivered
+			 * closes it for successfully delivered
 			 * transactions. For transactions that weren't
 			 * delivered, the new fd was never allocated so
 			 * there is no need to close and the fput on the
@@ -4424,10 +4424,12 @@ static int binder_thread_release(struct binder_proc *proc,
 	/*
 	 * If this thread used poll, make sure we remove the waitqueue
 	 * from any epoll data structures holding it with POLLFREE.
-	 * waitqueue_active() is safe to use here because we're holding
-	 * the inner lock.
 	 */
 	if ((thread->looper & BINDER_LOOPER_STATE_POLL) &&
+	    /*
+	     * waitqueue_active() is safe to use here because we're holding
+	     * the inner lock.
+	     */
 	    waitqueue_active(&thread->wait)) {
 		wake_up_poll(&thread->wait, EPOLLHUP | POLLFREE);
 	}
@@ -4436,7 +4438,7 @@ static int binder_thread_release(struct binder_proc *proc,
 
 	/*
 	 * This is needed to avoid races between wake_up_poll() above and
-	 * and ep_remove_waitqueue() called for other reasons (eg the epoll file
+	 * ep_remove_waitqueue() called for other reasons (eg the epoll file
 	 * descriptor being closed); ep_remove_waitqueue() holds an RCU read
 	 * lock, so we can be sure it's done after calling synchronize_rcu().
 	 */
@@ -4752,8 +4754,9 @@ static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	unsigned int size = _IOC_SIZE(cmd);
 	void __user *ubuf = (void __user *)arg;
 
-	/*pr_info("binder_ioctl: %d:%d %x %lx\n",
-			proc->pid, current->pid, cmd, arg);*/
+	/* pr_info("binder_ioctl: %d:%d %x %lx\n",
+	 *		proc->pid, current->pid, cmd, arg);
+	 */
 
 	binder_selftest_alloc(&proc->alloc);
 
@@ -5982,8 +5985,8 @@ static int __init binder_init(void)
 	if (!IS_ENABLED(CONFIG_ANDROID_BINDERFS) &&
 	    strcmp(binder_devices_param, "") != 0) {
 		/*
-		* Copy the module_parameter string, because we don't want to
-		* tokenize it in-place.
+		 * Copy the module_parameter string, because we don't want to
+		 * tokenize it in-place.
 		 */
 		device_names = kstrdup(binder_devices_param, GFP_KERNEL);
 		if (!device_names) {
-- 
2.17.1

