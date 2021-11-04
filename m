Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A67D44569B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 16:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbhKDP4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 11:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbhKDP4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 11:56:37 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6234C06127A
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 08:53:59 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id r10-20020a056830448a00b0055ac7767f5eso8871225otv.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 08:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=57ktjFEtesdLi+1z8hbOyPWZtwGeamLgAiEVc1UH7SI=;
        b=hvQniKKj9i6+dl6JNccGuh2PvpCpsDuoVFrCnvGilJu8SYU9eBOcuD9lh3Cc7Y6KTD
         0CQ89U+sfMehs2LPTWE813UzweLDzS1N2iXmIhbUYDpJt8jfXfNWYgIVSAV18vlHJnLb
         C8exfXMDAylDbwllx/DaHJm+2nRmxmzXza6jZXXUQyfKotZKv3Gswmux2bRp4THBka11
         d98qdzU4mkZPVpX+UhV/1za5+VBkiRqn2iTAXt4RsfTOTNwwQapGlOzt2sS7HCSuBEUJ
         brZK4nM/ijzoFclXVD28MfaPqRR32WrQHLHxKGFbnX6XMIHhyYkaFI8zzdpcuGSlBzdl
         0Vfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=57ktjFEtesdLi+1z8hbOyPWZtwGeamLgAiEVc1UH7SI=;
        b=X2Nc14Y1szSW4/MRP5O/9k/KGBRc3yvcbpfiMzA+ntzMrgePrzrc5V7hd5+z602B3m
         j7yRIHGmosKWF4qXkIbtDwbWGbM8jeGNQM2PS/rw/obsxx6171GrHWSqnnPbX/pN9Z67
         vz/u4X/trL7OYJHV5kBy/PgT6KnEisgAI9pdWuymM//Nub15iDhZMGMC2P/onAN2AqaQ
         NO0DdPylyy93ZuG2KYGJCkj0WFUqceIZXsTZaUKcA9E2qPs//oNoFqhzZEgQhkDxu1aN
         P34pwWr1koVHmSEag+1nTF8zKz5wVMJpYsE/nVqGIJDHYFPwvuFvgAeFau2Gd3AIG73n
         1Akw==
X-Gm-Message-State: AOAM532b/hv63uj1aAs41LakWgXRRIl+QDPDwTyX+MWcvagU0kf79Ba+
        d05cKRh5zP9L03ggnhjQ1ETbcNOX1YV0jxOu
X-Google-Smtp-Source: ABdhPJwNEREUFoRziBuC9TC46+Lk+CuVVn9ESUk41WEdsVUDos1AKVw2RANG141JlLfGmQJPM14Aag==
X-Received: by 2002:a05:6830:22ef:: with SMTP id t15mr37489047otc.368.1636041238980;
        Thu, 04 Nov 2021 08:53:58 -0700 (PDT)
Received: from [192.168.17.16] ([189.219.75.83])
        by smtp.gmail.com with ESMTPSA id x8sm1471617otg.31.2021.11.04.08.53.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 08:53:58 -0700 (PDT)
Subject: Re: [PATCH 5.10 00/16] 5.10.78-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     shuah@kernel.org, f.fainelli@gmail.com, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        stable@vger.kernel.org, pavel@denx.de, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, linux@roeck-us.net
References: <20211104141159.561284732@linuxfoundation.org>
From:   =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
Message-ID: <3971a9b4-ebb6-a789-2143-31cf257d0d38@linaro.org>
Date:   Thu, 4 Nov 2021 09:53:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211104141159.561284732@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 11/4/21 8:12 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.78 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 06 Nov 2021 14:11:51 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.78-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Regressions detected.

Build failures on all architectures and all toolchains (GCC 8, 9, 10, 11; Clang 10, 11, 12, 13, nightly):
- arc
- arm (32-bits)
- arm (64-bits)
- i386
- mips
- parisc
- ppc
- riscv
- s390
- sh
- sparc
- x86

Failures look like this:

   In file included from /builds/linux/include/linux/kernel.h:11,
                    from /builds/linux/include/linux/list.h:9,
                    from /builds/linux/include/linux/smp.h:12,
                    from /builds/linux/include/linux/kernel_stat.h:5,
                    from /builds/linux/mm/memory.c:42:
   /builds/linux/mm/memory.c: In function 'finish_fault':
   /builds/linux/mm/memory.c:3929:15: error: implicit declaration of function 'PageHasHWPoisoned'; did you mean 'PageHWPoison'? [-Werror=implicit-function-declaration]
    3929 |  if (unlikely(PageHasHWPoisoned(page)))
         |               ^~~~~~~~~~~~~~~~~
   /builds/linux/include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   cc1: some warnings being treated as errors

and this:

   /builds/linux/mm/memory.c:3929:15: error: implicit declaration of function 'PageHasHWPoisoned' [-Werror,-Wimplicit-function-declaration]
           if (unlikely(PageHasHWPoisoned(page)))
                        ^

   /builds/linux/mm/page_alloc.c:1237:4: error: implicit declaration of function 'ClearPageHasHWPoisoned' [-Werror,-Wimplicit-function-declaration]
                           ClearPageHasHWPoisoned(page);
                           ^
   /builds/linux/mm/page_alloc.c:1237:4: note: did you mean 'ClearPageHWPoison'?


Greetings!

Daniel Díaz
daniel.diaz@linaro.org
