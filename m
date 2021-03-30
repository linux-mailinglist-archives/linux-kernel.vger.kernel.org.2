Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88FCC34DD6F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 03:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhC3B0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 21:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhC3BZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 21:25:52 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7ADAC061764
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 18:25:46 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id 19so12849319ilj.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 18:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GkIjNDQSnVX2oXTUlrAlT+4P6pRDsPQgKbnz0z7FXoY=;
        b=OzG8y73xy1Ccrs0BA9Ve63fo6sqraBJh4L0X6hPl7pUnG28esdc2mfJCgboyzcg1jn
         F3qA+zRG4T21ag3ESSMpS9jtLHil28tlx6CN31LPraJU6mg/bQm1fvn05PkjsxC7lArz
         D+RdGGzKE4etBdOJez99FFYJikaGKL1a8zcBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GkIjNDQSnVX2oXTUlrAlT+4P6pRDsPQgKbnz0z7FXoY=;
        b=IqcFTFbXLPfK/BD9oKw6HjzTvDntTmiLKQZsjAN6CiaOqBwApn90LWQ2RiQ1hlS7D4
         8umY1F8hvZSSILV8kjfysLo1+rapN8HKpHN25jUT1g/bKu7oKO4l1g2sdaifGajRb1Nb
         n2VTUsUOy6BeWi7cZy3HoL/WNC13zI+pUVALLFncIH8y82cP5n6RJWr4TQbT5RnW9iRH
         wcpShWAq2JRk+wHX8DsISWXaT5ZXRA0qsXX+KZkGFanpvM3sgrOaxS4BvqrhhqOeNp4d
         fgE+kC/e1U0Vvq8nmajv4GPHPKVNfT6YXhE6WF4Im+De5+67kMsWcKu6V4M26v2x2HJe
         DnOg==
X-Gm-Message-State: AOAM530WxKIf2nsC38vNGohir1s+7hrufBwnMUXNTtasmGz6gOS6Mz/c
        Qj+GJaPTb6RBvYQPooW6g61dPw==
X-Google-Smtp-Source: ABdhPJwRtZgxKWec0GDzxXrZYxwzhbuLEo7wNv2MoDiC9H8mpAhcI/MqUDdnVnMLl9QatqmRZQQgGQ==
X-Received: by 2002:a92:dc83:: with SMTP id c3mr24122962iln.167.1617067545853;
        Mon, 29 Mar 2021 18:25:45 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id q8sm10253199ilv.55.2021.03.29.18.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 18:25:45 -0700 (PDT)
Subject: Re: [PATCH 5.11 000/252] 5.11.11-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210329101343.082590961@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <06aeb8ee-135f-620c-05e2-d00899fe6dcc@linuxfoundation.org>
Date:   Mon, 29 Mar 2021 19:25:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210329101343.082590961@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/21 4:14 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.11.11 release.
> There are 252 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 31 Mar 2021 10:13:07 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.11.11-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.11.y
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
