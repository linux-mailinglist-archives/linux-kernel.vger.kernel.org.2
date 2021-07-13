Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1543C6C0D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 10:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbhGMIf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 04:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234586AbhGMIfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 04:35:25 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A784AC0613E9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 01:32:34 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id hr1so40087314ejc.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 01:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6DGB3hOsdKSq5v2IFbBrpt+jsJ9LbRhPt8yf+P+chGE=;
        b=vXepEEJPwhK9QI7g/nWa5g+pLRBvbfdxZwJpFN+8yjBhvD+03TDrvjGGlMl8vzvfdZ
         zHeIPygnbbB+BokYUdvFIqb/cjCm3EUZWskeL7Ce5LNPZfzb+MMcU9x3gy5xJfJRA9jM
         D9DlxHnm0QV+rmpPKXT9WU7KrER/aw8T8eVysuVmrCSIwTyilnXHutsHMI7TFtaHei4I
         4P7cV2tOGUY82wULNvnbBe0y+bYFV4t8R0rJd/SHIUn+tNecB8ZrweafmNFCZmHypqe1
         15whgJNUc+mazo+R2gv1+VvPoZVRUe4VOCcHeIy6ROcVjsUlWWzT2vsI1rs8JS2xImpX
         NYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6DGB3hOsdKSq5v2IFbBrpt+jsJ9LbRhPt8yf+P+chGE=;
        b=kocfurTo8debp20k59stvokT9pj9p+b8wEwZ73RHOR9YRgbtJ3hx1sLPRUjHh+tk5p
         DkAhQ/QCHC0q1nFVcwbTqlfRp569LRFB4G3OAiCwcXxhbWMrjs1s6QW/dQDqHzTJ93+a
         KyFV/bsHOyJQinjqvOPshnpFGdhcqFtVr3Rp4Sv27HCYX1CuI9D6nf6TIagjpq9doSud
         dSLiwikHnWDU91kTy/KXb1d1TsmprKd4Fy+Wg/aIsK05/L4nyv27Ahk74Z3u2zpfQWdd
         DWFQGrrMkxfn9hdiY0EE2u9/35a6vnVk2vDoTnS2ERkkBuYLjHvBnN4koSMBUC3K8rG2
         q0DA==
X-Gm-Message-State: AOAM531T4PezDpF6/wNoSPdrOZPvnwXWUywc1aOz6HWT84OotST4Xf/8
        +TdRrPPz3Vm4fyF8HYUwlWNu5vLCFX+dzb1CNfGHBQ==
X-Google-Smtp-Source: ABdhPJyv4A0lrOm13xd5bqxwPWlgG4DR4mvYJ3ecRb6bkIXBrz7iHoUjo6dGAh5X/jpYqmHTSyWM/GXwNvv4oz1QJdI=
X-Received: by 2002:a17:906:844d:: with SMTP id e13mr4200381ejy.503.1626165152962;
 Tue, 13 Jul 2021 01:32:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210712060924.797321836@linuxfoundation.org>
In-Reply-To: <20210712060924.797321836@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 13 Jul 2021 14:02:20 +0530
Message-ID: <CA+G9fYvRf1pxeUaKRimW39YzneOh=PFpsAq7w26XRtXYD3xVbw@mail.gmail.com>
Subject: Re: [PATCH 5.12 000/700] 5.12.17-rc1 review
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

On Mon, 12 Jul 2021 at 12:25, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.12.17 release.
> There are 700 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 14 Jul 2021 06:02:46 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.12.17-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.12.17-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-5.12.y
* git commit: fd3222df4dfe575b8d1fd1aef320a441f3833513
* git describe: v5.12.16-705-gfd3222df4dfe
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.12.y/build/v5.12=
.16-705-gfd3222df4dfe

## No regressions (compared to v5.12.16-700-g60202d2cb2e2)


## No fixes (compared to v5.12.16-700-g60202d2cb2e2)

## Test result summary
 total: 83175, pass: 68018, fail: 1941, skip: 11855, xfail: 1361,

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
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org
