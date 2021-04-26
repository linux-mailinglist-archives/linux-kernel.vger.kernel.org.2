Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D2236B827
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 19:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236101AbhDZRil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 13:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234754AbhDZRij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 13:38:39 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69147C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 10:37:57 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id i3so41033167edt.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 10:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QP0CmUOmuZCqFMCKbU7p6miMg+oTUEAR2qJhsCeBN3g=;
        b=M78V2gjSMdnIA3IGGpOKBt23gjaj6T/rFhYiDsIGYpthKKMLq+xksmfqE1O5ZzCIMT
         thpCHpkYFCRoICXNYbM+6G5S+mWzl80T9xpqt5LTmkJcqJW2gnrRhqUxIPscQ61pV7yJ
         JN6LoHFDwpco6cOiCMtqxcskVlcKmTTPPBe/u23auJIp/BwYFUlsZqH8lqtK83ZG8pyP
         GeIdUn++Ix43s1WBNQeVP/kjK7FZI3kGLUD21b+kLpsiZVIXzWpvN4i/VloRoACY+SFC
         066jcpMatjvUsz/FuAsNX5D1lDhxq6sjbUEK9Gn4IToxVBrzKkQs8qf/AC61IdvAVBuz
         z2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QP0CmUOmuZCqFMCKbU7p6miMg+oTUEAR2qJhsCeBN3g=;
        b=Dmr8NKbfRFP6Oo51Hj0cW00mExjFqQpBRYdQrtvY6Eu5sayHM5T64I2uAtcXO9xaiU
         8HLeQfzro6F7R7hAGW5jRhLvKBw4E/Ixqa/CYkMuWRKNXqVM+fkD3aVMV2+wD/5APVBi
         NW5I3wEcIUs6jmzmGKTe6dMYHppKH76EafbDf/nvcJ8fA8bwfWaDBVP+1sdbQozfQYL7
         W3JZrhkFSmzGjIos/Ms4eSRGnUA+38ckzYHobfPqRXnIPJBnBRztjPgpvPq6aYYYmDkk
         nJEvPeV5GUm1+gDIA/Kf7eKKRILCc6uejuJzYXw2zmd0D3XRw0rX2GXGWGScSFtNTSlz
         CNig==
X-Gm-Message-State: AOAM53106+0YNT791EhFqYHRPgvn1Ht91vTMoIKDztV3iUIBkfPq8O5p
        /hDY6B1K+d6JYLdU5a5r15mc86COwUKJIjJOHgp0XQ==
X-Google-Smtp-Source: ABdhPJw8ntNewUe3WzcD7bi7C8umTwXUMW2bj96iebG+KrEjIdXnwc94Jzl4KA2EgjkxOGFXRAH2XpWHzndTYnXfviE=
X-Received: by 2002:aa7:c78a:: with SMTP id n10mr22185210eds.239.1619458676007;
 Mon, 26 Apr 2021 10:37:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210426072819.666570770@linuxfoundation.org>
In-Reply-To: <20210426072819.666570770@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 26 Apr 2021 23:07:44 +0530
Message-ID: <CA+G9fYut9RpR+ciV7uX7zfpRW8=knqgHY3XeuJJxnBTCVYcvLQ@mail.gmail.com>
Subject: Re: [PATCH 5.11 00/41] 5.11.17-rc1 review
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

On Mon, 26 Apr 2021 at 13:15, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.11.17 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 28 Apr 2021 07:28:08 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.11.17-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.11.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.11.17-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-5.11.y
* git commit: 847f63d2d71067175476a525cd35c5520e66f466
* git describe: v5.11.16-42-g847f63d2d710
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.11.y/build/v5.11=
.16-42-g847f63d2d710

## No regressions (compared to v5.11.16)

## No fixes (compared to v5.11.16)

## Test result summary
 total: 83400, pass: 68313, fail: 2671, skip: 12150, xfail: 266,

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
* riscv: 21 total, 21 passed, 0 failed
* s390: 18 total, 18 passed, 0 failed
* sh: 18 total, 18 passed, 0 failed
* sparc: 9 total, 9 passed, 0 failed
* x15: 1 total, 0 passed, 1 failed
* x86: 1 total, 1 passed, 0 failed
* x86_64: 26 total, 26 passed, 0 failed

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
* kselftest-ftrace
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
* packetdrill
* perf
* rcutorture
* ssuite
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org
