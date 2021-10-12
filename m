Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA1F42AB93
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 20:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhJLSId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 14:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233324AbhJLSIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 14:08:11 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BCFC061745
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:06:09 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g10so2822117edj.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hWo11OYPx2feNS+jDPVo6X/YTvO7eTMf/xVCh3NXBxY=;
        b=pucLlfo3nzxaa/jnU7aKxXGJ1hHRTvopZf7vSxpwGm/68DwdfjqmOEUyOCirlN0Eqi
         4ICQDarOtuE+f5Elf64W6FCeSlbh9ibgBxDX9i5ZPn5ZovYYFsA+y7KFiIHhRywzKn6y
         mIlqkivvESfzC0th3IukuVzDRhBsf5xPLQDYHnzShArytmJB37LBqrU636HzxLB/SjWV
         7CRFqXqt0ZEoph/7zVwT35IcUsA7fpAZHXObJGwkdoFiLFXSk//L3AlfCrky5bri1kNL
         B45T8QUcKLBhNVZy5k3HwNHo0Yuq3GUN2HlcE4UpEzyMJniGimGzq6DpQFN4Oo3jIym+
         2Ptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hWo11OYPx2feNS+jDPVo6X/YTvO7eTMf/xVCh3NXBxY=;
        b=fG/at2EloesxQpkY4log6tUNDoH+9kWSrKIfLX5y5KZMCR+FmIUOiHCCTp7z3PW/Ia
         2ImHa08HHM6T9x52UJVslgh5kv2BgNT5pfUIqfFM1CoNHqXRrkHBQJZDN/wI75BGmvgH
         DXTGhGk1qzPjeZi18jK1YfienzveCPVnp/vS9F8vmAzclhKRScEmMKepJhrFTbDaea9M
         i1Qr8SzEFAuGQwEDyutUwiFL9gFca9fhZ8xJ2DNI6F71VSsah1fAWR5/m8pJqQlZsNvu
         ZhoODUnj1PeiVCF75tK8W3ilHbupK8MrDcYiu1k8vWPz2iiAG5Ly/tSDrxVxe8bgKB9O
         7iWQ==
X-Gm-Message-State: AOAM533I57M6B+kjpr8UlPpyGdXgaQrSDCzTsVOoIeGmlDQUIjBD6IZ9
        RCuoYGHkj1wEiKtbn56/++T2IUy9qjsFkHL9J/5aXA==
X-Google-Smtp-Source: ABdhPJxjdWSJDeRldG8uVMNNqwnOvuZ2+sF4DzCt4DkEsLflZi5ma3jBM3Z5u/69dHAsOXI0hM+3ewiPiRp5hmnRTRU=
X-Received: by 2002:a50:e184:: with SMTP id k4mr1707651edl.217.1634061935351;
 Tue, 12 Oct 2021 11:05:35 -0700 (PDT)
MIME-Version: 1.0
References: <20211012093348.134236881@linuxfoundation.org>
In-Reply-To: <20211012093348.134236881@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 12 Oct 2021 23:35:23 +0530
Message-ID: <CA+G9fYtGe44TSKNcWjn-kjm6UD6pPau2zn_-XFScatqxSL+ubA@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/81] 5.10.73-rc3 review
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

On Tue, 12 Oct 2021 at 15:07, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.73 release.
> There are 81 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 14 Oct 2021 09:33:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.73-rc3.gz
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
* kernel: 5.10.73-rc3
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.10.y
* git commit: 29e0360ee4fccd2090a04f1a772a23a9ab01326b
* git describe: v5.10.72-82-g29e0360ee4fc
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.72-82-g29e0360ee4fc

## No regressions (compared to v5.10.72-83-g0d59553e5bda)

## No fixes (compared to v5.10.72-83-g0d59553e5bda)

## Test result summary
total: 85643, pass: 72733, fail: 511, skip: 11583, xfail: 816

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 289 total, 289 passed, 0 failed
* arm64: 39 total, 39 passed, 0 failed
* dragonboard-410c: 1 total, 1 passed, 0 failed
* hi6220-hikey: 1 total, 1 passed, 0 failed
* i386: 38 total, 38 passed, 0 failed
* juno-r2: 1 total, 1 passed, 0 failed
* mips: 39 total, 39 passed, 0 failed
* parisc: 12 total, 12 passed, 0 failed
* powerpc: 36 total, 36 passed, 0 failed
* riscv: 30 total, 30 passed, 0 failed
* s390: 18 total, 18 passed, 0 failed
* sh: 24 total, 24 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x15: 1 total, 1 passed, 0 failed
* x86: 1 total, 1 passed, 0 failed
* x86_64: 39 total, 39 passed, 0 failed

## Test suites summary
* fwts
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
