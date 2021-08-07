Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 023DD3E36D2
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 20:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhHGSor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 14:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhHGSoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 14:44:46 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22B1C0613D3
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 11:44:28 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id p21so18149011edi.9
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 11:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vH4iHcwS+oyI59VfmhkppLskDj75UUNO7iIn9MYCA/0=;
        b=uJzI/3LhK3KjIYjsQ4SyzX0yFGdmz/xNwOhNOWydJWNjpJv97qje4BzclKQ/G/w+H4
         tKgmBj1cEXLHazJNczu7iDgbwX6Hh4Ch//tD8FclzOAnpFUMDxThpWvQqriIur8T6xeY
         TPeSgssG0zUFokH85rtO/1atRyMjPFQOXYL534FIZN6vhbgn95WujtGJIFRwOpYb9DEG
         5libLhsluQbIbXjWX1lA2NvLkR5g9UPWWUKUWQtXWvpR7xDd9/zNd9C4OTvjD9g356Mv
         npS/fHQFzcgbBoLSBFLmrtLcAoT/BRS0cm3VV26wNOXkOdeAb/adWeGfvfaCHCuo4Tys
         YMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vH4iHcwS+oyI59VfmhkppLskDj75UUNO7iIn9MYCA/0=;
        b=n3xqIYQPX6UXaoxQ7CGy/PjZPCpNEo5+iCqDpfMf1FjN4sIJqNlFhPsm3OUz+yKcjJ
         cCu4XcMaBEdwQvmV2yZ5oElqfkyn8cS+bwUmfjm/LIt9sBu/wBlCTVXRQaGbYDkC3dgr
         yCXr4jNiBvPi/dDSA4u3XBRavaBh0yU+sujzVGAipcW5q9rr3mxTeAnRuXLbXkf25w28
         ki2OIsLUpZIiZR/XaZzPBO3TbtjkziYXYmJmA/LkF5k1ULPmOFAsWLAnPliSywE/46AO
         CAnLoghdlWpTNJoOwBSEyAwmEClHoIH7+4Fi4apGumk5ukmxK3lBV2JdpM8kgSp/XI6c
         j97A==
X-Gm-Message-State: AOAM5332bSiYUbukCI9H1e9h5CQqe9Ew7wPKonkcVppJk3CNt3RhIzX8
        WeBP/24zo07lA8zCecaZKIb9hSaR7trG/kVKnooltQ==
X-Google-Smtp-Source: ABdhPJzJQVSwSO2E3RGj6vchMweukRXvtn9bViKDtVzYCJkLS33Bvf3igt3RtZE/MGxll/rtu/upJb3EA3k5c8NRrss=
X-Received: by 2002:aa7:c805:: with SMTP id a5mr19987282edt.23.1628361867210;
 Sat, 07 Aug 2021 11:44:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210806081111.144943357@linuxfoundation.org>
In-Reply-To: <20210806081111.144943357@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sun, 8 Aug 2021 00:14:15 +0530
Message-ID: <CA+G9fYsow5FMRdVHq3CRB6sHCW+FQBtDco8r3At5UnxRsx7UGw@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/16] 4.19.202-rc1 review
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

On Fri, 6 Aug 2021 at 13:46, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.202 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 08 Aug 2021 08:11:03 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.202-rc1.gz
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
* kernel: 4.19.202-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-4.19.y
* git commit: 9c68cf432f4cb6091ecc834b0e3a729892247335
* git describe: v4.19.201-17-g9c68cf432f4c
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19=
.201-17-g9c68cf432f4c

## No regressions (compared to v4.19.201)

## No fixes (compared to v4.19.201)

## Test result summary
total: 76501, pass: 59304, fail: 1758, skip: 13148, xfail: 2291

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
