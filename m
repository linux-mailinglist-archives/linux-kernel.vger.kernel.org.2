Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C157C3A13C0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 14:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239718AbhFIMJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 08:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232563AbhFIMJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 08:09:46 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFAAC06175F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 05:07:51 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id f5so23368864eds.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 05:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YyCHyjohVg8f5AvB8SjG/oYMqmkPHsYDsxIiqqZRuLY=;
        b=p8+do0nGorr2Aj3kckGZh7NNbObeZ1FvaoPQ5M9acdigl3jGuadwnfEL0unXqd+Nmt
         JnZBGj/JITn5pF0fYwmKB9AU3rDkksvlgps+kOAGMq9L8f+V/L+vUdQ4hicYTrhf6HL2
         91eevuHu6/LI+koOnyIMdifE0R/LR6q24TzP9TlN2fGNNovAoQl9Mcw4KXpYxy658HOs
         OxA3tz4fUfHVirmDqzEPnrFS6CFucnWkeryvHYkWpNAgbOCLy7vT/HtOyYbXTakVZmLv
         pzogGS4BLLQwU4f9BeY3F9CWJDw09lylQF7pCUZK90EPGr70xdVSIqHpkpGBLaNdCgew
         +9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YyCHyjohVg8f5AvB8SjG/oYMqmkPHsYDsxIiqqZRuLY=;
        b=Fc+BgXtoIAa9xE2BMuqSqSzB7xvKiNqT/CdeegvGyj/UVWmUPGj+C+AN/Dg+aKfV/N
         VtN/vJZA9E2k3SI+FxY6v2Y5gTo+Bf1WFgTCiAipvgNNSMUrLHJFEhLLJ9+/cA0ZaL/M
         aW5L1H6Q1aqzn0/3xVLl4/RgaE+RG5bjCBkrWwvPiFOwqnUrjboCqCuCpmvPabatlWl6
         T50mrEHbib7QF5mnu5UX6PyCXg5avoqO5uCp0rrE1IqBxSSQeGka7dsSks3t0NICqxDV
         gIEs//o6CRlrJXKv2W49xL2KP+UWk0X4EdTLphYIO3lksOHWTKmsBemUccz8zl0lAdB2
         7rcA==
X-Gm-Message-State: AOAM5301zfkBugMDhekIClXkocqsl2vgQke2fsY0ugvDF4DDlmiNf6YS
        sXsMduPHBP0s5Q2GvXZZhdGcMZlYW+d7L04zqak2vg==
X-Google-Smtp-Source: ABdhPJzSgsZpOyZqPE21klGMdPrjI1ErkEaKq0wlIExVhqIeGSuP87fxJUy5y07iYh5Z9d6yeAm1g3yvlDMAPNV6aOo=
X-Received: by 2002:aa7:dc12:: with SMTP id b18mr30082329edu.52.1623240467726;
 Wed, 09 Jun 2021 05:07:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210608175926.524658689@linuxfoundation.org>
In-Reply-To: <20210608175926.524658689@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 9 Jun 2021 17:37:36 +0530
Message-ID: <CA+G9fYvw-Ma6REZ1db2URqg8soWE-nCpNTwExgUtz-tYawks2Q@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/23] 4.4.272-rc1 review
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

On Tue, 8 Jun 2021 at 23:58, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.272 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 10 Jun 2021 17:59:18 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.272-rc1.gz
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
* kernel: 4.4.272-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-4.4.y
* git commit: 1aa9f2da300268ec8eddf371b698eb77dd21960f
* git describe: v4.4.271-24-g1aa9f2da3002
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.4.y/build/v4.4.2=
71-24-g1aa9f2da3002

## No regressions (compared to v4.4.271)

## No fixes (compared to v4.4.271)

## Test result summary
 total: 36399, pass: 29083, fail: 370, skip: 6218, xfail: 728,

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
