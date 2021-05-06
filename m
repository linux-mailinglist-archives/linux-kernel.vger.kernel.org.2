Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 194C5374EAC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 06:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbhEFEtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 00:49:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232097AbhEFEsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 00:48:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 032FF610FA;
        Thu,  6 May 2021 04:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620276383;
        bh=zdcpYsjq/LphvbQv7Zuthak4zPjOF67RloOr7IcUpVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IVQUJBNyHp5vKHHfgOo4IpQlo9/7fegK57l9M3nTuzqhuWZLNtGqQF4gpQVCzlGZd
         D6g1IITSgS4K1xXCc0Te09mDDUWDQnbn9GakeLEPQXEW0UtR2Ln0PKBfIxbj4NfMxs
         jNA5YB4B66FcwVZjlSI0n5acqeW6MY5/qm8SyKZ+wzMD7XYBU/w7nC8RThXRCle7Zs
         +870I3Gxqc9wRfugo4PICfeq2SMKX2D5ZAC4cloUzQSDox7iKrOYKvMnxIqwi2xzaV
         VLqx2ujLnh/Pq4UDuTmZN8c8Lf+Bj1laUVCSAZbcmAJzVl5mlxfJ9EzzfVEgUS42oL
         8DZd1RsNwujkA==
Date:   Wed, 5 May 2021 21:46:21 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     daejun7.park@samsung.com, "chao@kernel.org" <chao@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: [PATCH] f2fs: set file as cold when file defragmentation
Message-ID: <YJN0nTgadoq8vDaG@google.com>
References: <CGME20210429062005epcms2p352ef77f96ab66cbffe0c0ab6c1b62d8a@epcms2p3>
 <20210429062005epcms2p352ef77f96ab66cbffe0c0ab6c1b62d8a@epcms2p3>
 <3a0ab201-9546-d523-abc7-79df5f637f14@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a0ab201-9546-d523-abc7-79df5f637f14@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06, Chao Yu wrote:
> On 2021/4/29 14:20, Daejun Park wrote:
> > In file defragmentation by ioctl, all data blocks in the file are
> > re-written out-of-place. File defragmentation implies user will not update
> > and mostly read the file. So before the defragmentation, we set file
> > temperature as cold for better block allocation.
> 
> I don't think all fragmented files are cold, e.g. db file.

I have a bit different opinion. I think one example would be users want to
defragment a file, when the they want to get higher read bandwidth for
usually multimedia files. That's likely to be cold files. Moreover, I don't
think they want to defragment db files which will be fragmented soon?

> 
> We have separated interface (via f2fs_xattr_advise_handler, e.g. setfattr -n
> "system.advise" -v value) to indicate this file is a hot/cold file, so my
> suggestion is after file defragmentation, if you think this file is cold, and
> use setxattr() to set it as cold.
> 
> Thanks,
> 
> > 
> > Signed-off-by: Daejun Park <daejun7.park@samsung.com>
> > ---
> >   fs/f2fs/file.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index d697c8900fa7..dcac965a05fe 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -2669,6 +2669,9 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
> >   	map.m_len = pg_end - pg_start;
> >   	total = 0;
> > +	if (!file_is_cold(inode))
> > +		file_set_cold(inode);
> > +
> >   	while (map.m_lblk < pg_end) {
> >   		pgoff_t idx;
> >   		int cnt = 0;
> > 
