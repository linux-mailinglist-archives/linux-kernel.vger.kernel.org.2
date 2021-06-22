Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB693B10DD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 01:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhFWABH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 20:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhFWABF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 20:01:05 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151AFC061760
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 16:58:36 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id s23so1311424oiw.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 16:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4/1De2wl86lhZjHuZl2xQQMDd0SZ6yG+b8j1vIHk6t8=;
        b=JMS0HICcE85Qgk+mrtCTa89oFPxDDq5IuSysmkvpP2+xmUiC87MObWeOSFuayZBi82
         sv6wdlCb65XwhvkwrFatvLONECOpahInVJcB7wk3uN5WlWaGMI4V6nDgTM52IAfI6y4/
         gbw50tp5XssTWe6eeKMSQpjs9xbbkwdth/zgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4/1De2wl86lhZjHuZl2xQQMDd0SZ6yG+b8j1vIHk6t8=;
        b=Q3fpafkwzmfQLd0ayQn0jR1D4TqM5ap4HMlr/pU4opcLKQBtuST0zLLdp1ghxnPPDy
         JtSi5FVjWyB18srrk28hO6HbDF9q8Id+NZjDMwLOaF3clXCj9acIn+KKQQOBz+qcJcry
         nrYaY5ASGNLc7XfLtuUkOzkxeuCC7CRG9a7iFH//K0l4R15/72EuCx84OLJXWWhbHrQ0
         A0RC/XqlSUeHlsc9wSZLG9H+KrqDd+DvdaSpoUvgdQeir7qiGG/Klvx3k5mqlZcF818p
         A1QJ4XtrbeF21r9kRBbgFCkhAE4rm8cpB1CWozyX/eSgKKQ66GkjgMTlp6E0MgTHejBs
         hn6g==
X-Gm-Message-State: AOAM5334X5nVQiHVMCzIQ+yNGGf3h4Naquh1R1NLAQ7LTt62fkRoY8yV
        uf5+ZthKAwZVs0IHfXVjTUddfw==
X-Google-Smtp-Source: ABdhPJwQHwSnlPSLMhDGtrxXsjr4nMrCAcHe2/KT9YmbZt38CXSINqiJvuxUGjb1ODAQf/GulWMKfg==
X-Received: by 2002:aca:aa45:: with SMTP id t66mr1040075oie.103.1624406315507;
        Tue, 22 Jun 2021 16:58:35 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b20sm204956otq.41.2021.06.22.16.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 16:58:35 -0700 (PDT)
Subject: Re: [PATCH 5.10 000/146] 5.10.46-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210621154911.244649123@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <42816623-43f6-272a-88ab-b4b6f5e7db41@linuxfoundation.org>
Date:   Tue, 22 Jun 2021 17:58:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210621154911.244649123@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/21 10:13 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.46 release.
> There are 146 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 23 Jun 2021 15:48:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.46-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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

