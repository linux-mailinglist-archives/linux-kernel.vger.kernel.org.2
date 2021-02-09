Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB7F3158E1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 22:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbhBIVoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 16:44:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:49334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233597AbhBITHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 14:07:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B7DF60232;
        Tue,  9 Feb 2021 18:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612897146;
        bh=4fpJLNnnXrm61+CZAhV3xI29v6k4LL3TqX6499FGgog=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e25v8N6RsnT4Ivrb6cji8NwTzyy/ohyiPXpn0gROnVLNpW6dr3+SRaJPV+e3O7qxL
         tww8pvKGDsFKr3S8fwnpWIb22cAPecBKUX4jZT/Z+C6k3QAoySZeGu1v+//UBvnW9h
         GsPg0YTe7lVm48+aAptfMIHHvD11bf9P/UT2GVco=
Date:   Tue, 9 Feb 2021 19:59:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     karthik alapati <mail@karthek.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: fix block comments alignment
Message-ID: <YCLbdtaTRk8dtsVA@kroah.com>
References: <YCLaHXD/sUKM5HZE@karthik-strix-linux.karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCLaHXD/sUKM5HZE@karthik-strix-linux.karthek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 12:23:17AM +0530, karthik alapati wrote:
> fix checkpatch.pl warning for "block comments should align the * on each line"
> 
> Signed-off-by: karthik alapati <mail@karthek.com>
> ---
>  .../staging/rtl8723bs/hal/rtl8723b_phycfg.c   | 204 +++++++++---------
>  1 file changed, 102 insertions(+), 102 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
> index cf23414d7..003f954c2 100644
> --- a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
> +++ b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
> @@ -20,16 +20,16 @@
>  #define MAX_DOZE_WAITING_TIMES_9x 64
>  
>  /**
> -* Function:	phy_CalculateBitShift
> -*
> -* OverView:	Get shifted position of the BitMask
> -*
> -* Input:
> -*		u32 	BitMask,
> -*
> -* Output:	none
> -* Return:		u32 	Return the shift bit bit position of the mask
> -*/
> + * Function:	phy_CalculateBitShift
> + *
> + * OverView:	Get shifted position of the BitMask
> + *
> + * Input:
> + *		u32 	BitMask,
> + *
> + * Output:	none
> + * Return:		u32 	Return the shift bit bit position of the mask
> + */

These huge function comments are not normal kernel coding style anyway,
why not fix them up to use the correct style, don't paper over it and
keep this mess around any longer than it needs to be.

thanks,

greg k-h
