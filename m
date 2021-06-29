Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 365EE3B6E23
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 08:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbhF2GNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 02:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbhF2GN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 02:13:29 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6C9C061760
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 23:11:01 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id gn32so34364392ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 23:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XkEQfTiWhOAp2Rbh7DiZy6DSYYRDHTVtJV3TfHsv2T0=;
        b=hk1DTLcc3O/Ky9pmi2i8sTk2KZxEv3lAgaSLNwzz4gSBAWurhC7c3u9lwnw2sqksu1
         QOQQn9iNdcCtLNtx17vI18TcIo1F3n30ORU05fgq5wsE297od/vW2Kn9C9xx9rT2AlG5
         Wefl7QUs+lihoo9xRoH84VJ39QylYsTXoVI6auDcd2VUhY9D/mxlHoP4iDdv4oPZm62J
         uXpn1Ta8Dpmw03ElNVwifpRmxDMkAzGY+0ZaprKDaVnxOTuf+Hxllm8V/iusBjR8I5ox
         DNYJ8JiTNECPc7k8VHUQy7zHt6QRWIy7TW4Mxe7THkrFebKzVdtUP6alVkC89YM9LVjl
         WTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XkEQfTiWhOAp2Rbh7DiZy6DSYYRDHTVtJV3TfHsv2T0=;
        b=FzleJwsgXMXbNLdrancHM1Law3YDpRHPdilRH5JVFwVVZjlhTlvKpyymjNrRGLwi9S
         TOm/FvBNXTcdBANkGXGEqpEOZi3J520mke4aAOlkDz67rDuhbWwXBzPxF753H1y0c1qC
         pZohrwOlizjbb/7IM6zhaFffHk9LNoqrKch7Tl2VOS8bCZzJU/RWOfChoiM9X2XaOKFy
         XbwaCkODPQgtTlvNVtlEkXqsezZEh5NA3beYUobfymrCR3wT23ce7q0hjBn75yDusZdT
         WFf7OQ6xmv6lFmSoYQY39eo1DpWWQ1U4s0aDEo6ppEuc76vCnPj/J7yASUwMktRpQY+U
         hnlw==
X-Gm-Message-State: AOAM532SbSqUvTUynr5vXfA9z1tUPzw+5f8g+QXW+t63WWNckqJeyOvU
        J5UG7IVnMSdU0QxSMitHCxmO9KDZ0w3ZTXSJCEFU+w==
X-Google-Smtp-Source: ABdhPJwyjek4lAyTKPKpeIWbvXgnwF60gjPAMTL6FttYrMnfymoAu/VaHOg+JQWeVNg9oclrgly8+/h5JF2AXKUSZ2Y=
X-Received: by 2002:a17:906:eca1:: with SMTP id qh1mr4706716ejb.287.1624947059735;
 Mon, 28 Jun 2021 23:10:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210628141828.31757-1-sashal@kernel.org>
In-Reply-To: <20210628141828.31757-1-sashal@kernel.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 29 Jun 2021 11:40:47 +0530
Message-ID: <CA+G9fYu+8dNjrqdt-c0M60DYZchN5vom-A4NdJSR-R6i7JWYrw@mail.gmail.com>
Subject: Re: [PATCH 5.12 000/110] 5.12.14-rc1 review
To:     Sasha Levin <sashal@kernel.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jun 2021 at 19:48, Sasha Levin <sashal@kernel.org> wrote:
>
>
> This is the start of the stable review cycle for the 5.12.14 release.
> There are 110 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed 30 Jun 2021 02:18:05 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git/patch/?id=3Dlinux-5.12.y&id2=3Dv5.12.13
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.12.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.12.14-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-5.12.y
* git commit: 5f4499a4d0cb6da10815c298938bce95915a3388
* git describe: v5.12.13-110-g5f4499a4d0cb
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.12.y/build/v5.12=
.13-110-g5f4499a4d0cb

## No regressions (compared to v5.12.13)

## No fixes (compared to v5.12.13)

## Test result summary
 total: 83608, pass: 68828, fail: 2262, skip: 11832, xfail: 686,

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 193 total, 193 passed, 0 failed
* arm64: 27 total, 27 passed, 0 failed
* dragonboard-410c: 1 total, 1 passed, 0 failed
* hi6220-hikey: 1 total, 1 passed, 0 failed
* i386: 26 total, 26 passed, 0 failed
* juno-r2: 1 total, 1 passed, 0 failed
* mips: 45 total, 45 passed, 0 failed
* parisc: 9 total, 9 passed, 0 failed
* powerpc: 27 total, 27 passed, 0 failed
* riscv: 21 total, 21 passed, 0 failed
* s390: 18 total, 18 passed, 0 failed
* sh: 18 total, 18 passed, 0 failed
* sparc: 9 total, 9 passed, 0 failed
* x15: 1 total, 0 passed, 1 failed
* x86: 1 total, 1 passed, 0 failed
* x86_64: 27 total, 27 passed, 0 failed

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
