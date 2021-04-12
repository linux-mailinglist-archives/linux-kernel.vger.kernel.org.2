Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBFE35C2D6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243950AbhDLJvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:51:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:55950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241395AbhDLJjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:39:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 080BA6120F;
        Mon, 12 Apr 2021 09:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618220331;
        bh=5XCbpQ2jaq37pFKegsSHbOMkbKZ0wG2OYWzBu2rU7QE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UpNbq3qLa8usFfqRYPlgHES2fkwyykMg6KuAhcpbAnUYVZ8SIEuPywnWyZwzxv4eW
         Hzs/o7rE0C3fwz2x1bB9hUx6b0ZvgAmf2+XJYwgSwyVPW6LZNtSOAYh8yh8CCuchYC
         Odu/4iEb19OVqB7jexNpiZ3UDq06fg4xs6S5FUHc=
Date:   Mon, 12 Apr 2021 11:38:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/3] staging: rtl8723bs: remove unused variable ret in
 hal/sdio_halinit.c
Message-ID: <YHQVKPOoGS3auAeQ@kroah.com>
References: <cover.1618145345.git.fabioaiuto83@gmail.com>
 <fbba90b0c8fb9f65b0dc7bc0b02560724a5502ab.1618145345.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbba90b0c8fb9f65b0dc7bc0b02560724a5502ab.1618145345.git.fabioaiuto83@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 11, 2021 at 02:57:35PM +0200, Fabio Aiuto wrote:
> fix following compiler warning issue:
> 
>    drivers/staging/rtl8723bs/hal/sdio_halinit.c:
>  In function 'CardDisableRTL8723BSdio':
> >> drivers/staging/rtl8723bs/hal/sdio_halinit.c:881:5:
> warning: variable 'ret' set but not used [-Wunused-but-set-variable]
>      881 |  u8 ret = _FAIL;
>          |     ^~~
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> ---
>  drivers/staging/rtl8723bs/hal/sdio_halinit.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
> index 2098384efe92..936181a73d73 100644
> --- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
> +++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
> @@ -878,10 +878,9 @@ static void CardDisableRTL8723BSdio(struct adapter *padapter)
>  {
>  	u8 u1bTmp;
>  	u8 bMacPwrCtrlOn;
> -	u8 ret = _FAIL;
>  
>  	/*  Run LPS WL RFOFF flow */
> -	ret = HalPwrSeqCmdParsing(padapter, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, rtl8723B_enter_lps_flow);
> +	HalPwrSeqCmdParsing(padapter, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, rtl8723B_enter_lps_flow);
>  
>  	/* 	==== Reset digital sequence   ====== */
>  
> @@ -909,9 +908,8 @@ static void CardDisableRTL8723BSdio(struct adapter *padapter)
>  	/* 	==== Reset digital sequence end ====== */
>  
>  	bMacPwrCtrlOn = false;	/*  Disable CMD53 R/W */
> -	ret = false;
>  	rtw_hal_set_hwreg(padapter, HW_VAR_APFM_ON_MAC, &bMacPwrCtrlOn);
> -	ret = HalPwrSeqCmdParsing(padapter, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, rtl8723B_card_disable_flow);
> +	HalPwrSeqCmdParsing(padapter, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, rtl8723B_card_disable_flow);
>  }

Why isn't the return value being checked and returned to the caller if
something goes wrong?  Ignoring it feels wrong to me.

thanks,

greg k-h
