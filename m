Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9542E33421F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 16:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbhCJPwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 10:52:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:54750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233181AbhCJPvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 10:51:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D79164E86;
        Wed, 10 Mar 2021 15:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615391507;
        bh=cx2k3zIevdtlZosOIu0f6rmjRxaYgbMOD0ua7N3lBQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JuPixlUojewCJxizHFgv508Mf/dCoggWsL9Rd9zsfbnmVi3fCQSMse04AwoRkPsDE
         u0Oc22drHPorD2NLTpowMmAPsK/D2lodUeDhvJ9qlgObXQXNQqTWKwKtJEt9eKz3/o
         ciFn+92WIh81f3kHgIpyfn3yLEUrcvyBtOvZSaMc=
Date:   Wed, 10 Mar 2021 16:51:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: align comments
Message-ID: <YEjrEErDZTH47gto@kroah.com>
References: <20210310153717.GA5741@agape.jhs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310153717.GA5741@agape.jhs>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 04:37:21PM +0100, Fabio Aiuto wrote:
> fix the following checkpatch warnings:
> 
> WARNING: Block comments use * on subsequent lines
> +	/*
> +		AMPDU_para [1:0]:Max AMPDU Len => 0:8k , 1:16k, 2:32k, 3:64k
> --
> WARNING: Block comments use * on subsequent lines
> +/*
> +op_mode
> 
> Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_ap.c | 28 ++++++++++++-------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
> index b6f944b37b08..3a0e4f64466a 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_ap.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
> @@ -721,9 +721,9 @@ static void update_hw_ht_param(struct adapter *padapter)
>  
>  	/* handle A-MPDU parameter field */
>  	/*
> -		AMPDU_para [1:0]:Max AMPDU Len => 0:8k , 1:16k, 2:32k, 3:64k
> -		AMPDU_para [4:2]:Min MPDU Start Spacing
> -	*/
> +	 *	AMPDU_para [1:0]:Max AMPDU Len => 0:8k , 1:16k, 2:32k, 3:64k
> +	 *	AMPDU_para [4:2]:Min MPDU Start Spacing
> +	 */
>  	max_AMPDU_len = pmlmeinfo->HT_caps.u.HT_cap_element.AMPDU_para & 0x03;
>  
>  	min_MPDU_spacing = (
> @@ -1815,17 +1815,17 @@ void update_beacon(struct adapter *padapter, u8 ie_id, u8 *oui, u8 tx)
>  }
>  
>  /*
> -op_mode
> -Set to 0 (HT pure) under the following conditions
> -	- all STAs in the BSS are 20/40 MHz HT in 20/40 MHz BSS or
> -	- all STAs in the BSS are 20 MHz HT in 20 MHz BSS
> -Set to 1 (HT non-member protection) if there may be non-HT STAs
> -	in both the primary and the secondary channel
> -Set to 2 if only HT STAs are associated in BSS,
> -	however and at least one 20 MHz HT STA is associated
> -Set to 3 (HT mixed mode) when one or more non-HT STAs are associated
> -	(currently non-GF HT station is considered as non-HT STA also)
> -*/
> + *op_mode
> + *Set to 0 (HT pure) under the following conditions
> + *	 - all STAs in the BSS are 20/40 MHz HT in 20/40 MHz BSS or
> + *	 - all STAs in the BSS are 20 MHz HT in 20 MHz BSS
> + *Set to 1 (HT non-member protection) if there may be non-HT STAs
> + *	 in both the primary and the secondary channel
> + *Set to 2 if only HT STAs are associated in BSS,
> + *	 however and at least one 20 MHz HT STA is associated
> + *Set to 3 (HT mixed mode) when one or more non-HT STAs are associated
> + *	 (currently non-GF HT station is considered as non-HT STA also)
> + */

Add a space after the ' ' to make it look correct please.

thanks,

greg k-h
