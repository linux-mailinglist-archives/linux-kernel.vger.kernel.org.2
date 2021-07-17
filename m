Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E113CBFF7
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 02:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbhGQAJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 20:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhGQAJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 20:09:13 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F539C061760
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 17:06:16 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id z17so5980688iog.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 17:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NBMqm9QbgY8pXr43Ar0+BX9+G1u/HV8S3ltMcAtx8kU=;
        b=Yx8gH1TC8ab7+WtnYQr1YUiMmbNltVYS+hGLaRZLV/Ft/0YQgoDiPbQTaBx4PxWFFM
         spEto2zKosQevQO2QD2CmOn8bZ0WhC4tehQUWVQ+kZpLzuATthjzNvd7p6JC6OwMIKNX
         m9CHbz7d+HD9id0MvqsD5PJZnCGR6Zlncak+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NBMqm9QbgY8pXr43Ar0+BX9+G1u/HV8S3ltMcAtx8kU=;
        b=imMtss8nGK7mPbatZ8LYTqvtppI34QLB4k8GnC7YKZppEbWYxZjHdDc4AUfvYP1nfg
         +KAjewakpYb4wOMKI4dRThNYdG96ohFl+QOCeEAf9nMhDU/5oZc81FI00H09ZMNX8Pns
         KgANbpUhu85Gpee4IaBSFI7g8rPWrs/2H1hVEAAkX5+i2xeKRxfwC2/+pGAloXrdQReE
         tR6LnGs1qD4QaWzy5qG4aILYmGpuFsRZjGF5VW0EVjfhzz4+N2CuRnx37V5SYdqKCN2w
         m6G2fegm/4dE3vZtIk9CNbLQTXj4C+jv/2/gS8dANmqDfcSZBHs/Ih0A4qajJqw5zLIA
         kLbA==
X-Gm-Message-State: AOAM533tgKN4CWUmrfdgW4HzijI0I61tEVyIH4uy8yGXeX4ZDn5Jh/4h
        h+3UY5UxgCqyiA902vlib62Wpw==
X-Google-Smtp-Source: ABdhPJwrPd85TTx0d5mLdbGd69KRJHwRqgQw4ejggbAGySxLdWlui281ODJm4kk8NyKpGXKhcK6ybw==
X-Received: by 2002:a5d:914a:: with SMTP id y10mr9467052ioq.140.1626480375996;
        Fri, 16 Jul 2021 17:06:15 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h13sm4994982ila.44.2021.07.16.17.06.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 17:06:15 -0700 (PDT)
Subject: Re: [PATCH 5.13 000/258] 5.13.3-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210716182150.239646976@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <dc5724fb-151d-429f-8a6e-0caba4ee8fb2@linuxfoundation.org>
Date:   Fri, 16 Jul 2021 18:06:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210716182150.239646976@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/21 12:29 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.13.3 release.
> There are 258 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 18 Jul 2021 18:16:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.13.3-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.13.y
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

