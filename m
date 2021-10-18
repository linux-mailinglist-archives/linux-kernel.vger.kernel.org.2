Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283294328B0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 22:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbhJRVBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 17:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbhJRVBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 17:01:53 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6CBC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 13:59:42 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id z69so14755558iof.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 13:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JLUcl8p8Hqm8iT+oO9PaiWigqfpfxjhf8KSs3ceuVh8=;
        b=WFGjbecRVNThvQVvL1bWfKE1yS+SM+IRrLljAPxv2Wjym/Hswx2kGL4/JDuxOX57GN
         fSq2+EE11bICEQoyHOlzPTnA7alZOHARAeGcphOMKofgUqRSYIuA2JkVGEd7aPUr81A0
         b1MMusa0SbIszrjeEP0DwbweS22SfVDZf11PI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JLUcl8p8Hqm8iT+oO9PaiWigqfpfxjhf8KSs3ceuVh8=;
        b=6XogoVBI9JBCS6+ogtMQXz0CtAFS/Dvdh8hSZdVZUKIOoijaPo1tCymLEa4z1Ohkte
         +dCTp5JCSXe2Dea8GkzAY9Isbtz7O6XfDKXgazb+k0lOzo1XstrtOZH/iDExQpXtkOzv
         C/QLene4aA71CXCsTKVWc7LhYtQ+cu4wzqLhyG6EVDg7zWqIrh8K+muALHFRyK8Q0S2c
         y0JSBh1LVnajomwu2wHUVdD6xb3ouODwoclQfIFeFK8tXPufbQ2RyHiI4mYr9b64hiVs
         3C+PwGT4G1UfrsTlz62wd1YrPCTbnVovc74s3Xity0lA0NzWHbuJ0haLd0AMt1DeB5oG
         mBeg==
X-Gm-Message-State: AOAM531xwrhFGB80QXfgS5z+UuQe3drwjp+0bdLGCJQMbK0bocn/1k+3
        UYSOIDZePq5vubFDSX5OS1m4Ag==
X-Google-Smtp-Source: ABdhPJyfwHUU1IszZM3oawT8H7lX9gLMXBi5u/AzqIgDqI3DmPEVpFZsDzOfuRZCmj2x4NGW4H8L4w==
X-Received: by 2002:a6b:db0d:: with SMTP id t13mr15934449ioc.149.1634590781722;
        Mon, 18 Oct 2021 13:59:41 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c17sm7390257ils.55.2021.10.18.13.59.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 13:59:41 -0700 (PDT)
Subject: Re: [PATCH 5.4 00/68] 5.4.155-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211018143049.664480980@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <4a0d0414-3c39-f460-d37b-816cbff0f48e@linuxfoundation.org>
Date:   Mon, 18 Oct 2021 14:59:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211018143049.664480980@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/21 8:31 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.155 release.
> There are 68 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 20 Oct 2021 14:30:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.155-rc2.gz
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
