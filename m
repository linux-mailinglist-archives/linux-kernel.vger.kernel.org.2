Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEDE32AAEA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 21:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577389AbhCBUAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 15:00:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:53802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343767AbhCBRcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 12:32:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EAE6B601FB;
        Tue,  2 Mar 2021 17:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614704707;
        bh=apE6atfdCU5ynjww5gGzXPVqWZw4OaO9hE7kK5VtJI8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LJcRlj9re5bdGrm9vdA9SqBxE7WtM7/5azxcG7xoPjFZrl2mqlocqbIEkWl4gBLqL
         ozsszbnW0UxEf7FUs1Bz4wqzURZOkTwLLyMFvcYimjspOiv5qSwuG8URNyaNtwcxhr
         yGpUqqpyGbgXI2o60vmo6RzDdjT5iryfKtwJPCxbi460cbnRIhsF4P5CTnXDUwVtEe
         zL4vfY7RogF9MpvJGUYEelMZFcBbdhKvpFs7polpISSlE8uIbosCTrC9OFgNhp4Lym
         xZjX5eRWThag92bgmkvMW8QjxS4AdRzTW8ph3xhqkNwu3EUGL2hef775cBEu6gCWiE
         i8w5v3zU12oEg==
Date:   Tue, 2 Mar 2021 09:05:05 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Subject: Re: [f2fs-dev] [PATCH] f2fs: expose # of overprivision segments
Message-ID: <YD5wQRX+HnltBvEM@google.com>
References: <20210302054233.3886681-1-jaegeuk@kernel.org>
 <920469a9-45d3-68e3-1f8d-a436bdd60cfe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <920469a9-45d3-68e3-1f8d-a436bdd60cfe@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02, Chao Yu wrote:
> On 2021/3/2 13:42, Jaegeuk Kim wrote:
> > This is useful when checking conditions during checkpoint=disable in Android.
> 
> This sysfs entry is readonly, how about putting this at
> /sys/fs/f2fs/<disk>/stat/?

Urg.. "stat" is a bit confused. I'll take a look a better ones.

> 
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >   fs/f2fs/sysfs.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> > 
> > diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> > index e38a7f6921dd..254b6fa17406 100644
> > --- a/fs/f2fs/sysfs.c
> > +++ b/fs/f2fs/sysfs.c
> > @@ -91,6 +91,13 @@ static ssize_t free_segments_show(struct f2fs_attr *a,
> >   			(unsigned long long)(free_segments(sbi)));
> >   }
> > +static ssize_t ovp_segments_show(struct f2fs_attr *a,
> > +		struct f2fs_sb_info *sbi, char *buf)
> > +{
> > +	return sprintf(buf, "%llu\n",
> > +			(unsigned long long)(overprovision_segments(sbi)));
> > +}
> > +
> >   static ssize_t lifetime_write_kbytes_show(struct f2fs_attr *a,
> >   		struct f2fs_sb_info *sbi, char *buf)
> >   {
> > @@ -629,6 +636,7 @@ F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, node_io_flag, node_io_flag);
> >   F2FS_RW_ATTR(CPRC_INFO, ckpt_req_control, ckpt_thread_ioprio, ckpt_thread_ioprio);
> >   F2FS_GENERAL_RO_ATTR(dirty_segments);
> >   F2FS_GENERAL_RO_ATTR(free_segments);
> > +F2FS_GENERAL_RO_ATTR(ovp_segments);
> 
> Missed to add document entry in Documentation/ABI/testing/sysfs-fs-f2fs?

Yeah, thanks.

> 
> Thanks,
> 
> >   F2FS_GENERAL_RO_ATTR(lifetime_write_kbytes);
> >   F2FS_GENERAL_RO_ATTR(features);
> >   F2FS_GENERAL_RO_ATTR(current_reserved_blocks);
> > 
