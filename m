Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7103536C965
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238850AbhD0Q0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:26:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238893AbhD0QZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:25:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4EEE1613C5;
        Tue, 27 Apr 2021 16:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619540686;
        bh=LMVtZTGw+E5wL0bq9s5XgFiik4qT+ymqPUx2h0KLhiQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w7w5VwO7Pe3TRXu599yiDmoOE569CB9jhuwI1biDZK+rOj1YC2gVWuoLhCtroL7o3
         DJPeZvResJQ7ZowH55+2Sl1AtN+ftrKl35R+SsqY0uUl1kkDiGfxAttza4mEM/UxJz
         7ihHPnuKb0ehYpQiPOhFssMbC6w0Rlu+CKhEKZOs=
Date:   Tue, 27 Apr 2021 18:24:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>, Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH 016/190] Revert "drm/nouveau: fix reference count leak in
 nouveau_debugfs_strap_peek"
Message-ID: <YIg6zHrrywU+6K7q@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-17-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-17-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:58:11PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 8f29432417b11039ef960ab18987c7d61b2b5396.
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
>  drivers/gpu/drm/nouveau/nouveau_debugfs.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> index c2bc05eb2e54..c8da70e06006 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
> @@ -54,10 +54,8 @@ nouveau_debugfs_strap_peek(struct seq_file *m, void *data)
>  	int ret;
>  
>  	ret = pm_runtime_get_sync(drm->dev->dev);
> -	if (ret < 0 && ret != -EACCES) {
> -		pm_runtime_put_autosuspend(drm->dev->dev);
> +	if (ret < 0 && ret != -EACCES)
>  		return ret;
> -	}
>  
>  	seq_printf(m, "0x%08x\n",
>  		   nvif_rd32(&drm->client.device.object, 0x101000));
> -- 
> 2.31.1
> 

Looks correct, dropping this.

greg k-h
