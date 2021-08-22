Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE373F41F0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 00:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbhHVWVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 18:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbhHVWV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 18:21:29 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7EC2C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 15:20:47 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id x10-20020a056830408a00b004f26cead745so31235617ott.10
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 15:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EX0kJLbWPO/gGvtWZrYlXdMUmieVpPmj3inuxYZYEK8=;
        b=X905vpcVix5dUgIXcsYBm48sGOvY6Q9tAbuMJ2FITzzDKkNhvDuVF1Bjpu1CsY2e4B
         ia5jh5z8Dzml8Y6oAhfulLubQTeCQk0gpgNdxvOUxbNf9eVph0fUmjZAtkqEVKzedBOB
         PRaJYB5VS1a0Lfr71gVkdZgJju8OCPzsnlctQijn8TohOgNxIl+NIq33lrVfvGfaCyNj
         0gue81LwfmJdROMdiu+D9KMp5gpcb7wNUeZtAnzZZ5XTxnqj4oOqqlK9rGJ6bRMh0E++
         SpvofwwTSa3O5fGQNKhp6Wd5pBAJgk6/1P0d9AaznKGm5pHG7V7/ctt/vgvr1z6Zq0yt
         BGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EX0kJLbWPO/gGvtWZrYlXdMUmieVpPmj3inuxYZYEK8=;
        b=uUg4zvihLuCyC2wEcFaqDulIg1P9KQ481/e97Lk/DaI31ML5v1ygOAQf7jFpvIIeni
         pcNpQqpkcpIitd1WKHzI69PkWA6s/bbSNt9yNnjaA5N+uT7znUdkoNMIoFYHrkvc4gsS
         vEj/8MkCVF6gRMpeFAhko8wuPzsXGsrBH7GnYIjiZ4fMdobpmF9AQEXoO20VheaO8Y7T
         kIR7p9TCBQniqT9i4c6NkwWcI+vtn+8wFs+V1Vn0Z90CYegHjFtrGyR8vjn2SXv4LBNR
         nSd6lTAtQYZYqM5yVsaqAoRXD2a092vno4fCiYlth+4cvgP9Hh8km6qaO5qgy1QJ9la+
         qv1A==
X-Gm-Message-State: AOAM533lzVS3DQorOu3n5nmSrAV6uKR9Wr4pwPB1c+gIL1fV7jP+BDiQ
        O9V7hnf5rmslBDkwp3vLFxE=
X-Google-Smtp-Source: ABdhPJwE15NCa8WKtdgeR3/dbe7hhgznsV40g1M14s3dtqtT45Pgz97wR93Mn+yQFFpQHuuV4Xgv3g==
X-Received: by 2002:a9d:6c48:: with SMTP id g8mr26939243otq.199.1629670847204;
        Sun, 22 Aug 2021 15:20:47 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id x198sm2964122ooa.43.2021.08.22.15.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 15:20:46 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        seanpaul@chromium.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 01/11] moduleparam: add data member to struct kernel_param
Date:   Sun, 22 Aug 2021 16:19:59 -0600
Message-Id: <20210822222009.2035788-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210822222009.2035788-1-jim.cromie@gmail.com>
References: <20210822222009.2035788-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a const void* data member to the struct, to allow attaching
private data that will be used soon by a setter method (via kp->data)
to perform more elaborate actions.

To attach the data at compile time, add new macros:

module_param_cb_data() derives from module_param_cb(), adding data
param, and latter is redefined to use former.

It calls __module_param_call_with_data(), which accepts new data param
and inits .data with it. Re-define __module_param_call() to use it.

Use of this new data member will be rare, it might be worth redoing
this as a separate/sub-type to de-bloat the base case.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v6:
. const void* data - <emil.l.velikov@gmail.com>
. better macro names s/_cbd/_cb_data/, s/_wdata/_with_data/
. more const, no cast - Willy
---
 include/linux/moduleparam.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index eed280fae433..b8871e514de5 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -78,6 +78,7 @@ struct kernel_param {
 		const struct kparam_string *str;
 		const struct kparam_array *arr;
 	};
+	const void *data;
 };
 
 extern const struct kernel_param __start___param[], __stop___param[];
@@ -175,6 +176,9 @@ struct kparam_array
 #define module_param_cb(name, ops, arg, perm)				      \
 	__module_param_call(MODULE_PARAM_PREFIX, name, ops, arg, perm, -1, 0)
 
+#define module_param_cb_data(name, ops, arg, perm, data)			\
+	__module_param_call_with_data(MODULE_PARAM_PREFIX, name, ops, arg, perm, -1, 0, data)
+
 #define module_param_cb_unsafe(name, ops, arg, perm)			      \
 	__module_param_call(MODULE_PARAM_PREFIX, name, ops, arg, perm, -1,    \
 			    KERNEL_PARAM_FL_UNSAFE)
@@ -284,14 +288,17 @@ struct kparam_array
 
 /* This is the fundamental function for registering boot/module
    parameters. */
-#define __module_param_call(prefix, name, ops, arg, perm, level, flags)	\
+#define __module_param_call(prefix, name, ops, arg, perm, level, flags) \
+	__module_param_call_with_data(prefix, name, ops, arg, perm, level, flags, NULL)
+
+#define __module_param_call_with_data(prefix, name, ops, arg, perm, level, flags, data) \
 	/* Default value instead of permissions? */			\
 	static const char __param_str_##name[] = prefix #name;		\
 	static struct kernel_param __moduleparam_const __param_##name	\
 	__used __section("__param")					\
 	__aligned(__alignof__(struct kernel_param))			\
 	= { __param_str_##name, THIS_MODULE, ops,			\
-	    VERIFY_OCTAL_PERMISSIONS(perm), level, flags, { arg } }
+	    VERIFY_OCTAL_PERMISSIONS(perm), level, flags, { arg }, data }
 
 /* Obsolete - use module_param_cb() */
 #define module_param_call(name, _set, _get, arg, perm)			\
-- 
2.31.1

