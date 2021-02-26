Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58385325DCA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 08:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhBZG6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 01:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhBZG62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 01:58:28 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DA7C061756
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 22:57:48 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id mm21so12676443ejb.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 22:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wi5VvusttMA+MBJc6HO2q4L5QyU7/Qv6UujnAJKL9O0=;
        b=zbtG7psKY8lRiuxSMgC9zhmX4FA/XNFL0jHBQqFqEWiFH9KmSEhuMeXY+eCGgTQwmc
         aW6//kQ0iDCnaBLlFvTVGRUgLa9cdAFfQX4Y1i2h8NQbFGNOZ5MIlsWdFi6JRnALV7ll
         2grGRxV0kzRFyZgxLHZtK/MThLjLRMTvrG8huvquEjVt4lUnMEmWkHPWjGj5KHadwzgF
         fm+WOpEyTMbkroYThb8GPULiifHYI6PqVx+Z8yLNcaa9Tvh2Ja/+BX2+NFp5hV7/Pr79
         sJidgcHFanFZbZjVDhN+T4+k4UuMjCVcTMOutQln26d9Nz18d3KAVlysgf56/NUVubbu
         2Ptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wi5VvusttMA+MBJc6HO2q4L5QyU7/Qv6UujnAJKL9O0=;
        b=PtBy+2NyA+oB+Tg5/GeToV8URoav0LGBFlH/HL+/xG8VqutP1406u1YTBj7ouo3OId
         /WVyfs6c6a6wzHJGqFqzbyVf+EpdRcrt9+NUnBDayEUIQFGSDmESZ36IGdFTVIh8kC8U
         sK4Lyn/dy+g7RmVj98OQND4zTAJMBHN2k0mp/LxmtE1hCqxvvMWU/zTjUDWEhfSo3QZ/
         K6RD44d9VTrAZuu+Vdru5vCxBhQKq2x+bGg1Tg67bvR5k4TdzgydQa6iS5bA8q+npZWh
         E2SaAwwwgAon9lcc02hXVD0NdDdUyxOF2SlSvcchhm50IuDXD93Xp9hewxjgdsalpI1I
         o5/g==
X-Gm-Message-State: AOAM531E6WuB29aR3vOn/a2WznsNLI2rBbDlAIpn0AxLXLeWUj8KiiPZ
        DU+eqRF4oirOOWl+lw0nEaWiTfo5ZkifScp7y+xVYg==
X-Google-Smtp-Source: ABdhPJwnAD2bUrzQtrQaKtFeCtX+RBV1M0kWnGUI+CnMF8p/QvgY2AsRYmeSsORVXZBLDQ10oxyZD1vqebHzy8EtAPM=
X-Received: by 2002:a17:906:a896:: with SMTP id ha22mr1692415ejb.503.1614322660679;
 Thu, 25 Feb 2021 22:57:40 -0800 (PST)
MIME-Version: 1.0
References: <20210225092516.531932232@linuxfoundation.org>
In-Reply-To: <20210225092516.531932232@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 26 Feb 2021 12:27:29 +0530
Message-ID: <CA+G9fYs2y7WcvZ1DTRkTNy3pzYAz0k+HeRS4XFhZTF4x9JKMVQ@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/23] 5.10.19-rc1 review
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

On Thu, 25 Feb 2021 at 15:24, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.19 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 27 Feb 2021 09:25:06 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.19-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.10.y
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

kernel: 5.10.19-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.10.y
git commit: 6ffb943c0e01d843a06842f9a7bcfc008e10a6d2
git describe: v5.10.18-24-g6ffb943c0e01
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10=
.y/build/v5.10.18-24-g6ffb943c0e01

No regressions (compared to build v5.10.18)

No fixes (compared to build v5.10.18)

Ran 50352 total tests in the following environments and test suites.

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
* install-android-platform-tools-r2600
* kselftest-android
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
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
* kselftest-livepatch
* kselftest-ptrace
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-cve-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-tracing-tests
* fwts
* kselftest-
* kselftest-kvm
* kselftest-lib
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
* ltp-dio-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-mm-tests
* network-basic-tests
* perf
* kselftest-bpf
* kselftest-kexec
* kselftest-lkdtm
* kselftest-timens
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-vm
* kselftest-x86
* kselftest-zram
* ltp-controllers-tests
* ltp-open-posix-tests
* v4l2-compliance
* kvm-unit-tests
* kunit
* rcutorture
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
