Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B56B3D8884
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 09:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbhG1HFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 03:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbhG1HFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 03:05:03 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB81C061760
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 00:05:01 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id da26so1834902edb.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 00:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cKhgY1APh6u7WRd7JINYXQE2NYePg4Fciw9h6NBd1sU=;
        b=llICbczqrATAT9EBV/lEVzhA2TH9YyrHoX5ozdD7CK8UvT188Y+fPpuwu4cwuOzinW
         B46k5aEumcBW5q0y70u20B/FoQLqBzMAC1p3oVejx3vvm35XZzu/Gy6ahiFkNQCFyUYB
         Zo2ERsi2Dlj802M5meDle1CAF0zTVLpJr1j+XUHkmdt9p8B7WYiyqT28aDsQ7YOaL36g
         Q99L7Fan0kY6ztGYl+GtNmVidWLzCo906Dl5vh6JBLfyqjRO37ohJy9KBGBE3pEqi5yg
         r3rlEhEyuYM6XYYPH5MzitvpmBsAwKq5lhMf4A0gR6O1mDvt5kgijjnIFUjGBAkJ6T2b
         RfPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cKhgY1APh6u7WRd7JINYXQE2NYePg4Fciw9h6NBd1sU=;
        b=FC2Jyr/8M/pBca4eHmS4tWsRC0RTul55fyngSWrraLI1nNwXeqNYBSF62dgmNnm8Gp
         vFad64bGveHQpevjSv9kHL0g39kvw7q6iEpPowVndVq42DQqGKvVFys2tB1Nrn/or/sA
         UxFLOZ/Ks7LDtKyH+8Sg+f2+GN3OvGwyhKohgGXbqYfINuf2wzZTXiEhzaBd/h49neSa
         s6oM6nepbSJ8DUuZBTY0Xfhcv8OgvmzZB9zV1rqQ9TUWtL746fBwcNF0jAoREFBohnE7
         +SaLd/q60af4Yl8W7uyGKlabZSd8YESPOelCKXIMeRnr5q4XE2tcjCb2a6tSPQLQVIIh
         HFsQ==
X-Gm-Message-State: AOAM531MuqqDnidKuouPq3S14p6niEHoRICp6EkLdMWaO6T58o21yOnx
        DqAvNwVwt+gi4v3PkA6I7yrwywEE0nizr5b0U4bFBw==
X-Google-Smtp-Source: ABdhPJwwwDVBXtREuKoUYNMQlmHHS1IS1VtQtH3+aUxiYFYwUvMBa+RsaVWXbC+O1JSBw1bZEyPTnLYp/xjgAQWVGSg=
X-Received: by 2002:aa7:cb9a:: with SMTP id r26mr32666305edt.78.1627455900283;
 Wed, 28 Jul 2021 00:05:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210727061334.372078412@linuxfoundation.org>
In-Reply-To: <20210727061334.372078412@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 28 Jul 2021 12:34:49 +0530
Message-ID: <CA+G9fYt8UAz+ey9bej4_gJ+5aCYyKDO121-ZjzVw+LTiV-HcVQ@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/46] 4.4.277-rc2 review
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

On Tue, 27 Jul 2021 at 11:43, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.277 release.
> There are 46 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 29 Jul 2021 06:13:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.277-rc2.gz
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
* kernel: 4.4.277-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-4.4.y
* git commit: 33db885afa37349d2872aa265bfa7b936f83d709
* git describe: v4.4.276-47-g33db885afa37
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.4.y/build/v4.4.2=
76-47-g33db885afa37

## Regressions (compared to v4.4.276-48-gaf1d085ef55c)
No regressions found.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## No fixes (compared to v4.4.276-48-gaf1d085ef55c)


## Test result summary
 total: 45368, pass: 35683, fail: 351, skip: 8074, xfail: 1260,

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
