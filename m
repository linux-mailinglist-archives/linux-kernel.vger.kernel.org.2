Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF2A396DCD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 09:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbhFAHPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 03:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbhFAHPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 03:15:15 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7ECC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 00:13:31 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id e18so4335535eje.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 00:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Y4pIwun4lcYA5WBPfQTrtPC9bCpeKo1JjO9SfQad/uw=;
        b=ORkO2FmC8O8AMwNNjRNCIacjBr3sKBcOpNP/V3v1Y9f2YtUK8BMa6WyiW5Byd/jMho
         t5/Oumr9GuVhOkAF2C+u2l3uoZ+3ojoZI0l4ScKWXI0GVyCiy3cnafOdZ+b4tIXUuix3
         LYsqWMWvCBJEVJN6gVwS87Pab+HNvNjcUV5Kyg2kb4yu/VNsFjsRLysxhQ4IvikwPtfQ
         M2gbuyNKkBd1wPIf2fNkeJDdWihJLN+nlSGynl+LemiRXqYxsLbZLS/w4ZQMB7tEJoii
         6FcL9Q3Gc+VZYM9IgYBLOUQEJjgJnax/BrAKArJR+Dl91IgxvrpzAwbM6eSeyYv9ZHC0
         kURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y4pIwun4lcYA5WBPfQTrtPC9bCpeKo1JjO9SfQad/uw=;
        b=mbROv5jm3sL/d9ApXdZ2kVdI/GrKSOCc1z2v5lVjALbC+sAK+N5viLW5q2n1trEmXN
         IfT/ETbgoz3prLK4M59TJPzg5MTOmiVW9I3Z6sdV6PEwrZ3mwEw1MNxgXm9PSESNrAo6
         cg/MIsIM2bURnprrVzkHmgvkvSqBi2V5wUbTTRtcKIMnkM5asUe1gBo1TJbljJm3hhuL
         yaiCrACtSG5EWbp1/4CbIvSksIIO084dX1w1/eavA28qU5CdW8jaMDGmZa0ThK/qvH3Z
         G0fONqGjR3I74yO14rqxJnlQt0rB3xw8mhR4Fy2h/KurrW/cU3lSJ3FY6XaAwfqdvWRa
         Ur6A==
X-Gm-Message-State: AOAM533eDopgl/+RLB1SGh2Y/naEy9ixgYw3Te2TM/5MwqrtUouvifHi
        nHXek198aAM/qcG2+VlESJ6brgD9MS0ZZYcPxmQUDw==
X-Google-Smtp-Source: ABdhPJxwTRPw1SyfjHlncNSOVorvYESoFFbXMikButATomxjuwsBtRRhsFdbrn1FLDfvVaLzKr9cQ9nL1qakihnHqzI=
X-Received: by 2002:a17:906:5f93:: with SMTP id a19mr19302430eju.18.1622531609380;
 Tue, 01 Jun 2021 00:13:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210531130657.971257589@linuxfoundation.org>
In-Reply-To: <20210531130657.971257589@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 1 Jun 2021 12:43:18 +0530
Message-ID: <CA+G9fYtU3_=W-Y-SG9rdQV-JXLT82bciuy0FJ_ykcOnr4LCqQQ@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/252] 5.10.42-rc1 review
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

On Mon, 31 May 2021 at 19:03, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.42 release.
> There are 252 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 02 Jun 2021 13:06:20 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.42-rc1.gz
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
* kernel: 5.10.42-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-5.10.y
* git commit: 2a1bdede969e234cf4e4e8d31566ea1804d3b443
* git describe: v5.10.40-263-g2a1bdede969e
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.40-263-g2a1bdede969e

## No regressions (compared to v5.10.40-10-gec1cc3ee7be2)

## No fixes (compared to v5.10.40-10-gec1cc3ee7be2)

## Test result summary
 total: 74784, pass: 63100, fail: 550, skip: 10569, xfail: 565,

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 193 total, 193 passed, 0 failed
* arm64: 27 total, 27 passed, 0 failed
* i386: 25 total, 25 passed, 0 failed
* mips: 45 total, 45 passed, 0 failed
* parisc: 9 total, 9 passed, 0 failed
* powerpc: 27 total, 27 passed, 0 failed
* riscv: 21 total, 21 passed, 0 failed
* s390: 18 total, 18 passed, 0 failed
* sh: 18 total, 18 passed, 0 failed
* sparc: 9 total, 9 passed, 0 failed
* x86_64: 27 total, 27 passed, 0 failed

## Test suites summary
* fwts
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
* v4l2-compliance

--
Naresh Kamboju
https://lkft.linaro.org
