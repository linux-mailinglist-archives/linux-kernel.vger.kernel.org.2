Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100543E1B54
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 20:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241245AbhHESaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 14:30:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:53988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238354AbhHESaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 14:30:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F37660F02;
        Thu,  5 Aug 2021 18:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628188186;
        bh=g+LoOLtzde4IFS+UuVya/xo96UmrefQYwhGrlJnmR7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oae8wfEMxY/Am+GcbqdvZs4z6kpzYIGvpoABCoPgAfwc+xG0mYtPgO8DuZytQiy2+
         tVQHkPC16jomktkLPV+GZ7xQsmit6MaoV3MIcZqoynjZpmWqSvEijan6dnVu+ZKihN
         JMmTjKlXcnVEIwGho+nlSLdch262MFBCF6Sj7atY=
Date:   Thu, 5 Aug 2021 20:29:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: r8188eu: remove label at the end of a
 function
Message-ID: <YQwuGLEpq7O+P2GM@kroah.com>
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

https://lore.kernel.org/r/20210805140941.9130-1-straube.linux@gmail.com
just submitted the same thing right before you, I'll go add both
signed-off-by as you both did the same thing...

thanks,

greg k-h
