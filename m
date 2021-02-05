Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E6E3113A8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 22:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhBEVgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 16:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbhBEVfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 16:35:01 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA65C0617A7
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 13:34:09 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id dh16so6018635qvb.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 13:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:cc;
        bh=8MAy8AaN6ZS5Avy4E0Q7L68GZ02PGsx9JgCkTgKoHNQ=;
        b=WnliLim5ZvWL9ZBmepw0MTbma5fCSUQs19cvbXGTo+LnqW1tu36qu/K4HvniKmFTjd
         o/nv5QHpFhvC1eCslPC0jr1VAqkMPdVYGLNyfvhw7JiuBUz0u4i6PkS0c67rvgIQYiBO
         g5+n6GO294I+aASt6Okdy9Y9hDftPtnxffwm4veUH2aPdEe1/mbXdiZO0+1PytM4wtcZ
         4SBS8PoKpJ2a5KG8d3InFVtCAvi162x32ueOqd1DR2iJ9rUXtXQWvryG0yK/b9Gg8CUZ
         F9LvfX+RVQiieanUmyi8TtjNs5RuLFq2g/8ltJvxdZrRvjYSm0t4RNN5SN+xVXeIeXlV
         d4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=8MAy8AaN6ZS5Avy4E0Q7L68GZ02PGsx9JgCkTgKoHNQ=;
        b=ZorgsGb0D8yd/FSIpjiemgKa79x1pTb3L9vzERsuR7uzGnsm9OpamqZYM33Xm9Ch3F
         HeLM9ORqVWKrW/A3QOLFZsmp+38bmztYw+gbf3WYd9Ss8vJ0islLOLnmstfjpyp1A44o
         13V5OZluDPz3s/E8u2Lbx/2rFs1A0q1cwnCDlEmKVw4LhnST5mmy96oTvD5wUrkarloY
         fK6pUVRlMyqpuyKA8KbHZO+17i0Xm+VW+UNztn4SY/0ClO+OQaSjI38IA6uRzp2Ntb3V
         8cEJjDc+pf5gi8+0yTNIQa0I5YALPVi1CT0gsIioGFau6EYBcZT92AmT3PZ3T8SG6wT7
         c6Wg==
X-Gm-Message-State: AOAM531mU3r3HUWxY8Wq/LQl/894QPyowADw1eqi5Uk+bg2d8/JxOyPu
        hyx8wqmA2euSamYGW4VsjurGez8M/pXgocgWRw==
X-Google-Smtp-Source: ABdhPJy5Phpkm8UmSoQT/cka7X8jy/KGgS1Wrb3leZpBdapsYf0YaqsduncqfY+tg1G+WZk5ym5FvVPgD1lNua+NiA==
Sender: "kaleshsingh via sendgmr" <kaleshsingh@kaleshsingh.c.googlers.com>
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:10:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:ad4:486c:: with SMTP id
 u12mr6427106qvy.5.1612560848833; Fri, 05 Feb 2021 13:34:08 -0800 (PST)
Date:   Fri,  5 Feb 2021 21:33:44 +0000
In-Reply-To: <20210205213353.669122-1-kaleshsingh@google.com>
Message-Id: <20210205213353.669122-2-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20210205213353.669122-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v4 2/2] dmabuf: Add dmabuf inode number to /proc/*/fdinfo
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     jannh@google.com, jeffv@google.com, keescook@chromium.org,
        surenb@google.com, minchan@kernel.org, hridya@google.com,
        rdunlap@infradead.org, christian.koenig@amd.com,
        kernel-team@android.com, Kalesh Singh <kaleshsingh@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        NeilBrown <neilb@suse.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Michel Lespinasse <walken@google.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Andrei Vagin <avagin@gmail.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And 'inode_no' field to /proc/<pid>/fdinfo/<FD> and
/proc/<pid>/task/<tid>/fdinfo/<FD>.

The inode numbers can be used to uniquely identify DMA buffers
in user space and avoids a dependency on /proc/<pid>/fd/* when
accounting per-process DMA buffer sizes.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
Changes in v4:
  - Add inode number as common field in fdinfo, per Christian
Changes in v3:
  - Add documentation in proc.rst, per Randy
Changes in v2:
  - Update patch description

 Documentation/filesystems/proc.rst | 37 +++++++++++++++++++++++++-----
 fs/proc/fd.c                       |  5 ++--
 2 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 2fa69f710e2a..db46da32230c 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -1902,18 +1902,20 @@ if precise results are needed.
 3.8	/proc/<pid>/fdinfo/<fd> - Information about opened file
 ---------------------------------------------------------------
 This file provides information associated with an opened file. The regular
-files have at least three fields -- 'pos', 'flags' and 'mnt_id'. The 'pos'
-represents the current offset of the opened file in decimal form [see lseek(2)
-for details], 'flags' denotes the octal O_xxx mask the file has been
-created with [see open(2) for details] and 'mnt_id' represents mount ID of
-the file system containing the opened file [see 3.5 /proc/<pid>/mountinfo
-for details].
+files have at least four fields -- 'pos', 'flags', 'mnt_id' and 'inode_no'.
+The 'pos' represents the current offset of the opened file in decimal
+form [see lseek(2) for details], 'flags' denotes the octal O_xxx mask the
+file has been created with [see open(2) for details] and 'mnt_id' represents
+mount ID of the file system containing the opened file [see 3.5
+/proc/<pid>/mountinfo for details]. 'inode_no' represents the inode number
+of the file.
 
 A typical output is::
 
 	pos:	0
 	flags:	0100002
 	mnt_id:	19
+	inode_no:       63107
 
 All locks associated with a file descriptor are shown in its fdinfo too::
 
@@ -1930,6 +1932,7 @@ Eventfd files
 	pos:	0
 	flags:	04002
 	mnt_id:	9
+	inode_no:       63107
 	eventfd-count:	5a
 
 where 'eventfd-count' is hex value of a counter.
@@ -1942,6 +1945,7 @@ Signalfd files
 	pos:	0
 	flags:	04002
 	mnt_id:	9
+	inode_no:       63107
 	sigmask:	0000000000000200
 
 where 'sigmask' is hex value of the signal mask associated
@@ -1955,6 +1959,7 @@ Epoll files
 	pos:	0
 	flags:	02
 	mnt_id:	9
+	inode_no:       63107
 	tfd:        5 events:       1d data: ffffffffffffffff pos:0 ino:61af sdev:7
 
 where 'tfd' is a target file descriptor number in decimal form,
@@ -1971,6 +1976,8 @@ For inotify files the format is the following::
 
 	pos:	0
 	flags:	02000000
+	mnt_id:	9
+	inode_no:       63107
 	inotify wd:3 ino:9e7e sdev:800013 mask:800afce ignored_mask:0 fhandle-bytes:8 fhandle-type:1 f_handle:7e9e0000640d1b6d
 
 where 'wd' is a watch descriptor in decimal form, i.e. a target file
@@ -1993,6 +2000,7 @@ For fanotify files the format is::
 	pos:	0
 	flags:	02
 	mnt_id:	9
+	inode_no:       63107
 	fanotify flags:10 event-flags:0
 	fanotify mnt_id:12 mflags:40 mask:38 ignored_mask:40000003
 	fanotify ino:4f969 sdev:800013 mflags:0 mask:3b ignored_mask:40000000 fhandle-bytes:8 fhandle-type:1 f_handle:69f90400c275b5b4
@@ -2017,6 +2025,7 @@ Timerfd files
 	pos:	0
 	flags:	02
 	mnt_id:	9
+	inode_no:       63107
 	clockid: 0
 	ticks: 0
 	settime flags: 01
@@ -2031,6 +2040,22 @@ details]. 'it_value' is remaining time until the timer expiration.
 with TIMER_ABSTIME option which will be shown in 'settime flags', but 'it_value'
 still exhibits timer's remaining time.
 
+DMA Buffer files
+~~~~~~~~~~~~~~~~
+
+::
+
+	pos:	0
+	flags:	04002
+	mnt_id:	9
+	inode_no:       63107
+	size:   32768
+	count:  2
+	exp_name:  system-heap
+
+where 'size' is the size of the DMA buffer in bytes. 'count' is the file count of
+the DMA buffer file. 'exp_name' is the name of the DMA buffer exporter.
+
 3.9	/proc/<pid>/map_files - Information about memory mapped files
 ---------------------------------------------------------------------
 This directory contains symbolic links which represent memory mapped files
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 585e213301f9..2c25909bf9d1 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -54,9 +54,10 @@ static int seq_show(struct seq_file *m, void *v)
 	if (ret)
 		return ret;
 
-	seq_printf(m, "pos:\t%lli\nflags:\t0%o\nmnt_id:\t%i\n",
+	seq_printf(m, "pos:\t%lli\nflags:\t0%o\nmnt_id:\t%i\ninode_no:\t%lu\n",
 		   (long long)file->f_pos, f_flags,
-		   real_mount(file->f_path.mnt)->mnt_id);
+		   real_mount(file->f_path.mnt)->mnt_id,
+		   file_inode(file)->i_ino);
 
 	/* show_fd_locks() never deferences files so a stale value is safe */
 	show_fd_locks(m, file, files);
-- 
2.30.0.478.g8a0d178c01-goog

