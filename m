Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41CC344AB3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 17:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhCVQJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 12:09:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:55388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231617AbhCVQJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 12:09:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D05DE6198C;
        Mon, 22 Mar 2021 16:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616429343;
        bh=S8egBBkG/IrGOXtnVBxf9LB7f8Mai2E3Qg6O7ER8j9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v+4c5GltO8jYY9el82VePesv7L/rhDopYckXvLs+RnlVc57UN3uSQ7T+ocvINkz0K
         R+QVPzd4eN8Jb8VH1328lkNsQDoTXABiCWIY7IjFsV5Fgj2aCVeGKxmHmypEGKdqtR
         asLIaFSCqFg45SvJnEi6UDf6MOtah3C+nXBfUXDc=
Date:   Mon, 22 Mar 2021 17:09:00 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     joe@perches.com, apw@canonical.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] staging: rtl8723bs: moved function prototype out
 of core/rtw_ioctl_set.c and core/rtw_mlme.c
Message-ID: <YFjBHNkQFlFzZKpV@kroah.com>
References: <cover.1616422773.git.fabioaiuto83@gmail.com>
 <81ccf18df5ca0acab5bb8da2b675a03626ef57ac.1616422773.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81ccf18df5ca0acab5bb8da2b675a03626ef57ac.1616422773.git.fabioaiuto83@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 03:31:41PM +0100, Fabio Aiuto wrote:
> fix the following checkpatch issues:
> 
> WARNING: externs should be avoided in .c files
> 40: FILE: drivers/staging/rtl8723bs/core/rtw_ioctl_set.c:40:
> +u8 rtw_do_join(struct adapter *padapter);
> 
> WARNING: externs should be avoided in .c files
> 15: FILE: drivers/staging/rtl8723bs/core/rtw_mlme.c:15:
> +extern u8 rtw_do_join(struct adapter *padapter);
> 
> moved function prototype in include/rtw_ioctl_set.h
> 
> Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_ioctl_set.c    | 1 -
>  drivers/staging/rtl8723bs/core/rtw_mlme.c         | 2 --
>  drivers/staging/rtl8723bs/include/rtw_ioctl_set.h | 2 ++
>  3 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
> index cb14855742f7..7d858cae2395 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
> @@ -37,7 +37,6 @@ u8 rtw_validate_ssid(struct ndis_802_11_ssid *ssid)
>  	return ret;
>  }
>  
> -u8 rtw_do_join(struct adapter *padapter);
>  u8 rtw_do_join(struct adapter *padapter)
>  {
>  	struct list_head	*plist, *phead;
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> index 95cfef118a94..1ee86ec2dee7 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> @@ -12,8 +12,6 @@
>  #include <hal_btcoex.h>
>  #include <linux/jiffies.h>
>  
> -extern u8 rtw_do_join(struct adapter *padapter);
> -
>  int	rtw_init_mlme_priv(struct adapter *padapter)
>  {
>  	int	i;
> diff --git a/drivers/staging/rtl8723bs/include/rtw_ioctl_set.h b/drivers/staging/rtl8723bs/include/rtw_ioctl_set.h
> index 4b929b84040a..55722c1366aa 100644
> --- a/drivers/staging/rtl8723bs/include/rtw_ioctl_set.h
> +++ b/drivers/staging/rtl8723bs/include/rtw_ioctl_set.h
> @@ -28,6 +28,8 @@ u8 rtw_set_802_11_connect(struct adapter *padapter, u8 *bssid, struct ndis_802_1
>  u8 rtw_validate_bssid(u8 *bssid);
>  u8 rtw_validate_ssid(struct ndis_802_11_ssid *ssid);
>  
> +u8 rtw_do_join(struct adapter *padapter);
> +

This is already in drivers/staging/rtl8188eu/include/hal_intf.h, why
declare it again?

I'm stopping here on reviewing this patchset, please look closer at it
again and fix up and resend a v2.

thanks,

greg k-h
