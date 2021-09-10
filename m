Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B954073C9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 01:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbhIJXTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 19:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234772AbhIJXTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 19:19:25 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32755C061756
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 16:18:14 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id q14so3704390ils.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 16:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aRF9+qqshJRxoOURWf31CuywRUzKYx5uCq4SEWQFgIo=;
        b=IjqDVZqKhz+Ga16X+exSzq/XrMT1TR8joSyyQOpH8vTefVG8Ftk8HwwXuGjFplTinJ
         0i63fXXTxEqSrhMsUcj4OvZ/iVr79gwXBgkwJ0C9xLIA5yPTLBb7Ds8P0LUBhpW9rzpm
         nA/DLKtIieMlPJzkxhBqaXrPBMI7fQvw5aNnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aRF9+qqshJRxoOURWf31CuywRUzKYx5uCq4SEWQFgIo=;
        b=kxrhxsBl6rJvVM2NFnywNWC6v0YC5JJJw/xKg7eO6Gfw8HWHGaawOVjCuO/1v92WFK
         PEZYRzA34z9soOAQpO5DfT8TcH7iYkYKPZMRoN1cFCccNBkKzoUDiGNnwZyXIjdDOwof
         4a+l3KVmMcXadrbS6PhPZHwktyJggcOPcax+j8RAZT6tGdLRCGq4xP6KmwpAw4yCp1GP
         fct7XG3Shd2o/jJ9UI1UNkWTGadfare9Z4zhNFAeL0P6vKLnfiA7v9yBaKVY3gJRuvhx
         QRHf9WRdLe6cqQxcisHTl/PPQQE+HZAuA1xXWo88+IpDOCqsr2QOyQxAC0/0pWhzSuDF
         aY+w==
X-Gm-Message-State: AOAM5325oT7J7qygFhTv5qHQ3uJXLHhhtq4YVMFC+6l4WEE7lvtmp++L
        fh/gyVIyEev9bCU/vwrydhEl4g==
X-Google-Smtp-Source: ABdhPJybZtjx+H/33334R3fvWSjVwDB36A9pLlTDIwW7eWbzbPki2d7l+2CBqIkbXJFM2tgtbFZhDA==
X-Received: by 2002:a05:6e02:1546:: with SMTP id j6mr89056ilu.154.1631315893570;
        Fri, 10 Sep 2021 16:18:13 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y11sm32031ilh.5.2021.09.10.16.18.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 16:18:13 -0700 (PDT)
Subject: Re: [PATCH 5.4 00/37] 5.4.145-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210910122917.149278545@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5b29ca0d-7f5a-e0bb-2dfd-fa5b09316a65@linuxfoundation.org>
Date:   Fri, 10 Sep 2021 17:18:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210910122917.149278545@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/21 6:30 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.145 release.
> There are 37 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 12 Sep 2021 12:29:07 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.145-rc1.gz
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
