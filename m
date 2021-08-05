Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5F13E0D57
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 06:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236424AbhHEEfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 00:35:30 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:44768 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236329AbhHEEf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 00:35:26 -0400
Received: by mail-pl1-f181.google.com with SMTP id q2so5569144plr.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 21:35:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zqkxRlYr87kbKQ9r71+y8bsBamGsVypc9m9RJrJLvrI=;
        b=im4Rp2hMfq7ouMFunxqxqlgPQ6rHKP3JgSMvMmmfoOI8/7T3BPQFeYUB6+CwjlG+Dv
         9XStpl+DNruQz54RY6eOiF1EqW+f492hwTBbbxdPT84elarT47Bcax0mWBurSb9/aAhh
         Hk+1wX2Cf9pA96ZqJCjey3uM41qr92nZIK7LZm7po4wHUgngca5XzfZCmz0iB0EYsPbD
         lpnQvz4jR4xCTaiCSoqy9dr2XlQmosSgMDwMxLGvmD3JEeqS7KF+ki9/4yO5qgoxMOBC
         sGVDWhMbpfKGl4sGfZzdt+fW65gUOUCSdj4mVXrWok9fcnkpTrJHHLN8ogaqZcDK4wyG
         jZUQ==
X-Gm-Message-State: AOAM530pbRBqHedj8Fl4fmOLmhX/FXGUishLcajdqa+4MnRXwT8V/tLo
        +f0g5Hu3i3O0ACdVtjzsCN0=
X-Google-Smtp-Source: ABdhPJxO9FxtHheSPC4QGlfyRxUjwuXmOlUY3XMIwkCOcoDEkyD76HpRSLGCN0Tq44QDOVjOiJoy1g==
X-Received: by 2002:aa7:96aa:0:b029:3c3:9e84:45a3 with SMTP id g10-20020aa796aa0000b02903c39e8445a3mr3066167pfk.23.1628138112195;
        Wed, 04 Aug 2021 21:35:12 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:e365:91b7:6284:3848])
        by smtp.gmail.com with ESMTPSA id b15sm5642153pgj.60.2021.08.04.21.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 21:35:11 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joel Becker <jlbec@evilplan.org>, linux-kernel@vger.kernel.org,
        Bodo Stroesser <bostroesser@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Yanko Kaneti <yaneti@declera.com>
Subject: [PATCH v4 1/3] configfs: Restore the kernel v5.13 text attribute write behavior
Date:   Wed,  4 Aug 2021 21:35:01 -0700
Message-Id: <20210805043503.20252-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805043503.20252-1-bvanassche@acm.org>
References: <20210805043503.20252-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of appending new text attribute data at the offset specified by the
write() system call, only pass the newly written data to the .store()
callback.

Cc: Bodo Stroesser <bostroesser@gmail.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Yanko Kaneti <yaneti@declera.com>
Cc: Brendan Higgins <brendanhiggins@google.com>
Reported-by: Bodo Stroesser <bostroesser@gmail.com>
Tested-by: Bodo Stroesser <bostroesser@gmail.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/configfs/file.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/fs/configfs/file.c b/fs/configfs/file.c
index 5a0be9985bae..0ad32150611e 100644
--- a/fs/configfs/file.c
+++ b/fs/configfs/file.c
@@ -177,28 +177,22 @@ static ssize_t configfs_bin_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	return retval;
 }
 
-/* Fill [buffer, buffer + pos) with data coming from @from. */
-static int fill_write_buffer(struct configfs_buffer *buffer, loff_t pos,
+/* Fill @buffer with data coming from @from. */
+static int fill_write_buffer(struct configfs_buffer *buffer,
 			     struct iov_iter *from)
 {
-	loff_t to_copy;
 	int copied;
-	u8 *to;
 
 	if (!buffer->page)
 		buffer->page = (char *)__get_free_pages(GFP_KERNEL, 0);
 	if (!buffer->page)
 		return -ENOMEM;
 
-	to_copy = SIMPLE_ATTR_SIZE - 1 - pos;
-	if (to_copy <= 0)
-		return 0;
-	to = buffer->page + pos;
-	copied = copy_from_iter(to, to_copy, from);
+	copied = copy_from_iter(buffer->page, SIMPLE_ATTR_SIZE - 1, from);
 	buffer->needs_read_fill = 1;
 	/* if buf is assumed to contain a string, terminate it by \0,
 	 * so e.g. sscanf() can scan the string easily */
-	to[copied] = 0;
+	buffer->page[copied] = 0;
 	return copied ? : -EFAULT;
 }
 
@@ -227,10 +221,10 @@ static ssize_t configfs_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
 	struct configfs_buffer *buffer = file->private_data;
-	ssize_t len;
+	int len;
 
 	mutex_lock(&buffer->mutex);
-	len = fill_write_buffer(buffer, iocb->ki_pos, from);
+	len = fill_write_buffer(buffer, from);
 	if (len > 0)
 		len = flush_write_buffer(file, buffer, len);
 	if (len > 0)
