Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D36329FCD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574614AbhCBDsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243498AbhCAV0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 16:26:35 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98AAC0617AA
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 13:23:14 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id g9so16085947ilc.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 13:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TIqmUV2OyRVCYYPSnJbYDSlxwUiLg/Pd3YdADLVGsgo=;
        b=Q+ke+df4KJ0IBHdBlwNOdA3ODfjjykQcvG7qyKV9FX5wY7EzFbRcA5Iisf69ZkIkWa
         Is2p03mIrfqfTjw/h2CLCTJS1t6HQ8uOfYUYq4fEEw/9gefs99tg+Uj1JtpixloWSJaP
         HwAFPQUhfCxJOSqoh4sq3l4phVJuyXh+oBoII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TIqmUV2OyRVCYYPSnJbYDSlxwUiLg/Pd3YdADLVGsgo=;
        b=iqSq6BU/xUqhCX/vOPOdf0IhW0xk1NQi+FhLQrCc1ebkZGg3ZN5vsIYM7cEHJNMbjf
         q/3+IJwsy5oWesWng2whUcUVxxUt9gyU+DL/ad4zcfx2jYxzyqt5nEuNb2XENYDjTQAm
         QXeWLlYC0b8OYt+Q91woSZKqBOApM84+HmYQNZ/VTfno2PYPDOutVoUAHiiWAmpLkphn
         +YMaPC874Uj1D3AMcjgJLlqWi5YRstJhOeOwxbVYWut5GR8UPRd6OiuIZZa7rUix91BA
         IWjb01oEoDh9dV+1PaXOEfbBRfZz/zNtEVBDvsKVXkgMmqJEECQ3j1pqc13Bnu0rB3M5
         bMug==
X-Gm-Message-State: AOAM531eij7R+kYBcmXVxLXH7+/Sjr+ZGIZwCbcNqbmedPulwfUq3fkM
        BdWPHA9rCvHwovE7bh3pBsqDng==
X-Google-Smtp-Source: ABdhPJydxxF/ArluhQhW5ASu+/8zLIxaWebi/nXL8lkWWpkLVPien2rSJjf1EQz6TsjkE+l3qtS6sg==
X-Received: by 2002:a92:290e:: with SMTP id l14mr14745189ilg.36.1614633794277;
        Mon, 01 Mar 2021 13:23:14 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id m1sm10621332ioo.39.2021.03.01.13.23.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Mar 2021 13:23:13 -0800 (PST)
Subject: Re: [PATCH 5.11 000/774] 5.11.3-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210301193729.179652916@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <664d3da1-9961-1a02-3f22-3f01fc7948b3@linuxfoundation.org>
Date:   Mon, 1 Mar 2021 14:23:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210301193729.179652916@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/21 12:38 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.11.3 release.
> There are 774 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 03 Mar 2021 19:35:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.11.3-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.11.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

thanks,
-- Shuah
