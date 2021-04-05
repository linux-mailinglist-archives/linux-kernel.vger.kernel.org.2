Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE16354730
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 21:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbhDETlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 15:41:10 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:61889
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232942AbhDETlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 15:41:07 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AKjwsRKgO6mRS1bbdAwFfnsDbaHBQXjsji2hD?=
 =?us-ascii?q?6mlwRA09T+WzkceykPMHkSLlkTp5YgBFpfmsMLSNKEm2ybdb+o8UVI3JYCDHvy?=
 =?us-ascii?q?+SIJhm/c/exVTbehHW0s54+eNef7NlCNv2ZGIK6PrSxAWjCd4vzJ2m3cmT5dv2?=
 =?us-ascii?q?9HtmQQF0Z6wI1W4QNi+hHkJ7XwVAD5YifaDshfZvnSaqengcc62AaEUtYu6rnb?=
 =?us-ascii?q?H2va79bQVDLxAq7xTmt0LL1JfKVynd5BsYXj9VqI1OzUHOmWXCiZmejw=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.81,307,1610406000"; 
   d="scan'208";a="377792127"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 21:41:00 +0200
Date:   Mon, 5 Apr 2021 21:40:59 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH 4/4] staging: rtl8723bs: core: align
 arguments with open parenthesis
In-Reply-To: <00250c746ed850f6a73ff0ad4c1735cbd019b58f.1617641790.git.martinsdecarvalhobeatriz@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2104052138230.2981@hadrien>
References: <cover.1617641790.git.martinsdecarvalhobeatriz@gmail.com> <00250c746ed850f6a73ff0ad4c1735cbd019b58f.1617641790.git.martinsdecarvalhobeatriz@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 5 Apr 2021, Beatriz Martins de Carvalho wrote:

> Cleans up checks of "Alignment should match open parenthesis"
> in file rtw_ap.c
>
> Signed-off-by: Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_ap.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
> index ca6fec52d213..73a35b3320fe 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_ap.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
> @@ -439,7 +439,7 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
>  		arg[3] = psta->init_rate;
>
>  		DBG_871X("%s => mac_id:%d , raid:%d , shortGIrate =%d, bitmap = 0x%x\n",
> -			__func__, psta->mac_id, psta->raid, shortGIrate, tx_ra_bitmap);
> +			 __func__, psta->mac_id, psta->raid, shortGIrate, tx_ra_bitmap);
>
>  		rtw_hal_add_ra_tid(padapter, tx_ra_bitmap, arg, rssi_level);
>  	} else {
> @@ -512,7 +512,7 @@ void update_bmc_sta(struct adapter *padapter)
>  			arg[3] = psta->init_rate;
>
>  			DBG_871X("%s => mac_id:%d , raid:%d , bitmap = 0x%x\n",
> -				__func__, psta->mac_id, psta->raid, tx_ra_bitmap);
> +				 __func__, psta->mac_id, psta->raid, tx_ra_bitmap);
>
>  			rtw_hal_add_ra_tid(padapter, tx_ra_bitmap, arg, 0);
>  		}
> @@ -605,14 +605,14 @@ void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta)
>
>  		/*  B0 Config LDPC Coding Capability */
>  		if (TEST_FLAG(phtpriv_ap->ldpc_cap, LDPC_HT_ENABLE_TX) &&
> -			GET_HT_CAPABILITY_ELE_LDPC_CAP((u8 *)(&phtpriv_sta->ht_cap))) {
> +			      GET_HT_CAPABILITY_ELE_LDPC_CAP((u8 *)(&phtpriv_sta->ht_cap))) {
>  			SET_FLAG(cur_ldpc_cap, (LDPC_HT_ENABLE_TX | LDPC_HT_CAP_TX));
>  			DBG_871X("Enable HT Tx LDPC for STA(%d)\n", psta->aid);
>  		}

TEST_FLAG and SET_FLAG are not standard for the kernel, don't do anything
very interesting, and aren't even used consistently in this file.  Maybe
you could get rid of them completely from the driver.  In another patch,
of course.

julia


>  		/*  B7 B8 B9 Config STBC setting */
>  		if (TEST_FLAG(phtpriv_ap->stbc_cap, STBC_HT_ENABLE_TX) &&
> -			GET_HT_CAPABILITY_ELE_RX_STBC((u8 *)(&phtpriv_sta->ht_cap))) {
> +			      GET_HT_CAPABILITY_ELE_RX_STBC((u8 *)(&phtpriv_sta->ht_cap))) {
>  			SET_FLAG(cur_stbc_cap, (STBC_HT_ENABLE_TX | STBC_HT_CAP_TX));
>  			DBG_871X("Enable HT Tx STBC for STA(%d)\n", psta->aid);
>  		}
> @@ -1176,7 +1176,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
>  		);
>
>  		if ((psecuritypriv->wpa_pairwise_cipher & WPA_CIPHER_CCMP) ||
> -			(psecuritypriv->wpa2_pairwise_cipher & WPA_CIPHER_CCMP)) {
> +		     (psecuritypriv->wpa2_pairwise_cipher & WPA_CIPHER_CCMP)) {
>  			pht_cap->ampdu_params_info |= (IEEE80211_HT_CAP_AMPDU_DENSITY & (0x07 << 2));
>  		} else {
>  			pht_cap->ampdu_params_info |= (IEEE80211_HT_CAP_AMPDU_DENSITY & 0x00);
> @@ -1233,7 +1233,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
>  	pmlmepriv->htpriv.ht_option = false;
>
>  	if ((psecuritypriv->wpa2_pairwise_cipher & WPA_CIPHER_TKIP) ||
> -		      (psecuritypriv->wpa_pairwise_cipher & WPA_CIPHER_TKIP)) {
> +	     (psecuritypriv->wpa_pairwise_cipher & WPA_CIPHER_TKIP)) {
>  		/* todo: */
>  		/* ht_cap = false; */
>  	}
> @@ -1820,7 +1820,7 @@ static int rtw_ht_operation_update(struct adapter *padapter)
>  	}
>
>  	DBG_871X("%s new operation mode = 0x%X changes =%d\n",
> -		   __func__, pmlmepriv->ht_op_mode, op_mode_changes);
> +		 __func__, pmlmepriv->ht_op_mode, op_mode_changes);
>
>  	return op_mode_changes;
>  }
> @@ -1865,7 +1865,7 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
>  			pmlmepriv->num_sta_no_short_preamble++;
>
>  			if ((pmlmeext->cur_wireless_mode > WIRELESS_11B) &&
> -				(pmlmepriv->num_sta_no_short_preamble == 1)) {
> +			    (pmlmepriv->num_sta_no_short_preamble == 1)) {
>  				beacon_updated = true;
>  				update_beacon(padapter, 0xFF, NULL, true);
>  			}
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/00250c746ed850f6a73ff0ad4c1735cbd019b58f.1617641790.git.martinsdecarvalhobeatriz%40gmail.com.
>
