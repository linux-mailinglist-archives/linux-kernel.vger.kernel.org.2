Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D8F371748
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 16:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhECO6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 10:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbhECO6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 10:58:43 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF2DC061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 07:57:46 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id t21so4323796iob.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 07:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=yjuCHoWi9NQN2JVk/lXHAiPpWbADy6aEqtHpjVnEBPk=;
        b=sjJtnetJvY/M6qNRaBqxHidEC74a7C6LZAJGspCJhSTA0r8yXXdy3ynvz2uNX6qj+O
         YPLy7fFemV82zKrEHTunFa85kwk8rH/seK6OL3Nv+F52Y8rM6tRK1M6u7JGcJznKSWph
         zRrywf4ylBIJFyhYTfXicZKptxnr7mxQuXhRU6JoBsVzkkhtg4tsGP8ldr2F6b6LpYel
         O2wz9eaFbG0OoVr2GTJOzh3OwrpcEuwpoVtyIQq92QmmfM0c61tMbLfH6EWymH5iaMfx
         EmjXjX6yOB60/ZCiPb0sfY0pLli9DQfbF7jr/FUFssB2kI4mVBvn3Zpf9dRkDNieVGC2
         R+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=yjuCHoWi9NQN2JVk/lXHAiPpWbADy6aEqtHpjVnEBPk=;
        b=gWNoK1HNSUnJQ3fbddEDzuD0y5tnx1V5eWiDC2O15mjfJAJvfeemB7i9DfoJgT6PFc
         t/pqHGSOuUMfN5DwoHkZ6rPGM3cAI/GzUSi9BRWQqFuu2609kwYnznL7lKbYxivJvU/x
         GzCCE8FdmNAMHBRHQ6I4p5FThy7ntQ3AJZeMo3qQdHPN6VznFH+5V9ul7VZod7mw13mV
         AgJD1PdUu7tvwjDyuHDfYt+D/xvtbjGGNrxWdyifrSjYcKC4rgr6eYdXbDKVEEtGsMx/
         z8Zv7cjYM3Us9Q23iYHk8OfLNaAZILbG3mssUsfNfmQ/pqh1RPWnErhr9qjhZpQWta2Z
         molA==
X-Gm-Message-State: AOAM533JOT1i/jQuhAZtv50GohrVL41xViGOI+cmC/QaxIZSFQIgblde
        ALPBeWJ0DYpvvU665ZRvdGYr2uR9fB9okg==
X-Google-Smtp-Source: ABdhPJzIZBAEhvhAP5ObOH40HKGK3XVZwJyr8z7rAcGxQDdgxhf2HkI/dLpIAoFVWJWyL0qOQ9hA5Q==
X-Received: by 2002:a02:8308:: with SMTP id v8mr19390470jag.143.1620053866052;
        Mon, 03 May 2021 07:57:46 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h14sm683783ils.13.2021.05.03.07.57.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 07:57:45 -0700 (PDT)
To:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] eventfd: convert to using ->write_iter()
Message-ID: <7b98e3c2-2d9f-002b-1da1-815d8522b594@kernel.dk>
Date:   Mon, 3 May 2021 08:57:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Had a report on writing to eventfd with io_uring is slower than it
should be, and it's the usual case of if a file type doesn't support
->write_iter(), then io_uring cannot rely on IOCB_NOWAIT being honored
alongside O_NONBLOCK for whether or not this is a non-blocking write
attempt. That means io_uring will punt the operation to an io thread,
which will slow us down unnecessarily.

Convert eventfd to using fops->write_iter() instead of fops->write().

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/eventfd.c b/fs/eventfd.c
index e265b6dd4f34..02c55e5e1a3e 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -264,17 +264,18 @@ static ssize_t eventfd_read(struct kiocb *iocb, struct iov_iter *to)
 	return sizeof(ucnt);
 }
 
-static ssize_t eventfd_write(struct file *file, const char __user *buf, size_t count,
-			     loff_t *ppos)
+static ssize_t eventfd_write(struct kiocb *kiocb, struct iov_iter *from)
 {
+	struct file *file = kiocb->ki_filp;
 	struct eventfd_ctx *ctx = file->private_data;
+	size_t count = iov_iter_count(from);
 	ssize_t res;
 	__u64 ucnt;
 	DECLARE_WAITQUEUE(wait, current);
 
 	if (count < sizeof(ucnt))
 		return -EINVAL;
-	if (copy_from_user(&ucnt, buf, sizeof(ucnt)))
+	if (copy_from_iter(&ucnt, count, from) != count)
 		return -EFAULT;
 	if (ucnt == ULLONG_MAX)
 		return -EINVAL;
@@ -282,7 +283,8 @@ static ssize_t eventfd_write(struct file *file, const char __user *buf, size_t c
 	res = -EAGAIN;
 	if (ULLONG_MAX - ctx->count > ucnt)
 		res = sizeof(ucnt);
-	else if (!(file->f_flags & O_NONBLOCK)) {
+	else if (!(file->f_flags & O_NONBLOCK) &&
+		 !(kiocb->ki_flags & IOCB_NOWAIT)) {
 		__add_wait_queue(&ctx->wqh, &wait);
 		for (res = 0;;) {
 			set_current_state(TASK_INTERRUPTIBLE);
@@ -331,7 +333,7 @@ static const struct file_operations eventfd_fops = {
 	.release	= eventfd_release,
 	.poll		= eventfd_poll,
 	.read_iter	= eventfd_read,
-	.write		= eventfd_write,
+	.write_iter	= eventfd_write,
 	.llseek		= noop_llseek,
 };
 

-- 
Jens Axboe

