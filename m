Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46BE3D3D08
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 17:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235697AbhGWPS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 11:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235588AbhGWPS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 11:18:28 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD85C061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 08:59:00 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id f20-20020a9d6c140000b02904bb9756274cso2505332otq.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 08:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gsAtSKzvk9fquVfCZQyjVjjkdpxVo1nm7YgxqYqDF2A=;
        b=P8h9kGlgSkZ9ak4PdU/D9xKsC8GfFxHNQFlU0468namzJijaAjpkihMcEyVLyaaH1m
         qpUrLLmxJfO90qNUn7ih+mFsP6XpM3lH80dOQ4/bFi6wHdejNUWPHC9/84I8iikK2kLE
         blNMkRre8Wc3ebVJhiGUuXJvSJWW0rD8y+Hmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gsAtSKzvk9fquVfCZQyjVjjkdpxVo1nm7YgxqYqDF2A=;
        b=B+jsA9psRhddvcwwQSisNECQKRrSPabcF4sKAEp77Qo15yKNH0qMw/P1Ie6xAzyzLs
         voykrwKlebI8In2Ujjzx23GdD06ZvfnzE2dfVOMtdE61zh1BCZut3lhQjGbCmnF0t3jE
         WQS8BK6ack6EvN0qS67kENUIH7MH7sL4eZTc7E7kcB6RvtNxMkYKn5BoQWxamz+iY102
         0Ynt0jCSs3/dkBD3j4Bow35qLZB1zyJkU70AxCwOHPQO36WtKIhO5oYSREkpoT2SuueF
         1recrXLiQ6V+xb6CWSA9/Ujo3S3LEzAhlVjWTH+1yqd80EJ//9ypiS0zwIaYz9pcO4Wt
         a7JA==
X-Gm-Message-State: AOAM532lPi/R9WJgB2menCA8WkhDMscHJPr3wEN5Etcm7bUxLpP279XW
        nK2wb+MWMkycNE7GPkh0poCDfw==
X-Google-Smtp-Source: ABdhPJyHyC5MS0gQSXv5zzoh8bN0AKbT8U73wIFg814usxijhF2W3/GewA2qiuqUYwrqmKwMqd/9xg==
X-Received: by 2002:a9d:8d3:: with SMTP id 77mr3567217otf.6.1627055939760;
        Fri, 23 Jul 2021 08:58:59 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h187sm1279505oif.48.2021.07.23.08.58.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jul 2021 08:58:59 -0700 (PDT)
Subject: Re: [PATCH 5.4 00/71] 5.4.135-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210722155617.865866034@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8900e167-69c6-ccf8-64ce-d130d3974cc5@linuxfoundation.org>
Date:   Fri, 23 Jul 2021 09:58:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210722155617.865866034@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/21 10:30 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.135 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 24 Jul 2021 15:56:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.135-rc1.gz
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
