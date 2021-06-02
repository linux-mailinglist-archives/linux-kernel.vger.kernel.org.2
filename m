Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB77398FF2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 18:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhFBQai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 12:30:38 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:44019 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhFBQah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 12:30:37 -0400
Received: by mail-lj1-f181.google.com with SMTP id w15so3324716ljo.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 09:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2zl14KJtnHBMJGbvmOb00o5AylAgishMt24fY3YGZ1U=;
        b=I0ITGUCwWVLVPeXvF60xKf9ew55SSejiWzxO8oSBZHQZzyUR4gmdcxtHgbyxacGfoS
         50WF2rxRIKs5sKhZiOlI07bDlccNuGS2ylFNEV/M4ZqW9C21P2dl1961UYKNqBV75us2
         arFhSeFXzLjsrtMTugrhG/Ux27CGXXatwNQsddoHpf3eOj9yTR1w7PEjzCS2ZqQBqnyQ
         eyB12I6PClj1QN/+Mcgv9fX/1RH08KRN2BvRw/t7+6Q/vA8t/2EN+Nq3/QAcsczM3aUk
         5n9rwKxMsxTYS5sV+S66W8Hrf4IPsJ/2RNNuk2Q4VBPMi8ifSXj7bZy3snSsHFNsNBcC
         z0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2zl14KJtnHBMJGbvmOb00o5AylAgishMt24fY3YGZ1U=;
        b=S5cY7BxPi7qO7OwYs/pSKRT6N4oUmRdMW51UK0NvPu9pDkslsxHGcaFViyeMmxQ6u7
         bSRhkZvAwK+qQ/HSUG8KBhRJ32mgrKBOqxegBstMxtUF8wEnlwu4tL6686XxmJcTgWqG
         LyDMwhdXbjCaq0QIzZPgJBt1qMHGHjyy6+zCfDp5KbOmyzp1noF35HI+SbdS1R0R5KX9
         kRUqNe8mVqjdurvgfeea9j8Qz06J/Ba6arWY6HN9HwFuC9b95Q8FIAG39wRxVoQJLbOW
         QeCnAFCScjDf97gY7sVb+/yeBDfi98GvcY/SS8NjDuRDQfvHDSPoRNTM8QZ1W3cy0fTY
         eK8g==
X-Gm-Message-State: AOAM530Luz8EaVeflgXTwjjfDvT8qc4mQkTYlcxvO5Plykueo8th3bwO
        w1zdhz6Z7oKVreBgbS3gZ4M=
X-Google-Smtp-Source: ABdhPJwpIkq0hBHMEmNSB/yFWxWf4uayQP+s8arPaYWp53yhH3URV8uMCwgTG2Vyd7ZUqhoBZf9R0w==
X-Received: by 2002:a2e:2d11:: with SMTP id t17mr25330956ljt.56.1622651256972;
        Wed, 02 Jun 2021 09:27:36 -0700 (PDT)
Received: from HyperiorArchMachine.bb.dnainternet.fi (dcx7x4ycc2b7s--vdqzfy-3.rev.dnainternet.fi. [2001:14ba:14f7:3c00:42b0:76ff:fe23:6d08])
        by smtp.gmail.com with ESMTPSA id i21sm37274lfc.65.2021.06.02.09.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 09:27:36 -0700 (PDT)
From:   Jarmo Tiitto <jarmo.tiitto@gmail.com>
To:     Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <wcw@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Cc:     Jarmo Tiitto <jarmo.tiitto@gmail.com>, morbo@google.com
Subject: [PATCH 1/1] pgo: Fix sleep in atomic section in prf_open()
Date:   Wed,  2 Jun 2021 19:26:40 +0300
Message-Id: <20210602162640.170752-1-jarmo.tiitto@gmail.com>
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

This patch avoids holding the prf_lock() while calling
vzalloc(). Problem with that is prf_buffer_size()
*must* be called with prf_lock() held and the buffer
size may change while we call vzalloc()

So first get buffer size, release the lock and allocate.
Then re-lock and call prf_serialize() that now checks if
the buffer is big enough. If not, the code loops.

Signed-off-by: Jarmo Tiitto <jarmo.tiitto@gmail.com>
---
 kernel/pgo/fs.c | 45 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/kernel/pgo/fs.c b/kernel/pgo/fs.c
index ef985159dad3..e8ac07637423 100644
--- a/kernel/pgo/fs.c
+++ b/kernel/pgo/fs.c
@@ -227,16 +227,15 @@ static unsigned long prf_buffer_size(void)
  * Serialize the profiling data into a format LLVM's tools can understand.
  * Note: caller *must* hold pgo_lock.
  */
-static int prf_serialize(struct prf_private_data *p)
+static int prf_serialize(struct prf_private_data *p, unsigned long *buf_size)
 {
 	int err = 0;
 	void *buffer;
 
-	p->size = prf_buffer_size();
-	p->buffer = vzalloc(p->size);
+	*buf_size = prf_buffer_size();
 
-	if (!p->buffer) {
-		err = -ENOMEM;
+	if (p->size < *bufsize) {
+		err = -EAGAIN;
 		goto out;
 	}
 
@@ -259,6 +258,7 @@ static int prf_open(struct inode *inode, struct file *file)
 {
 	struct prf_private_data *data;
 	unsigned long flags;
+	unsigned long buf_size;
 	int err;
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
@@ -267,14 +267,39 @@ static int prf_open(struct inode *inode, struct file *file)
 		goto out;
 	}
 
+	/* note: vzalloc() can be used in atomic section.
+	 * However to get the buffer size prf_lock() *must*
+	 * be taken. So take lock, get buffer size, release
+	 * the lock and allocate.
+	 * prf_serialize() then checks if buffer has enough space.
+	 */
 	flags = prf_lock();
+	buf_size = prf_buffer_size();
 
-	err = prf_serialize(data);
-	if (unlikely(err)) {
-		kfree(data);
-		goto out_unlock;
-	}
+	do {
+		prf_unlock(flags);
+
+		/* resize buffer */
+		if (data->size < buf_size && data->buffer) {
+			vfree(data->buffer);
+			data->buffer = NULL;
+		}
+
+		if (!data->buffer) {
+			data->size = buf_size;
+			data->buffer = vzalloc(data->size);
+
+			if (!data->buffer) {
+				err = -ENOMEM;
+				kfree(data);
+				goto out;
+			}
+		}
+		/* try serialize */
+		flags = prf_lock();
+	} while (prf_serialize(data, &buf_size));
 
+	data->size = buf_size;
 	file->private_data = data;
 
 out_unlock:

base-commit: e1af496cbe9b4517428601a4e44fee3602dd3c15
prerequisite-patch-id: fccc1bd89bbd33af13a4ce9bc3c913e6e3cdecee
prerequisite-patch-id: a2e53c0b44ad39c78ed7bc7aad40d133548a13b5
prerequisite-patch-id: 12f0e468a3d0ff12c7f5bc640f213be3b5dd261b
prerequisite-patch-id: 707b836b1969958b5131dfa1b9f044eae5f4a76a
-- 
2.31.1

