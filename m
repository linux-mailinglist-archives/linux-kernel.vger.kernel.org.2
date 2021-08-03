Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3481F3DE98D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 11:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbhHCJNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 05:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234950AbhHCJNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 05:13:02 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C9CC061764
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 02:12:51 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id f13so28036061edq.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 02:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1jcxmD3sQXpmNfJK4uSxL5iV11KAZsLdVZYpF3n4HWk=;
        b=gOfVaaSrHHc6PmtOlqESY3yVGLx9qXLVF8p48VeFIAVzbTwIVzXjuxnwH1nwIoCksZ
         oYcdNG2Go23923Oihx0HhCLSD8XAZkerljIib7J56Nf4Mwsq3Zhly711PtjHwHe+Clj9
         J6LCFgIeTPJFkRfdW2/iEKu4k7ygC7ucI9u9OhLxCoG+po9Ti0bDvn6vuNvdHnyf1amw
         VSWHhS56ve2pO8gHir8pwqK9ztq2vJZS9ojWv21dcMTUpod31A7BHMdCzX0Qu19kGuO1
         1DROJmji6P5pbKmPCBQy/lZoj0NmebqRTPJmgPHRQIBIqu4iapiLLqGT2CkMZ4YtDU3/
         4NXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1jcxmD3sQXpmNfJK4uSxL5iV11KAZsLdVZYpF3n4HWk=;
        b=X5mq1sOai+DndlkzZSiFi2wAdUP1gKNR++7lqTmvKDXBsYSuHqYMz/nZjq1LUQsZp0
         90/krVI22VXEAku9cfb0N7yIFCknuvqo3kK6OEl71IE7a0FGvsqa5t6/uCEY0m9LYTIQ
         5Ue0Ub2lOvV7N4d2tTY4BMDoPdCJtODhJPLvMy3+pkkIL4Etr85iDfPZIx4G08Oe3FyO
         Ozq/UX9k0cBeNVubX20tjDJAzxn+ZoRt1UWiaqO0vdGfQZyYC7BDVgYyugmtakYBh0nQ
         h1huq5856AU6KJzXZjc/z5Ps6U3/tAMaLHQ3/6hRNauFk2R3oPsyqGB8/nBN50WzSdHX
         qPZQ==
X-Gm-Message-State: AOAM530aKoUEWdxurIhrRlhURO5+DRaTsYJMYj6dreOECSzAk0d/DsLK
        vVWq5l/QXMSv8mie1o9YIzNhG/wHQ7C+V0hYc47+Hw==
X-Google-Smtp-Source: ABdhPJz2+V0SZqlxlga/sxjq+Y0V0jHuMs3JD6Fodn4TJXiYkUEdkem85D4lE1H3QnJLC14aRi7u/wH5cpA/PPwkd/0=
X-Received: by 2002:aa7:c647:: with SMTP id z7mr24010974edr.52.1627981970289;
 Tue, 03 Aug 2021 02:12:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210802134335.408294521@linuxfoundation.org>
In-Reply-To: <20210802134335.408294521@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 3 Aug 2021 14:42:38 +0530
Message-ID: <CA+G9fYviDnpy=DjTsWHuiaZJ2KCvuX+F9p81SqHATFrerjS=rA@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/40] 5.4.138-rc1 review
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

On Mon, 2 Aug 2021 at 19:20, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.138 release.
> There are 40 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 04 Aug 2021 13:43:24 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.138-rc1.gz
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
* kernel: 5.4.138-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-5.4.y
* git commit: 6049e03b1cecf58b1cb94bf92c713eb5a89dcea4
* git describe: v5.4.137-41-g6049e03b1cec
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.1=
37-41-g6049e03b1cec

## No regressions (compared to v5.4.137-42-gdb4bddb4a5cb)

## No fixes (compared to v5.4.137-42-gdb4bddb4a5cb)


## Test result summary
 total: 76353, pass: 61686, fail: 858, skip: 12287, xfail: 1522,

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
