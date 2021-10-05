Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB7042334F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 00:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhJEWSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 18:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236711AbhJEWSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 18:18:45 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F081AC061753
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 15:16:52 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r10so2349154wra.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 15:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qxs6a/YOJlcXbFGJuLKjfSBLL26lfGvubpNFpg4B2uw=;
        b=FBy3dmrQ48JXwNkdxo1l405ZzKldehno8kEVoWUSik5BAsMNmcxPElYUXJXXHfuad2
         dIwJ7XDUfmWyfhryi1uXf+nSdr795+xnpPXmSvzOEcDcfWuoSu8auJmllKW8nDdjrCU9
         Hz13Xv27UA4cWQizmo1n/TBozZ1oVX+4g8m8nKP2i4rld9nem7kmxKwj0ruwyJlYMNRv
         oq774EVvSliscTF7q6k/FpWr21EVUKxi7GLTWgzX7hO7R61SY7hdtAO5Ye159nB9KSKa
         SXIl51vZAHhxQz4LxuDWsAaRSgAQxWD22zUA5IOjBtfJrBysCJSZ7P2lCvA4OkYHEpgL
         qBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qxs6a/YOJlcXbFGJuLKjfSBLL26lfGvubpNFpg4B2uw=;
        b=Hx3oW08v4HP/OopZxE7NqsHIlIM/dOTL5JOvzJbqXEe5sUQ+DL4pa3mgMQnKoaAaw0
         YSw+EgYHm7LFqh5sO10eCVH1T5QoWTm+ugee8HXq8Hlcx1UEwkYlc2Zp+1vyYPjXvmoI
         AJTWfeysdAfZp2cetyy40XbbqvsU+ZltjC8wlXD0E/fFrjYZcQGSHi8OBdB3T//unDdz
         lSgzUc8kFS4mAx809tTt1UMdobopmhOUr66fuXhpPFaNiUQHALzMFy8ry1XfZHPHub71
         egeD57XrNPpPcnY6bXRXFLKtFTmoj8hpHmTfgudu2ip2BpSiI0c8W0UFezugxQSswXa9
         dBwQ==
X-Gm-Message-State: AOAM533Aahhzh2e9hQ06J1c7Jc2JFZlxeL/WC5o19bhCvS0yDt90Jpry
        mCtM5qtRCMi9KStOYnwt+1A=
X-Google-Smtp-Source: ABdhPJzZB+JtVAm6+HqIG/y9NkLeFXjXgX8Uid2KwwK1kakGPkc7XjNSPr6MrZPbWeMFeH1goxMqrQ==
X-Received: by 2002:a7b:cc88:: with SMTP id p8mr6215089wma.101.1633472211575;
        Tue, 05 Oct 2021 15:16:51 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::f816? ([2a02:8108:96c0:3b88::f816])
        by smtp.gmail.com with ESMTPSA id j6sm5271416wrh.76.2021.10.05.15.16.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 15:16:51 -0700 (PDT)
Message-ID: <dd53513b-00c1-e915-712b-08b7cb7b5b34@gmail.com>
Date:   Wed, 6 Oct 2021 00:16:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 9/9] staging: r8188eu: support interface is always usb
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211005200821.19783-1-martin@kaiser.cx>
 <20211005200821.19783-9-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20211005200821.19783-9-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/21 22:08, Martin Kaiser wrote:
> We set ODM_CMNINFO_INTERFACE to ODM_ITRF_USB as this driver supports
> only usb. Therefore, dm_odm->SupportInterface is always ODM_ITRF_USB.
> 
> Simplify some if conditions accordingly. Remove/replace two empty
> functions.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   drivers/staging/r8188eu/hal/odm_HWConfig.c | 58 +++++++---------------
>   1 file changed, 19 insertions(+), 39 deletions(-)
> 

<...>

>   
>   static s32 odm_SignalScaleMapping(struct odm_dm_struct *dm_odm, s32 CurrSig)
>   {
> -	if ((dm_odm->SupportPlatform == ODM_MP) &&
> -	    (dm_odm->SupportInterface != ODM_ITRF_PCIE) && /* USB & SDIO */
> -	    (dm_odm->PatchID == 10))
> -		return odm_sig_patch_netcore(dm_odm, CurrSig);
> -	else if ((dm_odm->SupportPlatform == ODM_MP) &&
> -		 (dm_odm->SupportInterface == ODM_ITRF_PCIE) &&
> -		 (dm_odm->PatchID == 19))
> -		return odm_sig_patch_lenove(dm_odm, CurrSig);
> +	if ((dm_odm->SupportPlatform == ODM_MP) && (dm_odm->PatchID == 10))
> +		return 0;
>   	else
>   		return odm_SignalScaleMapping_92CSeries(dm_odm, CurrSig);
>   }
> 

dm_odm->SupportPlatform is always ODM_CE, so this could be just:

	return odm_SignalScaleMapping_92CSeries(dm_odm, CurrSig);

And then it's just an unnecessary wrapper. ;)

Regards,
Michael
