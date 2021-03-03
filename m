Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEC032BF10
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 00:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239107AbhCCRxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244869AbhCCO6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:58:54 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2EDC06175F
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 06:56:03 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id bd6so17105160edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 06:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BeRYEBXOGtUPacQ3jkJGzfydVsmuFdHHmsB89bO92TI=;
        b=r50kqoWy+d1dJYf6ypcyQwWbSum4uqiHvTtVjWcG+68wn0e+NK4KIa7MPsxG5zO3CD
         eCgWLopEPyP92JyNf/nUKOFcM05+BaYnLvekoqOMzUxPzCACSCkfz/yXYUZIGQel7cPe
         OF/8+H0CC5+ChvGB6YpQqPkXkWtn0zZZwJLxWO9S8Nx34nR3JvYY5IJ7wIGmq1PRhcKC
         c9QS5XETuxA0b3EIH7Pq6UJXp0ze7icTfe2O99aXJKYfTZ/rPJhbxHZH27R64chMrBF/
         JIbBvmPnWVeAEe24ajmqIHxROI7E+XC7WDcMcL8Kww4oANUViqj8PpAotsKArcllCbcE
         BNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BeRYEBXOGtUPacQ3jkJGzfydVsmuFdHHmsB89bO92TI=;
        b=IN79gRwuUR/il6DsC4OVPwdicpjSMRufAVb6XSwTus8NrNr5KvASqt/lG2QGQjXPjx
         WMERmtxXqWBvNB+z0aNZrV6fhnbGfCoS7CDtWs4qGAlZ4myWTb6N51cOrIQvYpfSPZLg
         rAycOUaHX9to4By14x8JYwvvd0rssgLqd2DMZz6pxghjyNiyVLb148BwPuFBuQAlHME3
         DvA98hQqZ0U/sgCJiGhX4lFMny7C+s3TaDsT3E0DKNQ6LY/2K+p8kW2GjZ48goWZTtUm
         oPBOwhUOAsxENmMKw+hntnahrlwZUERjTpjf+c6r+8N7FX+9dvq8hQMDhE+jQXn1HCdm
         U+CA==
X-Gm-Message-State: AOAM530V/CgmQxLX1Xu7t4XqDOy0fK5e3KNKCTy+mtrYK//8n6drKVg5
        N8fT8xkNZdiN83o+7xzMZIJihAyiKu9b8A5abA5rlg==
X-Google-Smtp-Source: ABdhPJw5Tnill5Lv4tgf8pN2VY2Vo3q6TPg5TrHu0jh97X5xDkXoay7DMgbUtIkuYKc1RHOtHRA4sLfxm7+JtQWfM3g=
X-Received: by 2002:a05:6402:510f:: with SMTP id m15mr26129817edd.78.1614783361814;
 Wed, 03 Mar 2021 06:56:01 -0800 (PST)
MIME-Version: 1.0
References: <20210302192550.512870321@linuxfoundation.org>
In-Reply-To: <20210302192550.512870321@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 3 Mar 2021 20:25:48 +0530
Message-ID: <CA+G9fYvtvZ2Cz+vEXiZouYWsG6V6ZnyF3N8m2c9mkfUn=RxZCg@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/246] 4.19.178-rc4 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>, patches@kernelci.org,
        lkft-triage@lists.linaro.org, Jon Hunter <jonathanh@nvidia.com>,
        linux-stable <stable@vger.kernel.org>, pavel@denx.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Mar 2021 at 00:58, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.178 release.
> There are 246 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 04 Mar 2021 19:25:07 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.178-rc4.gz
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

Summary
------------------------------------------------------------------------

kernel: 4.19.178-rc3
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: be9fac34eff6bc947c29cdccf772b7671f70dbc8
git describe: v4.19.177-248-gbe9fac34eff6
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19=
.y/build/v4.19.177-248-gbe9fac34eff6

No regressions (compared to build v4.19.177-rc1)

No fixes (compared to build v4.19.177-rc1)

Ran 46512 total tests in the following environments and test suites.

Environments
--------------
- arm
- arm64
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- juno-r2-compat
- juno-r2-kasan
- mips
- nxp-ls2088
- nxp-ls2088-64k_page_size
- qemu-arm64-clang
- qemu-arm64-kasan
- qemu-x86_64-clang
- qemu-x86_64-kasan
- qemu_arm
- qemu_arm64
- qemu_arm64-compat
- qemu_i386
- qemu_x86_64
- qemu_x86_64-compat
- s390
- sparc
- x15 - arm
- x86_64
- x86-kasan
- x86_64

Test Suites
-----------
* build
* linux-log-parser
* install-android-platform-tools-r2600
* kvm-unit-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-controllers-tests
* ltp-dio-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* ltp-tracing-tests
* perf
* v4l2-compliance
* fwts
* kselftest-bpf
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-sched-tests
* ltp-syscalls-tests
* ltp-cve-tests
* ltp-open-posix-tests
* rcutorture
* ssuite
* network-basic-tests
* kselftest-android
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
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
* kselftest-tc-testing
* kselftest-timens
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-zram
* kselftest-
* kselftest-kexec
* kselftest-vm
* kselftest-x86
* kselftest-vsyscall-mode-native-
* kselftest-vsyscall-mode-none-

--
Linaro LKFT
https://lkft.linaro.org
