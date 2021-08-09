Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9C73E4748
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 16:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbhHIOPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 10:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbhHIOPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 10:15:15 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AF4C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 07:14:55 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id g5-20020a9d6b050000b02904f21e977c3eso18141150otp.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 07:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gJiisE2sO/m7LO4WNaomFmzM/RoJAn5C0ijeBGS4qJA=;
        b=kwtx6TLve0+9uE6D/0k+4ids05jQJ4WI5b39zRJUTd64cI7YK8yLmLxi+k1kWUP5BU
         n2HLHipQYtfGw9Jrh3thPlUTY+dpmGwYiyWXg4oLwRRe57eZRWbTN7rx+sqvn4KDfQkn
         UWIfJHNWycYN+HVSBkl7+t8TWYqO6wd3KdR0wTO3Gob2nDMKbyN/KHO7DEQ1HFslbiIY
         NgtV+Z4ix7viEOW1IBVkp2QLqon7KqCguFYYlCk5Pz9Ae1g/H7O5NDic+whcIWiRxU0V
         EGR4llZ04OJykXWn8mQoKo3+PM7PbkXK93072am6V0NJciCvlW4zLtKd5rcPJAg0pYCo
         QEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gJiisE2sO/m7LO4WNaomFmzM/RoJAn5C0ijeBGS4qJA=;
        b=ZkxM1Yef1mOBRrc2v5KFej2FXOQXyrUDAnoZkpYFoASDU43hZx0P165RN8pYS9Q8qj
         +kenboC6Ht9q8Lct0UYV/32OI7i42qpHMsrIlcq5pkgm7eu9cu3WSk8GU5dnClpJFrGO
         CmS7ISyPuaKL9rOm4dTrAN2y7BLcxG192G0JOJLd8m9o4vHF5xgCsoXamFNRBe6HcLmM
         0bUG+4B0Oh6/UYagTsePMPkN1yUNe0Z4gAT7SNE3obOm/hMe7bSGXyJ5F9zUjIu6OV0+
         ix4kC3vUsXsWtCzuaN5GYd3uS5ikyOdyubkV1kB7V06wPtOwdyFgR1ebJ172Iw+zFCbE
         MlQA==
X-Gm-Message-State: AOAM532oUZunuYoy2DAyZ8C+8i6ue3QGqFR02RJKc2X2wemG0LAXc3TK
        obXoSqESLmUYLwC4I1Qy5EIE3MJ6A+NDbtHBZ6pUsoRKJOTl3AKC
X-Google-Smtp-Source: ABdhPJzWeazR6E5ky7JGYjfZkcy2QMvYYMAUFfVFU7pxCM8d8XJ5hE3I9rzhv3mZZOZmC6SnLT88nFM/GQD7xZ/hD2E=
X-Received: by 2002:a9d:7087:: with SMTP id l7mr3733863otj.72.1628518494277;
 Mon, 09 Aug 2021 07:14:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210808072217.322468704@linuxfoundation.org>
In-Reply-To: <20210808072217.322468704@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 9 Aug 2021 19:44:42 +0530
Message-ID: <CA+G9fYv8-mLb=T0aYJuCtjZnru37DGgaz-Emq3SDC42o14spoQ@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/11] 4.4.280-rc1 review
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

On Sun, 8 Aug 2021 at 12:52, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.280 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 10 Aug 2021 07:22:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.280-rc1.gz
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

## Build
* kernel: 4.4.280-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-4.4.y
* git commit: ed64e21faa7c363631146450958652fc0eca52ff
* git describe: v4.4.279-12-ged64e21faa7c
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.4.y/build/v4.4.2=
79-12-ged64e21faa7c

## No regressions (compared to v4.4.278-7-g155338eca25e)

## No fixes (compared to v4.4.278-7-g155338eca25e)

## Test result summary
total: 46830, pass: 36930, fail: 379, skip: 8222, xfail: 1299

## Build Summary
* arm: 96 total, 96 passed, 0 failed
* arm64: 23 total, 23 passed, 0 failed
* i386: 13 total, 13 passed, 0 failed
* juno-r2: 1 total, 1 passed, 0 failed
* mips: 36 total, 36 passed, 0 failed
* sparc: 9 total, 9 passed, 0 failed
* x15: 1 total, 1 passed, 0 failed
* x86: 1 total, 1 passed, 0 failed
* x86_64: 13 total, 13 passed, 0 failed

## Test suites summary
* fwts
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
