Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2517035AC84
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 11:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbhDJJn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 05:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhDJJnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 05:43:24 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E235C061763
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 02:43:10 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id w3so12367510ejc.4
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 02:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oT7wiINNDYxVGyh44UMSvOYd+UDI8vGaMi5lFMvnZWQ=;
        b=FdOCNoJJEQWupHt0LdW3FVm2gK3bmx1+iCfH5+kK0GxeCjld8Q940Vb7QVezA8CoxA
         133jZq7crxDlHCD2xyC+XoeSVbeiTEK1PYIOoGyVqEly5u52LrsEl/ZjWm7ruulxYKdM
         fBW5DAIlmJqE0fJTE2pIB7uCc7VXrBs6rxJabHpi/M7+4XmFLqqSo7jcmrPHV5MkvJNy
         gvuEgFF3foLOCQf9TyfJhSFaWc64G9nDuOHCNHhYqNFO63pHcf+ZARo2Y3wpjA5us8tB
         UvuLk51dh4VGX7kyrQKWPmYvc7m1sJhLqDbjllrksvBJZDRWMTw1JgRMMEFJjKHccNUp
         nZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oT7wiINNDYxVGyh44UMSvOYd+UDI8vGaMi5lFMvnZWQ=;
        b=NqqLwxb7AZtIDVuJPQIOmX/LlwOCTswfffn8Ifb3YmGpzh8LaX2Wd6AKU8YAeFFR45
         0xKw69YpmrdDSrpYgIS0o5Vfo6TYeI4FSR+JXdN0eAJpFOSYVrjdT6DNAoiYNavAoMdB
         nOex1ftW3kY/iRhueiOs3FrD01H3Vn71zU77ssZmhw5iKU4+/avfE8IfoR5Fa/7tTIHi
         yuOS728gU1pFiZQBxx2ckYDHy2Qumn1ts0W0voKHUILOexi0D5PUmEa+EP3QrepgZokL
         WIh6aW6boCvpXMYo1fiZa2C8Cw96arfUMz3x8G60St9UBLr972RpK8CSn17BuriJOQa5
         Bbmw==
X-Gm-Message-State: AOAM531rDY219wzOFJ6wxi8Dzzttx4b+/O8T6qlRSvoa1eGx63pWtPck
        goDcs/RpR8v6I7sH1QMCMZuycAc+kMLZXpSBUOj6EQ==
X-Google-Smtp-Source: ABdhPJyQD3KWPVIGnfbbc1eW/uQFmBzzCchk3YUCUAQk1WuGi7O8bE90uprfRRWYBmvr6LpS3OCG8ZThU6GiwgiKWpU=
X-Received: by 2002:a17:906:9605:: with SMTP id s5mr19996604ejx.287.1618047788992;
 Sat, 10 Apr 2021 02:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210409095259.957388690@linuxfoundation.org>
In-Reply-To: <20210409095259.957388690@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 10 Apr 2021 15:12:57 +0530
Message-ID: <CA+G9fYt+ZNDp9NsQM7y+r62sya0=J79A4=OYg2jJME6vLRkZvQ@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/20] 4.4.266-rc1 review
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

On Fri, 9 Apr 2021 at 15:25, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.266 release.
> There are 20 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 11 Apr 2021 09:52:52 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.266-rc1.gz
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
* kernel: 4.4.266-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-4.4.y
* git commit: 52dca0094c23c3f6c73da63a8861764f778940d5
* git describe: v4.4.265-21-g52dca0094c23
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.4.y/build/v4.4.2=
65-21-g52dca0094c23

## No regressions (compared to v4.4.265)

## No fixes (compared to v4.4.265)

## Test result summary
 total: 45835, pass: 37184, fail: 486, skip: 7946, xfail: 219,

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
* perf
* ssuite
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org
