Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8653A35F317
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 14:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350635AbhDNMBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 08:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350629AbhDNMBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 08:01:07 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B56AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 05:00:45 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e7so10645000wrs.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 05:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i5HQjPxljcZpnbRE8jlqMD0sbzsc3/4zXnile+oXWDQ=;
        b=ScW4FlP0yM6PkI94P7pV26U6mEKpxWSwBqKSSe4/+xhy+qNiHmhO3yGuAZhSlQ7rtq
         kULF9POB6rgS9sSmFJjhYEW6FGb9+/ovW5fwFDmwPl3mHP+FXqY6f0eZ8ZW6b9/QUsiF
         6/FMO4iGBtImK+GOc12KEsr4B4iW02B9hWr7OulBsVz8ea6Sd9StIi1QnGHZZsNIIkz4
         doNN2AmXlFFFG04uDXC72PuuGRMPKeegNURLOjWSjGxjVdum5dlL9zQjsju6rslvXiBP
         OkUsa4t+0F+esaWDeKSYVXBzhltOxamW2Qt2u6HTiSGYYwA13+gSn8LGF9OaqmdUzuKd
         WZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i5HQjPxljcZpnbRE8jlqMD0sbzsc3/4zXnile+oXWDQ=;
        b=l3rjwGGOBqoa5gPnJ7pMigt/uqNM7gwjVvPq17zwU6UJp3IJo35Qz5r+pxiudBmmK0
         vAAtBHtlhWSdCjJbo5DZR+ngQqhj4ysq6rzEJFWQxqwG5IisFeRjK+hkLmxu7PVdmFnK
         YOgv6DGmUweLy3Z4d7vLJwMaj6OGMBHnY5z8yrQ+YjuW8+vcsqSPqAYO2Sgb41srVfa6
         WqRpbncAA/I9+TZ0sDIifF+zckE+BOn657ZS+3MoGKaLD4ZOw/rihdD3vrTYfxTP6sIU
         aBZFE9TPuIMsGitCY+mydEcxQV8+Hyf3NRVK4QSdLwF89n3KbCrRl//8ncleSuGUSFnA
         +Jrg==
X-Gm-Message-State: AOAM532Y4E7l0ODuA1lHASiNaoOBFYSQPfCml25vJwchSyyTwg9aq2FM
        XvauBOT9VArNXE6PlJ/n8B0=
X-Google-Smtp-Source: ABdhPJwML60N7/hC8YidD4FD0HToXMox8L8T2jdNH0sZA/YfOM6q1NybJyIXIcCUUT5JL0EaoSbPcA==
X-Received: by 2002:a5d:508d:: with SMTP id a13mr11234994wrt.182.1618401643900;
        Wed, 14 Apr 2021 05:00:43 -0700 (PDT)
Received: from agape.jhs ([5.171.26.216])
        by smtp.gmail.com with ESMTPSA id o1sm6407860wrw.95.2021.04.14.05.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 05:00:43 -0700 (PDT)
Date:   Wed, 14 Apr 2021 14:00:40 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8723bs: Remove useless
 led_blink_hdl()
Message-ID: <20210414120039.GA1417@agape.jhs>
References: <20210414115243.32716-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414115243.32716-1-fmdefrancesco@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 01:52:43PM +0200, Fabio M. De Francesco wrote:
> Removed the led_blink_hdl() function (declaration and definition).
> Declared dummy_function() in include/rtw_mlme_ext.h and defined it in
> core/rtw_cmd.c. Changed the second parameter of GEN_MLME_EXT_HANDLER
> macro to make use of dummy_function().
> 
> Reported-by: Julia Lawall <julia.lawall@inria.fr>
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_cmd.c         | 4 +++-
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c    | 9 ---------
>  drivers/staging/rtl8723bs/include/rtw_mlme_ext.h | 3 ++-
>  3 files changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> index 0297fbad7bce..7b6102a2bb2c 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> @@ -87,6 +87,8 @@ static struct _cmd_callback rtw_cmd_callback[] = {
>  	{GEN_CMD_CODE(_RunInThreadCMD), NULL},/*64*/
>  };
>  
> +u8 dummy_functioni(struct adapter *var0, u8 *var1) { return 0; }
> +

I think that this won't compile

>  static struct cmd_hdl wlancmds[] = {
>  	GEN_DRV_CMD_HANDLER(0, NULL) /*0*/
>  	GEN_DRV_CMD_HANDLER(0, NULL)
> @@ -150,7 +152,7 @@ static struct cmd_hdl wlancmds[] = {
>  
>  	GEN_MLME_EXT_HANDLER(0, h2c_msg_hdl) /*58*/
>  	GEN_MLME_EXT_HANDLER(sizeof(struct SetChannelPlan_param), set_chplan_hdl) /*59*/
> -	GEN_MLME_EXT_HANDLER(sizeof(struct LedBlink_param), led_blink_hdl) /*60*/
> +	GEN_MLME_EXT_HANDLER(sizeof(struct LedBlink_param), dummy_function) /*60*/
>  
>  	GEN_MLME_EXT_HANDLER(sizeof(struct SetChannelSwitch_param), set_csa_hdl) /*61*/
>  	GEN_MLME_EXT_HANDLER(sizeof(struct TDLSoption_param), tdls_hdl) /*62*/
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> index 873d3792ac8e..963ea80083c8 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> @@ -6189,15 +6189,6 @@ u8 set_chplan_hdl(struct adapter *padapter, unsigned char *pbuf)
>  	return	H2C_SUCCESS;
>  }
>  
> -u8 led_blink_hdl(struct adapter *padapter, unsigned char *pbuf)
> -{
> -
> -	if (!pbuf)
> -		return H2C_PARAMETERS_ERROR;
> -
> -	return	H2C_SUCCESS;
> -}
> -
>  u8 set_csa_hdl(struct adapter *padapter, unsigned char *pbuf)
>  {
>  	return	H2C_REJECTED;
> diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
> index 5e6cf63956b8..57977da78eb3 100644
> --- a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
> +++ b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
> @@ -745,11 +745,12 @@ u8 chk_bmc_sleepq_hdl(struct adapter *padapter, unsigned char *pbuf);
>  u8 tx_beacon_hdl(struct adapter *padapter, unsigned char *pbuf);
>  u8 set_ch_hdl(struct adapter *padapter, u8 *pbuf);
>  u8 set_chplan_hdl(struct adapter *padapter, unsigned char *pbuf);
> -u8 led_blink_hdl(struct adapter *padapter, unsigned char *pbuf);
>  u8 set_csa_hdl(struct adapter *padapter, unsigned char *pbuf);	/* Kurt: Handling DFS channel switch announcement ie. */
>  u8 tdls_hdl(struct adapter *padapter, unsigned char *pbuf);
>  u8 run_in_thread_hdl(struct adapter *padapter, u8 *pbuf);
>  
> +/* Dummy function used to fill elements of an array of function pointers */
> +u8 dummy_function(struct adapter *, u8 *);

here 'dummy_function' prototype is declared

>  
>  #define GEN_DRV_CMD_HANDLER(size, cmd)	{size, &cmd ## _hdl},
>  #define GEN_MLME_EXT_HANDLER(size, cmd)	{size, cmd},
> -- 
> 2.31.1
> 
> 

thank you,

fabio
