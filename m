Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C413FA4FA
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 12:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbhH1KU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 06:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbhH1KU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 06:20:26 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0A7C061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 03:19:36 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id g138so5397546wmg.4
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 03:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RC7LPyfbNt1+RagRhkvYWa1ipbTkkODFFOj4k/E6Cm0=;
        b=CVGsQxvh2nuqKrftwTRo/9U9LFYy75R9GXFX8PBFnQudTSHCUDWNjHponrLyZKm0pT
         pzbutD7YXiDWVJdNoLg/hlV5IDoMHVi/VGMrj3ezUEnKh/30ZpZLf2h6/gy3EIphOW+R
         pxhCEFLX0L15ReywgSPM1RBYHdWLALAcqYGmZdxC1A343uvY59Wmg0YvxH++PfAB85oN
         FuBYatfmoXjxq+AwNXzD8LFtZ1PLWtl0IJOv6RM9UR1lCQ1ZQgYgGa8saddYIS/uNwWb
         B8rnIydBY14AFNm6nrsH7x15aU2iVHAEchfc3MCv5Se5fUAwCnbRGk+QybbRXnrvfEI9
         iASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RC7LPyfbNt1+RagRhkvYWa1ipbTkkODFFOj4k/E6Cm0=;
        b=saJkt0N0XRucYKL9efAZSogZq3ym6MvCH4W91Bg61YvLDSBqXyLvEaI7//osfb1H/X
         9a5hy4hUR0dYjeqKVYCGPNYfM5apDs6zTGsaOmRHrw7PDOOk/hdu3cf5nJyrwz4/kFGy
         6nKupgTWZBbWa59+KlbMunlDSRs/b6DaT8k7+Nqq0dqBoVjFH0KxCU3nQs7JoMtzDq2h
         H4BNeo9FRTMAYm0uELEfvD5madvslhRqvvK6mDCo4j4566ZliCcr+fp8B3y8KemY2S8N
         2vtT1D/qe42WUNuGB8/rDsW4BXj33nydZc0fgWeQXENVJnmx21GB/KUUuFAjyCrDEA4+
         MSwQ==
X-Gm-Message-State: AOAM5331lMma99wU4NBz7R7Okpi1LTczFlGy8YijBEfoZ73sF0QBT+hE
        /4/5iTsGRKE58GtomCct/Go=
X-Google-Smtp-Source: ABdhPJwR8VQlUVWGCgpSTy/QdZkOyivdFSVPEMb+xjddUTSGZXkHH0hXCC3LHrbXCugH3aJcWlfD4A==
X-Received: by 2002:a7b:c197:: with SMTP id y23mr23013238wmi.135.1630145974873;
        Sat, 28 Aug 2021 03:19:34 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::884b? ([2a02:8108:96c0:3b88::884b])
        by smtp.gmail.com with UTF8SMTPSA id m7sm12935776wmq.29.2021.08.28.03.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Aug 2021 03:19:34 -0700 (PDT)
Message-ID: <bc0c9cd1-d915-2cb0-ef57-3b9dc5410bbc@gmail.com>
Date:   Sat, 28 Aug 2021 12:19:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH] staging: r8188eu :os_dep: remove condition with no effect
Content-Language: en-US
To:     Saurav Girepunje <saurav.girepunje@gmail.com>,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, nathan@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
References: <YSoCfTaR66C6iJFw@user>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <YSoCfTaR66C6iJFw@user>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/21 11:31, Saurav Girepunje wrote:
> Remove the condition with no effect (if == else) in usb_intf.c
> file.
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---
>   drivers/staging/r8188eu/os_dep/usb_intf.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
> index bb85ab77fd26..849563b54727 100644
> --- a/drivers/staging/r8188eu/os_dep/usb_intf.c
> +++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
> @@ -496,10 +496,8 @@ static int rtw_resume(struct usb_interface *pusb_intf)
>   	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
>   	int ret = 0;
> 
> -	if (pwrpriv->bInternalAutoSuspend)
> -		ret = 
> -	else
> -		ret = rtw_resume_process(padapter);
> +	ret = rtw_resume_process(padapter);
> +
>   	return ret;
>   }

Thanks for your patch. Perhaps this could be further simplified to:

int ret = rtw_resume_process(padapter);

return ret;

or even:

return rtw_resume_process(padapter);

Best regards,
Michael
