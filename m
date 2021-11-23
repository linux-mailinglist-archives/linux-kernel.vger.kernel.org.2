Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5464A45AC1B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 20:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbhKWTVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 14:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhKWTU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 14:20:57 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58640C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 11:17:49 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id o4-20020a17090a3d4400b001a66f10df6cso121471pjf.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 11:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/Wu/IKe6vm9acow98kpO8yBnX9ceqcYGYutL6tcKfK0=;
        b=hmkBTACZzy2j54PF8xrGe9hwc8AR0rBojligfCQWISqUqYyPSM0IfIcQuKSPYtH14C
         2EFGTK8oph0UFdJo9R7LV8+WVJbup6DZi28Wyvj6cdufH7Dn8vlylxirAXtd3fXeDWiZ
         e7zdvq+zQWM+O0+ktc3uZ8hzsl6nwfs4N48bJdPS//pgxGqXxFw0CRIhywFO0KGL/vLh
         WJknTdo90Ccve1mvwxgKX7mkFN2mk2xHuwxs0kVb8iXyvz9mVU7jdV82Hcv1ZaMHyv0F
         Gl5Hh1ENGOK0c/vSTEs0PgyBW4mXQ8HLqXFTYN+c2pqs0ej/ikA5gvlqr44j8jEz+xlk
         hZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/Wu/IKe6vm9acow98kpO8yBnX9ceqcYGYutL6tcKfK0=;
        b=GxP3AtcNEtxOYJ1nORyTSoTgQcDZe5ujA2sjOChmYl8nckexUhrJCI68W3ym9miO6I
         VY6L7KWY7lEC7RKx0wPWNfr1VmhcSZMk7snDKbwVqDz6g+N5zPnpZ8QCV3Kke7enP1VA
         RpFEyQP4wHGfPOpgkywY6gBl8WV5ITw5vpXxiqTPkmruwGLyqZkdDsHiFF7yjmrmuYyT
         mrtGXhWc6b7RSTG/IIhU9Fm7WV7QJgYbonz8xK6yyU+IrnNrA7HBvLB8ucPTSMUzkTch
         8A7XCYI5OT69PFFllsp759JdFZiyO8hU0N6zh/DkEjT1f/vN/kuiEpF0swCgQoD6x23/
         toCg==
X-Gm-Message-State: AOAM5339Ukb1ldpRIIk4xw+uoKYGOHDZxJ6+GkaHXfqMB23tJGZSTUUC
        2c5TErGqu17GcrGHvKnUkUI/mnRxaQ==
X-Google-Smtp-Source: ABdhPJzVLB9/5VB0XxIBPaGi6wOqp+JkRmcFPzIVlssCjibjD+3ga+3scZfLoV6B5DMEWxYNl5ccwBdJuw==
X-Received: from tkjos-desktop.mtv.corp.google.com ([2620:15c:211:200:ac67:ee23:d7c5:aa3b])
 (user=tkjos job=sendgmr) by 2002:a17:90b:3810:: with SMTP id
 mq16mr6028528pjb.128.1637695068910; Tue, 23 Nov 2021 11:17:48 -0800 (PST)
Date:   Tue, 23 Nov 2021 11:17:36 -0800
In-Reply-To: <20211123191737.1296541-1-tkjos@google.com>
Message-Id: <20211123191737.1296541-3-tkjos@google.com>
Mime-Version: 1.0
References: <20211123191737.1296541-1-tkjos@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH 2/3] binder: read pre-translated fds from sender buffer
From:   Todd Kjos <tkjos@google.com>
To:     tkjos@google.com, gregkh@linuxfoundation.org, christian@brauner.io,
        arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we are no longer going to copy the pre-fixup
data from the target buffer, we need to read
pre-translated FD array information from the source
buffer.

Signed-off-by: Todd Kjos <tkjos@google.com>
---
 drivers/android/binder.c | 40 +++++++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 571d3c203557..2300fa8e09d5 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2234,15 +2234,17 @@ static int binder_translate_fd(u32 fd, binder_size_t fd_offset,
 }
 
 static int binder_translate_fd_array(struct binder_fd_array_object *fda,
+				     const void __user *u,
 				     struct binder_buffer_object *parent,
+				     struct binder_buffer_object *uparent,
 				     struct binder_transaction *t,
 				     struct binder_thread *thread,
 				     struct binder_transaction *in_reply_to)
 {
 	binder_size_t fdi, fd_buf_size;
 	binder_size_t fda_offset;
+	const void __user *ufda_base;
 	struct binder_proc *proc = thread->proc;
-	struct binder_proc *target_proc = t->to_proc;
 
 	fd_buf_size = sizeof(u32) * fda->num_fds;
 	if (fda->num_fds >= SIZE_MAX / sizeof(u32)) {
@@ -2266,7 +2268,10 @@ static int binder_translate_fd_array(struct binder_fd_array_object *fda,
 	 */
 	fda_offset = (parent->buffer - (uintptr_t)t->buffer->user_data) +
 		fda->parent_offset;
-	if (!IS_ALIGNED((unsigned long)fda_offset, sizeof(u32))) {
+	ufda_base = (void __user *)uparent->buffer + fda->parent_offset;
+
+	if (!IS_ALIGNED((unsigned long)fda_offset, sizeof(u32)) ||
+	    !IS_ALIGNED((unsigned long)ufda_base, sizeof(u32))) {
 		binder_user_error("%d:%d parent offset not aligned correctly.\n",
 				  proc->pid, thread->pid);
 		return -EINVAL;
@@ -2275,10 +2280,9 @@ static int binder_translate_fd_array(struct binder_fd_array_object *fda,
 		u32 fd;
 		int ret;
 		binder_size_t offset = fda_offset + fdi * sizeof(fd);
+		binder_size_t uoffset = fdi * sizeof(fd);
 
-		ret = binder_alloc_copy_from_buffer(&target_proc->alloc,
-						    &fd, t->buffer,
-						    offset, sizeof(fd));
+		ret = copy_from_user(&fd, ufda_base + uoffset, sizeof(fd));
 		if (!ret)
 			ret = binder_translate_fd(fd, offset, t, thread,
 						  in_reply_to);
@@ -2951,6 +2955,8 @@ static void binder_transaction(struct binder_proc *proc,
 		case BINDER_TYPE_FDA: {
 			struct binder_object ptr_object;
 			binder_size_t parent_offset;
+			struct binder_object user_object;
+			size_t user_parent_size;
 			struct binder_fd_array_object *fda =
 				to_binder_fd_array_object(hdr);
 			size_t num_valid = (buffer_offset - off_start_offset) /
@@ -2982,8 +2988,28 @@ static void binder_transaction(struct binder_proc *proc,
 				return_error_line = __LINE__;
 				goto err_bad_parent;
 			}
-			ret = binder_translate_fd_array(fda, parent, t, thread,
-							in_reply_to);
+
+			/*
+			 * We need to read the user version of the parent
+			 * object to get the original user offset
+			 */
+			user_parent_size =
+				binder_get_object(proc, user_buffer, t->buffer,
+						  parent_offset, &user_object);
+			if (user_parent_size != sizeof(user_object.bbo)) {
+				binder_user_error("%d:%d invalid ptr object size: %lld vs %lld\n",
+						  proc->pid, thread->pid,
+						  user_parent_size,
+						  sizeof(user_object.bbo));
+				return_error = BR_FAILED_REPLY;
+				return_error_param = -EINVAL;
+				return_error_line = __LINE__;
+				goto err_bad_parent;
+			}
+			ret = binder_translate_fd_array(fda, user_buffer,
+							parent,
+							&user_object.bbo, t,
+							thread, in_reply_to);
 			if (ret < 0 ||
 			    binder_alloc_copy_to_buffer(&target_proc->alloc,
 							t->buffer,
-- 
2.34.0.rc2.393.gf8c9666880-goog

