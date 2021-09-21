Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1326B413642
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 17:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbhIUPfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 11:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233985AbhIUPfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 11:35:07 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12686C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 08:33:39 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id w1so23174874ilv.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 08:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0eLDsx/2EJ0VqfuLJsx8Q8VpSkY12tGf7fLHU46IIl8=;
        b=LCAZgmA6ucLnOgNr+PG9SUiiAk4rZKpHYi80CUyacnD9o4MpH/oQsiMBwebe3XV4Sm
         MLAEf8o1/0Kd5QQKlJU6Cpt93i4TmOqSJPfehjNwnYnvVw8Z70c+TGFCMuLr8PJDQeJ1
         Y+O1S6fRNWxOENrgRNCrknnMXY7rPsfjAwUFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0eLDsx/2EJ0VqfuLJsx8Q8VpSkY12tGf7fLHU46IIl8=;
        b=Fp6nN4cKs3vHcTsS+OgsEXnDs2SHC5jMGODDzprpd+1XOwBqFbck5r7h2wY+8IokNH
         OdnIiQKJa3z/Q/YN6DoqkktciqcfcFIqCBwBFmSAi1+pGpBSb80SwcVuz+kZS+iJfn3Y
         GJEfHUmFUVAXZcCEbOsZtE3StmcBC53HSVu6844WdFTMuRT9M//IcWraujb5Int98gq5
         CLSPkKv2k3Ezb1iwidrMbYpWSjkMXDD6PcacQirqlB7yX+6GsB2IHkNFCq+50d0gVVkr
         +7gxnJN5h05lLybxPcsVsebYpMrW0w2eC3bzAHAFapjdT3MNNN8+n2LXXHbPY6A2qier
         GOhQ==
X-Gm-Message-State: AOAM533RN75qNWGXDZ+0agnChSmViKeE9ZoaFL7z96UaePb8vW+GMT/S
        ASypLwgdCcefku7bGCPp9bJUmvDJogGsQg==
X-Google-Smtp-Source: ABdhPJzlSwOJhzRc9k4KQ3XpLE/uHYd9e913K/4rSk6hWC8zd9yyQNH3z39flpA8S5XExCXZGmz9MA==
X-Received: by 2002:a05:6e02:20ed:: with SMTP id q13mr7613678ilv.111.1632238418485;
        Tue, 21 Sep 2021 08:33:38 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v6sm1643442iox.11.2021.09.21.08.33.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 08:33:38 -0700 (PDT)
Subject: Re: [PATCH 5.4 000/260] 5.4.148-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210920163931.123590023@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <30e198a5-dcd4-05e3-b0ef-8ebefc51842c@linuxfoundation.org>
Date:   Tue, 21 Sep 2021 09:33:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210920163931.123590023@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/21 10:40 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.148 release.
> There are 260 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 22 Sep 2021 16:38:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.148-rc1.gz
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
