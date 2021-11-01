Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E49442289
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 22:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbhKAVXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 17:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbhKAVXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 17:23:40 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706C6C061764
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 14:21:06 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id 62so15766043iou.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 14:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K18TGQ4nH9kGKX37x989CqZVv8jyi5svDJyeXNn9jN8=;
        b=SpD3Ov1+FGbs5q+hUb7QigmZepVKpsOCXl9/w5Sm9Vfn8YZjUjykNv+nsmMlu85rKm
         ZMBM6Dtb+Lv+SRGl+jwg3RiGf5t+S3FLNJZYvVHmL5erN4kLWC6R7VfYqO4NUV2VfqcU
         uOsJmAzI8rbYsLHDQMx1EuI8Io8nKyqfe5X4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K18TGQ4nH9kGKX37x989CqZVv8jyi5svDJyeXNn9jN8=;
        b=DzoDmicjP1BzJlZx499JcBTB0SuAZOo8p4Wl7dD4a2dKIqqWw9zJQb6OoQZhast7SF
         lwdblJTvhMpZNCScCZ+qxccUxrEqWfLTG2b1W2zv6OWwbswTWuzcI5slLtL9z+zHkhOE
         +IvPDlLsurqY59zlSRWlo40TYnQr7TI4+VcmWNBf4TnF44iHnsB7V3jJBG06YAhVjchi
         cAFym9LYn1Utsd7/78XEx7aQMYj4gS57X3/tTzkqnu4ORROn4MURqwssknUgXYIhjmhy
         iiTzKy/ZETyPhImgjwYRLIkgKxm1FCbZPvST0ywtGH6aoh54Oe5x3CtSEUUOKdaWLSSG
         5HIA==
X-Gm-Message-State: AOAM530MgKJXEMHXI5YsvCwehs3ERTY0F/B4f8+eqSU9vibUpl9y8YUF
        RD7mwGCF8epTnbrAm9v59mvg7A==
X-Google-Smtp-Source: ABdhPJwExIUpZ6WzeGXBMtDCKydyXEZee9zs1WzTEJqrsTSm0bKSNy/FLJK4F8dYejrkzwo33pcKbg==
X-Received: by 2002:a05:6602:59:: with SMTP id z25mr20436431ioz.212.1635801665869;
        Mon, 01 Nov 2021 14:21:05 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i15sm5959364ila.12.2021.11.01.14.21.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 14:21:05 -0700 (PDT)
Subject: Re: [PATCH 5.10 00/77] 5.10.77-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211101082511.254155853@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <4d67fdfc-86e2-ee86-4444-892bc04b2693@linuxfoundation.org>
Date:   Mon, 1 Nov 2021 15:21:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211101082511.254155853@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/21 3:16 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.77 release.
> There are 77 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 03 Nov 2021 08:24:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.77-rc1.gz
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
