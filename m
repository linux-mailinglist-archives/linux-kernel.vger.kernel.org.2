Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7126A34FE0F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 12:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234375AbhCaK3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 06:29:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:38640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234666AbhCaK3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 06:29:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D449E60C3D;
        Wed, 31 Mar 2021 10:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617186559;
        bh=aTogiyWjaMiJg208imNhC5f3kuX3jCk6wK/jS2Fdq4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VEUIZekY8pMbJqwgwsM1hTq6732F91r63dDVHv49xMIKTNLT42DOHVptSZNTGmitM
         o2vn8d3MWUdCRZ7Cx4HlDykAjW/Et9uN4tbqSl727uzJGUxjh8MXMQ8rwwstE1/Ogy
         aWJzvzVyZqp5cT2Ktl2o5EblmV6q2qGSEv5iBSnM=
Date:   Wed, 31 Mar 2021 12:29:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Xu Jia <xujia39@huawei.com>
Cc:     Ross Schmidt <ross.schm.dev@gmail.com>,
        Amarjargal Gundjalam <amarjargal16@gmail.com>,
        Jason Yan <yanaijie@huawei.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] staging: rtl8723bs: core: Remove unused variable
 'res'
Message-ID: <YGRO/JzEvCgt9I0M@kroah.com>
References: <1617178363-34193-1-git-send-email-xujia39@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617178363-34193-1-git-send-email-xujia39@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 04:12:43PM +0800, Xu Jia wrote:
> The variable 'res' is not used in function, this commit
> remove it to fix the warning.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Xu Jia <xujia39@huawei.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_sta_mgt.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
> index f96dd0b40e04..00b83919a9a3 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
> @@ -533,7 +533,6 @@ struct sta_info *rtw_get_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
>  u32 rtw_init_bcmc_stainfo(struct adapter *padapter)
>  {
>  	struct sta_info *psta;
> -	u32 res = _SUCCESS;
>  	NDIS_802_11_MAC_ADDRESS	bcast_addr = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
>  
>  	struct	sta_priv *pstapriv = &padapter->stapriv;
> @@ -542,15 +541,12 @@ u32 rtw_init_bcmc_stainfo(struct adapter *padapter)
>  	psta = rtw_alloc_stainfo(pstapriv, bcast_addr);
>  
>  	if (!psta) {
> -		res = _FAIL;
>  		RT_TRACE(_module_rtl871x_sta_mgt_c_, _drv_err_, ("rtw_alloc_stainfo fail"));
> -		goto exit;
> +		return _FAIL;

You just changed the logic here, that's not a good thing for a "robot"
to be doing at all.

greg k-h
