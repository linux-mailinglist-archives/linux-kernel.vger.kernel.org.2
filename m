Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A593D87F7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 08:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbhG1GdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 02:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbhG1GdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 02:33:04 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B326EC061760
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 23:33:03 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id hp25so2747218ejc.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 23:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Wzc1VnWHuUTL1zDY7Wja81vShQG20UXdvo++bBOFt18=;
        b=eSlphBKjoCEojoPpl4MgfJpe2xwXV+oBLk5fPYjfS4ANMInn09pRJzt8hZoLgNAAXF
         dSM9OeTCvbb9/bUfk2+oWwvWyfTyzBoOgTbYKp++M8H5lFSVH/kjtTgo4+aAh27Tmlz9
         gyiXLq0avTmn/qL/6CkqLsp/vmZmyGRoLOdbISMMRifmzTqxiOcaSL6VFWj4IjUPjPia
         bY/Bzl+MO8hTABIUnEJgH8gdaeQCdQu5G3HdpSQXPOozXB3y3ixDEl9xnTpCTWvuaWdM
         KYZbpiDSB58z/ymj91Goo0M8uFNekqnJAjwAZHbf+KpJPyfnV+IQAO0KdG/Y8CU4dzL4
         fc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Wzc1VnWHuUTL1zDY7Wja81vShQG20UXdvo++bBOFt18=;
        b=Azfcof9Ji+Q3Yjqa09l7KqWf9dDg011ti2QAhHJb2DZYVSoY0cZpsGrB+B0hjeda4O
         a6x5z1mLmW4wOLYZTdi35Sx32zIrpAecFaH6FtmmTtKxn9v6+d6kr8EP1jwo8l0mcUUy
         xV3h4/LAr+lwCs3z2OuAD5/DF8VMKr32vKSqKbIRNGckGiQolZZKvwodxu5pw/pA2Men
         8+Jt9xCZseayYCcHZ3bqXXYiacs6b8AOTibE2uV1yLKS8+heZV9/N7DUdJAJvlvXg3/s
         efJCWUSsrfNPMCGB724eMFnB/siSYVnQ22s5mcys9B1CsL7KKj6YMU1AGQrUdXnHxt/R
         EPSg==
X-Gm-Message-State: AOAM532D/VTjZdrhwmstU27q4rD220Piry3VlKVk+ZDVEek42B5qjFil
        a5Cpbjg1IUU82KTHdp7Gvn4khAUAuQUzpPKRBf0Fzw==
X-Google-Smtp-Source: ABdhPJwsPWx52W9lF9EL7VtL/9QNrXcvB+NloPfgw+S9Oh/ua9A0L3WpqGTnG2xP5tD3u1rrVTNya5tHNMJmiNK0Lhs=
X-Received: by 2002:a17:906:45b:: with SMTP id e27mr17141033eja.375.1627453982188;
 Tue, 27 Jul 2021 23:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210727112108.341674321@linuxfoundation.org>
In-Reply-To: <20210727112108.341674321@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 28 Jul 2021 12:02:51 +0530
Message-ID: <CA+G9fYsb0QzEqGxdVErL-FTz1OTSLHE+-s6aW5MT6BmKu7V+RQ@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/119] 4.19.199-rc3 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org, Pavel Machek <pavel@denx.de>,
        Jon Hunter <jonathanh@nvidia.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2021 at 16:51, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.199 release.
> There are 119 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 29 Jul 2021 11:20:50 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.199-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.19.199-rc3
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-4.19.y
* git commit: b72fc3c0016d5ba671bf6e5ee31852a03d8c3a0d
* git describe: v4.19.198-120-gb72fc3c0016d
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19=
.198-120-gb72fc3c0016d

## No regressions (compared to v4.19.198-121-g85cf6e2446d4)

## No fixes (compared to v4.19.198-121-g85cf6e2446d4)

## Test result summary
 total: 77363, pass: 59814, fail: 1889, skip: 13309, xfail: 2351,

## Build Summary
* arm: 97 total, 97 passed, 0 failed
* arm64: 25 total, 25 passed, 0 failed
* dragonboard-410c: 1 total, 1 passed, 0 failed
* hi6220-hikey: 1 total, 1 passed, 0 failed
* i386: 14 total, 14 passed, 0 failed
* juno-r2: 1 total, 1 passed, 0 failed
* mips: 39 total, 39 passed, 0 failed
* s390: 9 total, 9 passed, 0 failed
* sparc: 9 total, 9 passed, 0 failed
* x15: 1 total, 1 passed, 0 failed
* x86: 1 total, 1 passed, 0 failed
* x86_64: 15 total, 15 passed, 0 failed

## Test suites summary
* fwts
* igt-gpu-tools
* install-android-platform-tools-r2600
* kselftest-
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
* kselftest-vsyscall-mode-native-
* kselftest-vsyscall-mode-none-
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
