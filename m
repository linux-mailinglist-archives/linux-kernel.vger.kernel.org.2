Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3077F375111
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 10:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbhEFIt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 04:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbhEFIt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 04:49:27 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E22C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 01:48:28 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id r9so7105997ejj.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 01:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VPgJK08siuD8fYt99eN4gvyIJpbmAGGAM2iVxKDpWcw=;
        b=TQQi9iQlC6toLLaZEtaXlWa4Q+zrCFK9IkrrzAwGBnOk21+QxHwNj5Q3mvMONu5KpV
         EfmvZuWkG8S+4yrzFlDaf38NgfnsglYJYBMlrHl5zPl/2JfPvfturJ+OgJboCvahJzZt
         FkNFWCl8C4fuL6dfS1s/CWFTSGkutdQ9FJhq9df2eyfR6Owqtm9f7Oystxvf8Rij9wao
         PXLrSxrKWCskIueJ1fHtFmZvmrBJfYWCL+s/fe4Rv19jE//wAdd5olladtks0JWPI4tS
         buZi2htypGIB1JajZJkC5jfg7kOf9JLERK1sYJjhLcPZkgjSJRaGoevlXFjx0XfABK55
         SspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VPgJK08siuD8fYt99eN4gvyIJpbmAGGAM2iVxKDpWcw=;
        b=luoqpm/4pDSrqFAaznFv3M5K9r01fGImDeyfwSkxn8xBYm3OWiceX92OKcoNM40bxa
         bmQF1S6jRq0zm2BI7Qv79V8UTEVPVsjInUBsnCs8YPSCzdJnQ8xsNW5SifjanC4+chLn
         bzVoUxOjtBHt3XOmHYSKf8rVodBzxLfBy8YuMgIbiMgwtBsvN7XZnNyqX9IfSBRIRi80
         3G0dW+Ljc4wnfPq6QX9XCbN2gkbWU1qwswtpH7j6iejktXkBVjkU3Y1/MJ19AWCC2ETK
         a1E8R/zM8PEJP5s4fa+Ph8c0JGwkGuUAIH5kWZ/3i+xkgF1vUY2TlD6go2MUcGitaD2M
         /QXQ==
X-Gm-Message-State: AOAM530NQiPjsf1vYgTA0sp7HA4gAUj3TGQEGh2B9BbMQE/DRU6XeuqL
        3Su7p6TyzJB9OBAfiJ+Z4udyY6JgnA8khCVhDSa6rQ==
X-Google-Smtp-Source: ABdhPJweGh1HHwC1XRBL8ezF8ayG7aVNfq7ekrwDyn6m7O9ryH5jdWSgWBEQtbNzraHK3RhBYy8DW7eoBY8FXMWq1kg=
X-Received: by 2002:a17:907:6ee:: with SMTP id yh14mr3150159ejb.375.1620290906973;
 Thu, 06 May 2021 01:48:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210505112324.729798712@linuxfoundation.org>
In-Reply-To: <20210505112324.729798712@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 6 May 2021 14:18:15 +0530
Message-ID: <CA+G9fYvnfHZUaGnNvR4S12e+Lzy-7Xp-_wyto0uY9oFLa2cN_g@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/21] 5.4.117-rc1 review
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

On Wed, 5 May 2021 at 17:34, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.117 release.
> There are 21 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 07 May 2021 11:23:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.117-rc1.gz
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
* kernel: 5.4.117-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-5.4.y
* git commit: 73e74400c797af9bc645d41cfd350b15e3e52d2c
* git describe: v5.4.116-22-g73e74400c797
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.1=
16-22-g73e74400c797

## No regressions (compared to v5.4.116-11-gd885c7ab9671)


## No fixes (compared to v5.4.116-11-gd885c7ab9671)


## Test result summary
 total: 73691, pass: 59640, fail: 2187, skip: 11607, xfail: 257,

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
