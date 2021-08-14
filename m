Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2623EC400
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 19:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238774AbhHNRDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 13:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234577AbhHNRDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 13:03:05 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C86C061764
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 10:02:36 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id k5-20020a05600c1c85b02902e699a4d20cso8885570wms.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 10:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=X9HnISzXWkNVCczHXM6hTEMkBbJkCBVv5W2RvJ/RQCE=;
        b=IaI8Qf8y3Hhbe7l9Yq/M1VmbnJfx/iZy3c2Hrq0p2vC1m3Q4cUrhRuE40EWvUUUpL1
         mGOBHV7kvFtHK7oY1or4FxjMIFxoF1WD9i3guIwka0EEjYUHEJxJel3312TkFwn8TCKx
         morDQDr0p20mAkUzxQhLDnn6oze42yyfsb9+/FQeDFcY9mSUkl+kZq5hjJC9tONoIbcW
         NDvLt8JqpIcI5DI6h1sp2xaSkCYIA1JJNxJJBX5FFnZfWxBL/7Fl/O2qNWIVNXWSJA6+
         Ge0lQd2RMebV250RYgU93nFt5LcxWFt7RgRw93snmqD4YLJ5bKg6TndYQ1duwH6111nG
         WtVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X9HnISzXWkNVCczHXM6hTEMkBbJkCBVv5W2RvJ/RQCE=;
        b=qH0QBrvdUeCJ+RItHpEM1E2+EDHCbvy5A24eb56uVN2MFeLzaiOrfP0qVpfIHZwm1U
         kuMCoVgJMTCEjIAp8UHkjBaUTNLK5QVAw37fZTjI/93XCpEKWaMYSy07oDhkWUwZTFkw
         ufQAGEAy2C3xwwVVVAqeoVga95bLsliYRA+VfDJcSWQ01lOFPZTBM6n4mFi0o0FpMHIf
         eQmgFPathM7q2Lu6Oy4Pkwi3jh2mdksuJmjAh6y5jO6F43UVcIFhEz4ZX0xZSgOwwXEx
         p9J14KAetpDduICuQocyl82KjjsE5INMdJkSldbFv9P3qOEb2Ejn4eEfwWbPE5nboif6
         +pDg==
X-Gm-Message-State: AOAM530pB5smWoIabGO5LdjWqKrjDl01Cjyb6aT+HV/tIgTVNC3cDFvo
        Mu3aEv49yHFmjfj2FtK4zzKPivbZTP4=
X-Google-Smtp-Source: ABdhPJzvdRKJhhSHZETge+N+tLedrQj+cQPZKJB0HLdBgPp04ehf56MNITDph3+Ysd13DGMYAeEFyw==
X-Received: by 2002:a1c:6a18:: with SMTP id f24mr2346878wmc.142.1628960554971;
        Sat, 14 Aug 2021 10:02:34 -0700 (PDT)
Received: from ?IPv6:2a02:8108:96c0:3b88::4058? ([2a02:8108:96c0:3b88::4058])
        by smtp.gmail.com with ESMTPSA id z5sm4934753wmi.36.2021.08.14.10.02.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Aug 2021 10:02:34 -0700 (PDT)
Subject: Re: [PATCH] staging: r8188eu: os_dep: Remove defined but not used
 variables
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Martin Kaiser <martin@kaiser.cx>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210814160804.11634-1-fmdefrancesco@gmail.com>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <e0c701f3-d13e-421a-c22b-d6be98e28e97@gmail.com>
Date:   Sat, 14 Aug 2021 19:01:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210814160804.11634-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/21 6:08 PM, Fabio M. De Francesco wrote:
> Remove defined but not used const variables. Issues detected by GCC
> running with -Wunused-const-variable option enabled.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>   drivers/staging/r8188eu/os_dep/ioctl_linux.c | 21 --------------------
>   1 file changed, 21 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> index 38ee41f9d2ba..d9fdd83218dc 100644
> --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> @@ -84,11 +84,6 @@ static u32 rtw_rates[] = {1000000, 2000000, 5500000, 11000000,
>   	6000000, 9000000, 12000000, 18000000, 24000000, 36000000,
>   	48000000, 54000000};
>   
> -static const char * const iw_operation_mode[] = {
> -	"Auto", "Ad-Hoc", "Managed",  "Master", "Repeater",
> -	"Secondary", "Monitor"
> -};
> -
>   void indicate_wx_scan_complete_event(struct adapter *padapter)
>   {
>   	union iwreq_data wrqu;
> @@ -6666,19 +6661,3 @@ struct iw_handler_def rtw_handlers_def = {
>   	.num_private_args = sizeof(rtw_private_args) / sizeof(struct iw_priv_args),
>   	.get_wireless_stats = rtw_get_wireless_stats,
>   };
> -
> -/*  copy from net/wireless/wext.c start */
> -/* ---------------------------------------------------------------- */
> -/*
> - * Calculate size of private arguments
> - */
> -static const char iw_priv_type_size[] = {
> -	0,			      /* IW_PRIV_TYPE_NONE */
> -	1,			      /* IW_PRIV_TYPE_BYTE */
> -	1,			      /* IW_PRIV_TYPE_CHAR */
> -	0,			      /* Not defined */
> -	sizeof(__u32),		  /* IW_PRIV_TYPE_INT */
> -	sizeof(struct iw_freq),	 /* IW_PRIV_TYPE_FLOAT */
> -	sizeof(struct sockaddr),	/* IW_PRIV_TYPE_ADDR */
> -	0,			      /* Not defined */
> -};
> 

Looks good to me, thanks.

Acked-by: Michael Straube <straube.linux@gmail.com>

Michael
