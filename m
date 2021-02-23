Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF7A3225F1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 07:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbhBWGcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 01:32:20 -0500
Received: from verein.lst.de ([213.95.11.211]:32825 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229996AbhBWGcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 01:32:14 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id AEED268D0D; Tue, 23 Feb 2021 07:31:30 +0100 (CET)
Date:   Tue, 23 Feb 2021 07:31:30 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        David Anderson <dvander@google.com>,
        linux-block@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        Alistair Delva <adelva@google.com>
Subject: Re: [REGRESSION] "add a disk_uevent helper" breaks booting Andorid
 w/ dynamic partitions
Message-ID: <20210223063130.GA16292@lst.de>
References: <CALAqxLU3B8YcS_MTnr2Lpasvn8oLJvD2qO4hkfkZeEwVNfeHXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLU3B8YcS_MTnr2Lpasvn8oLJvD2qO4hkfkZeEwVNfeHXg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please try the patch below:

---
From 85943345b41ec04f5a9e92dfad85b0fb24e2d2eb Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Tue, 23 Feb 2021 07:28:22 +0100
Subject: block: don't skip empty device in in disk_uevent

Restore the previous behavior by using the correct flag for the whole device
("part0").

Fixes: 99dfc43ecbf6 ("block: use ->bi_bdev for bio based I/O accounting")
Reported-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index dbb92e24ef65ed..fcc530164b5ab4 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -476,7 +476,7 @@ void disk_uevent(struct gendisk *disk, enum kobject_action action)
 	struct disk_part_iter piter;
 	struct block_device *part;
 
-	disk_part_iter_init(&piter, disk, DISK_PITER_INCL_PART0);
+	disk_part_iter_init(&piter, disk, DISK_PITER_INCL_EMPTY_PART0);
 	while ((part = disk_part_iter_next(&piter)))
 		kobject_uevent(bdev_kobj(part), action);
 	disk_part_iter_exit(&piter);
-- 
2.29.2

