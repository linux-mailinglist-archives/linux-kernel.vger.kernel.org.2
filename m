Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84396361F27
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 13:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242982AbhDPLvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 07:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235498AbhDPLu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 07:50:59 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FCBC061756
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 04:50:32 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id j12so6880100edy.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 04:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Sj9F+4m0QBxztbTpUZBY4iguQ75hWMqv8Hn35qn3Kqs=;
        b=mYCnARdQtVCgcGuEaWSXIqQALIsUVH3RynrAHX4tx8Vy8XutxYjPsXVK8bnm3bOEEd
         /QZxHesDNycqjp3mb+jlo7p8tRO3EkAQ5/lRCpkvKTabEwhj/kJVCYKJDfT800k59g7W
         S17qLmzEpG3F40eV0u0qecyA27DelutJ67m/2+2bA4RDuy+TuCfuDd5uKsx+o+gspKxj
         b9ipU+h5cA2E3XIQmAp9Ido3kjBpwQgX5JBCrMPLp2HKQBwPUS65wUG1QP0fxHVAScMF
         +UsEYQ6PCgvw0jmPRl6S8Fy0AJrCBvHiPJlVYTcIAX0U9hRln5GSsy02jRVWpo4dwQvv
         HUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Sj9F+4m0QBxztbTpUZBY4iguQ75hWMqv8Hn35qn3Kqs=;
        b=NHddUt6jOiIeTxgMEh2PrPuudd48LJ0Zgpr5QoVIDgEJxTuD/EICE6efGIYSvS+6bG
         7Pn73IKeolDGaA77ZjfQnhqJGSZhqXUmpJCHk4iK/RxRknb32G0r9YQsB9oWlNUWiWAV
         3FuIkw8eJLC+pSJ8kpiUxpqzNCFNQRA4+VptaPVFF3jVZyU9QCegimK+GDBGT1OmTFUp
         /oerX5lsiuY5ojBcew1GQHVIp9qC2ZZpQyJZ7aSG0bqdy3cV/CdXGySgM/VRFFQv6cvr
         UpLlyz+33sr3KWVNakC094qvMQSy1cGqApQg5v/jHRkMlQSl51jCOokJtMAHjh6e+lKb
         5aWg==
X-Gm-Message-State: AOAM533/DUtTGptykY6KgonjIq0K+VSxnUQ6hwi6aE5W43HSTqMudJdw
        RYQCa74yKHg1rQBIHOYnpuaV+SjcW/+0utJeNJb8bJHpm/OcLKWu
X-Google-Smtp-Source: ABdhPJyCNVHpzTZNInTDjK0MQL3tRDaPqUL5G1ap3ba57Y/iQSFwHULoODNJq2+VhZ4VOeFsCnxuy0DOE6IM3dQs7BY=
X-Received: by 2002:a50:c3c2:: with SMTP id i2mr9424884edf.23.1618573831269;
 Fri, 16 Apr 2021 04:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210415144413.487943796@linuxfoundation.org>
In-Reply-To: <20210415144413.487943796@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 16 Apr 2021 17:20:19 +0530
Message-ID: <CA+G9fYvszXaHxPB4ApT2t+ZU5Emm8yABhk7-zeSumbkBTqUTdw@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/47] 4.9.267-rc1 review
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

On Thu, 15 Apr 2021 at 20:23, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.267 release.
> There are 47 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 17 Apr 2021 14:44:01 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.267-rc1.gz
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

## Build
* kernel: 4.9.267-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-4.9.y
* git commit: 5183cf83a541a4684e52ca704658b93e63fdf243
* git describe: v4.9.266-48-g5183cf83a541
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.9.y/build/v4.9.2=
66-48-g5183cf83a541

## No regressions (compared to v4.9.266-43-ga0c17d36dea3)

## No fixes (compared to v4.9.266-43-ga0c17d36dea3)

## Test result summary
 total: 54076, pass: 44392, fail: 544, skip: 8849, xfail: 291,

## Build Summary
* arm: 96 total, 96 passed, 0 failed
* arm64: 23 total, 23 passed, 0 failed
* dragonboard-410c: 1 total, 1 passed, 0 failed
* hi6220-hikey: 1 total, 1 passed, 0 failed
* i386: 13 total, 13 passed, 0 failed
* juno-r2: 1 total, 1 passed, 0 failed
* mips: 36 total, 36 passed, 0 failed
* sparc: 9 total, 9 passed, 0 failed
* x15: 1 total, 1 passed, 0 failed
* x86: 1 total, 1 passed, 0 failed
* x86_64: 13 total, 13 passed, 0 failed

## Test suites summary
* fwts
* igt-gpu-tools
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
* perf
* ssuite
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org
