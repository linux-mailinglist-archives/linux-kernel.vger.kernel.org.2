Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904FC45C857
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 16:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbhKXPPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 10:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhKXPPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 10:15:50 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9AAC061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 07:12:40 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id l25so11745392eda.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 07:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IqYslmpv1yqDJjThQv0ySRbKLZIoZm80xilrzxmA8Qk=;
        b=HFjdJK+/43spe75v55jcPDtzWSczxrPWRC6UvZGRrnu3M/GxoHznFUd7MkxOer/Fa4
         JQ0bmkugdYXxb2cn4f8mmwYTIea0y4QtFgl5nUQkzHXNwyQiW1DgoQhkrLzmJfBAUxIw
         FL5bBZEks/JPFoYaY+sH088hHxpaybAiG3VTq241kOY/vD259DTKOc6Wp0anz+S/QnPQ
         +OEI45Rr1fY2exr54K/uu0uYljhig026aT0WLIbervqmJ0iV3R2JX+D36+N8YVtel20b
         GGByHh32ZR5Pvf4B4h/2HzFwcll+hICmaXn5SgIuYcRMXT6XbMpuJ/ojcRnEd7KaGtb3
         dwww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IqYslmpv1yqDJjThQv0ySRbKLZIoZm80xilrzxmA8Qk=;
        b=Xck29myTjPAEEmkfNVWtZ1PkVbrxEc2tEtsgyFYf+aGvHyOSWuwm5zgcusuq25VpQk
         /lgkJT7swshKQrQJ2XrVh81dT+aakD2ynTXu4BtewSjI1UWlaprVIBbHI7fQVjswyYqv
         ZB6RxNvoIrFEXTAauAo69r2BcuQier9bHQMu/OS4KCC7MrqCTwpcDIknJv9das7jatIe
         WmBvsoAqsQmEqLbY6EgZyreKQ9FjJqM5NBE+bWqz8J885qHRrVKtEq+oMRdqlJvCjFem
         d4L3yuD6+JZLt7SuDBNxQF8bnQK8gPkhKELr022sJYw5LGRFb/gjfyoThakIrwDTHUWP
         Lzkg==
X-Gm-Message-State: AOAM530REI46otXOs8e+wt7nL/WT6ljddscT10Pn41kPDqs1Q3AuPkKr
        j17bjWqtKvOT47ekjuyRK4/nZKdrpZUcaMzuy4E42tHetR7XYQ==
X-Google-Smtp-Source: ABdhPJxb1xoWgYjl2rdv6j9Ih7tYRWC6b4QucPhtsCrazuTm2MK7fsoEggiuSOUAT9cvc9l6jWEnDY8SK4f+BWPUwvk=
X-Received: by 2002:a17:906:489b:: with SMTP id v27mr20680621ejq.567.1637766759116;
 Wed, 24 Nov 2021 07:12:39 -0800 (PST)
MIME-Version: 1.0
References: <20211124115703.941380739@linuxfoundation.org>
In-Reply-To: <20211124115703.941380739@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 24 Nov 2021 20:42:27 +0530
Message-ID: <CA+G9fYuZqV51ZGQd-ySaDqSQ_YDJHYav4KW4B0zEq1Rh2_KCDA@mail.gmail.com>
Subject: Re: [PATCH 4.9 000/207] 4.9.291-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        f.fainelli@gmail.com, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        stable@vger.kernel.org, pavel@denx.de, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, linux@roeck-us.net,
        Nadav Amit <namit@vmware.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2021 at 17:44, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.291 release.
> There are 207 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 26 Nov 2021 11:56:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.291-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Regression found on arm gcc-11 builds with tinyconfig and allnoconfig.
As a reported in this email,

https://lore.kernel.org/stable/CA+G9fYvU4yoOx7BEBxJXRVZx4pO5fYPRELmkNz+iBu7kdN_9Ew@mail.gmail.com/


build error :
--------------
make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/current ARCH=arm
CROSS_COMPILE=arm-linux-gnueabihf- 'CC=sccache
arm-linux-gnueabihf-gcc' 'HOSTCC=sccache gcc'
In file included from arch/arm/include/asm/tlb.h:28,
                 from arch/arm/mm/init.c:34:
include/asm-generic/tlb.h: In function 'tlb_flush_pmd_range':
include/asm-generic/tlb.h:208:54: error: 'PMD_SIZE' undeclared (first
use in this function); did you mean 'PUD_SIZE'?
  208 |         if (tlb->page_size != 0 && tlb->page_size != PMD_SIZE)
      |                                                      ^~~~~~~~
      |                                                      PUD_SIZE
include/asm-generic/tlb.h:208:54: note: each undeclared identifier is
reported only once for each function it appears in
make[2]: *** [scripts/Makefile.build:307: arch/arm/mm/init.o] Error 1
make[2]: Target '__build' not remade because of errors.
make[1]: *** [Makefile:1036: arch/arm/mm] Error 2

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Patch pointing to,

hugetlbfs: flush TLBs correctly after huge_pmd_unshare
commit a4a118f2eead1d6c49e00765de89878288d4b890 upstream.

--
Linaro LKFT
https://lkft.linaro.org
