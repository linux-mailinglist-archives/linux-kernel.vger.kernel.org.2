Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B36145D4A9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 07:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347014AbhKYGXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 01:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347270AbhKYGVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 01:21:54 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FE4C061757
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 22:18:43 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id z5so20968564edd.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 22:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WITUFjFeoRXXIk21nwQblVv59zXr2jMrNnG1DDq3GJk=;
        b=L3U/KB84dwjs6K2SclQ9UUSV3GNCyZeYrFNCf+ZpG7d6o56mevUubamlruF0xW7uyq
         cAvOzdbLopAxwZ30e/aEscW4x/Rdc2BkNcCUtX3UIDynQV4HDALJTnhwWcFb+Lg74nVw
         eUsKbQlKuLTX8VNlAcJr0XI75vl71QJzTrBZY3zpF4oRa8FYcKwjxdJ1M+kZvueO8EP7
         UA92cQ7BBg6WJTHcZ2t5y7//2/yvqNiC/XRwnLryRAqndor0fFnOnot/+JkXzvGRMox2
         gJ06D5SZbVh6c1DFW8F1YF9U0APMXmKctU9ptDnEOPY44aQ/eMPDvL+V6PP27AvBPmAf
         5Asw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WITUFjFeoRXXIk21nwQblVv59zXr2jMrNnG1DDq3GJk=;
        b=sMD+lsrB1h0ND5r8Ren95QNougkn7f3e/rEbRENIdGR/nFIbU+TPzncFVU2ypZnXnU
         jAcZ+I8sUDs7u56/AstC72JmWB3KbHS7S8nGbQhMxh3OGR06jisiEgJOredGfXstQXTp
         ATtAp94OEy6fN5lu7rG+oEq4Ib3ePp0uVYLDgkwMzhA4m4cFvP4VphpEraYVd8e4iwjF
         3CA7206la0pZzwYiDmFU7er3si6eRla0fKv4X+rIuHYC2I0PMYDiyjX//4KOv1kMSs7W
         4F/tjZwte6pgQ4+Ad4qbT1OWON9cyJj3e1Fzo5g/SKU+ivnQRtLKY1sHyjBhpvGiNGEJ
         d/Bw==
X-Gm-Message-State: AOAM533zFF7WYulhbJ71EeYh5kg8CwtL0kbOgWjSou+dE8YIvl9gzS91
        ZZTsutPvdokrUoOuPMSLNSc7lAONxCyPGXGYWbWr9kPoEdietg==
X-Google-Smtp-Source: ABdhPJzQs9Jt1no7hOxpl2MdpTlXZNDnTPc6AcTj+35SS9rxTwetNg6wF2u6kO0eOmQqNK1fzoPjD+81bXvGjvG7Uqo=
X-Received: by 2002:a05:6402:90c:: with SMTP id g12mr34789938edz.217.1637821121545;
 Wed, 24 Nov 2021 22:18:41 -0800 (PST)
MIME-Version: 1.0
References: <20211124115718.776172708@linuxfoundation.org>
In-Reply-To: <20211124115718.776172708@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 25 Nov 2021 11:48:30 +0530
Message-ID: <CA+G9fYu9-5Qwkd7bBapQcah=ZdtfgKmYxp9OKqhnnGwDWgzdvg@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/279] 5.15.5-rc1 review
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

On Wed, 24 Nov 2021 at 18:35, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.5 release.
> There are 279 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 26 Nov 2021 11:56:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.5-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.15.5-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: e3bb2e602026d5d841d7a2e62bfbe579265bb5ff
* git describe: v5.15.4-280-ge3bb2e602026
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.4-280-ge3bb2e602026

## No regressions (compared to v5.15.3)

## No fixes (compared to v5.15.3)

## Test result summary
total: 97214, pass: 82201, fail: 1196, skip: 13115, xfail: 702

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 259 total, 259 passed, 0 failed
* arm64: 37 total, 35 passed, 2 failed
* dragonboard-410c: 1 total, 1 passed, 0 failed
* hi6220-hikey: 1 total, 1 passed, 0 failed
* i386: 36 total, 36 passed, 0 failed
* juno-r2: 1 total, 1 passed, 0 failed
* mips: 34 total, 34 passed, 0 failed
* parisc: 12 total, 12 passed, 0 failed
* powerpc: 45 total, 42 passed, 3 failed
* riscv: 24 total, 24 passed, 0 failed
* s390: 18 total, 18 passed, 0 failed
* sh: 20 total, 20 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x15: 1 total, 1 passed, 0 failed
* x86: 1 total, 1 passed, 0 failed
* x86_64: 37 total, 37 passed, 0 failed

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
