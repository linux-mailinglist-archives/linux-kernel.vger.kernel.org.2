Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7321311D99
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 15:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhBFORW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 09:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhBFORS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 09:17:18 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F6EC061756
        for <linux-kernel@vger.kernel.org>; Sat,  6 Feb 2021 06:16:37 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id b9so17458172ejy.12
        for <linux-kernel@vger.kernel.org>; Sat, 06 Feb 2021 06:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YSdx/HyDW00fkPojce8NQkDGwF3FlhU+j+C00mcSxcE=;
        b=CAzyrBoU+2QcwCCHOnOxlDw/UysWFLujdGFMZy4rFzR3MEWmilpX4faaTBPHN+oi4D
         55d/Kg3+UHvH9fcU9sd/OLorYH6a2QpSVWYHv9h2FaP8d7/CKTuDpjjgteXf6NmHr/bo
         GrrmoXovUhwdEOvtt3S3wxi/5U6NqkoF8R4CWcErtxRIWlhae/pkpqXPIrNFsXbHDeQ+
         VXKjgy1PQX5YD9dh5UjaiW0RBQFbfrokN96GzBqFgJU/3UCoT1wfk8aGq9OHFnBeLs3f
         nVv8OmAjPfGo+WdOjeg97ireuJBTOEAeZYs3WE3jEht8YqDUJNjI7Yb5gr/jl1EFJkou
         vkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YSdx/HyDW00fkPojce8NQkDGwF3FlhU+j+C00mcSxcE=;
        b=SQa4I7Aw7P4WHpL2CcwEhS+C1V5dnNIEpQbDAvzfHMUYry7muGlgu4FTVOYG+lKAAh
         kH7ih2oxgAYAtSgdlDpn4GyMvi+RF7frrfcjOS9ksdKvSel5eE4jF0yTk/uQnSDMzEnv
         4jH24trAvphGhyfETnrJ7KakJDSt8dMkLLfoO0Ls/qKIorvkQVgVptHBd78/3dYelswl
         Q8hxihl0qVFGZasBlm2Ti68y2263mfj8nEUcYVzljnCb+oFh835b/d4yi27MdCv/QIET
         tXUX0LvyPNOuKbFOdsMayGzKC2rn49+aU8Qa2eLqHQ3NTHJxbLhVsKax9YDdmk8Qy0RH
         7r8A==
X-Gm-Message-State: AOAM533Q4TKKb4DXe2+FrIuXlmoR0a5nL1sqbH0dmr1Gv5DKgr9SYWyv
        raL4ByGsJQG1H6itejXXM2+9PhrDmLgy4rFkSU7VqA==
X-Google-Smtp-Source: ABdhPJzN+3wxggbsz/XUSU4bi6ZeZRBF/uXMAQIlFgT3WyAX9TTU5irHSMeAB6qH6nYE7gP2X8LUWoeatSuvecmN/G0=
X-Received: by 2002:a17:906:a153:: with SMTP id bu19mr9274390ejb.287.1612620996435;
 Sat, 06 Feb 2021 06:16:36 -0800 (PST)
MIME-Version: 1.0
References: <20210205140655.982616732@linuxfoundation.org>
In-Reply-To: <20210205140655.982616732@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 6 Feb 2021 19:46:25 +0530
Message-ID: <CA+G9fYuVctFjgOOq0JWumC-nfC+pGNLM2vX7XSb0tHboZgGpJw@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/57] 5.10.14-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
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

On Fri, 5 Feb 2021 at 19:40, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.14 release.
> There are 57 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 07 Feb 2021 14:06:42 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.14-rc1.gz
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

Summary
------------------------------------------------------------------------

kernel: 5.10.14-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.10.y
git commit: 58d18d6d116af323f12152b2e84a9e859a6d52dd
git describe: v5.10.13-58-g58d18d6d116a
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10=
.y/build/v5.10.13-58-g58d18d6d116a

No regressions (compared to build v5.10.13)

No fixes (compared to build v5.10.13)


Ran 59907 total tests in the following environments and test suites.

Environments
--------------
- arc
- arm
- arm64
- dragonboard-410c
- hi6220-hikey
- i386
- juno-r2
- juno-r2-compat
- juno-r2-kasan
- mips
- nxp-ls2088
- nxp-ls2088-64k_page_size
- parisc
- powerpc
- qemu-arm-clang
- qemu-arm64-clang
- qemu-arm64-kasan
- qemu-i386-clang
- qemu-x86_64-clang
- qemu-x86_64-kasan
- qemu-x86_64-kcsan
- qemu_arm
- qemu_arm64
- qemu_arm64-compat
- qemu_i386
- qemu_x86_64
- qemu_x86_64-compat
- riscv
- s390
- sh
- sparc
- x15
- x86
- x86-kasan
- x86_64

Test Suites
-----------
* build
* linux-log-parser
* install-android-platform-tools-r2600
* kselftest-bpf
* kselftest-lib
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
* kselftest-tc-testing
* kvm-unit-tests
* libhugetlbfs
* ltp-commands-tests
* ltp-containers-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-fs-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-tracing-tests
* v4l2-compliance
* fwts
* kselftest-
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
* kselftest-livepatch
* kselftest-ptrace
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* network-basic-tests
* kselftest-android
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-kexec
* kselftest-lkdtm
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
* kselftest-tpm2
* kselftest-user
* kselftest-vm
* kselftest-x86
* kselftest-zram
* ltp-cap_bounds-tests
* ltp-controllers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-open-posix-tests
* perf
* kselftest-tmpfs
* kunit
* rcutorture
* kselftest-vsyscall-mode-native-
* kselftest-vsyscall-mode-none-
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
