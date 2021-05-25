Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13DB53900F2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 14:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbhEYM1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 08:27:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:37196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232268AbhEYM1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 08:27:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 280FD613F5;
        Tue, 25 May 2021 12:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621945567;
        bh=EtIFUMHmD3veRiC7K2Y+/790eFrQYN42I/c+VbXM3IA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oRii/JRdixaYK3XunQGlbcCvmInWA/L0Ultgkk/FcxhZ973x/vMozlr5n087UAxzi
         vPV799WYkWuZT+PnuCUFVsZc4qVnVkpn80XGUiPoupPqLIvTSY4apSC0kfyMeJXzMu
         0dH/csW93PiDVVRQv7vGUfgnSzMciCPICxUb1RK6rqBZLzXeA2pvo4OfELRm5dPS7r
         /Hova4G8bE5o9AF7OwvE5KfsZYg+QXw2cfHlcRDwgXcpcLfbHPQ8Cafi97AeJnT7IS
         FHZi5l6Nc9JXozP0OSNembwUo3fXBJXgeyMZTN9rbgaNmLz6EsC5B+7zGR7fJ0cJGe
         S03DJ15HJhHtQ==
Date:   Tue, 25 May 2021 05:26:05 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH 1/2] f2fs: compress: fix to disallow wildcard extension
 for hot/cold file
Message-ID: <YKzs3anQwxEjs0tk@google.com>
References: <20210518095458.99728-1-yuchao0@huawei.com>
 <YKXHo0LAdE5fa77J@google.com>
 <96cc500d-18df-e9b5-98aa-066a2acfacc9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96cc500d-18df-e9b5-98aa-066a2acfacc9@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/20, Chao Yu wrote:
> On 2021/5/20 10:21, Jaegeuk Kim wrote:
> > On 05/18, Chao Yu wrote:
> > > If all files are hot or cold, hot/cold separation is not needed anymore,
> > > so let's disallow configure wildcard extension.
> > 
> > We need to be able to set hot/cold on the fly?
> 
> I got your concern, so do you prefer to keep "*" extension configuration
> for hot/cold file?

I'm fine with "*".

> 
> Thanks,
> 
> > 
> > > 
> > > Fixes: 4c8ff7095bef ("f2fs: support data compression")
> > > Signed-off-by: Chao Yu <yuchao0@huawei.com>
> > > ---
> > >   fs/f2fs/f2fs.h  |  1 +
> > >   fs/f2fs/namei.c | 12 ++++++++----
> > >   fs/f2fs/sysfs.c |  3 +++
> > >   3 files changed, 12 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > > index b753cc88c77e..ecb13c3b458d 100644
> > > --- a/fs/f2fs/f2fs.h
> > > +++ b/fs/f2fs/f2fs.h
> > > @@ -3322,6 +3322,7 @@ void f2fs_handle_failed_inode(struct inode *inode);
> > >   /*
> > >    * namei.c
> > >    */
> > > +bool f2fs_is_wildcard_char(const char *ext);
> > >   int f2fs_update_extension_list(struct f2fs_sb_info *sbi, const char *name,
> > >   							bool hot, bool set);
> > >   struct dentry *f2fs_get_parent(struct dentry *child);
> > > diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> > > index a9cd9cf97229..8d78b96a8b3b 100644
> > > --- a/fs/f2fs/namei.c
> > > +++ b/fs/f2fs/namei.c
> > > @@ -153,15 +153,17 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
> > >   	return ERR_PTR(err);
> > >   }
> > > +bool f2fs_is_wildcard_char(const char *ext)
> > > +{
> > > +	return *ext == '*' && strlen(ext) == 1;
> > > +}
> > > +
> > >   static inline int is_extension_exist(const unsigned char *s, const char *sub)
> > >   {
> > >   	size_t slen = strlen(s);
> > >   	size_t sublen = strlen(sub);
> > >   	int i;
> > > -	if (sublen == 1 && *sub == '*')
> > > -		return 1;
> > > -
> > >   	/*
> > >   	 * filename format of multimedia file should be defined as:
> > >   	 * "filename + '.' + extension + (optional: '.' + temp extension)".
> > > @@ -306,9 +308,11 @@ static void set_compress_inode(struct f2fs_sb_info *sbi, struct inode *inode,
> > >   	ext = F2FS_OPTION(sbi).extensions;
> > >   	for (i = 0; i < ext_cnt; i++) {
> > > +		if (f2fs_is_wildcard_char(ext[i]))
> > > +			goto set_compress;
> > >   		if (!is_extension_exist(name, ext[i]))
> > >   			continue;
> > > -
> > > +set_compress:
> > >   		set_compress_context(inode);
> > >   		return;
> > >   	}
> > > diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> > > index dc71bc968c72..ff5acb4de1b6 100644
> > > --- a/fs/f2fs/sysfs.c
> > > +++ b/fs/f2fs/sysfs.c
> > > @@ -343,6 +343,9 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
> > >   		if (strlen(name) >= F2FS_EXTENSION_LEN)
> > >   			return -EINVAL;
> > > +		if (f2fs_is_wildcard_char(name))
> > > +			return -EINVAL;
> > > +
> > >   		down_write(&sbi->sb_lock);
> > >   		ret = f2fs_update_extension_list(sbi, name, hot, set);
> > > -- 
> > > 2.29.2
> > .
> > 
