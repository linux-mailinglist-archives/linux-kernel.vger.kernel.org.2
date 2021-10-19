Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2DE432F04
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 09:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbhJSHNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 03:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbhJSHNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 03:13:38 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF334C061745
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 00:11:25 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id ec8so9032717edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 00:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wjx++QID6+axunkIQ2dtgiBAIR6rikeXXl5ZgjaKWnE=;
        b=VydO6SaG0h/jrtWIwo2XfQKcmxMvyjevQDRzdVPeaN0eNBLz8l/X3e2XeUXOWYFEXP
         bm+MbgyJ/j1sTlKYAvjE1noKVCH/ikgcyDsGzE4K21Tos4olsIm1cvIFgQj7f7xKkq3R
         JxsL3HFPhsU6JU/tdxO2hUdYzRMmwzkWMvkd9Jymplj9Lsg7K3+lt5g1+h159xRKRf5t
         +0WbdsWGFP20IDkYwqYCMIyARiio3WZ3G6WrYdqkAbRpgRfACL1oeaCDROUv094dUAuw
         vlyl3alh3nvnqVndHzlOl0kiBvmTepagUNs7tw3eBBZbp1w+kHdNPMY7yJddXp6Sl7On
         K4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wjx++QID6+axunkIQ2dtgiBAIR6rikeXXl5ZgjaKWnE=;
        b=BS2YIwF5FqFslDNLUBh6roTXm1+Grygv6KqjEU4byNRtKSn1U6AlU8ajrsKSf8V5FS
         tg+C0pP/gCRcMOKfIi9dQ5KipDIxP1sPFHde3TfsSm0tKcnYJQ2yxy0280+sWsMrv37t
         CrsZdcR6DJ74Wy/2nbDl3GlmTOVy2QaotohLHy8T/PDuYhCk4acsPw1eRPKPDMI3hf4U
         Ga5GZ1FrRO6NnZDiDETLMTljEvZPwXdRe9KTrV3rQplMiVIc9XstJdX1tvke724FgulU
         LB6051pVSqX3QMQDXduALDJX18tgIWb/iS1wxc4g0s3wb3CTJ2te3kP0t/1jaLa914eH
         UJ4A==
X-Gm-Message-State: AOAM533md3Qeh/CCwjtMfE5M62jn/IcI0iH9Tc8/HWRpsFDz8gbfAi0n
        D0+iwYpMOs4bkAGtXzlPPIXrXBfDHjzwiQ3dr8HG5w==
X-Google-Smtp-Source: ABdhPJxNrl2MuE548ewE0SNok5SUgFt1jRFh6bD6io1eB989QfPbF55fqUCtNRHVeDkn9IFFs4sciu3+rDEeSGl0tpE=
X-Received: by 2002:a50:e184:: with SMTP id k4mr52310196edl.217.1634627484142;
 Tue, 19 Oct 2021 00:11:24 -0700 (PDT)
MIME-Version: 1.0
References: <20211018143049.664480980@linuxfoundation.org>
In-Reply-To: <20211018143049.664480980@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 19 Oct 2021 12:41:12 +0530
Message-ID: <CA+G9fYsdj6-r0GZUgGpMRcXftf8ROQW49GMZBg1tMwCWQevrHA@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/68] 5.4.155-rc2 review
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

On Mon, 18 Oct 2021 at 20:01, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.155 release.
> There are 68 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 20 Oct 2021 14:30:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.155-rc2.gz
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
* kernel: 5.4.155-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.4.y
* git commit: 35f96c378e36012ea24805a5feff3276a9e84ca6
* git describe: v5.4.153-86-g35f96c378e36
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.1=
53-86-g35f96c378e36

## No regressions (compared to v5.4.154-70-gb75bde367f90)

## No fixes (compared to v5.4.154-70-gb75bde367f90)

## Test result summary
total: 94754, pass: 79354, fail: 519, skip: 13574, xfail: 1307

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 288 total, 288 passed, 0 failed
* arm64: 38 total, 38 passed, 0 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 39 total, 39 passed, 0 failed
* parisc: 12 total, 12 passed, 0 failed
* powerpc: 36 total, 36 passed, 0 failed
* riscv: 30 total, 30 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 24 total, 24 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
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
* kselftest-membarrier
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
* rcutorture
* ssuite
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org
