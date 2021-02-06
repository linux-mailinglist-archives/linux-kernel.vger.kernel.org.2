Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D59311E32
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 16:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhBFO6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 09:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhBFO6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 09:58:04 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E00C061788
        for <linux-kernel@vger.kernel.org>; Sat,  6 Feb 2021 06:57:25 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id s5so12894985edw.8
        for <linux-kernel@vger.kernel.org>; Sat, 06 Feb 2021 06:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g1kFlyenk5Gcxq5ngDZUDJaQYsludGa65ONKqqby+rs=;
        b=BRl5GfDzY/j7Kv33ec5GvKL2QZGx4oaP3MBRii1qPDpifjsbneoBdm6/cO3mNUdaM0
         DBBjO2eQYKcrJ8Tm0zxCel/BYHxw6YP+trV8bu4bqGbbPU29TFLB0dlLj4AL5l0E9WR2
         rk/2RNohofKFrE6244JNBBHMLpsGw2VKnhBDlNn5K/5eMFT1U6rAid3k1UNT5I2dpfLA
         mFj86OvcgpkcDY6XugBdYmvtrbJKIcjv0CSeHYx4r0Ta0hlgpMiRnQEPwN3qYlnYDbgv
         WOY6Rcp6c3yy4mttE/OouzEnG4qb75mIBplIHgwwh2wPmU6PednYvi+xC1WEgKk9qgUY
         w+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g1kFlyenk5Gcxq5ngDZUDJaQYsludGa65ONKqqby+rs=;
        b=Sy9FkcbgyO/dfsuKFFhrG75nD4i4yT2UCMZzm0dNj7eG3a2iDQUzQrOPDJQmTxfjes
         iSvK1Sb7ZUe3PjtlS+cTch1G8Uai07CoGglnoN/D3fN0dPuRMNG1kQPkCFcIEmoYtf64
         Opzq2+Eg0KoKoyVhHrtW2YZEH6uRi7y6XvjgMDAusAHqXqNucHeAzsreOsdNF3yV7HT/
         FEqR9en2gxkoUpuzYZNYva43Yw1nm/lNGHMkU/InG5eSzK0/VJebFnikU1O+9GnmYv/g
         gEX0s9U0qaO6IkIsRgjS0M1fuHuJYy43D9H00KETh/wuxKlFMe7aGlqsTQbWKsybye/1
         xZBQ==
X-Gm-Message-State: AOAM53020faIwDJdHoO7IFXNhgwKKbk3b6W0t6rEYkJotYslFo7YpQrK
        S05Sd+lSH1wHabvSoaVIklnCu6EpUKBzDYe01HmWiQ==
X-Google-Smtp-Source: ABdhPJyacHwpcc/u+ZXjftMTyQBRE2hF0Hvj62Y0ibzhL5D/dqXuK/tUoIr+Ea4K0+5Yx3BovZ1pmihvw/3SPbOQ/jk=
X-Received: by 2002:a05:6402:5107:: with SMTP id m7mr8701182edd.52.1612623443609;
 Sat, 06 Feb 2021 06:57:23 -0800 (PST)
MIME-Version: 1.0
References: <20210205140649.733510103@linuxfoundation.org>
In-Reply-To: <20210205140649.733510103@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 6 Feb 2021 20:27:12 +0530
Message-ID: <CA+G9fYuDJtR6XSm_yLR9LUGYWPiG5foURYWzoL7eb4OH_msmVw@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/15] 4.14.220-rc1 review
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

On Fri, 5 Feb 2021 at 19:45, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.220 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 07 Feb 2021 14:06:42 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.220-rc1.gz
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

kernel: 4.14.220-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 9bdfeb6e50d88f3dda36f8816b4b8e74d1b4d88f
git describe: v4.14.219-16-g9bdfeb6e50d8
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14=
.y/build/v4.14.219-16-g9bdfeb6e50d8

No regressions (compared to build v4.14.218)

No fixes (compared to build v4.14.218)

Ran 43689 total tests in the following environments and test suites.

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
* kselftest-lib
* kselftest-livepatch
* kselftest-lkdtm
* kselftest-membarrier
* kselftest-net
* kselftest-netfilter
* kselftest-nsfs
* kselftest-ptrace
* kselftest-tc-testing
* kselftest-timens
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-zram
* ltp-cap_bounds-tests
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
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* perf
* fwts
* libhugetlbfs
* ltp-commands-tests
* ltp-math-tests
* ltp-tracing-tests
* network-basic-tests
* v4l2-compliance
* kselftest-kvm
* kselftest-vm
* kselftest-x86
* ltp-fs-tests
* ltp-open-posix-tests
* kselftest-rseq
* kselftest-rtc
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-splice
* kselftest-static_keys
* kselftest-sync
* kselftest-sysctl
* kvm-unit-tests
* rcutorture
* ssuite
* kselftest-kexec

--
Linaro LKFT
https://lkft.linaro.org
