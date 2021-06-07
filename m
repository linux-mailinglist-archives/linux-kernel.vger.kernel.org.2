Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3EF139DF3A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 16:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhFGOwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 10:52:09 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:35351 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhFGOwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 10:52:08 -0400
Received: by mail-wm1-f41.google.com with SMTP id k5-20020a05600c1c85b02901affeec3ef8so2563917wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 07:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KV3zPs4im4phSjU/52hl/BfQSATdJYqhk/PrHcx2zz0=;
        b=nCT2Uck+ppudDmlZd58SohO6wRPIWG5d2DSvA3RejmUNR0hKuOtAJSxgr6xD1Sz5d2
         8oWB8Gjaa4VrCgACwRfTXsdavosuLKerEF6gY79l0xErlRHAJNj0W545e7saKMNpKSE9
         baxJ/eyeDEvp3FWIEiK8CY98x1iZSkrumTzb+BW37VbXOy/tdd3Nu5lAJU1mjDjIHvIP
         qTuFFub28DMAd4vLZ7iF0MT/xtGkIW0Gl+7hzgERcWGCaOJUFmY/WLDRnL/92VnOERRX
         R9+426CC70bePn2S6Etj66uYRV0O3BuZTck2xQSJeO1953C3/+DiO62jhnmBH8YOV6qK
         068w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KV3zPs4im4phSjU/52hl/BfQSATdJYqhk/PrHcx2zz0=;
        b=nJ5Pd708ckQ9yGq9nU6u4z9qB+0QLqiWvRgwxgAyXJB+uTOx3vVA+XG4PPHGaMiIZ+
         k6lZWg0VlRdzNuyvaae/XsU88iOPW8vfdID5fOq/+34r8QV6PWYdcUUZkn+JpWbsndXv
         p7y97DKeZPFuG/jdCahy4o08x0wjODG1Dvob5vIkFqgQVEtCMLt7/bIPaGAisx7YaznJ
         u5kPT2XPgE8Vae2xS5uoDfHhzEVzr0GSOSvU5X1rt8ZkOGJlXEAgB60qki8rbbNScguW
         r/W0+mY3yGGLzPpYn6cK6QHHdRvUo3YDXa2xwFmpHl0mEkx8iRUiiI8RFlRdbm/OEkxT
         +e9g==
X-Gm-Message-State: AOAM532zEqUSgzSRz/NMfyUvaOPlFTXpyvpAFaMPROQ4yED3jj1uNzzd
        yZaHMCJgawlRyqsVMYbo7dk=
X-Google-Smtp-Source: ABdhPJz7byVCgomQHWfqmTxuAfGFw4I0TYizHnTU7u6Ipz9/AscEmlH/KB9YAqIzPvR/8H7HsYg13A==
X-Received: by 2002:a05:600c:1994:: with SMTP id t20mr17320874wmq.177.1623077356153;
        Mon, 07 Jun 2021 07:49:16 -0700 (PDT)
Received: from agape.jhs ([5.171.73.82])
        by smtp.gmail.com with ESMTPSA id n13sm18372021wrg.75.2021.06.07.07.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 07:49:16 -0700 (PDT)
Date:   Mon, 7 Jun 2021 16:49:13 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8723bs: os_dep: Remove conditions with no
 effects
Message-ID: <20210607144912.GA1401@agape.jhs>
References: <20210606074216.26495-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210606074216.26495-1-fmdefrancesco@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 06, 2021 at 09:42:16AM +0200, Fabio M. De Francesco wrote:
> Removed conditions with no effects. Detected by Coccinelle.
> It seems that these conditions with no effects had been inadvertently
> left while deleting code that had to be conditionally compiled by 
> unused definition CONFIG_AP_WOWLAN (see commit dc365d2cc579).
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> v1 -> v2: Rewrote the changelog according to suggestion by 
> Joe Perches <joe@perches.com>
> 
>  drivers/staging/rtl8723bs/os_dep/os_intfs.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
> index 213ec5b4ce98..2035573ee5a0 100644
> --- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
> +++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
> @@ -1187,10 +1187,7 @@ void rtw_suspend_common(struct adapter *padapter)
>  
>  	rtw_ps_deny_cancel(padapter, PS_DENY_SUSPEND);
>  
> -	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE))
> -		rtw_suspend_normal(padapter);
> -	else
> -		rtw_suspend_normal(padapter);
> +	rtw_suspend_normal(padapter);
>  
>  	netdev_dbg(padapter->pnetdev, "rtw suspend success in %d ms\n",
>  		   jiffies_to_msecs(jiffies - start_time));
> @@ -1268,11 +1265,7 @@ int rtw_resume_common(struct adapter *padapter)
>  
>  	netdev_dbg(padapter->pnetdev, "resume start\n");
>  
> -	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
> -		rtw_resume_process_normal(padapter);
> -	} else {
> -		rtw_resume_process_normal(padapter);
> -	}
> +	rtw_resume_process_normal(padapter);
>  
>  	hal_btcoex_SuspendNotify(padapter, 0);
>  
> -- 
> 2.31.1
> 
> 

Thank you Fabio :)

Reviewed-by: Fabio Aiuto <fabioaiuto83@gmail.com>
