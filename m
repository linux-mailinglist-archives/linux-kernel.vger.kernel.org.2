Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E693EBEB3
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 01:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235760AbhHMXZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 19:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235628AbhHMXZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 19:25:14 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C560C0617AD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 16:24:46 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id b7so6343021iob.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 16:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yytFgI0IZthMjzs+JY5sOeovIHvMBvuPkg8gp5t+Ji0=;
        b=fK/MrkyJ4HyMgdQr/d0OBXNw1Q38ovtLlVdZ/O5yG5auqxOLpH0vccFGeOSS8+Omkt
         UPdnmxw9dIVGIFHnBUDDGtwVVnhSA32znj8C/R2qSaX0Rm1EhRXrX1bUM41O8yyKR8mB
         sg9KufZBF5T4f9A9BGGNF1NpBKCg8fB09QDMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yytFgI0IZthMjzs+JY5sOeovIHvMBvuPkg8gp5t+Ji0=;
        b=FWqdQOe9s+5IXr/ddJwjsa9CqEmgulAi7yjINf5g0JSig3vVRLAEBl4BiqAkv+xwCx
         N7VaOXwMyxoPfAHGTj0C/RvUxJDQ+5hz+f9PDKa7ENap2betC6B75iaPhsmg27i6QcfT
         umz4xb40CwdfZh2G9mE56VuTSaH78vTjvyxRcxMAmRSF+2HGTXwI+bN/ohBbz7wlbQyy
         uOB6xMOVMmLPBXAnUfVRqkP+c0FOqZewkAnNQAVgsd/dXsWmrLhr079KZEyL+zvTAfPS
         HRcvMt8OBK+sXp769OJankUTmIdLm/y5Zy/fQQqWsOD2+A1VZYIy8AR9vLWmeHfcS/bc
         BKag==
X-Gm-Message-State: AOAM533LwXCVR8ZdLH+h7R/+SR16uNKZisd7IzazUNdmbykJex6dfpvo
        WuJuzD9esoyBP3yVeXHReYF24Q==
X-Google-Smtp-Source: ABdhPJwX7JIAJzgS9SzyKpCVWzzwuFZF779Xd4X64mJNbKKQm0GCR5+P3vs4xSF8XqRieR1ZHDRH9Q==
X-Received: by 2002:a6b:8d8a:: with SMTP id p132mr3755314iod.81.1628897086117;
        Fri, 13 Aug 2021 16:24:46 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id m5sm1593920ila.10.2021.08.13.16.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 16:24:45 -0700 (PDT)
Subject: Re: [PATCH 5.4 00/27] 5.4.141-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210813150523.364549385@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <b433590c-4783-f75f-3a1e-94924cea6b16@linuxfoundation.org>
Date:   Fri, 13 Aug 2021 17:24:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210813150523.364549385@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/21 9:06 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.141 release.
> There are 27 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 15 Aug 2021 15:05:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.141-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
>

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
