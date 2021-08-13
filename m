Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6983EBEB9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 01:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235770AbhHMX0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 19:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235359AbhHMX0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 19:26:34 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC56C0617AD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 16:26:06 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id v16so1746034ilo.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 16:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8KjlZeOTulaFH6ENv8cuIdGqBV299uisFEi/IjHaLBI=;
        b=XOD73QKWgfFcCPtR+LUrPTi5eGKuNAXAB5liWLxyjPc1X667720GDXBfbqosc7HZ1D
         dTuMzDJl5/yvqnYucsTDGtqAGDZKaVpAaGQrearPdPSSAjrG3aND12/TagPyDb9w/NCb
         /m9KzwiKXSoEJn9GcuRmyDSmrae7czFmRo1HA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8KjlZeOTulaFH6ENv8cuIdGqBV299uisFEi/IjHaLBI=;
        b=TY6UZlsl90xrq7mBLhsZpEs4EAgSaHw/Ynk8Vivn4EHOQHrBZBRkV4YgXWiqsIbxXu
         7jEcwOFwGi2s+72PDPE8qkie2vn0YszKg0tYSF7ppJql99BieR7wU+fstVXlky3b4D9p
         aYsL5UVjQVa1pBj4E+NALQRkzu5ApEvgUbR1SF95JAuBdKgRvK09GAeRXfBKX2NiWzxu
         L2mDutkvDb0rpVZUa6JYqQBSlwj74zjLw71glaZaFoL1S420G4JI9+TS05ye+cOR5woR
         TYoPDUkU2Gq+5wf/OGzqRO8vQsGzSn7qRoADQtksNhmxODsGBEa8bwoah5iJWkOHasT8
         Nj/w==
X-Gm-Message-State: AOAM532OCQoLfvtsw7nKy8SgHlnfQEU7lHXoQti+U7cvo69txZEbQB1p
        fgLxuNTdqh/Ufu2GR47934pVBg==
X-Google-Smtp-Source: ABdhPJx2qbhEgPKHkpNZvBg7BZLPiowHnhC+EQOvNUqdoFH8p0LI11NdeWEMsQhPaHnb4h7Pq/Bgtw==
X-Received: by 2002:a05:6e02:154b:: with SMTP id j11mr3384310ilu.96.1628897166083;
        Fri, 13 Aug 2021 16:26:06 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x15sm1478509ilp.23.2021.08.13.16.26.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 16:26:05 -0700 (PDT)
Subject: Re: [PATCH 4.9 00/30] 4.9.280-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210813150522.445553924@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9e6ef946-e5df-bb15-6e7e-2242ff15c1d9@linuxfoundation.org>
Date:   Fri, 13 Aug 2021 17:26:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210813150522.445553924@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/21 9:06 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.280 release.
> There are 30 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 15 Aug 2021 15:05:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.280-rc1.gz
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
