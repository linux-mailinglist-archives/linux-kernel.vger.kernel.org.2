Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA4036CA53
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 19:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236733AbhD0R2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 13:28:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235974AbhD0R2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 13:28:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E79E61076;
        Tue, 27 Apr 2021 17:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619544454;
        bh=9DJ1p7DCHWQ4OBtaKiFsrFP5QgvtwfQt9OpCIk+NVrE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OiQ4FmsEdf9U29f7jy27miKtrB29wVY6UgUMPHNaEIRtDYTGWQGZx6irJLNTd5Wff
         P9x/QPaPkbn9fMegP88EMnjqbaNjXtt6oxjCbY/THa+TtPdI6C99961Ytg0E0q1nt6
         /owmamsm5iH0bvB95RXaC0szekBOk9z/wCoFRcHA=
Date:   Tue, 27 Apr 2021 19:27:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>
Subject: Re: [PATCH 104/190] Revert "char: hpet: fix a missing check of
 ioremap"
Message-ID: <YIhJg157HZ5mMecS@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-105-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-105-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:59:39PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 13bd14a41ce3105d5b1f3cd8b4d1e249d17b6d9b.
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
> Cc: Kangjie Lu <kjlu@umn.edu>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/char/hpet.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
> index ed3b7dab678d..6f13def6c172 100644
> --- a/drivers/char/hpet.c
> +++ b/drivers/char/hpet.c
> @@ -969,8 +969,6 @@ static acpi_status hpet_resources(struct acpi_resource *res, void *data)
>  	if (ACPI_SUCCESS(status)) {
>  		hdp->hd_phys_address = addr.address.minimum;
>  		hdp->hd_address = ioremap(addr.address.minimum, addr.address.address_length);
> -		if (!hdp->hd_address)
> -			return AE_ERROR;
>  
>  		if (hpet_is_known(hdp)) {
>  			iounmap(hdp->hd_address);
> -- 
> 2.31.1
> 

While this is technically correct, it is only fixing ONE of these errors
in this function, so the patch is not fully correct.  I'll leave this
revert and provide a fix for this later that resolves this same
"problem" everywhere in this function.

thanks,

greg k-h
