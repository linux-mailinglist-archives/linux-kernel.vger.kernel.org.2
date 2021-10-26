Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0262B43ADFF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 10:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbhJZIbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 04:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbhJZIbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 04:31:48 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEA7C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 01:29:24 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id g8so9946218edb.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 01:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TKSuloFwITpfhCZzc/sb+pIZGNH7vfUGpgnayb9U7cU=;
        b=AeqpWTTWD88b4M6IyQCUNL1sYG77a/kFmg2hlJkv5GBrT3MVYGOxrA6BrA5/3PBJcA
         RkrNmymE1pLTLLrqVRbz+c/m4rEzKImBd9WbO6Ji0dLB79CWU3UA0ZJydszQTn4dNFuN
         JQbMBY++aQ0Fi0R5GrAbAI/MMAuJvsh8TfEaP7R/jtJKClW73Hc6ZOapTw+eWw0ZMpZF
         iriM/wbmaTtYgWHeAtX2BcIvg0X5Ea0nAA7XK7WaCJ1OiC1+koSpC5xQUuuSD79tS37R
         X0KCN1g/qq4ic8dM3earchn+I4vdkgg2HJZPQu0D9jY+NM0TsL7TnS9V6yy1k2HNgzX6
         6pkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TKSuloFwITpfhCZzc/sb+pIZGNH7vfUGpgnayb9U7cU=;
        b=xGdVCBcKFDXngMO/8yv1aLQCFVkSBjS/qmgFaQpLexlKtz5LCxCvsa6ol6EwRVfuFU
         GJH5PcSxPX1GNrh0nFWYewWUuizZ6rSVVaV9fa0prqaow+h9josaiIwZYVlTPx5WbqZI
         DKWOiWggTwr9FMhxzWKIlZbSmzLxtAA9SaUQSuyQec0q+X0e9hrTC6fxUx1azuhyqzZI
         9lY4dwuzI9fPucVhVNCqrZsjc4Tmcv61OfpKh4jxPmy4ZdPnuikek4xHK8EOcniG68gT
         Qr4wvt6WQF6fXwVWBFcPfwpO68wISyZiheRqVfPt+K9QvdDZWOpJ0bwzOMq6sOjhvY6t
         Y2Hg==
X-Gm-Message-State: AOAM530vVrgl8Ac8mo1s6IC6lv11JtWSKq+UJSWAvX27OWSGCVXjW71h
        r2NvdeIbqdqV1WdrrYtMzcqOfT2oa5EyjQCz+u2qPA==
X-Google-Smtp-Source: ABdhPJy1sIqfzOVrgzNfKdE67cqFjSk8fXRtSNk83pU0kiWnuT2i8EpnmHl01K+0V6e9OciPfS/3yTfnnDh2MhCWOcY=
X-Received: by 2002:a17:906:c7c1:: with SMTP id dc1mr29346749ejb.6.1635236959071;
 Tue, 26 Oct 2021 01:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211025190937.555108060@linuxfoundation.org>
In-Reply-To: <20211025190937.555108060@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 26 Oct 2021 13:59:07 +0530
Message-ID: <CA+G9fYtftTyGNYFxVkjVUQODdCJcWzHBqcwyT8P=_DB39bX0Kg@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/58] 5.4.156-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        f.fainelli@gmail.com, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        stable@vger.kernel.org, pavel@denx.de, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, linux@roeck-us.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2021 at 00:56, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.156 release.
> There are 58 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 27 Oct 2021 19:07:44 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.156-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.4.156-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.4.y
* git commit: 392d7d5e7dd0d7102d4ca92158bdf3ffaaf19292
* git describe: v5.4.155-59-g392d7d5e7dd0
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.1=
55-59-g392d7d5e7dd0

## No regressions (compared to v5.4.155)

## No fixes (compared to v5.4.155)

## Test result summary
total: 85949, pass: 70713, fail: 820, skip: 13198, xfail: 1218

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 288 total, 288 passed, 0 failed
* arm64: 38 total, 38 passed, 0 failed
* dragonboard-410c: 1 total, 1 passed, 0 failed
* hi6220-hikey: 1 total, 1 passed, 0 failed
* i386: 19 total, 19 passed, 0 failed
* juno-r2: 1 total, 1 passed, 0 failed
* mips: 37 total, 37 passed, 0 failed
* parisc: 12 total, 12 passed, 0 failed
* powerpc: 36 total, 36 passed, 0 failed
* riscv: 24 total, 24 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 24 total, 24 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x15: 1 total, 1 passed, 0 failed
* x86: 1 total, 1 passed, 0 failed
* x86_64: 38 total, 38 passed, 0 failed

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
