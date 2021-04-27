Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6E036C83F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 17:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238527AbhD0PFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 11:05:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:37910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235659AbhD0PFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 11:05:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21BC3613D1;
        Tue, 27 Apr 2021 15:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619535894;
        bh=hSotAaqAZEUkK3K313WT/Wuuov23kIEHcYOW9tPoG4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IHAKaZjS+P0wwbNDNVqjo7N6rX+D6dJd97wCdIJ7bvKCPpdt22gpTJkaa1Gv5sxpm
         9muw4XFcVhzq9hK6p2qBZ/1pyIxP7ylE53vYKZLlH/AuwcxMCEC9L2MLV5FkpQidpk
         zo1IRZRlu3xqb3/CAzWpcskJVqU+XZDw8GC/dvF0=
Date:   Tue, 27 Apr 2021 17:04:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, Aditya Pakki <pakki001@umn.edu>,
        Ferenc Bakonyi <fero@drama.obuda.kando.hu>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 098/190] Revert "video: hgafb: fix potential NULL pointer
 dereference"
Message-ID: <YIgoFFGLbNZTwPvI@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-99-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-99-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:59:33PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit ec7f6aad57ad29e4e66cc2e18e1e1599ddb02542.
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
> Cc: Aditya Pakki <pakki001@umn.edu>
> Cc: Ferenc Bakonyi <fero@drama.obuda.kando.hu>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/video/fbdev/hgafb.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/hgafb.c b/drivers/video/fbdev/hgafb.c
> index 8bbac7182ad3..fca29f219f8b 100644
> --- a/drivers/video/fbdev/hgafb.c
> +++ b/drivers/video/fbdev/hgafb.c
> @@ -285,8 +285,6 @@ static int hga_card_detect(void)
>  	hga_vram_len  = 0x08000;
>  
>  	hga_vram = ioremap(0xb0000, hga_vram_len);
> -	if (!hga_vram)
> -		goto error;
>  
>  	if (request_region(0x3b0, 12, "hgafb"))
>  		release_io_ports = 1;
> -- 
> 2.31.1
> 

This patch "looks" correct, but the driver keeps on running and will
fail horribly right afterward if this error condition ever trips.

So points for trying to resolve an issue, but a huge NEGATIVE value for
providing a "fake" fix for the problem as nothing actually got resolved
at all.  I'll go fix this up properly...

{sigh}

greg k-h
