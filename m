Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A6F3546CD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 20:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbhDESpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 14:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235007AbhDESpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 14:45:16 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8596C061788
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 11:45:09 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ap14so18183455ejc.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 11:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BFHYssz1iaMUOv40sG4wfVnLP4seqzqqbAjmv6+HjRY=;
        b=LGrJid80r0gpEph4PUAcVfa2WlrIj3TxHV+XIbuyjN0LXnlfTixrzSYKC3ak0zzMsJ
         afrqnFdmMp6+JqEl1eeFkvvtzBxM2sfx+1QVs9XQUOR9BlFFZoTq8N3CD7cZHaHjJoeB
         LLMAPmc94Aik/EDjkmM3Ng4Rb/+Pjn4zgvTEdVj+LW0bg6eoREnz4iwVcKNO3wgaqNU2
         Q4N/v857gO0XuDwOm/O49cjlwpM/iOk7yQwD1v/l/wxMqxjqHuQrCewp/J5tQ/QAlvp/
         EFckBGIAXO9ZJWtlJIJ/k1HzBGYrkXyZ/UtaHLHyb2sBvcWuu9JoHsFtScvjRFutLEOQ
         qiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BFHYssz1iaMUOv40sG4wfVnLP4seqzqqbAjmv6+HjRY=;
        b=EBpBzxO3m8iwuWM4P55PBJREWQ04WB8tuWbP+frW1F2tQCmglWhJ36j5eTG0gQCsLt
         NcwZI1vkBpG0iQbvpqQQVDtEj+Rkr6V0y5NyNeADEM8rd5CMl0wFVHiZcUBpvxcpUtRr
         71PqMJnAATEtOHYiT/X/xvSP8iWiREHFAnMiL7oxZmldqWV+kx1IEP3xBTf9aq8Wykd+
         p1dErjkPLWzNAjlEhJxX+iElQPr2Z5VRuNkMNsoIu42VHBfqo5USoniQpLkyelOj3KDw
         o+go0tvS79i2d/imA65qLf0OJKWNi8HXzpk48BTDskW6biuPCMjcW/+ueCwAFgf0lF5M
         UDNg==
X-Gm-Message-State: AOAM533mu49sT8YsHUoldvfSJPaWskti7/FPPSS/IwyBKmOIFI0wsOSL
        WCmct2srR6Crl2VaQwV4hlh+rWxbDHKTImWxxynadg==
X-Google-Smtp-Source: ABdhPJw262MEF7u1tgMcfEVdRvtl2Xq0dU64UZWSdn0UIbio7YbFE5ScGvypumJnQ/aACUsg02YWDc35WMXf9NagFiE=
X-Received: by 2002:a17:907:2509:: with SMTP id y9mr17427811ejl.170.1617648308382;
 Mon, 05 Apr 2021 11:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210405085031.040238881@linuxfoundation.org>
In-Reply-To: <20210405085031.040238881@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 6 Apr 2021 00:14:56 +0530
Message-ID: <CA+G9fYvpTixH8MXGuovfEiYLAMoOxjG2jp2a0W7h20x_qUBn5Q@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/126] 5.10.28-rc1 review
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

On Mon, 5 Apr 2021 at 14:37, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.28 release.
> There are 126 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 07 Apr 2021 08:50:09 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.28-rc1.gz
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
* kernel: 5.10.28-rc1
* git: ['https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git',
'https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc']
* git branch: linux-5.10.y
* git commit: 17879c574df0acdfddd69065b191a3c1b1f00d48
* git describe: v5.10.27-127-g17879c574df0
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.27-127-g17879c574df0

## No regressions (compared to v5.10.27-82-g948d7f2d279f)

## No fixes (compared to v5.10.27-82-g948d7f2d279f)

## Test result summary
 total: 75519, pass: 63466, fail: 1846, skip: 9956, xfail: 251,

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 192 total, 192 passed, 0 failed
* arm64: 26 total, 26 passed, 0 failed
* dragonboard-410c: 1 total, 1 passed, 0 failed
* hi6220-hikey: 1 total, 1 passed, 0 failed
* i386: 25 total, 25 passed, 0 failed
* juno-r2: 1 total, 1 passed, 0 failed
* mips: 45 total, 45 passed, 0 failed
* parisc: 9 total, 9 passed, 0 failed
* powerpc: 27 total, 27 passed, 0 failed
* riscv: 30 total, 30 passed, 0 failed
* s390: 27 total, 27 passed, 0 failed
* sh: 18 total, 18 passed, 0 failed
* sparc: 9 total, 9 passed, 0 failed
* x15: 1 total, 1 passed, 0 failed
* x86: 1 total, 1 passed, 0 failed
* x86_64: 35 total, 35 passed, 0 failed

## Test suites summary
* fwts
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
* perf
* rcutorture
* ssuite
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org
