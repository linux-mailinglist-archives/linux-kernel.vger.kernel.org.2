Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6EC3A12A7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239089AbhFIL23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:28:29 -0400
Received: from mail-ej1-f42.google.com ([209.85.218.42]:42823 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbhFIL22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:28:28 -0400
Received: by mail-ej1-f42.google.com with SMTP id k25so32416005eja.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 04:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TkAkxdDOuSWTWLSlpw124sm6Jp5NWZnhQZKvhZghRUM=;
        b=iBrWWiOZcNabkL6PBCZB23EtNaqCtJGJEGbdI6+Ql18J+BRzE5Trl/8TOnW28Vg65e
         lyCJBrvkdU5X2F9lpwNBBKLXsjm6VH48xKMBS+a1VXnfdrnxO3OiHW2PH/gcAzQNi2wx
         X43/eZX6Vh0kXB/j0HwSAhQhxAbbDKuXcS7wDo5wmtZjXMj8LnYHOB3899JzD0cs0TdY
         q1Ue4QgR70p9EoRPm5mUUUT0osHIA1VAd4qJMI6CDGEO2g8ZTQDLkab/sPSxMawqihjC
         67linbH5TmPHgXjuLC8JSTQkG5A4EGkVhfhe1EkcOKABm75tT9FqTlj44XEBbg0Ccsaj
         AcyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TkAkxdDOuSWTWLSlpw124sm6Jp5NWZnhQZKvhZghRUM=;
        b=VhO08QSH/1KRcC9x+vKpY1k0KBH1EGpyJCji2qb3sKs6ecgu9+AIyb9ROO+6jxJzo4
         XV6eUdTc9LITpt+2+UVIRoDLlT5xt6lB4ausyah4seUo+K6Hy0Fg8QDmxyw9azCs1w5X
         h9ZPb4iI48K1jLmuph07lSFNoLQinvpwcMrhIlvRGioam2Z/vQ++a4g69mF3eV87TAhI
         zlI3AI5VEmZIJPWgKgMAR4hZ8q5878fA+yJBFaiEifL0QoPy9XV6Oq19UamKYP3IkQT8
         YQw9AOEOt7tzdvlmSL+Lk3wQvwaAOljfyQgXrmhcch8kTcsLPtX4kXy7krhcTWZXPMMl
         CkRg==
X-Gm-Message-State: AOAM533d9lCMLtv6y+KpH7lDG1LO8OHjpEK5EvByITpIyy0DbbV8SFnm
        XdNOenaP/kTY5s7+Z2ysfOM+KVYKu2O+K1QdFLXIbw==
X-Google-Smtp-Source: ABdhPJwNcyurynImyMgnL5vfKz2hbXTJTCgHLbWcZqewFOKc6tdKR1bSchzVmr+P+Agyy0SsugQ6H6u4DFfCtWogoZc=
X-Received: by 2002:a17:906:d0da:: with SMTP id bq26mr29039010ejb.287.1623237932762;
 Wed, 09 Jun 2021 04:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210608175930.477274100@linuxfoundation.org>
In-Reply-To: <20210608175930.477274100@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 9 Jun 2021 16:55:21 +0530
Message-ID: <CA+G9fYtuRvpL=jw8EkNkP6U19udkV5U7=LRM6ctPJfU9R8-OLg@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/47] 4.14.236-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>, patches@kernelci.org,
        lkft-triage@lists.linaro.org, Jon Hunter <jonathanh@nvidia.com>,
        linux-stable <stable@vger.kernel.org>,
        Pavel Machek <pavel@denx.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jun 2021 at 00:01, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.236 release.
> There are 47 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 10 Jun 2021 17:59:18 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.236-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.14.236-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-4.14.y
* git commit: 872e045a48f87d3c4c6deaab477abd068fda46b3
* git describe: v4.14.235-48-g872e045a48f8
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14.y/build/v4.14=
.235-48-g872e045a48f8

## No regressions (compared to v4.14.235)


## No fixes (compared to v4.14.235)


## Test result summary
 total: 61694, pass: 48597, fail: 1298, skip: 10549, xfail: 1250,

## Build Summary
* arm: 97 total, 97 passed, 0 failed
* arm64: 24 total, 24 passed, 0 failed
* dragonboard-410c: 1 total, 1 passed, 0 failed
* hi6220-hikey: 1 total, 1 passed, 0 failed
* i386: 14 total, 14 passed, 0 failed
* juno-r2: 1 total, 1 passed, 0 failed
* mips: 36 total, 36 passed, 0 failed
* sparc: 9 total, 9 passed, 0 failed
* x15: 1 total, 1 passed, 0 failed
* x86: 1 total, 1 passed, 0 failed
* x86_64: 14 total, 14 passed, 0 failed

## Test suites summary
* fwts
* igt-gpu-tools
* install-android-platform-tools-r2600
* kselftest-android
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
* kselftest-vm
* kselftest-x86
* kselftest-zram
* kvm-unit-tests
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
