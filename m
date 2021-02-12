Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C674319FE1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 14:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbhBLN3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 08:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbhBLN3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 08:29:43 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618B6C0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 05:29:03 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id z22so10791983edb.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 05:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Neefq26+0wySW8CCnpLiBrHunY0atHBH7eM16bKt2m0=;
        b=bcewxCG4FV8BHFBpRn1shnV7GDwRUGR+xXERg6mUXkd8n62XwsN2ArPOvBxUNeYXuB
         2r3SjemR3eHwstWqtHfua3AbZsVZvKaOUHfXuJOfjX2zfh0HVdx8Nu+7W7+LXb3Edcic
         AsnhQFP4d6HmuuQmp3X9rHHNtcpy7xKuKSJMJmPVMW3WPc1wtXVNju06lRMlmWZxIdXQ
         OPPocEKzMv0q+VTjQSru+7VI/w3PHjZZ1s0GEcvT0Emh6yhcwQ7HaUrERjaGCNFuaSeQ
         0USgCvt56eN92SS3RdeiAEWuA20QEkOH0IwMSBJb7dF/HpDrajBrDUpYA2jbz1GeN/Em
         mmcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Neefq26+0wySW8CCnpLiBrHunY0atHBH7eM16bKt2m0=;
        b=ZeZ+6e3qjHRSZ5glw58bJKxjDJQnt1lLW25tQ7GenIgbuRyj/hqi+MJ2AX68fmQ4ft
         /EUozetAQkRhHd4itUUhJTJ1CDNfuyUGOIPkGXXmxkuVJII6Ypz5LLis/P8c10mRA/4D
         XtLw2j4bPtoFUJlmbZYpswPlGoRUwK3GGTtKA8nddxNd9F1LPAlxt8aQnHWwPb/BvqjL
         P81bbwGH2r2Ll3DukDC5qCG0aUEbmtB/GJKuy5AXgKfYHsbU3ykSHbiNF7wrq+Pg9dfi
         Ya1ygr/Smd/0VXlFkj0TmqtSpEC7ocFs2kRjcGZFlxvBcU9aWkgrxl1KJVytphOkDD5P
         Cmdw==
X-Gm-Message-State: AOAM530CTTWrIQ7F3oc8ak8hdSGO+KQ+7p+ClVVdMlZAjMyKvCMGV2Bs
        meh8sv5ufRCVIvtW0pp5Nv9Mr4bFZPpEnVL4NpHQgw==
X-Google-Smtp-Source: ABdhPJyuoZ2N89f1TFVEVZX0+m2/XBkrFKVLO0lTG9qKGTaZn1cG4Ny2hI2eK7IiHUvaopGL8HqK4A4rmZAiWFKd5+Q=
X-Received: by 2002:aa7:d3c7:: with SMTP id o7mr3355484edr.23.1613136541914;
 Fri, 12 Feb 2021 05:29:01 -0800 (PST)
MIME-Version: 1.0
References: <20210212074240.963766197@linuxfoundation.org>
In-Reply-To: <20210212074240.963766197@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 12 Feb 2021 18:58:50 +0530
Message-ID: <CA+G9fYvtosFoB8ufDgu-3jhLOYGhEH5Vxo1n6P3bbgmDhBFzqA@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/27] 4.19.176-rc2 review
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

On Fri, 12 Feb 2021 at 13:25, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.176 release.
> There are 27 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 14 Feb 2021 07:42:29 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.176-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
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

kernel: 4.19.176-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 7a5acd93ed02982be8ee91127bad4f85473b3c1a
git describe: v4.19.175-28-g7a5acd93ed02
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19=
.y/build/v4.19.175-28-g7a5acd93ed02

No regressions (compared to build v4.19.175)

No fixes (compared to build v4.19.175)


Ran 48636 total tests in the following environments and test suites.

Environments
--------------
- arm
- arm64
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- juno-r2-compat
- juno-r2-kasan
- mips
- nxp-ls2088
- nxp-ls2088-64k_page_size
- qemu-arm64-clang
- qemu-arm64-kasan
- qemu-x86_64-clang
- qemu-x86_64-kasan
- qemu_arm
- qemu_arm64
- qemu_arm64-compat
- qemu_i386
- qemu_x86_64
- qemu_x86_64-compat
- s390
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
* kselftest-livepatch
* kselftest-lkdtm
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
* kselftest-zram
* ltp-containers-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* perf
* v4l2-compliance
* fwts
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-controllers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-fs-tests
* ltp-hugetlb-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-syscalls-tests
* ltp-tracing-tests
* network-basic-tests
* kselftest-
* kselftest-kexec
* kselftest-kvm
* kselftest-lib
* kselftest-membarrier
* kselftest-memfd
* kselftest-memory-hotplug
* kselftest-mincore
* kselftest-mount
* kselftest-mqueue
* kselftest-openat2
* kselftest-pid_namespace
* kselftest-pidfd
* kselftest-proc
* kselftest-pstore
* kselftest-vm
* kselftest-x86
* ltp-open-posix-tests
* kvm-unit-tests
* rcutorture
* ssuite
* kselftest-vsyscall-mode-native-
* kselftest-vsyscall-mode-none-

--=20
Linaro LKFT
https://lkft.linaro.org
