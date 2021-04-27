Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C36036C967
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237446AbhD0Q0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:26:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:53182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237537AbhD0QZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:25:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E204613C3;
        Tue, 27 Apr 2021 16:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619540710;
        bh=c6OBw5cXsfdREMEWjX/C1s0HD5wMUyzf5BdIy9p6y7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZlG5SSeFpQynhBDmXMDYPz+RAuvlBWDPFcpywRRS9gJJ3kWx1my8tUQ5j9R5FimYO
         ntvv1SDsXwjX+oK9BMe0Q30JvlRk7pOGdn1Ragd1LHyUz1rhcMq/haRhTXAyZimnEc
         Qu/fWd578pUkDpBjN5XUmBW0AuukSH2p/vjSETuk=
Date:   Tue, 27 Apr 2021 18:25:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>, Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH 018/190] Revert "drm/nouveau: fix multiple instances of
 reference count leaks"
Message-ID: <YIg65CAxgmBIu4ty@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-19-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-19-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:58:13PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 659fb5f154c3434c90a34586f3b7aa1c39cf6062.
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
>  drivers/gpu/drm/nouveau/nouveau_drm.c | 8 ++------
>  drivers/gpu/drm/nouveau/nouveau_gem.c | 4 +---
>  2 files changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
> index 885815ea917f..1a203b64bb67 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -1067,10 +1067,8 @@ nouveau_drm_open(struct drm_device *dev, struct drm_file *fpriv)
>  
>  	/* need to bring up power immediately if opening device */
>  	ret = pm_runtime_get_sync(dev->dev);
> -	if (ret < 0 && ret != -EACCES) {
> -		pm_runtime_put_autosuspend(dev->dev);
> +	if (ret < 0 && ret != -EACCES)
>  		return ret;
> -	}
>  
>  	get_task_comm(tmpname, current);
>  	snprintf(name, sizeof(name), "%s[%d]", tmpname, pid_nr(fpriv->pid));
> @@ -1152,10 +1150,8 @@ nouveau_drm_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  	long ret;
>  
>  	ret = pm_runtime_get_sync(dev->dev);
> -	if (ret < 0 && ret != -EACCES) {
> -		pm_runtime_put_autosuspend(dev->dev);
> +	if (ret < 0 && ret != -EACCES)
>  		return ret;
> -	}
>  
>  	switch (_IOC_NR(cmd) - DRM_COMMAND_BASE) {
>  	case DRM_NOUVEAU_NVIF:
> diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
> index c88cbb85f101..195b570ee8f2 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_gem.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
> @@ -48,10 +48,8 @@ nouveau_gem_object_del(struct drm_gem_object *gem)
>  	int ret;
>  
>  	ret = pm_runtime_get_sync(dev);
> -	if (WARN_ON(ret < 0 && ret != -EACCES)) {
> -		pm_runtime_put_autosuspend(dev);
> +	if (WARN_ON(ret < 0 && ret != -EACCES))
>  		return;
> -	}
>  
>  	if (gem->import_attach)
>  		drm_prime_gem_destroy(gem, nvbo->bo.sg);
> -- 
> 2.31.1
> 

Looks correct, dropping this.

greg k-h
