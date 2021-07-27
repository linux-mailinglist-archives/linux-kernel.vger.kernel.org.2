Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCAF3D6B1F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 02:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbhGZX4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 19:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbhGZX4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 19:56:22 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C17CC061760
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 17:36:49 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id h63-20020a9d14450000b02904ce97efee36so11782396oth.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 17:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MnfUJHksOhHrUR4OzOMW3hWEu649YzD2jTIICKMt5sQ=;
        b=iV6A7lnpOdoCkH4bF2cs2IBlbktKjllJ5l+aU1yNjdDQdswAPo4jpAYCUW9lfTIq72
         28L9pXqVlW83XhqadlQjR8l7nBnJ64HVWG85aF1LOvbC9ySzNZkbKZyxx/KXfYTF7UOD
         v/6cWQDWcrUTRxRkFcN/vz2Gxht+TCrNFzLpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MnfUJHksOhHrUR4OzOMW3hWEu649YzD2jTIICKMt5sQ=;
        b=EtzZTziblQJFsZmEd4Whv5ic7bGRCpgs271b4rP8a5bs53NQbr3tUk/qphd/j6xe72
         t133+8GmFFycgOPQakWCOggQ063WbG3EpFikNznQl19GdpC/lKhTXeSdY7+tLKAXVp3g
         bHfSdVhuoQwHAjoilXCUZ2CvliQRWvsw2j2BaAvVMvoUBQw0+s7Iip//sXO3Ff6rs7iH
         MlppK1Y6ZvLg4qUdKTdaZiKAZiGQqHXSoHDCVpVFyJoBgj1/7oS47rayfsZ1GcfnDCp4
         qQm0sjCQtp2PVdT1wtHpyG5LyqR3Dw2sK9V31LFNjd4n2RC33Oj25WiV4MGquq9vm4vZ
         1xJw==
X-Gm-Message-State: AOAM531So87lBduKvLMt18rs9uMogcicPlH4bES4+ZIqn8uoctSKi+OT
        f+B/NLxjmFBHx7NccoaD0KrVbw==
X-Google-Smtp-Source: ABdhPJy0VTIyUADZKpT/SzGXvk0UX3vIraW1PwQRzICgZAhChGVUVcZ9wUPo42CrETT+LCCqyqXDwg==
X-Received: by 2002:a9d:3e06:: with SMTP id a6mr13778092otd.50.1627346208873;
        Mon, 26 Jul 2021 17:36:48 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x14sm323672oiv.4.2021.07.26.17.36.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 17:36:48 -0700 (PDT)
Subject: Re: [PATCH 4.9 00/60] 4.9.277-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210726153824.868160836@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <4b21c15d-7689-4f4e-ab3b-829b3279ebab@linuxfoundation.org>
Date:   Mon, 26 Jul 2021 18:36:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210726153824.868160836@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/21 9:38 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.277 release.
> There are 60 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 28 Jul 2021 15:38:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.277-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
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
