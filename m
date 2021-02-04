Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D29730D6C2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 10:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbhBCJyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 04:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbhBCJyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 04:54:20 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF82EC06174A
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 01:53:38 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id y9so13040003ejp.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 01:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8TVy5DZnY7lNtTamXNCXIrRsdDrSL7T9/2S4+5yx1jk=;
        b=Rq3bI0AZndd46vcT3JblrwyAh9ENHJ2aFHoKRftIispFKZ7iG5PG1dHRQe8wxez+N8
         pbCLSOGGjqEgMuCXkCIG8KXuEvjkyiwRbIQDHqOUp1ax19gVXVctKoCBLvGRj6q44N0I
         w3StmEaSxkQn6LOLPVIVxoPfPsT3uq4w3zSgf5rMmwMLUarTEHnI6Pn4Rr1k2AP2E3Kz
         S8MKSz+l6PkTqSBb2wpX7vpUwYU2atEQ0g9Lb45Z1n/x6oCx0HS3jmGBS7ZrQqye0tBg
         c8wKsA3ir6D7FSeWdvbNBecLlNxTE0NmxjHaBcxyvl1oRR7V3xrwws0REL/wX3uYnMZt
         OZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8TVy5DZnY7lNtTamXNCXIrRsdDrSL7T9/2S4+5yx1jk=;
        b=RDxjVxjGMtFiubOfQgQUzgwzaIN4YSoqaHUmFY7ewAxP3K2E8T4vH4oTmd9QmX0SS/
         h08p+kL5H+vUH952f9TgseCXmKhCg6MZ4L2crDCqQrxRVshHNooIpZiKdWyHZsGBTMNS
         p+W70VIFyAc5/xAjCnLXF1i7Xo0P8rUxmOLtguaGDScJl8g8k7gJyGbC6aqsNFUGHIP6
         lT5HQ/t8V0jEapmcX9cwQgDlUvsc8srsJh62CW9VMxNetds7Qg3Pue9+6t+OgnOwpXT9
         eRbRseKrmn22ncly1cIgXrZzTkOnCdRT0ThWZIjv7R4eH98H8phxs/QcVSxusRSWvzSA
         4N/g==
X-Gm-Message-State: AOAM531zZ/Czu41M1uE6a91Ql1j0XNqIq9QR/bigyO9kaKFrBwjdASDx
        vLHMHXkB9WyNVlG2tWXu6OBmjVcgzNscCBzuoEwKEg==
X-Google-Smtp-Source: ABdhPJwPEqJgFA7v3jn2TVlLbbVFc1Iznr2lyfbTIOCaMfCvYmq7RvofUVP5L40ki6JP+flu+BB87bg3bAu5PLl6cxE=
X-Received: by 2002:a17:906:ca0d:: with SMTP id jt13mr2324082ejb.170.1612346017471;
 Wed, 03 Feb 2021 01:53:37 -0800 (PST)
MIME-Version: 1.0
References: <20210202132942.035179752@linuxfoundation.org>
In-Reply-To: <20210202132942.035179752@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 3 Feb 2021 15:23:25 +0530
Message-ID: <CA+G9fYuNxxD6Setgoku50y7jsDt5x+MFq0s4jO0XJzcZcQJgpQ@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/32] 4.9.255-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org, Jon Hunter <jonathanh@nvidia.com>,
        linux-stable <stable@vger.kernel.org>, pavel@denx.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Feb 2021 at 19:20, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.255 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 04 Feb 2021 13:29:33 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.255-rc1.gz
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

Summary
------------------------------------------------------------------------

kernel: 4.9.255-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 70e4b0214c4095d6102b69f30858cfb31d36e1c2
git describe: v4.9.254-33-g70e4b0214c40
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.9.=
y/build/v4.9.254-33-g70e4b0214c40

No regressions (compared to build v4.9.254)

No fixes (compared to build v4.9.254)

Ran 39352 total tests in the following environments and test suites.

Environments
--------------
- arm
- arm64
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-64k_page_size
- juno-r2 - arm64
- juno-r2-compat
- juno-r2-kasan
- mips
- qemu-arm64-kasan
- qemu-x86_64-kasan
- qemu_arm
- qemu_arm64
- qemu_arm64-compat
- qemu_i386
- qemu_x86_64
- qemu_x86_64-compat
- sparc
- x15 - arm
- x86_64
- x86-kasan
- x86_64

Test Suites
-----------
* build
* linux-log-parser
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
* kselftest-intel_pstate
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
* kselftest-sysctl
* kselftest-timens
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-zram
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
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-tracing-tests
* perf
* v4l2-compliance
* fwts
* kselftest-efivarfs
* kselftest-filesystems
* kselftest-firmware
* kselftest-fpu
* kselftest-futex
* kselftest-gpio
* kselftest-ipc
* kselftest-ir
* kselftest-kcmp
* libhugetlbfs
* ltp-fs-tests
* ltp-hugetlb-tests
* ltp-mm-tests
* network-basic-tests
* kvm-unit-tests
* ltp-open-posix-tests
* kselftest-vm
* kselftest-kexec
* kselftest-x86

--=20
Linaro LKFT
https://lkft.linaro.org
