Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D16BD3E1AD3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 19:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240804AbhHERzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 13:55:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:39970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229873AbhHERze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 13:55:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8CDB26113C;
        Thu,  5 Aug 2021 17:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628186119;
        bh=rVLtjqrUhdZh425E1Zy2DDDa3FlbKL1Kbob+il2W9Kg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gu70gbNtuIx8/+txbiiTbjsW9EBw/QR8zhEnUK8cbgiA5KbbU0BU4Kq3bw2YB8bJZ
         CzvbT0lCcj0KEERKYY61eaK3VEywNX8I9W1hTu3aAtYsxvTGm1fVTC6pTrP4+D+e7A
         tXyevUp8Djybpox7SCAVJOUciqn3LLEZGpB32+I0=
Date:   Thu, 5 Aug 2021 19:55:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: r8188eu: remove label at the end of a
 function
Message-ID: <YQwmBEAdUiPCbIj0@kroah.com>
References: <20210805130750.7974-1-martin@kaiser.cx>
 <20210805145026.14572-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210805145026.14572-1-martin@kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 04:50:26PM +0200, Martin Kaiser wrote:
> Compilation fails for me
> 
> drivers/staging/r8188eu/hal/rtl8188e_dm.c: In function ‘rtl8188e_HalDmWatchDog’:
> drivers/staging/r8188eu/hal/rtl8188e_dm.c:182:1: error: label at end of compound statement
>   182 | skip_dm:
>       | ^~~~~~~
> 
> Remove the label at the end of the function. Replace the jump to this label
> with a return statement.
> 
> Fixes: b398ff88aa36 ("staging: r8188eu: remove return from void functions")
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
> v2:
>  - add Fixes tag
> 
>  drivers/staging/r8188eu/hal/rtl8188e_dm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/rtl8188e_dm.c b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
> index b5f42127a751..72b3130eddd2 100644
> --- a/drivers/staging/r8188eu/hal/rtl8188e_dm.c
> +++ b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
> @@ -145,7 +145,7 @@ void rtl8188e_HalDmWatchDog(struct adapter *Adapter)
>  	hw_init_completed = Adapter->hw_init_completed;
>  
>  	if (!hw_init_completed)
> -		goto skip_dm;
> +		return;
>  
>  	fw_cur_in_ps = Adapter->pwrctrlpriv.bFwCurrentInPSMode;
>  	rtw_hal_get_hwreg(Adapter, HW_VAR_FWLPS_RF_ON, (u8 *)(&fw_ps_awake));
> @@ -179,7 +179,7 @@ void rtl8188e_HalDmWatchDog(struct adapter *Adapter)
>  		ODM_CmnInfoUpdate(&hal_data->odmpriv, ODM_CMNINFO_LINK, bLinked);
>  		ODM_DMWatchdog(&hal_data->odmpriv);
>  	}
> -skip_dm:
> +
>  	/*  Check GPIO to determine current RF on/off and Pbc status. */
>  	/*  Check Hardware Radio ON/OFF or not */
>  }
> -- 
> 2.20.1
> 
> 

How is this not showing up in my build tests?  Odd, let me figure that
out...


greg k-h
