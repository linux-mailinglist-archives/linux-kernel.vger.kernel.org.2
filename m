Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D2A3BC5BF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 06:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhGFEwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 00:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhGFEwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 00:52:05 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7E8C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 21:49:26 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id m17so4616084edc.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 21:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jELG4lIy9CnXksyY1hPYmbkLYOjbAA5UXxfHqrz9WZI=;
        b=joFF/8m84G9Q816dx4HzYLFh3yIo3QGMwj2PCof0hAyORWaeUUehIU+slAAkW8oAcP
         jmRc93sme9ghO7X4/zHUi2QcJabLz8paUL+eGkSvzFeCVc9q8rfXA4WOmZf3wi8yPARP
         hzxuyyYR7gcGBf6WfknnR35eoXGTBnEo8+AtWdmKsgmsGXr56S2mIxMVQ2JF2nnxMtfn
         8GgtfmhNOehiUve5OaLYqn6vCUQktWXE9ZnlIgK7A7PURD84rJ/d9cVtrO8wdX+fsqN3
         c9JecMiUEqabgMr6ih2UA9Z5hj/0kBqyukQETqIhu6zXGh4oy/hFJaJCJPyAPK4wlQ44
         4XcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jELG4lIy9CnXksyY1hPYmbkLYOjbAA5UXxfHqrz9WZI=;
        b=Z3W5CmdCs9WBMN7iBwNyJY/f1AzOcpUTeHMc6Q6UB1rGec8kDCT4ZfNefHgab8Xmo+
         sHBjrOHJmLv5hptu+oyVfzEMvZ430qxYn4RKy7cxm4e0YvY3utqE0QVtfhNWtiHXjTzN
         tnZh8kmh7YlOBBbjUi7TB/ADJkqAXtXYp1wVxJm+qsyKTQ87qRQuse8MiH82pjaT2UIy
         2I39iIE0ZELVBnJOFKIah/lXJcl80qIfcBL5Qa57HaMv3M0arc/AiV7gs4b4qmcsMC3B
         hFr++x4KZVTWJRmftsfEE3JNvF99lM22SfBcpHfsvunVd9EXfss9eV34s7SMSyWlYJaR
         +WVw==
X-Gm-Message-State: AOAM530qtKOOdHDiqh0AaUM/tyxCDJTU5pSbf40MNOtdtDo2HExUklU+
        U/lYpPhP+S9+wHyFaAQ6wPfx0/sWTU58wMjq3OwOmA==
X-Google-Smtp-Source: ABdhPJxUmMRGEmWAJTaewSIaFmnzZ+BuduG+GMQhkDfVPtmOys+Bi5Cx+hu6P/A+suippZ3UyZEZ0ujetIHwlDJtuxM=
X-Received: by 2002:aa7:d38d:: with SMTP id x13mr20323803edq.23.1625546965417;
 Mon, 05 Jul 2021 21:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210705105656.1512997-1-sashal@kernel.org>
In-Reply-To: <20210705105656.1512997-1-sashal@kernel.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 6 Jul 2021 10:19:14 +0530
Message-ID: <CA+G9fYvETgFUefSkrsZ5DaBomzZm5dzrh8HHLJJWX6egTPvhwQ@mail.gmail.com>
Subject: Re: [PATCH 5.13 0/2] 5.13.1-rc1 review
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jul 2021 at 16:27, Sasha Levin <sashal@kernel.org> wrote:
>
>
> This is the start of the stable review cycle for the 5.13.1 release.
> There are 2 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed 07 Jul 2021 10:49:46 AM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git/patch/?id=3Dlinux-5.13.y&id2=3Dv5.13
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.13.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.13.1-rc1
* git: ['https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git',
'https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc']
* git branch: linux-5.13.y
* git commit: eedde12f53553760b1f31f52f1ddf4445528ca23
* git describe: v5.13-3-geedde12f5355
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.13.y/build/v5.13=
-3-geedde12f5355

## No regressions (compared to v5.13-2-g58f1766113f0)


## No fixes (compared to v5.13-2-g58f1766113f0)


## Test result summary
 total: 84198, pass: 69181, fail: 2092, skip: 11875, xfail: 1050,

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 193 total, 193 passed, 0 failed
* arm64: 27 total, 27 passed, 0 failed
* dragonboard-410c: 1 total, 1 passed, 0 failed
* hi6220-hikey: 1 total, 1 passed, 0 failed
* i386: 26 total, 26 passed, 0 failed
* juno-r2: 1 total, 1 passed, 0 failed
* mips: 45 total, 45 passed, 0 failed
* parisc: 9 total, 9 passed, 0 failed
* powerpc: 27 total, 27 passed, 0 failed
* riscv: 21 total, 21 passed, 0 failed
* s390: 18 total, 18 passed, 0 failed
* sh: 18 total, 18 passed, 0 failed
* sparc: 9 total, 9 passed, 0 failed
* x15: 1 total, 0 passed, 1 failed
* x86: 1 total, 1 passed, 0 failed
* x86_64: 27 total, 27 passed, 0 failed

## Test suites summary
* fwts
* igt-gpu-tools
* install-android-platform-tools-r2600
* kselftest-
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
* kselftest-vsyscall-mode-native-
* kselftest-vsyscall-mode-none-
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
