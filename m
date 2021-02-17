Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241FB31DCC6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 16:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbhBQP4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 10:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbhBQP4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 10:56:22 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3F3C061574
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 07:55:42 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id m22so22334764lfg.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 07:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KRsRMiJdhUIxr2Xg+92+1e5npMvkoee1V46CqCqYxRQ=;
        b=KzpNmFCrWYzucYiPdw9HhVTul/NMWbVj9oJ/4cXajUjdPX45NZq0PMy5Apha5wiGcx
         fZ39dIhyVFltm7T1U3mSaxoLCPQyvrTzZHrKPV3i5rV6TsUd+jAveIoLWNJ/D7LG6F9t
         PA41HtSfB/NkJzgmKEv7XhLCSu47z4MqyuILMYfse0sEpbBrOsFBVUzoZ7S1P3yMdNZd
         SnNb0UPc6gtqRSvDmvIkXrMozSdrxQHmTbDhr9YJq8jFhW1Upwfs10t0qjxPBNbBvIof
         +xOxyHYNprvy8HEXXUTD65j4B5/8qMhkQQzCogLV0QG/1uQm8yzMhfSY9mjUb2Q/92jE
         NTQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KRsRMiJdhUIxr2Xg+92+1e5npMvkoee1V46CqCqYxRQ=;
        b=CwWv9pF24I0bOUla87+tI1zwHYhpXEdb4KcUk50t0X3rUt8+ZcLu7z9Dlo3eH6Bh3H
         wq1bqP11x7hCsXVxfx9aWD2/MwdD/tx5xjcZfUMXSBx97qaSp6Ilgy/wxx8AkoYzsBlB
         UoRfI1+5SP8HwtvxrngMpVXpincJh0oiJl3FI5wALS7kmjsKo8rJPmnqf71HKjkOO16G
         uQ2FiOzsyjQFIeqtxTHZsR0KLq/7jzb2bKr8NGib3t6rfdmtKBYBz5sPzoENgA35yAse
         PENcLygMeNj+OWFSRajHfLh2HOzX7pzJYJ5BFikEIlfSA/nHiirBHuJThSnAhWlLd/3R
         oOlA==
X-Gm-Message-State: AOAM533HTo4Npx3/DUDMmfyHu38q1UBez1VPqN34Wkd7b7vpBKIYfpwZ
        zmGAaPwhuW7bS52rjIUCXlE=
X-Google-Smtp-Source: ABdhPJzMdHVBMkH8VYpou3wIVYgDnwUia43Q7sdIAP4gj49UgfDl9nJTpYoEx1uvHvybnC34LVochw==
X-Received: by 2002:a19:6b1a:: with SMTP id d26mr15356954lfa.162.1613577340535;
        Wed, 17 Feb 2021 07:55:40 -0800 (PST)
Received: from localhost.localdomain ([146.158.65.225])
        by smtp.googlemail.com with ESMTPSA id g19sm287322lfb.54.2021.02.17.07.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 07:55:39 -0800 (PST)
From:   Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        snovitoll@gmail.com,
        syzbot+3d2c27c2b7dc2a94814d@syzkaller.appspotmail.com
Subject: [PATCH v2] tty: fix when iov_iter_count() returns 0 in tty_write()
Date:   Wed, 17 Feb 2021 21:55:36 +0600
Message-Id: <20210217155536.2986178-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YC0zGySVWMKdpulA@kroah.com>
References: <YC0zGySVWMKdpulA@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot found WARNING in iov_iter_revert[1] when iov_iter_count() returns 0,
therefore INT_MAX is passed to iov_iter_revert() causing > MAX_RW_COUNT
warning.

static inline ssize_t do_tty_write()
{
..
	size_t count = iov_iter_count(from);
..
		size_t size = count;
		if (ret != size)
			iov_iter_revert(from, size-ret);

[1] WARNING: lib/iov_iter.c:1090
Call Trace:
 do_tty_write drivers/tty/tty_io.c:967 [inline]
 file_tty_write.constprop.0+0x55f/0x8f0 drivers/tty/tty_io.c:1048
 call_write_iter include/linux/fs.h:1901 [inline]
 new_sync_write+0x426/0x650 fs/read_write.c:518
 vfs_write+0x791/0xa30 fs/read_write.c:605
 ksys_write+0x12d/0x250 fs/read_write.c:658

Fixes: 9bb48c82aced ("tty: implement write_iter")
Reported-by: syzbot+3d2c27c2b7dc2a94814d@syzkaller.appspotmail.com
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---

v2: Fixed "Fixed" tag to proper commit and changed write return to -EFAULT
as this statement is valid, tested via strace:

write(3, NULL, 0)                       = -1 EFAULT (Bad address)

Updated to -EFAULT, should be a valid exit code as
copy_from_iter(.., .., from) returns -EFAULT as well if *from is invalid
address.

>
> Nit, you need a ' ' before your '(' character here, otherwise the
> linux-next scripts will complain.

> Also, you got the git commit id wrong, so this needs to be fixed up
> anyway.  You are pointing to a merge point, I doubt that's what you want
> to point to here, right?

Thanks!
---
 drivers/tty/tty_io.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 816e709afa56..e1460cad8b7d 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -905,6 +905,9 @@ static inline ssize_t do_tty_write(
 	ssize_t ret, written = 0;
 	unsigned int chunk;
 
+	if (!count)
+		return -EFAULT;
+
 	ret = tty_write_lock(tty, file->f_flags & O_NDELAY);
 	if (ret < 0)
 		return ret;
-- 
2.25.1

