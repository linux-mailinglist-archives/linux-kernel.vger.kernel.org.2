Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70C83D7B54
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 18:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhG0Qr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 12:47:29 -0400
Received: from mail-pj1-f53.google.com ([209.85.216.53]:41751 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhG0Qr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 12:47:28 -0400
Received: by mail-pj1-f53.google.com with SMTP id q17-20020a17090a2e11b02901757deaf2c8so5750639pjd.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 09:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=01OAR8To3ZcJ4vpFCydcbHByeaZ86l3QJWSODV86wfw=;
        b=LcRmV7BEuFZWS8MNJ/ia+ubWuY0KFKcBh5wj1Vez10UZr8v+DjizwEBrdJ7p4Rhmms
         c2GoqISd5dRDzs1Lmw9M7RiJ68kWtbKYJUnmTogbdwKbBpQ2fYo3mcVRuD2edzKjvFOR
         dcZAazwWIJE3B8rAFb01UbzVXeAJ/CZ70Py1BHjdihsS9SO7VLnjTUV91vNdsETrxwL5
         1+Z3QqjCM5jq5Tulfb1rq1eWAgS0CLcb3XirJjGsUfnTAFLo7sywlKIFFkGX/GQoO+5T
         vL4eCQQC1OtnyeTh/oBeh2h8PArNhTFaL8mydFMKxCxUwNteUJBBcHmTSCZtzjqhqN81
         5hIg==
X-Gm-Message-State: AOAM532oBqZ8S5f19ZC6QWQ7PYIApbd44vGwTzFF/loVQFHHATzvtPoa
        gDhd+DlreGX79mGjOpPhgZBbZGxHoqqxeY+U
X-Google-Smtp-Source: ABdhPJwYVs7GDk8Z8AcfLb+yMMUJ6ADhr7eZUZ8VQ9Nl2gbuDw+lZ2ejc2bGd6VTfj48ntf7+a/PpA==
X-Received: by 2002:a63:fb08:: with SMTP id o8mr24245628pgh.72.1627404447187;
        Tue, 27 Jul 2021 09:47:27 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:1:245b:3f73:a2af:af2f])
        by smtp.gmail.com with ESMTPSA id c83sm4404335pfb.164.2021.07.27.09.47.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 09:47:26 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 2/4] configfs: Fix writing at a non-zero offset
To:     Bodo Stroesser <bostroesser@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Joel Becker <jlbec@evilplan.org>, linux-kernel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Yanko Kaneti <yaneti@declera.com>,
        Brendan Higgins <brendanhiggins@google.com>
References: <20210723212353.896343-1-bvanassche@acm.org>
 <20210723212353.896343-3-bvanassche@acm.org>
 <7bee65ce-f5f1-a525-c72d-221b5d23cf3e@gmail.com>
 <d12f24b6-7066-f9bb-1b88-6cc23c9c45c1@acm.org>
 <4055ca70-7669-d00d-7c08-86fe75a3d377@gmail.com>
 <618b2bdc-282b-0a1d-1fc5-020cf80d7a7e@acm.org>
 <c9cb1f3b-0b3b-c571-4a51-e647f3c1e90a@gmail.com>
 <ab190c50-8c87-b215-1432-056c81bcd656@acm.org>
 <fec30933-46b1-1085-1af1-1fd0d2265981@gmail.com>
Message-ID: <a3ba73e5-ffd1-887e-acd9-11f537db27e0@acm.org>
Date:   Tue, 27 Jul 2021 09:47:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <fec30933-46b1-1085-1af1-1fd0d2265981@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/21 12:27 AM, Bodo Stroesser wrote:
> What I meant is, that changing the source code in such a way, that
> writing a buffer in multiple writes works in general, could cause
> trouble in case userspace uses this.
> 
> But for special syscall sequences your changes still change the result
> on existing configfs files. Example:
> 
> 1) userspace program opens qfull_time_out
> 2) userspace program writes "90", count=2 to set timeout to 90 sec
> 3) userspace again wants to change timeout, so it writes "55", count=2
> 
> Before the changes we end up with timeout being 55 seconds. After the
> change - due to data gathering - we finally have timeout 9055 seconds.

Hi Bodo,

How about replacing patches 1 and 2 from this series with the patch below?
Do you agree that this patch is sufficient to restore the behavior from
kernel v5.13 and before?

Thanks,

Bart.

Subject: [PATCH 1/3] configfs: Restore the kernel v5.13 text attribute write behavior

Instead of writing at the offset specified by the write() system call,
always write at offset zero.

Cc: Bodo Stroesser <bostroesser@gmail.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Yanko Kaneti <yaneti@declera.com>
Cc: Brendan Higgins <brendanhiggins@google.com>
Reported-by: Bodo Stroesser <bostroesser@gmail.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
  fs/configfs/file.c | 20 ++++++++------------
  1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/fs/configfs/file.c b/fs/configfs/file.c
index 5a0be9985bae..8adf6250b207 100644
--- a/fs/configfs/file.c
+++ b/fs/configfs/file.c
@@ -177,12 +177,11 @@ static ssize_t configfs_bin_read_iter(struct kiocb *iocb, struct iov_iter *to)
  	return retval;
  }

-/* Fill [buffer, buffer + pos) with data coming from @from. */
-static int fill_write_buffer(struct configfs_buffer *buffer, loff_t pos,
+/* Fill @buffer with data coming from @from. */
+static int fill_write_buffer(struct configfs_buffer *buffer,
  			     struct iov_iter *from)
  {
-	loff_t to_copy;
-	int copied;
+	int to_copy, copied;
  	u8 *to;

  	if (!buffer->page)
@@ -190,11 +189,8 @@ static int fill_write_buffer(struct configfs_buffer *buffer, loff_t pos,
  	if (!buffer->page)
  		return -ENOMEM;

-	to_copy = SIMPLE_ATTR_SIZE - 1 - pos;
-	if (to_copy <= 0)
-		return 0;
-	to = buffer->page + pos;
-	copied = copy_from_iter(to, to_copy, from);
+	to = buffer->page;
+	copied = copy_from_iter(to, SIMPLE_ATTR_SIZE - 1, from);
  	buffer->needs_read_fill = 1;
  	/* if buf is assumed to contain a string, terminate it by \0,
  	 * so e.g. sscanf() can scan the string easily */
@@ -227,14 +223,14 @@ static ssize_t configfs_write_iter(struct kiocb *iocb, struct iov_iter *from)
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
-		iocb->ki_pos += len;
+		iocb->ki_pos = len;
  	mutex_unlock(&buffer->mutex);
  	return len;
  }
