Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1723E36CC
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 20:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbhHGSkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 14:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhHGSkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 14:40:32 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5E6C0613D3
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 11:40:14 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id oz16so5105242ejc.7
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 11:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pI322vBowVTjsGLkWWsueDMRXdWRgvDh8cNdQlljOLA=;
        b=R5g+CZoRWQkKEqZA45xQiqnYvd/vqqRllllqdAl6s3r2oOmIdYvbnvJBW32wsEcXY9
         aibjFEigFVQdFQC5VLDYvaD59Q5ncS3/bHr45YP5KlTASI/ySd6oeZSO0g2oTOgBHtjx
         Hg5N7kvIb55pK/FDDbBcMcPtyF5bNAjNY9GIZ9ut3ISJN9SrZMVYbdxY/kBqG9m/m1eg
         trs+tn/r5pBfN9mcP8ABGJCc8RIArTkWm/RIWAe6feIQOo1sQO8Zzc9bNozh9HpwkqCa
         yS+VOMA1TCAOreCQuVNWnzT3bwB75jE6qne0brIwFogEMuD9wCXQLXg2669EJIQXsjXS
         TIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pI322vBowVTjsGLkWWsueDMRXdWRgvDh8cNdQlljOLA=;
        b=mnE9neMfnLZ4w9fCq2BLwceeygtugegQsfZX3TsK0SkgY1RitYeU8/b1svQa5kVjtz
         AsHZP4igWYweYQhloCbVb+fsmoFwAn5/VPYn2EcZaiUy2EPlEe5LH8LXdsSuPXqzBVo+
         vHpV9JFRxY2zZ5HQyeH+gMoke4hk7wqATF+n8Xma0s0yALT3ooK4tD2TzUon/2WkqHY4
         0VYInp62abScl5uwDNtoj1jpmVydGb93mgZ/gV+aw6bh9aUkfItAlVoA9Z1Ewfca5/pk
         UXTSsMytc3isJVSiGdBci5rAWgs7XWT4veJhVcmiXya/4dNbg3R2CiW7yRugoFWPBoyd
         mOsA==
X-Gm-Message-State: AOAM533qnNWLKl6bkjA9aLhT92b+GDJyQ09Rbvh6mzZjvYFTi7Bvq6oF
        Wpj2q43QVEk+0LXUxi7vWX28i4rFOtXV3Xx9hKnUaQ==
X-Google-Smtp-Source: ABdhPJzOLFZq8Ew3zgKf2hhVQW1P7f2bfvONyPO4qnH9CGdFHxQtB7vy0S0ByNlVrEjhHmiRP9tcsr/3YTieifphg/8=
X-Received: by 2002:a17:907:94c6:: with SMTP id dn6mr15840528ejc.287.1628361612890;
 Sat, 07 Aug 2021 11:40:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210806081112.104686873@linuxfoundation.org>
In-Reply-To: <20210806081112.104686873@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sun, 8 Aug 2021 00:10:01 +0530
Message-ID: <CA+G9fYs_qAF+i8hYCDURUgn6qpG4-3489D--ENv-_YZU00HGHA@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/23] 5.4.139-rc1 review
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

On Fri, 6 Aug 2021 at 13:48, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.139 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 08 Aug 2021 08:11:03 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.139-rc1.gz
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
* kernel: 5.4.139-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-5.4.y
* git commit: e6d9a103071fd29a034b969983747f48d429ce9b
* git describe: v5.4.138-24-ge6d9a103071f
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.1=
38-24-ge6d9a103071f

## No regressions (compared to v5.4.138)

## No fixes (compared to v5.4.138)


## Test result summary
total: 74755, pass: 60671, fail: 881, skip: 11660, xfail: 1543

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 192 total, 192 passed, 0 failed
* arm64: 26 total, 26 passed, 0 failed
* dragonboard-410c: 1 total, 1 passed, 0 failed
* hi6220-hikey: 1 total, 1 passed, 0 failed
* i386: 15 total, 15 passed, 0 failed
* juno-r2: 1 total, 1 passed, 0 failed
* mips: 45 total, 45 passed, 0 failed
* parisc: 9 total, 9 passed, 0 failed
* powerpc: 27 total, 27 passed, 0 failed
* riscv: 21 total, 21 passed, 0 failed
* s390: 9 total, 9 passed, 0 failed
* sh: 18 total, 18 passed, 0 failed
* sparc: 9 total, 9 passed, 0 failed
* x15: 1 total, 1 passed, 0 failed
* x86: 1 total, 1 passed, 0 failed
* x86_64: 26 total, 26 passed, 0 failed

## Test suites summary
* fwts
* igt-gpu-tools
* install-android-platform-tools-r2600
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
* kselftest-x86
* kselftest-zram
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
