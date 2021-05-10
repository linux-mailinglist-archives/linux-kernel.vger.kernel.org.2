Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C28379149
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbhEJOu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:50:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:43566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240155AbhEJOs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:48:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D39C6613EE;
        Mon, 10 May 2021 14:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620658074;
        bh=U1Sin8G9z22lt/bG16uwURi9Dx9x0iPEy+hh0JwsyFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=keNT+x7eXINKGEsJIphXo/QIJgeq7qQ7hSW/4o7eDnsiV3M2kbnWFnQjxQfNNkWOP
         QRFQwO6m1qJm8z23q27NduE8oC6dFpzAC1BCf6M/FVBiJHjTYBIqkmybdCi5D4A8Zp
         te+AzqDsju6ArT4jrY4sjg4XMZpRNE52wLzW+PGfn6EEREeA1MiQIDgA3lsqX8bzld
         NjG5MlM3PZ5XtO+OAndj28ryhCy2Bqsz3+ds+olNXNzWkdA9HHq+ZcrWe51Ef5i218
         xM+l2lg9lOKjZUxMfOCZHTQyNPHue+mjAiDJ7I9iq4bA+TCE2GJsbVQpjv+8Z90Rz9
         sn2IV4Q8m8O3A==
Date:   Mon, 10 May 2021 07:47:52 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     daejun7.park@samsung.com, "chao@kernel.org" <chao@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: [PATCH] f2fs: set file as cold when file defragmentation
Message-ID: <YJlHmP/ej8/IsHL3@google.com>
References: <CGME20210429062005epcms2p352ef77f96ab66cbffe0c0ab6c1b62d8a@epcms2p3>
 <20210429062005epcms2p352ef77f96ab66cbffe0c0ab6c1b62d8a@epcms2p3>
 <3a0ab201-9546-d523-abc7-79df5f637f14@huawei.com>
 <YJN0nTgadoq8vDaG@google.com>
 <bd0fa15b-01c3-9f70-3eb8-ec2b54a0ee8f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd0fa15b-01c3-9f70-3eb8-ec2b54a0ee8f@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06, Chao Yu wrote:
> On 2021/5/6 12:46, Jaegeuk Kim wrote:
> > On 05/06, Chao Yu wrote:
> > > On 2021/4/29 14:20, Daejun Park wrote:
> > > > In file defragmentation by ioctl, all data blocks in the file are
> > > > re-written out-of-place. File defragmentation implies user will not update
> > > > and mostly read the file. So before the defragmentation, we set file
> > > > temperature as cold for better block allocation.
> > > 
> > > I don't think all fragmented files are cold, e.g. db file.
> > 
> > I have a bit different opinion. I think one example would be users want to
> > defragment a file, when the they want to get higher read bandwidth for
> 
> Multimedia file was already defined as cold file now via default extension
> list?

I just gave an example. And default is default.

> 
> > usually multimedia files. That's likely to be cold files. Moreover, I don't
> > think they want to defragment db files which will be fragmented soon?
> 
> I guess like db files have less update but more access?

I think both, and we set it as hot.

> 
> Thanks,
> 
> > 
> > > 
> > > We have separated interface (via f2fs_xattr_advise_handler, e.g. setfattr -n
> > > "system.advise" -v value) to indicate this file is a hot/cold file, so my
> > > suggestion is after file defragmentation, if you think this file is cold, and
> > > use setxattr() to set it as cold.
> > > 
> > > Thanks,
> > > 
> > > > 
> > > > Signed-off-by: Daejun Park <daejun7.park@samsung.com>
> > > > ---
> > > >    fs/f2fs/file.c | 3 +++
> > > >    1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > > index d697c8900fa7..dcac965a05fe 100644
> > > > --- a/fs/f2fs/file.c
> > > > +++ b/fs/f2fs/file.c
> > > > @@ -2669,6 +2669,9 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
> > > >    	map.m_len = pg_end - pg_start;
> > > >    	total = 0;
> > > > +	if (!file_is_cold(inode))
> > > > +		file_set_cold(inode);
> > > > +
> > > >    	while (map.m_lblk < pg_end) {
> > > >    		pgoff_t idx;
> > > >    		int cnt = 0;
> > > > 
> > .
> > 
