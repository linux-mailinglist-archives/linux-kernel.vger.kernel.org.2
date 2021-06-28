Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF21B3B5945
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 08:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbhF1GuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 02:50:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232166AbhF1GuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 02:50:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7BB47619B6;
        Mon, 28 Jun 2021 06:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624862863;
        bh=j1K+vMODTMBa9yGZCvQC9vRUeL8g0T5aiKCSAl60vuM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0k0mCoCyi45DfFxb9GQeL1gJ3lSwIDvmzWdDdfusbrlucMPXkQJu81GJXDnfBMK2B
         j+BcftoZJfwAghDEa8xXFhLk92al7uYfsirA284b3wDwa73WlH+BB8pNOxSN/mRxXu
         hTEl6tsv2D6HCcMNtRUdG1u7lThAstKsy9qfRHJo=
Date:   Mon, 28 Jun 2021 08:47:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     13145886936@163.com
Cc:     tj@kernel.org, linux-kernel@vger.kernel.org,
        gushengxian <gushengxian@yulong.com>
Subject: Re: [PATCH] kernfs: Simplify if--else codes
Message-ID: <YNlwjchu6QMVpc6g@kroah.com>
References: <20210628060155.1509993-1-13145886936@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628060155.1509993-1-13145886936@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 27, 2021 at 11:01:55PM -0700, 13145886936@163.com wrote:
> From: gushengxian <gushengxian@yulong.com>
> 
> Simplify if--else codes.
> 
> Signed-off-by: gushengxian <13145886936@163.com>
> Signed-off-by: gushengxian <gushengxian@yulong.com>
> ---
>  fs/kernfs/file.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> index c75719312147..6bd531419f30 100644
> --- a/fs/kernfs/file.c
> +++ b/fs/kernfs/file.c
> @@ -644,10 +644,7 @@ static int kernfs_fop_open(struct inode *inode, struct file *file)
>  	 * Both paths of the branch look the same.  They're supposed to
>  	 * look that way and give @of->mutex different static lockdep keys.
>  	 */
> -	if (has_mmap)
> -		mutex_init(&of->mutex);
> -	else
> -		mutex_init(&of->mutex);
> +	mutex_init(&of->mutex);

Please always read the code, and the comments, you are modifying before
you modify it :(

This is a sign you are doing "blind" code cleanups.  Please stick with
drivers/staging/ for now as that part of the kernel accepts them much
easier than the rest of the kernel does.

thanks,

greg k-h
