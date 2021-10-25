Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987274399E8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 17:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbhJYPSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 11:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233877AbhJYPSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 11:18:15 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A7FC061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 08:15:53 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id x27-20020a9d459b000000b0055303520cc4so15376600ote.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 08:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bvVtz/dG5wpXJrVUlsjEtf4jIyUq5VXwh2yzvFXtufg=;
        b=JAR+ck8VcTN6+TbYv38Sl0ec6sGWbrO0u2FXw6t9cPYgzXiuixwbHl6G0W77vAN1ea
         UDm+zpnZLfFnhKfCbF48pBSRYGQJjv1hBLAZM+Ri8otUeRgRjproZtjFtYLNdo2PV+X6
         zlTG8VgUplF3eDa5tcKSNv8S8accNJSwZ6UmW/dCjC3d36xfkfx6V+0aWmvXYeQT+c/7
         ONDyAe7prv/ayvqfiLPnI39jREHiaPxmIHFeGu9jFx4+FIlDitmhsBvrPb5Tx0bdkBUW
         fBMDl5MC4+rq7WZy97PTXIScqACWRDihpg1Ii+sC2K3yHPP9fvryoKiB/oE4fybNzIcL
         JHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bvVtz/dG5wpXJrVUlsjEtf4jIyUq5VXwh2yzvFXtufg=;
        b=Q4rskuKZZYYMjbFkuC/wrVdRvP3e8GCuIIyHo1W0h2Tklxlr8NOJ/8+JFSiSw/fUAQ
         zPhIQl20zxu8aNxQCd1uYQyg8zuQ1y4tvyd1QTE9D/ksTGKTkSQ9DjvHdlPKH09nBbGX
         kYBSPOlnzg3ESL6ZId0IHT/MmaSyN2SjNqtws2XMSezNAL5qL8e9Pu3BEr2onFfw7/MJ
         Sy/Me2KC/IVHJ23AGvwqmmqTwYPSEJzPUZrgSZBwxkcQ/eMfJcWOhmuW2n4iubXHluI9
         HchwAidQO45Ox5scDDpKNfYPoe8e5oOw8kCdk4owZCreYcfF5HajjSiMiIRcRB/Zdj0W
         kkCQ==
X-Gm-Message-State: AOAM5317OEgLGr15JdLREUqszgVRAVtQb7C8MeM1qNs61qkga4selKwa
        cm3ZB4JW6TFSE5c/qFFZyq8=
X-Google-Smtp-Source: ABdhPJzs9If2C/jeXxW9RWTxvvyexAy7zBi0YZjsATZ9PGaUaZEPe5fu64jXzj+GXwIOcddZeNPtTQ==
X-Received: by 2002:a9d:6483:: with SMTP id g3mr13968208otl.105.1635174952481;
        Mon, 25 Oct 2021 08:15:52 -0700 (PDT)
Received: from ?IPV6:2603:8090:2005:39b3::101e? (2603-8090-2005-39b3-0000-0000-0000-101e.res6.spectrum.com. [2603:8090:2005:39b3::101e])
        by smtp.gmail.com with ESMTPSA id t11sm3074948otp.68.2021.10.25.08.15.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 08:15:52 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <7dc4eba4-c009-b8b7-bc08-5b608bdf86a0@lwfinger.net>
Date:   Mon, 25 Oct 2021 10:15:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] staging: r8188eu: core: remove goto statement
Content-Language: en-US
To:     Saurav Girepunje <saurav.girepunje@gmail.com>,
        phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, fmdefrancesco@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
References: <YXafzp5F8T7/+tk2@Sauravs-MacBook-Air.local>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <YXafzp5F8T7/+tk2@Sauravs-MacBook-Air.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/21 07:15, Saurav Girepunje wrote:
> Remove the goto statement from rtw_do_join(). In this function goto
> can be replace by return statement. As on goto label exit, function only
> return it is not performing any cleanup. Avoiding goto will improve
> the function readability.
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---

You need to read section 14 of Documentation/process/submitting-patches.rst to 
learn how to submit a revised patch. Resubmitting such a revision using the same 
subject line is likely to confuse reviewers and maintainers alike, if not 
patchworks.

Larry

>   drivers/staging/r8188eu/core/rtw_ioctl_set.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_ioctl_set.c b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
> index 2b54cdfa9d6e..411b06e135be 100644
> --- a/drivers/staging/r8188eu/core/rtw_ioctl_set.c
> +++ b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
> @@ -51,7 +51,7 @@ u8 rtw_do_join(struct adapter *padapter)
>   			ret = _FAIL;
>   		}
> 
> -		goto exit;
> +		return ret;
>   	} else {
>   		int select_ret;
> 
> @@ -78,10 +78,9 @@ u8 rtw_do_join(struct adapter *padapter)
> 
>   				rtw_generate_random_ibss(pibss);
> 
> -				if (rtw_createbss_cmd(padapter) != _SUCCESS) {
> -					ret =  false;
> -					goto exit;
> -				}
> +				if (rtw_createbss_cmd(padapter) != _SUCCESS)
> +					return false;
> +
>   				pmlmepriv->to_join = false;
>   			} else {
>   				/*  can't associate ; reset under-linking */
> @@ -102,8 +101,6 @@ u8 rtw_do_join(struct adapter *padapter)
>   		}
>   	}
> 
> -exit:
> -
>   	return ret;
>   }
> 
> --
> 2.33.0
> 

