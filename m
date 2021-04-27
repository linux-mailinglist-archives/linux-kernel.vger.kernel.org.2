Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C4636BF8F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 08:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhD0G7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 02:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhD0G7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 02:59:39 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F869C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 23:58:56 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id d14so4818944edc.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 23:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nYuHSxQqjB98hxWMFodin2As7mkAminTbcZYjOL6beU=;
        b=n2mizalICG+uSY4fJozb+7tW1GzbcZ4Ggg3wtOd81c2ZemW6wzdGyT3YACiSBO9KhI
         fdnVBjESdmezTv5FcuYTvxhn4OG+yNbTekWaw/XiFN3gq3HnR/bPFc9Mv9C3gOhg10W7
         RnfiNDd2PqNDuMWOw1FMdrm0lgWKC8vtLSEXVwwnj2rLWu5i7BOY/Ln18aDvrfit2g/1
         khtciFfj70mocNfs3+N9moj7NdRkQAKAnqyVAIkkPAg8eH672KhWESSk0dgDixafZXMD
         hKXSZn2zCdeIxPdZGg1kpnqT256j+gHhC3UHokgFVACpRFYAGM7jqJn13woK1Pfsnp5H
         YMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nYuHSxQqjB98hxWMFodin2As7mkAminTbcZYjOL6beU=;
        b=ug+3aV914yhoArHmlF441WSoKPgqhBm3ULyAF8nV1feH2J6rhAugoMjwJeIc5pZYo0
         yjJ03MlYH50TSz8nkGWF4H4EBjBM7X3sVplmDcESznqixsPKiv7MafxvuqlkJHdTJz/I
         wRuD2XWsDyGqAPZUPgi6FHqvRE0UA1EcdvvqhM3soujJ1B2WTp9m+vtD35xH+Bkf3H4d
         XKGnLvlZwZTKfRzZoHzu45zURQYznlCwHw/9vMEiWM+6OgKnHDkLKn92271mmy+n9/mp
         rTYVdPpsy76nHy4ATvToU4kAH++C69LQIR2Qn+Hwx/e4LSrfHKuafe24io0pWtylQVJZ
         z6NQ==
X-Gm-Message-State: AOAM5301bWVKsQEuU76sd8D65YcHEfP/HWZjQmLGSMLiXNQ8mEiVtEub
        xRfX/56PtpiVAe5hGGaXcZWcjc6jjcNft1MixV+2Zg==
X-Google-Smtp-Source: ABdhPJzryJOj559l2+49TUIuvvln+WTSV/fTLapGzlWxjsiaJv3qDdZhZjmZOBtt9r9sEfuHM1HC90aPw99bdOAAAhE=
X-Received: by 2002:a05:6402:5113:: with SMTP id m19mr2654011edd.78.1619506734692;
 Mon, 26 Apr 2021 23:58:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210426072819.721586742@linuxfoundation.org>
In-Reply-To: <20210426072819.721586742@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 27 Apr 2021 12:28:43 +0530
Message-ID: <CA+G9fYs84Oajjj_nuby-Bat_JtWQP8OGeeT29_+Z2g182G--Vw@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/49] 4.14.232-rc1 review
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

On Mon, 26 Apr 2021 at 13:05, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.232 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 28 Apr 2021 07:28:08 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.232-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.14.232-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-4.14.y
* git commit: 3ac46322bf509c3f3735c8287d28702ee6172b6e
* git describe: v4.14.231-50-g3ac46322bf50
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14.y/build/v4.14=
.231-50-g3ac46322bf50

## No regressions (compared to v4.14.231-37-g80b9c877fd48)

## No fixes (compared to v4.14.231-37-g80b9c877fd48)

## Test result summary
 total: 59469, pass: 48473, fail: 1702, skip: 9049, xfail: 245,

## Build Summary
* arm: 97 total, 96 passed, 1 failed
* arm64: 24 total, 23 passed, 1 failed
* dragonboard-410c: 1 total, 1 passed, 0 failed
* hi6220-hikey: 1 total, 1 passed, 0 failed
* i386: 14 total, 13 passed, 1 failed
* juno-r2: 1 total, 1 passed, 0 failed
* mips: 36 total, 36 passed, 0 failed
* sparc: 9 total, 9 passed, 0 failed
* x15: 1 total, 1 passed, 0 failed
* x86: 1 total, 1 passed, 0 failed
* x86_64: 14 total, 13 passed, 1 failed

## Test suites summary
* fwts
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
* kselftest-kexec
* kselftest-kvm
* kselftest-lib
* kselftest-livepatch
* kselftest-lkdtm
* kselftest-membarrier
* kselftest-net
* kselftest-netfilter
* kselftest-nsfs
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
* rcutorture
* ssuite
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org
