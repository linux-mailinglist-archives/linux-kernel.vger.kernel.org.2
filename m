Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2291330D211
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 04:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbhBCDUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 22:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbhBCDRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 22:17:07 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C502C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 19:16:26 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id t5so4169694eds.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 19:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pg8Ks24UcMd2FwnQ3i8ehHc2CE8jbPZ+357jBLiLdiw=;
        b=i42K+wLUFZCb3ysgketbxLcbpWHSzLQMPinLV2a5dEhtJ2pC3Y1vABkWGHoQhKwjIr
         gBPbpHBJ2svM/fcIcqDz5OfzwgYXw6KR59v58tGbMJdS2XAmwc/Q/KOXlP794dyhSdEl
         NSvJVhpdiwltQWJmImb1lpfSUY8M2n+MoHV2kRTZRHZqCJlejSoEMeMi1l8wpy/zK/ff
         0BmzPQajH8tKOSpynIK07j0RbfiCAHD/Vm3PhBAMhG7fzDdWK6xo+KHozTHL/1iIaHdn
         m4KmB3tCS992eoDOvnOWgRyoN2TB9WjYk82LmU+NApE86DM0idhhSZsIYoUqxtLyV01V
         3iow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pg8Ks24UcMd2FwnQ3i8ehHc2CE8jbPZ+357jBLiLdiw=;
        b=hGO8JUt1ZfEDg23Mxy0esFF27z+5jkCq/mxnAH6U2n5DqHGVvAPL+SI+M5PGHtvwrh
         /1MebNZk8tnZXvE2Vhv/WLK0Q8+cszuhplidwLkK7jOzJCnWES/TonuGECzyKs5yzNqn
         Di2Q9VeIC7WIVi/9NNpS7y9l8ImCKRl9op7K57UuieF34nyMdEUljuHSnm8DyX2VQZFB
         E5hQoaO4mWMrST5Br7fUwT1d85pAzUUO/sxdKNEV92bB+vJnQUGuhUXjbN/OkBgf1jEX
         LPbh4SNYLGl2mwtHX1lKz64oSEdjWLKjd2hZIfGbNI7B+9pve1im5Tdj7tIuUmMPRZSX
         g05Q==
X-Gm-Message-State: AOAM5321N2wy76os3zLfYPSh8/41W+fCwZjA/LPUNKMV0wkt/jBpPahM
        G9X1XYbQgy3CnicQipJgN84soS21SjgtSAbnXWP+kw==
X-Google-Smtp-Source: ABdhPJwi/pNtpt/7fxM+OvIdBW+vQg6ue7SvPXvV+DAhucvYZD02vfcYJTjiYzmAEW+uZqJbX5ABT90CiaQ/rj1lhCQ=
X-Received: by 2002:a05:6402:60a:: with SMTP id n10mr1029603edv.230.1612322183068;
 Tue, 02 Feb 2021 19:16:23 -0800 (PST)
MIME-Version: 1.0
References: <20210202132946.480479453@linuxfoundation.org>
In-Reply-To: <20210202132946.480479453@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 3 Feb 2021 08:46:11 +0530
Message-ID: <CA+G9fYtnx1wsVET6qjtO4PRW42XqgFV_-52vj-ZNyhXggA4u_g@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/61] 5.4.95-rc1 review
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

On Tue, 2 Feb 2021 at 19:17, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.95 release.
> There are 61 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 04 Feb 2021 13:29:33 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.95-rc1.gz
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

Summary
------------------------------------------------------------------------

kernel: 5.4.95-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.4.y
git commit: 339dd34feba591544379ca9623fc350452e01be3
git describe: v5.4.94-62-g339dd34feba5
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.=
y/build/v5.4.94-62-g339dd34feba5

No regressions (compared to build v5.4.94)

No fixes (compared to build v5.4.94)


Ran 53636 total tests in the following environments and test suites.

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
* igt-gpu-tools
* install-android-platform-tools-r2600
* kselftest-
* kselftest-android
* kselftest-bpf
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
* kvm-unit-tests
* ltp-cap_bounds-tests
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
* ltp-io-tests
* ltp-ipc-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-tracing-tests
* perf
* v4l2-compliance
* fwts
* ltp-commands-tests
* ltp-hugetlb-tests
* ltp-math-tests
* ltp-mm-tests
* network-basic-tests
* kselftest-kexec
* kselftest-vm
* kselftest-x86
* libhugetlbfs
* ltp-open-posix-tests
* rcutorture
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
