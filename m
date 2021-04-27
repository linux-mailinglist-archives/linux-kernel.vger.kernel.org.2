Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0D036C034
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 09:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbhD0Hh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 03:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbhD0HhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 03:37:24 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D066BC061756
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 00:36:39 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id r20so38412168ejo.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 00:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lXsEOswDY9Cprrt7+KPG1IVk34xEGEwkulyAI2cnbJU=;
        b=d//H4Jpooy/haV6dF4neT7pCklUZgWKdCMggkQdc7d3BB5+WAbx+mvClyYo0mYWLdt
         15rL+zgsP4kKGynKSMoDSm+4XfAfus0KWRx1GtSTD/diMOZuwB+cMg0rq4P/dgonQTyj
         Lx9zWNRU0HoOtdIqAs6mnQze2fy3iTIzVK/XIQSk9TuU7HqA5TyRHTEjLagmX20aXpXB
         w0IbnLljMIDrwKwDehOw1dIxuoxESo7i2mx5uYSErTHCUifiRSKqhrYqMBlCXW1a+HRK
         Km4/uyr2zRmoDdJxc4k+sJQmGavqJHy8O2Gf255L/glXsxNk/HDNE5LsSHHKWKNVnNHm
         SrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lXsEOswDY9Cprrt7+KPG1IVk34xEGEwkulyAI2cnbJU=;
        b=HTEd7dPr3oC/egS19PzM/eb0K23y7Y94iKjwQlDj11+BIAkWmr2xhDY0NMCBci7wjp
         99632fqFpf/bnA5jwG+drtvlERv1OkchFcX+mNg4O4MgZYkTKLmQqYbOlHAzvpw4wKkx
         wh/LlSRl0To3+xHBoL2cqnEFQ1ZVQuV+hCClkK6vS2y14wYyKiWrieOGrIyWRaf40JJh
         zkuPylOty7R7Iny1e9EPcJDABtSNsLZ/dr/vuVpYUFIhVSH9eYEUstwvs+ujJp8k9yCz
         Ko8bU6Q9zP25SugvX68SWZ3FS3FnbLahRqpKdD30NhN21t34XUCSpPr2LYMRiCUFma/A
         G23Q==
X-Gm-Message-State: AOAM533yK+iq5mqXUwx2Q+9UT1E5d4daR3LyIVLAR3EsHX6vurt8O9yn
        1BnCBfxbiMIRp72Q6x07iIfo6/vhp+3TpAlgv7xocBmuyItIP0LR
X-Google-Smtp-Source: ABdhPJxlvzbX3NyS38DOVp16YdtWz/KF88EIQr1t3ZO7oGWWu3WTBrEJFw7rHBfIIrypAq0kKkW9lH3z2O6DnQzc6dw=
X-Received: by 2002:a17:906:c04:: with SMTP id s4mr1593653ejf.170.1619508998418;
 Tue, 27 Apr 2021 00:36:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210426072817.245304364@linuxfoundation.org>
In-Reply-To: <20210426072817.245304364@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 27 Apr 2021 13:06:26 +0530
Message-ID: <CA+G9fYsu9RekqXWAY16ZnYoQ62Op5e3vjC22zNfdJKO9O+3E-g@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/37] 4.9.268-rc1 review
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

On Mon, 26 Apr 2021 at 13:03, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.268 release.
> There are 37 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 28 Apr 2021 07:28:08 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.268-rc1.gz
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
* kernel: 4.9.268-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-4.9.y
* git commit: 0f9e08cfadcbaa4b26690c14336e41e014e4a1da
* git describe: v4.9.267-38-g0f9e08cfadcb
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.9.y/build/v4.9.2=
67-38-g0f9e08cfadcb

## No regressions (compared to v4.9.267-25-g5a84577f34c1)

## No fixes (compared to v4.9.267-25-g5a84577f34c1)

## Test result summary
 total: 60436, pass: 48766, fail: 1600, skip: 9758, xfail: 312,

## Build Summary
* arm: 97 total, 96 passed, 1 failed
* arm64: 24 total, 23 passed, 1 failed
* dragonboard-410c: 1 total, 1 passed, 0 failed
* hi6220-hikey: 1 total, 1 passed, 0 failed
* i386: 14 total, 13 passed, 1 failed
* juno-r2: 1 total, 1 passed, 0 failed
* mips: 36 total, 36 passed, 0 failed
* sparc: 9 total, 9 passed, 0 failed
* x15: 1 total, 1 passed, 0 failed
* x86: 1 total, 1 passed, 0 failed
* x86_64: 14 total, 13 passed, 1 failed

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
* packetdrill
* perf
* ssuite
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org
