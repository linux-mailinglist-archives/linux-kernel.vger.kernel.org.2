Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1F543B81F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 19:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237776AbhJZR1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 13:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237767AbhJZR1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 13:27:47 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629DCC061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 10:25:23 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id 3so18983ilq.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 10:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YAY7NqnNxo2ZTH54u5aRi5aIrhzg6YLPBc/3pUJfTzs=;
        b=FE9vGRfNOn2xFNG9hZSjkWcE8MuymZ3CFS6RLfX0ppkyg73tvTZsWeqv1QAsDSCOSX
         RgpMSj+P0QxErCQx0NVseaxCAhL/cTrHQP4njPs742NO9qjcX/zo/QphdF0t9Vy+r8l3
         +zeeTavq9ZuixzoShd+rlZ7XJpFSQhlMTZGyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YAY7NqnNxo2ZTH54u5aRi5aIrhzg6YLPBc/3pUJfTzs=;
        b=lbXON9LcPap6/3QtpX004H3TvPgPQ3olWj7Ki9fQ7c9se1uZe4487thRw7gPZZS8aR
         klf06DpDnqpHwAyZKpQBDkHlhA1YuF41/XU8Tt3kgW/OkpHsYdGWgpHIr0wlWK/UjdOr
         /YL47IvzBwvV/1Y2OgCBoAIA9aCE9hWOgscoI5ZkBH7uHpsvE/Afprsmzw2sOOU0Yrgq
         GTJFrHh7NES1C+2g+gBj6DQJBP5GHaZ/DkGl1o9r1+wAs334z3OVVLPUDXLAQ42vRzf8
         EVQp3BckjYEGwXvhBYLSThwc4aZHtpm/iHpY445tCDetTNP0oHhP8/1kYkhMAJVjrhKw
         l6LQ==
X-Gm-Message-State: AOAM530LiGVhRoOCdaLGkCiR6gM6cTI7Q3V7hCp+3GrRonutz/v8QbKj
        CdasDw69vSnvykMMhSB6jCfXNQ==
X-Google-Smtp-Source: ABdhPJwJ/5vCsOWaxQjxb4Zdp3/9OBQqgIshFQ9L92eXiJcE5WTYeE6YeBy1RGsaZjifYttOmr5xXw==
X-Received: by 2002:a05:6e02:1c26:: with SMTP id m6mr15385937ilh.229.1635269122840;
        Tue, 26 Oct 2021 10:25:22 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id m5sm10714751ild.45.2021.10.26.10.25.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 10:25:22 -0700 (PDT)
Subject: Re: [PATCH 5.14 000/169] 5.14.15-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211025191017.756020307@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <46e778e2-0f9a-576f-9f4a-8964b8b9ca50@linuxfoundation.org>
Date:   Tue, 26 Oct 2021 11:25:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211025191017.756020307@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/21 1:13 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.14.15 release.
> There are 169 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 27 Oct 2021 19:08:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.14.15-rc1.gz
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

Upgrading to Ubuntu 21.10 caused issues with the boot related to
zstd compression which is the default initramfs.conf for 21.10

If others run into this:

Change the default to lz4. I ended up enabling
CONFIG_DECOMPRESS_ZSTD=y for 5.4 since it has support for ZSTD

On another note CONFIG_ZSTD_DECOMPRESS and CONFIG_DECOMPRESS_ZSTD
naming rather confusing.

thanks,
-- Shuah
