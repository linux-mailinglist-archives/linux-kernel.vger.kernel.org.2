Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728C336C969
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbhD0Q1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:27:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:53314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237939AbhD0Q0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:26:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED1F761182;
        Tue, 27 Apr 2021 16:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619540720;
        bh=dVj+rE/0pybYckf2YJebySw7gD5D3H/YW7IeZID/EZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=puuu/0x+9xK+yNkQpE2fYPUOCHjPOXm3tSaIAsbcAmnyO1gYrUb2biatY+KNNxo4H
         PRxm4cKGx8krqnUqswc6QsgEAwgcTc6KQBSfOqswl0feAWU3YZfSa8/ena19FTWlaI
         ur6J+uihjpUBjZvmx/poYiGDgkaG7bWwYOZHGf1A=
Date:   Tue, 27 Apr 2021 18:25:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>, Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH 019/190] Revert "drm/nouveau/drm/noveau: fix reference
 count leak in nouveau_fbcon_open"
Message-ID: <YIg67pFY6socFDCY@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-20-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-20-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:58:14PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit bfad51c7633325b5d4b32444efe04329d53297b2.
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
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/gpu/drm/nouveau/nouveau_fbcon.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_fbcon.c b/drivers/gpu/drm/nouveau/nouveau_fbcon.c
> index 4fc0fa696461..6f04e7402a76 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_fbcon.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_fbcon.c
> @@ -189,10 +189,8 @@ nouveau_fbcon_open(struct fb_info *info, int user)
>  	struct nouveau_fbdev *fbcon = info->par;
>  	struct nouveau_drm *drm = nouveau_drm(fbcon->helper.dev);
>  	int ret = pm_runtime_get_sync(drm->dev->dev);
> -	if (ret < 0 && ret != -EACCES) {
> -		pm_runtime_put(drm->dev->dev);
> +	if (ret < 0 && ret != -EACCES)
>  		return ret;
> -	}
>  	return 0;
>  }
>  
> -- 
> 2.31.1
> 

Looks correct, dropping this.

greg k-h
