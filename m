Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4A86315537
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 18:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbhBIRhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 12:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbhBIRfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 12:35:55 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E272C0617AB
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 09:35:12 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id l25so15756055eja.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 09:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rkfxHG6SUHpA6tbpAjqOVi7wM6zkzfQEESqTN4U8tdc=;
        b=z3yKYDJsOsvcbQ4+mpQdcQtuQkh5oVsz0uARlIOZKEXhGob+/98z00TQGaBr0rIvSs
         Eye29pBN/n+i7yGZCpYwYxcgMVA+W1joredpcyuu/+rMcw0AbTHoW2ZM2QMDqVQc0QGp
         2zcXSppp5KjixOUlJETm3pJDIMmULzVtKIc7qccB3kJ4NCArSorbQSmDkLAKzimQdo4K
         G8yPbkysQhut4sHefawh9EdPi/pFVo5zd8upCbqLb3W0KICOxktT9JL4/5miSrbkqvcx
         sJlYivsmVQmMko9NEiXNhkvRnLJBfnm2KUCsA31aVA+GLIvESUwmZNlmEQXMI5PegFXV
         PJZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rkfxHG6SUHpA6tbpAjqOVi7wM6zkzfQEESqTN4U8tdc=;
        b=fon8qsWStZ1OWPTCS4LuDuwbqUbLGiNBJ7xXCwfrsV75mvOCFmj2nX7Khhxxs1PrfA
         t9pK7duQVcRdJZOxpTTbpSoCJx/smiflwn3WBQoaq19VAHvE+ffPW0PHvOEfOMR8MWZu
         CrlCwWqX0YZqEo+7ZA5XLFLR/+OKZ4LCT+HG0AmXAADltvh4gk2SHevNsDISSEZbjEl6
         +DoKEKKcDZUwj/ahacjndZcYK99Na9m9AddS8/S7sKRfKspQrweDRhYAwsQFjNsjyiW9
         glFmQ0yoUVOWwrb/jleMV9Uh4RqnpyiBP35rtSdCDrICcU1nPi7NLOs9RU72FJaSb3rW
         bf3g==
X-Gm-Message-State: AOAM531Piqd2Yoa/nnQRg6+ooQqP0a9KVqI6LJhNovA7zs4gFiE2lnLp
        FCouDXZ7i2d5SsRyUD3hBzSoG9RTeg8dnyAoOPbzfQ==
X-Google-Smtp-Source: ABdhPJxbdvKjtKtbJCC9grRrKSo6+kZvrHTJ445dnzu5sAHOxM5Ses6yOP/mCA4uwQsHBV0RjO0w5oiZR245W4pWl/Q=
X-Received: by 2002:a17:906:a153:: with SMTP id bu19mr24081209ejb.287.1612892110587;
 Tue, 09 Feb 2021 09:35:10 -0800 (PST)
MIME-Version: 1.0
References: <20210208145805.239714726@linuxfoundation.org>
In-Reply-To: <20210208145805.239714726@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 9 Feb 2021 23:04:59 +0530
Message-ID: <CA+G9fYukMW13mCTXE2VYaDokxe59PB09Dcwkkb2aT8p6PakbLA@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/30] 4.14.221-rc1 review
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

On Mon, 8 Feb 2021 at 20:38, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.221 release.
> There are 30 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 10 Feb 2021 14:57:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.221-rc1.gz
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

Summary
------------------------------------------------------------------------

kernel: 4.14.221-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: c7c1196add2085d4956a80729d2832ef83d963c8
git describe: v4.14.220-31-gc7c1196add20
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14=
.y/build/v4.14.220-31-gc7c1196add20

No regressions (compared to build v4.14.220)

No fixes (compared to build v4.14.220)


Ran 41474 total tests in the following environments and test suites.

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
* fwts
* install-android-platform-tools-r2600
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-controllers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-fs-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-tracing-tests
* network-basic-tests
* v4l2-compliance
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
* kselftest-net
* kselftest-netfilter
* kselftest-nsfs
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
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-open-posix-tests
* perf
* kvm-unit-tests
* rcutorture

--=20
Linaro LKFT
https://lkft.linaro.org
