Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC68F3549AD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 02:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242992AbhDFA3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 20:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237906AbhDFA3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 20:29:17 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EA7C061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 17:29:09 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id j20-20020a4ad6d40000b02901b66fe8acd6so3263094oot.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 17:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8JbhiHo6IOoY5iWGNqHOdb0xxqkEeapiHglvZ8VP2nU=;
        b=KkEGFAt+IZ8fJezAe+1XPvtNZb7bQJDD8C51ZRGBkDP8HiWT6/xm2jk7/Tn44f9x0q
         mPhOZRwHlBMSerJF0lFH19fvt18y6OIL2gnZ9VKsBVXg9dBSApe+4YsCYLufUYOs0yat
         wUISM7EJn89C+HQQ3S4+Ughm77lWaoiivXMuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8JbhiHo6IOoY5iWGNqHOdb0xxqkEeapiHglvZ8VP2nU=;
        b=fyj0yvn0kAquB3vM35t6R8xllJTzGCW85xS1FOhBsIbtA9YIdu8JpkxWPiUWr9IJwA
         JB/9aajnBHCQ/5Y+25MLnlRuGeEauMNecmVvM8TEM65F4xJKIhPoiCb7tmOKlvH2f6x5
         b6unlQCnVxTc6zNwXRFasm8TZp2iUrRfmWEBsNCvrzz+81YEVm4XCi9v1xBAujWouRbw
         vrU8kjDTNtoIKVnbZH9uswNC6TBTzPv+0bRJc7FnisHTL5dIISiZjotZm1C9rZYYXJNX
         2EdyrwbmqoX8Q1Vxq3uYbdRoMrvAhZEtDUkqy1komntHbGK/FzDatAiZsLyAskgNJozI
         K7ww==
X-Gm-Message-State: AOAM530ZQsHIYWWNjVS379Lju1dnYe63lZvGsCLVbSOAt3eV/tJrL9xU
        bLX5pnVojzKQl7jTpQlgMhQynQ==
X-Google-Smtp-Source: ABdhPJzt562iP/S34/FifCpvqG4SSFrzwLtRQ4GL4tiNzhV6BTiiBnEwmGlUds5ZIrlOaLpl7VltqQ==
X-Received: by 2002:a4a:de56:: with SMTP id z22mr24202679oot.14.1617668949048;
        Mon, 05 Apr 2021 17:29:09 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x20sm3339073oiv.35.2021.04.05.17.29.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Apr 2021 17:29:08 -0700 (PDT)
Subject: Re: [PATCH 5.4 00/74] 5.4.110-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210405085024.703004126@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <76b47745-2ab2-9bc6-2aa1-7cfa1244d57e@linuxfoundation.org>
Date:   Mon, 5 Apr 2021 18:29:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210405085024.703004126@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/21 2:53 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.110 release.
> There are 74 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 07 Apr 2021 08:50:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.110-rc1.gz
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
