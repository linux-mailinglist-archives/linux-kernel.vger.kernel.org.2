Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1DB379EFB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 07:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhEKFIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 01:08:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229885AbhEKFIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 01:08:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9CA3D6187E;
        Tue, 11 May 2021 05:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620709644;
        bh=4c0rBQ+cD5bPSkpsXMcoo5k4pBv7+UXNxE9GGH+21ng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CinG+sArvseTBVOprnEIloPi/Nj2J4HiKbUh4f0a10srYbeAV9NuZ8XZFOU/nfJyk
         HAbgwecj8i9iao7lHbwE7WctBk16geRajB37wLCoMxYbbfWugSdzU9AIrgm2wqLTtZ
         wi0jjVWEhi36fxepX5c1C8KTzXzri3UjWPlwGDyvgkAutCR6WG9KWAO8MkCjaubRDr
         kFNItNLuh74GVno1cNRar5FKJAGkm0wiiZ9np74UpMO+LxMQ7kJgQ3SIh2qp7fR9KO
         cK7W5qOWFgcmgSOovTb2Nwv5zS7DhrlloCxyjDUlfS7pNc5R6STZ4XW19lZ68YHgel
         ut9RoDtAm11BA==
Date:   Mon, 10 May 2021 22:07:23 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid null pointer access when handling
 IPU error
Message-ID: <YJoRCwwRDgEH49/P@google.com>
References: <20210510142804.511265-1-jaegeuk@kernel.org>
 <9df7d088-3580-122b-60a3-799ea665cfeb@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9df7d088-3580-122b-60a3-799ea665cfeb@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11, Chao Yu wrote:
> On 2021/5/10 22:28, Jaegeuk Kim wrote:
> >   Unable to handle kernel NULL pointer dereference at virtual address 000000000000001a
> >   pc : f2fs_inplace_write_data+0x144/0x208
> >   lr : f2fs_inplace_write_data+0x134/0x208
> >   Call trace:
> >    f2fs_inplace_write_data+0x144/0x208
> >    f2fs_do_write_data_page+0x270/0x770
> >    f2fs_write_single_data_page+0x47c/0x830
> >    __f2fs_write_data_pages+0x444/0x98c
> >    f2fs_write_data_pages.llvm.16514453770497736882+0x2c/0x38
> >    do_writepages+0x58/0x118
> >    __writeback_single_inode+0x44/0x300
> >    writeback_sb_inodes+0x4b8/0x9c8
> >    wb_writeback+0x148/0x42c
> >    wb_do_writeback+0xc8/0x390
> >    wb_workfn+0xb0/0x2f4
> >    process_one_work+0x1fc/0x444
> >    worker_thread+0x268/0x4b4
> >    kthread+0x13c/0x158
> >    ret_from_fork+0x10/0x18
> > 
> > Fixes: 955772787667 ("f2fs: drop inplace IO if fs status is abnormal")
> 
> My bad, thanks for fixing this.
> 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >   fs/f2fs/segment.c | 8 +++++---
> >   1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index c605415840b5..ae875557d693 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -3577,9 +3577,11 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
> >   	if (fio->bio) {
> >   		struct bio *bio = *(fio->bio);
> > -		bio->bi_status = BLK_STS_IOERR;
> > -		bio_endio(bio);
> > -		fio->bio = NULL;
> > +		if (bio) {
> > +			bio->bi_status = BLK_STS_IOERR;
> > +			bio_endio(bio);
> > +			fio->bio = NULL;
> 
> fio->bio points a bio assigned in writepages(), so it should reset
> that bio to NULL by *(fio->bio) = NULL.

Good timing. I hit other kernel panic, and it seems this is the root cause.
Let me give it a try. :)

--- v2 ---

 Unable to handle kernel NULL pointer dereference at virtual address 000000000000001a
 pc : f2fs_inplace_write_data+0x144/0x208
 lr : f2fs_inplace_write_data+0x134/0x208
 Call trace:
  f2fs_inplace_write_data+0x144/0x208
  f2fs_do_write_data_page+0x270/0x770
  f2fs_write_single_data_page+0x47c/0x830
  __f2fs_write_data_pages+0x444/0x98c
  f2fs_write_data_pages.llvm.16514453770497736882+0x2c/0x38
  do_writepages+0x58/0x118
  __writeback_single_inode+0x44/0x300
  writeback_sb_inodes+0x4b8/0x9c8
  wb_writeback+0x148/0x42c
  wb_do_writeback+0xc8/0x390
  wb_workfn+0xb0/0x2f4
  process_one_work+0x1fc/0x444
  worker_thread+0x268/0x4b4
  kthread+0x13c/0x158
  ret_from_fork+0x10/0x18

Fixes: 955772787667 ("f2fs: drop inplace IO if fs status is abnormal")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index c605415840b5..51dc79fad4fe 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3574,12 +3574,12 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
 
 	return err;
 drop_bio:
-	if (fio->bio) {
+	if (fio->bio && *(fio->bio)) {
 		struct bio *bio = *(fio->bio);
 
 		bio->bi_status = BLK_STS_IOERR;
 		bio_endio(bio);
-		fio->bio = NULL;
+		*(fio->bio) = NULL;
 	}
 	return err;
 }
-- 
2.31.1.607.g51e8a6a459-goog

