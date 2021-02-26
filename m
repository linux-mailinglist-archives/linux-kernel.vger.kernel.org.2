Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E89B325BA8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 03:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhBZCZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 21:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbhBZCZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 21:25:29 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B9BC061756
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 18:24:49 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id e2so4879741iog.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 18:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JZKa2PXVjE98EtfWOINEVIYizzKlapAufh9CNuvXzRs=;
        b=Nqm0K2Wl5L9Bh31keiE/NWxDHMAbDnSmjfWyhVlPLDqcOdyz+GkVrcpoBPxn3pbOPg
         tmU9pGjLAF2pUzT1Peq5a3Mv7V6Ey8e71gV6pJhiB6qOwao8UxuusymhUuLY7sd0OYNe
         m+u7aT7VkK/MoyW8xm/h/WcSN6IbOUGnvwvKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JZKa2PXVjE98EtfWOINEVIYizzKlapAufh9CNuvXzRs=;
        b=cG61ISANw1gk7MMRfPnMgKadoTLMhXQSpkXZ+0uyP3ljZHvsQa6CUIm9nw95tL0dpv
         fn0CUqzsm2tJ2uVeey952krBunLOWAiVkWZDMcHLL34592RmoQhiJSZmqhUsWXRRxs5a
         LGw7BRAp19xegsGRNHENE9PclYMebVreyYwlU/aGeS+AlocNZuMdoyzq6qsLdQEi0spe
         SmxFeoVj/kbRUpU8t7SenT2UmNCWUOZBLca3jeCfgOnda+IiWEj6/6Yc1J/OVcy7ahUb
         7tO/0iqrMQ48ioH1p7Bxdf0B+0xFDDxoSWZLdvVIRiP77Z98VTsfGpkfzN2mdvkXusro
         hISg==
X-Gm-Message-State: AOAM5300FU+9uLzVEJbsv36OTd9CVVUFOosuANHUL7lnX+XE++/hB9Bg
        41ZrERZbJmzJVlhAz8cLXNN+1w==
X-Google-Smtp-Source: ABdhPJw4/sbeSSDZyzuNPOp6w5utYbvsLPgeOzPYblgYrJTdkqObNyVQqYWMP01iEmmzkmomuXBH3g==
X-Received: by 2002:a02:94cb:: with SMTP id x69mr801657jah.8.1614306288659;
        Thu, 25 Feb 2021 18:24:48 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i67sm2026484ioa.3.2021.02.25.18.24.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Feb 2021 18:24:48 -0800 (PST)
Subject: Re: [PATCH 5.10 00/23] 5.10.19-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210225092516.531932232@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <37c37acb-0098-f4d8-8948-c1694cb633ee@linuxfoundation.org>
Date:   Thu, 25 Feb 2021 19:24:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210225092516.531932232@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/21 2:53 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.19 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 27 Feb 2021 09:25:06 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.19-rc1.gz
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
