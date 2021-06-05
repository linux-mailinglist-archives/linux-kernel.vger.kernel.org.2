Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37FE939CA86
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 20:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhFESg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 14:36:28 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:40545 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbhFESg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 14:36:26 -0400
Received: by mail-lj1-f181.google.com with SMTP id x14so1694190ljp.7
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 11:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pd7tf3i2pnO2Ok9Tv/vp503TcTB5cBTB11RLxlS7Uv8=;
        b=SHZMwxLgxSJrLhj66EbwzrZlSQgqZmh8DV0H98sw7nObl4e1lQe8NbHfBBSPi1y7BQ
         vft3kUPa7oVom64QBDktptjHWg8VEHVFDZeuGDpXlPFeSYUGlcbutqDsyg37xroTvWki
         7Bxt/4dbajKcOz6t6/OtIfLIOWiyxJilNRN3pdih5c/YTQ7QudPQIXzVqjHqWOcVUhaf
         OkHXZB/QcblN8Yvqu22W203NUCyo3mf/zlwDlvziQyKvgjtXbEIvj8rE9Dsw5A/zkj62
         Rb95n18ghx3QCwnr1pOZkxJ2ApXxbG+lfOmNtGDrBMpQNBal6mmTE47sjAT4aE7VxMnX
         3cfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pd7tf3i2pnO2Ok9Tv/vp503TcTB5cBTB11RLxlS7Uv8=;
        b=pCQd3+cZVSL+TIaNLvfmHU4Tl88yHhHHb+uTgcNJW54Ox4B0wdkRJQJN/8GhxWZNAM
         DhtIo3scZQ5gzwcrl3Da/aCeBQqkWTDY+qJ1HzPCW5NPQU4bjaf0SmZjA/7jsI6e8uGY
         o9zXLlt4THnx7C6+6vKwQ0mzPQhnvKrYIUyGY19IK8RtEhoX/X1IIN4zbLfTjgbdH1Mw
         l6XZLOp9YZ+FEc4XK2PUTOL1JiWapISmgLN7lVfsUxTv1fIeYWfG5+o2zmW2/IJ0nwj4
         /A3INZtZYDKdzl3oAVzdQcbaz/crjXkt9hx2s8ogkGiiD4NxWGERAYbku5jnCYlrF/qB
         Zoqg==
X-Gm-Message-State: AOAM532aexEzuFGivI3DDjg/qvO1oZsjTJDONAhb09VLojAxwaLzUl/Q
        NZ3vhJdAuYYO9Jvgx4rtrig=
X-Google-Smtp-Source: ABdhPJzAchRqFbX7wzaaWwsUM4bqwsi0b2uMf5D/Ut0ZYEx7mac8euPkXdz+PH6guEB+finZ2WSFuw==
X-Received: by 2002:a2e:2c0a:: with SMTP id s10mr8116155ljs.171.1622918017098;
        Sat, 05 Jun 2021 11:33:37 -0700 (PDT)
Received: from HyperiorArchMachine.bb.dnainternet.fi (dcx7x4ybp09ts--z5-7ry-3.rev.dnainternet.fi. [2001:14ba:14f7:3c00:2cf7:60ff:fe99:fedc])
        by smtp.gmail.com with ESMTPSA id r28sm1142441ljn.96.2021.06.05.11.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 11:33:36 -0700 (PDT)
From:   Jarmo Tiitto <jarmo.tiitto@gmail.com>
To:     Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <wcw@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Cc:     Jarmo Tiitto <jarmo.tiitto@gmail.com>, morbo@google.com
Subject: [PATCH v3 1/1] pgo: Fix sleep in atomic section in prf_open() v3
Date:   Sat,  5 Jun 2021 21:31:29 +0300
Message-Id: <20210605183128.129614-1-jarmo.tiitto@gmail.com>
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
* First get initial buffer size via prf_buffer_size()
  and release the lock.

* Round up to the page size and allocate the buffer.

* Finally re-acquire the pgo_lock and call prf_serialize().
  prf_serialize() will now check if the buffer is large enough
  and returns -EAGAIN if it is not.

Note that prf_buffer_size() walks linked lists that
are modified by __llvm_profile_instrument_target(),
so we have to "guess" the buffer size ahead of time.
prf_serialize() will then return the actual data length.

Signed-off-by: Jarmo Tiitto <jarmo.tiitto@gmail.com>
---
v3: Go back the loop solution.
    Explained why prf_buffer_size() need pgo_lock.
    Cleanup the code a bit.
v2: Loopless attempt.
---
 kernel/pgo/fs.c | 62 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 47 insertions(+), 15 deletions(-)

diff --git a/kernel/pgo/fs.c b/kernel/pgo/fs.c
index ef985159dad3..0ce0dc9caf7a 100644
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
@@ -225,18 +227,22 @@ static unsigned long prf_buffer_size(void)
 
 /*
  * Serialize the profiling data into a format LLVM's tools can understand.
+ * Returns actual buffer size in p->size.
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
 
@@ -259,27 +265,53 @@ static int prf_open(struct inode *inode, struct file *file)
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
 
+	/* get initial buffer size */
 	flags = prf_lock();
+	data->size = prf_buffer_size();
+	prf_unlock(flags);
 
-	err = prf_serialize(data);
-	if (unlikely(err)) {
-		kfree(data);
-		goto out_unlock;
-	}
+	do {
+		if (data->buffer)
+			vfree(data->buffer);
+
+		/* allocate, round up to page size. */
+		buf_size = PAGE_ALIGN(data->size);
+		data->buffer = vzalloc(buf_size);
+
+		if (!data->buffer) {
+			err = -ENOMEM;
+			goto out_free;
+		}
+
+		/*
+		 * try serialize and get actual
+		 * data length in data->size
+		 */
+		flags = prf_lock();
+		err = prf_serialize(data, buf_size);
+		prf_unlock(flags);
+		/* in unlikely case, try again. */
+	} while (err == -EAGAIN);
+
+	if (err)
+		goto out_free;
 
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
 

base-commit: 46773f32ddf1d49a84eca5f19126d6dfaf08e8d9
-- 
2.31.1

