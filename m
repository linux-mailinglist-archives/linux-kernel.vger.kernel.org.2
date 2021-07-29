Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084FD3D9CDD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 06:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbhG2Elm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 00:41:42 -0400
Received: from mail-pj1-f42.google.com ([209.85.216.42]:54178 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbhG2Elh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 00:41:37 -0400
Received: by mail-pj1-f42.google.com with SMTP id j1so8457704pjv.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 21:41:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zqkxRlYr87kbKQ9r71+y8bsBamGsVypc9m9RJrJLvrI=;
        b=DZ400IbRw/o7Ch0wvuYwnxwGAnyF/F/Cka8q17fP3spLACebB2hyOHqbT5M96ZXiXe
         KRp1WY7X53/bP1dKbrE0bq4lVas1RosuJmjlEH/bSz0YfsnzavbtmZX5gnKySIsMtdNZ
         bkVEGEtVie/wkcTHVqQGmD7meaVr/DqkKqnMl0vUGxepSVBoWcLbCPuvO14rXMsTFo3q
         JJVDBNg9VaAoaMON1sNVJkLlrOi7jFzio1WvEJpTF1Paczv8uLG867VByIjnlYJW5Dpx
         3Y2CPiT9ph2LXNJjpAfeZ86rDQIpvfod8rNKsHUtB3kf0nB2vdtP8bxOCRM0SuJ7Kjxx
         HuyA==
X-Gm-Message-State: AOAM533GPz+0/69cZnjjyy0mtFykasBV4gYbJkOwrKq9o2JRpHsuaBis
        VgeHmXYX6GD90b0cuQ27bVY=
X-Google-Smtp-Source: ABdhPJzyXmh4m3u2d0I6+1ffnirx8A5ikWzYR9B/W0DJCrJE/uKfhX8Ec5qPaBnhaZKIsF2T3Soypw==
X-Received: by 2002:a65:450c:: with SMTP id n12mr2181950pgq.316.1627533694446;
        Wed, 28 Jul 2021 21:41:34 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:9eeb:60dc:7a3c:6558])
        by smtp.gmail.com with ESMTPSA id dw15sm1415405pjb.42.2021.07.28.21.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 21:41:33 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joel Becker <jlbec@evilplan.org>, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Bodo Stroesser <bostroesser@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Yanko Kaneti <yaneti@declera.com>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: [PATCH v2 1/3] configfs: Restore the kernel v5.13 text attribute write behavior
Date:   Wed, 28 Jul 2021 21:41:23 -0700
Message-Id: <20210729044125.7435-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210729044125.7435-1-bvanassche@acm.org>
References: <20210729044125.7435-1-bvanassche@acm.org>
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
