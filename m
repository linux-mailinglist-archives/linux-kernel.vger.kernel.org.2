Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6B24239CB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 10:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237703AbhJFIdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 04:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237551AbhJFIdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 04:33:44 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA5AC06174E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 01:31:52 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id p11so6753186edy.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 01:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n57iUb7x8GJCYLGUqi/XvYYRYqpyg5wwYFmMWJ6epWg=;
        b=R1Rf8VT01nPXcJdhLBPc8gmj/DfqsdG2efdBoic6wm9pDtYyMx0kqy9a1DrhCFq9Td
         U4nveIzg2R6WPhv5nn68xfE2DnmCm11xkVywBTnSFcM871qgvXlOlIJdPu5A5KhNSt4m
         wfYXwEAjOlDIAoCYvMN832o1uG2rrh4anWuyPaGsQuMq+I6XgfmG93L+qb4ZAIHGB0UM
         gUOXtl8NPM7hBCO+878A4Y4mlTtgRspB+xyrSFY73BRX8QB/HsjNIqJ+4ZarsleykRDf
         sBpujQAF6BMfaSmbf/61NwfDshM/EyD4XwqoJFdCHnfkMXc3HCl/BKRfN27JwlDq5MKR
         Vt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n57iUb7x8GJCYLGUqi/XvYYRYqpyg5wwYFmMWJ6epWg=;
        b=73vKdIzpTAWquc9iZKAZLf33Mag1dGNRFAiZ/Baeuj5c2Kiq0Q45TNJR1XiGuveG/J
         7U+qyjM8gzxo/LLjU5UpHsC/P/Y3AAbMY7DaRiQE8DK39dNdeoRHhMfrmb2z0gD7akYV
         8DPxl3kjjc8sycKpzKUqBOMrbjawtO0aXu9yYkHNX81+re14quRjbBun1qNbNzhdbUz+
         OKSNT8u2789BSXP8kb2FOzHjdgtITQVmWo8df017Ys4o+0tvyMrakRSGTiDIIwnYW65G
         u8kcGdNMGaqjrR+ygRCd+1vLfJIPvekFpqiYoGDoW2IwXom0s9rcbs8g1p9xXS2JTjLt
         hGgw==
X-Gm-Message-State: AOAM531rbByeBTD/ybUvQUkW2DN6B5+9jc7yKAs+fK2TX0+y7UO7AAlU
        cX8ehzqbcVZZ6ydF0Gwb74nkCZadTfoUPsdRoQ0dlA==
X-Google-Smtp-Source: ABdhPJztgFOWnbssTMnGjXB7Pd1z7UZy0t+OTTGq2zcAVII5LCgLBQfBExSTdJZs4wJLyljYxen5Z/ysC/JsrlFd9Zo=
X-Received: by 2002:a05:6402:5146:: with SMTP id n6mr32095802edd.357.1633509110551;
 Wed, 06 Oct 2021 01:31:50 -0700 (PDT)
MIME-Version: 1.0
References: <20211005083255.847113698@linuxfoundation.org>
In-Reply-To: <20211005083255.847113698@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 6 Oct 2021 14:01:39 +0530
Message-ID: <CA+G9fYv6_jc_tB8pnHRXv7hr_d94+JQdFYXDDnrn+8e953QjqQ@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/57] 4.9.285-rc2 review
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

On Tue, 5 Oct 2021 at 14:08, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.285 release.
> There are 57 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 07 Oct 2021 08:32:44 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.285-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.9.285-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-4.9.y
* git commit: e7efcc55cce6ba10027969d4bbf10a0920381417
* git describe: v4.9.284-58-ge7efcc55cce6
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.9.y/build/v4.9.2=
84-58-ge7efcc55cce6

## No regressions (compared to v4.9.284-58-g12f4032656ef)

## No fixes (compared to v4.9.284-58-g12f4032656ef)

## Test result summary
total: 72967, pass: 57396, fail: 583, skip: 12923, xfail: 2065

## Build Summary
* dragonboard-410c: 1 total, 1 passed, 0 failed
* hi6220-hikey: 1 total, 1 passed, 0 failed
* i386: 1 total, 1 passed, 0 failed
* juno-r2: 1 total, 1 passed, 0 failed
* x15: 1 total, 1 passed, 0 failed
* x86: 1 total, 1 passed, 0 failed

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
* ssuite
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org
