Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5E4410759
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 17:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239865AbhIRPZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 11:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbhIRPZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 11:25:24 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F580C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 08:24:01 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id g8so41826276edt.7
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 08:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/PVHZeQvuCdJZw/7spyFDTgAV+tqTP3cubrD/AsvRUE=;
        b=g3G1y6iqalMUdxu2CHB+pDSTfXBWaVTyIT14AiI+GkxoKfEKO5deyRk3NhFk4nnbi4
         veFbn1FGSQMHNS/Kpd0pbpJNl0Pb30U6NehA17r/SrthCklGoP92qKGLKHchspDWK1T0
         uNDuS70fBhJ4gjQmrfnqj3MAjd7cdn0FPuMmdQ3dITDGUAjHJu/inMTB79hhGq+iJg/k
         IBrYTYyyCDgpSkLQTt5J+tOW/lRt9ed/M3Ov1W/urE5irU2BRqspRSvjmoTrfj8CYWrA
         Kx4KTJzJJ4GZbsvnrOKQxuFu9XrM2+33aL6gsY4n0ji77LUFYOMgCW7BE46zAWmIZu8i
         xOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/PVHZeQvuCdJZw/7spyFDTgAV+tqTP3cubrD/AsvRUE=;
        b=Mw2iJpgaHu1HNvPiiZK6os+31oTwJA9ejEqFRwOQHNiuO6ccgt88k9nPWgOd7iaFAu
         ZUwSf8yNFdiTG1V4IiQWVnCqL+yoaW5FMw+wclLMqQxAqt3uqQdVMhLgJR4XedneJodH
         EpYUuJPWqK7oMf5LhQLpqlkvRPU0Ru+x3anGlBECvVYWF79wbhSQEY5ydyv8DpXwlT8k
         Zm0I63s1pY/QFUsAwcqEq9kPj7RPA1d/z04n0Ki70IRYmTojfZyisw5B0R8m+amSB3m+
         oqZamow7BIIhZ/cjSEkrniFXbC586dcHrtq9XKufY4s3L65LyOETk0yYMKh1bO/6eHqj
         9NNQ==
X-Gm-Message-State: AOAM532yIuQyoz3ZDbK4vzzJCf3AKINvOi2B38P9o/xfh4pw0buGOq1y
        W0X5HXRzRH9EhPmNN5X1iak=
X-Google-Smtp-Source: ABdhPJxyOJoPGKkmBorV+l/KTBon5gA3f+YV/V2WnySmLJsQeY152oV20/A8mhK3XxEPGkyZE6P9Tw==
X-Received: by 2002:a17:906:688a:: with SMTP id n10mr18642709ejr.389.1631978639707;
        Sat, 18 Sep 2021 08:23:59 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::cde? ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id i13sm4164751edc.48.2021.09.18.08.23.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Sep 2021 08:23:59 -0700 (PDT)
Message-ID: <202aba98-2e54-9728-3bcb-2f195062a535@gmail.com>
Date:   Sat, 18 Sep 2021 17:23:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] staging: r8188eu: remove rtw_free_pwrctrl_priv prototype
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210918141141.28547-1-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20210918141141.28547-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/21 16:11, Martin Kaiser wrote:
> The rtw_free_pwrctrl_priv has already been removed in commit 6729e7541934
> ("staging: r8188eu: _free_pwrlock is empty"). Remove the prototype as well.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   drivers/staging/r8188eu/include/rtw_pwrctrl.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/r8188eu/include/rtw_pwrctrl.h b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
> index a77fb76a0b09..e412ef71b54b 100644
> --- a/drivers/staging/r8188eu/include/rtw_pwrctrl.h
> +++ b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
> @@ -134,7 +134,6 @@ struct pwrctrl_priv {
>   				       (pwrctrl)->pwr_state_check_interval)
>   
>   void rtw_init_pwrctrl_priv(struct adapter *adapter);
> -void rtw_free_pwrctrl_priv(struct adapter *adapter);
>   
>   void rtw_set_ps_mode(struct adapter *adapter, u8 ps_mode, u8 smart_ps,
>   		     u8 bcn_ant_mode);
> 

Looks good to me.

Acked-by: Michael Straube <straube.linux@gmail.com>

Thanks,
Michael
