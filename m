Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09877422FDB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 20:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbhJESXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 14:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234916AbhJESXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 14:23:32 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7C8C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 11:21:41 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id z184so47243iof.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 11:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YwnC8hpn+FIOkts5Uv8OyhoB4r22VJdfWW6CyG0jPeA=;
        b=BnEY81RueuL6B69bIDQ3xWUys2wx3nEKyoAvNxeHfgoXy7MszdX7mFoTBnGqg7nArI
         q/BTYo7U2l453aFsJE2JFTgCOAspmqAXj3vlVYd6W6thYP5hePGv+eNnmC2aQETAJdcB
         aIPRQ1G0SgqiklWQyJnNw/19BLzEfOF/jMuvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YwnC8hpn+FIOkts5Uv8OyhoB4r22VJdfWW6CyG0jPeA=;
        b=pZBe5l6Yl+HKWpI0ltuIB2eWbCwUwZl88XrNOVt89lVLKinrFycvngdMBeNBBSgVvl
         Cp8bPWn/K1qQ6jmeYAN58E/xfY7ErIEG8y/Inkk7uChuBNd05VSRl1+4usBB06f3uOrd
         n1sJBaY59/ttcXIe3p3JaTKd5tgTpgwJUWvJ8qqNPaH1XSdonuPwelGBAde43Dlie6PK
         deizqleLmGpFhiGYjeugiE8lzHX5RouIRFjAUl2YSZg6d+0IFIOvVIdUDWMCfYlNye6N
         8PT1YX+qeqVpsX1gHQLChG2EPiUuMa3RpUQDMT75qw6yZSjKlh0sHjYd6q3pl2gkmVpj
         T/Ww==
X-Gm-Message-State: AOAM530Gf7LhhWu90Y4In8GI2sbSSHxzGm4O97s++fnISUFKnVe7u1M9
        yblqo6N2rXYE01CGgAcs712YBg==
X-Google-Smtp-Source: ABdhPJyKZ/xZjExSgGSFijfsmiVl0qSFtdtmiCWGmseIr6KTEHF7GSZZFpw6Q/YP1Boo9TbvNShErQ==
X-Received: by 2002:a6b:f111:: with SMTP id e17mr3301290iog.147.1633458100842;
        Tue, 05 Oct 2021 11:21:40 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o11sm13097722ilu.0.2021.10.05.11.21.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 11:21:40 -0700 (PDT)
Subject: Re: [PATCH 5.14 000/173] 5.14.10-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211005083311.830861640@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <41227f84-832d-1939-f4c7-8d19c6e764a9@linuxfoundation.org>
Date:   Tue, 5 Oct 2021 12:21:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211005083311.830861640@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/21 2:38 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.14.10 release.
> There are 173 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Oct 2021 08:32:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.14.10-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.14.y
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
