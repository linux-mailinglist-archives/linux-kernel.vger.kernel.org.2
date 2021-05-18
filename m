Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F27387573
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 11:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243508AbhERJrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 05:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241211AbhERJq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 05:46:59 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4CFC061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 02:45:41 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id lz27so13521360ejb.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 02:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+oqeCKfXv82JScb7czkuI4jlT3GFELCoxB29oxrX+A0=;
        b=UODTDDeQoU/FGbWm2WyozsDnYWpZ6FCKK6tmqI8b5MhtfXONiBI5+1Pmst92hBNNPt
         H4VH0TjkP6r/CBPL8FhCEOU/1aKJ1TZzS8uN4n0x3tgtNOG8ixpFQ/FCVTU0lyBH9H5d
         iXqxYAr1VDzHxoQR/olXH2InXbvejnSwTtihL+1gW/Rw4lRmyoNyJehoNHYAnHXEy0M7
         GWDolLF72tyOPKN0WviHS7qzAQKREHTvwZRzeg3yn7prVhLIKKE9k0AcKxGS7oolEc4p
         6cNTmD/TJ2m8enTohFyA1+AKHiGfAQSJaFqEu5j85ORQkpJVHfzshDg/PYUHiVZfN7+s
         xoTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+oqeCKfXv82JScb7czkuI4jlT3GFELCoxB29oxrX+A0=;
        b=IeAewUpYhWPQiA+1csNhdaNQY4mUrCyvQB/NOIkqFDX75RIZZ+GCdQh1sZCmLx1XeP
         xVG8kTEMvygskUAEku5Hg3/KgQ4m7+hCZN05/mOfm2mNh91HwYIaHjfA4RdD3j+is9lu
         Z5jtf4b0VjMcd5nDDomptWCAlwb41M/vEqwM6lI0eg88i+RMviflfiCZEp4Jq4Vgi7S1
         jIcv7L7JHs9jnS6wavI/9hPL70K1SUehIYTYO3EFd3QPEsHIHeUtFmLA80cTn33JTTZr
         a9GVA/1sSi/NrZgzFI7O6PAaPW+bw5HsERAN6866d3eqonhANs2Kat4r4TjzKofqy74x
         lZMw==
X-Gm-Message-State: AOAM530nncN2pP2hcnxRMLE3DGRtgjALpdUlCWVbcL7DAk1fKnlmlJ/Z
        gWoTyk1pkylaydSqiqIsElPPSgxpy9k7KquDlmaIOev/3rAwxR9H
X-Google-Smtp-Source: ABdhPJzQ7ATO2yRh0M7AqlfnoDtHYcLtEEj1Om/5GtLciWdQuJEb5qLvvhnhYEqraag/rAlJvvPBRDOxPxKVavqC8ks=
X-Received: by 2002:a17:906:c211:: with SMTP id d17mr5113796ejz.247.1621331140210;
 Tue, 18 May 2021 02:45:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210517140302.043055203@linuxfoundation.org>
In-Reply-To: <20210517140302.043055203@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 18 May 2021 15:15:28 +0530
Message-ID: <CA+G9fYu=Y4m9Q5QSgKC21JaXo5=_UVFmK17WOMr4H2ADwpWBZw@mail.gmail.com>
Subject: Re: [PATCH 5.11 000/329] 5.11.22-rc1 review
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

On Mon, 17 May 2021 at 19:34, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.11.22 release.
> There are 329 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 19 May 2021 14:02:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.11.22-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.11.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.11.22-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-5.11.y
* git commit: 6d09fa399bd51fced0a3ad760d2b28f3cfca1678
* git describe: v5.11.21-330-g6d09fa399bd5
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.11.y/build/v5.11=
.21-330-g6d09fa399bd5

## No regressions (compared to v5.11.21)


## Fixes (compared to v5.11.21)
* mips, build
  - clang-10-allnoconfig
  - clang-10-defconfig
  - clang-10-tinyconfig
  - clang-11-allnoconfig
  - clang-11-defconfig
  - clang-11-tinyconfig
  - clang-12-allnoconfig
  - clang-12-defconfig
  - clang-12-tinyconfig

## Test result summary
 total: 77570, pass: 64809, fail: 945, skip: 11208, xfail: 608,

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
* kselftest-android
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
