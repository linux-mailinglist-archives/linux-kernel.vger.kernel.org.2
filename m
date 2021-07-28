Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B23ED3D8825
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 08:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbhG1Gqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 02:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbhG1Gqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 02:46:51 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0A9C061760
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 23:46:49 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id nb11so2862661ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 23:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pjRIGe1htbdZHgyR4KVT9raJyHP9F/yxoUfa/oO0gGo=;
        b=Y7HFYjzdqt218TOc9MTYI7Dzk8GBvHNw16WH7hu6q4JafssGSD0KXOJxMivnXBIxDx
         BcLh6oJgvX0eaLb3FoWwi70ArpVA6nI8bR0Y0JACzZzfO65pqC2QMnlqQqM76H2ciQPg
         Jg+PB3QUK8pW/sJc+q0jrkHkeljSmuP3oRzPqVumwuwBK36SHrGW/RqJH1KJ5SKfQmO/
         59MSNRSO4HoSg+72M+VHBgPkDkgP29ZWeOsAzqRP2WZ2Mn1oJP3dOI6xNdfzGb/vQMbL
         ejcTzEH7JBIoKJF5wDYhzEsoNxoNl2kMfRAUgzfo6EkRFB0QrTZ07l+o+nc7sui/qPpi
         HxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pjRIGe1htbdZHgyR4KVT9raJyHP9F/yxoUfa/oO0gGo=;
        b=Z11rQXmdKETkDrZzJslwbx2bvVDPGdsIw761+MyChmJ/mEYL5TMCTdYGExaqYPBoYd
         /J/U9mI0F9vEbP/HOmzrGsa/5aeQPLKcPjp6ECC82CtoFsEfl7DIeQlOE6sLEat7UqhG
         NXgBFR0XT7oQwqFZ378ZUiEVR+MLNjPw5dyVQlhNFVrOZE59YeT4q/7LWdRu7JKvHgP0
         jkUPn60wiFa2uB/80dJPr7Xsd7JUEyCcbkh9SPZtiNFDLYsuCprtXWEstLUoHq0tavMx
         +E1fF4uW/LNr2kt4Ni15oluwSnNWWqFSPHRNAD9Zy5b6XNGXK5SW5hm+HYzMHLF7wQ9J
         wakg==
X-Gm-Message-State: AOAM533GEDIjX9/zn8zRMUKn/NldAH5wf9RgCHKkflh0oQ5C98TlTluG
        68HWoVlKfGwji5OANXq9HorOnA9MaFuAcynpocjCrQ==
X-Google-Smtp-Source: ABdhPJycUoiQJYGYojHDPEU/FGwRW4Unc6y/0nbhjP6Knawu8wNQxLHQT8RZHjhG0aW8Cg/pVj0SnNpwgvjIY1jenf4=
X-Received: by 2002:a17:906:8606:: with SMTP id o6mr2904420ejx.247.1627454807807;
 Tue, 27 Jul 2021 23:46:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210727061353.216979013@linuxfoundation.org>
In-Reply-To: <20210727061353.216979013@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 28 Jul 2021 12:16:36 +0530
Message-ID: <CA+G9fYuSJ6ScOURncp6hoaqaxKpoBv2NuvwZFUW+rGEWqZ_rww@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/81] 4.14.241-rc2 review
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

On Tue, 27 Jul 2021 at 11:44, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.241 release.
> There are 81 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 29 Jul 2021 06:13:39 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.241-rc2.gz
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
* kernel: 4.14.241-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-4.14.y
* git commit: 44bb6f3b2f378d6fdb758d8bab20d8ed0f8fe9b2
* git describe: v4.14.240-82-g44bb6f3b2f37
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14.y/build/v4.14=
.240-82-g44bb6f3b2f37

## Regressions (compared to v4.14.240-83-g449cd20526ea)
No regressions found.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## No fixes (compared to v4.14.240-83-g449cd20526ea)

## Test result summary
 total: 62926, pass: 49179, fail: 666, skip: 10940, xfail: 2141,

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
