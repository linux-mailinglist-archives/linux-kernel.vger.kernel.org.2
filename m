Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8A739A510
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 17:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhFCP4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 11:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhFCP40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 11:56:26 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04C5C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 08:54:27 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id w15so7725682ljo.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 08:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KnUxfFc49U1kaTX0xn6lq4EXnbOa1XnWH3SflMbe0J0=;
        b=QXKKkyGMMu+GZVJ73OGf9WXp6o4asES7jH+vvLnZsa7hB5TrvgK4gDk17Jos8H6BBJ
         92lYztrSblt6SBQWB4xI4NqTHbG+H5UYzrTsoyNDe7upeAnw8t0CAZ4b54e7LUyC/d2U
         yIbnNLkPi1cL96b9jSaaqXvOMatOPUTS0cc1dHgatknnWV+XHcDl/ALnH8gk4WCbhKVG
         9kcsvVOqpoF0aeyMJWfI7Q2vOoyPCHgS0uw8etz7Yq4juAT5aQgv+/Ywu9IG0MiJK8Je
         UuXgpmD91YtxhVTQsH/RwyCqrBbxv+Sut/hFCCnAp8tU1U7e/qf0Ke/wfG351VhKnAwR
         DRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KnUxfFc49U1kaTX0xn6lq4EXnbOa1XnWH3SflMbe0J0=;
        b=QTQ8BYtdA5pMDRJ+CWo3cNoml4cwPWAWDghWmCAJFlUdxTq3ga9Gf0L8L8hP+Z30Df
         jmvZq/eL/DKYoigjXmw5kC9Fg6vODcijWKhH+G78ADL8jrrQPctikWbe32I5dBQQ9mqF
         L5oSGb0OJLEvvIA9cx1Q+kP7mFnyIhgw4eI2FuUA8uXXtOnQvsKI9Pzpc2W/BSU9WVYy
         PG3RbDDS/BDxpdxuA/xi1h5SYjnjxhd13d3yZxCrIqqGYwMybcKNkpbMTFkrCk4lzlrg
         Lt7N7Gbipbqk/gnzEzOGmBdOZh6IbziSQfa3KjYN+Ur4KbQ7G8jQe0/KjBpJVDdKaagS
         rLww==
X-Gm-Message-State: AOAM530POJLjdqp42F9KLEKYrG9Od/H2oJZDcRZhAnel8dx93rGxwTP7
        1qEZWnZpBQnYrsnGFQ6Reoc=
X-Google-Smtp-Source: ABdhPJw6ql5YqT4qqLEeeUQpckJoVIJmEGAZWi30Y5kgGMRh3n12ueFCjClKbkiML+hGidTojlzamA==
X-Received: by 2002:a05:651c:50f:: with SMTP id o15mr57865ljp.452.1622735666031;
        Thu, 03 Jun 2021 08:54:26 -0700 (PDT)
Received: from HyperiorArchMachine.bb.dnainternet.fi (dcx7x4yb9bh06yk5jm2qt-3.rev.dnainternet.fi. [2001:14ba:14f7:3c00:3d09:bda0:2327:559b])
        by smtp.gmail.com with ESMTPSA id a20sm401857ljn.94.2021.06.03.08.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 08:54:25 -0700 (PDT)
From:   Jarmo Tiitto <jarmo.tiitto@gmail.com>
To:     Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <wcw@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Cc:     Jarmo Tiitto <jarmo.tiitto@gmail.com>, morbo@google.com
Subject: [PATCH v2 1/1] pgo: Fix sleep in atomic section in prf_open()
Date:   Thu,  3 Jun 2021 18:53:17 +0300
Message-Id: <20210603155318.46346-1-jarmo.tiitto@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In prf_open() the required buffer size can be so large that
vzalloc() may sleep thus triggering bug:

======
 BUG: sleeping function called from invalid context at include/linux/sched/mm.h:201
 in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 337, name: cat
 CPU: 1 PID: 337 Comm: cat Not tainted 5.13.0-rc2-24-hack+ #154
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
 Call Trace:
  dump_stack+0xc7/0x134
  ___might_sleep+0x177/0x190
  __might_sleep+0x5a/0x90
  kmem_cache_alloc_node_trace+0x6b/0x3a0
  ? __get_vm_area_node+0xcd/0x1b0
  ? dput+0x283/0x300
  __get_vm_area_node+0xcd/0x1b0
  __vmalloc_node_range+0x7b/0x420
  ? prf_open+0x1da/0x580
  ? prf_open+0x32/0x580
  ? __llvm_profile_instrument_memop+0x36/0x50
  vzalloc+0x54/0x60
  ? prf_open+0x1da/0x580
  prf_open+0x1da/0x580
  full_proxy_open+0x211/0x370
  ....
======

Since we can't vzalloc while holding pgo_lock,
split the code into steps:
* First get buffer size via prf_buffer_size()
  and release the lock.
* Round up to the page size and allocate the buffer.
* Finally re-acquire the pgo_lock and call prf_serialize().
  prf_serialize() will now check if the buffer is large enough
  and returns -EAGAIN if it is not.

New in this v2 patch:
The -EAGAIN case was determined to be such rare event that
running following in a loop:

$cat /sys/kernel/debug/pgo/vmlinux.profraw > vmlinux.profdata;

Didn't trigger it, and I don't know if it ever may occur at all.

Signed-off-by: Jarmo Tiitto <jarmo.tiitto@gmail.com>
---
 kernel/pgo/fs.c | 52 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 38 insertions(+), 14 deletions(-)

diff --git a/kernel/pgo/fs.c b/kernel/pgo/fs.c
index ef985159dad3..9afd6f001a1b 100644
--- a/kernel/pgo/fs.c
+++ b/kernel/pgo/fs.c
@@ -24,13 +24,14 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+#include <linux/mm.h>
 #include "pgo.h"
 
 static struct dentry *directory;
 
 struct prf_private_data {
 	void *buffer;
-	unsigned long size;
+	size_t size;
 };
 
 /*
@@ -213,6 +214,7 @@ static inline unsigned long prf_get_padding(unsigned long size)
 	return 7 & (sizeof(u64) - size % sizeof(u64));
 }
 
+/* Note: caller *must* hold pgo_lock */
 static unsigned long prf_buffer_size(void)
 {
 	return sizeof(struct llvm_prf_header) +
@@ -225,18 +227,21 @@ static unsigned long prf_buffer_size(void)
 
 /*
  * Serialize the profiling data into a format LLVM's tools can understand.
+ * Note: p->buffer must point into vzalloc()'d
+ * area of at least prf_buffer_size() in size.
  * Note: caller *must* hold pgo_lock.
  */
-static int prf_serialize(struct prf_private_data *p)
+static int prf_serialize(struct prf_private_data *p, size_t buf_size)
 {
 	int err = 0;
 	void *buffer;
 
+	/* get buffer size, again. */
 	p->size = prf_buffer_size();
-	p->buffer = vzalloc(p->size);
 
-	if (!p->buffer) {
-		err = -ENOMEM;
+	/* check for unlikely overflow. */
+	if (p->size > buf_size) {
+		err = -EAGAIN;
 		goto out;
 	}
 
@@ -259,27 +264,46 @@ static int prf_open(struct inode *inode, struct file *file)
 {
 	struct prf_private_data *data;
 	unsigned long flags;
-	int err;
+	size_t buf_size;
+	int err = 0;
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data) {
 		err = -ENOMEM;
-		goto out;
+		goto out_free;
 	}
 
+	/* get buffer size */
 	flags = prf_lock();
+	buf_size = prf_buffer_size();
+	prf_unlock(flags);
 
-	err = prf_serialize(data);
-	if (unlikely(err)) {
-		kfree(data);
-		goto out_unlock;
+	/* allocate, round up to page size. */
+	buf_size = PAGE_ALIGN(buf_size);
+	data->buffer = vzalloc(buf_size);
+
+	if (!data->buffer) {
+		err = -ENOMEM;
+		goto out_free;
 	}
 
+	/* try serialize and get actual
+	 * data length in data->size
+	 */
+	flags = prf_lock();
+	err = prf_serialize(data, buf_size);
+	prf_unlock(flags);
+
+	if (err)
+		goto out_free;
+
 	file->private_data = data;
+	return 0;
 
-out_unlock:
-	prf_unlock(flags);
-out:
+out_free:
+	if (data)
+		vfree(data->buffer);
+	kfree(data);
 	return err;
 }
 

base-commit: 5d0cda65918279ada060417c5fecb7e86ccb3def
-- 
2.31.1

