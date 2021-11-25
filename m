Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29CBC45E01D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 18:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbhKYSCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 13:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355657AbhKYSAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 13:00:41 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E36FC0613BE
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 09:49:01 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 133so6264640wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 09:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PJCc5QqWq8SIWCxJePls2Yfaz7hssfHLDOZdKfFnbN4=;
        b=XLa2FScBuBkuGDeiRO0o6jOOfJ0o4Khat5HZHEoQqLFiyq8qxy+I5ddkfWMk4hupCS
         PzRZX3eapZ7AOwPL0pymAmNFkbDnFUzHTr3lXLKffOfArI+tiUiG/05BVqJu3sU1KNP5
         OyBCyjvVbf/G9+ncdorVz9A+I7/Tg4RUbVmaJff/ZwoEh8zOeWhUDop+qivkLcSaYsSo
         cQdD7VyyonzN4im12JG0VYH8DoZZiElhN+rlzPSEtTg+bJTdwGn64X86vI6xmopSbBKC
         ExSX40w1S3L2HpPb0nE6DmtZxJZJiiNOs84LEy7ANUSi42siTZ/y2iwMoDulBrAJ0tOZ
         0ahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PJCc5QqWq8SIWCxJePls2Yfaz7hssfHLDOZdKfFnbN4=;
        b=b3oq0jlGP0Ttq5hxXLLmQvZD2RZvLIzu68Hwpq/sApQSTbFuuL8/pMFJW7+5d/mLjJ
         470sYYYXphscQgGmlxLMQ/dGF/X4X2zOg/lenRs86gt7DqqTtaeCnAle1R1yRewWHaSl
         WV18OHEqrOkm3SCFF1xA8ZDqnTqcoQ17fDeJOFHBbVR+8tvJ0KLYLcmiucbUNhmmTWzm
         PqMnXsSwVc6tAOJmhLax47QgwbusJTr1ubkplix1Ol1S3LtNZgYejq2TfDFOBgUUyBL5
         9I79u0GeDUzm8fDxHFTQ0Ps56kwcyylrwZNhc8dQmWeS4wTt6FmNJQuHWqEhvOqrgfxW
         352Q==
X-Gm-Message-State: AOAM530kfrPPpQ2029lwBWR0PNjhef+VaaCLyAv5n88EF/8Jf3eurV1v
        TtUM+wNdtmEs4zTXwu8lJ0U=
X-Google-Smtp-Source: ABdhPJw5l3IETGCDco+C3TLxjlDf81me85PbicBW+NT8hjSgTy5TeuNrABNe9kNrk8H9PSgQgHPsjg==
X-Received: by 2002:a05:600c:b46:: with SMTP id k6mr9456701wmr.45.1637862540287;
        Thu, 25 Nov 2021 09:49:00 -0800 (PST)
Received: from ?IPV6:2a02:8108:96c0:3b88::7311? ([2a02:8108:96c0:3b88::7311])
        by smtp.gmail.com with ESMTPSA id y7sm3326485wrw.55.2021.11.25.09.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Nov 2021 09:49:00 -0800 (PST)
Message-ID: <8a74f32b-381d-919b-816c-4b93706e6da8@gmail.com>
Date:   Thu, 25 Nov 2021 18:48:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 4/4] staging: r8188eu: loadparam needs no net_device
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211125164745.8188-1-martin@kaiser.cx>
 <20211125164745.8188-5-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20211125164745.8188-5-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/21 17:47, Martin Kaiser wrote:
> Remove the second parameter of the loadparam function. This parameter
> is not used.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   drivers/staging/r8188eu/os_dep/os_intfs.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
> index 397981bc9a62..02700834c587 100644
> --- a/drivers/staging/r8188eu/os_dep/os_intfs.c
> +++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
> @@ -153,7 +153,7 @@ MODULE_PARM_DESC(rtw_notch_filter, "0:Disable, 1:Enable, 2:Enable only for P2P")
>   module_param_named(debug, rtw_debug, int, 0444);
>   MODULE_PARM_DESC(debug, "Set debug level (1-9) (default 1)");
>   
> -static uint loadparam(struct adapter *padapter,  struct  net_device *pnetdev)
> +static uint loadparam(struct adapter *padapter)
>   {
>   	struct registry_priv  *registry_par = &padapter->registrypriv;
>   
> @@ -371,7 +371,7 @@ struct net_device *rtw_init_netdev(struct adapter *old_padapter)
>   	pnetdev->wireless_handlers = (struct iw_handler_def *)&rtw_handlers_def;
>   
>   	/* step 2. */
> -	loadparam(padapter, pnetdev);
> +	loadparam(padapter);
>   
>   	return pnetdev;
>   }
> 

Reviewed-by: Michael Straube <straube.linux@gmail.com>

