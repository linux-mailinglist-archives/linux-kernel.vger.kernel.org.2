Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD693C75F3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 19:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbhGMRw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 13:52:27 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:35495 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbhGMRw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 13:52:26 -0400
Received: by mail-pg1-f182.google.com with SMTP id v7so22282078pgl.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 10:49:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VG1FWTRYTInmEPvLXXEMu7wWoWibZcsjI/7WfQ0dzcQ=;
        b=LkOMHZ1m+vOyp05IZA72QM764ylNOqlTkGewRyAPWpCu+X8jjCfVmP013rOTEAVwIb
         LQ5trhWPJb7XluOxcWj5SZ5deIulDJt1JsJospKR0Ty3DEIhxt5ft1Ji7GjKAS13Z+DZ
         0/Dp2M1H2GqQTjiN288QUwR3IRb3WrTvimQstAqB2Sef8U9qc6PdQsZJbCQkYWtBhmmT
         OSSo6qlKadFIr4JhdVSPoOuLPBI24jWiIkiPS+KLNWlHoya9jkCkaPLBI4DPmWdnqtdd
         YDZ4ATAquP2vyZrvVztY0prXXhdYrN02WoUSSc9JL4KTf6xwti5PU8w3j0KlcHDJV6pG
         xb2w==
X-Gm-Message-State: AOAM532d8ezFEvSYbmfwWq40y/WbVqybZEH/01mxop1vwTEDHzW8mYrJ
        d5XrjL/ssqzMNpjpE0smpqbIdD8FbRQ=
X-Google-Smtp-Source: ABdhPJyt0YOkFabHeQ0cZcIojAlZ9ADe2x9PgO5Ybhkk0LnsZkL3pMB4q7IpsLMMRLzbPopGJS7s9Q==
X-Received: by 2002:aa7:818a:0:b029:309:a073:51cb with SMTP id g10-20020aa7818a0000b0290309a07351cbmr5899545pfi.40.1626198574999;
        Tue, 13 Jul 2021 10:49:34 -0700 (PDT)
Received: from bvanassche-glaptop.corp.google.com ([2620:0:1000:2004:d6d0:1357:913a:795c])
        by smtp.gmail.com with ESMTPSA id i12sm10690655pjj.9.2021.07.13.10.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 10:49:34 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Joel Becker <jlbec@evilplan.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Yanko Kaneti <yaneti@declera.com>
Subject: [PATCH] configfs: Fix the read and write iterators
Date:   Tue, 13 Jul 2021 10:49:26 -0700
Message-Id: <20210713174926.330829-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7fe1e79b59ba ("configfs: implement the .read_iter and .write_iter
methods") changed the simple_read_from_buffer() calls into copy_to_iter()
calls and the simple_write_to_buffer() calls into copy_from_iter() calls.
The simple*buffer() methods update the file offset (*ppos) but the read and
write iterators not yet. Make the read and write iterators update the file
offset (iocb->ki_pos).

This patch has been tested as follows:

 # modprobe target_core_user
 # dd if=/sys/kernel/config/target/dbroot bs=1
/var/target
12+0 records in
12+0 records out
12 bytes copied, 9.5539e-05 s, 126 kB/s

 # cd /sys/kernel/config/acpi/table
 # mkdir test
 # cd test
 # dmesg -c >/dev/null; printf 'SSDT\x8\0\0\0abcdefghijklmnopqrstuvwxyz' | dd of=aml bs=1; dmesg -c
34+0 records in
34+0 records out
34 bytes copied, 0.010627 s, 3.2 kB/s
[  261.056551] ACPI configfs: invalid table length

Reported-by: Yanko Kaneti <yaneti@declera.com>
Cc: Yanko Kaneti <yaneti@declera.com>
Fixes: 7fe1e79b59ba ("configfs: implement the .read_iter and .write_iter methods")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/configfs/file.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/fs/configfs/file.c b/fs/configfs/file.c
index 2f63bf3a7325..5a0be9985bae 100644
--- a/fs/configfs/file.c
+++ b/fs/configfs/file.c
@@ -91,7 +91,10 @@ static ssize_t configfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	}
 	pr_debug("%s: count = %zd, pos = %lld, buf = %s\n",
 		 __func__, iov_iter_count(to), iocb->ki_pos, buffer->page);
-	retval = copy_to_iter(buffer->page, buffer->count, to);
+	if (iocb->ki_pos >= buffer->count)
+		goto out;
+	retval = copy_to_iter(buffer->page + iocb->ki_pos,
+			      buffer->count - iocb->ki_pos, to);
 	iocb->ki_pos += retval;
 	if (retval == 0)
 		retval = -EFAULT;
@@ -162,7 +165,10 @@ static ssize_t configfs_bin_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		buffer->needs_read_fill = 0;
 	}
 
-	retval = copy_to_iter(buffer->bin_buffer, buffer->bin_buffer_size, to);
+	if (iocb->ki_pos >= buffer->bin_buffer_size)
+		goto out;
+	retval = copy_to_iter(buffer->bin_buffer + iocb->ki_pos,
+			      buffer->bin_buffer_size - iocb->ki_pos, to);
 	iocb->ki_pos += retval;
 	if (retval == 0)
 		retval = -EFAULT;
@@ -171,21 +177,28 @@ static ssize_t configfs_bin_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	return retval;
 }
 
-static int fill_write_buffer(struct configfs_buffer *buffer,
+/* Fill [buffer, buffer + pos) with data coming from @from. */
+static int fill_write_buffer(struct configfs_buffer *buffer, loff_t pos,
 			     struct iov_iter *from)
 {
+	loff_t to_copy;
 	int copied;
+	u8 *to;
 
 	if (!buffer->page)
 		buffer->page = (char *)__get_free_pages(GFP_KERNEL, 0);
 	if (!buffer->page)
 		return -ENOMEM;
 
-	copied = copy_from_iter(buffer->page, SIMPLE_ATTR_SIZE - 1, from);
+	to_copy = SIMPLE_ATTR_SIZE - 1 - pos;
+	if (to_copy <= 0)
+		return 0;
+	to = buffer->page + pos;
+	copied = copy_from_iter(to, to_copy, from);
 	buffer->needs_read_fill = 1;
 	/* if buf is assumed to contain a string, terminate it by \0,
 	 * so e.g. sscanf() can scan the string easily */
-	buffer->page[copied] = 0;
+	to[copied] = 0;
 	return copied ? : -EFAULT;
 }
 
@@ -217,7 +230,7 @@ static ssize_t configfs_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	ssize_t len;
 
 	mutex_lock(&buffer->mutex);
-	len = fill_write_buffer(buffer, from);
+	len = fill_write_buffer(buffer, iocb->ki_pos, from);
 	if (len > 0)
 		len = flush_write_buffer(file, buffer, len);
 	if (len > 0)
@@ -272,7 +285,9 @@ static ssize_t configfs_bin_write_iter(struct kiocb *iocb,
 		buffer->bin_buffer_size = end_offset;
 	}
 
-	len = copy_from_iter(buffer->bin_buffer, buffer->bin_buffer_size, from);
+	len = copy_from_iter(buffer->bin_buffer + iocb->ki_pos,
+			     buffer->bin_buffer_size - iocb->ki_pos, from);
+	iocb->ki_pos += len;
 out:
 	mutex_unlock(&buffer->mutex);
 	return len ? : -EFAULT;
