Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD33305D84
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 14:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbhA0Ns3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 08:48:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:33176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231403AbhA0NsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 08:48:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61F70207A3;
        Wed, 27 Jan 2021 13:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611755256;
        bh=vwROcIKQyMXdOuOaTz9RYp8+jyk0RITyZVQqlu+0wqI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=brzhogQ1JKPfPh3OstDTX8lGtt3YgmCR5mYIkaw+ArvvtOCYRyiR4FQlGg9IrYCoE
         5mcRry9pkgydcfKy13G2alkU+cOR8cbX6F7USVvg+LHJQYlMcY6MYcb8NLMvwjLF8y
         usLiJpC7PZzB08JO6BTDI17FCdPMdUPFGAQ5YxBE=
Date:   Wed, 27 Jan 2021 14:47:33 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Maciej =?utf-8?Q?=C5=BBenczykowski?= <zenczykowski@gmail.com>
Cc:     Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] configfs: make directories inherit uid/gid from creator
Message-ID: <YBFu9WkVMdsfy51I@kroah.com>
References: <20210123205516.2738060-1-zenczykowski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210123205516.2738060-1-zenczykowski@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 23, 2021 at 12:55:16PM -0800, Maciej Żenczykowski wrote:
> From: Maciej Żenczykowski <maze@google.com>
> 
> Currently a non-root process can create directories, but cannot
> create stuff in the directories it creates.

Isn't that on purpose?

> 
> Example (before this patch):
>   phone:/ $ id
>   uid=1000(system) gid=1000(system) groups=1000(system),... context=u:r:su:s0
> 
>   phone:/ $ cd /config/usb_gadget/g1/configs/
> 
>   phone:/config/usb_gadget/g1/configs $ ls -lZ
>   drwxr-xr-x 3 system system u:object_r:configfs:s0  0 2020-12-28 06:03 b.1
> 
>   phone:/config/usb_gadget/g1/configs $ mkdir b.2
> 
>   phone:/config/usb_gadget/g1/configs $ ls -lZ
>   drwxr-xr-x 3 system system u:object_r:configfs:s0  0 2020-12-28 06:03 b.1
>   drwxr-xr-x 3 root   root   u:object_r:configfs:s0  0 2020-12-28 06:51 b.2
> 
>   phone:/config/usb_gadget/g1/configs $ chown system:system b.2
>   chown: 'b.2' to 'system:system': Operation not permitted
> 
>   phone:/config/usb_gadget/g1/configs $ ls -lZ b.1
>   -rw-r--r-- 1 system system u:object_r:configfs:s0  4096 2020-12-28 05:23 MaxPower
>   -rw-r--r-- 1 system system u:object_r:configfs:s0  4096 2020-12-28 05:23 bmAttributes
>   lrwxrwxrwx 1 root   root   u:object_r:configfs:s0     0 2020-12-28 05:23 function0 -> ../../../../usb_gadget/g1/functions/ffs.adb
>   drwxr-xr-x 2 system system u:object_r:configfs:s0     0 2020-12-28 05:23 strings
> 
>   phone:/config/usb_gadget/g1/configs $ ln -s ../../../../usb_gadget/g1/functions/ffs.adb b.2/function0
>   ln: cannot create symbolic link from '../../../../usb_gadget/g1/functions/ffs.adb' to 'b.2/function0': Permission denied
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Joel Becker <jlbec@evilplan.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Maciej Żenczykowski <maze@google.com>
> Change-Id: Ia907b2def940197b44aa87b337d37c5dde9c5b91

No need for "Change-Id:" :)

> ---
>  fs/configfs/dir.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
> index b839dd1b459f..04f18402ef7c 100644
> --- a/fs/configfs/dir.c
> +++ b/fs/configfs/dir.c
> @@ -1410,6 +1410,21 @@ static int configfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode
>  	else
>  		ret = configfs_attach_item(parent_item, item, dentry, frag);
>  
> +	/* inherit uid/gid from process creating the directory */
> +	if (!uid_eq(current_fsuid(), GLOBAL_ROOT_UID) ||
> +	    !gid_eq(current_fsgid(), GLOBAL_ROOT_GID)) {
> +		struct inode * inode = d_inode(dentry);
> +		struct iattr ia = {
> +			.ia_uid = current_fsuid(),
> +			.ia_gid = current_fsgid(),
> +			.ia_valid = ATTR_UID | ATTR_GID,
> +		};
> +		inode->i_uid = ia.ia_uid;
> +		inode->i_gid = ia.ia_gid;
> +		/* (note: the above manual assignments skip the permission checks) */
> +		(void)configfs_setattr(dentry, &ia);

No need for (void), here, right?

And this feels like a big user-visible change, what is going to break
with this?

thanks,

greg k-h
