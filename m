Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945A636C5A4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 13:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236038AbhD0Lze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 07:55:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:58824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230365AbhD0Lzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 07:55:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD207613D1;
        Tue, 27 Apr 2021 11:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619524490;
        bh=dCGJFVdD2TOwzh2s6fuc7Ms91bZRRTyrTv18wTwGR2k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tR0bWlm6Mi2oSqEH5zhDIhsyXxatZh5TEhjzQgxnMQnFpmxT/sxLdEej4UnZx0AxX
         bLGAcAwWx6egMO7CwZNT4WFSHjY3Skhiw18R2PJufPh3CZWQXnWMDjPIGX2ubu8FfP
         2fx9h+Bs+bxd9x72s31mKod1pbR1tmxNCuTSDwnA=
Date:   Tue, 27 Apr 2021 13:54:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>
Subject: Re: [PATCH 060/190] Revert "staging: kpc2000: remove unnecessary
 assertions in kpc_dma_transfer"
Message-ID: <YIf7h/G8VOz02VgZ@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-61-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-61-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:58:55PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit d7a336d67ab5443a0ef14b8335d139e855e8a682.
> 
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
> 
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
> 
> Cc: Aditya Pakki <pakki001@umn.edu>
> Cc: https
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/staging/kpc2000/kpc_dma/fileops.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
> index 10dcd6646b01..7fdad86044ca 100644
> --- a/drivers/staging/kpc2000/kpc_dma/fileops.c
> +++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
> @@ -49,7 +49,9 @@ static int kpc_dma_transfer(struct dev_private_data *priv,
>  	u64 dma_addr;
>  	u64 user_ctl;
>  
> +	BUG_ON(priv == NULL);
>  	ldev = priv->ldev;
> +	BUG_ON(ldev == NULL);
>  
>  	acd = kzalloc(sizeof(*acd), GFP_KERNEL);
>  	if (!acd) {
> -- 
> 2.31.1

This one looks fine, I'm dropping it.

greg k-h
