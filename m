Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8C7F45300A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 12:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbhKPLRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 06:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234617AbhKPLRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 06:17:14 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45812C061746
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 03:14:17 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id y13so11156918edd.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 03:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5JW/MMbMxa+KIJp1B3HffAHon1NPs382FvX6wG2A9ns=;
        b=JqJhqGtXZCflYWXzN8utW0ydJ0qP1Osq37Z7drojv3IDTefKa2xOoH1q/yX707syz7
         PsjKTkLi+2KPVEzVs0X/vh50bnlBNkK0k93MJ2I1ct5nfCni4k++yPZfKKbTDO4kH3C4
         gqClCGEHC0BapWrwfrK0O/BUlRX8RpB2nW+f8TqTCVf0JlylU5+yK+DYz7sEyRrdoC1z
         bkgXocfFbMogpPSQRdoCBW3k5pluTAgNc0zIoBsnTgY4aKzrFLHuE8EFKH+jpzGunBx+
         XUCtmQpZYcRbYBLK4rhHDm+/4xzPKsB7/Nz0/9bK5ky7hvE2yvrVjQ/wp2Fe7tAcQWZp
         hYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5JW/MMbMxa+KIJp1B3HffAHon1NPs382FvX6wG2A9ns=;
        b=719AiaD6GfbL6JHIVbYivg7M2dofK6Jmep8g3eqxulEJTLOWb3vuOfihTG4SV6jdNz
         QRXmBdOXyDKvNkyChz/OrZallZnTcX8/X3/w/7S89WbUD5k1W9pQX088cu7PUjye7nQ2
         RWAMYl1fKqn9LT3F9/y/Q3r2+htQo6hD/9IKbqrb8cfsRxnP+jtRDJYQl30XPl2txHtz
         0lQWc1dEaFjrpk5DYFeqhYgc7m9oJ4ZO8fmvAMoNnWjynHRzQT/3VuWDK7i4POTPFI4i
         +CnRBEWe/FjMY73I+7dTJYCcqHjSX2KOqt+QHPDXE8sna2OSQ5fMSL8ATyVs0Rbd6DCJ
         kjfA==
X-Gm-Message-State: AOAM531rzT0Vs/Dg80FJvoYuhT5OxJ0vd/QO/XsbGv6lRg+yyj++3TWq
        /38lyS/UT6wwRmYls+QTwM/KiVHZouNsuJQQiiKHow==
X-Google-Smtp-Source: ABdhPJwlNJxWgN6oRKBIOdXF3kUernh7P+fI+mFWPDGFB9BJvE6wnOmIsqaADWku58xboPDUWGgRgISvMiaZgQqya80=
X-Received: by 2002:a17:906:c302:: with SMTP id s2mr8914943ejz.499.1637061255166;
 Tue, 16 Nov 2021 03:14:15 -0800 (PST)
MIME-Version: 1.0
References: <20211115165343.579890274@linuxfoundation.org>
In-Reply-To: <20211115165343.579890274@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 16 Nov 2021 16:44:03 +0530
Message-ID: <CA+G9fYsCAUBowNeYmj_L9K1bGWziJJp5UJvtUSd1Lj0d4LR=qw@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/575] 5.10.80-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        f.fainelli@gmail.com, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        stable@vger.kernel.org, pavel@denx.de, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, linux@roeck-us.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Nov 2021 at 22:54, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.80 release.
> There are 575 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 17 Nov 2021 16:52:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.80-rc1.gz
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

## Build
* kernel: 5.10.80-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-5.10.y
* git commit: 5c7cb5c1520316c728b44f31c1bd6b22942a0b18
* git describe: v5.10.79-576-g5c7cb5c15203
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.79-576-g5c7cb5c15203

## No regressions (compared to v5.10.79-126-g498eb27d1093)

## No fixes (compared to v5.10.79-126-g498eb27d1093)

## Test result summary
total: 92721, pass: 78619, fail: 559, skip: 12582, xfail: 961

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 290 total, 290 passed, 0 failed
* arm64: 40 total, 40 passed, 0 failed
* dragonboard-410c: 1 total, 1 passed, 0 failed
* hi6220-hikey: 1 total, 1 passed, 0 failed
* i386: 39 total, 39 passed, 0 failed
* juno-r2: 1 total, 1 passed, 0 failed
* mips: 37 total, 37 passed, 0 failed
* parisc: 12 total, 12 passed, 0 failed
* powerpc: 54 total, 46 passed, 8 failed
* riscv: 24 total, 24 passed, 0 failed
* s390: 18 total, 18 passed, 0 failed
* sh: 24 total, 24 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x15: 1 total, 1 passed, 0 failed
* x86: 1 total, 1 passed, 0 failed
* x86_64: 40 total, 40 passed, 0 failed

## Test suites summary
* fwts
* igt-gpu-tools
* kselftest-android
* kselftest-arm64
* kselftest-arm64/arm64.btitest.bti_c_func
* kselftest-arm64/arm64.btitest.bti_j_func
* kselftest-arm64/arm64.btitest.bti_jc_func
* kselftest-arm64/arm64.btitest.bti_none_func
* kselftest-arm64/arm64.btitest.nohint_func
* kselftest-arm64/arm64.btitest.paciasp_func
* kselftest-arm64/arm64.nobtitest.bti_c_func
* kselftest-arm64/arm64.nobtitest.bti_j_func
* kselftest-arm64/arm64.nobtitest.bti_jc_func
* kselftest-arm64/arm64.nobtitest.bti_none_func
* kselftest-arm64/arm64.nobtitest.nohint_func
* kselftest-arm64/arm64.nobtitest.paciasp_func
* kselftest-bpf
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-drivers
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
* kselftest-kexec
* kselftest-kvm
* kselftest-lib
* kselftest-livepatch
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
* kselftest-vm
* kselftest-x86
* kselftest-zram
* kunit
* kvm-unit-tests
* libgpiod
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-controllers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-tracing-tests
* network-basic-tests
* packetdrill
* perf
* rcutorture
* ssuite
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org
