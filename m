Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272B93EC321
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 16:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238450AbhHNONn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 10:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238486AbhHNONd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 10:13:33 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797D4C0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 07:13:04 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id v2so9199530edq.10
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 07:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uP6RbH8Pgo9wDsPbdfuuwayUA6fJ/RxF+MP+Rr5vsro=;
        b=WYVzTIjdNDUeOmoJKfzdTJUacAlCp0s5TeM9WPVCUIN9cQ97bvvoqeT4rke7Ojh/Dc
         /ZyDhv9LFqkJo91hiPZTOhZNoiYe4hsmaQJMecS+xoStN5ObJ0gGVoz92Mqmg8ffCjer
         pHX+i4hsLMGJ8Lteh32LzpmXlBS0ZP8RZKI2YTTlldENPfCOOfF66eapemNDae3k9nEo
         /DTF1fudaQKy8sGIVLNIfIMaPMg9IBic1v6NnIjDxNmBmilPluaHX3p/hjE54iEItfn8
         TMi9ow7uJLui+acthVtByapnhvdpG4O/G6rmBhmlml0vzDWnWsebC3W1WkSbCfLZARUJ
         WIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uP6RbH8Pgo9wDsPbdfuuwayUA6fJ/RxF+MP+Rr5vsro=;
        b=pA0YfT5GJOORle4WcsCwG0h43YMFmVqrVzT795HzDyBUXBWAGc8WheS8QTpzGxs1H8
         vYeHjbJHtV2ccIV9R5/9hVp12jwqBBNZUNugdULrpMttJgiCQx5cwefBbyy4S62+D99Y
         vYNyqP+t8CXfp9qeqP9ObbPnXbqmPisD+ciyIHIJ/l1UY8Q+8CHwSnw/UVRAFWWQ8bba
         tnZ911PWRRSXTgebzGjrCR8ZY/AQaPRV+/KJSsZ2sXSpJU426f+lnHU5Mc4PCjKkkS8j
         LgMgT3aVAxN30Xb4bmVEMwOjW25oE33KaVYP8f8FUXXt7tUMQ2K5XRmK/RNC2gpfUI4q
         XBFA==
X-Gm-Message-State: AOAM530S4kVjSo3JxRmaCl+sxmdZ6Myz8Zo6ht8AVLurGd9EVGKjzkdn
        oSy4/V1wonFd+zmArUicM9MlItL6j8SQwQVt/gp2Bg==
X-Google-Smtp-Source: ABdhPJzMElQAJA1X4G2K5OxvaFn7gB8Fq+kPAzlkCwfszq65w0z9hbbU8tIt46cWISXmpcGPXBfMBhyzfZ/tqzg6TMU=
X-Received: by 2002:a05:6402:1a23:: with SMTP id be3mr9175661edb.23.1628950382884;
 Sat, 14 Aug 2021 07:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210813150522.445553924@linuxfoundation.org>
In-Reply-To: <20210813150522.445553924@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 14 Aug 2021 19:42:51 +0530
Message-ID: <CA+G9fYsSq_LooJ=_UV-=XJmOcg-vrRDGZvUCvo3GnMF0c8pvSA@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/30] 4.9.280-rc1 review
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

On Fri, 13 Aug 2021 at 20:40, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.280 release.
> There are 30 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 15 Aug 2021 15:05:12 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.280-rc1.gz
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
* kernel: 4.9.280-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-4.9.y
* git commit: 5124b049250fa384487453ee2be70fbf82aea45c
* git describe: v4.9.279-31-g5124b049250f
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.9.y/build/v4.9.2=
79-31-g5124b049250f

## No regressions (compared to v4.9.279-31-g58fff7715c9c)

## No fixes (compared to v4.9.279-31-g58fff7715c9c)

## Test result summary
total: 74784, pass: 58530, fail: 535, skip: 13533, xfail: 2186

## Build Summary
* arm: 98 total, 98 passed, 0 failed
* arm64: 25 total, 25 passed, 0 failed
* dragonboard-410c: 1 total, 1 passed, 0 failed
* hi6220-hikey: 1 total, 1 passed, 0 failed
* i386: 15 total, 15 passed, 0 failed
* juno-r2: 1 total, 1 passed, 0 failed
* mips: 36 total, 36 passed, 0 failed
* sparc: 9 total, 9 passed, 0 failed
* x15: 1 total, 1 passed, 0 failed
* x86: 1 total, 1 passed, 0 failed
* x86_64: 15 total, 15 passed, 0 failed

## Test suites summary
* fwts
* igt-gpu-tools
* install-android-platform-tools-r2600
* kselftest-android
* kselftest-arm64
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
