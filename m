Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5295F355364
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 14:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343850AbhDFMNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 08:13:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238620AbhDFMNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 08:13:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9EA846139E;
        Tue,  6 Apr 2021 12:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617711219;
        bh=e7eFd02Z9wUi0fdYUZP7ksNxGrIRXxvKr6qEjvDuAgY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xw/1H6Y41hhakwQEtXX9g7On8WHn2oMiIPnleRAi0ku5UDHmdEoDek0ceMnaLGALl
         WFULMx1nelXHeE/vMi0+zu9ESPoiaskrzTmPjNdi+Oy+SiPpU41pyOVWT08orMbxcF
         4GWI+2GCdQ2MnCe3if2uvEG6hQkeNsrIufg7lSB4=
Date:   Tue, 6 Apr 2021 14:13:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: Re: [PATCH 3/4] staging: rtl8723bs: core: reorganize characters so
 the lines are under 100 ch
Message-ID: <YGxQcEvmxHrNz2US@kroah.com>
References: <cover.1617641790.git.martinsdecarvalhobeatriz@gmail.com>
 <6ce5f20399f2bea9f08bb37150fc67fe3c2b2a55.1617641790.git.martinsdecarvalhobeatriz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ce5f20399f2bea9f08bb37150fc67fe3c2b2a55.1617641790.git.martinsdecarvalhobeatriz@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 06:29:19PM +0100, Beatriz Martins de Carvalho wrote:
> Cleans up warnings of "line over 100 characters" but avoinding
> more than 90 characters in file rtw_ap.c
> 
> Signed-off-by: Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_ap.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
> index 4dab4d741675..ca6fec52d213 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_ap.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
> @@ -278,11 +278,13 @@ void expire_timeout_chk(struct adapter *padapter)
>  
>  			if (psta->state & WIFI_SLEEP_STATE) {
>  				if (!(psta->state & WIFI_STA_ALIVE_CHK_STATE)) {
> -					/* to check if alive by another methods if station is at ps mode. */
> +					/* to check if alive by another methods */
> +					/* if station is at ps mode. */
>  					psta->expire_to = pstapriv->expire_to;
>  					psta->state |= WIFI_STA_ALIVE_CHK_STATE;
>  
> -					/* DBG_871X("alive chk, sta:%pM is at ps mode!\n", MAC_ARG(psta->hwaddr)); */
> +					/* DBG_871X("alive chk, sta:%pM is at ps */
> +					/* mode!\n", MAC_ARG(psta->hwaddr)); */

You just wrapped a code line :(

Just remove it, it's not needed.


>  
>  					/* to update bcn with tim_bitmap for this station */
>  					pstapriv->tim_bitmap |= BIT(psta->aid);
> @@ -309,7 +311,8 @@ void expire_timeout_chk(struct adapter *padapter)
>  			);
>  			updated = ap_free_sta(padapter, psta, false, WLAN_REASON_DEAUTH_LEAVING);
>  		} else {
> -			/* TODO: Aging mechanism to digest frames in sleep_q to avoid running out of xmitframe */
> +			/* TODO: Aging mechanism to digest frames in sleep_q to */
> +			/* avoid running out of xmitframe */
>  			if (psta->sleepq_len > (NR_XMITFRAME / pstapriv->asoc_list_cnt)
>  				&& padapter->xmitpriv.free_xmitframe_cnt < ((
>  					NR_XMITFRAME / pstapriv->asoc_list_cnt
> @@ -375,7 +378,8 @@ void expire_timeout_chk(struct adapter *padapter)
>  			if (list_empty(&psta->asoc_list) == false) {
>  				list_del_init(&psta->asoc_list);
>  				pstapriv->asoc_list_cnt--;
> -				updated = ap_free_sta(padapter, psta, false, WLAN_REASON_DEAUTH_LEAVING);
> +				updated = ap_free_sta(padapter, psta, false,
> +						      WLAN_REASON_DEAUTH_LEAVING);
>  			}
>  			spin_unlock_bh(&pstapriv->asoc_list_lock);
>  		}
> @@ -469,7 +473,8 @@ void update_bmc_sta(struct adapter *padapter)
>  
>  		memset((void *)&psta->sta_stats, 0, sizeof(struct stainfo_stats));
>  
> -		/* psta->dot118021XPrivacy = _NO_PRIVACY_;//!!! remove it, because it has been set before this. */
> +		/* psta->dot118021XPrivacy = _NO_PRIVACY_;//!!! remove it, */
> +		/* because it has been set before this. */

Again, look at what you are changing to see if it makes sense.

>  
>  		/* prepare for add_RATid */
>  		supportRateNum = rtw_get_rateset_len((u8 *)&pcur_network->SupportedRates);
> @@ -748,8 +753,8 @@ void start_bss_network(struct adapter *padapter, u8 *pbuf)
>  	cur_ch_offset = HAL_PRIME_CHNL_OFFSET_DONT_CARE;
>  
>  	/* check if there is wps ie, */
> -	/* if there is wpsie in beacon, the hostapd will update beacon twice when stating hostapd, */
> -	/* and at first time the security ie (RSN/WPA IE) will not include in beacon. */
> +	/* if there is wpsie in beacon, the hostapd will update beacon twice when stating */
> +	/* hostapd, and at first time the security ie (RSN/WPA IE) will not include in beacon. */

These changes do not look correct, you made them longer?

thanks,

greg k-h
