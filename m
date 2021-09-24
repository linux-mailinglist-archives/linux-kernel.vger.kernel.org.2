Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241B74176A5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 16:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345808AbhIXONn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 10:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346008AbhIXONk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 10:13:40 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3406C061613
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 07:12:06 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id y201so14642285oie.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 07:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QHWU83P2QW9GhJYRT+OrwRkJXHizJLTmhkuqfEE3CsM=;
        b=g6y8kcoqbXZIS2JO8xh24fL0VeGvNnPeeP0PRi0kYvqZuxr1iDhs9N51MVKlWlYzcD
         XZkgT/OGS40r5UypvCP16WA80+0Xy3vdptTJy8VR1cEyY8Jteo6lCyqme57I3byTINxs
         6Tim5L6AF7KBaFgLslotAWEsIs9m4r9GNCAu4t3NCPiILiP+8SHJZ7oxEfYfaZr1bPJU
         k1oTmdn/NsEjCwIzpecIupZeAsOV8DwQHjs0F6tUdEEPaUUhIdjUzqkhvIlwPoPi8X8s
         IA94SmnIovNnGXVN4sBBsK6tZyoFmnkbv7l7Zztbo+OI9qyCylRnizW+HFqCV4uQmh/p
         HCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QHWU83P2QW9GhJYRT+OrwRkJXHizJLTmhkuqfEE3CsM=;
        b=p3pyYcIlQdqUOfTa6tj35eBwZCkBkcIPZYKISapdxhMteoDF2nymG/fx1e1gwfnduQ
         P+LRykc+6O+gRIfDpdzyZEkgTw92Y6ZmmEyfxq0lw4tEGAnoHoyVY9bDhr1mJR+CA6h3
         OOKn4Nbala2c8ndRSKQdcs4klpNuXqdCIJivcMxR75uZfgOmUmbwj2tFAradzPRKgDqn
         x7pqhu7hJQrlQSR9tDdn4SJO4OehFWFVcRgPS32ttK8qi75V+kr8Ub+WgjIyHudrQG9d
         Z6Rghf6Py2/2nfOnSkAVweqJum+P+pdPrRaFT6kpEFTKB2rSXCVUJLOEMqq6vZp9HFgb
         rUcw==
X-Gm-Message-State: AOAM530sIiD3zEuTqd8lg+okDRytiQ3n/z2ancOVuSajaOwmmNplfHUG
        IksUhBccUYFwpu+fou1Q3rzSUg==
X-Google-Smtp-Source: ABdhPJxmoqc2Pndb75bFtMtyDU52IEzmImh5nLyoThNL7QCJ5wvd3GaD1Zon2Op1UqXaB049PzVRyQ==
X-Received: by 2002:aca:5bd4:: with SMTP id p203mr1599204oib.34.1632492726203;
        Fri, 24 Sep 2021 07:12:06 -0700 (PDT)
Received: from [192.168.17.16] ([189.219.73.83])
        by smtp.gmail.com with ESMTPSA id bk40sm2140964oib.8.2021.09.24.07.12.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 07:12:05 -0700 (PDT)
Subject: Re: [PATCH 5.10 00/63] 5.10.69-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     shuah@kernel.org, f.fainelli@gmail.com, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        stable@vger.kernel.org, pavel@denx.de, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, linux@roeck-us.net
References: <20210924124334.228235870@linuxfoundation.org>
From:   =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
Message-ID: <c7a38a76-18b0-efaa-efed-f73e53e58277@linaro.org>
Date:   Fri, 24 Sep 2021 09:12:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210924124334.228235870@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 9/24/21 7:44 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.69 release.
> There are 63 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 26 Sep 2021 12:43:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.69-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Regressions detected.

While building Perf for arm, arm64, i386 and x86, all with GCC 11, the following error was encountered:

   util/dso.c: In function 'dso__build_id_equal':
   util/dso.c:1345:26: error: implicit declaration of function 'memchr_inv'; did you mean 'memchr'? [-Werror=implicit-function-declaration]
    1345 |                         !memchr_inv(&dso->bid.data[bid->size], 0,
         |                          ^~~~~~~~~~
         |                          memchr
   cc1: all warnings being treated as errors
   make[4]: *** [/builds/linux/tools/build/Makefile.build:96: /home/tuxbuild/.cache/tuxmake/builds/current/util/dso.o] Error 1

To reproduce this build locally (for instance):
   tuxmake \
     --target-arch=x86_64 \
     --kconfig=defconfig \
     --kconfig-add=https://raw.githubusercontent.com/Linaro/meta-lkft/sumo/recipes-kernel/linux/files/lkft.config \
     --kconfig-add=https://raw.githubusercontent.com/Linaro/meta-lkft/sumo/recipes-kernel/linux/files/lkft-crypto.config \
     --kconfig-add=https://raw.githubusercontent.com/Linaro/meta-lkft/sumo/recipes-kernel/linux/files/distro-overrides.config \
     --kconfig-add=https://raw.githubusercontent.com/Linaro/meta-lkft/sumo/recipes-kernel/linux/files/systemd.config \
     --kconfig-add=https://raw.githubusercontent.com/Linaro/meta-lkft/sumo/recipes-kernel/linux/files/virtio.config \
     --kconfig-add=CONFIG_IGB=y \
     --kconfig-add=CONFIG_UNWINDER_FRAME_POINTER=y \
     --kconfig-add=CONFIG_FTRACE_SYSCALLS=y \
     --toolchain=gcc-11 \
     --runtime=podman \
     perf

Greetings!

Daniel Díaz
daniel.diaz@linaro.org
