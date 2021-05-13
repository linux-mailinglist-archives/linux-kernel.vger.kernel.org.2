Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB4037F7B9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 14:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbhEMMWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 08:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbhEMMVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 08:21:55 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00862C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 05:20:45 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u21so39529322ejo.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 05:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=399CU6FoVrAwohQZCEAKYJ/S5aFaMtgvcWQSU++tNeg=;
        b=BeFoPu4TSujc1wZTDS/TrysxrXtliF2kQZjftGgllngHqqky65t+naFcSYty2PMht2
         564XeU/iGtzoa+LJFUMHHee9/vEA/tZ1bUpN5lMi8d0coLwhVg4FSLbj/3UJrTkTYJyP
         y1XLYEI02HyixJ743dPhteP51D6oKh4cepQ40SrGp1gr0vq9Xi7mucciKNy3mzYu/LLx
         +lj9HdeXKLqDwLh4o/Es7cTxH/LwPJmsYBFJoiLi9pCr3v/kNGckq4i82I/daUqlhS3f
         0TX3Q3gLtiAbkTuKSmznNCkCoNOzG5ayKqAIYI8ro6ryryZtgQh817khs70vuLWpXGjo
         f5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=399CU6FoVrAwohQZCEAKYJ/S5aFaMtgvcWQSU++tNeg=;
        b=nAIP/njt5qUpIhdk2ErJcx6gBZaH4DGdJtG1x+VXoZ0mu6W3YbsfHX3qSmyH9eOQ90
         GhSeEJAnq9YYt4zVaYPZk/CBbx1pb+QqcbVR3DvrStCFoA32y14Je/9HQcqsb2/uyxZe
         sj6J/3HoN8EqUpwc0UnKWFbmcnbA2/P5JZZjBbUVn1BGZBMSjQQhwd6lfNP+LpLsf0NH
         2EFEPbpjYwHxfXm2cFcxgyFk7DxWwUf+y94oOyDK2coWa2yL+QzjJUQ8FQPfYo/Jt4BA
         jCwnamduOn6+qadExMOMP2SXaD1zeKmClvEeZboCSxmLuV1ksDxJaeSNn45mshlP9912
         7lzw==
X-Gm-Message-State: AOAM530jprungfRt+940FmOXWvwTk/7je+48kuJmefv3ZDsWfq/wU+BE
        mnQ4bMp87331Z5RaXXm/1r29wHDCnQoKTZLT1zMoPyxn2D1zkzGW
X-Google-Smtp-Source: ABdhPJx5Ui+iWa4w2gQ9QwGBWGtlInf1eMY6SBXbqURGnqY2dDfJnCjw4OTJmxlCchg1Po9TVAI5cDGZrui7OHP5twc=
X-Received: by 2002:a17:906:fcdc:: with SMTP id qx28mr11531261ejb.375.1620908443510;
 Thu, 13 May 2021 05:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210512144819.664462530@linuxfoundation.org>
In-Reply-To: <20210512144819.664462530@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 13 May 2021 17:50:32 +0530
Message-ID: <CA+G9fYvR7epBnYDWODEvc-OoVab0aqLx3PNAaCXxR2wM2oQOuQ@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/530] 5.10.37-rc1 review
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

On Wed, 12 May 2021 at 20:34, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.37 release.
> There are 530 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 14 May 2021 14:47:09 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.37-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.

Apart from mips clang build failures no other new test failures noticed.

## Build
* kernel: 5.10.37-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.10.y
* git commit: 77806d1ee43e1bea3aa5095445eb7a69f02ec8d3
* git describe: v5.10.35-831-g77806d1ee43e
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.35-831-g77806d1ee43e

## Regressions (compared to v5.10.35-300-g4edc8f7e8676)

* mips, build
  - clang-10-allnoconfig
  - clang-10-defconfig
  - clang-10-tinyconfig
  - clang-11-allnoconfig
  - clang-11-defconfig
  - clang-11-tinyconfig
  - clang-12-allnoconfig
  - clang-12-defconfig
  - clang-12-tinyconfig


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## No fixes (compared to v5.10.35-300-g4edc8f7e8676)


## Test result summary
 total: 71368, pass: 60228, fail: 866, skip: 10020, xfail: 254,

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 193 total, 193 passed, 0 failed
* arm64: 27 total, 27 passed, 0 failed
* i386: 25 total, 25 passed, 0 failed
* mips: 45 total, 36 passed, 9 failed
* parisc: 9 total, 9 passed, 0 failed
* powerpc: 27 total, 27 passed, 0 failed
* riscv: 21 total, 21 passed, 0 failed
* s390: 18 total, 18 passed, 0 failed
* sh: 18 total, 18 passed, 0 failed
* sparc: 9 total, 9 passed, 0 failed
* x86_64: 27 total, 27 passed, 0 failed

## Test suites summary
* fwts
* igt-gpu-tools
* kselftest-android
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
* kselftest-ipc
* kselftest-ir
* kselftest-kcmp
* kselftest-kvm
* kselftest-lib
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
* kselftest-zram
* kunit
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
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org
