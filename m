Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885DB39D791
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 10:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhFGImV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 04:42:21 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:39754 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhFGImU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 04:42:20 -0400
Received: by mail-lf1-f41.google.com with SMTP id p17so24149413lfc.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 01:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=23fli3JLo9FlGzs0nLGuTkx8ubyTMyqY3LmXa7zU2Yg=;
        b=BUYy7+bPIC5JB6RIeym46q5zz2rnzOBGfrOjPTrZxTXm2ViCN/dqkHW9ApPEc5akb1
         oYeHfz05uHj15Gjvd+MVCZMRK/vUpb55Rt0amJ6GrzoacISQKJk8WLdgRYLhiupFtR3l
         Vf6gFERiDjsbfJ0YB1LNaAJdo5C+W8tIITyc+EFY36Jv7WSqZQ75UoEy31Si8P0Z22qo
         cIfI7RS9k05fj+a4Jo6fRqLLpinin8qMzBpxJjw/0pZPLEDT6M/vl0z4atAdoTc5J/wl
         Gn4SB+yMz4XqCwnMFGci9ye5shFJbhT6hyXZ7s8xHcsiE1SoPIaki6LUVDtN+pUClczU
         Uq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=23fli3JLo9FlGzs0nLGuTkx8ubyTMyqY3LmXa7zU2Yg=;
        b=IWkcerglS6+Fa7/7XpMW2Jy8iNknK8qm1nWoAQ6hFcGQtz79JwMPc4ZsJLhVAK/+km
         tY3bH0BTHvhfQPiKMomEKPnl4kaPU2BrpIUHPro+EtJnk3X0qRmDUVNK5dLdX+Q4s1dK
         3htLDtVZ5u71HJH7+v8Q9cN2yzyfy0fiqur3NLKR+tJ7nSAPskqdHRCutavpvvOXdFNs
         wI16G5b5eymNR9zdYwsNU0RCr4+k5CV52Vxz/j8Rdo9M47wlcrhvAyki0njDAgd952h6
         nY/upPwIzXFUrQvQLDR1CRtmbb7KfjIFVhyykghsdr9eysqvd2NhcyfaQK8cR/EGgxfE
         Q9Zg==
X-Gm-Message-State: AOAM533uxPXrwpvoFRs2yzJkYKBysQq0Y63G1BQpuke/EElpuhSctF7x
        aOGlstep5YHpD21ZdjLW7QA=
X-Google-Smtp-Source: ABdhPJyRLZqOBZTg0tai812DXugLBDp1it9DyPhnh8sfm+ssL1g7/eKKB6iXNJ7Ls/I6ANcXJMAVdQ==
X-Received: by 2002:a05:6512:374b:: with SMTP id a11mr10947922lfs.377.1623055168235;
        Mon, 07 Jun 2021 01:39:28 -0700 (PDT)
Received: from hyperiorarchmachine.localnet (dcx7x4ycc2b7s--vdqzfy-3.rev.dnainternet.fi. [2001:14ba:14f7:3c00:42b0:76ff:fe23:6d08])
        by smtp.gmail.com with ESMTPSA id a24sm1409271lfi.272.2021.06.07.01.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 01:39:27 -0700 (PDT)
From:   jarmo.tiitto@gmail.com
To:     Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <wcw@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Cc:     Jarmo Tiitto <jarmo.tiitto@gmail.com>, morbo@google.com
Subject: [PATCH v3 1/1] pgo: Fix sleep in atomic section in prf_open() v3
Date:   Mon, 07 Jun 2021 11:39:26 +0300
Message-ID: <7663387.FLTpLEsnjC@hyperiorarchmachine>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In prf_open() the required buffer size can be so large that
vzalloc() may sleep thus triggering bug:

======
 BUG: sleeping function called from invalid context at include/linux/sched/
mm.h:201
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
Note: I re-sended this email since it looked like it was lost.
v3: Go back to the loop solution.
    Explained why prf_buffer_size() needs pgo_lock.
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
@@ -213,6 +214,7 @@ static inline unsigned long prf_get_padding(unsigned long 
size)
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
 
@@ -259,27 +265,53 @@ static int prf_open(struct inode *inode, struct file 
*file)
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




