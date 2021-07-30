Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4B53DB4A4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 09:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237921AbhG3Hn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 03:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237783AbhG3Hnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 03:43:53 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCC7C061765
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 00:43:47 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id gs8so15123509ejc.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 00:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XNb1vdDFyUaitEth7U9Mw3bRVjScfkX4yuNTGRHOOZI=;
        b=WOMkP1gUuGLYiBgd6mH86nsLknzRL5bXpAPNk/5UwcXfcZ9EQv9MRr0f+D9hGjPlks
         bgrCF827NmTWYILTDg23M0IKQHIjQ4aXkX8EuXYFUDMbRjztqs5FJozIxBGLZYiVH/rf
         oyoOnV5A5N2c9Dyx6fFvtnNuLy3GGahc8bfdgY7VKafbsk+ct6Dif/g+2KeKF1Pz7G2o
         dZRGDHaGQ3Ohe2rDDlR2odQiTGOFY4P0vLRglEYx/RvIszvla7R+DKNuw91Lsa/HED+p
         XzH2AClE0grQhthEAL+ZGYS2I18RLx4moNnKcDUKjLlCe4tcd3RDmhBJTYrTdjFrQbj1
         o6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XNb1vdDFyUaitEth7U9Mw3bRVjScfkX4yuNTGRHOOZI=;
        b=ovC46G2KYwk5aOneZhBTwUOusDwHWbalxYhg2NfG5vhX/gyZGy4AEafBEGMNZfMvOR
         7MoPspULsZDbp1d1NdbVW7+kNG3J3zpC6SofwSzfoGh8vq+K4iLVfVSGmFGNEj6JUVHK
         U0/qhar884xg3IViDUvoREaOc5RJVNQl4+e6dxSI0PQ2CqdTISkB90ynESv2Mtg7o8cq
         ncxCagN3aPf+6GNStrya0PbZjD82QeUVc4oi68kG9x6UzhCGowt8dpyUPqoaM95Ddb7H
         FZjcysUqmwnUu6/mfbLNU085beEJxpYZSBcIud1+XdtLgELLwM/WxLUkz0zYmbyTXF7w
         +iRg==
X-Gm-Message-State: AOAM530VX/6KNvkMmTYa0dCyi7ZDfQ5ouHCpEIsdY8882cdCGS+4H5aT
        UqcjyDmDI6XFUCOK7tFuXTubbuqgRwYLjEAiHfzLBQ==
X-Google-Smtp-Source: ABdhPJyjd5Ruhtz7xbinzt2RW6nVODmDy6NaOTTXBdA0vGpDB2dMCIucBKKENRmccDApb7FWHODHlJL2DcsTdYbsGsw=
X-Received: by 2002:a17:906:c447:: with SMTP id ck7mr1354289ejb.18.1627631025894;
 Fri, 30 Jul 2021 00:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210729135142.920143237@linuxfoundation.org>
In-Reply-To: <20210729135142.920143237@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 30 Jul 2021 13:13:34 +0530
Message-ID: <CA+G9fYvazOLwch-JupVP6uhAYYdMuYpfgWAEYVyipmUsUqCasQ@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/21] 5.4.137-rc1 review
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

On Thu, 29 Jul 2021 at 19:28, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.137 release.
> There are 21 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 31 Jul 2021 13:51:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.137-rc1.gz
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

## Build
* kernel: 5.4.137-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-5.4.y
* git commit: f73de39e1fb7b0cbd29bf959b3a305eca0e182e7
* git describe: v5.4.136-22-gf73de39e1fb7
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.1=
36-22-gf73de39e1fb7

## No regressions (compared to v5.4.135-109-g77cfe86f3223)

## No fixes (compared to v5.4.135-109-g77cfe86f3223)


## Test result summary
 total: 76416, pass: 61164, fail: 1313, skip: 12522, xfail: 1417,

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 192 total, 192 passed, 0 failed
* arm64: 26 total, 26 passed, 0 failed
* dragonboard-410c: 1 total, 1 passed, 0 failed
* hi6220-hikey: 1 total, 1 passed, 0 failed
* i386: 15 total, 15 passed, 0 failed
* juno-r2: 1 total, 1 passed, 0 failed
* mips: 45 total, 45 passed, 0 failed
* parisc: 9 total, 9 passed, 0 failed
* powerpc: 27 total, 27 passed, 0 failed
* riscv: 21 total, 21 passed, 0 failed
* s390: 9 total, 9 passed, 0 failed
* sh: 18 total, 18 passed, 0 failed
* sparc: 9 total, 9 passed, 0 failed
* x15: 1 total, 1 passed, 0 failed
* x86: 1 total, 1 passed, 0 failed
* x86_64: 26 total, 26 passed, 0 failed

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
* kselftest-x86
* kselftest-zram
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
