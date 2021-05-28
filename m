Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF7D393D39
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 08:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhE1Gkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 02:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbhE1Gka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 02:40:30 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA831C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 23:38:54 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id l3so3732240ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 23:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NYBo8xCArOcC/hKNmPEOzfIERhkQSl/7u9OtlFmmITw=;
        b=qi7J8c+fsoS+yumWB+/OoQMPoiJITwUNEH3Q++3AhZeMf0Sl9mZqRSD03rliMKMSFT
         NUeYsGCTgZV2bb8wVn7J2hlTT75uW8G2INCZ83UlwBkXFrh2P+JcSnR/5fdZTAS1uTae
         Qj1lRwFPVJcVG9HkP6tGfxRq20L68Tauu5nJPlLupHSh36J/jcQyuxDGZaKQGrZNbX81
         2o/Z/1u7MvcizGEr0Sp1HMBpYU/6zuDXP2/D/jCFKMqWnfTYZuACUMwWgB0GwUO76QKD
         SB78KWuN8rDIb7npgy1ObppG8iiTvvRwsGyEQJEmJqPqAMgGwQysfLVD+drnILVmpSIT
         2vgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NYBo8xCArOcC/hKNmPEOzfIERhkQSl/7u9OtlFmmITw=;
        b=Ddt8N3HQRQnKnKXu7tWllUt+KxvSyEzwH6Q7Va2aqW8YsO+MmlmefSekhokgU80n5S
         IaIJ4d8uz9CLZ6WdhXuYJDPMLIbnmpmWnSN6FF/Q9J6jdR48Ah4UXAjRcw5f2kcdsXR4
         L9O/8to3uihM2+xVc9+7Cq3yyXmMUusQ5aOopgSCuERtvaPLSV5xpAcPuis86AWxpE52
         2QCOSYEuRi3v3ADv4DAWaBCXWCtxyJuHknqnBu7uYC1Bbd9AK1lyJkUGefPHXs6RNMSd
         89b9wMgvgvTogrc/Po2GAODe12QPCm4fc2VvS600mMIaESn2BuJpfgo8XtilDyezHSbs
         ubaw==
X-Gm-Message-State: AOAM530WAtHfdVONJ3asJOAvvS/oIbgS/Boo0EjR3u8hh8rnKrhyDGuX
        YDEpwqx1WyJdGyTd+scLi1KWTJvo/+nyC33D0qWuVg==
X-Google-Smtp-Source: ABdhPJyl75rNKQLPStQfrgLCbH4CtLvEi82w9sH4VS9qL7w6lPcH8eJhZkWoqClFi3ReT/2SYdtQ8NXO3nMq9udMlQg=
X-Received: by 2002:a17:906:8394:: with SMTP id p20mr5264438ejx.170.1622183933016;
 Thu, 27 May 2021 23:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210527151139.224619013@linuxfoundation.org>
In-Reply-To: <20210527151139.224619013@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 28 May 2021 12:08:41 +0530
Message-ID: <CA+G9fYvKmEeRsc5uYaPCp4h6gS38W7epM3kZEUSoOi1J+xtC1Q@mail.gmail.com>
Subject: Re: [PATCH 5.4 0/7] 5.4.123-rc1 review
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

On Thu, 27 May 2021 at 20:42, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.123 release.
> There are 7 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 29 May 2021 15:11:29 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.123-rc1.gz
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
* kernel: 5.4.123-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-5.4.y
* git commit: 69500752c0577511bd2a31b0169e1bcb6f710905
* git describe: v5.4.122-8-g69500752c057
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.1=
22-8-g69500752c057

## No regressions (compared to v5.4.122)

## No fixes (compared to v5.4.122)

## Test result summary
 total: 76612, pass: 62193, fail: 1553, skip: 12114, xfail: 752,

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
