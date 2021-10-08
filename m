Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAEF42729A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 22:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243311AbhJHUv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 16:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243042AbhJHUvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 16:51:24 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708FEC061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 13:49:28 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id x1so8162313iof.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 13:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DLCZUJaL7PUb/C1Qr4B260Q3TVmtChewZiyhSNL10CM=;
        b=Rvg/Esd4eveDZrPwipW31jHHBm4DUxbRyoefKLUnNTAKBPH6jpmVK87cSVbBiyGXw9
         wWmipcEQQvVZW0EKiQMPeTVSaC6ypOILbvyzYQoeSvwQPla6TdFfOv6mhpjvxqNYT45o
         MSQqMqn2f9Xcaqx06pSPCym1fsanzUZ4hkyBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DLCZUJaL7PUb/C1Qr4B260Q3TVmtChewZiyhSNL10CM=;
        b=RnaC8hO64XTsRJ7oVkldGNq5lhzfm26biaegz5YhxeLO4uACOioW8M1KdrdINIxBxk
         xNhvBDk3Zo/x/ZzPOmvur7vT8DoC1ebAYWbmjLg+oH6mdg2tvoDPgJIH97ISuNWnYznD
         xvqw/mQZp8p9K4z+ZMzxYl6X3xQ0hOnlXH7+RXDrIfNyq/2GdT+qDJ93JlFQ4ElSpQMf
         Ty+U7Wzinovf+EecZkYrsBRxdSwu5X1OniE2j7aXgt1zCxJAJXgQgkG0Z9jEJMJwq48z
         rXn4YSJA1OnKeJKCR7Zc7qpHrI6Bfp9KikJvYMR2vptyNXAeBhxSc09kiXlDQ5lT9X+D
         svyQ==
X-Gm-Message-State: AOAM5306SOwXL0q/fhWWkR7/qL76Y41YyBCAT8mPLpTLRVqS8FWWyQ5R
        jDkzewJKtGCQI3L2kco5FtTsow==
X-Google-Smtp-Source: ABdhPJweHflNx3w4biWW94W0KStyisvFB50PPCuxpPOPo33kDaGmyITMW0/GmC9w0DH+QgzDZXCAWQ==
X-Received: by 2002:a5d:9145:: with SMTP id y5mr9206933ioq.200.1633726167865;
        Fri, 08 Oct 2021 13:49:27 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n3sm158082iob.32.2021.10.08.13.49.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 13:49:27 -0700 (PDT)
Subject: Re: [PATCH 4.4 0/7] 4.4.288-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211008112713.515980393@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f447bc87-0ec8-8798-b6ec-0c194c13ce07@linuxfoundation.org>
Date:   Fri, 8 Oct 2021 14:49:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211008112713.515980393@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/21 5:27 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.288 release.
> There are 7 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 10 Oct 2021 11:27:07 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.288-rc1.gz
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

thanks,
-- Shuah
