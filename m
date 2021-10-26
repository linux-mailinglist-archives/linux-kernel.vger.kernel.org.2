Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2785743A984
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 02:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235965AbhJZBBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 21:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235947AbhJZBB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 21:01:29 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC41C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 17:59:06 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id w10so15054908ilc.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 17:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r/93flgoPAibw9TrMBsmA1tH1WmHaddSeHXSGb4pbC0=;
        b=MPca3Iusd4ca1zyXvvyCIip9B0/gtVGELbrq5P22f82Yj+sY3YMyqKIICOB3sZYe4X
         dsZXLF3SYA7m/EVwxZ1KoyyCQJ1VujWJyk/hMmLJBi/dtHMP3dcRSaNqIrcyZq7BMAon
         xrBb8QcXPVrloAmEbJ7qcrG2f9q3NBab6r8ME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r/93flgoPAibw9TrMBsmA1tH1WmHaddSeHXSGb4pbC0=;
        b=ar2Qwmawql+qsix+7LCPVohUPlnQxKIHCIuddJrwvk21VBmT06dKX4cxn3jNsf3qyN
         BGyFCTiEcBl3KER/mhCPKuOZlyepKOkUCnYuB/uh+OHbIzWPsLTuPyWK7MT4ChYI/2pe
         WsUBjwUcf2/Q6TAhd0FlC00cUiTaXR2Mjrhdij7W3SKOn932rLGQd4lfuiRfePtUVqAi
         RG8BZWkJWoNBhBq0RsSMznA930TO3Bdfx3tTecfCTQtHq0r8SdjqB6IePl7cgjueoOPV
         qVNBxwT75u0sZLR7wQC394tMh6Sb6TVl6xL+e1ZLMglVdTDBV2htgyO34e12JvNOnrGP
         oXSQ==
X-Gm-Message-State: AOAM533JvCFZd9BoDBjBMbNVGMzpHd+z9/ckuzsOzqVkaysmD39E+0HV
        goGRBGiwmXobQNchIF2m2wU2ow==
X-Google-Smtp-Source: ABdhPJzWbEimFyCb5K4GLGi0lb3Ftal3/l/f8ycjvOSYnBUNyegjAS3krA62pdLh2f0SDKPuC2uebw==
X-Received: by 2002:a92:d801:: with SMTP id y1mr11065765ilm.159.1635209945906;
        Mon, 25 Oct 2021 17:59:05 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id e14sm9845649ioe.37.2021.10.25.17.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 17:59:05 -0700 (PDT)
Subject: Re: [PATCH 5.10 00/95] 5.10.76-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211025190956.374447057@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <b7e3fc5c-1cc3-6be9-0b84-82310e280d01@linuxfoundation.org>
Date:   Mon, 25 Oct 2021 18:59:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211025190956.374447057@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/21 1:13 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.76 release.
> There are 95 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 27 Oct 2021 19:07:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.76-rc1.gz
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
