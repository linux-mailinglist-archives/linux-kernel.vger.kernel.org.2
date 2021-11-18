Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A0B4554B1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 07:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243309AbhKRGUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 01:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243301AbhKRGUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 01:20:33 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED00C061764
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 22:17:33 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id y12so22002688eda.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 22:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2Jgd/Uy9gtODKx1KtUIvf0F11hbP4Jy1x4tgEAPO2Ag=;
        b=nUSEXBVc11rBCtBD7x3GDqvBrXQo4CKDhYAd2w9Ptj3WCS/T8/tNSQ52nXpBiC5+hr
         A9woN8mVpcOVmPA+f0TLSka078BeypYAO+9wBv3tC0wGkwCHS0LmaRwBcDfGG1bYEl0g
         X4mi49p/RBBy9bqlp8qyz5e75pFwcTEB7YfViavDlBXi+C9H1KLW12MX63sdMcmIAIaE
         r435TVQC4PYHHDfEqaiPZag7+7wxUKMuqkt96hWxrgPbJY+8TgPb1mS6frDaVscjeKfI
         7PoblSYw/y5dyLxSRSiTFc6ghyERIOWtlrwvQ9kDWHtskIV98S3pMpKQ5rrvfzarhLqo
         aUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2Jgd/Uy9gtODKx1KtUIvf0F11hbP4Jy1x4tgEAPO2Ag=;
        b=ioAVJKmwbJ6xUv3pjv3bkhHdIh0+kBn2fMWRyKb4gou4aA7ssk7wezj8btHZ5vXq+N
         1mgznrTBU+t655YdadUlEVkt3vFxiNGQ9af6JRpm6ofMnR8A2VzpF7tglM2itkWiB+wP
         qNzb9PMkm4HQua73/OO7lh+3Tmzqvak00f2rDWy7t5DURKIhPCsE+JVhWJjkd7IXHk3c
         G9KWFqplo87sZ/NKj/DfLDKRnXc0phwcLQyck9pxnMWNEa6UP+CEbuqy1vt0OhH1TQZu
         5gnwdxYZWs83L+GA3NlUNGDk75nva6aNot0klCNMTlV1RVzUdlt8oKnKcSn/JNR+vgHN
         C7nQ==
X-Gm-Message-State: AOAM531mkzFPXJd7PCTlUZe8mpnGbg5eNa2sUuEuASR6Ei2+VbRUEDt2
        52HREtnuiir+UVdYKmqNVtyAbNI0ukjg5x+vsLyENQ==
X-Google-Smtp-Source: ABdhPJz5jXV9FDBEk4qJUbxvQpSDeAySuVhYuOB3OxjgG/lbBWVUwaxhu5X3K+zXJjQIZSyxGugAievmkFXtCmQ3ZZ0=
X-Received: by 2002:a17:906:489b:: with SMTP id v27mr29401117ejq.567.1637216251656;
 Wed, 17 Nov 2021 22:17:31 -0800 (PST)
MIME-Version: 1.0
References: <20211117144602.341592498@linuxfoundation.org>
In-Reply-To: <20211117144602.341592498@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 18 Nov 2021 11:47:20 +0530
Message-ID: <CA+G9fYv6gNNhtGtE5HC4e4M+kdb7gJKn1t6tC1mec3V0gJ2SZA@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/569] 5.10.80-rc4 review
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

On Wed, 17 Nov 2021 at 20:16, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.80 release.
> There are 569 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 19 Nov 2021 14:44:50 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.80-rc4.gz
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

NOTE:
Anders reported that,
The following warnings are still noticed on arm64 builds.
drivers/soc/tegra/pmc.c: In function 'tegra_powergate_power_up':
drivers/soc/tegra/pmc.c:726:1: warning: label 'powergate_off' defined
but not used [-Wunused-label]
  726 | powergate_off:
      | ^~~~~~~~~~~~~

If I cherry pick 19221e308302 ("soc/tegra: pmc: Fix imbalanced clock
disabling in error code path")
the warning goes away.

build link:
https://builds.tuxbuild.com/213DyYEZ9MU7o7yLjEn0sleNfM6/

## Build
* kernel: 5.10.80-rc4
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.10.y
* git commit: 087abd07310fe0fc9974a321f3e0918e63c4bd44
* git describe: v5.10.79-570-g087abd07310f
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.79-570-g087abd07310f

## No regressions (compared to v5.10.79-579-g739c1bb0c245)

## No fixes (compared to v5.10.79-579-g739c1bb0c245)

## Test result summary
total: 90167, pass: 76691, fail: 526, skip: 12152, xfail: 798

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 259 total, 259 passed, 0 failed
* arm64: 37 total, 37 passed, 0 failed
* dragonboard-410c: 1 total, 1 passed, 0 failed
* hi6220-hikey: 1 total, 1 passed, 0 failed
* i386: 36 total, 36 passed, 0 failed
* juno-r2: 1 total, 1 passed, 0 failed
* mips: 34 total, 34 passed, 0 failed
* parisc: 12 total, 12 passed, 0 failed
* powerpc: 54 total, 46 passed, 8 failed
* riscv: 24 total, 24 passed, 0 failed
* s390: 18 total, 18 passed, 0 failed
* sh: 24 total, 24 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x15: 1 total, 1 passed, 0 failed
* x86: 1 total, 1 passed, 0 failed
* x86_64: 37 total, 37 passed, 0 failed

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
* perf/Zstd-perf.data-compression
* rcutorture
* ssuite
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org
