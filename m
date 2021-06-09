Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76DD83A147D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 14:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbhFIMeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 08:34:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:48030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230377AbhFIMee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 08:34:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 959AF61183;
        Wed,  9 Jun 2021 12:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623241960;
        bh=wtbyrMKSuMZ+ubnpoHwvsXFSnwWGhrtAlMZjlqRbpbw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XMzNZoTpRgVbaEqerw4ctjcAhPzZml970IN96scfxBnkR8QXNdCWllsh7Oi/YpC1D
         XIl10gTlw+etrclCoBADLqKTcZfhR0y8O349e8xZF1SP1kEd58bwUsSnW+q13yE9Ci
         JuTGMa1vUE/xbvfnDEyrXzPLC2WZeqdYzSltyJfg=
Date:   Wed, 9 Jun 2021 14:25:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Joe Perches <joe@perches.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8723bs: os_dep: Remove conditions with no
 effects
Message-ID: <YMCzQCYAlSafu88E@kroah.com>
References: <20210606074216.26495-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210606074216.26495-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 06, 2021 at 09:42:16AM +0200, Fabio M. De Francesco wrote:
> Removed conditions with no effects. Detected by Coccinelle.
> It seems that these conditions with no effects had been inadvertently
> left while deleting code that had to be conditionally compiled by 
> unused definition CONFIG_AP_WOWLAN (see commit dc365d2cc579).
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> v1 -> v2: Rewrote the changelog according to suggestion by 
> Joe Perches <joe@perches.com>
> 
>  drivers/staging/rtl8723bs/os_dep/os_intfs.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
> index 213ec5b4ce98..2035573ee5a0 100644
> --- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
> +++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
> @@ -1187,10 +1187,7 @@ void rtw_suspend_common(struct adapter *padapter)
>  
>  	rtw_ps_deny_cancel(padapter, PS_DENY_SUSPEND);
>  
> -	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE))
> -		rtw_suspend_normal(padapter);
> -	else
> -		rtw_suspend_normal(padapter);
> +	rtw_suspend_normal(padapter);
>  
>  	netdev_dbg(padapter->pnetdev, "rtw suspend success in %d ms\n",
>  		   jiffies_to_msecs(jiffies - start_time));
> @@ -1268,11 +1265,7 @@ int rtw_resume_common(struct adapter *padapter)
>  
>  	netdev_dbg(padapter->pnetdev, "resume start\n");
>  
> -	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
> -		rtw_resume_process_normal(padapter);
> -	} else {
> -		rtw_resume_process_normal(padapter);
> -	}
> +	rtw_resume_process_normal(padapter);
>  
>  	hal_btcoex_SuspendNotify(padapter, 0);
>  
> -- 
> 2.31.1

This patch adds a build warning:

drivers/staging/rtl8723bs/os_dep/os_intfs.c: In function ‘rtw_resume_common’:
drivers/staging/rtl8723bs/os_dep/os_intfs.c:1264:27: warning: unused variable ‘pmlmepriv’ [-Wunused-variable]
 1264 |         struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
      |                           ^~~~~~~~~
  LD [M]  drivers/staging/rtl8723bs/r8723bs.o


So I can not take it, please fix up and resend.

thanks,

greg k-h
