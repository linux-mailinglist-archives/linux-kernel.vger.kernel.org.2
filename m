Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E923DEA85
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 12:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbhHCKKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 06:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235058AbhHCKKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 06:10:30 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08790C061764
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 03:10:19 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id cf5so16739455edb.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 03:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LGkg+tEKNi+6cq7JJd/Wd28kqNOTiVmWoVZkricfcWw=;
        b=F1jU1sEiGki0ctpVPHy+pXuqLkqJkeqWSChQJKEdwh/u4o1jDamuddMmMW/UfAOpo7
         kEe2fWxs1bPUKAulnqt1CeJXlyH4qVlVHle+tWY1Zc4xvBAHa2Y1j/jX3QLJI7JfFlom
         Qa5BzIK1ESybsMJMySYplEpG4JUPbkURQYf4ZUlpH8g0eET0WNSNRJTDAUhuvPI+HHlR
         GvAVjZyQm0aJKVELk/xoBRkPFjUwK9C/hLxFr6UBmblZu2Iyo/WaHV59gyqsMGKyUrwN
         fZuUL48T1cAQLQqMifNSeKG4ffMbSUt5cAPW7ZNQUFz1qeYwXsN8IZCmfvAqWPFJo7va
         aZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LGkg+tEKNi+6cq7JJd/Wd28kqNOTiVmWoVZkricfcWw=;
        b=YoTy6BAtah+Y0OFmV+UtBBmh4OuxoKP6wESGz8lC1/wjBlHNqNw526LaEhhDevH3qt
         Twos4RfqTNpKvaFZKn8OaVYg6SXw73i8t4E8DLDvJ5spa6dhS9UTbtCkHuR2XyKikO4k
         P65Mx5juYCR7cLd0XkJM40ZPROgj2HC5SbvILn6QLBYUroL6NwJZ4mQvTHrvNvUgCqNB
         wLdQtl4HZrx2LhKpK687DvJgO5gPAP0FcM/IhYO/cUA4Pi7ZRepFIE4PPfkBoOQTthP3
         Yq27UHAZ04KpYGyAgJc2z+D8+jsQrTeZTc1xAj3owvupXFceCidYITEJFSZnUS5jbcTl
         OPFw==
X-Gm-Message-State: AOAM531kRpcp0UC56LLetDBryvbacAbwq0vvU0dTyOyCwN8+LdYyc8FI
        nDlA4Alu/lAOvkhUMX0jAFeUL4Y3v1XN7dVdJDctUQ==
X-Google-Smtp-Source: ABdhPJz+oc77cT1vGzJEr5sly502MyYWV7G7l2sd/9HCUeJ+E/mmE0fonNgXIsX6F4GWqyj4uS+8Rqga3E8JhUqkoqk=
X-Received: by 2002:aa7:c647:: with SMTP id z7mr24239038edr.52.1627985417407;
 Tue, 03 Aug 2021 03:10:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210802134334.081433902@linuxfoundation.org>
In-Reply-To: <20210802134334.081433902@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 3 Aug 2021 15:40:06 +0530
Message-ID: <CA+G9fYu+Bax17kwqWMFniMfPZO+qh2Spz9mXvdgXiEA7fsptQw@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/30] 4.19.201-rc1 review
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

On Mon, 2 Aug 2021 at 19:19, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.201 release.
> There are 30 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 04 Aug 2021 13:43:24 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.201-rc1.gz
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
* kernel: 4.19.201-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-4.19.y
* git commit: 7d0b2cf6631fd9776096a6a1bc52a89946f15d4c
* git describe: v4.19.200-31-g7d0b2cf6631f
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19=
.200-31-g7d0b2cf6631f

## No regressions (compared to v4.19.200-15-g5b0f1f3c91d6)

## No fixes (compared to v4.19.200-15-g5b0f1f3c91d6)

## Test result summary
 total: 71236, pass: 55001, fail: 1762, skip: 12270, xfail: 2203,

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
