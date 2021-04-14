Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02C9835F935
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 18:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352818AbhDNQrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 12:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352816AbhDNQrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 12:47:32 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F970C061756
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 09:46:55 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id o20-20020a05600c4fd4b0290114265518afso10889014wmq.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 09:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o+ROcY1C8wz+8PkDwYJ0lELoDYp6Z6DB0Dpa2ieHXSk=;
        b=WKZZ4YuCmfu4t3u8YtaZHTMmCLTh1OUflTICQbpr98lNRy5a1nW0CB5E01bfuOaSkx
         hRDK9UJpSNgAC5Z+cYmrZPALX2T6vnanFG6BfjAg5OmZsBr2BOMYldptIQ8q9Wwoyn/i
         mzY1uBZ+77qI6HUapXtnXdO9KpwPeci+cRyrz3y4YsTTvizuH6OMaNj9wGetPedi63HC
         hsjbMHpyu/eA3zNTswNgdvRkIlRhfw+eREDOkVlulQUygoBzCv/4wNuZ8VdzgHedD12D
         5uyHro/8Vst7frKlQ98NVlF1NGJco1i9/RN5woAiUoOUfuZJKtgln7Ug+hOn/hU1Ocu6
         U7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o+ROcY1C8wz+8PkDwYJ0lELoDYp6Z6DB0Dpa2ieHXSk=;
        b=sCnXXj/Y4+5tAWv5zqwV2umkwduJVojiYFpNNR5PnkPKjnmsg1XV6UUazXC7Y32g66
         2O6OyPV8YB46vjrlPjCSbgLTeYRCe9vDlrPIvBBXV25JF8kMR7GgNZ2zMtf3ccoN290x
         /h496/H9f+VbV5KT62fFGJp6TnarPPfMIIXmEUOWAO/BoCh3h7IFl1IHqfAb0c9MMNgy
         ESoEfsQZNlOVXFlmQzqQAka885cTPa6vGzdbakgb2wJ4+BJC4UhAwMQPp8pAopK4u5gq
         pvr8riic3yse6EQWddMxWSr7GhcZiGpU381KqXKos5hN+euwi1Zpqc4uoNLvJyadUoEd
         dKAw==
X-Gm-Message-State: AOAM5339ICifaKfC4dqmm/TnAml/4m84chySP5aCDCuvBHKks7pCC7Dy
        M13fHKPhy7bvxY8THVjEeUg=
X-Google-Smtp-Source: ABdhPJyYuz4ksvarjnIv1ssY7WB+q4mqAdzG49O8lSpMxLFJ0uzQDfOL8ktmyipnD664+3bkfm1jUQ==
X-Received: by 2002:a1c:2985:: with SMTP id p127mr3911373wmp.165.1618418814386;
        Wed, 14 Apr 2021 09:46:54 -0700 (PDT)
Received: from agape.jhs ([5.171.72.89])
        by smtp.gmail.com with ESMTPSA id j14sm23224202wrw.69.2021.04.14.09.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 09:46:54 -0700 (PDT)
Date:   Wed, 14 Apr 2021 18:46:51 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [Outreachy kernel] [PATCH v2] staging: rtl8723bs: Remove useless
 led_blink_hdl()
Message-ID: <20210414164650.GA1418@agape.jhs>
References: <20210414162614.14867-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414162614.14867-1-fmdefrancesco@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 06:26:14PM +0200, Fabio M. De Francesco wrote:
> Removed useless led_blink_hdl() prototype and definition. In wlancmds[]
> the slot #60 is now set to NULL using the macro GEN_MLME_EXT_HANDLER. This
> change has not unwanted side effects because the code in rtw_cmd.c checks
> if the function pointer is valid before using it.
> 
> Reported-by: Julia Lawall <julia.lawall@inria.fr>
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> Changes since v1: Corrected a bad solution to this issue that made use of
> an unnecessary dummy function.
> 
>  drivers/staging/rtl8723bs/core/rtw_cmd.c         | 2 +-
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c    | 9 ---------
>  drivers/staging/rtl8723bs/include/rtw_mlme_ext.h | 1 -
>  3 files changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> index 0297fbad7bce..f82dbd4f4c3d 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> @@ -150,7 +150,7 @@ static struct cmd_hdl wlancmds[] = {
>  
>  	GEN_MLME_EXT_HANDLER(0, h2c_msg_hdl) /*58*/
>  	GEN_MLME_EXT_HANDLER(sizeof(struct SetChannelPlan_param), set_chplan_hdl) /*59*/
> -	GEN_MLME_EXT_HANDLER(sizeof(struct LedBlink_param), led_blink_hdl) /*60*/
> +	GEN_MLME_EXT_HANDLER(0, NULL) /*60*/

I'd remove LedBlink_param struct as well, now it's unused

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
> index 5e6cf63956b8..472818c5fd83 100644
> --- a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
> +++ b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
> @@ -745,7 +745,6 @@ u8 chk_bmc_sleepq_hdl(struct adapter *padapter, unsigned char *pbuf);
>  u8 tx_beacon_hdl(struct adapter *padapter, unsigned char *pbuf);
>  u8 set_ch_hdl(struct adapter *padapter, u8 *pbuf);
>  u8 set_chplan_hdl(struct adapter *padapter, unsigned char *pbuf);
> -u8 led_blink_hdl(struct adapter *padapter, unsigned char *pbuf);
>  u8 set_csa_hdl(struct adapter *padapter, unsigned char *pbuf);	/* Kurt: Handling DFS channel switch announcement ie. */
>  u8 tdls_hdl(struct adapter *padapter, unsigned char *pbuf);
>  u8 run_in_thread_hdl(struct adapter *padapter, u8 *pbuf);
> -- 
> 2.31.1
> 
> 

thank you,

fabio
