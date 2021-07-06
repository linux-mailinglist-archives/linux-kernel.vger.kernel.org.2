Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8E03BC5CD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 06:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhGFEzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 00:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhGFEzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 00:55:24 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8949C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 21:52:45 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id j11so26182109edq.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 21:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D/eej8vbwviU04q4fS0jX/CNEpMOA9iWE2FiJXiWWk8=;
        b=pTtExl3W3H+bGihHW6HDvhnwU1XGxjPOTeU6jv/v1mJB/GeN5qFyJ0Bvx92sgrtQ+r
         +ibOq3U7ft71GpDHTsG1huDoYJ/xl2tDOX/N3f5LHbB2eb2DN11jm0oMKEXTO2n5yXRk
         hmytvQFkg6h+uQavTkauuOBbKZelrNi1CIak15i8FOYaPsHvOk0OuIT2+pX31CaBC0wk
         qyP68xAZkCraeHsqCTS2DglEw34mYZVqrJUsNHKc18T6dyinET5qBHXC8cXJ8DIpB93v
         rup+zJ9b5ShuRwM2XdpA5ghVGZ642r9xzDMAWBjjfs4taJ79/a4XOSFGppCQLhqghW/k
         pXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D/eej8vbwviU04q4fS0jX/CNEpMOA9iWE2FiJXiWWk8=;
        b=gv3OFIyG4lhD4ALB/U/hw81RxET/DMr5QNQOpYGY3A/k4AXBGLaSzeizPdpunC6Y4K
         kygXTVSLI5mCI2Lo8DxsRD/xfDg5FiB+3mJ+Ut43yll5lj5BeTb8qJdRHn7QUdeob6wc
         ITwIGfUyzP0mYc4CXiZJhrIjvcpAJ2tX9g+V9JOIuUZzNzX1i0JhXEzxCr/wjctkJ2yE
         M2eZL+IYWid7x0gOtYLX2dxyFgNy9cwRyL9fC1HUHOLhoxTGwofgoKtrpObZaDFHuPTz
         yuDypQx3nIoJv3ollbn/MITPNNc5jD0ys/B0ANdJ443hlPZF1R5eTKwGYhqKO63zmuL/
         o4ow==
X-Gm-Message-State: AOAM532jOHq8BAo3WU9xXhOs2WiVwBVe86xYEjAA1FNqr48nDQhKr0tF
        lMujZjJBRVTzohKlQEk1E9GPGaKriZCBMjZa0Hnrvg==
X-Google-Smtp-Source: ABdhPJwy3qXdeQ6rTWLlIrQNetzYkvxUm1IWtnoMHdPxqxY5bgVr+8kQiOSTzaOy3jcklZLCfSqfWyRq7UJrMPpDpYg=
X-Received: by 2002:a05:6402:1e8e:: with SMTP id f14mr7523534edf.52.1625547164284;
 Mon, 05 Jul 2021 21:52:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210705105934.1513188-1-sashal@kernel.org>
In-Reply-To: <20210705105934.1513188-1-sashal@kernel.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 6 Jul 2021 10:22:33 +0530
Message-ID: <CA+G9fYsjk-F8YzbdkTZr71nPWqCC02dBLVgaLZbMie8+bgfLAQ@mail.gmail.com>
Subject: Re: [PATCH 5.12 0/7] 5.12.15-rc1 review
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jul 2021 at 16:29, Sasha Levin <sashal@kernel.org> wrote:
>
>
> This is the start of the stable review cycle for the 5.12.15 release.
> There are 7 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed 07 Jul 2021 10:59:20 AM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git/patch/?id=3Dlinux-5.12.y&id2=3Dv5.12.14
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.12.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.12.15-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-5.12.y
* git commit: b9d039f0f2f2c67492e003b60d5bebb6efc4c40b
* git describe: v5.12.14-7-gb9d039f0f2f2
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.12.y/build/v5.12=
.14-7-gb9d039f0f2f2

## No regressions (compared to v5.12.14)

## No fixes (compared to v5.12.14)

## Test result summary
 total: 84116, pass: 68959, fail: 1982, skip: 11980, xfail: 1195,

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 193 total, 193 passed, 0 failed
* arm64: 27 total, 27 passed, 0 failed
* dragonboard-410c: 1 total, 1 passed, 0 failed
* hi6220-hikey: 1 total, 1 passed, 0 failed
* i386: 26 total, 26 passed, 0 failed
* juno-r2: 1 total, 1 passed, 0 failed
* mips: 45 total, 45 passed, 0 failed
* parisc: 9 total, 9 passed, 0 failed
* powerpc: 27 total, 27 passed, 0 failed
* riscv: 21 total, 21 passed, 0 failed
* s390: 18 total, 18 passed, 0 failed
* sh: 18 total, 18 passed, 0 failed
* sparc: 9 total, 9 passed, 0 failed
* x15: 1 total, 0 passed, 1 failed
* x86: 1 total, 1 passed, 0 failed
* x86_64: 27 total, 27 passed, 0 failed

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
