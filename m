Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5012944294C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 09:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhKBI0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 04:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhKBI0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 04:26:36 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EFCC061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 01:24:01 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id l13so41379251lfg.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 01:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lGA1P2Tr/ukavsshgYa/nXvPdmDWbu05OP2PPDxYnOE=;
        b=O8vKJv5AsHfBWIgPB54pAWEfwY4Wt1OJRHIoBA0fCEa5Z7ViROqa6pkSVoyk5D/Ugp
         T4z9i9r2YsH1ui8Z5RCABnozY837phJFlEHr4/rTZs9TIKptQhIUdBND+e7BCXj/tRSB
         miGiPEbZBH/pmeSE0MXfq6RUocQQdiCCdgiZFON7BagT9Zfp4quUYw/FzZX1Q1L5ptS2
         /aAgI8e8loCN8HLBa979VXmKEN1K/7k+tzOoj2LFuRfwCC4NPh7UQlcsMERohsmrHr5U
         /J9o9pGpwkJxQgHOAcBCryYU1NC7avdoXS5j8uU9npw9UGCLWLJsl02YNm1Zi0p8RtEY
         l0vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lGA1P2Tr/ukavsshgYa/nXvPdmDWbu05OP2PPDxYnOE=;
        b=ShLI7oPSW0yz+Orn5idlEV2V/0+Q8mfgmBQmg/dFwxjzoxxgEmqLp67rQ6AWiF+EUU
         jxaTlhdYt9vy6Ydjcr24YGviDPl05SRITzA2qPuWJ6r19WL91D4DDjMjS6EwQYqJyz6v
         1tIol+MickRZD/awOz9cQmMbi+3sLEFe7jPI0uasGqawRPd6l2s0V2+dfPsHv3to/ttA
         2hvedR6ImsXmLImQBJJeOPfXs6hCPRaCHg2VR1i9VVedz75s/XuGbRsGFTR0bfqaAuwy
         7n3ZtJMjcaUkPQc0snvitKh20gQgxEAvp8vIpAMmCvIT/9rIEI6GjIVROV80cIHfja82
         G+rg==
X-Gm-Message-State: AOAM532rPgQXkqjVcd8o0RYiXOVUumN7uBb661sW+DLvU1/hFihLnQer
        eJRA1/REp7ycib19u5/ijdU=
X-Google-Smtp-Source: ABdhPJzT1xTfYnFrPByNFje0X3a3pTJ5b0IoGpJMKxX/ZWQAAWPZKwRCyN0ehmJTd1yh5PgIRn98NQ==
X-Received: by 2002:a05:6512:1284:: with SMTP id u4mr3680968lfs.273.1635841439621;
        Tue, 02 Nov 2021 01:23:59 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.235.8])
        by smtp.gmail.com with ESMTPSA id b13sm1612925lfb.145.2021.11.02.01.23.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 01:23:59 -0700 (PDT)
Message-ID: <e0c4a337-995e-2dce-1dbf-e0fe4b778455@gmail.com>
Date:   Tue, 2 Nov 2021 11:23:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] staging: r8188eu: remove unneeded variable
Content-Language: en-US
To:     cgel.zte@gmail.com, Larry.Finger@lwfinger.net
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, fmdefrancesco@gmail.com,
        saurav.girepunje@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20211102073226.7966-1-deng.changcheng@zte.com.cn>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20211102073226.7966-1-deng.changcheng@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/21 10:32, cgel.zte@gmail.com wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> Remove unneeded variable used to store return value.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
> ---
>   drivers/staging/r8188eu/core/rtw_mlme_ext.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> index 995a0248c26f..98863a06bdb6 100644
> --- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> @@ -350,7 +350,6 @@ static u8 init_channel_set(struct adapter *padapter, u8 ChannelPlan, struct rt_c
>   
>   int	init_mlme_ext_priv(struct adapter *padapter)
>   {
> -	int	res = _SUCCESS;
>   	struct registry_priv *pregistrypriv = &padapter->registrypriv;
>   	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
>   	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
> @@ -373,7 +372,7 @@ int	init_mlme_ext_priv(struct adapter *padapter)
>   
>   	pmlmeext->active_keep_alive_check = true;
>   
> -	return res;
> +	return _SUCCESS;
>   }

Looks like it always return success, so, maybe, it should return just void?

>   
>   void free_mlme_ext_priv(struct mlme_ext_priv *pmlmeext)
> @@ -1611,7 +1610,6 @@ unsigned int OnAtim(struct adapter *padapter, struct recv_frame *precv_frame)
>   
>   unsigned int on_action_spct(struct adapter *padapter, struct recv_frame *precv_frame)
>   {
> -	unsigned int ret = _FAIL;
>   	struct sta_info *psta = NULL;
>   	struct sta_priv *pstapriv = &padapter->stapriv;
>   	u8 *pframe = precv_frame->rx_data;
> @@ -1644,7 +1642,7 @@ unsigned int on_action_spct(struct adapter *padapter, struct recv_frame *precv_f
>   	}
>   
>   exit:
> -	return ret;
> +	return _FAIL;
>   }
>   
>   unsigned int OnAction_qos(struct adapter *padapter, struct recv_frame *precv_frame)
> 

This looks odd from the beginning... Why return _FAIL even on success?
Anyway, nothing checks these handlers return values:

		ptable = &OnAction_tbl[i];
		if (category == ptable->num)
			ptable->func(padapter, precv_frame);

So, it worth to make them void too, but, I guess, it's out of scope of 
current patch



With regards,
Pavel Skripkin
