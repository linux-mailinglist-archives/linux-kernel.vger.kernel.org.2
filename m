Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCF1386B69
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 22:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242684AbhEQUd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 16:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234249AbhEQUdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 16:33:24 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8853C061573;
        Mon, 17 May 2021 13:32:07 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id q10so7162631qkc.5;
        Mon, 17 May 2021 13:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7tDiRnux3uGojDgUk7bh9AMoMEuxHuA0volg/VGIBr0=;
        b=nIvO8kJuEVhhjIGB6QynAKHZyarbmO5+pCfkGFoGSJBdQfIAupRkIAfiVCPEmuAF08
         MEvsG/Z7Oe3h9O744TVcz6XaOYpmc9V13jO2p0i8ueT3hBLfXDPuMnDWgRFFoPb9uhn6
         MxuNLFBMFZXkbdndqoD5VqDNxDIj8EF4ed1TDnFHwvLLytX1wxm0pnXTgbyAIKhrKfzv
         6cXZ7buvJDCzT76JNWKC4Uy3JGsPckpCiC4zztLvtTlWFiOz8Psz1nT7QJVGbsTWgu7q
         iVM4gMoRKEIR2mBA5VRfgjFE0ngrxfNypVDXFIGJCZHyEyo2EMQAXSNjHABH5QQHoeIh
         Aj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=7tDiRnux3uGojDgUk7bh9AMoMEuxHuA0volg/VGIBr0=;
        b=LWKrNUBMioz6pNPzAx8sM5pDJHDu/GaWm5IWe+lS6D8CvZPNbY3qhiEPpWpMVXqaZR
         HrFw1LeVUcM4lK+hUGd20D0biFeSUsSNsw9FIGKTCY35AIlfD3Zwi8Jip4OJGpSR6J6U
         Dif8d9n/+LDyh/xWLSdNwR8HkdfIF6ug61VzZk6m8F4PnVY+iXiZpo+6aHpbAWXY6VHJ
         W7VxW89GxqRjHReqaxCxBusL3fREIUObxKgIskMcVTCy/UVnROdSFkfYnRUiyG48tYC0
         xrtCD6S/df9+tDz09pvQpd4xPQXkLZnwJP+8OH6wnClF9x2OU+QLNG2lrqoj8pcyE1QN
         8BdA==
X-Gm-Message-State: AOAM531iiNZiyge3p30UTYkPOTpV/foQND8SAGrzjUihV2fklDI1E8dl
        /gb9Cd9VKRPcvPnPABIVX1Q=
X-Google-Smtp-Source: ABdhPJywC7gR3ZD4k1krxuHzwmwfJc2ESji7ZOfPZX6VhrU8S+kfVJeD5EdVbnzLZVLZh2lQZVx09w==
X-Received: by 2002:a37:a604:: with SMTP id p4mr1686927qke.215.1621283527185;
        Mon, 17 May 2021 13:32:07 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j6sm11273426qti.4.2021.05.17.13.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 13:32:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 17 May 2021 13:32:05 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] staging: rtl8188eu: use safe iterator in
 rtw_free_all_stainfo
Message-ID: <20210517203205.GB3620180@roeck-us.net>
References: <20210516160613.30489-1-martin@kaiser.cx>
 <20210517201826.25150-1-martin@kaiser.cx>
 <20210517201826.25150-2-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517201826.25150-2-martin@kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 10:18:22PM +0200, Martin Kaiser wrote:
> This is another case where we may remove list entries while we iterate over
> the list. Use list_for_each_entry_safe to avoid an endless loop.
> 
> Fixes: 23017c8842d2 ("staging: rtl8188eu: Use list iterators and helpers")
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> v2:
>  - use list_for_each_entry_safe
> 
> Without this patch, unloading the module goes into an endless loop
> sometimes.
> 
>  drivers/staging/rtl8188eu/core/rtw_sta_mgt.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
> index 7941ca0397ed..5af7af5f5a5a 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
> @@ -379,9 +379,9 @@ u32 rtw_free_stainfo(struct adapter *padapter, struct sta_info *psta)
>  /*  free all stainfo which in sta_hash[all] */
>  void rtw_free_all_stainfo(struct adapter *padapter)
>  {
> -	struct list_head *plist, *phead;
> +	struct list_head *phead;
>  	s32 index;
> -	struct sta_info *psta = NULL;
> +	struct sta_info *psta, *temp;
>  	struct sta_priv *pstapriv = &padapter->stapriv;
>  	struct sta_info *pbcmc_stainfo = rtw_get_bcmc_stainfo(padapter);
>  
> @@ -392,9 +392,7 @@ void rtw_free_all_stainfo(struct adapter *padapter)
>  
>  	for (index = 0; index < NUM_STA; index++) {
>  		phead = &pstapriv->sta_hash[index];
> -		list_for_each(plist, phead) {
> -			psta = list_entry(plist, struct sta_info, hash_list);
> -
> +		list_for_each_entry_safe(psta, temp, phead, hash_list) {
>  			if (pbcmc_stainfo != psta)
>  				rtw_free_stainfo(padapter, psta);
>  		}
> -- 
> 2.20.1
> 
