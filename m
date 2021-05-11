Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409EE379EFE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 07:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhEKFKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 01:10:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229885AbhEKFKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 01:10:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6141A6187E;
        Tue, 11 May 2021 05:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620709746;
        bh=uDrTLbqjHBuDV27sGnx7o+4XL3ViZ8fFjVCDhBcvXxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X0JIL5Kjhnm/lPR4LxScLrwHwFlTpddi/MLDiSFUaHa7YcnWQXMCM1ZpkqNWeE0HR
         AP6LvUHICb5x6XqGVaQMLg6g30axgSDLU9lioo3BVgldLxn/VFPDyoc5gkSIlDyrF7
         gd/QUhzZamRuPhpcEOibs6b6Bm+Wt4brNMEIxs0dlW3kaKHx7KeHj2JWNtZixqSSb+
         YwIMmwy6cRMrXCl7sdI1b3R+yqDOeovPSu9mIyUuIv/s2e1n/IkiZBNhuhRUnYiESl
         JoZfcE5n1l2bxcNXaiqAHEkO0N+4WfhutdO2FdIC7YT2zLL4uVuh+QSLhw0Ac7QLYO
         PNVmqROVGvqDA==
Date:   Mon, 10 May 2021 22:09:04 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     daejun7.park@samsung.com, "chao@kernel.org" <chao@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: [PATCH] f2fs: set file as cold when file defragmentation
Message-ID: <YJoRcIpW1g/OgHZn@google.com>
References: <CGME20210429062005epcms2p352ef77f96ab66cbffe0c0ab6c1b62d8a@epcms2p3>
 <20210429062005epcms2p352ef77f96ab66cbffe0c0ab6c1b62d8a@epcms2p3>
 <3a0ab201-9546-d523-abc7-79df5f637f14@huawei.com>
 <YJN0nTgadoq8vDaG@google.com>
 <bd0fa15b-01c3-9f70-3eb8-ec2b54a0ee8f@huawei.com>
 <YJlHmP/ej8/IsHL3@google.com>
 <6e95edca-4802-7650-4771-5389067935dc@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e95edca-4802-7650-4771-5389067935dc@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11, Chao Yu wrote:
> On 2021/5/10 22:47, Jaegeuk Kim wrote:
> > On 05/06, Chao Yu wrote:
> > > On 2021/5/6 12:46, Jaegeuk Kim wrote:
> > > > On 05/06, Chao Yu wrote:
> > > > > On 2021/4/29 14:20, Daejun Park wrote:
> > > > > > In file defragmentation by ioctl, all data blocks in the file are
> > > > > > re-written out-of-place. File defragmentation implies user will not update
> > > > > > and mostly read the file. So before the defragmentation, we set file
> > > > > > temperature as cold for better block allocation.
> > > > > 
> > > > > I don't think all fragmented files are cold, e.g. db file.
> > > > 
> > > > I have a bit different opinion. I think one example would be users want to
> > > > defragment a file, when the they want to get higher read bandwidth for
> > > 
> > > Multimedia file was already defined as cold file now via default extension
> > > list?
> > 
> > I just gave an example. And default is default.
> > 
> > > 
> > > > usually multimedia files. That's likely to be cold files. Moreover, I don't
> > > > think they want to defragment db files which will be fragmented soon?
> > > 
> > > I guess like db files have less update but more access?
> > 
> > I think both, and we set it as hot.
> 
> Then hot and cold bit will set to the same db file after defragmentation?

Do you set cold bit to db files? I mean, generally db is not cold, but hot.

> 
> Thanks,
> 
> > 
> > > 
> > > Thanks,
> > > 
> > > > 
> > > > > 
> > > > > We have separated interface (via f2fs_xattr_advise_handler, e.g. setfattr -n
> > > > > "system.advise" -v value) to indicate this file is a hot/cold file, so my
> > > > > suggestion is after file defragmentation, if you think this file is cold, and
> > > > > use setxattr() to set it as cold.
> > > > > 
> > > > > Thanks,
> > > > > 
> > > > > > 
> > > > > > Signed-off-by: Daejun Park <daejun7.park@samsung.com>
> > > > > > ---
> > > > > >     fs/f2fs/file.c | 3 +++
> > > > > >     1 file changed, 3 insertions(+)
> > > > > > 
> > > > > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > > > > index d697c8900fa7..dcac965a05fe 100644
> > > > > > --- a/fs/f2fs/file.c
> > > > > > +++ b/fs/f2fs/file.c
> > > > > > @@ -2669,6 +2669,9 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
> > > > > >     	map.m_len = pg_end - pg_start;
> > > > > >     	total = 0;
> > > > > > +	if (!file_is_cold(inode))
> > > > > > +		file_set_cold(inode);
> > > > > > +
> > > > > >     	while (map.m_lblk < pg_end) {
> > > > > >     		pgoff_t idx;
> > > > > >     		int cnt = 0;
> > > > > > 
> > > > .
> > > > 
> > .
> > 
