Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E76043310C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 10:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbhJSI3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 04:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbhJSI3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 04:29:31 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E59C061745
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 01:27:18 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g10so9678482edj.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 01:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Msx8Er3aKiF5Q8imFAG7GDDWqMBTCqqf3LXu8XEy/B0=;
        b=aP4IsvSWAsy222gOq1bSASCLsnBIbCEYboEf6AiOL3xVmUrn4j52AkQ65vPQNGdSmH
         3g9tMH+EJzkbdWXpaayw7lCa68F1Jw1H02pJ2X1GYZlb9DwToo6Wq7yLUFDTZJLNirdc
         cs1nNgDr9NfxL2QBH5rtPpVg1JNQBY8c2w7zyqDsAQtuVRNlvGcTmyvafgqwgzo2+IjC
         hVQrFGGWDUTYnoBnwCd2Bs23nxWYcmjNr3o2Tvuc/ce72T8ghcXY8vMHxjmOqxDVX2A0
         j0R3OLBNcj7kejojlaTXwjjDBCXXUgEYQGMYG4RsqzasJdrJI3zxokM7HbA1tmnYN3un
         SKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Msx8Er3aKiF5Q8imFAG7GDDWqMBTCqqf3LXu8XEy/B0=;
        b=gFqR3T0jYl93InzKike+/b2r5xwA4Y2/WHz/H5BBOS303pObQHnSA1W4phGjMb/RzC
         63Jne8WOOYl2PgNr+cRTEXFj22e/4WFwtbbKIpC3gAaFKfx2j+b2uyO484M0V79OzHMR
         C7phxb9wfKtsxDD8v0eCI54XYVR20JUHGpwMFxT5klUZXDobQPjDX5olfT45GCgVPXlB
         vnzwhHaRldHcLSymoOOxBmdmfZL3ZCMqsM998JxhOjDJlXTlIhbELU628uiv8xU1Wlft
         3ZtSlTglbOFqkHrQkOqiT75AZukjJ6bIHY7gE9D6zmRIbwGe/OQ2FAPQSCVQjZ2FzbZF
         6i8A==
X-Gm-Message-State: AOAM531yvxhlHOELle0TfJ7tacgh3F00CHRkBUzljh5iuI4f+/rIElrT
        l1z09HtA+nzqyaSP2ju1pxDiNtwVc51E2d1GGm0nkA==
X-Google-Smtp-Source: ABdhPJzyoCAWBviB9qB+Gq9M5VUliKxINqgazMN+dc/k4gmVOm5q88JXN7URwzHmOBLYyRZupXls8VrXAtakHcDW3WI=
X-Received: by 2002:a50:bf07:: with SMTP id f7mr52034469edk.288.1634632033488;
 Tue, 19 Oct 2021 01:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <20211018132325.426739023@linuxfoundation.org>
In-Reply-To: <20211018132325.426739023@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 19 Oct 2021 13:57:02 +0530
Message-ID: <CA+G9fYurG_mJ8LMOrOdF1M_RdTODYz9TbMFEF=rQ5-9rE2m1SA@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/39] 4.14.252-rc1 review
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

On Mon, 18 Oct 2021 at 18:57, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.252 release.
> There are 39 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 20 Oct 2021 13:23:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.252-rc1.gz
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
* kernel: 4.14.252-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.14.y
* git commit: f772f5cdea8646ee293bac8c4e702ad235969ecd
* git describe: v4.14.250-74-gf772f5cdea86
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14.y/build/v4.14=
.250-74-gf772f5cdea86

## No regressions (compared to v4.14.251-7-g23de85e22f4d)

## No fixes (compared to v4.14.251-7-g23de85e22f4d)

## Test result summary
total: 61585, pass: 48676, fail: 514, skip: 10650, xfail: 1745

## Build Summary
* arm: 129 total, 129 passed, 0 failed
* arm64: 34 total, 34 passed, 0 failed
* i386: 17 total, 17 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
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
* rcutorture
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org
