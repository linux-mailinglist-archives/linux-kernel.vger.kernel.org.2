Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A197A3DB1FA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 05:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236285AbhG3DfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 23:35:20 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:55259 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbhG3DfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 23:35:18 -0400
Received: by mail-pj1-f41.google.com with SMTP id b6so13135545pji.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 20:35:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zqkxRlYr87kbKQ9r71+y8bsBamGsVypc9m9RJrJLvrI=;
        b=rHhJuC+91hBEI4EU0AdOJmgvcfQgmu+SeQLTsoTIuyDVd01NWNQnYh00Wnkj9AGdpn
         oZhuXBBxd3i9SUi23TK+ig/+Bj2FDPE0hKNVFI30VmB5JtNK2yu39Yb4Fc36TKhCgIUT
         KHAfgiUhzC5BwZHdrD0lJ1nRbGi3rWY88cQ/UnX/ahsapCqkE+PbtSZwEhfkaiRmEz4g
         WPs2LIYOtYDn9RnamwuANa6M3EGbY5rY+nV+l2tvlIJx7sps7zQ9E4P1SXb5Feul87oR
         TA+hDbddw55DNN25DPHCumU6UqwtwtOuaXXgSuvttrWWi8Nu/NL7xZyHAXl571tkkapN
         TNOw==
X-Gm-Message-State: AOAM5304z+V7pA2L/7YEYuZf9vn8zWlXLHrvPS6t/TJjprwEXH7hcHah
        N8L1wz8xznRJUNtzXfa8sY8=
X-Google-Smtp-Source: ABdhPJz0Jt8TKofZrX3tJl/utaA3/MkmVv+rUt0ssXixoHhYr42z21OhVBHnEIocVSU60an6mCWpqA==
X-Received: by 2002:aa7:85da:0:b029:329:aacc:333e with SMTP id z26-20020aa785da0000b0290329aacc333emr740287pfn.60.1627616113313;
        Thu, 29 Jul 2021 20:35:13 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:3f66:df55:a341:f79d])
        by smtp.gmail.com with ESMTPSA id y7sm292830pfi.204.2021.07.29.20.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 20:35:12 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joel Becker <jlbec@evilplan.org>, linux-kernel@vger.kernel.org,
        Bodo Stroesser <bostroesser@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Yanko Kaneti <yaneti@declera.com>
Subject: [PATCH v3 1/3] configfs: Restore the kernel v5.13 text attribute write behavior
Date:   Thu, 29 Jul 2021 20:35:02 -0700
Message-Id: <20210730033504.8228-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210730033504.8228-1-bvanassche@acm.org>
References: <20210730033504.8228-1-bvanassche@acm.org>
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
