Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9620236C062
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 09:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234927AbhD0HtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 03:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbhD0HtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 03:49:15 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94687C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 00:48:32 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id n21so11987901eji.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 00:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2WBMmfcE4GGrTTxX0b2VcgU2lIT0khyk78AKbuGu5xc=;
        b=ZQ0rJQWZ5cle+in5Iw9hVMZZk7higJkwhcqCGCFwyDh+RxvBpR3c+Ha4c2L9GdXYRH
         k52R7eDcrLrqkdRUFbwFhKv1Shpnjc7oTZ+YiC0s+9lrZQYPl5NXMeuA5AqYUQq1aoDV
         5k26s8T84ar80/9jZEgSYp9s8+ayEeTzertYKCeO3PGRfug25QIVIqdN06AD3nMCEDVJ
         +DwUf3s6Duau/tFbMMU8uV3A+QUNxTtvPxwtxZ3V2Vn/gnar7ol0wZUp6pd5zrA0XS0S
         /ph7FntsFikhbLwHyDPn/MXw4qt/+0QEwDwjlyq5l3lUFJwwG3N5D/jTBMitC5xL0Hu1
         2v3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2WBMmfcE4GGrTTxX0b2VcgU2lIT0khyk78AKbuGu5xc=;
        b=GZ6OlUUKlW34LoMrP55fA2aaoaO/2ye5B3jrmWvQLCGoBMYaVx9z/17sD3U+F1IRJO
         QBAOSxA8r1MFc8eIcllRKeoE1HdZOVpFbLH4xM3s2lDmSalCeMv9JcU5aFBFNZncGra+
         EFlPNcj5d8pxW3wD1JZpRWZaHzFqXMrXlvw443u4L4AincYoAXTWBVsFTRSqe7A5qADa
         yQIii1GjqsMPgSCVInjBDZWLujGFuSbeNNdpCr7HShzJrKpEhhTkcCIsO/w+ZNud7Mhw
         08d2VJjDg1TsbhjkuxiOm8q5X4hyR4irmGypMRqy+UDdfFbO9VyVW3szHtYtZ2KD1Ad2
         Vgzg==
X-Gm-Message-State: AOAM531b67Q8ICC13HjKzIXhJBUV/2AKqUKB1e3uBGvuW9vFOelFnz4f
        ExbIU4mRHKFSbaCZoxTMTFQx9O6yK9CE0ifVMUDghg==
X-Google-Smtp-Source: ABdhPJx89lxxnib7lGmFStTv3VynzOthPCz+VloSTlsBmkpY6ghhVLqDBni4BQM/yHmT0FVGUN9EJb5WwkU/uNcIrlE=
X-Received: by 2002:a17:906:3749:: with SMTP id e9mr22310950ejc.247.1619509711200;
 Tue, 27 Apr 2021 00:48:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210426072816.574319312@linuxfoundation.org>
In-Reply-To: <20210426072816.574319312@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 27 Apr 2021 13:18:20 +0530
Message-ID: <CA+G9fYtvMUOHPXjX0Kp7yGPJ2T+ZnvzKG61-iALasn+uguCrVQ@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/32] 4.4.268-rc1 review
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

On Mon, 26 Apr 2021 at 13:01, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.268 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 28 Apr 2021 07:28:08 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.268-rc1.gz
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
* kernel: 4.4.268-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-4.4.y
* git commit: 78d632f91b0e9c213e8a76367900e6f37e2c81e7
* git describe: v4.4.267-33-g78d632f91b0e
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.4.y/build/v4.4.2=
67-33-g78d632f91b0e

## No regressions (compared to v4.4.267-24-g6efef630b70b)

## No fixes (compared to v4.4.267-24-g6efef630b70b)

## Test result summary
 total: 45230, pass: 36002, fail: 1238, skip: 7746, xfail: 244,

## Build Summary
* arm: 96 total, 96 passed, 0 failed
* arm64: 23 total, 23 passed, 0 failed
* i386: 13 total, 13 passed, 0 failed
* juno-r2: 1 total, 1 passed, 0 failed
* mips: 36 total, 36 passed, 0 failed
* sparc: 9 total, 9 passed, 0 failed
* x15: 1 total, 1 passed, 0 failed
* x86: 1 total, 1 passed, 0 failed
* x86_64: 14 total, 13 passed, 1 failed

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
