Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37E33B727C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 14:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbhF2My3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 08:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbhF2Mxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 08:53:34 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF78C061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 05:51:06 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id j11so5634387edq.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 05:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+wWT811g+EZoum3+0GL6gvNCRUuriJ6tNDv+ihrdI4c=;
        b=YwlTTPauB/VjkKZBToaJSqg3L9yNUD7x5+5bA95UNciEf2LLbHjarNws6PwiJNFVkM
         D5Wjs/ShWWyiw09LX2T9/zLBmetpj/6wDInDdaf272s9TbWZU+pcUxBEckHtspPgyXCr
         5n02xeuX9OyM3i9j8I25V+EytaVVdifnTPIJs9GNhR9oNeioOMUSBRySLS9iBx6xP7UT
         JkPjqFqNnwqnbmp1ZHUGBBwD8AZANj/f6zgzLjJek9RG/vKN6xsSLn2m0c+umOrLodS+
         otYQ8RoA2bB4XxmY0dpk+ou/mGeOmKVMcdxXmPbCtywQbY/5Vx4Zt71KL9vKQvP/WPWH
         1V/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+wWT811g+EZoum3+0GL6gvNCRUuriJ6tNDv+ihrdI4c=;
        b=Iq5rCBCMEXPnqiqc+6/ObSi0ehHHx8IDqqr6v6bVyTgypGu4PzOQNzoDmtd/uVvk24
         KUL/uXF18l9ye+oK3o/bUJnLcOr/OqAhHAURKR7igG8jPAcbv/MC1HZjEpLMd9oOTm9l
         pQoLSJPc61nw1Ud8UhzSzMUzi8T1EEMIOl1guRN/OH21eV4FxzYBZ+BUJNsL9kr6zT/g
         Ua/Jzlz1y6IEOtKQTH3fxxPe76qzGyfgO6pG9LtHmJYFycKOPF2mSvEyiGIndu+C5fKn
         bkbfginhCH346ojsl5eQcB+2rd25lQ1HK8LSL6UCBLneZ3wCsbAAYgt237HPGCa8irpb
         Ex4w==
X-Gm-Message-State: AOAM533g9nvWdRxkb83Vlqg5rA+YlteuOgFa9HBD6p25DuSQK+qndSKZ
        mxvvUCzg1BZiiFUTunJKAQ6wWsL9EamzqFudoivdWw==
X-Google-Smtp-Source: ABdhPJwhX338tmGvYeIGSjHyHOGFmNoG7GGAyucwpt4r8D68uRQM/lkAmkPIkdgN5k0KrRWTjh5DJTT8bs6cjg4bMss=
X-Received: by 2002:a05:6402:90a:: with SMTP id g10mr39885659edz.365.1624971065255;
 Tue, 29 Jun 2021 05:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210628144003.34260-1-sashal@kernel.org>
In-Reply-To: <20210628144003.34260-1-sashal@kernel.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 29 Jun 2021 18:20:53 +0530
Message-ID: <CA+G9fYvWYsHC_55PFq5s-OO7fkkfk0V=UbW+6ZCHpGV3jNuZ=g@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/71] 4.9.274-rc1 review
To:     Sasha Levin <sashal@kernel.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jun 2021 at 20:14, Sasha Levin <sashal@kernel.org> wrote:
>
>
> This is the start of the stable review cycle for the 4.9.274 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed 30 Jun 2021 02:39:51 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git/patch/?id=3Dlinux-4.9.y&id2=3Dv4.9.273
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.9.274-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-4.9.y
* git commit: a12e33370009130a2628d2a2cdca0cfd421a2f5b
* git describe: v4.9.273-71-ga12e33370009
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.9.y/build/v4.9.2=
73-71-ga12e33370009

## No regressions (compared to v4.9.273-55-g9cd83a1b77d2)

## No fixes (compared to v4.9.273-55-g9cd83a1b77d2)

## Test result summary
 total: 59943, pass: 46910, fail: 1073, skip: 10404, xfail: 1556,

## Build Summary
* arm: 97 total, 97 passed, 0 failed
* arm64: 24 total, 24 passed, 0 failed
* dragonboard-410c: 1 total, 1 passed, 0 failed
* hi6220-hikey: 1 total, 1 passed, 0 failed
* i386: 14 total, 14 passed, 0 failed
* juno-r2: 1 total, 1 passed, 0 failed
* mips: 36 total, 36 passed, 0 failed
* sparc: 9 total, 9 passed, 0 failed
* x15: 1 total, 1 passed, 0 failed
* x86: 1 total, 1 passed, 0 failed
* x86_64: 14 total, 14 passed, 0 failed

## Test suites summary
* fwts
* igt-gpu-tools
* install-android-platform-tools-r2600
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
