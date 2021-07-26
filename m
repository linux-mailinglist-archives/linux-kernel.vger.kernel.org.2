Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE1F3D64CC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 18:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239798AbhGZQGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 12:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240758AbhGZQE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 12:04:59 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8924C061372
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 09:43:13 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id z26so11566560oih.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 09:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NdX13LWnHVphbv5/jTkJzsPyEzi3c8U9xthXSsCMjvg=;
        b=y6xm3YIQFNdcPVTtHQs6sRH1mS5p6uHRGBrDokpleG228vjJWcby6bIukbPKgXlKiQ
         EYYG4ZlwZWMbXeb1tSobAV2bqhmzbh5ddydtp3sWNomVdIrluMqmYjOMUoLAVxOx+K1S
         WRNDqVzuX8empufIK9fuduKvl611FD/78IMsH7LeaXJpGuw/NnaYfC0fU6uaEJMcvxoa
         zy3xNao0YovPXg+NgyBkU+EmBBKOwE+c1RwxvmTd5CQdketSF2g1wzw4PBndIRy44Kjk
         A7WP2uqgHBnSLC2Xze3z4uI+kdWhlywO7OVPLsThbRWQGfnbWqwEE9NjHIOnRMluGGqG
         qbdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NdX13LWnHVphbv5/jTkJzsPyEzi3c8U9xthXSsCMjvg=;
        b=cRpdISTohY1A/VMqXzucU5HLzHA7+DFj8EI5WvQ5XrkV0YkRihHEEX7zr9uK6weF+Q
         jmY1WYHtvsMULdDL66Z+orvOJwfGzTA05o1UZlkIpo0nzu2o9YlGu2EZ1FJ/MFY9BBnF
         cnn0hywZSozWNZwpMFMbq1YeSdZyGLUiD26Rtm7evsDvVjHnPlDoTCjPIse0fpUQyhoa
         l5opFGzUJ2oFuRQ+5GJNduvNSrtZxn33k6OpcsBz5iWUwsKpvcsf4mF1M0F3LfUmarxc
         U55h9RYUhihYU55NoS1uYIUFr2J/fKy4H+m3PzamSxMW3f/XLHevwtE4SsHoY7+2DmcI
         n9zw==
X-Gm-Message-State: AOAM533J1oDn9GGU6SHd+QE4A0VNaxOwmB3z41UPHbFO7rs51zxa+pLX
        7o/Dlxc3YEIvRXLR96RaRqXdPDHCAaJJSXxU
X-Google-Smtp-Source: ABdhPJzXvlrJNlzoPJvZhyXGM/tlohScunN/GKrL0BT+ZlR7j+n+iIH5/eDzlwu069YVC1qSDx8P0A==
X-Received: by 2002:a05:6808:1494:: with SMTP id e20mr11606655oiw.111.1627317792575;
        Mon, 26 Jul 2021 09:43:12 -0700 (PDT)
Received: from [192.168.17.50] ([189.219.72.83])
        by smtp.gmail.com with ESMTPSA id r1sm50986ooi.21.2021.07.26.09.43.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 09:43:12 -0700 (PDT)
Subject: Re: [PATCH 5.13 000/223] 5.13.6-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     shuah@kernel.org, f.fainelli@gmail.com, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        stable@vger.kernel.org, pavel@denx.de, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, linux@roeck-us.net,
        linux-kernel@vger.kernel.org
References: <20210726153846.245305071@linuxfoundation.org>
From:   =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
Message-ID: <99b34fe9-0f1f-c94f-58d5-cfb43de98d76@linaro.org>
Date:   Mon, 26 Jul 2021 11:43:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210726153846.245305071@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 7/26/21 10:36 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.13.6 release.
> There are 223 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 28 Jul 2021 15:38:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.13.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.13.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Build regressions detected across plenty of architectures and configurations:

   /builds/linux/net/core/dev.c: In function 'gro_list_prepare':
   /builds/linux/net/core/dev.c:5988:72: error: 'TC_SKB_EXT' undeclared (first use in this function)
    5988 |                         struct tc_skb_ext *skb_ext = skb_ext_find(skb, TC_SKB_EXT);
         |                                                                        ^~~~~~~~~~
   /builds/linux/net/core/dev.c:5988:72: note: each undeclared identifier is reported only once for each function it appears in
   /builds/linux/net/core/dev.c:5993:47: error: invalid use of undefined type 'struct tc_skb_ext'
    5993 |                                 diffs |= p_ext->chain ^ skb_ext->chain;
         |                                               ^~
   /builds/linux/net/core/dev.c:5993:64: error: invalid use of undefined type 'struct tc_skb_ext'
    5993 |                                 diffs |= p_ext->chain ^ skb_ext->chain;
         |                                                                ^~
   make[3]: *** [/builds/linux/scripts/Makefile.build:273: net/core/dev.o] Error 1
   make[3]: Target '__build' not remade because of errors.
   make[2]: *** [/builds/linux/scripts/Makefile.build:516: net/core] Error 2
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [/builds/linux/Makefile:1853: net] Error 2
   make[1]: Target '__all' not remade because of errors.
   make: *** [Makefile:220: __sub-make] Error 2


Here's a summary:
* arc: 10 total, 4 passed, 6 failed
* arm: 193 total, 18 passed, 175 failed
* arm64: 27 total, 12 passed, 15 failed
* dragonboard-410c: 1 total, 0 passed, 1 failed
* hi6220-hikey: 1 total, 0 passed, 1 failed
* i386: 26 total, 12 passed, 14 failed
* mips: 45 total, 15 passed, 30 failed
* parisc: 9 total, 6 passed, 3 failed
* powerpc: 27 total, 6 passed, 21 failed
* riscv: 21 total, 14 passed, 7 failed
* s390: 18 total, 12 passed, 6 failed
* sh: 18 total, 6 passed, 12 failed
* sparc: 9 total, 6 passed, 3 failed
* x15: 1 total, 0 passed, 1 failed
* x86: 1 total, 0 passed, 1 failed
* x86_64: 27 total, 12 passed, 15 failed

All failed, except allnoconfig, tinyconfig, and a few others here and there.

Same applies for 5.10.

Greetings!

Daniel Díaz
daniel.diaz@linaro.org
