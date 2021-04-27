Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE4936C7DF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 16:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238436AbhD0Okn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 10:40:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:49748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236173AbhD0Oki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 10:40:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 731D860720;
        Tue, 27 Apr 2021 14:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619534394;
        bh=CjQitGT6i3MBhHPzADA14+RsDdclwJAn8SlJVVMePO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LO6AZg0NOykThlMpbeNKmUCw//+kGZqKD3fKnuh1QpZGCRn83PbToSnt15M7EJiYc
         JJA09INjJwgiyFUt78UK6l6N9TrDJ72HOdAasrx4YQ3abWv24OFNGiYCNhKhh/1jRJ
         oejVgrkoHgJJ8IOZBETc3QGqmL2fxuzn/mq9H6SY=
Date:   Tue, 27 Apr 2021 16:39:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, Kalle Valo <kvalo@codeaurora.org>
Subject: Re: [PATCH 155/190] Revert "brcmfmac: add a check for the status of
 usb_register"
Message-ID: <YIgiOGnU4Nm8L164@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-156-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-156-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:00:30PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 42daad3343be4a4e1ee03e30a5f5cc731dadfef5.
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
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
> index 586f4dfc638b..d2a803fc8ac6 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
> @@ -1586,10 +1586,6 @@ void brcmf_usb_exit(void)
>  
>  void brcmf_usb_register(void)
>  {
> -	int ret;
> -
>  	brcmf_dbg(USB, "Enter\n");
> -	ret = usb_register(&brcmf_usbdrvr);
> -	if (ret)
> -		brcmf_err("usb_register failed %d\n", ret);
> +	usb_register(&brcmf_usbdrvr);
>  }
> -- 
> 2.31.1
> 

This change was not ok, and did nothing to actually fix the root problem
here.  I'll be keeping this revert and will fix it up "properly".

thanks,

greg k-h
