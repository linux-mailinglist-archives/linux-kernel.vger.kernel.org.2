Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8271B3C2AF2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 23:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhGIVob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 17:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhGIVoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 17:44:30 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577EEC0613E5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 14:41:46 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so10922451oti.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 14:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g2ljriZeQQuR5yX1d1BB9+mNoBpcvvJiTSBUERRIqeg=;
        b=bM2HHhUP42rJDK9WevBz9ZsTs8feejTk4TBJtnSjoIb0MbBUbXcSGbZt0Umt0wc7VB
         84VKBUf3EXwmfncw4wx9db+vH9BL9mJJT5xlYVqlUbIxg18+nAFt9uNkyHcU50HH2Aww
         FPWAZw3HoDtYmOlcMBeLyYo6fxgmvgfc1CEYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g2ljriZeQQuR5yX1d1BB9+mNoBpcvvJiTSBUERRIqeg=;
        b=IcyHoKYyC6NB1kvBx6klIAgZ9iCbByea+tXu9Ekdgc2zHiCNxTsjkBCYsy4NY2CDOh
         HKCbUNe8CDAgHwPFCob4vlY8uyo5F8HmEkl73/+5qJ5RfWyFvT2fB8h3ifJZg5dU2Qay
         1znwv6dRLqeMZgnXOgdp7Xd8tjuLJoovHy8RY028v7tn5YWeAKR/J/0vecx0mBrrMzJB
         TwIQqrvPW+AW1uZq5t/pKZTJlPIj3cv3tjvWKmDfDVy7uprispddigUiO+5VWl2Y97CC
         Gbf+uhBufWGqnniWULay7IGLVQsJ0VUO02GjLv0bMpOOhVmYlfMlJ7qMxssMOOpD8pKu
         0Ypg==
X-Gm-Message-State: AOAM533BDIEHB8OTncD+82dy5pqpTbEHNSO4JxHnCF5dCdUX1YQ9Vn9s
        72E6aKw5A6XtZySFT5/U1NUaMg==
X-Google-Smtp-Source: ABdhPJwJL/BuEk82bjYYfJIqlBbCGLJuiCefV1mqwYMjL0ZaEfYsq5QNe4P7Si6tM+8LzIa6sWbhmQ==
X-Received: by 2002:a9d:24e8:: with SMTP id z95mr24365475ota.326.1625866905630;
        Fri, 09 Jul 2021 14:41:45 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x23sm391638oto.20.2021.07.09.14.41.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 14:41:45 -0700 (PDT)
Subject: Re: [PATCH 5.4 0/4] 5.4.131-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210709131531.277334979@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <83f32de9-a856-d6ef-e595-259ad20caa10@linuxfoundation.org>
Date:   Fri, 9 Jul 2021 15:41:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210709131531.277334979@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/21 7:20 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.131 release.
> There are 4 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 11 Jul 2021 13:14:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.131-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

