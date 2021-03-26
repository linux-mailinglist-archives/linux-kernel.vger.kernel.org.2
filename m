Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 779C434AEEC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 20:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhCZTGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 15:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhCZTGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 15:06:21 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4E8C0613B1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 12:06:21 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id n21so6470748ioa.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 12:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iGIQ1hcGQQNpOYIY/AUEiBnrXouDjQgdVYHaK86pao8=;
        b=Xmcmt+p3dO0skhmoEpw6S2pw8jp0vuDua5iAd4gE+CgAtkGzwJn7UjWtygnNtVDtN1
         DWh3OuVQ23uOjy/JLrouyLe5azJUna2G4lF5l6HNzNfWAGsNfuKRJefrC+pgpUebK7xG
         s11VBnD2iWtRJoVrMVnYfCD8Z5bh+EYNaV/qQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iGIQ1hcGQQNpOYIY/AUEiBnrXouDjQgdVYHaK86pao8=;
        b=aDfxxDwRVaeGLDEWjl78C/tg+Wfo8HosD0VvunPsai0XYFVOu/8OEjYXGCUgK5s/97
         PUormQD+n44GFVWE4EKRvc+yjZz3aIvMnfa30qcN1K2ZeZaDTwXr47zRuraHUpRcDLT+
         opVtydr+1ClnoSJgQnO5bEdO/TijpeUIFgiLskbsabprTtBhkUY2cKPurRr86ZKKdfES
         6os7CtzLhcG4upm7tQo2S3YMD/XLdcj1ZKTWh42c5DPbaN+Iyu54u18B3jeuu1QW4GJT
         I5gmkedRO/gqpH9H5aG/xXjhg53ZAF63Iomgkx3OBT5zMgyUH3aF2a2gxKZQaMM0JjgC
         QHeQ==
X-Gm-Message-State: AOAM532R/ilqGExJgZIHf5AtGcQwFj/YEhm1XDlFs6LKRK/IyVxepeXE
        TTkfYr/nc83xD8n1sb5BWh9lGw==
X-Google-Smtp-Source: ABdhPJz1Qt4D0rNhLf568C9tqdSbIyX56jFCPovgDpfjMgus2Nn6hkGIJaZ5Vixojp9/jjDAptMd8w==
X-Received: by 2002:a05:6602:2d95:: with SMTP id k21mr11346052iow.123.1616785580532;
        Fri, 26 Mar 2021 12:06:20 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f9sm4692257iol.23.2021.03.26.12.06.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 12:06:20 -0700 (PDT)
Subject: Re: [PATCH] selftests/timers: remove unneeded semicolon
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        john.stultz@linaro.org
Cc:     tglx@linutronix.de, sboyd@kernel.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <1615276181-27090-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a5274488-2be2-9ef6-e01d-18da789a9881@linuxfoundation.org>
Date:   Fri, 26 Mar 2021 13:06:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1615276181-27090-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/21 12:49 AM, Jiapeng Chong wrote:
> Fix the following coccicheck warnings:
> 
> ./tools/testing/selftests/timers/nanosleep.c:75:2-3: Unneeded semicolon
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>   tools/testing/selftests/timers/nanosleep.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/timers/nanosleep.c b/tools/testing/selftests/timers/nanosleep.c
> index 71b5441..433a096 100644
> --- a/tools/testing/selftests/timers/nanosleep.c
> +++ b/tools/testing/selftests/timers/nanosleep.c
> @@ -72,7 +72,7 @@ char *clockstring(int clockid)
>   		return "CLOCK_BOOTTIME_ALARM";
>   	case CLOCK_TAI:
>   		return "CLOCK_TAI";
> -	};
> +	}
>   	return "UNKNOWN_CLOCKID";
>   }
>   
> 


Can you send one single patch for all these timers fixes. All of these
patches have the same subject line and it is becoming hard to tell
them apart.

thanks,
-- Shuah
