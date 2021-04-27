Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263E336C964
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238847AbhD0Q0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:26:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:52490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237939AbhD0QZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:25:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 31ED061027;
        Tue, 27 Apr 2021 16:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619540664;
        bh=Q95Gjbj37i3t5cGK6a5zR4v9UL3HcYVi08bCpryPZ7I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=njazE24zDymQtoLVM1Z3pQwdVt5BNYFvRcWw/uJz2JOYMVQKSyBTe6t12jsHqqg5H
         V9JEFUmwWY+h5sXGIWGlVPNanv99G3sttw+VEjG1lDDYfm0jqD90DSb3nwgkH0GOlL
         Ds53baoDTK/Ein3/lD70Ad9JTEvHmzRV6tabaLw4=
Date:   Tue, 27 Apr 2021 18:24:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>, Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH 017/190] Revert "drm/nouveau: fix reference count leak in
 nv50_disp_atomic_commit"
Message-ID: <YIg6tVGPKdhv49ll@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-18-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-18-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:58:12PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit a2cdf39536b0d21fb06113f5e16692513d7bcb9c.
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
>  drivers/gpu/drm/nouveau/dispnv50/disp.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> index 1c9c0cdf85db..8ae298ab1cfb 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -2320,10 +2320,8 @@ nv50_disp_atomic_commit(struct drm_device *dev,
>  	int ret, i;
>  
>  	ret = pm_runtime_get_sync(dev->dev);
> -	if (ret < 0 && ret != -EACCES) {
> -		pm_runtime_put_autosuspend(dev->dev);
> +	if (ret < 0 && ret != -EACCES)
>  		return ret;
> -	}
>  
>  	ret = drm_atomic_helper_setup_commit(state, nonblock);
>  	if (ret)
> -- 
> 2.31.1
> 

Looks correct, dropping this.

greg k-h
