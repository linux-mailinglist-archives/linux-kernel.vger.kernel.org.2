Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94431417D4C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 23:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343743AbhIXVyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 17:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343675AbhIXVyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 17:54:45 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9382C061613
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 14:53:11 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id y197so14433626iof.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 14:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j3aWjaIPFonu8drIIteSMoX3XKDl/3kctB7jZVViw9E=;
        b=YNvqXOFCWGuz/iLbjCk/707ApbmVvOmJrdRSl5El0t6mUAdJkDs5raaNvQGh9wpSbk
         oaQNzMmLmZLiV9zmyCzlt+D4/hT9poN2+7SuXxyVtm/aIgll7//qolaIkMeT7+QHpv0g
         UgiTXkr9TfCL/RXQURmD5X/jhJfwytj6Wlfnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j3aWjaIPFonu8drIIteSMoX3XKDl/3kctB7jZVViw9E=;
        b=xxzsE29jmq6ehmFBPLY+7Lz5Iz4Aday0owqIM5A5mudPfUdde5je3EMvKkM2BcvueQ
         mh4kLF1FuRCnbUqrqlyN8feuiRkUhQoFkYDLFZAc46aEfoEMARixnigt5QE+7d13jX2O
         rf04Qyo6yUjHighr8mT8vCGpkC7vApJ8Bzk6NOGIpEA9omfk+a2O0WdCo+qaeQ4F89X8
         u5f8+ck664oUiofBQoi2ZepjDBSmCmqwSvSIOTXOhCIfIUnjCHojnb5n0HkMPysbx8Bw
         k2PHAj2rwFxKl4wa3ipRrtXfj9n7RIXMVxSje/Q5RTVN13Atk/WmEjsLd4FboWpRHR9S
         XWAQ==
X-Gm-Message-State: AOAM531gfWpTYiChwqwSKl92pddlmkeIovFRlz+EtrXlkeiMyoQdlEth
        9JauOCwuKZ1gdiu0zrKIWdFS4g==
X-Google-Smtp-Source: ABdhPJy8wpIq3czR3fhaDw667P00I7yb/Vh/uTA1McFUzgqpew3vsVwvPakZuHGn5fmFXI4f/c8EHQ==
X-Received: by 2002:a6b:5d19:: with SMTP id r25mr10929688iob.11.1632520391376;
        Fri, 24 Sep 2021 14:53:11 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o11sm4629729ilq.12.2021.09.24.14.53.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 14:53:11 -0700 (PDT)
Subject: Re: [PATCH 5.4 00/50] 5.4.149-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210924124332.229289734@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <0e3b468b-4810-bf3f-9af7-1863fb42e6ae@linuxfoundation.org>
Date:   Fri, 24 Sep 2021 15:53:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210924124332.229289734@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/21 6:43 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.149 release.
> There are 50 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 26 Sep 2021 12:43:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.149-rc1.gz
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

