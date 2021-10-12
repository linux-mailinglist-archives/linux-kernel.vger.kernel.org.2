Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59644429AE9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 03:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbhJLBUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 21:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234886AbhJLBUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 21:20:46 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D7AC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 18:18:45 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id x1so17927402iof.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 18:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gerANuMYIsa1VDfjanaYaMHDBj8H/vN7JkwYlt5oGRI=;
        b=dQ4WeV9RBxJ26B0U6pJNRM7lK/rYP8CwgcYKgTYLoNVFQYPPBUqXvKPctoq2+zHihu
         jmtE2hssI15+tNpCMD+ct3UpNNGyFVDTZUXiszUCYcwMYMDl24QJAEWZhOSBm14w6US2
         GfTbHcBk32ZM7AdLZKZ8vHddJxHjNXX9VlKOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gerANuMYIsa1VDfjanaYaMHDBj8H/vN7JkwYlt5oGRI=;
        b=ZTddg7WQZvf80bljtLMRY6fsiJjPu/vewnvIiuEtnogUUJGa7NwRpdB/MNAA9mRyTc
         MRRMU2fpyTRaoc2A/hkNqGCw6/pRFoddPl+buSUN3sUHVacGuC0kXboF9BjKHXLYSct1
         rPbPfgxj7xGfDZt7oZx6SOMllG+ACeuhjjBm8v6g/I+QE6xjqOYaNCMMy9Uj99v7No15
         bGH1vaKHPYpfQORXqR3NDFxFCELr5mZncknrlJQWZw0ybr2l56SnJGphMxkoT/YjBajx
         ds5WKLcRILAwdRG0WuNu0/41du4fxq1qs9zjgexIIfG2PPRcR04Wx98KGUh5xgxn7fiV
         A6NQ==
X-Gm-Message-State: AOAM531FmXvpVZLLntpzMjrdOsETQtBG1DYp6bgPah0Q/gduB5GzH05F
        iHuBuw/0RPX0M8JVnyeYifUCUtvfH1sYNQ==
X-Google-Smtp-Source: ABdhPJzvjNb9lJ0xniiiUt8+ZCb97bobFC5kON354fKdFcf1I9RmAN2YsG+CGFHX5/gDlmRFvxFvlQ==
X-Received: by 2002:a02:270c:: with SMTP id g12mr20789755jaa.75.1634001524866;
        Mon, 11 Oct 2021 18:18:44 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id m2sm1330340ilg.72.2021.10.11.18.18.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 18:18:44 -0700 (PDT)
Subject: Re: [PATCH 4.19 00/28] 4.19.211-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211011134640.711218469@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f70e42ea-2fcf-ac92-2e33-3b787ffde4f4@linuxfoundation.org>
Date:   Mon, 11 Oct 2021 19:18:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211011134640.711218469@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/21 7:46 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.211 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Oct 2021 13:46:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.211-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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
