Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB6C42AB80
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 20:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhJLSFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 14:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234516AbhJLSEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 14:04:54 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4C8C061771
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:02:50 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id k3so9009ilu.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2bpq9vZ1ywmjFaWaTaSoSw7oZ5Xe9ZrJkc7mehLIaLo=;
        b=MurefTEGF9K6Y1js68Sz9jyL+FdvW1g0UvodpMH6zHP4NG+ZjJwrPAB14pLQppUzCV
         pi/HVqcCIADjGpGfEPr5mpAIKRFXSFytgRE4XLceuj7iNsetiwctjrpO2/W++The8H9M
         Nd079/VKzGa5s2opuk8Lo2Fd+IuqDTjnjxlO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2bpq9vZ1ywmjFaWaTaSoSw7oZ5Xe9ZrJkc7mehLIaLo=;
        b=wFShXA8vZYwyM1bVyNtkG3g92dtt+tNYObQr9Dfva1TE56J2GaXYaYUp5qhiL4fDbA
         gU/ei//fQMBnBicPsDhoSAUQXuKHol97GL/EYPx4brt8CiKNleQX74WA0rbqXaNC5C+w
         vUu+Doq1MLEZx6wSxeKRBHv7KEZFkXvqEF1nkc0GFWxynKgg0V3KSsrmyZO1b8O37y7+
         re0s3m9PI1yExzvuPX8Ul5MKcgO/EO19iiPAYR5QBMom+AfJo9TFApgBPAX5yIaKSLce
         l/NHnloqIoPjtb1mtb3YxCXMj+wJje/051OEJbcYoqJxgmoR//npKte5EckeRtIKSEEk
         lIag==
X-Gm-Message-State: AOAM530Tn+uKVHei7VaSJpN6lUxqnidOEnCvwVwckMllOLUoL0LIOOI5
        mJhdk+dTIj5KReyLn9hC4ffaYg==
X-Google-Smtp-Source: ABdhPJwS1eH0lSH0qFVNOw1ExzVPoBsE/sZUZvSLF0mwf1Jz0tMd/jH0sX+NooWgJabd1z59EqDF0w==
X-Received: by 2002:a05:6e02:1d9b:: with SMTP id h27mr21488582ila.274.1634061769818;
        Tue, 12 Oct 2021 11:02:49 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l20sm5823796ioh.34.2021.10.12.11.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 11:02:49 -0700 (PDT)
Subject: Re: [PATCH 5.4 00/51] 5.4.153-rc3 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211012093344.002301190@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <0253dcfe-95bf-65c3-ae26-89a87b997003@linuxfoundation.org>
Date:   Tue, 12 Oct 2021 12:02:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211012093344.002301190@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/21 3:37 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.153 release.
> There are 51 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 14 Oct 2021 09:33:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.153-rc3.gz
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

