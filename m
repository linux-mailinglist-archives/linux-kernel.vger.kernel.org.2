Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7059532A9AF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 19:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581313AbhCBSl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1577708AbhCBPxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:53:53 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBC8C06178A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 07:53:10 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id mm21so35851209ejb.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 07:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QMwRcyglOwLZ35Davd21RnBIqDoikSKOqFigf1wF08Q=;
        b=vF+08XRd3O0EMKMnWLzOFjBDhyu0U0YQMMn6uibbs9fwIhYc7oDRjHVJuflkeA2jZt
         7mFG8VvthTdY2gz7Ziib7zZ5Dal2egH2bWiMetZQZ+tXpLvsbKZxMqNNyMUV6/8pgfl5
         Qk8EKfQ0xXIftHmFCTum6tih+zxs0KJibj2BZSc9owX916KVh5Ha/GNtOu4m1opw0vrA
         HbmCgHxthB+7rscJIW6O0v9DWGQuaWHL1RgUaIuYJIG/aa2OXz9Uq+1DJONixZBE14gK
         wc2xHaXUeVSoh/3BBLz4uAml7n/KZ35qn7A/n8YgBgOpuH0oRHKvMsVdQi/rynRJGcp7
         n/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QMwRcyglOwLZ35Davd21RnBIqDoikSKOqFigf1wF08Q=;
        b=h3iAP3SfrrF5tMIrlWyFFEiaYZBL4CDHJDXyJ/0waE0ZGnXkAFDKuEcqtAObiUANY6
         jNAc8EEeQk2E8YNhhn+SZeWm+iAjps3j+wgZr8KhHUcp0BnAkwZZIVvyZ5WYFDVdMOXK
         SXgxNiEU8VucYvUcXmr+pbJs/PO6i6qXqsmGHUsugZkHWVA2BkS3GmDGQk9E0SprYXJn
         fUB+xBJGizIqZU4k93v0FcNAOR4fLhssBmEcivIV5tmpPJMsutg322UEIYlGtVP2ZG2c
         EM8f8fw983VNNGJA+ZLEAaLw0Mjx/CB4px1zDQHjC3ebwT6vyarnP+ud5IEbG9zCgYzB
         WUzQ==
X-Gm-Message-State: AOAM531o1YFjBcSFdsqikPZkpoJZzltrvv3l6Ua625zkW/dsWfgpQUgM
        SjKQg9YXrSNodY/wU7SgtK7/YHvpnwH/v+ndMXPkDg==
X-Google-Smtp-Source: ABdhPJzyhmpnqBy3XKn1hwrSV1trimEFqFxnbtTfVuFXM8I7/TDmAeNMHfvwDQJtspg8hkYOWgY/y/V3WPuuERZUBNE=
X-Received: by 2002:a17:906:444d:: with SMTP id i13mr20892006ejp.170.1614700389087;
 Tue, 02 Mar 2021 07:53:09 -0800 (PST)
MIME-Version: 1.0
References: <20210301161006.881950696@linuxfoundation.org>
In-Reply-To: <20210301161006.881950696@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 2 Mar 2021 21:22:56 +0530
Message-ID: <CA+G9fYtkJB+1woED8Lu6UVK3zqRbqTJ1Y+gbjTx32H03FkdR=Q@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/93] 4.4.259-rc1 review
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

On Mon, 1 Mar 2021 at 21:47, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.259 release.
> There are 93 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 03 Mar 2021 16:09:49 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.259-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
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

kernel: 4.4.259-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: 9c6543652027bdd932b512863425cee455274d83
git describe: v4.4.258-94-g9c6543652027
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.4.=
y/build/v4.4.258-94-g9c6543652027

No regressions (compared to build v4.4.258)


No fixes (compared to build v4.4.258)


Ran 17073 total tests in the following environments and test suites.

Environments
--------------
- arm
- arm64
- i386
- juno-r2 - arm64
- mips
- qemu-arm64-kasan
- qemu-x86_64-kasan
- qemu_arm
- qemu_arm64
- qemu_arm64-compat
- qemu_i386
- qemu_x86_64
- qemu_x86_64-compat
- sparc
- x15 - arm
- x86_64
- x86_64

Test Suites
-----------
* build
* linux-log-parser
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
* kselftest-kexec
* kselftest-kvm
* kselftest-lib
* kselftest-livepatch
* kselftest-lkdtm
* kselftest-membarrier
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
* network-basic-tests
* perf
* kvm-unit-tests
* libhugetlbfs
* ltp-controllers-tests
* ltp-dio-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* v4l2-compliance
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-cve-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-sched-tests
* ltp-syscalls-tests
* ltp-tracing-tests
* install-android-platform-tools-r2600
* fwts

Summary
------------------------------------------------------------------------

kernel: 4.4.259-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git tag: 4.4.259-rc1-hikey-20210301-944
git commit: 12d629517b548857827a6d2c13ae8ba6c8708c63
git describe: 4.4.259-rc1-hikey-20210301-944
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.259-rc1-hikey-20210301-944


No regressions (compared to build 4.4.259-rc1-hikey-20210228-942)


No fixes (compared to build 4.4.259-rc1-hikey-20210228-942)


Ran 1897 total tests in the following environments and test suites.

Environments
--------------
- hi6220-hikey - arm64

Test Suites
-----------
* build
* install-android-platform-tools-r2600
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
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
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
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
* kselftest-kexec
* kselftest-kvm
* kselftest-lib
* kselftest-livepatch
* kselftest-lkdtm
* kselftest-membarrier
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

--=20
Linaro LKFT
https://lkft.linaro.org
