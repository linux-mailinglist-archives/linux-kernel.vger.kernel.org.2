Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E098353314
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 10:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbhDCIKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 04:10:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55381 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232157AbhDCIKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 04:10:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617437435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EEUUyQWVj0Di8OA7DVfsbpbP7S1zPziCDvrYaaf9VcI=;
        b=Wv4huS8MGqbMDWNbPlesRaVAUanKaWLAvf1Cyy789nCh4mnJ2L/oeYM5ZXgER3P3W/fBuB
        CAKSHixFCetTY7yA4Xmo/DOQy2xlVFM0dTBdU1hGJwI6KbnYYO0REhEtxlAZqCXmK9kf5y
        ZLeWtq7qdHlDDT7Bg4W8W3lDQP6CARw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-X4rTPKBNPtqsjJhYawnRMQ-1; Sat, 03 Apr 2021 04:10:30 -0400
X-MC-Unique: X4rTPKBNPtqsjJhYawnRMQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2B63180FCA7;
        Sat,  3 Apr 2021 08:10:28 +0000 (UTC)
Received: from T590 (ovpn-12-28.pek2.redhat.com [10.72.12.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 306C35D9DC;
        Sat,  3 Apr 2021 08:10:21 +0000 (UTC)
Date:   Sat, 3 Apr 2021 16:10:16 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] block: shutdown blktrace in case of fatal signal
 pending
Message-ID: <YGgi6FOr6cEiei+7@T590>
References: <20210323081440.81343-1-ming.lei@redhat.com>
 <20210323081440.81343-2-ming.lei@redhat.com>
 <20210330165330.GA13829@lst.de>
 <YGO/cpalyGevAJjn@T590>
 <20210402172730.GA22923@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402172730.GA22923@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2021 at 07:27:30PM +0200, Christoph Hellwig wrote:
> On Wed, Mar 31, 2021 at 08:16:50AM +0800, Ming Lei wrote:
> > On Tue, Mar 30, 2021 at 06:53:30PM +0200, Christoph Hellwig wrote:
> > > On Tue, Mar 23, 2021 at 04:14:39PM +0800, Ming Lei wrote:
> > > > blktrace may allocate lots of memory, if the process is terminated
> > > > by user or OOM, we need to provide one chance to remove the trace
> > > > buffer, otherwise memory leak may be caused.
> > > > 
> > > > Fix the issue by shutdown blktrace in case of task exiting in
> > > > blkdev_close().
> > > > 
> > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > 
> > > This just seems weird.  blktrace has no relationship to open
> > > block device instances.
> > 
> > blktrace still needs to open one blkdev, then send its own ioctl
> > commands to block layer. In case of OOM, the allocated memory in
> > these ioctl commands won't be released.
> > 
> > Or any other suggestion?
> 
> Not much we can do there I think.  If we want to autorelease memory
> it needs to be an API that ties the memory allocation to an FD.

We still may shutdown blktrace if current is the last opener, otherwise
new blktrace can't be started and memory should be leaked forever, and
what do you think of the revised version?

From de33ec85ee1ce2865aa04f2639e480ea4db4eebf Mon Sep 17 00:00:00 2001
From: Ming Lei <ming.lei@redhat.com>
Date: Tue, 23 Mar 2021 10:32:23 +0800
Subject: [PATCH] block: shutdown blktrace in case of task exiting

blktrace may allocate lots of memory, if the process is terminated
by user or OOM, we need to provide one chance to remove the trace
buffer, otherwise memory leak may be caused. Also new blktrace
instance can't be started too.

Fix the issue by shutdown blktrace in case of task exiting in
blkdev_close() when it is the last opener.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 fs/block_dev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 92ed7d5df677..8fa59cecce72 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -34,6 +34,7 @@
 #include <linux/part_stat.h>
 #include <linux/uaccess.h>
 #include <linux/suspend.h>
+#include <linux/blktrace_api.h>
 #include "internal.h"
 
 struct bdev_inode {
@@ -1646,6 +1647,11 @@ EXPORT_SYMBOL(blkdev_put);
 static int blkdev_close(struct inode * inode, struct file * filp)
 {
 	struct block_device *bdev = I_BDEV(bdev_file_inode(filp));
+
+	/* shutdown blktrace in case of exiting which may be from OOM */
+	if ((current->flags & PF_EXITING) && (bdev->bd_openers == 1))
+		blk_trace_shutdown(bdev->bd_disk->queue);
+
 	blkdev_put(bdev, filp->f_mode);
 	return 0;
 }
-- 
2.29.2


-- 
Ming

