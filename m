Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0D4347D57
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 17:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbhCXQLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 12:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhCXQLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 12:11:14 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85838C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 09:11:13 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1lP667-0001Ly-SM; Wed, 24 Mar 2021 17:11:07 +0100
Date:   Wed, 24 Mar 2021 17:11:07 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Colin King <colin.king@canonical.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] staging: rtl8188eu: Fix null pointer dereference
 on free_netdev call
Message-ID: <20210324161107.m7gbexp4e7e5vf77@viti.kaiser.cx>
References: <20210324152135.254152-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324152135.254152-1-colin.king@canonical.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Colin,

Thus wrote Colin King (colin.king@canonical.com):

> From: Colin Ian King <colin.king@canonical.com>

> An unregister_netdev call checks if pnetdev is null, hence a later
> call to free_netdev can potentially be passing a null pointer, causing
> a null pointer dereference. Avoid this by adding a null pointer check
> on pnetdev before calling free_netdev.

> Fixes: 1665c8fdffbb ("staging: rtl8188eu: use netdev routines for private data")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/staging/rtl8188eu/os_dep/usb_intf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

> diff --git a/drivers/staging/rtl8188eu/os_dep/usb_intf.c b/drivers/staging/rtl8188eu/os_dep/usb_intf.c
> index 518e9feb3f46..91a3d34a1050 100644
> --- a/drivers/staging/rtl8188eu/os_dep/usb_intf.c
> +++ b/drivers/staging/rtl8188eu/os_dep/usb_intf.c
> @@ -446,7 +446,8 @@ static void rtw_usb_if1_deinit(struct adapter *if1)
>  	pr_debug("+r871xu_dev_remove, hw_init_completed=%d\n",
>  		 if1->hw_init_completed);
>  	rtw_free_drv_sw(if1);
> -	free_netdev(pnetdev);
> +	if (pnetdev)
> +		free_netdev(pnetdev);
>  }

>  static int rtw_drv_init(struct usb_interface *pusb_intf, const struct usb_device_id *pdid)
> -- 
> 2.30.2

you're right. I removed the NULL check that was part of rtw_free_netdev.
Sorry for the mistake and thanks for your fix.

Reviewed-by: Martin Kaiser <martin@kaiser.cx>

Best regards,
Martin
