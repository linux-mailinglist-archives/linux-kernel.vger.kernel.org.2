Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8953A0A56
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 04:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236220AbhFIC6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 22:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbhFIC6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 22:58:18 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B560FC061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 19:56:24 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id c31-20020a056830349fb02903a5bfa6138bso22482102otu.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 19:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ai/DFSSo6UQg2GJJ+mhoa+CKX48y8PzGUVihOLbaeVQ=;
        b=aspIUyaHw4dbNAnbOxFTf2trXNK68yj1KFJEgcFvt+EvPtfYUC1oyv+0rOd7LjMFim
         OBWy0I3WnQAqSdhftXcGpadYrOil5WCllMvIaZZxPMmcVBek4bVmqa6Gw2R/kSkq7e5F
         Ah31gGaPWElbg/OfdgWZWMa4Bd1qeLlHrNGwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ai/DFSSo6UQg2GJJ+mhoa+CKX48y8PzGUVihOLbaeVQ=;
        b=lg6kaOuxHIUdeNPuVGQB2b8UA6Vtw5I9M3I4dwL3qFXv+WsfX4wyBIlNLPAWABTxl8
         Wtvxlnv3DlGDl72cWe4Ghrt1r5PlnKzY0Drw6m8/nDvpzzbEPs4r2Cdwopx8P4AjZtpN
         ZhbF81UGGOSOZc0+mTzju7zND3JFfdykJUYc+BRc5R/iQQqsAWL/nLJjLQL39r76dH6P
         wyg3vkzcQxvOVkKOIloa2fVz92RMA6VmZRUktlMkXZldwwKZucAtfMvLBtSypWvmzil8
         Ja2o5GNHUIw2Ok+jjNKJBoKRSrx7HNB+Gozc2s0miv3N8qjOH+AlzZVAcyVyWVUcZZOU
         J47g==
X-Gm-Message-State: AOAM530nIjqM+UvpSGWiM8GrSPrjTEczUzX0a66GIlZZKQI0IZktKk9C
        xacdXLBAvSeuue7jB8tsh5ihvw==
X-Google-Smtp-Source: ABdhPJyJqMq+IQEompYqr4Z/KpmZIRKifbGQnjp9bsIVJISSzDQGEzINrxpWWna2N+4dvSlsPHnewA==
X-Received: by 2002:a9d:8a7:: with SMTP id 36mr20722222otf.287.1623207384125;
        Tue, 08 Jun 2021 19:56:24 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a74sm1173237oib.21.2021.06.08.19.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 19:56:23 -0700 (PDT)
Subject: Re: [PATCH 4.4 00/23] 4.4.272-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210608175926.524658689@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e860bb90-6fa1-49c8-7ca8-4dd5e40ac4fa@linuxfoundation.org>
Date:   Tue, 8 Jun 2021 20:56:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210608175926.524658689@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/21 12:26 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.272 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Jun 2021 17:59:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.272-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
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
