Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581FC37EB4A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244797AbhELTX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 15:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343580AbhELQxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 12:53:18 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF547C03461B
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 09:47:57 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id s6so27828574edu.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 09:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JLDlceFPG4F0Fb3dNmzA+5MCXXJnN0q1C9HnPLqxGao=;
        b=JzN0isVmUOucKzUKjur/vn33DhCU89F/fH1BSSc5FQmte51dxAY2hw/9FG1hIp887h
         YNlOP5aE5/xQfni49iOo2ZpX9ZEk7bBOhlQQmHkjmNg58xN3MezOnQ6ocZCzSkNGZNKM
         8cvZq6P9kIBbQZAlw/oTJhLswznEGMSNGeGcZsqAOu6iA1+Isx546PrPPKBHXoQmTc3p
         JdUm3DffBX3wu8GZb3lmlSS1HdpW/oVEtDzuF7tSPsLxSzDrpE9o6fagffn31l+TK+PP
         RqQeMwJiwLUBiJKAIBMotEJGeDemsLjxIfMmdVwcpJdtFE8dN+w0G24h1Ujex1/2QwZ4
         7FGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JLDlceFPG4F0Fb3dNmzA+5MCXXJnN0q1C9HnPLqxGao=;
        b=t4hopIcizswDDkuelTGw42tyxOWv2DqlSVA78/K0TuiAbzNa/4dSDsnr2yd5zF9li6
         Q/sd2F9yZceRf+E7AOIfobw5nuGfGhruNoq/ZLYpvoM/FN7UsBIIyCj+iTFyJrDoDg2q
         OfiSb23k0OskxO+VasY8Z5ZOs5vkixmIW+gUJyHJVnO/PfeA0proCkMPT7kFCoA52gMM
         NuFEOTANB7KNukXu1pd3JibpB6q3vDnw0DnfZIbMNhLGtxnJNmp+LisYrtwSH2A97PEF
         C8AnPIFCBMsDZqX7j1RVQX9OvV8qJH/WfSEGatOvMCA3i/FAen2zY+pokkui9wgxMz0w
         Sq9A==
X-Gm-Message-State: AOAM530AjI/Wp0rJ1twGu8DOkbsVdvuTRO0IAeByFV0RCSBYLq+H8EOc
        rDu0wlCDttQco7WKXGE92JE3yr6AmBPPz6jtXXZI1g==
X-Google-Smtp-Source: ABdhPJyRZZ/2wFYuQ59+lzOy/ODmfJDP4HsKhPf+qtv1rThZSJPRW9sq7+R/GFBeQlTmuP+XhNbOkyQHO6bH3wh/JvM=
X-Received: by 2002:aa7:cd4a:: with SMTP id v10mr38037505edw.239.1620838076182;
 Wed, 12 May 2021 09:47:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210512144743.039977287@linuxfoundation.org>
In-Reply-To: <20210512144743.039977287@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 12 May 2021 22:17:44 +0530
Message-ID: <CA+G9fYs1AH8ZNWMJ=H4TY5C6bqp--=SZfW9P=WbB85qSBDkuXw@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/244] 5.4.119-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>, patches@kernelci.org,
        lkft-triage@lists.linaro.org, Jon Hunter <jonathanh@nvidia.com>,
        linux-stable <stable@vger.kernel.org>,
        Pavel Machek <pavel@denx.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kvmarm@lists.cs.columbia.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2021 at 20:22, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.119 release.
> There are 244 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 14 May 2021 14:47:09 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.119-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Build regression detected.

> Alexandru Elisei <alexandru.elisei@arm.com>
>     KVM: arm64: Initialize VCPU mdcr_el2 before loading it

stable rc 5.4 arm axm55xx_defconfig builds failed due to these
warnings / errors.
  - arm (axm55xx_defconfig) with gcc-8,9 and 10 failed

arch/arm/kvm/../../../virt/kvm/arm/arm.c: In function 'kvm_vcpu_first_run_init':
arch/arm/kvm/../../../virt/kvm/arm/arm.c:582:2: error: implicit
declaration of function 'kvm_arm_vcpu_init_debug'; did you mean
'kvm_arm_init_debug'? [-Werror=implicit-function-declaration]
  kvm_arm_vcpu_init_debug(vcpu);
  ^~~~~~~~~~~~~~~~~~~~~~~
  kvm_arm_init_debug
cc1: some warnings being treated as errors


steps to reproduce:
--------------------
#!/bin/sh

# TuxMake is a command line tool and Python library that provides
# portable and repeatable Linux kernel builds across a variety of
# architectures, toolchains, kernel configurations, and make targets.
#
# TuxMake supports the concept of runtimes.
# See https://docs.tuxmake.org/runtimes/, for that to work it requires
# that you install podman or docker on your system.
#
# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake
#
# See https://docs.tuxmake.org/ for complete documentation.


tuxmake --runtime podman --target-arch arm --toolchain gcc-8 --kconfig
axm55xx_defconfig

ref:
https://builds.tuxbuild.com/1sRT0HOyHnZ8N5ktJmaEcMIQZL0/


--
Linaro LKFT
https://lkft.linaro.org
