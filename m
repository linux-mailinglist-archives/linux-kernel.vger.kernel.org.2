Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955993FF180
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 18:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346369AbhIBQfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 12:35:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242414AbhIBQfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 12:35:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 83320600CC;
        Thu,  2 Sep 2021 16:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630600445;
        bh=I+UdrRBmYFaWK3oBwVCt9HxFGvt0IAgmwkIcUTzH7xM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EYIycoiS5EF3FWRx/vNxubQ06zX8ZPKHRyGJTPNQq+7cwO6+yfdMCnmYnI6UNiPUE
         h9r2HTL+RdQEelKGYZjBkV1rQmaf1QL2LFl9wqnWD8qazN4dAfL9tea2QrFUIhdNzq
         ubCmcMX93xfR8O8fnm6xSVzA5paUUiuArWQGMaPs=
Date:   Thu, 2 Sep 2021 18:34:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Nirmoy Das <nirmoy.das@amd.com>, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] debugfs: use IS_ERR to check for error
Message-ID: <YTD8+tLP7KeGRXEc@kroah.com>
References: <20210902102917.2233-1-nirmoy.das@amd.com>
 <YTCpuo00wM7jGSIc@kroah.com>
 <5ab7739d-15a4-2e84-0320-fee8d5df1e83@amd.com>
 <YTDBfO/byKzGWV8G@kroah.com>
 <c918f1a5-7c88-bf47-14b6-b6e892695951@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c918f1a5-7c88-bf47-14b6-b6e892695951@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 05:10:24PM +0200, Christian König wrote:
> Am 02.09.21 um 14:20 schrieb Greg KH:
> > On Thu, Sep 02, 2021 at 02:03:12PM +0200, Christian König wrote:
> > > 
> > > Am 02.09.21 um 12:38 schrieb Greg KH:
> > > > On Thu, Sep 02, 2021 at 12:29:17PM +0200, Nirmoy Das wrote:
> > > > > debugfs_create_file() returns encoded error so
> > > > > use IS_ERR for checking return value.
> > > > > 
> > > > > References: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1686&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7Cffc1109aeb744082181b08d96e0c06db%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637661820207117289%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=6NDHX9sEhGF2jakVfUJ7Qurql6UAdNpFQZ6XvCjwz0E%3D&amp;reserved=0
> > > > > Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> > > > > ---
> > > > >    fs/debugfs/inode.c | 2 +-
> > > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> > > > > index 8129a430d789..2f117c57160d 100644
> > > > > --- a/fs/debugfs/inode.c
> > > > > +++ b/fs/debugfs/inode.c
> > > > > @@ -528,7 +528,7 @@ void debugfs_create_file_size(const char *name, umode_t mode,
> > > > >    {
> > > > >    	struct dentry *de = debugfs_create_file(name, mode, parent, data, fops);
> > > > > -	if (de)
> > > > > +	if (!IS_ERR(de))
> > > > >    		d_inode(de)->i_size = file_size;
> > > > >    }
> > > > >    EXPORT_SYMBOL_GPL(debugfs_create_file_size);
> > > > > -- 
> > > > > 2.32.0
> > > > > 
> > > > Ah, good catch, I'll queue this up after 5.15-rc1 is out, thanks!
> > > Thinking more about this if I'm not completely mistaken
> > > debugfs_create_file() returns -ENODEV when debugfs is disabled and NULL on
> > > any other error.
> > How can this function be called if debugfs is not enabled in the system
> > configuration?  This _is_ the debugfs core code.
> 
> Well, that's what I meant. The original code is correct and Nirmoy's patch
> here is breaking it.

Ah, yes, sorry, you are right.  This function can not return an error
value, if something went wrong, the result will always be NULL.

> Nirmoys other patch is for a driver and there the function can indeed return
> both error code and NULL.

You should never be checking this stuff in a caller anyway, so no, don't
do it there either.

thanks,

greg k-h
