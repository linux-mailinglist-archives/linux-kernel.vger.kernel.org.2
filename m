Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E1A42E450
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 00:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbhJNWlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 18:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbhJNWlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 18:41:19 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAB6C061753
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 15:39:14 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id h196so5648707iof.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 15:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZLcUEf3FJ4EcdjOEZ269qg1+3MF5x+kzGi+tnY9ucNQ=;
        b=F9D3U7eYZ5ovOBvd3wWy9U4Ybx3IbTScSwLOrqxbkkbpm6Wr/rrPCBg8DJ4ZvoGJYz
         NQzH8Jb2/uLCchL2mJF7PSJsrqWY9IEFOkhEJpTz1DjAvJfbgzNAhbgGL7PVaELy4TWJ
         mjcrxmLplOKqkOKmUxAsBllQrTJULXDnQaOGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZLcUEf3FJ4EcdjOEZ269qg1+3MF5x+kzGi+tnY9ucNQ=;
        b=bJOosS0Y1xzWGipOofDXGiq1xG2X3ork+Cp+XKrR8MIl+UNNQzzMvjzzcGEmBpSnUt
         QigjaWi5nMugxbzlZXyIAYWtAmqJrbdaC/QVmp+Z1B1HHMz9o6EYVn0vCGaQVpUgQUO6
         Xhci5m+ak27cUGPg3Uga5DPOiABlbjo7CI3j4xrxxn4Nj1IspxRQcKRSaB4zUP7I8/Hc
         +WVtszl64rc1tVH4EuVSXb/oMzds/ZTee1zWmbBGELVtcLBaU3E3rhRGDR+ppV4fMQOg
         Q668psCCyzWcpMfY6aIa9vlzeXVyRNJp2PkUYFCOUCOA7uz0ME9T088AlGd1cxI+1wFu
         BVuw==
X-Gm-Message-State: AOAM530EJNL4M+8EGY+336vgT38jpb5jQ6dwntyu292cy3/e5tBe72IM
        NoSoUOH3Z6ubzP5dum2xeHobcg==
X-Google-Smtp-Source: ABdhPJxiTSkAvQxEOIVK3hG4YoZUmL+9mReDJ4BEWaLTlzv1j/3UF9jlNL6QWwnrhOhjV62QzIgGcw==
X-Received: by 2002:a02:858c:: with SMTP id d12mr6104814jai.110.1634251153400;
        Thu, 14 Oct 2021 15:39:13 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y5sm1791255ilg.58.2021.10.14.15.39.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 15:39:13 -0700 (PDT)
Subject: Re: [PATCH 5.4 00/16] 5.4.154-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211014145207.314256898@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e51b76f9-2c02-d9ba-f8e5-d278e98e97c6@linuxfoundation.org>
Date:   Thu, 14 Oct 2021 16:39:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211014145207.314256898@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/21 8:54 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.154 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 16 Oct 2021 14:51:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.154-rc1.gz
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
