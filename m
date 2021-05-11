Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D7537B0FA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 23:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhEKVsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 17:48:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:55314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhEKVsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 17:48:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84F26611F1;
        Tue, 11 May 2021 21:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620769644;
        bh=ETXRZR/HWxVHGLjQE9b0GOv3YJdjBNysrbBoj0QJ/6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UmJFotuJwk2WmkbYL5Kt2j3aShJLYIDMBGhT5K4Mocz8QoSUTyFA7Pj1fyITdGoz6
         4VUdVeXSQnAPgJ04SZwzGktrX+h+zYebkQ3C6CpJDirIp2XQfOz8HnqzfIkBalnUWb
         f9CyuxpSJwBehh4+ttZgOneF+z1IBXhNjDvo0+Ac0WStE1lkJx76nZ0/FoU8ydPnXI
         PGrqgQ/oH00u4r/g8ZDq3yNNOTWpZ7BchBDUd+IZ+wYFC0BWHHrUVNsdVUDNEulTer
         Ce8Ak7VFG8eYqMy8DUhQMDux/tUVs9Mv9oVvppELuFSmdLNQT2WSecSqZNEfJp0/yu
         JUSH7WZLAI5Bg==
Date:   Tue, 11 May 2021 14:47:23 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     daejun7.park@samsung.com, "chao@kernel.org" <chao@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: [PATCH] f2fs: set file as cold when file defragmentation
Message-ID: <YJr7axIRZcTDrAWE@google.com>
References: <20210429062005epcms2p352ef77f96ab66cbffe0c0ab6c1b62d8a@epcms2p3>
 <3a0ab201-9546-d523-abc7-79df5f637f14@huawei.com>
 <YJN0nTgadoq8vDaG@google.com>
 <bd0fa15b-01c3-9f70-3eb8-ec2b54a0ee8f@huawei.com>
 <YJlHmP/ej8/IsHL3@google.com>
 <6e95edca-4802-7650-4771-5389067935dc@huawei.com>
 <YJoRcIpW1g/OgHZn@google.com>
 <CGME20210429062005epcms2p352ef77f96ab66cbffe0c0ab6c1b62d8a@epcms2p1>
 <20210511064156epcms2p1351480bea36733f2e00022bd295e829e@epcms2p1>
 <771a05fe-e26f-d635-5f8d-5be72f82345f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <771a05fe-e26f-d635-5f8d-5be72f82345f@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11, Chao Yu wrote:
> On 2021/5/11 14:41, Daejun Park wrote:
> > > On 2021/5/11 13:09, Jaegeuk Kim wrote:
> > > > On 05/11, Chao Yu wrote:
> > > > > On 2021/5/10 22:47, Jaegeuk Kim wrote:
> > > > > > On 05/06, Chao Yu wrote:
> > > > > > > On 2021/5/6 12:46, Jaegeuk Kim wrote:
> > > > > > > > On 05/06, Chao Yu wrote:
> > > > > > > > > On 2021/4/29 14:20, Daejun Park wrote:
> > > > > > > > > > In file defragmentation by ioctl, all data blocks in the file are
> > > > > > > > > > re-written out-of-place. File defragmentation implies user will not update
> > > > > > > > > > and mostly read the file. So before the defragmentation, we set file
> > > > > > > > > > temperature as cold for better block allocation.
> > > > > > > > > 
> > > > > > > > > I don't think all fragmented files are cold, e.g. db file.
> > > > > > > > 
> > > > > > > > I have a bit different opinion. I think one example would be users want to
> > > > > > > > defragment a file, when the they want to get higher read bandwidth for
> > > > > > > 
> > > > > > > Multimedia file was already defined as cold file now via default extension
> > > > > > > list?
> > > > > > 
> > > > > > I just gave an example. And default is default.
> > > > > > 
> > > > > > > 
> > > > > > > > usually multimedia files. That's likely to be cold files. Moreover, I don't
> > > > > > > > think they want to defragment db files which will be fragmented soon?
> > > > > > > 
> > > > > > > I guess like db files have less update but more access?
> > > > > > 
> > > > > > I think both, and we set it as hot.
> > > > > 
> > > > > Then hot and cold bit will set to the same db file after defragmentation?
> > > > 
> > > > Do you set cold bit to db files? I mean, generally db is not cold, but hot.
> > > 
> > > I never set cold bit to db files, I mean if we defragment db file which
> > > has less update and more access, db file may have bot hot and cold bit.
> > > 
> > > To Daejun, may I ask that is Samsung planning to use this defragment ioctl
> > > in products? what's the user scenario?
> > 
> > It is just my idea for defragmentation, not Samsung.
> 
> Alright,
> 
> > I think the user will call the defrag ioctl for the files that have been updated.
> 
> Sadly, I don't see there is any user of this defragment interface since it was
> been introduced... so I really don't know the real use scenario of this interface
> now.
> 
> > 
> > On the other hand, I think FS should be able to support defrag file even
> > when in-place update is applied. What do you think?
> 
> bool f2fs_should_update_inplace(struct inode *inode, struct f2fs_io_info *fio)
> {
> 	if (f2fs_is_pinned_file(inode))
> 		return true;
> 
> 	/* if this is cold file, we should overwrite to avoid fragmentation */
> 	if (file_is_cold(inode))
> 		return true;
> 
> If cold bit was set, later rewrite in defragment interface can only trigger
> IPU due to above IPU policy check, so after this interface, file is still
> fragmented... what's the difference compared to just setting cold bit via
> setxattr?
> 
> And if user know that he will trigger less update and more read in the file,
> why not just calling setxattr("system.advise", cold_bit) to set the file as
> cold before it becomes fragmented, e.g. at the time of file creation?

yea, actually user can set it whatever they want after defragment. :P

> 
> Thanks,
> 
> > 
> > Thanks,
> > Daejun
> > > 
> > > Thanks,
> > > 
> > > > 
> > > > > 
> > > > > Thanks,
> > > > > 
> > > > > > 
> > > > > > > 
> > > > > > > Thanks,
> > > > > > > 
> > > > > > > > 
> > > > > > > > > 
> > > > > > > > > We have separated interface (via f2fs_xattr_advise_handler, e.g. setfattr -n
> > > > > > > > > "system.advise" -v value) to indicate this file is a hot/cold file, so my
> > > > > > > > > suggestion is after file defragmentation, if you think this file is cold, and
> > > > > > > > > use setxattr() to set it as cold.
> > > > > > > > > 
> > > > > > > > > Thanks,
> > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > Signed-off-by: Daejun Park <daejun7.park@samsung.com>
> > > > > > > > > > ---
> > > > > > > > > >       fs/f2fs/file.c | 3 +++
> > > > > > > > > >       1 file changed, 3 insertions(+)
> > > > > > > > > > 
> > > > > > > > > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > > > > > > > > index d697c8900fa7..dcac965a05fe 100644
> > > > > > > > > > --- a/fs/f2fs/file.c
> > > > > > > > > > +++ b/fs/f2fs/file.c
> > > > > > > > > > @@ -2669,6 +2669,9 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
> > > > > > > > > >               map.m_len = pg_end - pg_start;
> > > > > > > > > >               total = 0;
> > > > > > > > > > +        if (!file_is_cold(inode))
> > > > > > > > > > +                file_set_cold(inode);
> > > > > > > > > > +
> > > > > > > > > >               while (map.m_lblk < pg_end) {
> > > > > > > > > >                       pgoff_t idx;
> > > > > > > > > >                       int cnt = 0;
> > > > > > > > > > 
> > > > > > > > .
> > > > > > > > 
> > > > > > .
> > > > > > 
> > > > .
> > > > 
> > > 
> > > 
> > .
> > 
