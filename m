Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F3836C996
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237708AbhD0QkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:40:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:60940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237450AbhD0QkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:40:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B0E6613EA;
        Tue, 27 Apr 2021 16:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619541571;
        bh=eAoA7nn9uHMS+HdlmGEPB1MJqO8agIH1aMugwNGZwkM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bqXI5izwuv+XdEROF/iOr0mpSaju2Uw3slLLUpUETltAxtHYBUfGoCQIEmtbpuY5A
         S8NlLfV0E5ghOuUBh8hHsCfaZA1WvB8nlrSjkuan6d+KQDQwug5aUiRgffZEZw6oGf
         EI5nLEQHhG/uykTYQrISMN9EL+U95YUQNnUJI8Nc=
Date:   Tue, 27 Apr 2021 18:39:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Qiushi Wu <wu000273@umn.edu>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 034/190] Revert "efi/esrt: Fix reference count leak in
 esre_create_sysfs_entry."
Message-ID: <YIg+QUwh+wQze4+Z@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-35-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-35-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:58:29PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 4ddf4739be6e375116c375f0a68bf3893ffcee21.
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
> Cc: Qiushi Wu <wu000273@umn.edu>
> Cc: https
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/firmware/efi/esrt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/efi/esrt.c b/drivers/firmware/efi/esrt.c
> index d5915272141f..e3d692696583 100644
> --- a/drivers/firmware/efi/esrt.c
> +++ b/drivers/firmware/efi/esrt.c
> @@ -181,7 +181,7 @@ static int esre_create_sysfs_entry(void *esre, int entry_num)
>  		rc = kobject_init_and_add(&entry->kobj, &esre1_ktype, NULL,
>  					  "entry%d", entry_num);
>  		if (rc) {
> -			kobject_put(&entry->kobj);
> +			kfree(entry);
>  			return rc;
>  		}
>  	}
> -- 
> 2.31.1
> 

Looks correct so I'm dropping the revert.

greg k-h
