Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 779E833D33F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 12:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237396AbhCPLjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 07:39:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:48084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233193AbhCPLjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 07:39:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0214265020;
        Tue, 16 Mar 2021 11:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615894761;
        bh=NZpxAyJTgfolHxBaoIjQXcV5Ku2XxqAWb889DbrpH18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UblHxmrjtorTSrpz3/ycqYMoksG6QyPIZfpOUH7BIQQbYlbfZDaB0PJ1x9rn00qyV
         a1t4hJBQVCiCaeZPd1IQ5BeuDi2mN/upZ33VUfC728DVZdCwByIThsCSoqhdZ70bm6
         CrLaME8r5YPGglgpW7avwCKYZnM+3DPlGjhtZCmI=
Date:   Tue, 16 Mar 2021 12:39:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/15] staging: rtl8723bs: remove unused code blocks
 conditioned by never set CONFIG_PM
Message-ID: <YFCY564YYio8lkUT@kroah.com>
References: <cover.1615801721.git.fabioaiuto83@gmail.com>
 <77ea39e63246fa4756afcf2bdea573f43fefc74c.1615801721.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77ea39e63246fa4756afcf2bdea573f43fefc74c.1615801721.git.fabioaiuto83@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 11:15:02AM +0100, Fabio Aiuto wrote:
> remove conditional code blocks checked by unused CONFIG_PM
> 
> cleaning required in TODO file:
> 
> find and remove code blocks guarded by never set CONFIG_FOO defines
> 
> Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> ---
>  drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> index 2ff71d001c07..5748e1c1a25c 100644
> --- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> @@ -3198,14 +3198,6 @@ static void rtw_cfg80211_preinit_wiphy(struct adapter *padapter, struct wiphy *w
>  	wiphy->flags |= WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
>  	wiphy->flags |= WIPHY_FLAG_OFFCHAN_TX | WIPHY_FLAG_HAVE_AP_SME;
>  
> -#if defined(CONFIG_PM)
> -	wiphy->max_sched_scan_reqs = 1;
> -#endif
> -
> -#if defined(CONFIG_PM)
> -	wiphy->wowlan = &wowlan_stub;
> -#endif

How this is "unused"?  This is a real config option, did you just change
the logic here?

thanks,

greg k-h
