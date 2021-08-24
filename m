Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49CD93F5EB0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 15:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237548AbhHXNHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 09:07:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:49552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237363AbhHXNHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 09:07:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD31461184;
        Tue, 24 Aug 2021 13:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629810409;
        bh=CzvHAdiJz86mH/fepGltH+7sz1a2CYle6fa+UCARsBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0Art4iSOJnHLnZX31fLbttgTBGVCT1WUWVYbn5A1Kgg8M6rzc5WUPXo7tN8T6eNFu
         5BJ+n6n6U61uJBouu5u37+gSCtpwQQglZinDN/zfkZHKyN0tXjy40A5uIWngXjX8Gi
         8s/tTvwvg8fdk5s5QswSaKoqIfppb+5yt3slcAIo=
Date:   Tue, 24 Aug 2021 15:06:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        chris.chiu@canonical.com
Subject: Re: [RFC PATCH 1/5] usb: core: hcd: Modularize HCD stop
 configuration in usb_stop_hcd()
Message-ID: <YSTu5KCQV242XuXV@kroah.com>
References: <20210824105302.25382-1-kishon@ti.com>
 <20210824105302.25382-2-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824105302.25382-2-kishon@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 04:22:58PM +0530, Kishon Vijay Abraham I wrote:
> No functional change. Since configuration to stop HCD is invoked from
> multiple places, group all of them in usb_stop_hcd().
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/usb/core/hcd.c | 42 +++++++++++++++++++++++++-----------------
>  1 file changed, 25 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index 0f8b7c93310e..c036ba5311b3 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -2760,6 +2760,29 @@ static void usb_put_invalidate_rhdev(struct usb_hcd *hcd)
>  	usb_put_dev(rhdev);
>  }
>  
> +/**
> + * usb_stop_hcd - Halt the HCD
> + * @hcd: the usb_hcd that has to be halted
> + *
> + * Stop the timer and invoke ->stop() callback on the HCD
> + */
> +static void usb_stop_hcd(struct usb_hcd *hcd)
> +{
> +	if (!hcd)
> +		return;

That's impossible to hit, so no need to check for it, right?

thanks,

greg k-h
