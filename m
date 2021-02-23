Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16A7322653
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 08:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhBWHSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 02:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbhBWHRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 02:17:42 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F41C06178A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 23:17:01 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id lu16so32913389ejb.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 23:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tLbaD828ROUJrbj6tRy23GS8yufUa2khXUxH/puHPtI=;
        b=F5TNCKjrp8ESnoVA6ZWXuxk6nCe1Ef/2H/d6zzsBHwljCr3Dsuh80j0hWHjgfDLAGs
         UheDwb2dj2p7DdtBGfQ0rLt+DKCDwx2dOBzRW88scjPA9UHVpolA8twBNVzsiMFfL57+
         KGnKn+0kYzuBW6OonFB6N/6ExE4/eJpFy3UC9iz6NjXA6dY7gDMx7Oh3PAetN/GA8hYO
         YCyHPerwIsdN0mZZYkTfAasN4wIyZ7sWJ/PFjKfiFjNyPujzV5c6gu+SkPa4trQE9XX5
         H1IJKK7YY7D373cEG+8yNNOkACLQIwUu7suzAQMetM0fVCq69VFOfcECYNogVkBVPThu
         g71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tLbaD828ROUJrbj6tRy23GS8yufUa2khXUxH/puHPtI=;
        b=LrTJB+youDaTUpKZxUmlaF4OIL9KMcd4YnsSFMOmhdL2BtRA95QbRhDDsI2OmcACOU
         TSoM+2NNp0FBRWNE4FsjEaBn5aUaRRehJAxRbh7vZe29mUU2+nWSvfuPcwQo/hBLi7i8
         MsS0rbYNaIYFiR4GtHUVwsC/VnKNP0s5k+ehhdqLNVFxTeVpGqBW7KZZrL9pcYJx5xQ8
         FdLIgDdQ7Vs5eKKQHj6z/hNdg4BEh3scRokx+KpWQJBasVgF/J5NTj1tbi5zSAZ3a+Lv
         Ep0DwZnt6B+HnlvAMF+/Qe95ki+/gOyx/VtXTRT6Lp3Tqg7lppfQHRDe3q5jmhmId7YO
         QBrA==
X-Gm-Message-State: AOAM533Vvv8iMi/oevvRS+patTdKXFggKvy8urssNM8pqSmhbj79bkkC
        legw2NeN33MaLrCQCnlObOMP4FYpQukAqigXRgp/hw==
X-Google-Smtp-Source: ABdhPJwR4dR2313jAV5Q60+zbgHaxDnNhnO4yBzi9B7jS5hkn19x3uy9Nh0yj7vjpCfLabZ3VOICIBbz/GJvbiAeJHU=
X-Received: by 2002:a17:906:4c85:: with SMTP id q5mr24291742eju.375.1614064619821;
 Mon, 22 Feb 2021 23:16:59 -0800 (PST)
MIME-Version: 1.0
References: <20210222121013.583922436@linuxfoundation.org>
In-Reply-To: <20210222121013.583922436@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 23 Feb 2021 12:46:48 +0530
Message-ID: <CA+G9fYv_37qTVD_ag+_wPQFrbou9i-OmrJUmQw99OKUSVPkJHg@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/13] 5.4.100-rc1 review
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

On Mon, 22 Feb 2021 at 17:46, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.100 release.
> There are 13 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 24 Feb 2021 12:07:46 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.100-rc1.gz
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

kernel: 5.4.100-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.4.y
git commit: b467dd44a81c97f9d99fbab61ef081f35e824773
git describe: v5.4.99-15-gb467dd44a81c
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.=
y/build/v5.4.99-15-gb467dd44a81c

No regressions (compared to build v5.4.99)

No fixes (compared to build v5.4.99)


Ran 50146 total tests in the following environments and test suites.

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
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-containers-tests
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
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* perf
* v4l2-compliance
* fwts
* ltp-commands-tests
* ltp-controllers-tests
* ltp-math-tests
* ltp-sched-tests
* ltp-syscalls-tests
* ltp-tracing-tests
* network-basic-tests
* kselftest-kexec
* kselftest-vm
* kselftest-x86
* ltp-open-posix-tests
* kvm-unit-tests
* rcutorture
* ssuite
* timesync-off

--=20
Linaro LKFT
https://lkft.linaro.org
