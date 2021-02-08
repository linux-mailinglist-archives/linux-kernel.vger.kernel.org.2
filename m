Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E03A3141D9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236852AbhBHVc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 16:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbhBHUnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 15:43:07 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17203C061794
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 12:42:17 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id d6so14060451ilo.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 12:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m7vtTCXdXqh6ZHH+ncswdOb51TKlysL+Mp4Q3A8vt/E=;
        b=ABm5X9ElYgwBzw8og3ddP1QOOAZ1loe68YcB5gtjf4pNnyWUKStMqg3LmafPvBgREj
         3rnoQ/GBt+0P6EzrT8c8Cl3BDUeIuPQCICUoPpCBmsm1ialq+9slZ6w2LJMrz4F87JA/
         EbOkqBTZDgLtSiZMYpLZ6MyYuR2I8nGqilbhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m7vtTCXdXqh6ZHH+ncswdOb51TKlysL+Mp4Q3A8vt/E=;
        b=LbjYmNJY8OcZlsDYyJGqJ+0Z+4YeB+hCm7DLyxuFn/HjlHipETJnFG6toecNlv2bAw
         kx67xhkR3WefLc3Q3VsatNtS1WZ8H7F+PE/jvYOcYd/d6FvmUUqRfGLkdjj8q9nN5Y2O
         YxekPTarFElMOb3Hey5IQTX5nNx/+2mLoEcvVsIo7yuB6OGAa82hClff4hZhr0tQDl2P
         9r35LOHUbO0ULnjZ9QJbBTI4dXWrJRznqq/Se7PAF+OwPdzGG48K1WEseKXMve90d0lt
         Yab7HWA8IgQzI5N/3zi9kx4+d2JVH+3P8XVyQ1xtcAzO23aT503cyNxcUjTk7PX8zkhv
         dVaw==
X-Gm-Message-State: AOAM530guy04oSAQSNX57cMnNVEF1u/QqaItvg33/ZpiEPdbw5LaFJJ5
        QKZRkXxzDf0t0IvOdsh+0wA6Ow==
X-Google-Smtp-Source: ABdhPJzGrtIUQFNmvN+nAiGJnIDOd9jA++RT0DLa/0SFkfBdN7WbWqExmGBiFwWQFjjrbPRqvTPg9w==
X-Received: by 2002:a05:6e02:1a6d:: with SMTP id w13mr18888271ilv.181.1612816936502;
        Mon, 08 Feb 2021 12:42:16 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id w2sm9310933ioa.46.2021.02.08.12.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 12:42:15 -0800 (PST)
Subject: Re: [PATCH 5.4 00/65] 5.4.97-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20210208145810.230485165@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f4a29ebc-b388-26d7-554a-2d52115f4e72@linuxfoundation.org>
Date:   Mon, 8 Feb 2021 13:42:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210208145810.230485165@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/21 8:00 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.97 release.
> There are 65 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 10 Feb 2021 14:57:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.97-rc1.gz
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
