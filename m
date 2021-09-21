Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312A7412EFF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 09:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhIUHFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 03:05:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:50896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230020AbhIUHFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 03:05:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 697E961183;
        Tue, 21 Sep 2021 07:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632207827;
        bh=mQuKWQo9X6JaJZ7Qid4y074fGnCtlx3T1Uh750N/tEs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yhtWj7GHyb/Hq3YLZXfZPlNogmK+oV2YZqLjFwHz5QEeOVIOQ24hElvvY+55X6RAp
         k+uA+r3rxqR0ke0ZpaUG1iog7FtXXJHHGNx9/beGQCdcn2wpq8K3BiGMMkbFWZpc8j
         S+rOuecgOJYh5v3k5btl7iI0wnWevUXglHwvk0e0=
Date:   Tue, 21 Sep 2021 09:03:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     "Das, Nirmoy" <nirmoy.das@amd.com>, rafael@kernel.org,
        linux-kernel@vger.kernel.org, Nirmoy Das <nirmoy.aiemd@gmail.com>
Subject: Re: [PATCH 1/1] debugfs: use IS_ERR to check for error
Message-ID: <YUmD0ENc27Lv5Cy5@kroah.com>
References: <20210902102917.2233-1-nirmoy.das@amd.com>
 <YTCpuo00wM7jGSIc@kroah.com>
 <5ab7739d-15a4-2e84-0320-fee8d5df1e83@amd.com>
 <YTDBfO/byKzGWV8G@kroah.com>
 <c918f1a5-7c88-bf47-14b6-b6e892695951@amd.com>
 <YTD8+tLP7KeGRXEc@kroah.com>
 <a6817cbd-b43d-5334-3e1e-62c1cd99e8fc@amd.com>
 <c170c646-0db4-52ac-6008-4a9199609ee0@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c170c646-0db4-52ac-6008-4a9199609ee0@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2021 at 08:27:34AM +0200, Christian König wrote:
> Am 02.09.21 um 19:01 schrieb Das, Nirmoy:
> > 
> > On 9/2/2021 6:34 PM, Greg KH wrote:
> > > On Thu, Sep 02, 2021 at 05:10:24PM +0200, Christian König wrote:
> > > > Am 02.09.21 um 14:20 schrieb Greg KH:
> > > > > On Thu, Sep 02, 2021 at 02:03:12PM +0200, Christian König wrote:
> > > > > > Am 02.09.21 um 12:38 schrieb Greg KH:
> > > > > > > On Thu, Sep 02, 2021 at 12:29:17PM +0200, Nirmoy Das wrote:
> > > > > > > > debugfs_create_file() returns encoded error so
> > > > > > > > use IS_ERR for checking return value.
> > > > > > > > 
> > > > > > > > References: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1686&amp;data=04%7C01%7Cnirmoy.das%40amd.com%7C7a1f1095c0d64416576c08d96e2f7b38%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637661973378236086%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=g9BQRJG8gvjGFq6oj5vk9PCemQ39U19CLmkMNHVUafg%3D&amp;reserved=0
> > > > > > > > Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> > > > > > > > ---
> > > > > > > >     fs/debugfs/inode.c | 2 +-
> > > > > > > >     1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > > 
> > > > > > > > diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> > > > > > > > index 8129a430d789..2f117c57160d 100644
> > > > > > > > --- a/fs/debugfs/inode.c
> > > > > > > > +++ b/fs/debugfs/inode.c
> > > > > > > > @@ -528,7 +528,7 @@ void
> > > > > > > > debugfs_create_file_size(const char *name,
> > > > > > > > umode_t mode,
> > > > > > > >     {
> > > > > > > >         struct dentry *de =
> > > > > > > > debugfs_create_file(name, mode, parent, data,
> > > > > > > > fops);
> > > > > > > > -    if (de)
> > > > > > > > +    if (!IS_ERR(de))
> > > > > > > >             d_inode(de)->i_size = file_size;
> > > > > > > >     }
> > > > > > > >     EXPORT_SYMBOL_GPL(debugfs_create_file_size);
> > > > > > > > -- 
> > > > > > > > 2.32.0
> > > > > > > > 
> > > > > > > Ah, good catch, I'll queue this up after 5.15-rc1 is out, thanks!
> > > > > > Thinking more about this if I'm not completely mistaken
> > > > > > debugfs_create_file() returns -ENODEV when debugfs is
> > > > > > disabled and NULL on
> > > > > > any other error.
> > > > > How can this function be called if debugfs is not enabled in
> > > > > the system
> > > > > configuration?  This _is_ the debugfs core code.
> > > > Well, that's what I meant. The original code is correct and
> > > > Nirmoy's patch
> > > > here is breaking it.
> > > Ah, yes, sorry, you are right.  This function can not return an error
> > > value, if something went wrong, the result will always be NULL.
> > 
> > 
> > I just realized that we don't return NULL on error anymore:
> > 
> > commit ff9fb72bc07705c00795ca48631f7fffe24d2c6b
> > Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Date:   Wed Jan 23 11:28:14 2019 +0100
> > 
> >     debugfs: return error values, not NULL
> > 
> > 
> > and the current doc also says "If an error occurs, ERR_PTR(-ERROR) will
> > be returned."
> > 
> > If I am not missing anything, this patch should be fine.
> 
> Ah! Yes, now that makes sense.
> 
> Looks like that my memory and the documentation under
> https://www.kernel.org/doc/htmldocs/filesystems/API-debugfs-create-file.html
> is outdated.
> 
> I can update my memory, but I have no idea where this documentation comes
> from and how to fix it.

I do not know how that is created either, it looks very old.  This link
should always be used instead:
	https://www.kernel.org/doc/html/latest/index.html

thanks,

greg k-h
