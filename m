Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7678D427723
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 06:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhJIE0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 00:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbhJIE0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 00:26:37 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AE3C061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 21:24:41 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id x7so41800731edd.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 21:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CtayG/2Jwc3T42oMFOgLbtoi8yv9c+x98Ir15MDjDG0=;
        b=lXhE6maY17OUwCmUe0E7x43ggrUcdkCH1na7zZZEUugTJKFlBLYEcEgGezQC3fZnIv
         v8gAIRpMJgXHv7Nzgira4rNiWCqyCYRVuchqTRRoCa/hWKrb+GBTcu1XjEmhj/tj0qPx
         YEScqL8AhEqF5n2xVUq11cilQ31qCNNBE/FdEVy45mmuBbL4tNUSRyANThRzrYvaFFrY
         w/YgBsyhftKuQZL5cIeb6I2CTOHyEfzYOdAe49IjFO4LirUH57SB2D2LoAwb0E+Qob5d
         K8B7f6O++MbZag3iJ7sGqQb9QdZ474ECf5jJjHfMSiP43vB8z1vJJl1jvoIFPWViw/h8
         Y43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CtayG/2Jwc3T42oMFOgLbtoi8yv9c+x98Ir15MDjDG0=;
        b=4Pkimj9hFQ/gFeoqv8MEOujD+z7CunIkOvW65P4VicRKVRqrJQIVte5MbPaK0gH0M0
         z71Kvpx1E82APAbprLzmfrjgSs/PWJVDI1L3UpeLv2JIIAsdxdEyzCV212UyV6Ea+qRC
         B9ohL4CbAKdnkV34ah/qthXpKKLOS/7xfMiQfBPng+IZuky6e5URlHlLvNk79xQdcUN4
         L3qrSdHpBeic1ADyFZndgOKNaL3HL/OOPmJwodNlyaPi+wzaUKOiTYUK8RUNDmmfbXMv
         VIsRDRp0wldykeXADYI0r5takTYYYPLbmlXhqGwYWYsOQbYBrv7aSS07majLvi082y7E
         bGNg==
X-Gm-Message-State: AOAM5304ol7PrurnVJUFlVXyXshP9xPBNjzoFuZ77olOlf3YYrV5WiKj
        ODrabdAkfg7Tgt2Cp0DzatUvOkj9bwEMeeeOlxo3Ce6oGWSQXQ==
X-Google-Smtp-Source: ABdhPJwie6DwlYLxZbYPSoaIf86UF66XwpCGrLTca77CAKBF2nHvqNqR4OBZtXTarHBBRmgcOukue723gKsOvmdvx3E=
X-Received: by 2002:a50:bf07:: with SMTP id f7mr21126237edk.288.1633753479852;
 Fri, 08 Oct 2021 21:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <20211008112716.914501436@linuxfoundation.org>
In-Reply-To: <20211008112716.914501436@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 9 Oct 2021 09:54:28 +0530
Message-ID: <CA+G9fYvRkt61tGJJpaWi8yNLHp6Ruxz6AsYvhfNpF3s5ELM94Q@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/29] 5.10.72-rc1 review
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

On Fri, 8 Oct 2021 at 17:01, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.72 release.
> There are 29 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 10 Oct 2021 11:27:07 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.72-rc1.gz
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
* kernel: 5.10.72-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-5.10.y
* git commit: 1164874f979faefe5369c77fc31721dd66dd8d6b
* git describe: v5.10.71-30-g1164874f979f
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.71-30-g1164874f979f

## No regressions (compared to v5.10.71)

## No fixes (compared to v5.10.71)

## Test result summary
total: 90823, pass: 76904, fail: 575, skip: 12384, xfail: 960

## Build Summary
* arc: 20 total, 20 passed, 0 failed
* arm: 290 total, 290 passed, 0 failed
* arm64: 39 total, 39 passed, 0 failed
* dragonboard-410c: 1 total, 1 passed, 0 failed
* hi6220-hikey: 1 total, 1 passed, 0 failed
* i386: 58 total, 58 passed, 0 failed
* juno-r2: 1 total, 1 passed, 0 failed
* mips: 63 total, 63 passed, 0 failed
* parisc: 24 total, 24 passed, 0 failed
* powerpc: 36 total, 36 passed, 0 failed
* riscv: 45 total, 45 passed, 0 failed
* s390: 18 total, 18 passed, 0 failed
* sh: 48 total, 48 passed, 0 failed
* sparc: 24 total, 24 passed, 0 failed
* x15: 1 total, 1 passed, 0 failed
* x86: 1 total, 1 passed, 0 failed
* x86_64: 61 total, 61 passed, 0 failed

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
* kselftest-x86
* kselftest-zram
* kunit
* kvm-unit-tests
* libgpiod
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
