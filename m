Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01CF3407109
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 20:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbhIJSmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 14:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhIJSl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 14:41:59 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481DDC061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 11:40:48 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id i25so1950049lfg.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 11:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3vkTMGrZ3SRZIZdzzIrtgXnmVKr3uAywThftSTXEpQY=;
        b=LAXyZ71WmTVjjlIkgp8qd5/MZzB4/gg+KUl/2LCXnkwX8nvBSbTc9rOwfKC+/RTmNO
         H85MliFgE2jxwO/GH5u9rg4EwIaWjNWJ+OI7pspJusPnIczEioczoCQLC5EQBWrHEQ47
         oRndC7ATCBWesElZnBlNxuxOo6IsGKuRI5gC3EwnnzR0Z0cWYLtWIOn6elhJNMb2eQbM
         mABBmosWonK0MeS+OaG4ghyk9Uh7OglgSZwm3NCl21v01BQ8zcMIEUHBXasGHPJ3Q6Iy
         rUHShIf9lgDBgVXV9jd+fNylnPcbcR6+HbI/HsaGruFrSBVGQrs9mypM1YxYt22QttGJ
         7FHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3vkTMGrZ3SRZIZdzzIrtgXnmVKr3uAywThftSTXEpQY=;
        b=lwXx0j22LHzyldu7Lco6wh4KP0AIxPuRVjTjgzGvTtbN7uyW8UK0qf5dT2JTUiRH7M
         eudHTTpsTeScdWkuW8MCOFxjUF1r4kV321wbHJtjT5qw+MGIDhZS5jyUBzA9ADVprofW
         3fJXRHuBsaY+L+aAXof3ckM+xg8j4Zth/SZ7ErppbowjeP/v20yUeuXRaHGpVzKBlk4u
         zymOw5zmI9RnQKsOPNdLytLw15kYH9XGZrtvNf8K7jAxlW16QbiQMmWesy7JYUCaKH/+
         kzGmKXId22CuXpw46ScBj+stW1O9suWdJvKMDdTnzky0rGDDOSH8mPGZyQnK+mX4djrB
         sKgA==
X-Gm-Message-State: AOAM530OGYv0arXoh+yNpq28lRVdgoQSetPEVeuFpYmcVw0NVEL3Us15
        3jF+/3ZgPZsiP9zK+cvHUdE=
X-Google-Smtp-Source: ABdhPJz5ZkaZjWTWzzQccHlDZvXfHwAEaCrAp3HYRTEhRBJRUP/4tK6H3AmjqeACS8MXsmjj41A61g==
X-Received: by 2002:a05:6512:304b:: with SMTP id b11mr5177111lfb.502.1631299246559;
        Fri, 10 Sep 2021 11:40:46 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.67.70])
        by smtp.gmail.com with UTF8SMTPSA id r13sm636505ljh.61.2021.09.10.11.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 11:40:46 -0700 (PDT)
Message-ID: <dbc1947b-f9bf-c577-6b1d-c73516e7ff49@gmail.com>
Date:   Fri, 10 Sep 2021 21:40:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH] staging: r8188eu: core: remove unused variable padapter
Content-Language: en-US
To:     Saurav Girepunje <saurav.girepunje@gmail.com>,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
References: <YTukfSY0CxowGXlQ@user>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <YTukfSY0CxowGXlQ@user>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/21 21:31, Saurav Girepunje wrote:
> Remove unused variable padapter from mp_init_xmit_attrib().
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>

Reviewed-by: Pavel Skripkin <paskripkin@gmail.com>

Thanks!

> ---
>   drivers/staging/r8188eu/core/rtw_mp.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_mp.c b/drivers/staging/r8188eu/core/rtw_mp.c
> index dabdd0406f30..8ac23d2112fb 100644
> --- a/drivers/staging/r8188eu/core/rtw_mp.c
> +++ b/drivers/staging/r8188eu/core/rtw_mp.c
> @@ -75,7 +75,7 @@ static void _init_mp_priv_(struct mp_priv *pmp_priv)
>   	memcpy(pnetwork->Ssid.Ssid, "mp_871x", pnetwork->Ssid.SsidLength);
>   }
> 
> -static void mp_init_xmit_attrib(struct mp_tx *pmptx, struct adapter *padapter)
> +static void mp_init_xmit_attrib(struct mp_tx *pmptx)
>   {
>   	struct pkt_attrib *pattrib;
>   	struct tx_desc *desc;
> @@ -107,7 +107,7 @@ s32 init_mp_priv(struct adapter *padapter)
>   	pmppriv->papdater = padapter;
> 
>   	pmppriv->tx.stop = 1;
> -	mp_init_xmit_attrib(&pmppriv->tx, padapter);
> +	mp_init_xmit_attrib(&pmppriv->tx);
> 
>   	switch (padapter->registrypriv.rf_config) {
>   	case RF_1T1R:
> --
> 2.32.0
> 


With regards,
Pavel Skripkin
