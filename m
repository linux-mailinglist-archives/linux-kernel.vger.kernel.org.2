Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823FD40A6B2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 08:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240139AbhING05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 02:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240054AbhING04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 02:26:56 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59EFC061762
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 23:25:39 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id g21so18142496edw.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 23:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dRNiDC7YLs5heF9NcfR3kRhzSMIb5odMrKovtse3vZ0=;
        b=TfNPXtb37/ctK/4DAPOe/UQzIAP8tujP01WQDhiu4XxlSP9NsLwAsRhGrff/fOwP6x
         KvjtKG3Pq46pE38LvWcgKTK/6iGlDuL3bkJX+hphmZ5OFHtyLjFK34sF6XOoSIUYqwdb
         1R4dZmkU1Tanex2tZkBfsSBAkE/6brNrNfTLu/zLERmDGA2XElrczKMqG5PTzYZHaX30
         z7fngl7M5eak0Y4jucGbkYRTrixl5MC0TnKXCG1AehKyu7SlM1ckYbV/KKtgL2QL3gew
         BnyZkZKqe4tf7b5yXzy2g9urGq3FwIdwcTlOZi30aydlhu5X9fyXRVP1MvtTBHFCuwUV
         IYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dRNiDC7YLs5heF9NcfR3kRhzSMIb5odMrKovtse3vZ0=;
        b=Rokxh+S4ZSi9xQrIPq6rI+NPNFSipb5UXiNYl9PawuFHcmGy62sJoaEnnpCWozb+uE
         hkXmfARy7mBr9XzhR4MAGZNsFmntenTwNZHTFZzE+PUusbulf5cE79TEKulSsqO/LCQV
         dRt14k/yHqP791cWePR9TwI3XQJtFGyi3VoqETtQzwHsKd4O9NBvxQ7Pxx3MjYZ5yetJ
         KAPn/APKfn/8HUaw1EoqxS1U05QepuH5TnpNCjJiHuqn3/GllZU9kJoX09AjdfE9880q
         Zm6VW2F5kOZtxsYhC2c99WqUq7OsaLVQq4HdnJwmuPa2HsXM9uVQj1azlNo0CZmfsujY
         OQFA==
X-Gm-Message-State: AOAM531/rzX82Bh8OzzBHrxYhH5dmT79woTDZmG/84KlSobkdE1OmxSD
        q3hVJyVoI8SlJ/XslqjKvFJGH/QAubo35a6L1I6ZXw==
X-Google-Smtp-Source: ABdhPJzmWKzZmBP1pEjQIcGKkCAAXcKhcY+v43u2I/h9tGtB3r0vwJL8GJcy7Q4XC1BD4AqLCfxyurN+PsUjKy78SH8=
X-Received: by 2002:aa7:dcd0:: with SMTP id w16mr17554934edu.288.1631600738232;
 Mon, 13 Sep 2021 23:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210913131100.316353015@linuxfoundation.org>
In-Reply-To: <20210913131100.316353015@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 14 Sep 2021 11:55:26 +0530
Message-ID: <CA+G9fYuW0Z=NxY5wHrb6J0aWH393iDt=DafLQ8tYpHd6e5YY9w@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/236] 5.10.65-rc1 review
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

On Mon, 13 Sept 2021 at 18:54, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.65 release.
> There are 236 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 15 Sep 2021 13:10:21 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.65-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.10.65-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.10.y
* git commit: e306b25768e344bf338aeb3b1439af89af21b31e
* git describe: v5.10.64-237-ge306b25768e3
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.64-237-ge306b25768e3

## No regressions (compared to v5.10.64-215-g5352b1865825)

## No fixes (compared to v5.10.64-215-g5352b1865825)

## Test result summary
total: 89197, pass: 74790, fail: 603, skip: 12826, xfail: 978

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 289 total, 289 passed, 0 failed
* arm64: 39 total, 39 passed, 0 failed
* dragonboard-410c: 1 total, 1 passed, 0 failed
* hi6220-hikey: 1 total, 1 passed, 0 failed
* i386: 38 total, 38 passed, 0 failed
* juno-r2: 1 total, 1 passed, 0 failed
* mips: 51 total, 51 passed, 0 failed
* parisc: 12 total, 12 passed, 0 failed
* powerpc: 36 total, 35 passed, 1 failed
* riscv: 30 total, 30 passed, 0 failed
* s390: 18 total, 18 passed, 0 failed
* sh: 24 total, 24 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x15: 1 total, 1 passed, 0 failed
* x86: 1 total, 1 passed, 0 failed
* x86_64: 39 total, 39 passed, 0 failed

## Test suites summary
* fwts
* igt-gpu-tools
* install-android-platform-tools-r2600
* kselftest-android
* kselftest-arm64
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
* kunit
* kvm-unit-tests
* libgpiod
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
