Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC733F9BD8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 17:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244176AbhH0PnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 11:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbhH0PnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 11:43:14 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48A9C061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 08:42:24 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id m18so1084945lfl.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 08:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SpcuN/bsBI9VgmAGMIaDIULTEIAi8qlWKPc1ViB4NNI=;
        b=dRCaFrflWTRbihaNb7HXDF6iyIdI8YmmqAmu6KeVTTA6J50Qi5cNSFkvrR9lOhjY8f
         /d4t5+Fht6ECAKE50zOW+2zogeAEKbBES34vg3Lsofd5Ges+GsEG0wL7jbN5WDrKgR0J
         WxD8c852WfVA47i21P/i9eQVSiwzXfQ+EPVZEDVww+6KN5rP3xuno2P6/idqCiPFZRAk
         +tsxOo5g7GA5AXT1SEMEHgAFsDlyi2ldlGm1PuMrMw8HiV6KBiOIIqfQSpcNNDyjq5Zl
         7/can9T9497no7MFmFcBS4z+slAePWbwNtGj1HlFjWIs7GjPcC4iQcFxwykP7gdIz4Yx
         T/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SpcuN/bsBI9VgmAGMIaDIULTEIAi8qlWKPc1ViB4NNI=;
        b=rZBf+wj3B5Riao+7vhPg+fig7kQqAxHQjRtPKq/wvSiPFo4HtSeKB+vOpnNcmju98Y
         2opdCiWxNwyaX814Ipvw0mOrEezrEC9YP0R/ZWJdBgz4bW6Yug71wmkGppPpprKzF+eV
         WZ+5NhDbSj2AxQqlYhSFrOZItDdvTnA1rX2iArkPqACvImZRk5xGatYzbYFXB8AsCCRQ
         KC+itXb6Ify6T4Zp+hBWCx5t+o96TjlVLfnrvdorpvm+mxjT5zp6pMNM4/sRt/eDgMAj
         5Imm2BPcOnodScJ9UEE5XX5oiPkbW1eU+RJ5feLlbl8LIOWZwHutCURzqfJD0tia69CW
         zqSQ==
X-Gm-Message-State: AOAM530Nf26TMwXJXR52uEddvah++gWR9pjFlg8gQViL/fQtRTl8y3b+
        3U6SuFgVTWrd9gJ20YfZYE4=
X-Google-Smtp-Source: ABdhPJyvvu5TfPC7zdfGAANRw/Mr8Wti/DxRpQQJsJ9kmy0sVZm1C+zqCvI8clzw98XJMj2+Qyd0QQ==
X-Received: by 2002:a05:6512:ad6:: with SMTP id n22mr7616497lfu.532.1630078942153;
        Fri, 27 Aug 2021 08:42:22 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id a13sm716270ljn.120.2021.08.27.08.42.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 08:42:21 -0700 (PDT)
Subject: Re: [PATCH linux-next] drivers:r8188eu: remove unneeded variable
To:     CGEL <cgel.zte@gmail.com>, Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jing Yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20210825061531.69678-1-deng.changcheng@zte.com.cn>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <68520ae2-23a8-7948-7feb-aa9a69cc0c59@gmail.com>
Date:   Fri, 27 Aug 2021 18:42:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210825061531.69678-1-deng.changcheng@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/21 9:15 AM, CGEL wrote:
> From: Jing Yangyang <jing.yangyang@zte.com.cn>
> 
> Eliminate the following coccicheck warning:
> ./drivers/staging/r8188eu/os_dep/os_intfs.c:505:6-12:
>   Unneeded variable "status". Return "_SUCCESS" on line 577
> ./drivers/staging/r8188eu/os_dep/os_intfs.c:772: 4-7:
>    Unneeded variable "ret". Return "_SUCCESS" on line 818
> ./drivers/staging/r8188eu/os_dep/os_intfs.c:823:4-8:
> Unneeded variable "ret8". Return "_SUCCESS" on line 849
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Jing Yangyang <jing.yangyang@zte.com.cn>
> ---
>   drivers/staging/r8188eu/os_dep/os_intfs.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
> index 9d7d2b9..8436a43 100644
> --- a/drivers/staging/r8188eu/os_dep/os_intfs.c
> +++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
> @@ -502,7 +502,6 @@ void rtw_proc_remove_one(struct net_device *dev)
>   
>   static uint loadparam(struct adapter *padapter,  struct  net_device *pnetdev)
>   {
> -	uint status = _SUCCESS;
>   	struct registry_priv  *registry_par = &padapter->registrypriv;
>   
>   	GlobalDebugLevel = rtw_debug;
> @@ -574,7 +573,7 @@ static uint loadparam(struct adapter *padapter,  struct  net_device *pnetdev)
>   	snprintf(registry_par->if2name, 16, "%s", if2name);
>   	registry_par->notch_filter = (u8)rtw_notch_filter;
>   
> -	return status;
> +	return _SUCCESS;
>   }
>   

I suggest to make this function return void instead of always returning 
success

>   static int rtw_net_set_mac_address(struct net_device *pnetdev, void *p)
> @@ -751,7 +750,6 @@ void rtw_stop_drv_threads(struct adapter *padapter)
>   
>   static u8 rtw_init_default_value(struct adapter *padapter)
>   {
> -	u8 ret  = _SUCCESS;
>   	struct registry_priv *pregistrypriv = &padapter->registrypriv;
>   	struct xmit_priv	*pxmitpriv = &padapter->xmitpriv;
>   	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
> @@ -797,12 +795,11 @@ static u8 rtw_init_default_value(struct adapter *padapter)
>   #ifdef CONFIG_88EU_P2P
>   	padapter->bShowGetP2PState = 1;
>   #endif
> -	return ret;
> +	return _SUCCESS;
>   }

same

>   
>   u8 rtw_reset_drv_sw(struct adapter *padapter)
>   {
> -	u8	ret8 = _SUCCESS;
>   	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
>   	struct pwrctrl_priv *pwrctrlpriv = &padapter->pwrctrlpriv;
>   
> @@ -828,7 +825,7 @@ u8 rtw_reset_drv_sw(struct adapter *padapter)
>   
>   	rtw_set_signal_stat_timer(&padapter->recvpriv);
>   
> -	return ret8;
> +	return _SUCCESS;
>   }
>   
>   u8 rtw_init_drv_sw(struct adapter *padapter)
> 

same




With regards,
Pavel Skripkin
