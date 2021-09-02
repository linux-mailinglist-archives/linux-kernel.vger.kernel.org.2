Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD8D3FEC41
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 12:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243699AbhIBKjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 06:39:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:59922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233714AbhIBKjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 06:39:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE23060FC0;
        Thu,  2 Sep 2021 10:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630579133;
        bh=NMGhKYahMW2rDY0ByMqQVIirb8+NxXtz6C6xR4Zoao0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KKk+sNuNNpYA/AMQ1kXuzG3WjfS1tV91jm/FSuKyK9+q+CrQO0fSpwgHy2ky8bykI
         zmBJ/H7sBkLXnz9vKKLshLm4JG4/2qqKQSPf4UVJSplga7wwG9cQ86x0CeISVpqpf3
         HkfpVBocD6wtOJwn4cR0aH8ZcCBCe5MlTt0+aows=
Date:   Thu, 2 Sep 2021 12:38:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nirmoy Das <nirmoy.das@amd.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        Christian.Koenig@amd.com
Subject: Re: [PATCH 1/1] debugfs: use IS_ERR to check for error
Message-ID: <YTCpuo00wM7jGSIc@kroah.com>
References: <20210902102917.2233-1-nirmoy.das@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902102917.2233-1-nirmoy.das@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 12:29:17PM +0200, Nirmoy Das wrote:
> debugfs_create_file() returns encoded error so
> use IS_ERR for checking return value.
> 
> References: https://gitlab.freedesktop.org/drm/amd/-/issues/1686
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>  fs/debugfs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index 8129a430d789..2f117c57160d 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -528,7 +528,7 @@ void debugfs_create_file_size(const char *name, umode_t mode,
>  {
>  	struct dentry *de = debugfs_create_file(name, mode, parent, data, fops);
>  
> -	if (de)
> +	if (!IS_ERR(de))
>  		d_inode(de)->i_size = file_size;
>  }
>  EXPORT_SYMBOL_GPL(debugfs_create_file_size);
> -- 
> 2.32.0
> 

Ah, good catch, I'll queue this up after 5.15-rc1 is out, thanks!

greg k-h
