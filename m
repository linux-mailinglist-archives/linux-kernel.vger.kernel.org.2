Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A0D3F6EC0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 07:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbhHYFT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 01:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhHYFT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 01:19:56 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60530C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 22:19:11 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIlJY-00FqEt-Gy; Wed, 25 Aug 2021 05:19:04 +0000
Date:   Wed, 25 Aug 2021 05:19:04 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Gong, Sishuai" <sishuai@purdue.edu>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] configfs: fix a race in configfs_lookup()
Message-ID: <YSXSyGliOy9BCLkj@zeniv-ca.linux.org.uk>
References: <20210820214458.14087-1-sishuai@purdue.edu>
 <20210823074636.GA23822@lst.de>
 <AFABA8B1-0523-4F8C-A9DD-DDC5638DEAF7@purdue.edu>
 <20210823170847.GA617@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210823170847.GA617@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 07:08:47PM +0200, Christoph Hellwig wrote:

> We can't hold a spinlock over inode allocation.  So it would have to be
> something like this:

Check for -ENAMETOOLONG first; easier for analysis that way.

> +			dentry->d_fsdata = configfs_get(sd);
> +			sd->s_dentry = dentry;
> +			spin_unlock(&configfs_dirent_lock);
>  
> -			found = 1;
> -			err = configfs_attach_attr(sd, dentry);
> -			break;
> +			inode = configfs_create(dentry, mode);
> +			if (IS_ERR(inode)) {
> +				configfs_put(sd);
> +				return ERR_CAST(inode);

Er...  Won't that leave dentry with dangling ->d_fsdata?
