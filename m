Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C828B44299C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 09:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbhKBIjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 04:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhKBIjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 04:39:40 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B4EC061764
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 01:37:05 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id f4so14968920edx.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 01:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5AYeyLVdWzdnhW68S0bFY6KePLMB8RlIP6h4csX7Vl0=;
        b=IhnYxbjbKVyWXXbdkTGHaB82V99evla7PH0nv6L6LVOjywmMWXtAf8FQLgDp0C+84b
         oLV4tx45EvUaVKboIiuXA6BpWTU4wNuBGvJ4QZRTY78pRXsAzViShRzWYZqez8E1m+Oq
         L6U9YMAvPBRMpE61K6qIisw7WenjklFOzxKHcckBPhuwi4F969yg6mKpuQB5TrE85saU
         qyC9gZqNzdZwNGNeondnrGO+g+l831IgJNqaPilEazXZZWe2Mf31FRzCuuq0uwPeofs9
         2dLo/7Vk6M1IALkXXwmbTW1dI7jIDwTjUf/m0roCIn0uGda7U8EkFd8PuWyv0OwAVRza
         O8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5AYeyLVdWzdnhW68S0bFY6KePLMB8RlIP6h4csX7Vl0=;
        b=5fjZwaXOQ1eH1jnhLsIojeea/3YxCzImmz55HZ+/wmzvkwsEAagBYqoLpsPdKOkMIs
         /Am3QUCHZF3kYo23jleoroiWu9n2ns6Y0b41hy10sOUCtWOE0pJQ4IDmdkagOSw4rwVu
         nHxkJEgWy5NqgtmqE4F2kSabB+8AIS+9Ngp7yZEatmFvi0IpjXrk+dO8PYnRoZEIOMTB
         RGVDXWE7pcuCZl/m00ZW3FZUNcMLJvGIry/vIdhIp9UoLzuBNyv5le0a2C70jOj+ID5w
         m70hKv1m4o2+/2fE932tp0g7nFN/edxlJJieW8fn1pmbW9mEtOig4hd5gtnhvoKtkWd7
         tNJQ==
X-Gm-Message-State: AOAM531v9NH+Zt6Ahu+Qnz0N0iefk1ZwBY4z7xy+JIlaMQ5YgYoXtsvm
        Ju7fh6a/OcM4wzuTOnRUSUTGcqFReUetVowe6ZZJkQ==
X-Google-Smtp-Source: ABdhPJziNOsai6wcPm+hxMxTb1bY2WEIqzSnLrMSMLLCMZgjctOmriIDpmfYSOQDKgFz3VA7XphIzgLfk4h3F0VP2sM=
X-Received: by 2002:a05:6402:5204:: with SMTP id s4mr14363361edd.182.1635842224068;
 Tue, 02 Nov 2021 01:37:04 -0700 (PDT)
MIME-Version: 1.0
References: <20211101082444.133899096@linuxfoundation.org>
In-Reply-To: <20211101082444.133899096@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 2 Nov 2021 14:06:51 +0530
Message-ID: <CA+G9fYvOxQ2L45jQN=TV3S=UrgkxgTPmgiVyXL6Ok9zs1gFEuQ@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/20] 4.9.289-rc1 review
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

On Mon, 1 Nov 2021 at 14:50, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.289 release.
> There are 20 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 03 Nov 2021 08:24:20 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.289-rc1.gz
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

NOTE:
With new gcc-11 toolchain arm builds failed.
The fix patch is under review [1].
Due to this reason not considering it as a kernel regression.
* arm, build
    - gcc-11-defconfig FAILED

[1]
ARM: drop cc-option fallbacks for architecture selection
https://lore.kernel.org/linux-arm-kernel/20211018140735.3714254-1-arnd@kern=
el.org/

## Build
* kernel: 4.9.289-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.9.y
* git commit: d353d4ac36c75b17763e36cff9fc912b94d27a11
* git describe: v4.9.288-21-gd353d4ac36c7
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.9.y/build/v4.9.2=
88-21-gd353d4ac36c7

## No regressions (compared to v4.9.288)

## No fixes (compared to v4.9.288)

## Test result summary
total: 75148, pass: 59231, fail: 615, skip: 13038, xfail: 2264

## Build Summary
* arm: 260 total, 210 passed, 50 failed
* arm64: 35 total, 35 passed, 0 failed
* dragonboard-410c: 1 total, 1 passed, 0 failed
* hi6220-hikey: 1 total, 1 passed, 0 failed
* i386: 19 total, 19 passed, 0 failed
* juno-r2: 1 total, 1 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x15: 1 total, 1 passed, 0 failed
* x86: 1 total, 1 passed, 0 failed
* x86_64: 19 total, 19 passed, 0 failed

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
