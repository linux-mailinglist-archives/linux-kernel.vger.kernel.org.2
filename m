Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A64ED34A941
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 15:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhCZOIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 10:08:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229839AbhCZOIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:08:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D24861A24;
        Fri, 26 Mar 2021 14:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616767687;
        bh=sfKejFZdHc5ocWb1u29Ga9LhysZMd+NqlM93fFQXeLc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wN2ED4td46fy0E+xRVuWJcEoR+TURtgYYeFTQnmwfzznS/s96egLlT+pOxYTfz4yG
         NO2+OrzveTor9cJTr/O0m2UeQ4Z3LREi8JGMsnB3Uy5iLeXR/uFlQYn/7mhUPFHjoa
         6dr27IR72nYvDggowmZslO8agE8NROpjOk4fD66c=
Date:   Fri, 26 Mar 2021 15:08:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xu Jia <xujia39@huawei.com>
Cc:     ross.schm.dev@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, hulkcommits@huawei.com
Subject: Re: [PATCH -next] staging: rtl8723bs: core: fix error return
Message-ID: <YF3qxema68+hLEZq@kroah.com>
References: <20210325083041.1881347-1-xujia39@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325083041.1881347-1-xujia39@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 04:30:41PM +0800, Xu Jia wrote:
> Function rtw_init_bcmc_stainfo() is always return success.
> Variable 'ret' set but not used.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Xu Jia <xujia39@huawei.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_sta_mgt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
> index f96dd0b40e04..7b578192adf5 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
> @@ -551,7 +551,7 @@ u32 rtw_init_bcmc_stainfo(struct adapter *padapter)
>  	psta->mac_id = 1;
>  
>  exit:
> -	return _SUCCESS;
> +	return res;
>  }

You just changed the logic of this function, now it can return a
failure.  Is that ok?  have you tested it when this fails?

Given that I do not think anyone actually tests this value, should this
function just return void instead?

thanks,

greg k-h
