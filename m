Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB74243B831
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 19:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237813AbhJZReH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 13:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbhJZRdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 13:33:51 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9F4C061348
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 10:31:27 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id l7so33471iln.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 10:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LDEJDKLvwHDItOMunXyLHz+P+5cXsosFxrbxb74ZMLI=;
        b=RSOVR55vPMX+8xX0b6bWnCO9BdeYQDButlg1o8kXKtMn39Kc2ddjkY5N+F8Pnm+Ktm
         iY35TCR/p1WNOd6CshX0EMB6r5PEje0luDwmK6VV4a5dWcQva9V462OZZBd0B2uAvPxH
         PRR6Yeo7fs2q5ouVwjBOBgZzsfM1W6dfKlk1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LDEJDKLvwHDItOMunXyLHz+P+5cXsosFxrbxb74ZMLI=;
        b=XLS0wDOygMBO8qMMLwl2Ixsvc0U9Orc48ZtuBti3XNOm5B/1djIVEaz+fn4hUxJ8uN
         ie4FhSqMsKPsaXeiaWnqaXJ7spwiPKWEiSvc2q6iMIdZBirbzgjs5n0id7KKShtX63cC
         D+R4pFhqVgeMu7kmMK5NvFCtUYQXCTiyNUw7pgjvPDnSAnpPjf51kIJ3aOe4lu3iGLwu
         Vp9e2ygoD9HDnRVSKr3EVf95gxDVuqg48nSUJ1TWRj+pzOnlSHGLCw3ySljPX5XPlzWS
         J8vy81gBk7VSw20lRK0uEINsKJ7ADi5JGbnVqpD2pV8/ONRSG2LU0J2kcTMgnxrNq+ZB
         EAoA==
X-Gm-Message-State: AOAM5305EwMfgIZ1+qgITOR2VIbN49UEc3/05yHW03rkBaMvPgS/EiBA
        nSmnzK9lTL+uxrmXToC7Dnx4ag==
X-Google-Smtp-Source: ABdhPJx+ZbzTje2Lk+q/f1XfJlRFHshEQShihGEstV0dQ92fNBO1s+rkGTMy+EUParF3/3Do+P7b+w==
X-Received: by 2002:a92:d706:: with SMTP id m6mr14712252iln.155.1635269486913;
        Tue, 26 Oct 2021 10:31:26 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c3sm10947236ili.33.2021.10.26.10.31.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 10:31:26 -0700 (PDT)
Subject: Re: [PATCH 4.4 00/44] 4.4.290-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211025190928.054676643@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <4ff70939-7126-88ca-e55e-bc744c5b4ad6@linuxfoundation.org>
Date:   Tue, 26 Oct 2021 11:31:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211025190928.054676643@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/21 1:13 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.290 release.
> There are 44 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 27 Oct 2021 19:07:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.290-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

Upgrading to Ubuntu 21.10 caused issues with the boot related to
zstd compression which is the default initramfs.conf for 21.10

If others run into this:

Changing the default to lz4 is the answer for 4.4

thanks,
-- Shuah

