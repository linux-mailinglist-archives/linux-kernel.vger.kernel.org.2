Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40DA9325E88
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 09:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhBZH6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 02:58:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:53092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229449AbhBZH6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 02:58:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1359464EDB;
        Fri, 26 Feb 2021 07:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614326239;
        bh=17qB4OXEg3fk/1Suqbr0+KU1+wYrtixrMN3SQL5rC6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TYiVX3WIRJwOR+6ey01evnpqoX5pi335iyoEpRZUouqvE/o423wlj43M6pq/7EFfO
         MjGOGWrdz1XFx6BfbcMsKaBj7x1L1Kp8Y5VCfnc2L6O/nDTPoG2Osofz55FQJL//VH
         Hb0JHaJb+suQNrZZPlE76NKjJ8uUc66lPVHKfAqw=
Date:   Fri, 26 Feb 2021 08:57:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lee Gibson <leegib@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192u: minor coding style fix
Message-ID: <YDip3fQJcDIxKr0w@kroah.com>
References: <20210225100351.12199-1-leegib@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225100351.12199-1-leegib@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 10:03:51AM +0000, Lee Gibson wrote:
> Fixes this checkpatch warning
> WARNING: Comparisons should place the constant on the right side of the test
> 
> Signed-off-by: Lee Gibson <leegib@gmail.com>
> ---
>  drivers/staging/rtl8192u/r8192U_wx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192u/r8192U_wx.c b/drivers/staging/rtl8192u/r8192U_wx.c
> index d853586705fc..175bb8b15389 100644
> --- a/drivers/staging/rtl8192u/r8192U_wx.c
> +++ b/drivers/staging/rtl8192u/r8192U_wx.c
> @@ -726,7 +726,7 @@ static int r8192_wx_set_enc_ext(struct net_device *dev,
>  			idx--;
>  		group = ext->ext_flags & IW_ENCODE_EXT_GROUP_KEY;
>  
> -		if ((!group) || (IW_MODE_ADHOC == ieee->iw_mode) || (alg ==  KEY_TYPE_WEP40)) {
> +		if ((!group) || (ieee->iw_mode == IW_MODE_ADHOC) || (alg ==  KEY_TYPE_WEP40)) {
>  			if ((ext->key_len == 13) && (alg == KEY_TYPE_WEP40))
>  				alg = KEY_TYPE_WEP104;
>  			ieee->pairwise_key_type = alg;
> -- 
> 2.25.1

Someone already sent this same fix in before you did, sorry.

greg k-h
