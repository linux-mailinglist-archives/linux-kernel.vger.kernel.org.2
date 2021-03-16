Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B43133D37C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 13:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237571AbhCPMDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 08:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbhCPMDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 08:03:02 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D352C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 05:02:59 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id mm21so71609089ejb.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 05:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iPXR+AktNqrwbXoFSMKJafZPW/qVzp+J0tB5dSvdVJE=;
        b=qV+w76FJKuOM5pWRfhIz/X64Jpgxx+UL3OczdVFqZbRwXxi4ROyJcj/R6vqmDEcqBw
         ms6hcifAzM8yvT11trjCE4DY49FMsLIB6Jo39LH/YwLimkjOysNO9TZA3NzMDcawfh/t
         ZN0PlfY5Z2ZrCm052XruJcDgk3QXYplDVliIaBh1utj7AZc+JGlf4V11w01Y6rc6vuhB
         pPz2LoZZyMCInw2UL3pE01YWFK52BU4EoZzniMSdM4aMmEKI6c5+nKU7Pjn71EtZBGGn
         nWbGGNHpuJ+CXiMsTL4kCnu04nkz9sgSFAN5qXJSuo73Xymvcp/JpxN9lR3oWc8YaJPq
         1JhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iPXR+AktNqrwbXoFSMKJafZPW/qVzp+J0tB5dSvdVJE=;
        b=H90ZvxxNf+WvAr1ZzKzkfYfM5A8W60OX1xWC2qYMKnHnyUygsIiaopQPAcGUV4VQ+P
         19FZqfxxCtU2MjzZgJbMzi/zOg2nh6LgcS7W24lHDetj0rioB0zpCBAL+GJf0vSgK97Y
         3GOWMJL8FLpimxoaeNJdJ7wXE2O616KjFwEhxhGMt718BbEzjZiwNotNxKIsTOqTiWxr
         9VkWZSKKKEZFyuNcHGa37+3HBWpG5dVJFulXwBdrKTUcsbLRZUPeR04ZfIBsV/P9Ia4S
         mqFV3XyNvzJ2LOEMydQxmrKIjosrwdWnVBvSEfT7dE1g12+w6XPniQxx7YCxwNkNbQzN
         tBcQ==
X-Gm-Message-State: AOAM531X8T5cctbSi+Z1xw+IgAzf34XvQAeu6EL20digTbW7p/HDOP9S
        LgK+1uG+gb0X4/iSNtBt1q6W3nPuJS1Ql49aCHX0B1L2MODv8/ML
X-Google-Smtp-Source: ABdhPJxvnmKURFAs8b6W8bPA/FkKND/34KcvIRdQrUh4fhl84vjtYB+HBwH6hHQ/KSgPC6vBGBc8QNjb4GLKkOubQ3U=
X-Received: by 2002:a17:907:7785:: with SMTP id ky5mr17743901ejc.133.1615896178034;
 Tue, 16 Mar 2021 05:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210315135212.060847074@linuxfoundation.org>
In-Reply-To: <20210315135212.060847074@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 16 Mar 2021 17:32:46 +0530
Message-ID: <CA+G9fYvsDpz+PaznUbW=UmMC7n6QA3k+r74x5N-nmbEHSE1enA@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/78] 4.9.262-rc1 review
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

On Mon, 15 Mar 2021 at 19:23, <gregkh@linuxfoundation.org> wrote:
>
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> This is the start of the stable review cycle for the 4.9.262 release.
> There are 78 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 17 Mar 2021 13:51:58 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.262-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
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

kernel: 4.9.262-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: ed0b71399e2dfd89140732fd60d9435b266598c4
git describe: v4.9.261-79-ged0b71399e2d
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.9.=
y/build/v4.9.261-79-ged0b71399e2d

No regressions (compared to build v4.9.261)

No fixes (compared to build v4.9.261)


Ran 39751 total tests in the following environments and test suites.

Environments
--------------
- arm
- arm64
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-64k_page_size
- juno-r2 - arm64
- juno-r2-compat
- juno-r2-kasan
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
- x86-kasan
- x86_64

Test Suites
-----------
* build
* linux-log-parser
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
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-splice
* kselftest-static_keys
* kselftest-sysctl
* kselftest-timens
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-zram
* libhugetlbfs
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
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-tracing-tests
* perf
* v4l2-compliance
* fwts
* network-basic-tests
* kselftest-kexec
* kselftest-sync
* kselftest-vm
* kselftest-x86
* ltp-open-posix-tests
* kvm-unit-tests
* igt-gpu-tools
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
