Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E1442AE6D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 23:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235135AbhJLVEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 17:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbhJLVEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 17:04:05 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF3AC061745
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 14:02:02 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id p13so1521092edw.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 14:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SY4XwXrS0d1j8zvhoPNL9r+ZDepZwcOx38jO/MlU6nI=;
        b=U0B0DVY6a0gZJD1WGDZAMKfDjsFDtyHnlnpVmyA/Hl+/yCFLztZl+EjUCqguz+8lA/
         82maQmUQ4uLQfM4UzGfqRgayTPl80iBnOHX+cJiFyOX5SHFyGNYKGcrynY9jBBv6BzQp
         /tD+ns8QYaNeDIVRYi/w52wViQGks53YCpBqNZ61EFPlKGK2LNgw2Jmk9hZQhOYKtYDi
         ECKf51nIbBZeoYIPTQykAOWLc7x0/KdoPTrC5i8s8cIKteVrRTwPjvXC9iJ6nOwIHQRQ
         nKBy+1Lol8midgL/8xpMvt0k3afy2akgPGtDqND9Dktg0y/Af2X6XZn0lVa2NLo5cupF
         2TQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SY4XwXrS0d1j8zvhoPNL9r+ZDepZwcOx38jO/MlU6nI=;
        b=c+jGAsFB+p592uljl9n3Dger/4cjXdTM4yfPwRfkaxfCP+cwHhxTFlq7SMnWY1Cpfw
         xibVWncuakGCVZ4c0HkGS1cokcKuLrFO1OEkhA837bbGwZsxgQDux+GYGh7LSBUHPjTY
         sJA6xCA/M9Ze+mBTeWlkdjJc+1UFF01dtknJoZ/Dn3g/1B0VvN4EpqJksZGiGzHh1z+l
         fDRlM0CBDMZtjfxf3CLRrdkVTjJAlVoICBEbL5zHWo3TTru46Pt5CMCchnTcRc13GZ/W
         6gIIx2sVUlq69gRVWoPezOHeJWXyh+U0GccmYCvwIPMmYuzD/fkEXQ+FMqXqQuxrJhZM
         l15Q==
X-Gm-Message-State: AOAM531id4UBLw1/G3vFXPW0H11Ogi1PrH/lTc4+qX5mRp5pm/xUsk3R
        vEEFSKIrtrhocXM/thK8Hpf2MdvzM8EIDwtOkZjJ/g==
X-Google-Smtp-Source: ABdhPJx8d0eoZDTxnlRZYFO7YV9JgQ/67lLGSbIWXJiHP1HUg6E10/geTDqDLR5SYGa9oqx/oWIbZX+oB2TfXxtAYfA=
X-Received: by 2002:a17:906:4f96:: with SMTP id o22mr35820368eju.169.1634072521287;
 Tue, 12 Oct 2021 14:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <20211012093344.002301190@linuxfoundation.org>
In-Reply-To: <20211012093344.002301190@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 13 Oct 2021 02:31:49 +0530
Message-ID: <CA+G9fYvVdhRm+8oz5VGvMRaRh52RoMsQoftGHe88ocg4HjeTrw@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/51] 5.4.153-rc3 review
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

On Tue, 12 Oct 2021 at 15:07, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.153 release.
> There are 51 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 14 Oct 2021 09:33:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.153-rc3.gz
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
* kernel: 5.4.153-rc3
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.4.y
* git commit: c20820e7fdeabc34e2ebe5e74d37c8dfefe6ce27
* git describe: v5.4.152-52-gc20820e7fdea
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.1=
52-52-gc20820e7fdea

## No regressions (compared to v5.4.152-53-g2a225aa681c5)

## No fixes (compared to v5.4.152-53-g2a225aa681c5)

## Test result summary
total: 86252, pass: 70969, fail: 764, skip: 13351, xfail: 1168

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 288 total, 288 passed, 0 failed
* arm64: 38 total, 38 passed, 0 failed
* dragonboard-410c: 1 total, 1 passed, 0 failed
* hi6220-hikey: 1 total, 1 passed, 0 failed
* i386: 19 total, 19 passed, 0 failed
* juno-r2: 1 total, 1 passed, 0 failed
* mips: 39 total, 39 passed, 0 failed
* parisc: 12 total, 12 passed, 0 failed
* powerpc: 36 total, 36 passed, 0 failed
* riscv: 30 total, 30 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 24 total, 24 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x15: 1 total, 1 passed, 0 failed
* x86: 1 total, 1 passed, 0 failed
* x86_64: 38 total, 38 passed, 0 failed

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
