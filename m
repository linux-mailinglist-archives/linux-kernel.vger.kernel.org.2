Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 453B23F6ECE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 07:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbhHYF3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 01:29:50 -0400
Received: from verein.lst.de ([213.95.11.211]:54736 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229457AbhHYF3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 01:29:48 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id EE8D96736F; Wed, 25 Aug 2021 07:29:00 +0200 (CEST)
Date:   Wed, 25 Aug 2021 07:29:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Gong, Sishuai" <sishuai@purdue.edu>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] configfs: fix a race in configfs_lookup()
Message-ID: <20210825052900.GA26714@lst.de>
References: <20210820214458.14087-1-sishuai@purdue.edu> <20210823074636.GA23822@lst.de> <AFABA8B1-0523-4F8C-A9DD-DDC5638DEAF7@purdue.edu> <20210823170847.GA617@lst.de> <YSXSyGliOy9BCLkj@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSXSyGliOy9BCLkj@zeniv-ca.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 05:19:04AM +0000, Al Viro wrote:
> On Mon, Aug 23, 2021 at 07:08:47PM +0200, Christoph Hellwig wrote:
> 
> > We can't hold a spinlock over inode allocation.  So it would have to be
> > something like this:
> 
> Check for -ENAMETOOLONG first; easier for analysis that way.

Indeed.

> > +			dentry->d_fsdata = configfs_get(sd);
> > +			sd->s_dentry = dentry;
> > +			spin_unlock(&configfs_dirent_lock);
> >  
> > -			found = 1;
> > -			err = configfs_attach_attr(sd, dentry);
> > -			break;
> > +			inode = configfs_create(dentry, mode);
> > +			if (IS_ERR(inode)) {
> > +				configfs_put(sd);
> > +				return ERR_CAST(inode);
> 
> Er...  Won't that leave dentry with dangling ->d_fsdata?

Yes.  Existing problem, though.
