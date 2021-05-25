Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3F8390094
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 14:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbhEYMJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 08:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbhEYMIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 08:08:19 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5E4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 05:06:47 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id b9so11723350ejc.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 05:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z/HRJ7jt3I9xiHLTnaJ728pjDecVq61Fe3GesJ/a/Ik=;
        b=paUTTbxqqbx4WtSK/evYiZQ4F+VGcBkSPkm8wuqbf1gdiBpyWywTssrVLLzvJiietU
         nPWQS1bvJ9r44071kgWmY8yExcWWWTCLVEQ7xoWuxA9Um5S8WkdNAKk+3+u/a2j0rvid
         D+askmUpe2QBVxW+umjoTHR8Hmch+4I2SaSw8F/GPUmjQjQ87wcdlD4+FS3wx25xyynI
         xkRyF5VDlLayMkbFDuN/EweRMcDFI4qhas5UeBF7j/irw85rFZVzLtg0HQrARX0xOmA6
         2sJfPKZ5co5oFIaDA2kVlAvn3yTt3CbRBgCbytLQSz3YIWJbPXxvI1pqTbimc3NaRjJP
         3Y7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z/HRJ7jt3I9xiHLTnaJ728pjDecVq61Fe3GesJ/a/Ik=;
        b=oV9ShSY01scQjZMXX7HjKj4sDtgozC0/AIJPOj5i0MCya4v1OxZgNZjaQsZvsHqkMq
         bfrXzvye/iVg6Mt3Us9HRM3rcLCp5GmEs1Ye2pRuivn5/xFvREIW9ZDFxn7PtJsiNoG1
         pPRejSpt9gvlCfSxv5zJjt+v6Y/G/cPTyjea4kjA3kV+baunrNnORdptSw+93hIU5KRz
         8biArVZ62FeM1DzI+RJIr2Ool81m3u0uljH3/P5gGTpzJk8SqhQxezeS4PvHiljAwnLY
         jZsBUgnJ8ZGQeegbdLqlKyJFKQTVyuyyPeVEkIjTDrPRdqmKbJGyEnKLBmI63lTf3bGr
         HdoA==
X-Gm-Message-State: AOAM5306w/mYZ/EXU1fKuxvF/N9aUsGvy8sQFNq5PqfbLOwsuOF1smHo
        O61EMimwH0sc9TMAcdzwtgNjTIp0wcYNv/QRBjtOfQ==
X-Google-Smtp-Source: ABdhPJxZFTcldhsoOv++7TFkwI7zjXf+hsB8glOEmAbdynSi6//CXZvrGlOb2bXh+chUsB8vJu1ZQYVlHhgrKkmMzeo=
X-Received: by 2002:a17:906:c211:: with SMTP id d17mr28508067ejz.247.1621944405961;
 Tue, 25 May 2021 05:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210524152324.199089755@linuxfoundation.org>
In-Reply-To: <20210524152324.199089755@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 25 May 2021 17:36:34 +0530
Message-ID: <CA+G9fYtKx1=v39cbjicd3+-_652CY09kniqxpf8T3d3xL_d4sA@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/37] 4.14.234-rc1 review
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

On Mon, 24 May 2021 at 21:05, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.234 release.
> There are 37 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 26 May 2021 15:23:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.234-rc1.gz
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
* kernel: 4.14.234-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-4.14.y
* git commit: 535f9ea88cc881bdcb3db703d1a9f589effffdcf
* git describe: v4.14.233-38-g535f9ea88cc8
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14.y/build/v4.14=
.233-38-g535f9ea88cc8

## No regressions (compared to v4.14.232-324-g7c5a6946da44)

## No fixes (compared to v4.14.232-324-g7c5a6946da44)

## Test result summary
 total: 61870, pass: 49760, fail: 1509, skip: 9727, xfail: 874,

## Build Summary
* arm: 97 total, 97 passed, 0 failed
* arm64: 24 total, 24 passed, 0 failed
* dragonboard-410c: 1 total, 1 passed, 0 failed
* hi6220-hikey: 1 total, 1 passed, 0 failed
* i386: 14 total, 14 passed, 0 failed
* juno-r2: 1 total, 1 passed, 0 failed
* mips: 36 total, 36 passed, 0 failed
* sparc: 9 total, 9 passed, 0 failed
* x15: 1 total, 1 passed, 0 failed
* x86: 1 total, 1 passed, 0 failed
* x86_64: 14 total, 14 passed, 0 failed

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
