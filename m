Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE2F43B32E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 15:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236241AbhJZNdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 09:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235207AbhJZNdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 09:33:54 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A9AC061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 06:31:30 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id u13so14400964edy.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 06:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Vund6HcNyB+dVo7kBTNiXeBQrXIx8M30XxuxpsZtf4k=;
        b=MLuG4G2giQZS0n3RZL8U2uYsIyuHeyEGOwhTS4MeRLg13KkGuLY9KCaOTMWjeBcLLT
         F2EUiiZVFjelkxh4o4ARuAPyRicx2CEtQdhPTPN3iekHdPTPBsyIXFL1Fxhk8iQE4nzo
         E5sD8MLN3e05iN+dUu2XnzqKvdJNVXOuypzfe0orrKbj09WP/6MG76VSktJrkJwdb0wN
         4mIy8k1Gy7qkXieH+Xvr+OpIGzHQ0bT6LiVe55ZOJ7PDHag/AwEehNXV82EPEbNnPmjt
         BEthP9omsrygAa6mQ5EIYY0hSI94V7W4w0fyhfqz4aHEWUo18++rpm8bvoZXWADj2ych
         w7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Vund6HcNyB+dVo7kBTNiXeBQrXIx8M30XxuxpsZtf4k=;
        b=Yo1rBJevRIOfdDX90I34sinHGkh9nlMKKveVC0XGKVel3ERPWwR7ptmt6InisdSxVu
         R9JX0ciMo4bQtxcVl7sK89YH0MT1pvMFTAm5o9qUiQHP5mjxMgeDhqFpliyVr1QW4nhk
         foUbzYmSW/WVSxj41VO/pf79rHuqg8Y43EiP/K+noBck1G/mYKDp6FjJhnUabYIFaOon
         CEJiGpZUlLIkEdI4afqGGA8z90rpxF7GiGChwHIEnvYa4PPpPA+C6sEn5PK1nQwGPZtY
         +yLflRSRoivHqpy0jXMQr26+z7hfGb3tWDX9PMJC1tUbn2czI9dg2EqpDDhvTXXA9fde
         FTlA==
X-Gm-Message-State: AOAM533fXUMBGDlWOaW7o6FjSrjZer9x7waGkmP9Bc6QwZL1w0pFkxjp
        ymbgWVDUErzXJUjsqq0wAvo6h4uMBrI+ewb1Vb27kQ==
X-Google-Smtp-Source: ABdhPJzmY76D+QmfHUmuY6EARBld/NweGOVr8diCOusLIK/ttVNBfPoxrpX6YZxSqSGht7ibbDiJl5vRykMkuxpOUmw=
X-Received: by 2002:a17:906:9f21:: with SMTP id fy33mr21640961ejc.567.1635255055521;
 Tue, 26 Oct 2021 06:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <20211025190922.089277904@linuxfoundation.org>
In-Reply-To: <20211025190922.089277904@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 26 Oct 2021 19:00:43 +0530
Message-ID: <CA+G9fYtY_HrY8W-NiMf4rp0yAJTWj5qdrooxOOq1fya9EC=duQ@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/30] 4.14.253-rc1 review
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

On Tue, 26 Oct 2021 at 00:52, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.253 release.
> There are 30 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 27 Oct 2021 19:07:44 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.253-rc1.gz
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
* kernel: 4.14.253-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-4.14.y
* git commit: 5e416f8aa1bfc3905603b3a239a89cb8d0b88b77
* git describe: v4.14.252-31-g5e416f8aa1bf
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14.y/build/v4.14=
.252-31-g5e416f8aa1bf

## No regressions (compared to v4.14.252-27-g107227b9c5bb)

## No fixes (compared to v4.14.252-27-g107227b9c5bb)

## Test result summary
total: 76677, pass: 61017, fail: 785, skip: 12696, xfail: 2179

## Build Summary
* arm: 129 total, 129 passed, 0 failed
* arm64: 34 total, 34 passed, 0 failed
* dragonboard-410c: 1 total, 1 passed, 0 failed
* hi6220-hikey: 1 total, 1 passed, 0 failed
* i386: 18 total, 18 passed, 0 failed
* juno-r2: 1 total, 1 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x15: 1 total, 1 passed, 0 failed
* x86: 1 total, 1 passed, 0 failed
* x86_64: 18 total, 18 passed, 0 failed

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
