Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A343B3EFA8E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 08:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238009AbhHRGEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 02:04:31 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:56559 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237912AbhHRGE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 02:04:29 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id B5B235C024B;
        Wed, 18 Aug 2021 02:03:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 18 Aug 2021 02:03:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=Z4OBGGYHBzMUarRh5bKxj4waQXW
        Q8+mOIcMWDFXb/SQ=; b=lls89CTvEz3WollTMyEC2xgtnB5ky7CzHnr2SxZN3Vp
        iomR9cANbFNsojWbrc1CCOR85+G6JvbLFwFOaS4ldtWrDyQoCGnLdlqSgpY3INdL
        JlUoc1bDmOJGGt2m5Vw97n9jBEAhH5BKy2n2anz5bnW2wDl9YUoPrsqy3/3Hqs1q
        5kYK6XpBAAnfvf6YrBIFFOuMTnNol10CJwKtOu/1WW0N4HYNNMPB2uY+VZSb2R1n
        Eap02Vg4aruTs4TuwgwyRGj9/YtMYlW7gEmLO7GDIiPV897QXCXUtkbT9ezZyGn/
        PwA28W44JsUoh028Vtvn2ElPCVPSfPGTKqgSAW4b48g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Z4OBGG
        YHBzMUarRh5bKxj4waQXWQ8+mOIcMWDFXb/SQ=; b=Nw/F3V5hxMAVO5B+aprBwm
        WJpsIqcC9BXvyCkTff3KKiEETXWX31wSBcdOEZ9rdk6BJ0n4icvZU4dI07HILbz5
        7ydGHpbX07kDqlLzINBtusssyj0NH9NO4I2alUp8eXtZfV15I2gaRgof6ZWMTShn
        AsOTXQ+eFnEElWKu/tBFRih6ash2vP7xsuHJjEPrbFqXuXak4uEpkFOlpH5pz80C
        ZM0afP0hC3fSpRrtwq36hIh/NurcKWM5tk3Dnn/o+ShroFMjxO49nS1GvWHs8QHg
        kVqPLhPZ1W2FNMKoj1/aUD7I9uySPni/DsIoWOFNT+F/p/UjMgJklhjRKxab0Nbw
        ==
X-ME-Sender: <xms:yaIcYSAXE-19QqNgdgL4Ndg0YHNL_rDPYTt_hGWLV2Vl7CXr4PUWeA>
    <xme:yaIcYci0XXHqhKFSAQLuWqgNRtzTnOAhk2SZw4-frQm4AW3E84pdXGcrzbuJdxijr
    c9pax-9Fqvx5w>
X-ME-Received: <xmr:yaIcYVkBEoWj5wQ0TEOKVEbgxWz3YSALcd6iFVh4cl0QVW4fGtH0nWomeklzk10IvuhMRVjCTzUAeAdBVwZx5CV5d0UxLhwO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleeggddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:yaIcYQz1z4YkgjZCz-AlZ0rM80ir8cZcCCGnH_K2GmZmF2IaR2WVpQ>
    <xmx:yaIcYXTiB8iYLIx3ketjEJu2q5T-0xYJpt6VyTN25Ez8nfXAnPr_CQ>
    <xmx:yaIcYbY_phwDIWvMkv4amcjhzSN8FU4NUXJH8vsdpJANnyGGkdcbrw>
    <xmx:yqIcYSHylyFcpTLAAMBNO4BteGREuTzsLVUEuws5oDdcOwUUZ15Ndw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Aug 2021 02:03:52 -0400 (EDT)
Date:   Wed, 18 Aug 2021 08:03:50 +0200
From:   Greg KH <greg@kroah.com>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     dan.carpenter@oracle.com, yangyingliang@huawei.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: r8188eu: Remove unused including
 <linux/version.h>
Message-ID: <YRyixigRy/XvccKs@kroah.com>
References: <20210818054946.2751-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818054946.2751-1-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 01:49:46PM +0800, Cai Huoqing wrote:
> Remove including <linux/version.h> that don't need it
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  drivers/staging/r8188eu/core/rtw_mlme.c      | 1 -
>  drivers/staging/r8188eu/os_dep/os_intfs.c    | 1 -
>  drivers/staging/r8188eu/os_dep/rtw_android.c | 1 -
>  drivers/staging/r8188eu/os_dep/xmit_linux.c  | 1 -
>  4 files changed, 4 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
> index d5ef5783f4ad..82b74ebdaabd 100644
> --- a/drivers/staging/r8188eu/core/rtw_mlme.c
> +++ b/drivers/staging/r8188eu/core/rtw_mlme.c
> @@ -3,7 +3,6 @@
>  
>  #define _RTW_MLME_C_
>  
> -#include <linux/version.h>
>  #include "../include/osdep_service.h"
>  #include "../include/drv_types.h"
>  #include "../include/recv_osdep.h"
> diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
> index f4bf4732578a..aef978eef4d7 100644
> --- a/drivers/staging/r8188eu/os_dep/os_intfs.c
> +++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
> @@ -12,7 +12,6 @@
>  
>  #include "../include/usb_osintf.h"
>  #include "../include/rtw_br_ext.h"
> -#include <linux/version.h>
>  
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("Realtek Wireless Lan Driver");
> diff --git a/drivers/staging/r8188eu/os_dep/rtw_android.c b/drivers/staging/r8188eu/os_dep/rtw_android.c
> index bdd381606ba6..af0072e2cb5f 100644
> --- a/drivers/staging/r8188eu/os_dep/rtw_android.c
> +++ b/drivers/staging/r8188eu/os_dep/rtw_android.c
> @@ -3,7 +3,6 @@
>  
>  #include <linux/module.h>
>  #include <linux/netdevice.h>
> -#include <linux/version.h>
>  #include "../include/rtw_android.h"
>  #include "../include/osdep_service.h"
>  #include "../include/rtw_debug.h"
> diff --git a/drivers/staging/r8188eu/os_dep/xmit_linux.c b/drivers/staging/r8188eu/os_dep/xmit_linux.c
> index 4f1ce346b3a5..69966c696130 100644
> --- a/drivers/staging/r8188eu/os_dep/xmit_linux.c
> +++ b/drivers/staging/r8188eu/os_dep/xmit_linux.c
> @@ -3,7 +3,6 @@
>  
>  #define _XMIT_OSDEP_C_
>  
> -#include <linux/version.h>
>  #include "../include/osdep_service.h"
>  #include "../include/drv_types.h"
>  #include "../include/if_ether.h"
> -- 
> 2.22.0
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
