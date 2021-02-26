Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84BCA326013
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 10:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhBZJbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 04:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbhBZJ3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 04:29:11 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EB9C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 01:28:31 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id p2so10081484edm.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 01:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ikw82zKGlH8aAdOC5tkm4HrIRJXbA069HBPJV+fwmJ4=;
        b=vbv6w8323b60UCaA13z2PM/48T+4HYB2vQ0cbKzhx6wzjasKLh2c/wMDoVd/4HmTJg
         Iwt15CXmb9lKeUGzjy/zaRFmxRVZ2NmiL8YGqq/+tCmiaBeals42k9oZo6vZq532zNNy
         56Zv7TdqAPVeNiMkQPyvNZofrtpDEBoNZpZFNjCZDDLRCh517wT2c/H91sObtWxHKZ8d
         vpTsAJPdMAzMo+CcqnC3ZrriCREtUQB9NXTZSlrbKHCobVtxoHYza4XafW0Fz3ZlJhMw
         NJj/jP4RTh8SQwHxRsJCd4G6+j6tnphofbPYF/+suCQ+xRg0fDttKumwvaTI5hID6SRG
         qzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ikw82zKGlH8aAdOC5tkm4HrIRJXbA069HBPJV+fwmJ4=;
        b=TH5mnwCDwc/qww3NF5crDqcelmRTQZ/hbGr9aWl4cd4Z1VpTH3P1dxWuOyzeUhypB4
         Y5Fom6DCsdTjO2V3m3Gen0vjOQ4zL57htbclPjis2KuLISK9v5cFSnhed6cV/Oppzzze
         l/WgKNc4GIZb+pKhL0bgqH+UvLEhwe92irv3nGJ1MxMqdFGf7tbxvrAcXKGIVKLqW9tB
         NlDD4iHJpgK3h7kdNKgCSw/BKN9pRTjOY1yLUT/IdPBaMD4vBpZfx1B2mU51DVFfHhVk
         xE30ZPR5onZPYp6XHiWT0jXbXYlgXx1HkCR9wI3XR9YpiZxVRWH6MDhIEWwNoEfaVD25
         Bmxg==
X-Gm-Message-State: AOAM532+33m74MOSPs8tIv16RSLZXDX+01sZpTI2NDHw/rk5FU4uDUAy
        fwWd9hUmn+kRdYIXtVnKJTqTBSIK8ygFiHIuzDJ+7A==
X-Google-Smtp-Source: ABdhPJyU+iQl+XEcAxPwhEKIEaWX3ogIJpJdI2dH3ThxmxvcmQDCgg9SZPvxqVCNNZOkThq9/uGhcZj13qB48MzOiYQ=
X-Received: by 2002:aa7:cb0d:: with SMTP id s13mr2190198edt.221.1614331709840;
 Fri, 26 Feb 2021 01:28:29 -0800 (PST)
MIME-Version: 1.0
References: <20210225092515.001992375@linuxfoundation.org>
In-Reply-To: <20210225092515.001992375@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 26 Feb 2021 14:58:18 +0530
Message-ID: <CA+G9fYv1OQ07KqgKPMbZZEX6z+ARB-rbZmYZ9Jfq4C7HtTTg7A@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/17] 5.4.101-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>, patches@kernelci.org,
        lkft-triage@lists.linaro.org, Jon Hunter <jonathanh@nvidia.com>,
        linux-stable <stable@vger.kernel.org>, pavel@denx.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Feb 2021 at 15:26, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.101 release.
> There are 17 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 27 Feb 2021 09:25:06 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.101-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

Summary
------------------------------------------------------------------------

kernel: 5.4.101-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.4.y
git commit: 981a14c3f32577a8b2c1d21b17f134b14d41c89a
git describe: v5.4.100-18-g981a14c3f325
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.=
y/build/v5.4.100-18-g981a14c3f325

No regressions (compared to build v5.4.100)

No fixes (compared to build v5.4.100)


Ran 55957 total tests in the following environments and test suites.

Environments
--------------
- arc
- arm
- arm64
- dragonboard-410c
- hi6220-hikey
- i386
- juno-r2
- juno-r2-compat
- juno-r2-kasan
- mips
- nxp-ls2088
- nxp-ls2088-64k_page_size
- parisc
- powerpc
- qemu-arm-clang
- qemu-arm64-clang
- qemu-arm64-kasan
- qemu-x86_64-clang
- qemu-x86_64-kasan
- qemu-x86_64-kcsan
- qemu_arm
- qemu_arm64
- qemu_arm64-compat
- qemu_i386
- qemu_x86_64
- qemu_x86_64-compat
- riscv
- s390
- sh
- sparc
- x15
- x86
- x86-kasan
- x86_64

Test Suites
-----------
* build
* linux-log-parser
* igt-gpu-tools
* install-android-platform-tools-r2600
* kselftest-bpf
* kselftest-efivarfs
* kselftest-filesystems
* kselftest-firmware
* kselftest-fpu
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-ir
* kselftest-kcmp
* kselftest-kvm
* kselftest-lib
* kselftest-livepatch
* kselftest-lkdtm
* kselftest-membarrier
* kselftest-memfd
* kselftest-memory-hotplug
* kselftest-mincore
* kselftest-mount
* kselftest-mqueue
* kselftest-net
* kselftest-netfilter
* kselftest-nsfs
* kselftest-openat2
* kselftest-pid_namespace
* kselftest-pidfd
* kselftest-proc
* kselftest-pstore
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-splice
* kselftest-static_keys
* kselftest-sync
* kselftest-sysctl
* kselftest-tc-testing
* kselftest-timens
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-zram
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-controllers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-cve-tests
* ltp-fs-tests
* ltp-hugetlb-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-sched-tests
* ltp-syscalls-tests
* ltp-tracing-tests
* perf
* v4l2-compliance
* fwts
* kselftest-android
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kvm-unit-tests
* libhugetlbfs
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-ipc-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* network-basic-tests
* kselftest-kexec
* kselftest-vm
* kselftest-x86
* ltp-dio-tests
* ltp-io-tests
* ltp-open-posix-tests
* rcutorture

--=20
Linaro LKFT
https://lkft.linaro.org
