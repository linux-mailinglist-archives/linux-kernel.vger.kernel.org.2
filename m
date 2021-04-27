Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C0A36C7D1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 16:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237358AbhD0Oga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 10:36:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:46886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237035AbhD0Og1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 10:36:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E9E8613BF;
        Tue, 27 Apr 2021 14:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619534144;
        bh=/fvN8vpLjyyHB75xCBB5urvAmpxQrVr9UiO9JRE1l70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2cXHPnHvCRusN0alREtgtpfQAe7rqQDOLB3NQEOmOoId6mDAzv+qUOWk8cGJKVmwn
         qjg2f1E8vfnTntnhBLhbSHj4CAMkxqDUGUlSFot6Nmh8f89zREZeE5RFrYrxtqEiqN
         CYUtdbtpYj6e+TGcORM9LRB7wteo1vgZyHsf3cSI=
Date:   Tue, 27 Apr 2021 16:35:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 140/190] Revert "isdn: mISDN: Fix potential NULL pointer
 dereference of kzalloc"
Message-ID: <YIghPUPSp9XgjrgK@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-141-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-141-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:00:15PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 38d22659803a033b1b66cd2624c33570c0dde77d.
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
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/isdn/hardware/mISDN/hfcsusb.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/isdn/hardware/mISDN/hfcsusb.c b/drivers/isdn/hardware/mISDN/hfcsusb.c
> index 70061991915a..4bb470d3963d 100644
> --- a/drivers/isdn/hardware/mISDN/hfcsusb.c
> +++ b/drivers/isdn/hardware/mISDN/hfcsusb.c
> @@ -249,9 +249,6 @@ hfcsusb_ph_info(struct hfcsusb *hw)
>  	int i;
>  
>  	phi = kzalloc(struct_size(phi, bch, dch->dev.nrbchan), GFP_ATOMIC);
> -	if (!phi)
> -		return;
> -
>  	phi->dch.ch.protocol = hw->protocol;
>  	phi->dch.ch.Flags = dch->Flags;
>  	phi->dch.state = dch->state;
> -- 
> 2.31.1
> 

While it looks like this commit is correct, it is not, as none of the
setup actually happens, and the error value is not propagated upwards.
So this is worse than the original code being that an atomic operation
can almost never fail, and if it did, a oops would be good here, instead
of failing to do something that the driver now claims has happened.

So I am keeping the revert.

greg k-h
