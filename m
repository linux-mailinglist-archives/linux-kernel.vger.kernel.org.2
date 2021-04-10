Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A686435AE49
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 16:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbhDJO2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 10:28:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:53486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234392AbhDJO2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 10:28:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8914D6115B;
        Sat, 10 Apr 2021 14:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618064902;
        bh=vk1fqmBpzYPSIfjHRbqJl6UNW9VB0opCtMSgs5Q7qEs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QlnlAOsbehlgX6YKs0PIZQQBoYZGJkv69VvcLxO1MLn1zwHouCpPecJVeKtMSHoEB
         +HiVDvC0OIRDit54UsxNzIwqG2mezTwZkYH73EoHL3fB2znbp2GyIAlPtizicg9Lvt
         meTi+NqAicp7sPjiMQRtaRzzuKy21PeBY1G4LjHE=
Date:   Sat, 10 Apr 2021 16:28:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8723bs: remove unnecessary goto jumps
Message-ID: <YHG2A4rJdl1uiZjV@kroah.com>
References: <20210410141945.424238-1-hello@bryanbrattlof.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210410141945.424238-1-hello@bryanbrattlof.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2021 at 02:20:19PM +0000, Bryan Brattlof wrote:
> The next instruction for both 'goto exit' jump statements is to
> execute the exit jump instructions regardless. We can safely
> remove all jump statements from __init rtw_drv_entry()
> 
> Signed-off-by: Bryan Brattlof <hello@bryanbrattlof.com>
> ---
> Changes from:
>   v1: removed unnecessary edit of DBG_871X_LEVEL
> 
>  drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> index 9fd926e1698f..39b6d4b6dec4 100644
> --- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> +++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> @@ -517,12 +517,8 @@ static int __init rtw_drv_entry(void)
>  	if (ret != 0) {
>  		sdio_drvpriv.drv_registered = false;
>  		rtw_ndev_notifier_unregister();
> -		goto exit;
>  	}
>  
> -	goto exit;
> -
> -exit:
>  	DBG_871X_LEVEL(_drv_always_, "module init ret =%d\n", ret);
>  	return ret;
>  }
> @@ -540,6 +536,5 @@ static void __exit rtw_drv_halt(void)
>  	DBG_871X_LEVEL(_drv_always_, "module exit success\n");
>  }
>  
> -
>  module_init(rtw_drv_entry);
>  module_exit(rtw_drv_halt);

Any reason you removed this extra line?

thanks,

greg k-h
